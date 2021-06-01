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
           print(paste0("Using the billionaire dataset by Forbes, we have analyzed how billionaires lifestyles 
                        differ in an attempt to provide entrepenuers with motivation to be the next billionaire
                        added to the list. We deepdive into their income specifics, family specifics, and how 
                        these variables differ by location.")),
           
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
    
  ##Tab Panel for Emily's Page
  tabPanel("Average Income of Billionares",
           titlePanel("Average Income of Billionaires Examined"),
           sidebarLayout(
             sidebarPanel(
               radioButtons("incomeChoice", "View Income Grouped By: ", choices = c("Country" = "Country", 
                           "Number of Kids" = "Children", "Self Made vs. Not" = "Self_made"))
             ),
             # Show a plot of the income plot
             mainPanel(
               plotOutput("incomePlot")
             )
           )
           ),
  
  ##Tab Panel for Natalie's Page
  tabPanel("Family Lifestyle of Billionaires",
           titlePanel("Family Lifestyle of Billionaires"),
           sidebarLayout(
             sidebarPanel(
               uiOutput("ageSlider"),
               uiOutput("kidsSlider")),
             mainPanel(
               plotOutput("barNatalie"),
               textOutput("natText")
             )
           ))
)
  
