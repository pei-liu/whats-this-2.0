class Round < ActiveRecord::Base
  belongs_to :game
  belongs_to :player, class_name: "User", foreign_key: "user_id"
  validates :content, presence: true
  validates :content_type, presence: true, inclusion: { in: %w(drawing description) }

  def prepared_content
    content = self.content
    if self.content_type == "description"
      content
    elsif self.content_type == "drawing"
      content.gsub!(/width="\d+"/, '')
      content.gsub!(/height="\d+"/, 'preserveAspectRatio="xMinYMin meet" viewBox="0 0 500 500"')
      content.html_safe
    end
  end
end