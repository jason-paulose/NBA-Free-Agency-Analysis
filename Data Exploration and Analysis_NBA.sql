-- how many games were played in the 2020 season?
SELECT FORMAT(COUNT(DISTINCT GAME_ID), 'N0') AS NumberofGames
FROM nba.dbo.gameDetails

-- which players attributed to the most points, assists, and rebounds in a game the 2020 season?
SELECT TOP 1 g.GAME_DATE_EST, gd.PLAYER_NAME AS HighestScoringPlayer, MAX(gd.PTS) AS PointTotal
FROM nba.dbo.gameDetails gd LEFT JOIN nba.dbo.games g ON gd.GAME_ID = g.GAME_ID
WHERE YEAR(g.GAME_DATE_EST) IN (2020,2021)
GROUP BY g.GAME_DATE_EST, gd.PLAYER_NAME
ORDER BY PointTotal DESC

SELECT TOP 1 g.GAME_DATE_EST, gd.PLAYER_NAME AS HighestAssistingPlayer, MAX(gd.AST) AS AssistTotal
FROM nba.dbo.gameDetails gd LEFT JOIN nba.dbo.games g ON gd.GAME_ID = g.GAME_ID
WHERE YEAR(g.GAME_DATE_EST) IN (2020,2021)
GROUP BY g.GAME_DATE_EST, gd.PLAYER_NAME
ORDER BY AssistTotal DESC

SELECT TOP 1 g.GAME_DATE_EST, gd.PLAYER_NAME AS HighestReboundingPlayer, MAX(gd.REB) AS ReboundTotal
FROM nba.dbo.gameDetails gd LEFT JOIN nba.dbo.games g ON gd.GAME_ID = g.GAME_ID
WHERE YEAR(g.GAME_DATE_EST) IN (2020,2021)
GROUP BY g.GAME_DATE_EST, gd.PLAYER_NAME
ORDER BY ReboundTotal DESC

-- Who are the league leaders in efficiency?
SELECT PLAYER_NAME, 
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
