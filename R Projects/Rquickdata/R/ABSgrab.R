#rm(list = ls())

##runs the ABSDirectory.R script to download the GCP_AUS.xlsx from the ABS, loading in the list of tables
#select an ABS table to load into the environment based on the codes stored in ABSDirectory$code
#Defaults to returning a data.frame. However, some ABS tables are broken into 2 or 3 subtables and in this case will be returned together as a list
ABSgrab = function(code){
  #Users won't know that some ABS tables are broken into 2 or 3 subtables. This code reads any subtables into a list
  if (!code %in% readxl::excel_sheets(system.file("extdata", "GCP_AUS.xlsx", package = "Rquickdata"))){
    sheet_a = readxl::read_xlsx(path = system.file("extdata", "GCP_AUS.xlsx", package = "Rquickdata"), sheet = paste0((code),"a"))
    #remove any rows which are all NA values in sheet_a
    sheet_a = as.data.frame(sheet_a[rowSums(is.na(sheet_a)) != ncol(sheet_a), ])
    sheet_b = readxl::read_xlsx(path = system.file("extdata", "GCP_AUS.xlsx", package = "Rquickdata"), sheet = paste0((code),"b"))
    sheet_b = as.data.frame(sheet_b[rowSums(is.na(sheet_b)) != ncol(sheet_b), ])
    if (sum(grepl(code, readxl::excel_sheets(system.file("extdata", "GCP_AUS.xlsx", package = "Rquickdata")))) == 3){
        sheet_c = readxl::read_xlsx(path = system.file("extdata", "GCP_AUS.xlsx", package = "Rquickdata"), sheet = paste0((code),"c"))
        sheet_c = as.data.frame(sheet_c[rowSums(is.na(sheet_c)) != ncol(sheet_c), ])
        return (list(sheet_a, sheet_b, sheet_c))
        }
    return (list(sheet_a, sheet_b))
  }
  else{
  #Read in GCP_AUS specific catalogue based on entered code
  yoursheet = readxl::read_xlsx(path = system.file("extdata", "GCP_AUS.xlsx", package = "Rquickdata"), sheet = as.character(code))
  yoursheet = as.data.frame(yoursheet[rowSums(is.na(yoursheet)) != ncol(yoursheet), ])
  return(yoursheet)
  }
  #Time Series Data
  #add time series data section to this function
}

# # RES_DWELL_ST = "https://api.data.abs.gov.au/data/ABS%2CRES_DWELL_ST/all?detail=full"
# # 4 = SA
# # 8 = ACT
# # 3 = QLD
# # 7 = NT
# # 1 = NSW
# # 5 = WA
# # 2 = VIC
# # 6 = TAS



