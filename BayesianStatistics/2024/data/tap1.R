set.seed(1)
df <- data.frame(rt=rgamma(5000, 2.5, 1))
df$conf <- c(rbeta(2500, 0.5, 2) / 2, (rbeta(2500, 2, 0.5) / 2) + 0.5)

write.csv(df, "tap1a.csv", row.names=FALSE)
