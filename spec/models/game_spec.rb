require 'spec_helper'


describe Game do

  it "has a valid factory" do
    create(:game).should be_valid
  end

  context "#is_complete?" do
    it "returns false if a game has less than 10 rounds" do
      game = create(:game)
      expect(game.is_complete?).to eq false
    end

    it "returns true if a game has 10 or more rounds" do
      game = create(:game)
      10.times do
        game.rounds.build(content: "Content", content_type: "description").save
      end
      expect(game.is_complete?).to eq true
    end
  end

end
