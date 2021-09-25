
---------------------------------------------------------------------------------------------
-- Necessary data cleaning
---------------------------------------------------------------------------------------------

-- Remove unecessary columns
ALTER TABLE nba.dbo.games
DROP COLUMN GAME_STATUS_TEXT,
			HOME_TEAM_WINS

ALTER TABLE nba.dbo.teams
DROP COLUMN LEAGUE_ID,
			MIN_YEAR,
			MAX_YEAR,
			YEARFOUNDED,
			DLEAGUEAFFILIATION


-- assume null values in the comments column means the players were available to play
UPDATE nba.dbo.gameDetails
SET COMMENT = COALESCE(COMMENT, 'Played')


-- Replace abbreviated postion values with full names
UPDATE nba.dbo.gameDetails
SET START_POSITION = 
CASE
	WHEN START_POSITION = 'G' THEN 'Guard'
	WHEN START_POSITION = 'F' THEN 'Forward'
	WHEN START_POSITION = 'C' THEN 'Center'
END

UPDATE nba.dbo.gameDetails
SET TEAM_CITY = 'Los Angeles'
WHERE TEAM_CITY = 'LA'


-- add concatenated column for city name and team name
ALTER TABLE nba.dbo.teams
ADD CITYNICKNAME nvarchar(255)

UPDATE nba.dbo.teams
SET CITYNICKNAME = CONCAT(CITY, SPACE(1), NICKNAME)


-- add columns to get minutes
ALTER TABLE nba.dbo.gameDetails
ADD MIN_INT INT

UPDATE nba.dbo.gameDetails
SET MIN_INT =
CASE 
	WHEN CHARINDEX(':',[MIN]) <> 0 THEN CAST(LEFT(MIN,CHARINDEX(':',[MIN])-1) AS INT)
	ELSE MIN
END

DELETE FROM nba.dbo.gameDetails
WHERE MIN_INT > 48


---------------------------------------------------------------------------------------------
-- Additional cleaning below
---------------------------------------------------------------------------------------------


-- Replace arenas with a capacity of 0/null with the average capacity of all stadiums
UPDATE nba.dbo.teams
SET ARENACAPACITY= 
CASE
	WHEN ARENACAPACITY = 0 THEN (SELECT AVG(CAST(ARENACAPACITY AS INT))FROM nba.dbo.teams)
	WHEN ARENACAPACITY IS NULL THEN (SELECT AVG(CAST(ARENACAPACITY AS INT))FROM nba.dbo.teams)
	ELSE ARENACAPACITY
END


-- replace home/away null values for points, assists, rebounds with the average of those values, respectively
UPDATE nba.dbo.games
SET PTS_home = COALESCE(PTS_home,
	(SELECT AVG(PTS_home)
	 FROM nba.dbo.games))

UPDATE nba.dbo.games
SET AST_home = COALESCE(AST_home,
	(SELECT AVG(AST_home)
	 FROM nba.dbo.games))

UPDATE nba.dbo.games
SET REB_home = COALESCE(REB_home,
	(SELECT AVG(REB_home)
	 FROM nba.dbo.games))

UPDATE nba.dbo.games
SET PTS_away = COALESCE(PTS_away,
	(SELECT AVG(PTS_away)
	 FROM nba.dbo.games))

UPDATE nba.dbo.games
SET AST_away = COALESCE(AST_away,
	(SELECT AVG(AST_away)
	 FROM nba.dbo.games))

UPDATE nba.dbo.games
SET REB_away = COALESCE(REB_away,
	(SELECT AVG(REB_away)
	 FROM nba.dbo.games))

