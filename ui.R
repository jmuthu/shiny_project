
library(shiny)

shinyUI(fluidPage(
        titlePanel("Forecasting Food Basket Prices"),
        p("It is a known fact that food prices steadily increase over time because of various reasons and this application forecasts \
              the food basket prices over popular world cities using a linear model trained on UBS prices and earnings dataset. \
              More details can be found in 'More Details' tab below"),
        helpText(a("Click here for code hosted on github", target="_blank",    href="https://github.com/jmuthu/shiny_project")),
        tabsetPanel(type = "tabs", 
                        tabPanel("Forecast Food Basket Price", 
                                br(),
                                p ("For forecasting, choose a future year and also a city (or all) below."),
                                p ("Forecasted price is \
                                   shown below along with a plot which shows the actual data in the past years and the fitted linear model."),
                                wellPanel(fluidRow(
                                   column(4, selectInput('Year', 'Select Year', c(2016:2050),width="100px"), uiOutput("citySelect")),
                                   column(5,h4(textOutput("prediction")),plotOutput("plot",width="600px",height="500px")) 
                                ))), 
                                tabPanel("More Details", 
                                    p("This application uses linear models trained on actual data collected from various cities since 1976 by UBS. \
                                    So the prediction on prices is a fair estimate as the model fits very well. UBS has published all the collected Pricing and Earnings data."), 
                                    helpText(a("Click here for more details", target="_blank",    
                                    href="https://www.ubs.com/microsites/prices-earnings/open-data.html")),
                                    p("The dataset has been downloaded from the above site and converted into a time series data. \
                                        The data contains various cost/prices but only food prices were used for this application. \ 
                                       Only 32 cities have data recorded from 1976, so those city's prices were used for the model training."),
                                    p("Food prices averaged over 32 cities for years recorded since 1976 (in intervals of \
                                       3 years) is shown below."),
                                   # wellPanel(textOutput("cities")),
                                    tableOutput("table")
                             ))
))
          


