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

# Process

### Source Data

I found this dataset on Kaggle, downloaded it as a .csv and imported it into SQL Server. Credit for the dataset goes to Nathan Lauga on Kaggle: https://www.kaggle.com/nathanlauga/nba-games

### Data Cleaning

Before analyzing the data, I performed the following operations to work with a cleaner, more relevant dataset. Each line is followed by the main keywords/functions used to accomplish each task.

1) Remove unnecessary columns: used ALTER TABLE and DROP COLUMN
2) Remove null values: used UPDATE, CASE, and COALESCE
3) Clean strings: used UPDATE and CASE
4) Add conditional columns: used ALTER TABLE, ADD, CONCAT

### Data Analysis

In order to address the user stories above, I used the following SQL concepts to produce my results.

- Aggregate Functions: primarily used to find an average, as that is a fundamental calculation for statistics in any sport
- Joins: allowed me to get more descriptive information in my results, such as including the name of a team rather than it's ID
- Subqueries: helpful in filtering records in relation to value that is unknown to the analyst, such as the only looking for players with a rebounding average that is well above the league average
- Common Table Expressions: critical in allowing me to aggregate values multiple times, such as finding the average of the max/min points per position
- Stored Procedures: provides a clean way repeat queries with different inputs while making my code reusable
- Window Functions: valuable when looking looking to compare aggregate values to single records in the same view; for example, glossing over the Roster of the Houston Rockets and seeing James Harden's 37 point performance (the max value for that particular game) greatly exceed the point total of any of Rocket is a testament to his ability to single-handedly win a game.

# Reflection

I previously spent most of my time in a online course environment, looking at slides and completing basic problems. Like new developer, I ran into a brick wall when trying to come up with my own project. I combed through different datasets to find something appealing. I found it difficult to come up with relevant user stories. I was looking at data that was messier than what I had ever seen. Not to mention the number of google searches I did every time I executed a query.

However, going through all these challenges was truly a gift. I fell in love with the process of hitting and obstacle and working until I  was able to overcome. Allowing my own creativity to lead me through this project has taught me so much, and I can't wait to continue with project-based learning.
