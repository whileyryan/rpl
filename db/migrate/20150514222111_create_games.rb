class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :week
      t.integer :year
      t.references :home_team
      t.references :away_team
      t.integer :home_points
      t.integer :away_points
      t.timestamps null: false
    end
  end
end
