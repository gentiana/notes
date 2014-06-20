git checkout -b filling-in-layout
<!--[if lt IE 9]>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->
/[if lt IE 9]
  %script{src: "http://html5shim.googlecode.com/svn/trunk/html5.js", type: "text/javascript"}
= link_to image_tag("rails.png", alt: "Rails"), 'http://rubyonrails.org/'
gem 'bootstrap-sass', '2.3.2.0'
gem 'sprockets', '2.11.0'
config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)    # config/application.rb
@import "bootstrap" # app/assets/stylesheets/custom.css.scss - reszta globalnych styli też tam
@import "bootstrap/variables"
<%= render 'layouts/header' %>    # _header.html.haml
http://2beards.net/2011/11/the-rails-3-asset-pipeline-in-about-5-minutes/
http://truffles.me.uk/rails-3-asset-pipeline-in-a-minute
sprockets - manifest files
/*
 *= require bootstrap
 *= require_tree .
 *= require_self
*/
foobar.js.erb.coffee
$lightGray: #999
http://bootstrapdocs.com/v2.0.4/docs/less.html
<%#= link_to "Contact", '#' %>
'
visit contact_path
get 'contact', to: "static_pages#contact"
about_url
before { visit root_path }
subject { page }
it { should have_content('Sample App') }
rails g controller Users new --no-test-framework
rails g integration_test user_pages
$ git add .
$ git commit -m "Finish layout and routes"
$ git checkout master
$ git merge filling-in-layout
it { should have_selector('h1', text: 'Contact') }
shared_examples_for "all static pages" do
  it { should have_selector('h1', text: heading) }
  it { should have_title(full_title(page_title)) }
end
let(:heading)    { 'Help' }
it_should_behave_like "all static pages"
it "should have the right links on the layout" do
  visit root_path
  click_link "About"
  expect(page).to have_title(full_title('About Us'))
  click_link "Help" # ......
spec/helpers/application_helper_spec.rb
require 'spec_helper'
describe ApplicationHelper do
  describe "full_title" do
    it "should include the page title" do
      expect(full_title("foo")).to match(/foo/)
    end
spec/support/utilities.rb
include ApplicationHelper
