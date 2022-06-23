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
      r.name_eng AS artist_eng,
      l.likes
    FROM tracks t 
    JOIN albums a ON t.album_id = a.id 
    JOIN artists r ON r.id = t.artist_id
    LEFT JOIN (
      SELECT track_id, COUNT(*) AS likes
      FROM likes
      GROUP BY track_id
    ) l ON l.track_id = t.id
    SQL
  end

  def down
    execute <<-SQL
      DROP VIEW IF EXISTS songs
    SQL
  end
end
