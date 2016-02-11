
library(shiny)

shinyUI(fluidPage(
       
  
  fluidRow(
          titlePanel("World Average Food Basket Prices"),
          p ("This application predicts the average food basket prices from various cities in the world using a linear model trained on UBS prices and earnings dataset."),
          p ("Choose a year in future below to predict the prices"),
          column(3,wellPanel(
                 selectInput('Year', 'Input Year', c(2016:2050)))),
          column(8,wellPanel(
                 h4(textOutput("prediction")),
                 tabsetPanel(type = "tabs", 
                             tabPanel("Plot", plotOutput("plot")), 
                             tabPanel("Training Dataset", p("The training dataset is obtained from UBS Pricing and Earnings."), 
                                      helpText(a("Click here for more details", target="_blank",    href="https://www.ubs.com/microsites/prices-earnings/open-data.html")),
                                      p("The dataset has been downloaded from the above site and the food prices have been averaged for each year (table below) recorded since 1976 in intervals of 3 years."),
                                      p("Only 32 cities have data recorded from 1976, so only used those city's prices for the average computation."),
                                      p("Fitted a simple linear model using year as the predictor and average price as the outcome"),
                                      tableOutput("table"),
                                      tableOutput("cities")))
                 ))
          )

))
