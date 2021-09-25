# NBA-Free-Agency-Analysis

Hey! Welcome to my project, NBA Free Agency Analysis. 

Each NBA season, the excitement does not just end after the NBA championship, but the free agency period can seem like a exhilirating playoff run itself. As an NBA fan, nothing is more glorious then seeing your favorite team hoist the Larry O'Brien trophy - but pride aside, there is extra incentive for NBA owners, coaches, and players to perform at an elite level. According to Forbes, the average operating income of an NBA team has gone from $6M in 2011 to a whopping $62M in 2020. Most notably, you have seen teams like the Golden State Warriors value grow 1000% since 2009. With the NBA being a multi-billion dollar industry, each team continuing to improve and entertain fans globally will allow even greater financial prosperity for years to come.

With all this in mind, NBA organizations need to methodically grow their rosters in the hopes of being a championship calendar team. As measuring performance is critical to improving performance, many sources have found that the following 4 statistics are proven to have the biggest impact on winning:

- Overall Efficiency Rating
- Effective Field Goal Percentage
- Turnover Ratio
- Offensive Rebounding
- Free Throw Attempt Rate

The purpose of this study is to uncover how players perform in these statistical categories and ultimately who should garner attention for a free agency signing or trade request.

# Process

### Source Data

I found this dataset on Kaggle, downloaded it as a .csv and imported it into SQL Server. Credit for the dataset goes to Nathan Lauga on Kaggle: https://www.kaggle.com/nathanlauga/nba-games

One consideration is that one table only had team data from the 2019 - 2020 NBA season. As a result, the analysis of the statistics above are based on 2019 - 2020 data.

### Data Cleaning

Before analyzing the data, I performed the following operations to work with a cleaner, more relevant dataset. Each line is followed by the main keywords/functions used to accomplish each task.

1) Remove unnecessary columns: used ALTER TABLE and DROP COLUMN
2) Remove null values: used UPDATE, CASE, and COALESCE
3) Clean strings: used UPDATE and CASE
4) Add conditional columns: used ALTER TABLE, ADD, CONCAT

### Data Exploration

Before uncovering player performance in the four statistical categories, I used the following SQL concepts to produce aggregate measures of statistics like points, rebounds, assists, and minutes played.

- Aggregate Functions: primarily used to find an average, as that is a fundamental calculation for statistics in any sport
- Joins: allowed me to get more descriptive information in my results, such as including the name of a team rather than it's ID
- Subqueries: helpful in filtering records in relation to value that is unknown to the analyst, such as the only looking for players with a rebounding average that is well above the league average
- Common Table Expressions: critical in allowing me to aggregate values multiple times, such as finding the average of the max/min points per position
- Stored Procedures: provides a clean way repeat queries with different inputs while making my code reusable
- Window Functions: valuable when looking looking to compare aggregate values to single records in the same view; for example, glossing over the Roster of the Houston Rockets and seeing James Harden's 37 point performance (the max value for that particular game) greatly exceed the point total of any of Rocket is a testament to his ability to single-handedly win a game.

### Data Analysis

- Overall Efficiency Rating

![](https://github.com/jason-paulose/NBA-Free-Agency-Analysis/blob/main/Efficiency%20Ratings.png)

- Effective Field Goal Percentage

![](https://github.com/jason-paulose/NBA-Free-Agency-Analysis/blob/main/effective%20FG%20percentage.png)

- Turnover Ratio

![](https://github.com/jason-paulose/NBA-Free-Agency-Analysis/blob/main/turnover%20ratio.png)

- Offensive Rebounding

![](https://github.com/jason-paulose/NBA-Free-Agency-Analysis/blob/main/offenseive%20rebounding.png)

- Free Throw Attempt Rate

![](https://github.com/jason-paulose/NBA-Free-Agency-Analysis/blob/main/free%20throw%20attempt%20rate.png)

# Reflection

I previously spent most of my time in a online course environment, looking at slides and completing basic problems. Like any new developer, I ran into a brick wall when trying to come up with my own project. I combed through different datasets to find something appealing. I found it difficult to come up with relevant user stories. I was looking at data that was messier than what I had ever seen. Not to mention the number of google searches I did every time one of my queries returned an error.

However, going through all these challenges was truly a gift. I fell in love with the process of hitting and obstacle and working until I  was able to overcome. Allowing my own creativity to lead me through this project has taught me so much, and I can't wait to continue with project-based learning.

# Sources
https://www.forbes.com/sites/chrissmith/2019/12/23/team-of-the-decade-golden-state-warriors-value-up-1000-since-2009/?sh=33245deb480a
https://www.visualcapitalist.com/two-decades-of-nba-profit/
