class CreateSeasons < ActiveRecord::Migration
  def change
    create_table :seasons do |t|
      t.belongs_to :team, index: true 
      t.integer :year
      t.integer :wins
      t.integer :losses
      t.integer :pct
      t.integer :points
      t.timestamps null: false
    end
  end
end
