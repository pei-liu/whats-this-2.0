class Round < ActiveRecord::Base
  belongs_to :game
  belongs_to :player, class_name: "User", foreign_key: "user_id"
  validates :content, presence: true
  validates :content_type, presence: true, inclusion: { in: %w(drawing description) }
end