if (!file.exists("./Desktop/ubs-pricesandearnings-opendata-06-10-2015.csv")){
        download.file("https://www.ubs.com/microsites/prices-earnings/open-data/_jcr_content/mainpar/gridcontrol/col2/actionbutton.1407864669.file/bGluay9wYXRoPS9jb250ZW50L2RhbS91YnMvbWljcm9zaXRlcy9wcmljaW5nZWFybmluZ3MvdWJzLXByaWNlc2FuZGVhcm5pbmdzLW9wZW5kYXRhLTA2LTEwLTIwMTUuY3N2/ubs-pricesandearnings-opendata-06-10-2015.csv",
                      "~/Desktop/ubs-pricesandearnings-opendata-06-10-2015.csv", method="wget")
}
ubs_data <- read.csv("~/Desktop/ubs-pricesandearnings-opendata-06-10-2015.csv",sep=";", stringsAsFactors = FALSE)
# Strip the food data alone with prices recorded as USD. Filter out other indexes. 
food_data <- subset(ubs_data, TableTitle == "Food Prices" & !grepl("Index", Heading))

# Fix the special characters in the following cities
food_data$City <- gsub("Bogot\U3e31653c","Bogota", food_data$City)
food_data$City <- gsub("S\xe3o Paulo","Sao Paulo", food_data$City)

# Only use data for cities that are present in all the 13 years.
freq <- data.frame(table(food_data$City))
cities <- as.character(subset(freq, Freq == 13)$Var1)
food_final <- subset(food_data, City %in% cities)

# Write the data
write.csv(cities,"ubs_food_data_cities.csv",row.names=FALSE)
write.csv(food_final,"ubs_food_prices_by_cities.csv", row.names=FALSE)
# head(food_final)
# nrow(food_final)
# table(food_final$Year)
#plot(food_final$Year, food_final$Value)

# Calculate the average Price for all the cities in each year
mean_prices <- aggregate(list(Avg_Price = as.numeric(food_final$Value)), by = list(Year = food_final$Year), FUN=mean)
write.csv(mean_prices,"ubs_food_prices.csv",row.names=FALSE)

#mean_prices <- rbind(mean_prices, c("2006", NA))
#mean_prices <- mean_prices[with(mean_prices, order(Year)),]
#tstrain <- na.approx(ts(mean_prices$Avg_Price, start=1976, deltat=3))
#library(forecast)
#fit = ets(tstrain)
#fcast = forecast(fit,h=10)

require(rCharts)
nPlot(Value~Year, type = 'lineChart', data = food_final)
ggplot(subset(food_final, Year %in% c("1976", "1985","1994","2003","2012")), aes(x=as.numeric(Value), colour=Year)) + geom_density()
ggplot(food_final, aes(x=as.numeric(Value), colour=Year)) + geom_density(alpha=0.3)
mPlot(x="Year", y = "Value", group="City", data=food_final, type="Line")
mPlot(x="Avg_Price", y = "Year", data=mean_prices, type="Line")


