class CreateTrack302Clicks < ActiveRecord::Migration
  def change
    create_table :track302_clicks do |t|
      t.string :uuid

      if t.respond_to?(:json)
        # pgsql!
        t.json :data
      else
        t.binary :data
      end

      t.timestamps null: false
    end
  end
end
