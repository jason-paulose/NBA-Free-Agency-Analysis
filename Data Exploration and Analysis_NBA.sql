
---------------------------------------------------------------------------------------------
-- Data Exploration
---------------------------------------------------------------------------------------------

-- how many games were played in the 2020 season?
SELECT FORMAT(COUNT(DISTINCT GAME_ID), 'N0') AS [Number of Games In 2019]
FROM nba.dbo.games
WHERE SEASON = 2019


-- what is the average, max and min PTS for each position since 2004?
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
GO


-- return the full list of players with the respective team and average points, rebounds, and assists in 2019
WITH playerSummary AS(
SELECT TEAM_ID,
	   PLAYER_NAME,
	   ROUND(AVG(PTS),1) AS PPG,
	   ROUND(AVG(REB),1) AS RPG,
	   ROUND(AVG(AST),1) AS APG
FROM nba.dbo.gameDetails gd
LEFT JOIN nba.dbo.games g
ON gd.GAME_ID = g.GAME_ID
WHERE g.SEASON = 2019
GROUP BY PLAYER_NAME,
	     TEAM_ID)
SELECT t.CITYNICKNAME AS Team,
	   p.PLAYER_NAME AS Player,
	   p.PPG,
	   p.RPG,
	   p.APG
FROM playerSummary p LEFT JOIN nba.dbo.teams t ON p.TEAM_ID = t.TEAM_ID
ORDER BY Team
GO


-- return the average points, rebounds, and assists for any given player in any season
CREATE PROCEDURE dbo.spgameDetails_getStats
@PLAYER_NAME nvarchar(50),
@SEASON smallint
AS
BEGIN
 	SELECT gd.PLAYER_NAME AS Player,
		   ROUND(AVG(gd.PTS),1) AS PPG,
		   ROUND(AVG(gd.REB),1) AS RPG,
		   ROUND(AVG(gd.AST),1) AS APG
	FROM nba.dbo.gameDetails gd
	LEFT JOIN nba.dbo.games g
	ON gd.GAME_ID = g.GAME_ID
	WHERE g.SEASON = @SEASON
	      AND gd.PLAYER_NAME = @PLAYER_NAME
	GROUP BY gd.PLAYER_NAME
END
GO

EXEC dbo.spgameDetails_getStats @PLAYER_NAME = 'Ben Simmons', @SEASON = 2019
EXEC dbo.spgameDetails_getStats @PLAYER_NAME = 'Demar Derozan', @SEASON = 2018
EXEC dbo.spgameDetails_getStats @PLAYER_NAME = 'Kobe Bryant', @SEASON = 2006


-- what is the maximum number of points scored by each player in each game along with the highest amount of points scored by one player in 2019?
SELECT gd.GAME_ID,
	   gd.TEAM_ABBREVIATION AS Team,
	   gd.PLAYER_NAME AS Player,
	   gd.PTS,
	   MAX(gd.PTS)
OVER(PARTITION BY gd.GAME_ID) as MaxPTS
FROM nba.dbo.gameDetails gd
LEFT JOIN nba.dbo.games g
ON gd.GAME_ID = g.GAME_ID
WHERE g.SEASON = 2019


-- return players whose career minutes/game are 1.5x the league average in the NBA since 2004
SELECT gd.PLAYER_NAME AS Player, AVG(gd.MIN_INT) AS MPG
FROM nba.dbo.gameDetails gd
LEFT JOIN nba.dbo.games g
ON gd.GAME_ID = g.GAME_ID
GROUP BY gd.PLAYER_NAME
HAVING AVG(gd.MIN_INT) > 
	(SELECT 1.5*AVG(MIN_INT)
	FROM nba.dbo.gameDetails)
ORDER BY MPG DESC
GO


---------------------------------------------------------------------------------------------
-- Data Analysis
---------------------------------------------------------------------------------------------

-- Create a view for the remainder of the analysis of 2019 NBA stats
CREATE VIEW view_NBAStats2019 AS
	SELECT COALESCE(gd.GAME_ID, g.GAME_ID) AS GAME_ID
	  ,GAME_DATE_EST
      ,TEAM_ABBREVIATION
      ,PLAYER_NAME
      ,START_POSITION
      ,COMMENT
      ,[MIN]
      ,FGM
      ,FGA
      ,FG_PCT
      ,FG3M
      ,FG3A
      ,FG3_PCT
      ,FTM
      ,FTA
      ,FT_PCT
      ,OREB
      ,DREB
      ,REB
      ,AST
      ,STL
      ,BLK
      ,[TO]
      ,PF
      ,PTS
      ,PLUS_MINUS
  FROM nba.dbo.gameDetails gd
  LEFT JOIN nba.dbo.games g
  ON gd.GAME_ID = g.GAME_ID
  WHERE GAME_DATE_EST BETWEEN '2019-10-22'AND '2020-03-11'
GO


-- Who are the league leaders in efficiency?
SELECT TEAM_ABBREVIATION AS Team,
	   PLAYER_NAME AS Player, 
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
	   SUM(FGA-FGM)*(-0.726))/COUNT(DISTINCT GAME_ID), 2) AS [Efficiency Rating]
FROM view_NBAStats2019
WHERE COMMENT = 'Played'
GROUP BY TEAM_ABBREVIATION, PLAYER_NAME
ORDER BY [Efficiency Rating] DESC


-- who are the league leaders in effective field goal percentage?
SELECT TEAM_ABBREVIATION AS Team,
       PLAYER_NAME AS Player,
	   ROUND(AVG(FGA),1) AS [FGA Per Game],
	   ROUND(AVG(FGM),1) AS [FGM Per Game],
	   ROUND(AVG(FG3M),1) AS [FG3M Per Game],
	   ROUND(((SUM(FGM) + SUM(0.5*FG3M))/SUM(FGA)),1) AS [Effective FG Percentage]
FROM view_NBAStats2019
GROUP BY TEAM_ABBREVIATION, PLAYER_NAME
HAVING AVG(FGA) >= 5
ORDER BY [Effective FG Percentage] DESC, [FGA Per Game] DESC


-- who are the league leaders in Turnover Ratio?
SELECT TEAM_ABBREVIATION AS Team,
       PLAYER_NAME AS Player,
	   ROUND(AVG([TO]),1) AS [TO],
	   ROUND(((SUM([TO])*100)/(SUM([TO])+SUM(AST)+SUM(FGA)+0.44*SUM(FTA))),1) AS [TO%]
FROM view_NBAStats2019
GROUP BY TEAM_ABBREVIATION, PLAYER_NAME
ORDER BY [TO%] ASC


-- who are the league leaders in free throw attempt rate?
SELECT TEAM_ABBREVIATION AS Team,
       PLAYER_NAME AS Player,
	   ROUND(AVG(FTA),1) AS FTA_PG,
	   ROUND(AVG(FGA),1) AS FGA_PG,
	   ROUND((SUM(FTA)/SUM(FGA)),1) AS [Free Throw Attempt Rate]
FROM view_NBAStats2019
GROUP BY TEAM_ABBREVIATION,PLAYER_NAME
HAVING SUM(FTM) >= 125
ORDER BY [Free Throw Attempt Rate] DESC, FTA_PG DESC


-- who are the league leaders in offensive rebounding?
SELECT TEAM_ABBREVIATION AS Team,
       PLAYER_NAME AS Player,
	   ROUND(AVG(OREB),1) AS OREB_PG,
	   ROUND(AVG(DREB),1) AS DREB_PG,
	   ROUND(AVG(REB),1) AS REB_PG
FROM view_NBAStats2019
GROUP BY TEAM_ABBREVIATION,PLAYER_NAME
HAVING COUNT(DISTINCT GAME_ID) >= 50
ORDER BY OREB_PG DESC