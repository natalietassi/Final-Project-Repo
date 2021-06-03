#!/usr/bin/env Rscript

### This is the ui.R file for the Forbes Billionaire data shiny app

## set up

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

data <- read.delim("forbes_billionaires_geo.csv", sep=",")

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
                        these variables differ by location.")) , br(), br(),
           
           ## Data Summary Paragraph
           print(paste0("This dataset includes the top billionaire data of ", nrow(data),
                        " people with ", ncol(data), " columns. Since the data is",
                       " a breakdown of the richest people, there are no outliers,",
                       " since that would make the data incorrect. The data we have",
                       " includes ", tolower(toString(colnames(data)[1:10])), " and ", 
                        tolower(toString(colnames(data)[11])), ".")),
           
           img(src = "money.jpg", width = 1024, height = 512)
           ),
  
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
           )),
  tabPanel("Conclusion/Takeaways",
           titlePanel("Conclusion and Takeaways"),
           
           print("One fascinating pattern was seen in the figure on the Number 
                        of Billionaires per Country tab. As seen in the figure, there were
                        billionaires in 70 different countries in our data. However, when 
                        you set a higher minimum income, the number of countries go way down.
                        The vast majority of the richest on this list were from America. For 
                        example, when the income is set at a $90 billion, 7 of the 8 people
                        live in America. Thus, for entrprenuers looking to get as rich as
                        possible, America has the best track record in the past."), br(),br(),
           
           print("The dataset we used was of reasonable quality. Forbes did the majority of the data collection and Alexander Bader 
           merely cleaned the data into a set and published it on Kaggle. The one change he made was to the self-made section. In Forbes 
           data, the billionaires are given a specific score on a scale of 1-10 of how self-made their fortunes really are. If they 
           inherited it all then the billionaire scores a 10, whereas if they overcame struggles and grew up poor, the billionaire 
           receives a 1. This may cause the data to be biased based on whether or not the billionaire has their struggles in the public eye. 
           Perhaps the billionaire grew up poor and overcame adversity, but the Forbes data collectors do not know about their hardships. 
           They would score the billionaire higher on the self-made scale than what is true. In Bader’s dataset the billionaires were given 
           a simple yes or no to determine if they were self-made. Thus, in using this dataset there was a loss of some information regarding 
           the level of self-made status for each billionaire, creating some ambiguity and room for bias. Aside from this, the dataset does not 
           have harmful effects because it merely documents the wealth of people. Although the wealth itself may be considered harmful, 
           the data presenting the wealth is not."), br(),br(),
           
           
           
           print("In the future we could advance this project by creating more graphs that allow 
                        entrepenuers to enter their life preferences for all catagories and see where the most
                        dense amount of billionaires with similar habits to themselves live. We could also
                        do personalized information for billionaires on representing their wealth and
                        lifestyle choices. We could show the spread of weath (or lack there of) around the world
                        in order for billionaires to see where their money could most impact. In the future we
                        could gear it towards more audiences so everyone knows how their lifestyle habits
                        compare to our billionaires today.")
           )
)
  
