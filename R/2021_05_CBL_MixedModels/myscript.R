# Data Wrangling and plotting
library(dplyr)
library(ggplot2)

# Model fitting
library(lme4)

# Model analysis
library(report)
library(parameters)
library(modelbased)

# Read data
df <- read.csv("https://raw.githubusercontent.com/DominiqueMakowski/teaching/master/R/2021_05_CBL_MixedModels/data.csv")

report(df)

dfsub <- df %>%
  group_by(Participant) %>%
  summarize_all(mean)

dfsub

dfsub$Difficulty_Group <- ifelse(dfsub$Difficulty < mean(dfsub$Difficulty),
                                 "Reported_Easy", "Reported_Hard")



dfsub


model <- aov(RT ~ Difficulty_Group, data = dfsub)
report(model)


model <- lm(RT ~ Difficulty_Group, data = dfsub)
report(model)


model <- lm(RT ~ Difficulty, data = dfsub)
parameters(model)


viz_data <- estimate_relation(model)

p <- ggplot(data = viz_data,  aes(x = Difficulty, y = Predicted)) +
  geom_line() +
  geom_ribbon(aes(ymin = CI_low, ymax = CI_high), alpha = 0.3) +
  geom_point(data = dfsub, aes(x = Difficulty, y = RT, color = Participant))
p




model <- lm(RT ~ Difficulty, data = df)

performance::check_model(model)

performance::check_heteroscedasticity(model)

parameters(model)



model <- lmer(RT ~ Difficulty + (1|Participant), data = df)
parameters(model)



lm(RT ~ 1 + Difficulty, data = df)

model <- lmer(RT ~ Difficulty + Gender + (1 | Participant) + (1| Items), data = df)
parameters(model)


