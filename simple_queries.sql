--1)Which track has the longest duration (AVG)?
SELECT DISTINCT TOP(1) name, 
       CAST(duration AS FLOAT) AS duration, 
       (SELECT AVG(CAST(duration AS FLOAT)) FROM tracks) AS avg_duration
FROM tracks 
ORDER BY duration DESC; 

--2)Which album is the most popular?
SELECT DISTINCT TOP(1) [name],popularity from albums
ORDER by popularity DESC

--3)Which artist has BETWEEN 2 AND 10 albums?
SELECT DISTINCT  artists.[name], COUNT(albums.id) AS album_count
FROM albums
INNER JOIN r_albums_artists AS a ON a.album_id = albums.id
INNER JOIN artists ON a.artist_id = artists.id
GROUP BY artists.[name]
HAVING COUNT(albums.id) BETWEEN 2 AND 10
ORDER BY album_count DESC;


--4)Which 2 artist has the most tracks?
SELECT DISTINCT TOP 2 artists.[name], COUNT(tracks.id) AS track_count
FROM tracks
INNER JOIN r_track_artist AS a ON a.track_id = tracks.id
INNER JOIN artists ON a.artist_id = artists.id
GROUP BY artists.[name]
ORDER BY track_count DESC

--5)which artist has the track with the most instrumentalness ?
select top(1) artists.name ,tracks.name,audio_features.danceability as danceability
from artists
LEFT JOIN r_track_artist as a on a.artist_id=artists.id
LEFT JOIN tracks on tracks.id= a.track_id
LEFT JOIN audio_features ON audio_features.id = tracks.id
order by instrumentalness desc

--6)Which are the Top 3 Popular Energy tracks?
SELECT DISTINCT TOP 3 tracks.[name],popularity ,e.energy
from tracks 
INNER JOIN audio_features AS e ON e.id = tracks.id
order by popularity desc

--7)how many tracks has each album?
SELECT albums.name ,count(tracks.id)as ct
from albums
inner join r_albums_tracks as a on a.album_id= albums.id
inner join tracks on a.track_id=tracks.id
group by albums.name
order by ct desc

--8)how many same loudness tracks are in each album?
SELECT albums.name , count(tracks.id)as number_of_tracks,audio_features.loudness
from albums
inner join r_albums_tracks as a on a.album_id= albums.id
inner join tracks on a.track_id=tracks.id
inner join audio_features on audio_features.id =tracks.id
GROUP by albums.name,audio_features.loudness
order by number_of_tracks desc

--9)which artist has the track with the most dancability?
select top(1) artists.name ,tracks.name,audio_features.danceability as danceability
from artists
RIGHT join r_track_artist as a on a.artist_id=artists.id
RIGHT join tracks on tracks.id= a.track_id
RIGHT join audio_features ON audio_features.id = tracks.id
order by danceability desc

--10)which artist has the oldest album?
select top(1) artists.name , albums.release_date
from artists
inner join r_albums_artists as a on a.artist_id=artists.id
inner join albums on albums.id = a.album_id
order by CAST(albums.release_date AS DATE) asc


--11)which albums has the most tracks?
select albums.name , count(tracks.id)as number_of_tracks
from albums
inner join r_albums_tracks as a on a.album_id=albums.id
inner join tracks on tracks.id=a.track_id
group by albums.name
order by number_of_tracks desc


--12)which artist has the least tracks(MIN_TRACKS ARTIST)?
SELECT TOP(1) artists.name, 
       COUNT(tracks.id) AS number_of_tracks, 
       (SELECT MIN(track_count) 
        FROM (SELECT COUNT(tracks.id) AS track_count 
              FROM artists
              INNER JOIN r_track_artist AS a ON a.artist_id = artists.id
              INNER JOIN tracks ON tracks.id = a.track_id
              GROUP BY artists.name) AS subquery) AS min_tracks
FROM artists
INNER JOIN r_track_artist AS a ON a.artist_id = artists.id
INNER JOIN tracks ON tracks.id = a.track_id
GROUP BY artists.name
ORDER BY number_of_tracks ASC;