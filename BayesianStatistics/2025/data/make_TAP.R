# Tap 1 -------------------------------------------------------------------



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


# TAP 2 -------------------------------------------------------------------


df <- read.csv("https://raw.githubusercontent.com/DominiqueMakowski/PHQ4R/main/study2/data/data.csv")
df$Interoception <- rowSums(df[grep("IAS_\\d", names(df))])
df <-  filter(df, Gender %in% c("Female", "Male"))


# lm(STAI5_General ~ Age * Gender, data = df) |>
#   parameters::parameters()
#
# plot(estimate_relation(m))


df |>
  dplyr::select(Age, Gender, Anxiety=STAI5_General, Interoception, MoodDisorder, Depression=BDI2_Total) |>
  write.csv("tap2.csv", row.names=FALSE)


# lm(BDI2_Total ~ Interoception * MoodDisorder, data = df) |>
#   parameters::parameters()
#
# plot(estimate_relation(m))

