rails g model User name email
rake db:migrate
rails c --sandbox
user.reload.email
user.update(name: "The Dude", email: "dude@abides.org")
rake test:prepare
subject { @user }
it { should respond_to(:name) }
# The tests themselves rely on the boolean convention used by RSpec: the code
@user.respond_to?(:name)
# can be tested using the RSpec code
it "should respond to 'name'" do
  expect(@user).to respond_to(:name)
end
user.errors.full_messages
it { should_not be_valid }
%w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com foo@bar..com]
%w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
rails g migration add_index_to_users_email
add_index :users, :email, unique: true
# The reason is that not all database adapters use case-sensitive indices.
before_save { email.downcase! }

gem 'bcrypt-ruby', '3.1.2'
rails g migration add_password_digest_to_users password_digest
should respond_to(:password_digest) :password :password_confirmation :authenticate
# to sprawdza shoulda w have_secure_password, ale nie sprawdza czy jest nie blank i czy zgadza się z potwierdzeniem
class User < ActiveRecord::Base; has_secure_password; end
validates :password, length: { minimum: 6 }    # tego nie ma
user = User.find_by(email: email); current_user = user.authenticate(password)
specify { expect(sth).to matcher } - alias it {}
