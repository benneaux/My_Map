### Packages.R
## Contains scripts to install/load all of the required packages.

required_packages <- c("leaflet", "shiny", "dplyr", "ggplot2")
new_packages <- required_packages[!(required_packages %in% installed.packages()[,"Package"])]

load_packages <- function(x) {
  lapply(x,
         FUN = function(x) {
           do.call(
             "require",
             list(x)
           )
         }
  )
}

if (length(new_packages)) {
  install.packages(new_packages)
  load_packages(required_packages)
} else {
  load_packages(required_packages)
}

rm(list = ls())