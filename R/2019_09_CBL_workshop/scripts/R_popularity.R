
# CITATION HISTORY --------------------------------------------------------



# This script is based on J. Lindeloev's script here: https://github.com/lindeloev/spss-is-dying

library(rvest)
library(httr)
library(tidyverse)

# Settings
years = 2008:2019

searches = list(
  R = '"R software" OR "R project" OR "r-project.org" OR "R development core" "r function" OR "R language" OR "R statistical" OR "r package" OR "mass package" OR "plyr package" OR "mvtnorm" OR "bioconductor" OR "lme4" OR "nlme" OR "lmeR function" OR "ggplot2" OR "Hmisc" OR "tidyverse"',
  SPSS = 'SPSS -"SPSS Modeler" -"Amos"',
  SAS = '"SAS Institute" -JMP -"Enterprise Miner"',
  STATISTICA = '"STATISTICA" OR "StatSoft"',
  STATA = '("stata" "college station") OR "StataCorp" OR "Stata Corp" OR "Stata Journal" OR "Stata Press" OR "stata command" OR "stata module"'
)



# Utility Functions
# -----------------

# Build the URL string
get_url = function(software, year) {
  url_prefix = gsub('9999', as.character(year), 'https://scholar.google.dk/scholar?hl=en&as_sdt=0%2C5&as_ylo=9999&as_yhi=9999&q=')  # Enter year
  url_search = gsub(' ', '+', searches[[software]])  # Escape spaces
  url_search = gsub('\"', '%22', url_search)  # Escape quotes
  url = paste(url_prefix, url_search, sep='')
  url
}

# Do the web search
get_html = function(url) {
  html = read_html(url)
  #html = content(GET(url))
  html
}

extract_citations = function(html) {
  # Extract the citation number
  hits_strings = html %>%
    html_nodes(css='.gs_ab_mdw') %>%  # Name of the class where we can find citation number
    html_text()
  hits_string = strsplit(hits_strings[2], ' ')[[1]][2]  # Second hit, second "word"
  hits_numeric = as.numeric(gsub(',', '', hits_string))  # As numeric, not string
  hits_numeric
}

get_citations = function(software, year) {
  # Sleep to prevent HTTP error 503
  sleep_duration = runif(1, 10, 20)  # Uniformly break between searches in this interval to prevent scholar from rejecting searches
  Sys.sleep(sleep_duration)

  # Do the search
  url = get_url(software, year)
  html = get_html(url)
  citations =  extract_citations(html)

  # Status and return
  print(sprintf('Got %i scholar citations in %i for %s', citations, year, software))
  citations
}



# Get data
# --------------
data = expand.grid(years, names(searches))
names(data) = c('Year', 'Software')
data$Citations <- NA

# Run multiple times if need be
for(i in 1:nrow(data)){
  if(is.na(data[i, "Citations"])){
    data[i, "Citations"] <- get_citations(data[i, "Software"], data[i, "Year"])
  }
}



# Save it so you don't have to repeat in case Scholar locks you out
write.csv(data, 'citations.csv', row.names = FALSE)
