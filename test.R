library(RODBC)
ch <- odbcConnect("SHIPHNE")
#res <- sqlFetch(ch, "tblClient")
#query <- sqlQuery(ch, paste('SELECT "URNO", "City" FROM "tblClient"',
                            'WHERE "City" Is Not NULL'))

query4 <- sqlQuery(
  ch,
  paste(
'SELECT 
  dbo.tblClient.ID, 
  dbo.tblCodeClinic.Clinic, 
  dbo.tblCodeCountries.Country, 
  dbo.tblCodeIndigenous.Indigenous,
  dbo.tblClient.City AS suburb,
  dbo.tblClient.Postcode, 
  dbo.tblClient.Sex,
  COUNT(derivedtbl_1.URNO) AS NoServices',

'FROM  
  dbo.tblClient, 
  dbo.tblCodeClinic, 
  dbo.tblCodeCountries, 
  dbo.tblCodeIndigenous,
    (SELECT URNO FROM dbo.tblServiceActivities) derivedtbl_1',

'WHERE 
  dbo.tblClient.Clinic = dbo.tblCodeClinic.ClinicNumber 
  AND dbo.tblClient.CountryOfBirth = dbo.tblCodeCountries.CountryCode 
  AND dbo.tblClient.Indigenous = dbo.tblCodeIndigenous.IndCode 
  AND dbo.tblClient.URNO = derivedtbl_1.URNO 
  AND (dbo.tblClient.City IS NOT NULL)',

'GROUP BY 
  dbo.tblClient.ID, 
  dbo.tblCodeClinic.Clinic, 
  dbo.tblCodeCountries.Country, 
  dbo.tblCodeIndigenous.Indigenous,
  dbo.tblClient.City,
  dbo.tblClient.Postcode, 
  dbo.tblClient.Sex',

'ORDER BY 
  NoServices DESC'))

saveRDS(query4, file = "Data/deid.rds")
data <- readRDS("Data/deid.rds")
