class CreateArtists < ActiveRecord::Migration[7.0]
  def change
    create_table :artists do |t|
      t.string :name_kr
      t.string :name_eng
      t.string :image_url

      t.timestamps
    end
  end
end
