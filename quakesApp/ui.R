
library(shiny)

shinyUI(fluidPage(
    
    titlePanel("Quakes Map"),

    sidebarLayout(
        sidebarPanel(
            sliderInput("magSlider", "select the minimum and maximum Richter magnitude",
                        4.0, 6.4, value = c(4.0, 5)),
            sliderInput("depthSlider", "select the minimum and maximum depth (km)",
                        40, 680, value = c(50, 250)),
            submitButton("Submit")
        ),

        mainPanel(
            h3("Locations of Earthquakes off Fiji under Selected Magnitude and Depth Range"),
            h5("The data came from 'quakes' base data set under R"),
            leafletOutput("map")
        )
    )
))
