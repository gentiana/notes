rails g model Subscription follower_id:integer author_id:integer
add_index :subscriptions, :follower_id
add_index :subscriptions, :author_id
# composite index that enforces uniqueness of pairs of (follower_id, author_id)
add_index :subscriptions, [:follower_id, :author_id], unique: true

# user
has_many :subscriptions, foreign_key: :follower_id, dependent: :destroy
has_many :subscribers,   foreign_key: :author_id,
                         class_name: Subscription,  dependent: :destroy
has_many :followed_users, through: :subscriptions, source: :author
has_many :followers,      through: :subscribers

def subscriptions
  Subscription.where(follower_id: id)
end
def subscribers
  Subscription.where(author_id: id)
end
def followed_users
  User.find(subscriptions.map &:author_id)
end
def followers
  User.find(subscribers.map &:follower_id)
end

# subscription
belongs_to :follower, class_name: User
belongs_to :author,   class_name: User
validates :follower_id, presence: true
validates :author_id,   presence: true

def follower
  User.find(follower_id)
end

def following?(other_user)
  subscriptions.find_by(author_id: other_user.id)#.destroy to unfollow!
def follow!(other_user)
  subscriptions.create!(author_id: other_user.id)

User.all.sample(rand(30))

resources :users do
  member do
    get :following, :followers

it { should have_link("1 followers", href: followers_user_path(user)) }  

@user ||= current_user
@user.followed_users.count

- unless current_user?(@user)
  - if current_user.following?(@user)
    = render 'unfollow'

resources :subscriptions, only: [:create, :destroy]

= form_for current_user.subscriptions.build(author_id: @user.id) do |f|
  %div= f.hidden_field :author_id

= form_for current_user.subscriptions.find_by(author_id: @user.id),
           html: { method: :delete } do |f|

before_action :signed_in_user,
              only: [:index, :edit, :update, :destroy, :following, :followers]
before_action :set_user, only: [:show, :following, :followers]
  @user = User.find(params[:id])
def following
  @title = "Following"
  @users = @user.followed_users.paginate(page: params[:page])
  render 'show_follow'    # explicit
def followers
  @users = @user.followers.paginate(page: params[:page])

- if @users.any?
  = render @users 
  = will_paginate
  
it { should have_xpath("//input[@value='Unfollow']") }

before { delete subscription_path(1) }
# This works because the user should be redirected before the application
# ever tries to retrieve the subscription with this id.

before_action :signed_in_user
# respond_to :html, :js
def create
  @user = User.find(params[:subscription][:author_id])
  current_user.follow! @user
  redirect_to @user    # respond_with @user
def destroy
  @user = Subscription.find(params[:id]).author
  current_user.unfollow! @user
  redirect_to @user    # respond_with @user

$('#follow_form').html("<%= escape_javascript(render 'users/unfollow') %>")
$('#followers').html('<%= @user.followers.count %>')

= form_for current_user.subscriptions.build(author_id: @user.id), remote: true do |f|

before { sign_in user, no_capybara: true }
expect do
  xhr :post, :create, subscription: { author_id: author.id }
end.to change(Subscription, :count).by(1)
expect(response).to be_success
xhr :delete, :destroy, id: subscription.id

its(:feed) do
  followed_user.microposts.each do |micropost|
    should include(micropost)
def feed
  Micropost.from_users_followed_by(self)
def self.from_users_followed_by(user)
  where("user_id IN (?) OR user_id = ?", user.followed_user_ids, user)

def self.from_users_followed_by(user)
  followed_user_ids = "SELECT author_id FROM subscriptions
                       WHERE follower_id = :user_id"
  where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
        followed_user_ids: followed_user_ids, user_id: user)

it { should have_many(:subscriptions).dependent(:destroy) }
