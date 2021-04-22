# Package Installation ----------------------------------------------------

# Run the installation lines below (select them, and press CTLR + ENTER to run)

# NOTE: There might be some messages pop-ups appearing about whether to restart the console,
# Just answer "no" (or "yes", it doesn't really matter) and let it install

# NOTE: It might ask (in the console) whether to update only from source or something like that,
# and waiting for your to enter a response. Just press ENTER and let it finish


# Download and install
install.packages(c("remotes", "dplyr", "ggplot2", "lme4", "parameters", "modelbased", "report"))

# Update from github
remotes::install_github("easystats/modelbased")
remotes::install_github("easystats/report")

# ==============================================================================


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

# ==============================================================================



