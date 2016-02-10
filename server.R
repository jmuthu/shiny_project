library(shiny)
mean_prices <- read.csv("ubs_food_prices.csv")
mean_prices$date <- as.Date(as.character(mean_prices$Year),"%Y")
lmModel <- lm(Avg_Price~Year, data=mean_prices)

shinyServer(function(input, output) {
  output$prediction <- renderPrint({
          cat(paste("Prediction for Average Food Price :", round(lmModel$coefficients[1]+lmModel$coefficients[2]*as.integer(input$Year),2)))
                })
  output$distPlot <- renderPlot({
          plot(mean_prices$Year, mean_prices$Avg_Price, xlab="Year", ylab="Average Prices($)")
          abline(lmModel)
  })

})
