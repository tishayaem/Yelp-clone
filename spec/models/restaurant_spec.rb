require 'rails_helper'
require 'spec_helper'
describe Restaurant, type: :model do
it {is_expected.to have_many :reviews }


it 'is not valid with a name of less than three characters' do
  restaurant = Restaurant.new(name: 'kf')
  expect(restaurant).to have(1).error_on(:name)
  expect(restaurant).not_to be_valid
end

it 'is not valid unless it has a unique name' do
  Restaurant.create(name: "Mo's Tavern")
  restaurant = Restaurant.new(name: "Mo's Tavern")
  expect(restaurant).to have(1).error_on(:name)
end


end
