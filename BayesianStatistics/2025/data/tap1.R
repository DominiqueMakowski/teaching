set.seed(5)
df <- data.frame(rt=rgamma(5000, 2, 1))
df$confidence <- c(rbeta(2500, 0.5, 2) / 2, (rbeta(2500, 2, 0.5) / 2) + 0.5)

plot(bayestestR::estimate_density(df$rt))

# write.csv(df, "tap1a.csv", row.names=FALSE)
write.csv(df, "tap1a_resit.csv", row.names=FALSE)

set.seed(6)
df <- data.frame(reading_time=rgamma(5000, 3, 1))*2
df$certainty <- c(rbeta(2500, 0.5, 2) / 2, (rbeta(2500, 2, 0.5) / 2) + 0.5)

plot(bayestestR::estimate_density(df$reading_time))

write.csv(df, "tap1a.csv", row.names=FALSE)
# write.csv(df, "tap1a_resit.csv", row.names=FALSE)
