class CreateTrack302Links < ActiveRecord::Migration
  def change
    create_table :track302_links do |t|
      t.string :uuid
      t.string :original

      t.timestamps null: false
    end
  end
end
