require 'rails_helper'

RSpec.describe "Landing Page", type: :feature do
  let!(:users) { create_list(:user, 3)}
  let!(:viewing_party) { create(:viewing_party)}

  it "can display title of the application" do
    visit '/'

    expect(page).to have_content("Viewing Party")
  end

  it "has a button to create a new user" do
    visit '/'

    expect(page).to have_button("Create a New User")
    click_button "Create a New User"

    expect(current_path).to eq('/register')
  end

  it "has a link that goes back to the landing page" do
    visit "/"

    expect(page).to have_link("Landing Page")
    click_link "Landing Page"

    expect(current_path).to eq('/')

    visit '/register'

    expect(page).to have_link("Landing Page")
    click_link "Landing Page"

    expect(current_path).to eq('/')

  end

  # it "has a list of existing users and links to that users dashboard" do
  #   visit "/"
  #
  #   expect(page).to have_content("Existing Users")
  #
  #   within "#existing-users" do
  #     expect(page).to have_content(users[0].user_name)
  #     expect(page).to have_link(users[0].user_name)
  #     expect(page).to have_content(users[1].user_name)
  #     expect(page).to have_link(users[1].user_name)
  #     expect(page).to have_content(users[2].user_name)
  #     expect(page).to have_link(users[2].user_name)
  #
  #     click_link users[0].user_name
  #
  #   end
  #
  #   expect(current_path).to eq user_path(users[0])
  # end

  it "has a link called Log in that takes the user to a log in page" do
    user = User.create(user_name: 'Tester', email: 'test@gmail.com', password: 'test123' )

  
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path

    expect(page).to have_link("Log In")
    click_link "Log In"

    expect(current_path).to eq('/login')

    fill_in 'Email:', with: 'test@gmail.com'
    fill_in 'Password:', with: 'test123'

    click_button 'Log in'
    expect(current_path).to eq(dashboard_path)
  end

  it "produces an error message when the user fills in incorrect credentials" do
    user = User.create(user_name: 'Tester', email: 'test@gmail.com', password: 'test123' )
    visit root_path

    expect(page).to have_link("Log In")
    click_link "Log In"

    expect(current_path).to eq('/login')

    fill_in 'Email:', with: 'test@gmail.com'
    fill_in 'Password:', with: 'test145'
    click_button 'Log in'

    expect(current_path).to eq('/login')
    expect(page).to have_content('Invalid Credentials')
  end
end
