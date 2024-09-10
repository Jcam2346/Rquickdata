# censusimport = function()
#   "https://www.abs.gov.au/census/find-census-data/community-profiles/2021/AUS/download/GCP_AUS.xlsx"
rm(list = ls())

library(dplyr)
library(curl)
library(readxl)
library(usethis)
library(testthat)

ABSDirectoryURL = "https://www.abs.gov.au/census/find-census-data/community-profiles/2021/AUS/download/GCP_AUS.xlsx"

# RES_DWELL_ST = "https://api.data.abs.gov.au/data/ABS%2CRES_DWELL_ST/all?detail=full"
# 4 = SA
# 8 = ACT
# 3 = QLD
# 7 = NT
# 1 = NSW
# 5 = WA
# 2 = VIC
# 6 = TAS

h <- new_handle()
#To find your user-agent:
#options("HTTPUserAgent")
handle_setheaders(h,
                  "Content-Type" = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                  "Cache-Control" = "no-cache",
                  "User-Agent" = "RStudio Desktop (1.4.1106); R (4.0.2 x86_64-w64-mingw32 x86_64 mingw32)"
)

curl_download(ABSDirectoryURL, destfile = "ABSDirectory.xlsx", quiet = FALSE, handle = h)

ABSDirectory = read_xlsx("ABSDirectory.xlsx", sheet = 'List of tables', skip = 3, col_names = c("code","table","code2","table2"))

ABSDirectory = data.frame(code = c(ABSDirectory$code, ABSDirectory$code2), table = c(ABSDirectory$table, ABSDirectory$table2))

codelist = as.list(ABSDirectory$code)

getcodes = function(){
  print(ABSDirectory)
}

getsheet = function(code){
  deparse(substitute(code))
  yoursheet = readxl::read_xlsx("ABSDirectory.xlsx", sheet = as.character(code))
  yoursheet = yoursheet[rowSums(is.na(yoursheet)) != ncol(yoursheet), ]
  return(yoursheet)
}

#Time Series Data



