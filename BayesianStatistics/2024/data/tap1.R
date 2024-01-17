set.seed(1)
df <- data.frame(rt=rgamma(5000, 2.5, 1))
df$confidence <- c(rbeta(2500, 0.5, 2) / 2, (rbeta(2500, 2, 0.5) / 2) + 0.5)

write.csv(df, "tap1a.csv", row.names=FALSE)

set.seed(2)
df <- data.frame(reading_time=rgamma(5000, 2.5, 1))
df$certainty <- c(rbeta(2500, 0.5, 2) / 2, (rbeta(2500, 2, 0.5) / 2) + 0.5)

write.csv(df, "tap1a_resit.csv", row.names=FALSE)
