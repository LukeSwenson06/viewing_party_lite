require 'rails_helper'

RSpec.describe "User Dashboard", type: :feature do
  before :each do
    @user_1 = User.create(user_name: 'Tester', email: 'test@gmail.com', password: 'test123' )
    @user_2 = User.create(user_name: 'Ultimate Tester', email: 'ultimatetest@gmail.com', password: 'test321')

    visit '/login'
    fill_in 'Email:', with: 'test@gmail.com'
    fill_in 'Password:', with: 'test123'
    click_button 'Log in'

    @viewing_party = create(:viewing_party)
    attendee_table_1 = Attendee.create(user_id: @user_1.id, viewing_party_id: @viewing_party.id)
    attendee_table_2 = Attendee.create(user_id: @user_2.id, viewing_party_id: @viewing_party.id)

    visit dashboard_path
  end

  it "can display the users name at the top of the page", :vcr do
    expect(page).to have_content("#{@user_1.user_name} Dashboard")
    expect(page).to_not have_content("#{@user_2.user_name} Dashboard")
  end

  xit "has a button to take you to the movies page", :vcr do
    expect(page).to have_button("Discover Movies")
    click_button "Discover Movies"

    expect(current_path).to eq(user_discover_path(users[0].id))

  end

  describe 'it shows all the viewing parties that the user has been invited to' do

    xit 'displays the movie image', :vcr do
      within "#invited" do
        within "#party-#{viewing_party.id}" do
          expect(page).to have_image()
        end
      end
    end

    xit 'displays the movies title as a link which leads to the movie show page', :vcr do
      within "#invited" do
        within "#party-#{@viewing_party.id}" do
          click_link("#{@viewing_party.movie}")
          expect(current_path).to eq(user_movie_path(@user_1.id, "#{@viewing_party.movie_id}"))
        end
      end
    end

    xit 'displays the date and time of the event', :vcr do
      within "#invited" do
        within "#party-#{viewing_party.id}" do
          expect(page).to have_content("#{viewing_party.date.strftime('%a, %B %d, %Y')}")
          expect(page).to have_content("#{viewing_party.start_time.strftime("%I:%M%p")}")
        end
      end
    end

    xit 'displays the host of the event', :vcr do
      within "#invited" do
        within "#party-#{viewing_party.id}" do
          expect(page).to have_content("Host: #{viewing_party.user.user_name}")
        end
      end
    end

    xit 'displays a list of users invited to the party, with my name in bold', :vcr do
      within "#invited" do
        within "#party-#{viewing_party.id}" do
          expect(page).to have_content(viewing_party.users[0].user_name)
          expect(page).to have_content(viewing_party.users[1].user_name)
          expect(page).to_not have_content(users[2].user_name)
        end
      end
    end
  end

  describe 'it shows the viewing parties that the user has created', :vcr do

     xit 'displays the movie image' do
      withing "#created" do
        within "#party-#{host_party.id}" do
          expect(page).to have_image()
        end
      end
    end

    xit 'displays the movies title as a link which leads to the movie show page', :vcr do
      within "#created" do
        within "#party-#{host_party.id}" do
          click_link("#{viewing_party.movie}")
          expect(current_path).to eq(user_movie_path(users[0].id, "#{viewing_party.movie_id}"))
        end
      end
    end

    xit 'displays the date and time of the event', :vcr do
      within "#created" do
        within "#party-#{host_party.id}" do
          expect(page).to have_content("#{viewing_party.date}")
          expect(page).to have_content("#{viewing_party.start_time}")
        end
      end
    end

    xit 'displays that I am the host of the event', :vcr do
      within "#created" do
        within "#party-#{host_party.id}" do
          expect(page).to have_content("Host: #{viewing_party.user}")
        end
      end
    end

    xit 'displays a list of users invited to the party', :vcr do
      within "#created" do
          expect(page).to have_content(viewing_party.users[0].user_name)
          expect(page).to have_content(viewing_party.users[1].user_name)
          expect(page).to_not have_content(viewing_party.users[2].user_name)
      end
    end
  end
end
