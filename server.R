library(shiny)
mean_prices <- read.csv("ubs_food_prices.csv")
cities <- read.csv("ubs_food_data_cities.csv",stringsAsFactors = FALSE)

mean_prices$date <- as.Date(as.character(mean_prices$Year),"%Y")
lmModel <- lm(Avg_Price~Year, data=mean_prices)
shinyServer(function(input, output) {
        p <- reactive({round(predict(lmModel,new=data.frame(Year=c(as.integer(input$Year)))),2)})
  output$prediction <- renderPrint({
          cat(paste("Forecasted Average Food Price for", input$Year,"year : $", p()))
                })
  output$plot <- renderPlot({
  
          plot(mean_prices$Year, mean_prices$Avg_Price, xlab="Year", ylab="Average Prices ($)", xlim=c(1975,2060), 
               ylim=c(180,900), pch = 20, cex = 1.1, main="Average food basket prices over time")
          abline(lmModel,col="blue")
          
          points(input$Year, p(), pch = 19, col="red")
          text(input$Year, p(), labels=c(p()),pos=4, col="red", cex=1.1)
          legend("bottomright",c("Actual data", "Forecasted Value", "Linear model"), col=c("black","red","blue"), 
                 pch=c(20,19,NA), lty=c(NA,NA,1), bg = "gray90")
  })
  output$table <- renderTable({
          data.frame(Year = mean_prices$Year, "Average Food Prices ($)"= mean_prices$Avg_Price, check.names = F)
  })
  
  #output$cities <- renderTable({data.frame(City=cities$x)})
  output$cities <- renderText({paste(cities$x, collapse=", ")})
})
