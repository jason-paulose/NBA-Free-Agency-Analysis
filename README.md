# NBA-Free-Agency-Analysis

Hey! Welcome to my project, NBA Free Agency Analysis. 

Each NBA season, the excitement does not just end after the NBA championship, but the free agency period can seem like a exhilirating playoff run itself. As an NBA fan, nothing is more glorious then seeing your favorite team hoist the Larry O'Brien trophy - but pride aside, there is extra incentive for NBA owners, coaches, and players to perform at an elite level. According to Forbes, the average operating income of an NBA team has gone from $6M in 2011 to a whopping $62M in 2020. Most notably, you have seen teams like the Golden State Warriors value grow 1000% since 2009. With the NBA being a multi-billion dollar industry, each team continuing to improve and entertain fans globally will allow even greater financial prosperity for years to come.

With all this in mind, NBA organizations need to methodically grow their rosters in the hopes of being a championship caliber team. As measuring performance is critical to improving performance, many sources have found that the following 5 statistics are proven to have the biggest impact on winning:

- Overall Efficiency Rating
- Effective Field Goal Percentage
- Turnover Ratio
- Offensive Rebounding
- Free Throw Attempt Rate

The purpose of this study is to uncover how players perform in these statistical categories and ultimately who should garner attention for a free agency signing or trade request.

# Process

### Source Data

I found this dataset on Kaggle, downloaded it as a .csv and imported it into SQL Server. Credit for the dataset goes to Nathan Lauga: https://www.kaggle.com/nathanlauga/nba-games

One consideration is that one table only had team data from the 2019 - 2020 NBA season. As a result, the analysis of the statistics above are based on 2019 - 2020 data.

### Data Cleaning

Before analyzing the data, I performed the following operations to work with a cleaner, more relevant dataset. The first part of the script displays cleaning steps that directly impacted my analysis, and the second part contains additional cleaning steps that didn't aid my analysis, but it allowed me to continue practicing common data cleaning steps. The high level tasks I completed are below, followed by the main keywords/functions used to accomplish this part of the project.

- **Remove unnecessary columns:** used ALTER TABLE and DROP COLUMN
- **Remove null values:** used UPDATE, CASE, and COALESCE
- **Clean strings:** used UPDATE and CASE
- **Add conditional columns:** used ALTER TABLE, ADD, CONCAT, CHARINDEX

### Data Exploration

Before uncovering player performance in the four statistical categories, I carried out the data exploration steps below followed by the main keywords/functions.

- **Number of games played in 2019:** FORMAT, COUNT, DISTINCT to aggregate the data
- **Average maximum and average minimum points scored by each position:** used Common Table Expression to aggregate the same data multiple times
- **Full list of players with average points, rebounds, and assists:** used a Stored Procedure to find these statistics for any player in any year since 2004
- **Individual point totals compared to the highest point total for each game:** used Windowing to display both individual and aggregate values in one query
- **Players who played well above average minutes/game:** used a Subquery to use uknown critera of average minutes/game in the WHERE clause

### Data Analysis

Since I was only concerned with 2019-2020 statistics, I created a view from which I ran further queries to uncover insights on the five statistical categories considered for this project. The SQL concepts used in the analysis were very similar to the data exploration section.

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

One major lesson I learned is that data cleaning is an iterative process. I attempted to clean the data as the first step of the development. However, after the data exploration phase, I realized additional cleaning steps I had to perform to support my analysis.

Additionally, I previously spent most of my time in a online course environment, looking at slides and completing basic problems. Like any new developer, I ran into a brick wall when trying to come up with my own project. I combed through different datasets to find something appealing. I had to carve out extra time to understand the most relevant statistics. I was looking at data that was messier than what I had ever seen. I can only guess the number of google searches I had to do after all the errors my queries produced.

However, going through all these challenges was truly a gift. I fell in love with the process of facing an obstacle and working until I  was able to overcome it. Allowing my creativity to lead me through this project has compelled me to take a step back and evaluate this project from it's value proposition to the code development all the way to improvements for the future - looking forward to the next project!

# Sources
-- https://www.forbes.com/sites/chrissmith/2019/12/23/team-of-the-decade-golden-state-warriors-value-up-1000-since-2009/?sh=33245deb480a
-- https://www.visualcapitalist.com/two-decades-of-nba-profit/
-- https://www.nba.com/stats/help/faq/
