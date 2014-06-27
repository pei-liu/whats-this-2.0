class Game < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  has_many :rounds

  def is_complete?
    self.rounds.count >= 10 ? true : false
  end

end
