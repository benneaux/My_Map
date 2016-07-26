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
cleantable <- as.data.frame(cleantable)
