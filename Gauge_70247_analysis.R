rm(list=ls())  # clear global working environment

setwd("C:/Users/larni/OneDrive - Australian National University/Sem 1 2025-Tampopo/ENGN4901 Water Systems/R working directory/Design-project-1")

# load BoM daily data for guage10017 into data frame [other: parliament_gauge, gardens_gauge]
cap_flat_gauge <- read.csv("70016_Pdaily_1971_2023.csv")


# load relevant packages
library(zoo)
library(ggplot2)

# create character list of the dates in format: YYYY-MM-DD 
date_character = paste(cap_flat_gauge$Year, cap_flat_gauge$Month,cap_flat_gauge$Day, sep="-")
# convert the characters to class: Date
date = as.Date(date_character)
# zoo helps capture the irregular timeseries data into matrix 
rainfall = zoo(cap_flat_gauge$Rainfall.amount..millimetres.,)

#The maximum, sum and average total rainfall at the gauge station from 1971-2023
max(rainfall, na.rm=TRUE)
sum(rainfall, na.rm=TRUE)
mean(rainfall, na.rm=TRUE)

# makes another data frame with just the rows of rainfall measurement >=2days
tagged_accumulations <- subset(cap_flat_gauge, Period.over.which.rainfall.was.measured..days. >= 2)
nrow(tagged_accumulations)

#Total monthly rainfall
as.yearmon(date) # sets date to month+year eg. "Jan 1973" 
monthly_sum = aggregate(rainfall, by=as.yearmon(date), FUN=sum, na.rm=TRUE)
plot(monthly_sum)

#Total annual rainfall
format(as.yearmon(date), "%Y") # sets date to just year
annual_sum = aggregate(rainfall, by=format(as.yearmon(date), "%Y"), FUN=sum, na.rm=TRUE)
plot(annual_sum)

#Average rainfall per month
Month = months.Date(date, abbreviate = TRUE)
Monthly_mean = c() # open a vector to fill
for(i in 1:12)
{
  index = which(Month==month.abb[i]) # the index of the month.abb string that corresponds to Month
  Monthly_mean[i] = mean(coredata(monthly_sum)[index], na.rm=TRUE)  #coredata grabs only values from monthly_sum matrix, strips off index/time attributes
}
paste(month.name, "ave rainfall:", round(Monthly_mean, digits=3), "mm")


#Annual rainfall anomalies (wet and dry years)
anomalies = annual_sum - mean(annual_sum)
plot(anomalies)

#task 5 generating plots for annual total and anomalies
plot(annual_sum)
plot(annual_sum, xlab=c("Year"), ylab=c("Annual Sum"))

#task 6 scaling data by 0.8 
scaled_rainfall = 0.8*rainfall
write.table(scaled_rainfall, "scales.txt")