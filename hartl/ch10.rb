rails g model Micropost content user_id:integer
rm -f spec/factories/microposts.rb
# retrieve all the microposts associated with a given user id in reverse order of creation
add_index :microposts, [:user_id, :created_at]
# By including both the user_id and created_at columns as an array, we arrange for Rails to create a multiple key index, which means that Active Record uses both keys at the same time. 
rake db:migrate && rake test:prepare

user.microposts.create(arg)  # create!
user.microposts.build(arg)

factory :micropost do
  content "Lorem ipsum"
  user
FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
# Factory Girl: we can set created_at manually, which Active Record won’t allow us to do
# let variables are lazy, meaning that they only spring into existence when referenced
its('microposts.to_a') { should == [newer_micropost, older_micropost] }

belongs_to :user
default_scope -> { order('created_at DESC') }
-> { puts "foo" }.call

microposts = @user.microposts.to_a  # dzięki to_a tworzy kopię
@user.destroy
expect(microposts).not_to be_empty
microposts.each do |micropost|
  expect do
    Micropost.find(micropost)
  end.to raise_error(ActiveRecord::RecordNotFound)
has_many :microposts, dependent: :destroy

user.microposts.count
clients = Client.includes(:address) # eager loading associations
belongs_to :customer, counter_cache: true

= will_paginate @microposts
= render @microposts
# app/views/microposts/_micropost.html.erb
Posted <%= time_ago_in_words(micropost.created_at) %> ago.
@microposts = @user.microposts.paginate(page: params[:page])

users = User.all(limit: 6)
content = Faker::Lorem.sentence(5)

resources :microposts, only: [:create, :destroy]

before { delete micropost_path(FactoryGirl.create(:micropost)) }

rails g integration_test micropost_pages

before_action :signed_in_user
before_action :correct_user, only: :destroy
@micropost = current_user.microposts.build(micropost_params)
if @micropost.save
  flash[:success] = "Micropost created"
  redirect_to root_url
else
  @feed_items = []  # returning a paginated feed doesn’t work
  render 'static_pages/home'
@micropost.destroy
flash[:success] = "Micropost deleted"
redirect_to root_url
def micropost_params
  params.require(:micropost).permit(:content)
def correct_user
  @micropost = current_user.microposts.find(params[:id])
rescue ActiveRecord::RecordNotFound
  redirect_to root_url
end

pluralize(current_user.microposts.count, "micropost")
= render "shared/error_messages", object: f.object
= f.text_area :content, placeholder: "Compose new micropost..."

if signed_in?
  @micropost  = current_user.microposts.build
  @feed_items = current_user.feed.paginate(page: params[:page])

pluralize(object.errors.count, "error")

let(:unfollowed_post) { FactoryGirl.create(:micropost) }
its(:feed) { should_not include(unfollowed_post) }

Micropost.where("user_id = ?", id)    # microposts

= render partial: 'shared/feed_item', collection: @feed_items
= will_paginate @feed_items

if current_user?(micropost.user)
  link_to 'delete', micropost, method: :delete,
                               data: { confirm: 'Are you sure?' },
                               title: micropost.content

sanitize(raw(content.split.map{ |s| wrap_long_string(s) }.join ' '))
def wrap_long_string(text, max_width = 30)
  zero_width_space = "&#8203;"
  regex = /.{1,#{max_width}}/
  (text.length < max_width) ? text : text.scan(regex).join(zero_width_space)

$(document).on 'blur', '#micropost_content', ->
