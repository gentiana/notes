rails generate controller Sessions --no-test-framework
rails generate integration_test authentication_pages

resources :sessions, only: [:new, :create, :destroy]
match '/signout', to: 'sessions#destroy',     via: 'delete'
delete 'signout', to: 'sessions#destroy'

it { should have_selector('div.alert.alert-error') }
it { should_not have_link('Sign in', href: signin_path) }

= form_tag sessions_path do
  = label_tag :password
  = password_field_tag :password
  = submit_tag "Sign in"

user = User.find_by(email: params[:email].downcase)
if user && user.authenticate(params[:password])
  sign_in user
  redirect_to user
else
  flash.now[:error] = 'Invalid email/password combination'
  render :new

include SessionsHelper

session[:user_id] = user.id     # nie tu

add_column :users, :remember_token, :string
add_index  :users, :remember_token
rake db:migrate
rake test:prepare

its(:remember_token) { should_not be_blank }
before_create :create_remember_token
self.remember_token = User.digest(User.new_remember_token)
                      Digest::SHA1.hexdigest(SecureRandom.urlsafe_base64.to_s) # to_s bo może nil
                      
def sign_in(user)
  remember_token = User.new_remember_token
  cookies.permanent[:remember_token] = remember_token
  user.update_columns(remember_token: User.digest(remember_token))
  self.current_user = user

cookies[:remember_token] = { value: remember_token,
                             expires: 20.years.from_now.utc }
10.weeks.ago
5.megabytes

def current_user=(user)
  @current_user = user

def current_user
  remember_token = User.digest(cookies[:remember_token]) # if cookies[:remember_token]
  @current_user ||= User.find_by(remember_token: remember_token) # if remember_token

def signed_in?
  !current_user.nil?        # czemu nie current_user ????????

http://getbootstrap.com/2.3.2/components.html
- if signed_in?
  %li#fat-menu.dropdown
    %a.dropdown-toggle{ href: '#', data: {toggle: 'dropdown' } }
      Account
      %b.caret
    %ul.dropdown-menu
      %li.divider
      %li= link_to 'Sign out', signout_path, method: 'delete'

//= require bootstrap

sign_in @user       # users#create

def destroy
  sign_out
  redirect_to root_url
def sign_out
  current_user.update_columns(remember_token:
                              User.digest(User.new_remember_token))
  cookies.delete(:remember_token)
  self.current_user = nil
  
gem 'cucumber-rails', '1.4.0', :require => false, group: :test
gem 'database_cleaner', github: 'bmabey/database_cleaner', group: :test
rails g cucumber:install

Feature: Signing in
  Scenario: Unsuccessful signin
    Given a user visits the signin page
    When they submit invalid signin information
    Then they should see an error message
    
features/step_definitions/authentication_steps.rb
Then /^they should see an error message$/ do
  expect(page).to have_selector('div.alert.alert-error')

cucumber features/
rake cucumber
cucumber

spec/support/utilities.rb
def valid_signin(user)
  fill_in "Email",    with: user.email

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
