require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants add yet' do
    scenario 'should display a prompt to add restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add Restaurant'
    end
  end

  context 'adding restaurants' do
    scenario 'should prompt user to create restaurant' do
      visit '/restaurants'
      click_link 'Add Restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create'
      expect(page).to have_content('KFC')
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'restaurants have been added' do

    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'display restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'KFC'
      expect(page).not_to have_content 'No restaurants yet'
  end
  end
end