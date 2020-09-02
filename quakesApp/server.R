
library(shiny)
library(leaflet)
library(dplyr)

shinyServer(function(input, output) {
    
   
    output$map <- renderLeaflet({
        
        #get the selected mag and depth
        magMin <- input$magSlider[1]
        magMax <- input$magSlider[2]
        depMin <- input$depthSlider[1]
        depMax <- input$depthSlider[2]
        
        #clean data
        data <- quakes %>% 
            filter(mag > magMin) %>%
            filter(mag < magMax) %>%
            filter(depth > depMin) %>%
            filter(depth < depMax)
        
        #build the Leaflet map
        data %>%
            leaflet() %>%
            addTiles() %>%
            addCircleMarkers(popup = paste(data$stations, "stations reported"),
                             stroke = FALSE,
                             fillOpacity = 0.5,
                             radius = ~mag)
    })

})
