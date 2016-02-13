
library(shiny)

shinyUI(fluidPage(
       
  
  fluidRow(
          titlePanel("Forecasting Food Basket Prices"),
          p("It is a known fact that food prices steadily increase over time because of various reasons and this application forecasts \
              the food basket prices averaged over world cities using a linear model trained on UBS prices and earnings dataset. \
              More details can be found in 'Training Dataset' tab below"),
          helpText(a("Click here for code hosted on github", target="_blank",    href="https://github.com/jmuthu/shiny_project")),
          wellPanel(
                 tabsetPanel(type = "tabs", 
                             tabPanel("Forecasted Food Price", 
                                      br(),
                                      p ("Choose a year in the future below. Forecasted price is predicted and shown below along \
                                          with the plot that also shows the actual data in the past years and the fitted linear model."),
                                      
                                      selectInput('Year', 'Input Year', c(2016:2050),width="100px"),
                                      tags$b(textOutput("prediction")), 
                                      br(), 
                                      plotOutput("plot")), 
                             tabPanel("Training Dataset", p("The training dataset is obtained from UBS Pricing and Earnings."), 
                                      helpText(a("Click here for more details", target="_blank",    
                                                 href="https://www.ubs.com/microsites/prices-earnings/open-data.html")),
                                      p("The dataset has been downloaded from the above site, converted into a time series data by \
                                         averaging the food prices for each year (table below) recorded since 1976 in intervals of \
                                        3 years."),
                                      p("Only the following 32 cities have data recorded from 1976, so only used those city's prices for \
                                        the average computation."),
                                      wellPanel(textOutput("cities")),
                                      p("Fitted a simple linear model using year as the predictor and average price as the outcome"),
                                      tableOutput("table")
                                     # tableOutput("cities")
                                     ))
                 ))
          

))
