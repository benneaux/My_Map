### Global.R
source("Packages.R")

deid <- readRDS(file = "Data/deid.rds")
postcodes <- readRDS(file = "Data/allpostcodes.rds")

levels(deid[["City"]]) <- tolower(levels(deid[["City"]]))

  cleanpostcodes <- postcodes %>%
  group_by(suburb) %>%
  top_n(1)
  
cleanpostcodes$suburb <- tolower(cleanpostcodes$suburb)

cleantable <-  dplyr::left_join(deid, cleanpostcodes, by = c("City" = "suburb"))
cleantable <- na.omit(cleantable)

hne <- readOGR("LHDMapfiles/HNELHD only.shp", layer = "HNELHD only", verbose = FALSE)

map.bounds <- c(gBoundary(hne)@bbox)

map.buffer <- c(gBuffer(hne)@bbox)