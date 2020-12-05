--Transacion 시작
BEGIN;
--파일에서 데이터를 받아와 TABLE에 COPY
\COPY ACTOR(Name, BirthDate, DeathDate, Sex) from '/home/myung4386/Data/actor.tsv';
\COPY MOVIE(Title, TYPE, isAdult, StartDate, RunTimes) from '/home/myung4386/Data/movie.tsv';
\COPY GENRE(Genre) from '/home/myung4386/Data/genre.tsv';
\COPY BELONG(MovieID, GenreID) from '/home/myung4386/Data/belong.tsv';
\COPY ACCOUNT(ID, Password, Membership, Name, Address, Sex, BirthDate, Job, Phone, JoinDate) from '/home/myung4386/Data/account.tsv';
\COPY RATING(MovieID, AccountID, Score) from '/home/myung4386/Data/rating.tsv';
\COPY VERSION(MovieID, Ordering, Title, Region) from '/home/myung4386/Data/version.tsv';
\COPY EPISODE(MovieID, EpisodeNum) from '/home/myung4386/Data/episode.tsv';
\COPY ACT(MovieID, ActorID) from '/home/myung4386/Data/act.tsv';

--MOVIE의 AverageScore에 RATING의 값을 받아와서 채워넣음
CREATE VIEW AvgScore AS
SELECT MovieID, Avg(Score) AS Avg
FROM RATING
GROUP BY MovieID;

UPDATE MOVIE
SET AverageScore = AvgScore.Avg
FROM AvgScore
WHERE MOVIE.MovieID = AvgScore.MovieID;

DROP VIEW AvgScore;

--COMMIT
COMMIT;
