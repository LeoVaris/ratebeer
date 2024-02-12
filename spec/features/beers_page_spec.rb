require 'rails_helper'

describe "Beers page" do
  it "should not have any before been created" do
    visit beers_path
    expect(page).not_to have_content 'Style'
  end

  describe "when at least one brewery exists" do
    before :each do
      FactoryBot.create :user
      FactoryBot.create(:brewery, name: "Koff", year: 1896)

      sign_in(username: "Pekka", password: "Foobar1")

      visit new_beer_path
    end

    it "does not save a beer without a name" do
      click_button("Create Beer")

      expect(page).not_to have_content "List of breweries"
    end

    it "does save a beer with a name" do
      fill_in('beer_name', with: 'created beer')
      click_button("Create Beer")

      expect(page).to have_content "List of breweries"
      expect(page).to have_content "created beer"
      expect(current_path).to eq(beers_path)
    end
  end
end
