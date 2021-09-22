# NBA-Free-Agency-Analysis

Hey! Welcome to my project, NBA Free Agency Analysis. Each NBA season, the excitement does not just end after the NBA championship, but the free agency period can seem like a exhilirating playoff run itself. As teams revaluate and retool their rosters, different statistics can drive action for each team depending on their needs. The goal of this project is to analyze NBA game data to uncover insights from the following perspectives:

1) As an NBA Team Owner, I would like to know any given player's average points, rebounds, and assists so that I know who can provide the most excitement to my fans.

![](https://github.com/jason-paulose/NBA-Free-Agency-Analysis/blob/main/Ben%20Simmons.png)
![](https://github.com/jason-paulose/NBA-Free-Agency-Analysis/blob/main/DeMar%20DeRozan.png)

2) As an NBA Team Owner, I would like to know the players' efficiency ratings so that I know who will have the most positive impacts on winning.

![](https://github.com/jason-paulose/NBA-Free-Agency-Analysis/blob/main/Efficiency%20Ratings.png)

3) As an NBA Head Coach, I would like to know last season's players who are well above-average rebounders so that I know who can help my team gain more possessions.

![](https://github.com/jason-paulose/NBA-Free-Agency-Analysis/blob/main/rebounders.png)

4) As an NBA Head Coach, I would like to know the average minimum and maxiumum PPG by position so I know which players tend to have the highest and lowest floors/ceilings for potential.

![](https://github.com/jason-paulose/NBA-Free-Agency-Analysis/blob/main/average%20max%20and%20min.png)

#Process

##Source Data

I found this dataset on Kaggle, downloaded it as a .csv and imported it into SQL Server. Credit for the dataset goes to Nathan Lauga on Kaggle: https://www.kaggle.com/nathanlauga/nba-games

##Data Cleaning

Before analyzing the data, I performed the following operations to work with a cleaner, more relevant dataset. Each line is followed by the main keywords/functions used to accomplish each task.

1) Remove unnecessary columns: used ALTER TABLE and DROP COLUMN
2) Remove null values: used UPDATE, CASE, and COALESCE
3) Clean strings: used UPDATE and CASE
4) Add conditional columns: used ALTER TABLE, ADD, CONCAT


--

Credit for the dataset goes to Nathan Lauga on Kaggle: https://www.kaggle.com/nathanlauga/nba-games

- Aggregate Functions
- Joins
- Subqueries
- Common Table Expressions
- Stored Procedures
- Window Functions
