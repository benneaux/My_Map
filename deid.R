### Generate sequential study ID numbers
library(RODBC)
library(dplyr)
library(magrittr)

ch <- odbcConnect("SHIPHNE")

data <- sqlQuery(ch, paste('SELECT "URNO", "City" FROM "tblClient"',
                            'WHERE "City" Is Not NULL'))
data <- data %>% mutate(ID = URNO, URNO = NULL)


data.temp1 <- data[order(data$ID),]

data.temp1$DE_ID <- as.integer(
  unclass(
    factor(data.temp1$ID)
    )
  )

### Generate random study ID numbers

set.seed(1)
DE_ID <- data.frame(
  DE_ID=sample(
    1:length(
      unique(data.temp1$ID)
      ),
    replace = FALSE
    ), 
  ID = unique(data.temp1$ID)
  )

hds_temp1_ran <- merge(
  DE_ID,
  data.temp1,
  by = "ID",
  all = TRUE
  )

### Drop non-DE_ID fields

deid.data <- select(
  hds_temp1_ran,
  -ID,
  -DE_ID.y,
  ID = DE_ID.x
)

### Shift Dates
hds_temp2 <- transform(
  hds_temp1,
  Centered_TESTDATE=TESTDATE-DOB,
  Centered_DOD=DOD-DOB
  )


### De-identified Data-set
De_ID <- subset(
  hds_temp2, select=c(
    STUDY_ID,
    PSA,
    Age_TESTDATE,
    Age_DOD
    )
  ) 