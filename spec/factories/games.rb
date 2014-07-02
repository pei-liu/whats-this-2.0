require 'faker'

FactoryGirl.define do
  factory :game do
    creator

    factory :completed_game do
      is_complete true
    end

    factory :game_with_rounds do
      ignore do
        rounds_count 5
      end

      after(:create) do |game, evaluator|
        # create_list(:round_drawing, evaluator.rounds_count, game: game)
        create_list(:round_description, evaluator.rounds_count, game: game)
      end
    end
  end
end