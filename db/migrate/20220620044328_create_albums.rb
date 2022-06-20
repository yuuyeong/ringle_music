class CreateAlbums < ActiveRecord::Migration[7.0]
  def change
    create_table :albums do |t|
      t.string :title
      t.string :image_url
      t.datetime :release_date
      t.integer :total_tracks
      t.references :artist, null: false, foreign_key: true

      t.timestamps
    end
  end
end
