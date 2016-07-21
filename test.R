library(RODBC)
ch <- odbcConnect("SHIPHNE")
# res <- sqlFetch(ch, "tblClient")
# query <- sqlQuery(ch, paste('SELECT "URNO", "City" FROM "tblClient"',
#                             'WHERE "City" Is Not NULL'))
# 
# query2 <- sqlQuery(ch, paste(
# 'SELECT dbo.tblClient.ID, dbo.tblCodeClinic.Clinic, dbo.tblCodeCountries.Country, dbo.tblCodeIndigenous.Indigenous, dbo.tblClient.City, dbo.tblClient.Postcode, 
# dbo.tblClient.Sex, MAX(dbo.tblVisit.VisitDate) AS MaxVisit, COUNT(dbo.tblServiceActivities.URNO) AS NoVisits',
# 'FROM  dbo.tblClient, dbo.tblCodeClinic, dbo.tblCodeCountries, dbo.tblCodeIndigenous, dbo.tblVisit, dbo.tblServiceActivities',
# 'WHERE dbo.tblClient.Clinic = dbo.tblCodeClinic.ClinicNumber AND dbo.tblClient.CountryOfBirth = dbo.tblCodeCountries.CountryCode AND 
# dbo.tblClient.Indigenous = dbo.tblCodeIndigenous.IndCode AND dbo.tblClient.URNO = dbo.tblVisit.URNO AND 
# dbo.tblClient.URNO = dbo.tblServiceActivities.URNO',
# 'GROUP BY dbo.tblClient.ID, dbo.tblCodeClinic.Clinic, dbo.tblCodeCountries.Country, dbo.tblCodeIndigenous.Indigenous, dbo.tblClient.City, dbo.tblClient.Postcode, 
# dbo.tblClient.Sex','HAVING (dbo.tblClient.City IS NOT NULL)'))
# 
# data <- saveRDS(query2, file = "deid.rds")
data <- readRDS("Data/deid.rds")
