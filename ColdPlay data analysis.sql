-- ColdPlay Data - Case Study
-- As a data analyst at Spotify, our team embarks on a thrilling musical expedition to uncover
-- hidden gems and fascinating insights within the extensive discography of the iconic band,
-- Coldplay. Armed with a vast dataset about their songs, we seek to discover patterns, trends,
-- and unique characteristics that define Coldplay's musical journey and captivate their massive
-- fan base worldwide.


-- Data Description: The dataset contains the following columns:
-- ● name: The name of the song
-- ● duration: The duration of the song in seconds
-- ● release_date: The date when the song was released
-- ● album_name: The name of the album the song belongs to
-- ● explicit: A boolean value indicating whether the song contains explicit content
-- ● popularity: The popularity score of the song
-- ● acousticness: A measure of the acoustic quality of the song
-- ● danceability: A measure of how suitable the song is for dancing
-- ● energy: A measure of the intensity and activity of the song
-- ● instrumentalness: A measure of the instrumental content of the song
-- ● liveness: A measure of the presence of a live audience in the recording
-- ● loudness: The overall loudness of the song
-- ● speechiness: A measure of the presence of spoken words in the song
-- ● tempo: The tempo of the song in beats per minute
-- ● time_signature: The time signature of the song
-- ● valence: A measure of the musical positiveness of the song


SELECT * FROM `ColdPlay-Data`.coldplay_data LIMIT 1000;

-- -- Query 1: List all columns for the first 10 rows.
SELECT
*
FROM `ColdPlay-Data`.coldplay_data
LIMIT 10;


-- -- Query 2: Find the total number of songs in the dataset.
SELECT
COUNT(name) #COUNT(*) - there are no rows with null name value, both querys return 232.
FROM `ColdPlay-Data`.coldplay_data;


-- -- Query 3: Retrieve the average duration of Coldplay songs in seconds.
SELECT AVG(duration)
FROM `ColdPlay-Data`.coldplay_data;


-- -- Query 4: List all unique album names in the dataset.
SELECT DISTINCT album_name
FROM `ColdPlay-Data`.coldplay_data;


-- -- Query 5: Find the number of songs that are explicit.
SELECT
COUNT(*) AS num_of_explicit_songs
FROM `ColdPlay-Data`.coldplay_data
WHERE explicit = true;


-- -- Query 6: Rank the songs based on popularity in descending order.
SELECT
name,
popularity,
DENSE_RANK() OVER(ORDER BY popularity DESC) AS drnk
FROM `ColdPlay-Data`.coldplay_data
ORDER BY drnk;


-- -- Query 7: Calculate the running total of song durations ordered by release_date.
SELECT
name,
release_date,
duration,
SUM(duration) OVER(ORDER BY release_date ASC) AS running_total
FROM `ColdPlay-Data`.coldplay_data
ORDER BY release_date ASC;


--
SELECT release_date, duration,
SUM(duration) OVER (ORDER BY release_date) AS running_total_duration_seconds
FROM `ColdPlay-Data`.coldplay_data;


-- -- Query 8: Find the top 5 albums with the highest number of songs.
SELECT
album_name,
COUNT(*) AS num_of_songs_in_album
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
ORDER BY num_of_songs_in_album DESC
LIMIT 5;


-- -- Query 9: Calculate the average popularity for each album.
SELECT
album_name,
AVG(popularity) AS avg_popularity_in_album
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
ORDER BY avg_popularity_in_album DESC;


-- -- Query 10: Determine the rank of songs based on duration within each album.
SELECT
name,
album_name,
DENSE_RANK() OVER(PARTITION BY album_name ORDER BY duration) AS drnk
FROM `ColdPlay-Data`.coldplay_data
ORDER BY album_name, drnk;


--
SELECT *, RANK() OVER (PARTITION BY album_name ORDER BY duration) AS
song_duration_rank
FROM `ColdPlay-Data`.coldplay_data;


-- -- Query 11: List the songs that have a popularity greater than the average
-- popularity.
SELECT
name,
popularity
FROM `ColdPlay-Data`.coldplay_data
WHERE popularity > (SELECT AVG(popularity) FROM `ColdPlay-Data`.coldplay_data)
ORDER BY popularity DESC;


-- -- Query 12: Calculate the median duration of songs for each album using the
-- PERCENTILE_CONT() window function. --> doesn't exist in MySQL (does in bigQuery)
/*
SELECT
DISTINCT album_name,
PERCENTILE_CONT(duration,0.5) OVER(PARTITION BY album_name) AS median_duration_per_album
FROM
`ColdPlay-Data`.coldplay_data;

SELECT album_name,
PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY duration) OVER() AS median_duration
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name;
*/
-- -- Query 13: Find the songs that have both high popularity (above 80) and high energy
-- (above 0.8).
SELECT
name
FROM `ColdPlay-Data`.coldplay_data
WHERE popularity > 80 AND energy > 0.8;


-- -- Query 14: Calculate the total number of explicit and non-explicit songs for each
-- album.
SELECT
album_name,
SUM(CASE WHEN explicit = true THEN 1 ELSE 0 END) AS num_explicit,
COUNT(CASE WHEN explicit = false THEN 1 ELSE 0 END) AS num_not_explicit
FROM
`ColdPlay-Data`.coldplay_data
GROUP BY album_name
ORDER BY album_name ASC;


--
SELECT album_name, explicit,
COUNT(*) AS song_count
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name, explicit
ORDER BY album_name ASC;


-- -- Query 15: Determine the rank of albums based on the total number of songs.
SELECT
album_name,
num_of_songs,
DENSE_RANK() OVER(ORDER BY num_of_songs DESC) AS drk
FROM
(
SELECT
album_name,
COUNT(*) AS num_of_songs
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
)
ORDER BY drk;


--
SELECT album_name, COUNT(*) AS song_count,
RANK() OVER (ORDER BY COUNT(*) DESC) AS album_rank_by_song_count
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
ORDER BY album_rank_by_song_count;




-- -- Query 16: Calculate the percentage of explicit songs for each album.
SELECT
album_name,
COUNT(*) AS num_of_total_songs,
COUNT(CASE WHEN explicit = true THEN 1 END) AS num_of_explicit_songs,
(COUNT(CASE WHEN explicit = true THEN 1 END) / COUNT(*)) * 100 AS percentage
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name;
--
/*
SELECT album_name,
(COUNT(*) FILTER (WHERE explicit = true) / COUNT(*)) * 100 AS explicit_percentage
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name;
*/

-- -- Query 17: Rank the albums based on the average popularity.
SELECT
album_name,
DENSE_RANK() OVER(ORDER BY AVG(popularity) DESC) AS drk
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
ORDER BY drk;


--
SELECT album_name, AVG(popularity) AS avg_popularity,
RANK() OVER (ORDER BY AVG(popularity) DESC) AS album_rank_by_popularity
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
ORDER BY album_rank_by_popularity;


-- -- Query 18: Calculate the total number of explicit and non-explicit songs for each
-- album.
SELECT
album_name,
COUNT(CASE WHEN explicit = true THEN 1 END) AS num_of_explicit_songs,
COUNT(CASE WHEN explicit = false THEN 1 END) AS num_of_non_explicit_songs
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
ORDER BY album_name;


#another option:
SELECT
album_name,
explicit,
COUNT(*) AS num_of_songs
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name, explicit
ORDER BY album_name;


-- Query 19: Calculate the total duration of songs released after 2010.
SELECT SUM(duration) AS total_duration_after_2010
FROM `ColdPlay-Data`.coldplay_data
WHERE EXTRACT(YEAR FROM release_date) > 2010;


-- -- Query 20: Find the top 5 albums with the highest cumulative popularity.
SELECT
album_name,
SUM(popularity) AS cumulative_popularity
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
ORDER BY cumulative_popularity DESC
LIMIT 5;


-- -- Query 21: Calculate the average liveness of songs for each album that has at least
-- one live song.
SELECT
album_name,
AVG(liveness) AS average_liveness
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
ORDER BY average_liveness DESC;


-- for each live album:
SELECT album_name, AVG(liveness) AS avg_liveness
FROM `ColdPlay-Data`.coldplay_data
WHERE album_name IN (
SELECT DISTINCT album_name
FROM `ColdPlay-Data`.coldplay_data
WHERE lower(album_name) LIKE '%live%'
)
GROUP BY album_name
ORDER BY avg_liveness DESC;

-- -- Query 22: Rank the albums based on the total number of explicit songs they contain.
SELECT
album_name,
COUNT(CASE WHEN explicit = true THEN 1 END) AS num_explicit_songs,
DENSE_RANK() OVER(ORDER BY COUNT(CASE WHEN explicit = true THEN 1 END) DESC ) AS drnk
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
ORDER BY drnk;


--
SELECT album_name, COUNT(*) AS explicit_songs_count,
RANK() OVER (ORDER BY COUNT(*) DESC) AS explicit_songs_rank
FROM `ColdPlay-Data`.coldplay_data
WHERE explicit = true
GROUP BY album_name
ORDER BY explicit_songs_rank;


-- -- Query 23: Calculate the number of songs that have a higher popularity than the
-- previous song within each album.
SELECT COUNT(*)
FROM
(
	SELECT * 
	FROM
	(
		SELECT
		name,
		popularity,
		LAG(popularity,1) OVER(PARTITION BY album_name ORDER BY release_date) AS previous_song_in_album_popularity
		FROM `ColdPlay-Data`.coldplay_data
	)
    WHERE popularity > previous_song_in_album_popularity

);


--
SELECT album_name, release_date, popularity,
LAG(popularity) OVER (PARTITION BY album_name ORDER BY release_date) AS
previous_popularity,
CASE WHEN popularity > LAG(popularity) OVER (PARTITION BY album_name ORDER BY release_date) THEN 1 ELSE 0 END AS higher_popularity_than_previous
FROM `ColdPlay-Data`.coldplay_data;


-- -- Query 24: List all songs that have the same duration as any other song.
SELECT
name
FROM `ColdPlay-Data`.coldplay_data
GROUP BY name
HAVING COUNT(duration) >= 2;


--
SELECT t1.name, t2.name
FROM `ColdPlay-Data`.coldplay_data AS t1
JOIN `ColdPlay-Data`.coldplay_data AS t2
ON t1.duration = t2.duration #AND t1.name != t2.name
WHERE t1.name != t2.name;


-- -- Query 25: Calculate the total duration of all songs in the dataset grouped by
-- album_name and ordered by release_date in descending order.
SELECT
album_name,
SUM(duration) AS total_duration
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
ORDER BY MIN(release_date) DESC;


#
SELECT DISTINCT album_name FROM `ColdPlay-Data`.coldplay_data;


--
SELECT album_name, SUM(duration) AS total_duration
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
ORDER BY MIN(release_date) DESC;


-- -- Query 26: List the songs that have a popularity within the top 10% of all songs in
-- the dataset.
SELECT 
	name, 
    popularity
FROM
(
	SELECT
	name,
	popularity, 
    PERCENT_RANK() OVER(ORDER BY popularity) AS pr
	FROM `ColdPlay-Data`.coldplay_data
	ORDER BY popularity DESC
) AS t
WHERE pr >= 0.9
ORDER BY popularity DESC; -- returns 23 rows instead of 232 (only when the popularity is Larger then the 90th percentile (=70.0))

/* PERCENTILE_CONT -> not in MySQL!
-- using PERCENTILE_CONT:
SELECT
name,
popularity
FROM
`ColdPlay-Data`.coldplay_data
QUALIFY popularity > PERCENTILE_CONT(popularity,0.9) OVER()
ORDER BY popularity DESC; -- returns 23 rows instead of 232 (only when the popularity is Larger then the 90th percentile (=70.0))


-- using PERCENTILE_CONT:
SELECT
name,
popularity
FROM
`ColdPlay-Data`.coldplay_data
QUALIFY popularity >= PERCENTILE_CONT(popularity,0.9) OVER()
ORDER BY popularity DESC; -- returns 25 rows instead of 232 (also when the popularity is Equal to the 90th percentile (=70.0))

--
SELECT *
FROM `ColdPlay-Data`.coldplay_data
WHERE popularity >= (SELECT PERCENTILE_CONT(popularity,0.9) FROM `ColdPlay-Data`.coldplay_data LIMIT 1); -- returns 25 rows instead of 232 (also when the popularity is Equal to the 90th percentile (=70.0))
*/

-- -- Query 27: Find the albums that have at least one song with a popularity greater
-- than 90 and at least one song with a popularity less than 50.
SELECT DISTINCT album_name FROM
(
SELECT
name,
album_name
FROM `ColdPlay-Data`.coldplay_data
WHERE popularity > 90
UNION ALL
SELECT
name,
album_name
FROM `ColdPlay-Data`.coldplay_data
WHERE popularity < 50
);
--
SELECT album_name
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
HAVING MAX(popularity) > 90 AND MIN(popularity) < 50;


-- -- Query 28: Calculate the average energy for each album and include the album's
-- release date.


SELECT
album_name,
release_date,
AVG(energy) AS avg_energy
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name,release_date
ORDER BY album_name;


-- -- Query 29: Rank the songs based on their loudness in ascending order within each
-- album.
SELECT
name,
album_name,
loudness,
DENSE_RANK() OVER(PARTITION BY album_name ORDER BY loudness ASC) AS loudness_rank_within_album
FROM `ColdPlay-Data`.coldplay_data;


-- -- Query 30: Calculate the total number of songs for each album released in 2010 or
-- later.
SELECT
album_name,
COUNT(name) AS num_of_songs
FROM `ColdPlay-Data`.coldplay_data
WHERE EXTRACT(YEAR FROM release_date) >= 2010
GROUP BY album_name;
--
SELECT *
FROM
(
SELECT
album_name,
COUNT(CASE WHEN EXTRACT(YEAR FROM release_date) >= 2010 THEN 1 END) AS num_of_songs
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
)
WHERE num_of_songs != 0;


-- -- Query 31: List the songs that have a popularity greater than the average popularity
-- for their respective album.
WITH albums_and_avg_popularity AS
(
SELECT
album_name,
AVG(popularity) AS avg_popularity_in_album
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
)
SELECT
cp.name,
cp.album_name,
popularity,
avg_popularity_in_album
FROM `ColdPlay-Data`.coldplay_data AS cp
JOIN albums_and_avg_popularity AS cte
ON cp.album_name = cte.album_name AND cp.popularity > cte.avg_popularity_in_album;


--
SELECT t1.*
FROM `ColdPlay-Data`.coldplay_data AS t1
JOIN (
SELECT album_name, AVG(popularity) AS avg_popularity
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name
) AS t2
ON t1.album_name = t2.album_name AND t1.popularity > t2.avg_popularity;


-- -- Data quality
-- -- 1. Are there any missing values in the 'name' or 'duration' fields?
SELECT
name, duration
FROM `ColdPlay-Data`.coldplay_data
WHERE name IS NULL OR duration IS NULL; -- No
--
SELECT COUNT(*) AS missing_name_count
FROM `ColdPlay-Data`.coldplay_data
WHERE name IS NULL;
SELECT COUNT(*) AS missing_duration_count
FROM `ColdPlay-Data`.coldplay_data
WHERE duration IS NULL;


-- -- 2. Do the 'popularity' values fall within the expected range (0 to 100)?
SELECT
popularity
FROM `ColdPlay-Data`.coldplay_data
WHERE popularity < 0 OR popularity > 100; --Yes


-- -- 3. Are there any duplicate records based on the 'name' and 'album_name'
-- combination?
SELECT name,
album_name,
COUNT(*) AS duplicate_count
FROM `ColdPlay-Data`.coldplay_data
GROUP BY name, album_name
HAVING COUNT(*) > 1; -- No


-- -- 4. Do the 'release_date' values follow a consistent date format?
SELECT release_date,
COUNT(*) AS inconsistent_date_format_count
FROM `ColdPlay-Data`.coldplay_data
WHERE DATE_FORMAT(release_date,'%Y-%m-%d') IS NULL
GROUP BY release_date; -- Yes

-- -- 5. Are there any songs with negative 'duration' or 'tempo' values?
SELECT
name
FROM `ColdPlay-Data`.coldplay_data
WHERE duration < 0 OR tempo < 0; -- No


--
SELECT COUNT(*) AS negative_duration_count
FROM `ColdPlay-Data`.coldplay_data
WHERE duration < 0;
SELECT COUNT(*) AS negative_tempo_count
FROM `ColdPlay-Data`.coldplay_data
WHERE tempo < 0;


-- Data Visualization Techniques:


-- We will use the following five types of charts to visualize the data:


-- Data Visualization in BigQuery:
-- After running these queries, you can import the results into your preferred data visualization


-- 1. Line Chart: Use the line chart to show how the popularity of Coldplay songs changes
-- over time. The x-axis will represent the release date, and the y-axis will represent the
-- popularity score.


-- Line Chart: Popularity Over Time
SELECT release_date, popularity
FROM `ColdPlay-Data`.coldplay_data
ORDER BY release_date;


-- 2. Bar Chart: Create a bar chart to compare the average duration of songs across different
-- albums. The x-axis will show the album names, and the y-axis will display the average
-- duration.


-- Bar Chart: Average Duration per Album
SELECT album_name, AVG(duration) AS average_duration
FROM `ColdPlay-Data`.coldplay_data
GROUP BY album_name;


-- 3. Scatter Plot: Visualize the relationship between danceability and energy of songs using a
-- scatter plot. The x-axis will represent danceability, and the y-axis will represent energy.
-- Each point will represent a song, and the color of the points will represent different
-- albums.


-- Scatter Plot: Danceability vs. Energy
SELECT danceability, energy, album_name
FROM `ColdPlay-Data`.coldplay_data;


-- 4. Pie Chart: Create a pie chart to show the distribution of songs based on their time
-- signature in the dataset.


-- Pie Chart: Songs Distribution by Time Signature
SELECT time_signature, COUNT(*) AS song_count
FROM `ColdPlay-Data`.coldplay_data
GROUP BY time_signature;


-- 5. Bubble Chart: Use the bubble chart to explore the relationship between the loudness
-- and the valence of songs. The x-axis will represent the loudness, the y-axis will
-- represent the valence, and the bubbles' size will represent the songs' popularity.


-- Bubble Chart: Loudness vs. Valence
SELECT loudness, valence, popularity
FROM `ColdPlay-Data`.coldplay_data;
