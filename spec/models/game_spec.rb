require 'spec_helper'


describe Game do
  let(:game) { create(:game) }
  let(:completed_game) {}
  it "has a valid factory" do
    create(:game).should be_valid
  end

  context "#is_complete?" do
    it "returns false if a game has less than 10 rounds" do
      expect(game.is_complete?).to eq false
    end
    it "returns true if a game has 10 or more rounds" do
      10.times do
        game.rounds.build(content: "Content", content_type: "description").save
      end
      expect(game.is_complete?).to eq true
    end
  end

  context "#check_finished" do
    it "updates 'is_complete' attr to 'true' if game has 10 or more rounds" do
      10.times do
        game.rounds.build(content: "Content", content_type: "description").save
      end
      game.check_finished
      expect(game.is_complete).to eq true
    end
    it "does nothing if game has less than 10 rounds" do
      game.check_finished
      expect(game.is_complete).to eq false
    end
  end

end
