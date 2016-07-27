### Global.R
source("Packages.R")

deid <- readRDS(file = "Data/deid.rds")
postcodes <- readRDS(file = "Data/allpostcodes.rds")

  levels(deid[["suburb"]]) <- tolower(levels(deid[["suburb"]]))

  cleanpostcodes <- postcodes %>%
  group_by(suburb) %>%
  top_n(1)
  
  cleanpostcodes$suburb <- tolower(cleanpostcodes$suburb)

cleantable <-  dplyr::left_join(deid, cleanpostcodes, by = "suburb")
cleantable <- na.omit(cleantable)
# cleantable$lat <- jitter(cleantable$lat)
# cleantable$lon <- jitter(cleantable$lon)

sumtable <- cleantable %>%
  group_by(suburb, NoServices, lat, lon) %>%
  tidyr::nest() %>%
  group_by(suburb) %>%
  mutate(sumofservices = sum(NoServices)) %>%
  group_by(suburb, sumofservices, lat, lon) %>%
  tidyr::nest()


hne <- readOGR("LHDMapfiles/HNELHD only.shp", layer = "HNELHD only", verbose = FALSE)

map.bounds <- c(gBoundary(hne)@bbox)

map.buffer <- c(gBuffer(hne)@bbox)
