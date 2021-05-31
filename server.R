#!/usr/bin/env Rscript

### This is the sever.R file for the Forbes Billionaire data shiny app

## set up

library(shiny)
library(dplyr)
library(ggplot2)
library(plotly)

#Data Table for Average Number of Kids
averageKids <- data %>% 
  group_by(Country) %>% 
  mutate(avgKids = mean(Children, na.rm = TRUE)) %>% 
  mutate(avgAge = mean(Age, na.rm = TRUE))

#Data Table for Average Age
agesOnly <- data %>% 
  group_by(Country) %>% 
  summarize(avgAge = mean(Age, na.rm = TRUE)) %>% 
  select(Country, avgAge)

#Data Table for Average Number of Kids
kidsOnly <- data %>% 
  group_by(Country) %>% 
  summarize(avgKids = mean(Children, na.rm = TRUE)) %>% 
  select(Country, avgKids)

#Data Table of Average Kids and Average Age
age_kid_Only <- left_join(agesOnly, kidsOnly, by=c("Country" = "Country"))

#Data Table of Average Net Worth
networthOnly <- data %>% 
  group_by(Country) %>% 
  summarize(avgNet = mean(NetWorth, na.rm = TRUE)) %>% 
  select(Country, avgNet)

#Data Table for Natalie's Tab
natGraphdata <- left_join(age_kid_Only, networthOnly, by=c("Country" = "Country"))

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
  #Function for Natalie's Tab
  usedata <- reactive({
    if(is.null(input$g)) {
      natGraphdata
    } else{
      natGraphdata %>% 
        filter(avgKids <= input$g) %>% 
        filter(avgAge <= input$j)
    }
  })
  
  #output Natalie's Graph
  output$barNatalie <- renderPlot ({
    ggplot(usedata(), aes(Country, avgNet)) +
      geom_bar(stat = "identity", fill = "steelblue") +
      labs(
        x="Country",
        y="Average Net Worth per Billionaire"
      ) +
      theme(axis.text.x = element_text(angle=90))
  })
  
  # Function for Emily's data to filter down the input based on what radio buttons were chosen
  emIncomeData <- reactive ({
    if(input$incomeChoice == "Country"){
      data %>%
        select(Country, NetWorth) %>%
        group_by(Country) %>%
        summarise(mean_networth = mean(NetWorth, na.rm = TRUE))
      
    } else if (input$incomeChoice == "Children") {
      data %>%
        select(Children, NetWorth) %>%
        group_by(Children) %>%
        summarise(mean_networth = mean(NetWorth, na.rm = TRUE))
    } else {
      data %>%
        select(Self_made, NetWorth) %>%
        group_by(Self_made) %>%
        summarise(mean_networth = mean(NetWorth, na.rm = TRUE))
    }
    
  })
  
  # Output Emily's Graph
  output$incomePlot <- renderPlot({
    if(input$incomeChoice == "Country") {
      ggplot(emIncomeData(), aes(x = Country, y = mean_networth)) +
        geom_bar(stat = "identity", aes(fill = Country)) +
        labs(title = "Average Income by Choice", y = "Average Income by Billions")
    } else if (input$incomeChoice == "Children"){
      ggplot(emIncomeData(), aes(x = Children, y = mean_networth)) +
        geom_bar(stat = "identity", aes(fill = Children)) +
        labs(title = "Average Income by Choice", y = "Average Income by Billions")
    } else {
      ggplot(emIncomeData(), aes(x = Self_made, y = mean_networth)) +
        geom_bar(stat = "identity", aes(fill = Self_made)) +
        labs(title = "Average Income by Choice", y = "Average Income by Billions")
    }
    
    
  })
}




