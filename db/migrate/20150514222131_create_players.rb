class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.belongs_to :team, index: true
      t.string :name
      t.integer :rookie
      t.integer :retire
      t.integer :playing
      t.float :mult
      t.timestamps null: false
    end
  end
end
