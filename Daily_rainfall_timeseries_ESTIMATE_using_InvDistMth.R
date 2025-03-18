rm(list=ls()) #clears list of generated data sets in the Environment

cap_flat_gauge <- read.csv("70016_Pdaily_1971_2023.csv")
bot_gardens_gauge <- read.csv("70247_Pdaily_1971_2023.csv")
parliament_gauge <- read.csv("70246_Pdaily_1971_2023.csv")
library(zoo)
date_character = paste(cap_flat_gauge$Year, cap_flat_gauge$Month,cap_flat_gauge$Day, sep="-")
date = as.Date(date_character)
rainfall = zoo(cap_flat_gauge$Rainfall.amount..millimetres.,)

# calculate the distance from gauge i to catchment centroid
df_lat_lon = data.frame(
  Gauge_Name = c("Captains Flat (Foxlow St)", "Parliament House", 
                 "Australian National Botanic Gardens", "Catchment Centroid"),
  Latitude = c(-35.59, -35.31, -35.28, -35.469),
  Longitude = c(149.45, 149.13, 149.11, 149.427)
)

library(geosphere)
# initialise an empty vector to store distances
distance_km = c()
# calculate distance from each gauge to the catchment centroid
for(i in 1:(nrow(df_lat_lon)-1))
{
  distance_km[i] = distm(c(df_lat_lon$Longitude[i], df_lat_lon$Latitude[i]), 
                         c(df_lat_lon$Longitude[4], df_lat_lon$Latitude[4]),
                        fun = distHaversine)/1000
}
print(distance_km)

# initialise empty vectors to store inverse powered distances and weights (b=2 for all)
inv_pwr_distance = c()
weights = c()

for(i in 1:length(distance_km))
{
  inv_pwr_distance[i] = 1/(distance_km[i]^2) #here 2 is the power parameter 
  weights[i] = inv_pwr_distance[i]/sum(inv_pwr_distance)
}
print(inv_pwr_distance)
print (weights)


# estimate rainfall for each day where the data is filled in for each gauge



# make new column of the 
Data_Frame_InvDistMth <- data.frame (
  Rainfall_mm = c("Strength", "Stamina", "Other"),
  Distance_km = distance_km,
  Power_parameter = c(60, 30, 45)
)

Data_Frame_InvDistMth <- 
Weight = c(no., no., no.)
Data_Frame_InvDistMth <- cbind(Data_Frame_InvDistMth, Weight = c())

