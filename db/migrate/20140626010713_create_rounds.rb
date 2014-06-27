class CreateRounds < ActiveRecord::Migration
  def change
    create_table :rounds do |t|
      t.belongs_to :game
      t.belongs_to :user
      t.binary :content, null: false
      t.string :content_type, null: false

      t.timestamps
    end
  end
end
