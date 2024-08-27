## Project Overview

This project is designed to analyze and summarize the story of a soccer game, specifically focusing on the New York Red Bulls' playing style. The analysis is divided into different phases of the game, providing insights into possession, turnovers, pace of play, pass and transition speed, shot locations, and individual player contributions. The findings are summarized in a PowerPoint presentation.

## Data

The raw match data is provided in the file `match_events_for_test.csv`. This dataset contains event-level information for each minute of the game, including details on possession, turnovers, shots, and player actions.

## Libraries Required

This analysis utilizes the following R libraries:
- `tidyverse`: For data manipulation and visualization
- `readr`: For reading CSV files

Ensure that these libraries are installed in your R environment before running the code.

```r
install.packages("tidyverse")
install.packages("readr")
```

## Data Loading

The data is loaded using the `read.csv` function. Ensure that the file path is correctly set to where your data is located.

```r
# Load the CSV file
match_data <- read.csv("~/Downloads/NY Red Bulls Game Analysis/match_events_for_test.csv")
```

## Analysis and Visualization

### 1. **Possession Analysis**
   - The analysis focuses on summarizing possession by period and team.
   - The possession data is visualized using a bar plot to show the total number of possessions by team and period.

### 2. **Turnovers Analysis**
   - Turnovers, especially those under pressure, are analyzed and visualized.
   - The plot highlights moments where possession was lost and regained during the match.

### 3. **Tempo and Rhythm**
   - The pace of play is assessed by analyzing the number of events per minute in each match phase.
   - Pass and transition speeds are analyzed to understand how quickly the ball was moved up the field during transitions.

### 4. **Shot Locations and Outcomes**
   - Shot locations and their outcomes (goal, on target, off target) are visualized on a pitch diagram.

### 5. **Individual Player Contributions**
   - Key contributions by players, such as duels won and goals scored, are summarized.
   - The top performers are visualized based on their contributions to the game.

## PowerPoint Presentation

The findings and visualizations from the analysis are compiled into a PowerPoint presentation titled "My Story of the Game." This presentation provides a narrative of the game, emphasizing the Red Bull style of play and key moments in the match. The presentation includes the following sections:

- **Possession Analysis**
- **Turnovers**
- **Tempo and Rhythm**
- **Shot Locations and Outcomes**
- **Player Contributions**
- **Conclusion**

## Code

All the code used for the analysis and visualization is included in the R script within this README file. Ensure that the script is executed in the order provided to reproduce the results.

## Conclusion

The analysis highlights the New York Red Bulls' strengths in possession, tempo control, and individual player contributions, while also pointing out areas for improvement, particularly in maintaining intensity throughout the game. The insights gained from this analysis can be used to refine strategies and improve performance in future games.

---

## Contact

For any questions or further information, please contact me at nkalahasti2002@gmail.com.
