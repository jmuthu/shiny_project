
library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Average Food prices in world cities"),
  sidebarPanel(
            plotOutput("distPlot")
  ),

  mainPanel(
   numericInput('Year', 'Year', 2016, min = 2016,max = 2100, step = 1),     
   verbatimTextOutput("prediction")
  )

))
