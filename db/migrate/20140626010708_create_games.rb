class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :user
      t.boolean :is_complete, default: false

      t.timestamps
    end
  end
end
