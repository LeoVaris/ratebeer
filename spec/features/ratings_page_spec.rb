require 'rails_helper'

include Helpers

describe "Rating" do
  let!(:brewery) { FactoryBot.create :brewery, name: "Koff" }
  let!(:beer1) { FactoryBot.create :beer, name: "iso 3", brewery:brewery }
  let!(:beer2) { FactoryBot.create :beer, name: "Karhu", brewery:brewery }
  let!(:user) { FactoryBot.create :user }

  before :each do
    sign_in(username: "Pekka", password: "Foobar1")

    FactoryBot.create :rating, beer: beer1, user: user
    FactoryBot.create :rating, beer: beer2, user: user
  end

  it "should show the ratings on the main page" do
    visit ratings_path

    expect(page).to have_content "Number of ratings: 2"
    expect(page).to have_content "iso 3"
    expect(page).to have_content "Karhu"
  end

  it "should show the ratings on the user page" do
    visit user_path(user)

    expect(page).to have_content "iso 3"
    expect(page).to have_content "Karhu"
  end

  it "should show the favorite style and brewery" do
    visit user_path(user)

    expect(page).to have_content "Favorite style: Lager"
    expect(page).to have_content "Favorite brewery: Koff"
  end

  it "should delete a rating correctly" do
    visit user_path(user)

    page.all('a')[9].click

    expect(page).not_to have_content "iso 3"
    expect(Rating.all.length).to eq(1)
  end
end
