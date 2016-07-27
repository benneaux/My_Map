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
        minZoom = 6,
        unloadInvisibleTiles = TRUE
      )
    )
  
  output$map <- renderLeaflet(map)
  
  OOSInBounds <- reactive({
    if (is.null(input$map_bounds))
      return(cleantable[FALSE,])
    bounds <- input$map_bounds
    latRng <- range(bounds$north, bounds$south)
    lngRng <- range(bounds$east, bounds$west)
    
    subset(sumtable,
           lat >= latRng[1] & lat <= latRng[2] &
             lon >= lngRng[1] & lon <= lngRng[2])
  })
  
  observe({
    leafletProxy(
      "map",
      data = sumtable
    ) %>%
      
      clearShapes() %>%
      
      addCircleMarkers(
        lat = ~lat,
        lng = ~lon,
        radius = 6,
        weight = 2,
        opacity = 1,
        fillOpacity = 0.8
        
#         clusterOptions = markerClusterOptions(
#           
#           zoomToBoundsOnClick = TRUE,
#           removeOutsideVisibleBounds = TRUE,
#           disableClusteringAtZoom = 10
#           )
        ) %>%
      addPolylines(
        data = hne,
        layerId = "LHD"
      ) %>%
      
      setMaxBounds(
      
        lat1 = map.buffer[4],
        lat2 = map.buffer[2],
        lng1 = map.buffer[3],
        lng2 = map.buffer[1]
      
      ) %>%
      
      fitBounds(
        
        lat1 = map.bounds[4],
        lat2 = map.bounds[2],
        lng1 = map.bounds[3],
        lng2 = map.bounds[1]
        
      )
      
  })
  })


