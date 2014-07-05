require 'faker'

FactoryGirl.define do
  factory :user, aliases: [:player, :creator] do
    username Faker::Internet.user_name
    password "yolo"
    password_confirmation "yolo"

    factory :invalid_user do
      username ""
      password "yolo"
      password_confirmation "yolo"
    end

    factory :user_with_games_and_rounds do
      ignore do
        rounds_count 5
        games_count 5
      end

      after(:create) do |user, evaluator|
        create_list(:game_with_rounds, evaluator.games_count, user: user)
        create_list(:round_description, evaluator.rounds_count, user: user)
      end
    end
  end
end