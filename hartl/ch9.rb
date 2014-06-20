git co -b updating-users

@user = User.find(params[:id])
= form_for(@user) do |f|
  = render 'fields', f: f
  = f.submit 'Save changes', class: 'btn btn-large btn-primary'
User.new.new_record?

# cookies.permanent method doesn’t work inside tests
def sign_in(user, options={})
  if options[:no_capybara]
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_columns(remember_token: User.digest(remember_token))

if @user.update(user_params)
  flash[:success] = "Profile updated"
  redirect_to @user
else
  render :edit
end

specify { expect(user.reload.name).to eq new_name }
specify { expect(response).to redirect_to(signin_path) }  # root_url

before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
before_action :correct_user,   only: [:edit, :update]
before_action :admin_user,     only: :destroy
before_action :non_signups,    only: [:new, :create]

unless signed_in?
  store_location
  redirect_to signin_url, notice: 'Please sign in'

redirect_to(root_url) unless current_user?(@user)
redirect_to(root_url) if current_user?(@user) || !current_user.admin?
redirect_to(root_url, notice: 'You already have one account') if signed_in?

before { sign_in user, no_capybara: true }
before { get edit_user_path(wrong_user) }
before { patch user_path(wrong_user) }
specify { expect(response.body).not_to match(full_title('Edit user')) }

session[:return_to] = request.url if request.get?
redirect_to(session[:return_to] || default)
session.delete(:return_to)
sign_in user
-  redirect_to user
+  redirect_back_or user

it "should list each user" do
  User.all.each do |user|
    expect(page).to have_selector('li', text: user.name)

@users = User.all

gem 'faker', '1.1.2'
# lib/tasks/sample_data.rake
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      User.create!(name: name, ...
rake db:reset
rake db:populate
rake test:prepare

gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'
bundle install

factory :user do
  sequence(:name)  { |n| "Ciołek the #{n.ordinalize}" }
before(:all) { 30.times { FactoryGirl.create(:user) } }
after(:all)  { User.delete_all }
it { should have_selector '.pagination', count: 2 }
= will_paginate
%ul.users
  = render @users  # _user.html.erb
= will_paginate
# If the page is nil, paginate simply returns the first page.
@users = User.paginate(page: params[:page])

@user.toggle!(:admin)
it { should be_admin }
add_column :users, :admin, :boolean, default: false
rake db:reset && rake db:populate && rake test:prepare
it { should_not have_link('delete', href: user_path(admin)) }
expect { click_link 'delete', match: :first }.to change(User, :count).by(-1)
- if current_user.admin? && ! current_user?(user)
  |
  = link_to 'delete', user, method: :delete, data: { confirm: 'Are you sure?' }
@user.destroy
flash[:success] = "User deleted"
redirect_to users_url

git push heroku
heroku pg:reset DATABASE
heroku run rake db:migrate
heroku run rake db:populate

sign_in user, no_capybara: true
patch user_path(user), params
specify { expect(user.reload).not_to be_admin }
