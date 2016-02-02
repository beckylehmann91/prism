require "rails_helper"
require 'capybara/rspec'
require 'capybara/dsl'

feature "Logged in features" do
  before do
    User.create(username: "Brad", password: "password", email: "dude@bro.com")
  end

  scenario "Sign in with correct credentials" do
    visit '/login'
      fill_in 'Username', :with => 'Brad'
      fill_in 'Password', :with => 'password'

    click_button 'login'

    expect(page).to have_content 'Profile'

  end

  scenario "Sign in with incorrect credentials" do
    visit '/login'
      fill_in 'Username', :with => "Joe"
      fill_in 'Password', :with => "Schmore"

      click_button 'login'

      expect(page).to have_content "Username"

    end
end

feature "Not Logged in features" do
  before do

  end
  scenario "Not logged in going to posts/index" do
    visit '/posts'

    expect(page).to have_content 'Login'
  end

  scenario "Not logged in going to posts/show" do
    visit '/posts/1'

    expect(page).to have_content 'Login'
  end

  scenario "Not logged in going to posts/new" do
  visit '/posts/new'

  expect(page).to have_content 'Title'
  end
end