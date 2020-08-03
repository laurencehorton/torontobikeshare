# Check availablility of Toronto Bike Share's close to me.

# packages----
library(jsonlite)
library(dplyr)

# Get data from APIs----
# bike status has information about bike availability
bikestatus <- fromJSON("https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_status")
# bike station has infomation about bike stations (location, etc).
bikestation <- fromJSON("https://tor.publicbikesystem.net/ube/gbfs/v1/en/station_information")
# convert them to dataframes
status <- as.data.frame(bikestatus[["data"]][["stations"]])
station <- as.data.frame(bikestation[["data"]][["stations"]])

#----
# Merge station and status information
bike <- merge(station, status, by="station_id")

# Keep only the stations close to me
# Create geobox boundaries
n <- (43.66731) # north
s <- (43.66312) # south
e <- (-79.3742) # east
w <- (-79.3696) # west

mybike <- bike%>% select("name", "lat", "lon", "num_bikes_available") %>% filter(lat < n & lat > s & lon > e & lon < w)# Keep only name of station and number of bikes available
mybike <- subset(mybike, select = -c(lat,lon) ) # Drop the geocordinates
colnames(mybike)[1] <- "Station"
colnames(mybike)[2] <- "Available"
print(available)

# remove items no longer needed
rm(bike, bikestation, bikestatus, n, s, e, w, station, status)

# Citations----
citation()
citation("dplyr")
citation("jsonlite")
sessionInfo()

