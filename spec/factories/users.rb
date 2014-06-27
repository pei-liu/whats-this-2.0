require 'faker'

FactoryGirl.define do
  factory :user, aliases: [:player, :creator] do
    username "Faker::Internet.username"
    password "yolo"
    password_confirmation "yolo"
  end
end
