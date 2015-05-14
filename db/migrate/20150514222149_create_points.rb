class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.belongs_to :season, index: true
      t.belongs_to :player, index: true
      t.integer :points
      t.integer :year
      t.timestamps null: false
    end
  end
end
