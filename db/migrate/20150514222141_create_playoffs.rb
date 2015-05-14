class CreatePlayoffs < ActiveRecord::Migration
  def change
    create_table :playoffs do |t|
      t.integer :week
      t.integer :year
      t.references :home_team
      t.references :away_team
      t.references :winner
      t.references :loser
      t.timestamps null: false
    end
  end
end
