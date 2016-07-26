#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

source("Packages.R")
source("Global.R")

set.seed(100)
cleantable <- cleantable[sample.int(nrow(cleantable), 1000),]

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
   
  
  map = leaflet() %>%
    addProviderTiles(
      "CartoDB.Positron",
      options = providerTileOptions(
        noWrap = TRUE,
        #minZoom = 7,
        unloadInvisibleTiles = TRUE
      )
    )
  
  output$map <- renderLeaflet(map)
  
  observe({
    
    leafletProxy(
      "map",
      data = cleantable
    ) %>%
      
      clearShapes() %>%
      
      addMarkers(
        lat = ~lat,
        lng = ~lon
          
        )
      
  })
  })


