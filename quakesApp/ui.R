
library(shiny)

shinyUI(fluidPage(
    
    titlePanel("Map on 'quakes' Data Set and Build Linear Model"),

    sidebarLayout(
        sidebarPanel(
            sliderInput("magSlider", "select the minimum and maximum Richter magnitude",
                        4.0, 6.4, value = c(4.0, 5)),
            sliderInput("depthSlider", "select the minimum and maximum depth (km)",
                        40, 680, value = c(50, 250)),
            checkboxInput("showline", "Show/Hide linear model", value = TRUE),
            submitButton("Submit"), #submit button
            
            h5("The number of all selected earthquakes is:"),
            textOutput("numberofAll"),
            h5("The linear model shown in the plot:"),
            textOutput("equation")
      
        ),

        mainPanel(
            h3("Locations of Earthquakes off Fiji under Selected Magnitude and Depth Range"),
            h5("The data came from 'quakes' base data set under R"),
            leafletOutput("map"),
            
            #calculation part
            plotOutput("plot1")
            
        )
    )
))
