if (!file.exists("./ubs-pricesandearnings-opendata-06-10-2015.csv")){
        download.file("https://www.ubs.com/microsites/prices-earnings/open-data/_jcr_content/mainpar/gridcontrol/col2/actionbutton.1407864669.file/bGluay9wYXRoPS9jb250ZW50L2RhbS91YnMvbWljcm9zaXRlcy9wcmljaW5nZWFybmluZ3MvdWJzLXByaWNlc2FuZGVhcm5pbmdzLW9wZW5kYXRhLTA2LTEwLTIwMTUuY3N2/ubs-pricesandearnings-opendata-06-10-2015.csv",
                      "./ubs-pricesandearnings-opendata-06-10-2015.csv", method="wget")
}
ubs_data <- read.csv("./ubs-pricesandearnings-opendata-06-10-2015.csv",sep=";", stringsAsFactors = FALSE)
food_data <- subset(ubs_data, TableTitle == "Food Prices" & !grepl("Index", Heading))

freq <- data.frame(table(food_data$City))
cities <- subset(freq, Freq == 13)$Var1
food_final <- subset(food_data, City %in% cities)
head(food_final)
nrow(food_final)
table(food_final$Year)
plot(food_final$Year, food_final$Value)
mean_prices <- aggregate(list(Avg_Price = as.numeric(food_final$Value)), by = list(Year = food_final$Year), FUN=mean)
#mean_prices$date <- as.Date(mean_prices$Year,"%Y")
#mean_prices$date <- NULL
write.csv(mean_prices,"ubs_food_prices.csv",row.names=FALSE)
#tstrain = ts(mean_prices$Avg_Price)
#library(forecast)
#fit = bats(tstrain)
#fcast = forecast(fit,h=235)