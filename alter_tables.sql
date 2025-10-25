ALTER TABLE albums
ADD PRIMARY KEY (id); 

ALTER TABLE artists
ADD PRIMARY KEY (id); 

ALTER TABLE audio_features
ADD PRIMARY KEY (id); 

ALTER TABLE genres
ADD PRIMARY KEY (name); 

ALTER TABLE tracks
ADD PRIMARY KEY (id);

ALTER TABLE r_albums_artists
ADD FOREIGN KEY (album_id) REFERENCES albums(id);

ALTER TABLE r_albums_artists
ADD FOREIGN KEY (artist_id) REFERENCES artists(id);

ALTER TABLE r_albums_tracks
ADD FOREIGN KEY (album_id) REFERENCES albums(id) 

ALTER TABLE r_albums_tracks
ADD FOREIGN KEY (track_id) REFERENCES tracks(id);

ALTER TABLE r_artist_genre
ADD FOREIGN KEY (genre_name) REFERENCES genres(name);

ALTER TABLE r_artist_genre
ADD FOREIGN KEY (artist_id) REFERENCES artists(id);

ALTER TABLE r_track_artist
ADD FOREIGN KEY (track_id) REFERENCES tracks(id);

ALTER TABLE r_track_artist
ADD FOREIGN KEY (artist_id) REFERENCES artists(id);

ALTER TABLE audio_features 
ADD CONSTRAINT fk_audio_features_track 
FOREIGN KEY (id) REFERENCES tracks(id);
