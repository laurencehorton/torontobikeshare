# Check availablility of Toronto Bike Share's close to me.

# packages----
library(jsonlite)

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
mybike <- subset(bike, station_id %in% c("7071", "7042", "7549"))
# Keep only name of station and number of bikes available
available <- subset(mybike, select = c("name", "num_bikes_available"))
print(available)

# remove items no longer needed
rm(bike, bikestation, bikestatus, mybike, station, status)

# Citations----
citation()
citation("jsonlite")
sessionInfo()

