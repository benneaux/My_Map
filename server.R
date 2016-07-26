#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

source("Packages.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
   
  map <- leaflet() %>% 
    addTiles()

  output$map <- renderLeaflet(map)
  
  leafletProxy(
    "map",
    data = cleantable
  ) %>%
    
  addMarkers(
    lng = ~lon,
    lat = ~lat
  )
  
  })


