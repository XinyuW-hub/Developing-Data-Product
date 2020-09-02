
library(shiny)
library(leaflet)
library(dplyr)

shinyServer(function(input, output) {
    
    testData <- reactive({
        magMin <- input$magSlider[1]
        magMax <- input$magSlider[2]
        depMin <- input$depthSlider[1]
        depMax <- input$depthSlider[2]
        
        quakes %>% 
            filter(mag > magMin) %>%
            filter(mag < magMax) %>%
            filter(depth > depMin) %>%
            filter(depth < depMax)
    })
    
    output$map <- renderLeaflet({
        #build the Leaflet map
        testData() %>%
            leaflet() %>%
            addTiles() %>%
            addCircleMarkers(stroke = FALSE,
                             fillOpacity = 0.5,
                             radius = ~mag,
                             popup = paste(testData()$stations, "stations reported"))
    })
    
    #calculate the cases
    output$numberofAll <- renderText({
        nrow(testData())
    })
    
    #plot the model
    output$plot1 <- renderPlot({
        plot(testData()$mag, testData()$depth,
             xlab = "Magnitude", ylab = "Depth")
        if (input$showline) {
            abline(lm(depth~mag, testData()), col = "red", lwd = 1.5)
        }
    })
    
    output$equation <- renderText({
        intercept <- round(lm(depth~mag, testData())$coef[1], 3)
        slope <- round(lm(depth~mag, testData())$coef[2], 3)
        paste("Depth = ", slope, "* Mag + (", intercept, ")")
    })
    

})
