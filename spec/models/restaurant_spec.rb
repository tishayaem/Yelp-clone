require 'rails_helper'

describe Restaurant, type: :model do
  it {is_expected.to have_many :reviews }

describe Review do
  it { should belong_to(:restaurant) }
  end
end
