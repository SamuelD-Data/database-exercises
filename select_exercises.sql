USE albums_db;
DESCRIBE albums;

SELECT * FROM albums WHERE artist = "Pink Floyd";

SELECT release_date FROM albums WHERE name = 'Sgt. Pepper''s Lonely Hearts Club Band';

SELECT genre FROM albums WHERE name = 'Nevermind';

SELECT name FROM albums WHERE release_date BETWEEN 1990 AND 1999;

SELECT name FROM albums WHERE sales < 20;

SELECT name FROM albums WHERE genre = 'Rock';

/*The 'hard rock' and 'progressive rock' genres are not included in the results produced by the statement above because they include the words 'hard' and 'rock'.
The statement is only looking for albums with a genre that is strictly 'Rock'.*/