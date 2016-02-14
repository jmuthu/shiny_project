library(shiny)
mean_prices <- read.csv("ubs_food_prices.csv")
cities <- read.csv("ubs_food_data_cities.csv",stringsAsFactors = FALSE)

mean_prices$date <- as.Date(as.character(mean_prices$Year),"%Y")
lmModel <- lm(Avg_Price~Year, data=mean_prices)
food_data <- read.csv("ubs_food_prices_by_cities.csv")
library(lme4)
models <- lmList(Value~as.numeric(Year)|City, data=food_data)

shinyServer(function(input, output) {
  model <- reactive({      
        if (!is.null(input$City) && input$City != 'All') {
            output <-  models[[input$City]]
        } else {
            output <- lmModel
       }
  })
  year <- reactive ({
          if (!is.null(input$City) && input$City != 'All') {
                  yr <- subset(food_data, City %in% c(input$City))$Year
          }else {
                  yr <- mean_prices$Year
          }
  })
  price <- reactive ({
          if (!is.null(input$City) && input$City != 'All') {
                  pr <- subset(food_data, City %in% c(input$City))$Value
          }else {
                  pr <- mean_prices$Avg_Price
          }
  })
  graph_title <- reactive ({
          if (!is.null(input$City) && input$City != 'All') {
                  title <- paste("Food Basket Prices over time for", input$City,"city")
          }else {
                  title <- "World Average Food Basket Prices over time"
          }
  })
  
  p <- reactive(round(predict(model(),new=data.frame(Year=c(as.integer(input$Year)))),2))
        
  output$prediction <- renderPrint({
          cat(paste("Forecasted Food Price : $", p()))
                })
  output$citySelect <- renderUI({
          selectInput('City', 'Select City', c('All',cities$x),  selected ="All")
  })
  output$plot <- renderPlot({
          
          plot(year(), price(), xlab="Year", ylab="Prices ($)", xlim=c(1975,as.numeric(input$Year)+10), 
               ylim=c(100,p()+100), pch = 20, cex = 1.1, main=graph_title())
          abline(model(),col="blue")
          
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
