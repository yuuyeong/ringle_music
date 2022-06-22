class CreatePlaylists < ActiveRecord::Migration[7.0]
  def change
    create_table :playlists do |t|
      t.string :name
      t.references :playlistable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
