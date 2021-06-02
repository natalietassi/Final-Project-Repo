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
           print(paste0("In a capitalist country like the United States, wealth plays a large role in policy making and society. 
           As such, it is important to understand how the richest people in the world, like those on the Forbes billionaire list, 
           have made and used their fortunes. This is the purpose of our project. In our study, we seek to answer several questions 
           that entrepreneurs may have regarding billionaires’ lifestyles. For example, how does the average number of kids per billionaire 
           vary based on location and age. Where do billionaires live based on net worth? How does net worth change based on 
           whether or not the billionaire is self-made? All of these questions are relevant to our target audience of entrepreneurs. 
          Using the billionaire dataset created by Alexander Bader from data on Forbes, we have analyzed how billionaires lifestyles 
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
  
