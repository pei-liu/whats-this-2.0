require 'faker'

FactoryGirl.define do
  factory :game do
    association :creator
  end
end
