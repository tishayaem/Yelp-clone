require 'rails_helper'

feature 'restaurants' do

  context 'no restaurants add yet' do
    scenario 'should display a prompt to add restaurant' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'adding restaurants' do
    scenario 'should prompt user to create restaurant' do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'KFC'
      click_button 'Create Restaurant'
      expect(page).to have_content('KFC')
      expect(current_path).to eq '/restaurants'
    end

    scenario 'getting an error if adding a restarant without being signed in' do
      visit '/restaurants'
      create_restaurant

    end

end

  context 'an invalid restaurant' do
    it 'does not let you submit a name that is too short' do
      sign_up
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
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

  context 'viewing restaurants' do
    let!(:kfc){Restaurant.create(name:'KFC')}

    scenario 'lets a new user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do

    before { Restaurant.create name: 'KFC' }

    scenario 'let a user edit a restaurant' do
      sign_up
      click_link 'Edit KFC'
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do

    before {Restaurant.create name: 'KFC'}

    scenario 'removes restaurant when user clicks delete link' do
      sign_up
      click_link 'Delete KFC'
      expect(page).not_to have_content "KFC"
      expect(page).to have_content 'Restaurant deleted successfully'
    end
end

  scenario 'deleting a restaurant created by another user' do
    sign_up
    create_restaurant
    sign_out
    sign_up(email: 'user2@example.com')
    delete_restaurant
    expect(page).to have_content('error')
end
end
