-- how many games were played in the 2019 season?
SELECT FORMAT(COUNT(DISTINCT GAME_ID), 'N0') AS NumberofGames
FROM nba.dbo.games
WHERE YEAR(GAME_DATE_EST) = '2019'


-- maximum number of points scored by each player in each game along with the Highest amount of points scored by one player
SELECT gd.GAME_ID,
       gd.TEAM_ABBREVIATION,
       gd.PLAYER_NAME, gd.PTS,
       MAX(gd.PTS)
OVER(PARTITION BY gd.GAME_ID) as MaxPTS
FROM nba.dbo.gameDetails gd
LEFT JOIN nba.dbo.games g
ON gd.GAME_ID = g.GAME_ID
WHERE YEAR(GAME_DATE_EST) = '2019'


-- find the average max and min PTS for each position
WITH avgMaxandMin AS(
SELECT PLAYER_NAME,
       START_POSITION,
       MIN(PTS) AS MinPTS,
       MAX(PTS) AS MaxPTS
FROM nba.dbo.gameDetails
GROUP BY PLAYER_NAME, START_POSITION)
SELECT START_POSITION AS Position,
       ROUND(AVG(MinPTS),1) AS AvgMinPTS,
       ROUND(AVG(MaxPTS),1) AS AvgMaxPTS
FROM avgMaxandMin
WHERE START_POSITION IN ('Guard','Forward','Center')
GROUP BY START_POSITION


-- which players attributed to the most points and assists in a game in the 2019 season?
SELECT TOP 1 g.GAME_DATE_EST,
             gd.PLAYER_NAME AS HighestScoringPlayer,
	     MAX(gd.PTS) AS PointTotal
FROM nba.dbo.gameDetails gd
LEFT JOIN nba.dbo.games g
ON gd.GAME_ID = g.GAME_ID
WHERE YEAR(g.GAME_DATE_EST) = '2019'
GROUP BY g.GAME_DATE_EST,
         gd.PLAYER_NAME
ORDER BY PointTotal DESC

SELECT TOP 1 g.GAME_DATE_EST,
             gd.PLAYER_NAME AS HighestAssistingPlayer,
	     MAX(gd.AST) AS AssistTotal
FROM nba.dbo.gameDetails gd
LEFT JOIN nba.dbo.games g
ON gd.GAME_ID = g.GAME_ID
WHERE YEAR(g.GAME_DATE_EST) = '2019'
GROUP BY g.GAME_DATE_EST,
         gd.PLAYER_NAME
ORDER BY AssistTotal DESC


-- Full list of players with the respective team and average points, rebounds, and assists in 2019
WITH playerSummary AS(
SELECT TEAM_ID,
       PLAYER_NAME,
       ROUND(AVG(PTS),1) AS PPG,
       ROUND(AVG(REB),1) AS RPG,
       ROUND(AVG(AST),1) AS APG
FROM nba.dbo.gameDetails gd
LEFT JOIN nba.dbo.games g
ON gd.GAME_ID = g.GAME_ID
WHERE YEAR(g.GAME_DATE_EST) = '2019'
GROUP BY PLAYER_NAME,
	 TEAM_ID)
SELECT t.CITYNICKNAME AS TEAM,
       p.PLAYER_NAME AS Player,
       p.PPG,
       p.RPG,
       p.APG
FROM playerSummary p
LEFT JOIN nba.dbo.teams t
ON p.TEAM_ID = t.TEAM_ID
ORDER BY 1
GO


-- return the average points, rebounds, and assists for any given player in any season
CREATE PROCEDURE dbo.spgameDetails_getStats
@PLAYER_NAME nvarchar(50)
AS
BEGIN
 	SELECT gd.PLAYER_NAME AS Player,
	       ROUND(AVG(gd.PTS),1) AS PPG,
	       ROUND(AVG(gd.REB),1) AS RPG,
	       ROUND(AVG(gd.AST),1) AS APG
	FROM nba.dbo.gameDetails gd
	LEFT JOIN nba.dbo.games g
	ON gd.GAME_ID = g.GAME_ID
	WHERE YEAR(g.GAME_DATE_EST) IN (2019) AND
	      gd.PLAYER_NAME = @PLAYER_NAME
	GROUP BY gd.PLAYER_NAME
END
GO

EXEC dbo.spgameDetails_getStats @PLAYER_NAME = 'Lebron James'
EXEC dbo.spgameDetails_getStats @PLAYER_NAME = 'Trae Young'
EXEC dbo.spgameDetails_getStats @PLAYER_NAME = 'Luka Doncic'


-- return 2019 players whose rebounding averages are double the league average in the NBA since 2004
SELECT gd.PLAYER_NAME AS Player,
       ROUND(AVG(gd.REB),1) AS RPG
FROM nba.dbo.gameDetails gd
LEFT JOIN nba.dbo.games g
ON gd.GAME_ID = g.GAME_ID
WHERE YEAR(g.GAME_DATE_EST) = '2019'
GROUP BY PLAYER_NAME
HAVING (AVG(REB)) >
       (SELECT AVG(REB)*2
        FROM nba.dbo.gameDetails)
ORDER BY 2 DESC


-- Who are the league leaders in efficiency?
SELECT PLAYER_NAME AS Player,
       ROUND((SUM(FGM)*1.591+
       SUM(STL)*0.998+
       SUM(FG3M)*0.958+
       SUM(FTM)*0.868+
       SUM(BLK)*0.726+
       SUM(OREB)*0.726+
       SUM(AST)*0.642+
       SUM(DREB)*0.272+
       SUM([TO])*(-0.998)+
       SUM(FTA-FTM)*(-0.372)+
       SUM(FGA-FGM)*(-0.726))/COUNT(DISTINCT GAME_ID), 2) AS EfficiencyRating
FROM nba.dbo.gameDetails
WHERE COMMENT = 'Played'
GROUP BY PLAYER_NAME
ORDER BY EfficiencyRating DESC
