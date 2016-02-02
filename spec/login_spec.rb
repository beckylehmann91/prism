feature "Logged in features" do
  before do
    User.create(username: "Brad", password: "password", email: "dude@bro.com")
  end

  scenario "Sign in with correct credentials" do
    visit '/'
    within("#login") do
      fill_in 'Email', :with => 'dude@bro.com'
      fill_in 'Password', :with => 'password'
    end

    click_button 'login'

    expect(page).to have_content 'logout'

  end
end