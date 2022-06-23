class CreateSongsView < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE VIEW songs AS
      SELECT 
        t.id AS track_id, 
        t.title, 
        a.title AS album, 
        a.release_date, 
        r.name_kr AS artist_kr, 
        r.name_eng AS artist_eng
      FROM tracks t 
      JOIN albums a on t.album_id = a.id 
      JOIN artists r on r.id = t.artist_id
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW IF EXISTS songs
    SQL
  end
end
