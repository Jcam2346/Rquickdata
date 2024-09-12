rm(list = ls())

ABSDirectoryURL = "https://www.abs.gov.au/census/find-census-data/community-profiles/2021/AUS/download/GCP_AUS.xlsx"

h <- curl::new_handle()
#To find your user-agent:
#options("HTTPUserAgent")
curl::handle_setheaders(h,
                  "Content-Type" = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                  "Cache-Control" = "no-cache",
                  "User-Agent" = unlist((options("HTTPUserAgent")))
)
if (!file.exists("./data-raw/GCP_AUS.xlsx")){
curl::curl_download(ABSDirectoryURL, destfile = "./data-raw/GCP_AUS.xlsx", quiet = FALSE, handle = h)
}

ABSDirectory = readxl::read_xlsx("./data-raw/GCP_AUS.xlsx", sheet = 'List of tables', skip = 3, col_names = c("code","table","code2","table2"))

ABSDirectory = data.frame(code = c(ABSDirectory$code, ABSDirectory$code2), table = c(ABSDirectory$table, ABSDirectory$table2))

readr::write_excel_csv(ABSDirectory, "./inst/extdata/ABSDirectory.csv")
readr::write_excel_csv(ABSDirectory, "./data/ABSDirectory.csv")
xlsx::write.xlsx(ABSDirectory, "./inst/extdata/ABSDirectory.xlsx", row.names = FALSE)
xlsx::write.xlsx(ABSDirectory, "./data/ABSDirectory.xlsx", row.names = FALSE)

usethis::use_data(ABSDirectory, overwrite = TRUE)
