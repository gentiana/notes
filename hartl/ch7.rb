= debug(params) if Rails.env.development?

=box-sizing
  -moz-box-sizing:    border-box
  -webkit-box-sizing: border-box
  box-sizing:         border-box
.debug_dump
  +box-sizing

rails console test
rails server --environment production
rake db:migrate RAILS_ENV=production

resources :users
@user = User.find(params[:id])

gem 'factory_girl_rails', '4.2.1', group: :test
FactoryGirl.define do
  factory :user do
    name                  "Gryzelda Ciołek"
    email                 "mietekbylzajety@o2.pl"
    password              "ala123"
    password_confirmation "ala123"
let(:user) { FactoryGirl.create(:user) }

ActiveModel::SecurePassword.min_cost = true   # /config/environments/test.rb

gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{options[:size]}"

visit signup_path
fill_in "Name", with: "Example User"
expect { click_button 'Submit' }.to change(User, :count).by(1)

= form_for(@user) do |f|
  = render 'shared/error_messages'
  = f.label :password_confirmation, 'Confirmation'
  = f.password_field :password_confirmation
  = f.submit 'Create my account', class: 'btn btn-large btn-primary'

@user = User.new(user_params)
if @user.save
  flash[:success] = "Welcome, #{@user.name}!"
  redirect_to @user
else
  render :new
params.require(:user).permit(:name, :email, :password, :password_confirmation)

- if @user.errors.any?
  The form contains
  = pluralize(@user.errors.count, 'error') + '.'
  - @user.errors.full_messages.each do |msg|
    %li= msg

- flash.each do |key, value|
  = content_tag(:div, value, class: "alert alert-#{key}")

config.force_ssl = true    # config/environments/production.rb

heroku run rake db:migrate

specify 'fields with errors should be inside right divs' do
  within 'form#new_user' do
    should have_selector 'div.field_with_errors', count: 6
    should have_selector 'label[for=user_name]', text: 'Name'
