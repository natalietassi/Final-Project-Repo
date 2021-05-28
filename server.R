#!/usr/bin/env Rscript

### This is the sever.R file for the Forbes Billionaire data shiny app

## set up

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

server <- function(input, output) {
  data <- read.delim("./data/forbes_billionaires_geo.csv", sep=",")
  
  sample <- reactive({
    
    barGraphDataHelper <- data %>% 
      filter(NetWorth >= input$n)
    
    barGraphData <- as.data.frame(table(barGraphDataHelper["Country"])) %>%
      rename("Country" = "Var1") %>%
      rename("Billionaires" = "Freq")
    
  })
  
  ## Renders bar graph of billionaire data by country
  output$billionaireGraph <- renderPlotly ({

    barGraph <- plot_ly(
      data = sample(),
      x = ~Country,
      y = ~Billionaires,
      name = "Billionaires by Country",
      type = "bar",
      color = I("blueviolet")
    )
    
    barGraph <- barGraph %>% layout(height = 700)
    
    return(barGraph)
    
  })
  
  ## Renders text saying what how many countries billionaires are from in the graph
  output$numCountries <- renderText({
    numCountries <- sample() %>% nrow()
    paste0("The number of countries in this selection is ", numCountries,
          ". Hover over each bar to see the number of billionaires per country.") 
  })
  
}