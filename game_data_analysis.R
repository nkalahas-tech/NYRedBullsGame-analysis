
# Please complete the following test using the data provided and summarize your thoughts in a Powerpoint Presentation.
# Please attach all code used to creating anything included in your final summary. 

# Question  ###############################################################################################################################################################

# Using the raw match data, tell the 'story of the game', incorporating information on each phase of the game and paying special attention to the Red Bull style of play.

# Library Statements  ###############################################################################################################################################################

library(tidyverse)
library(readr)

# Read in Data  ###############################################################################################################################################################

match_data = read_csv("match_events_for_test.csv")

# Your Code Goes Below!  ###############################################################################################################################################################
# Load the CSV file
match_data <- read.csv("match_events_for_test.csv")

# Explore the data structure
str(match_data)
summary(match_data)


# Segment the game into 15-minute phases
match_data <- match_data %>%
  mutate(match_phase = cut(minute, breaks = seq(0, 90, by = 15), labels = paste(seq(0, 75, by = 15), seq(15, 90, by = 15), sep = "-")))


#FOR VISUAL 1:

#creating the possession summary as we group by period and team
possession_summary <- match_data %>%
  group_by(period, team) %>%
  summarise(total_possessions = n_distinct(possession))

#plotting the total possession summary by team and match period
ggplot(possession_summary, aes(x = as.factor(period), y = total_possessions, fill = team)) +
  geom_bar(stat = "identity", position = "dodge", alpha = 0.8) +
  labs(title = "Total Possessions by Period and Team",
       x = "Match Period",
       y = "Total Number of Possessions",
       fill = "Team") +
  theme_minimal() +
  theme(legend.position = "top",
        legend.title = element_text(size = 12, face = "bold"),
        legend.text = element_text(size = 10))

#FOR VISUALS 2:

turnovers <- match_data %>%
  arrange(period, minute, second) %>%
  mutate(previous_team = lag(team),
         previous_possession = lag(possession)) %>%
  filter(!is.na(previous_team) & previous_team != team & previous_possession != possession)

turnovers_under_pressure <- turnovers %>%
  filter(under_pressure == TRUE)

ggplot(turnovers, aes(x = minute, y = as.factor(period), color = under_pressure)) +
  geom_point(alpha = 0.7) +
  labs(title = "Turnovers During the Match",
       subtitle = "Highlighted Moments Where Possession Was Lost and Regained",
       x = "Minute of the Match",
       y = "Match Period",
       color = "Under Pressure",
       size = "Turnover") +
  scale_color_manual(values = c("red", "blue"),
                     labels = c("No", "Yes"),
                     name = "Under Pressure") +
  theme_minimal() +
  theme(legend.position = "top",
        legend.title = element_text(size = 12, face = "bold"),
        legend.text = element_text(size = 10))


#FOR VISUAL 3:

# Assess Pace of Play
# Calculate the number of events per minute in each match phase to estimate the tempo
pace_of_play <- match_data %>%
  group_by(match_phase) %>%
  summarize(events_per_minute = n() / max(minute))

# Plot Pace of Play
ggplot(pace_of_play, aes(x = match_phase, y = events_per_minute)) +
  geom_line(color = "blue", size = 1.5) +
  geom_point(color = "blue", size = 3) +
  labs(title = "Pace of Play by Match Phase",
       x = "Match Phase (Minutes)",
       y = "Events per Minute") +
  theme_minimal()

#FOR VISUAL 4: 

# Plotting Pass Speed and Transition Speed
# Analyze Pass Speed and Transition Speed
# Calculate pass speed (distance/time) and transition speed (total distance/time) for each pass event
match_data <- match_data %>%
  mutate(pass_length,
         pass_duration = duration,
         pass_speed = pass_length / pass_duration,
         is_transition = ifelse(event_type == "Pass" & (pattern == "From Counter" | pattern == "From Goal Kick"), TRUE, FALSE),
         transition_speed = ifelse(is_transition, pass_speed, NA))

# Calculating average pass speed and transition speed by match phase
pass_speed_analysis <- match_data %>%
  group_by(match_phase) %>%
  summarize(avg_pass_speed = mean(pass_speed, na.rm = TRUE),
            avg_transition_speed = mean(transition_speed, na.rm = TRUE))



ggplot(pass_speed_analysis, aes(x = match_phase)) +
  geom_line(aes(y = avg_pass_speed, color = "Pass Speed"), size = 1.5) +
  geom_line(aes(y = avg_transition_speed, color = "Transition Speed"), size = 1.5, linetype = "dashed") +
  geom_point(aes(y = avg_pass_speed, color = "Pass Speed"), size = 3) +
  geom_point(aes(y = avg_transition_speed, color = "Transition Speed"), size = 3, shape = 17) +
  scale_color_manual(values = c("Pass Speed" = "green", "Transition Speed" = "red")) +
  labs(title = "Pass and Transition Speed by Match Phase",
       x = "Match Phase (Minutes)",
       y = "Speed (units/second)",
       color = "Speed Type") +
  theme_minimal()



# FOR VISUAL 5: SHOT LOCATIONS AND OUTCOMES

ggplot(match_data %>% filter(event_type == "Shot"), aes(x = location_x, y = location_y, color = shot_outcome_name)) +
  geom_point(size = 3) +
  labs(title = "Shot Locations and Outcomes",
       x = "Pitch Length",
       y = "Pitch Width",
       color = "Shot Outcome") +
  theme_minimal()


# FOR VISUAL 6:

# Individual Player Analysis

# Summarize key contributions by player
player_contributions <- match_data %>%
  group_by(db_player_id) %>%
  summarize(
    duels_won = sum(event_type == "Duel" & duel_outcome_name == "Won", na.rm = TRUE),
    goals_scored = sum(event_type == "Shot" & shot_outcome_name == "Goal", na.rm = TRUE)
  )

# Display top performers
top_performers <- player_contributions %>%
  arrange(desc(duels_won)) %>%
  head(10)

print("Top Performers:")
print(top_performers)

ggplot(top_performers, aes(x = reorder(db_player_id, duels_won), y = duels_won)) +
  geom_bar(stat = "identity", fill = "grey") +
  coord_flip() +
  labs(title = "Top Performers by Duels Won",
       x = "Player",
       y = "Duels Won") +
  theme_minimal()

ggplot(top_performers, aes(x = reorder(db_player_id, goals_scored), y = goals_scored)) +
  geom_bar(stat = "identity", fill = "grey") +
  labs(title = "Top Performers by Goals Scored",
       x = "Player",
       y = "Goals Scored") +
  theme_minimal()
