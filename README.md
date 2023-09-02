# Coldplay Albums & Live shows Case-Study
Viva la Dataset: Exploring Coldplay's Albums and Electrifying Performances

[https://www.kaggle.com/datasets/faizalkarim/coldplay-albums-and-live-shows](url)

As a data analyst at Spotify, our team embarks on a thrilling musical expedition to uncover hidden gems and fascinating insights within the extensive discography of the iconic band- Coldplay. 
Armed with a vast dataset about their songs, we seek to discover patterns, trends, and unique characteristics that define Coldplay's musical journey and captivate their massive fan base worldwide.

The "Coldplay - Albums & Live shows" dataset is a comprehensive collection that offers a meticulous exploration of Coldplay's artistic evolution through their studio albums and captivating live performances. It provides information on the band's album tracklists, popularity, audio features such as popularity, danceability, energy etc.

This dataset can be used to explore the evolution of the band over the years, visualizing the data and comparing tracks based on various audio features.

Data Description: 

The dataset contains the following columns:

● name: The name of the song

● duration: The duration of the song in seconds

● release_date: The date when the song was released

● album_name: The name of the album the song belongs to

● explicit: A boolean value indicating whether the song contains explicit content

● Popularity: The popularity of the track. The value will be between 0 and 100, with 100 being the most popular. It is calculated by algorithm and is based, in the most part, songs that are being played a lot now will have a higher popularity than songs that were played a lot in the past.

● Acousticness: A confidence measure from 0.0 to 1.0 of whether the track is acoustic. 1.0 represents high confidence the track is acoustic.

● Danceability: Danceability describes how suitable a track is for dancing based on a combination of musical elements including tempo, rhythm stability, beat strength, and overall regularity. A value of 0.0 is least danceable and 1.0 is most danceable.

● Energy: Energy is a measure from 0.0 to 1.0 and represents a perceptual measure of intensity and activity. Typically, energetic tracks feel fast, loud, and noisy.
Instrumentalness: Predicts whether a track contains no vocals. "Ooh" and "aah" sounds are treated as instrumental in this context. Rap or spoken word tracks are clearly "vocal". The closer the instrumentalness value is to 1.0, the greater likelihood the track contains no vocal content.

● instrumentalness: A measure of the instrumental content of the song

● Liveness: Detects the presence of an audience in the recording. Higher liveness values represent an increased probability that the track was performed live. A value above 0.8 provides strong likelihood that the track is live.

● Loudness: The overall loudness of a track in decibels (dB). Loudness values are averaged across the entire track and are useful for comparing relative loudness of tracks. Values typically range between -60 and 0 db.

● Speechiness: Speechiness detects the presence of spoken words in a track. The more exclusively speech-like the recording (e.g. talk show, audio book, poetry), the closer to 1.0 the attribute value. Values above 0.66 describe tracks that are probably made entirely of spoken words. Values between 0.33 and 0.66 describe tracks that may contain both music and speech. Values below 0.33 most likely represent music and other non-speech-like tracks.

● Tempo: The overall estimated tempo of a track in beats per minute (BPM). In musical terminology, tempo is the speed or pace of a given piece and derives directly from the average beat duration.
Time Signature: An estimated time signature. The time signature (meter) is a notational convention to specify how many beats are in each bar (or measure). The time signature ranges from 3 to 7 indicating time signatures of "3/4", to "7/4".

● time_signature: The time signature of the song

● Valence: A measure from 0.0 to 1.0 describing the musical positiveness conveyed by a track. Tracks with high valence sound more positive (e.g. happy, cheerful, euphoric), while tracks with low valence sound more negative (e.g. sad, depressed, angry).

Reference: [https://developer.spotify.com/documentation/web-api/reference/get-audio-features](url)
