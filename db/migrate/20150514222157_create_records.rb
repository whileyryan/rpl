class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.belongs_to :season, index: true
      t.belongs_to :team, index: true
      t.timestamps null: false
    end
  end
end
