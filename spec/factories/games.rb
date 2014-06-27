require 'faker'

FactoryGirl.define do
  factory :game do
    association :creator

    factory :completed_game do
      is_complete true
    end
  end
end
