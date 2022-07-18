require 'rails_helper'

RSpec.describe 'New page', type: :feature do
  it 'has a form' do
    visit '/register'
    expect(page).to have_field('Username:')
    expect(page).to have_field('Email:')
    expect(page).to have_field('Password:')
    expect(page).to have_field('Password Confirmation:')
    expect(page).to have_button('Create User')
  end

  it 'can fill out and submit the form' do
    visit '/register'
    fill_in 'Username:', with: 'SWilks'
    fill_in 'Email:', with: 'stephenwilkens@gmail.com'
    fill_in 'Password:', with: 'test123'
    fill_in 'Password Confirmation:', with: 'test123'
    click_button 'Create User'
    new_user = User.last
    expect(current_path).to eq("/users/#{new_user.id}")
  end

  it "will not error out if user_name is blank" do
    visit '/register'
    fill_in 'Username:', with: ''
    fill_in 'Email:', with: 'stephenwilkens@gmail.com'
    fill_in 'Password:', with: 'test123'
    fill_in 'Password Confirmation:', with: 'test123'
    click_button 'Create User'

    expect(current_path).to eq("/register")
  end

  it "will not error out if passwords do not match" do
    visit '/register'
    fill_in 'Username:', with: 'Steph'
    fill_in 'Email:', with: 'stephenwilkens@gmail.com'
    fill_in 'Password:', with: 'test123'
    fill_in 'Password Confirmation:', with: 'test124'
    click_button 'Create User'

    expect(current_path).to eq("/register")
  end
end
