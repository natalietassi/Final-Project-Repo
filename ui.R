#!/usr/bin/env Rscript

### This is the ui.R file for the Forbes Billionaire data shiny app

## set up

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

data <- read.delim("./data/forbes_billionaires_geo.csv", sep=",")

ui <- navbarPage("Forbes Billionaires",
  tabPanel("Introduction and Summary", 
           
           
           #### Put introduction paragraph here
           
           ## Data Summary Paragraph
           print(paste0("This dataset includes the top billionaire data of ", nrow(data),
                        " people with ", ncol(data), " columns. Since the data is",
                       " a breakdown of the richest people, there are no outliers,",
                       " since that would make the data incorrect. The data we have",
                       " includes ", tolower(toString(colnames(data)[1:10])), " and ", 
                        tolower(toString(colnames(data)[11])), "."))),
  
  ## Billionaires by Country Bar Graph
  tabPanel("Number of Billionaires per Country",
           titlePanel("Number of Billionaires per Country"),
            sidebarLayout(
              sidebarPanel(
                sliderInput(input = "n", "Income Minimum (in Billions USD)", min = 1, max = 177, value = 40), 
                textOutput("numCountries")),
                mainPanel(plotlyOutput("billionaireGraph"))
            )),
    
  ## FIll in your tabs here, see mine above for an example
  tabPanel("Emily Tab -- change name"),
  tabPanel("Natalie Tab -- change name")
)
  
