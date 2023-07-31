# implementation of https://cran.r-project.org/web/packages/spacyr/vignettes/using_spacyr.html
# before running must ml load R/4.2.0 python/3.9.0


#remove.packages("reticulate")
install.packages("reticulate", repos = "http://cran.us.r-project.org")

#BEFORE THIS, MUST:  ml load physics geos/3.11.0 udunits gdal

install.packages("sf", repos = "http://cran.us.r-project.org")
install.packages("rgdal", repos = "http://cran.us.r-project.org")
install.packages("tmaptools", repos = "http://cran.us.r-project.org")
# this could run w/ just tidyverse for the next 3, but compat issues with R on sherlock so loading individually
install.packages("magrittr", repos = "http://cran.us.r-project.org")
install.packages("stringr", repos = "http://cran.us.r-project.org")
install.packages("dplyr", repos = "http://cran.us.r-project.org")
install.packages("spacyr", repos = "http://cran.us.r-project.org")
library(spacyr)
library(sf)
library(rgdal)
library(tmaptools)
library(magrittr)
library(stringr)
library(dplyr)

reticulate::virtualenv_create(envname = 'python_environment', 
                              python= 'python3')
#reticulate::virtualenv_install("python_environment")
reticulate::use_virtualenv("python_environment",required = TRUE)

#use_python("/usr/local/bin/python3")
spacy_initialize(model = "en_core_web_sm")

# code block for ingesting directory of NER inputs
#input_loc <- "/farmshare/learning/data/"
#files <- dir(input_loc, full.names = TRUE)
#text <- c()
#for (f in files) {
#  text <- c(text, paste(readLines(f), collapse = "\n"))
#}

text <- read_csv("/farmshare/learning/data/ner.csv")

parsedtxt <- spacy_parse(text)
#write.csv(parsedtxt, "pos_ner.csv")

onlyPlaces <- parsedtxt %>%
  filter(str_detect(parsedtxt$entity_1_group, "geopolitical area"))
#write out. variable can be changed depending on if you want full dataset, only entities, only places, etc.
#write.csv(parsedtxt, "pos_ner.csv")

# geocoding places subset
places_tmaptools <- geocode_OSM(onlyPlaces$token, details = TRUE, as.data.frame = TRUE)

# extracting from the result only coordinates and query. You can adjust this as needed by inspecting places_tmaptools
places_tmaptools <- places_tmaptools[, c("lat", "lon", "display_name", "query")]

# print the results
user <- Sys.getenv("LOGNAME")
write.csv(places_tmaptools,"/scratch/users/user/outputs/places.csv")
