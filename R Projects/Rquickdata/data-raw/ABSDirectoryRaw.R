## code to prepare `ABSDirectoryRaw` dataset goes here

utils::data(ABSDirectoryURL, package = "Rquickdata")

if (!file.exists("inst/extdata/GCP_AUS.xlsx")){
  curl::curl_download(ABSDirectoryURL, destfile = "inst/extdata/GCP_AUS.xlsx", quiet = FALSE,
                      handle = curl::handle_setheaders(handle = curl::new_handle(),
                                                       "Content-Type" = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                                                       "Cache-Control" = "no-cache",
                                                       "User-Agent" = unlist((options("HTTPUserAgent")))
                      ))
}
if (!file.exists("data-raw/GCP_AUS.xlsx") & (file.exists("inst/extdata/GCP_AUS.xlsx"))){
  file.copy(from="inst/extdata/GCP_AUS.xlsx", to = "data-raw/", overwrite = TRUE)
}
ABSDirectoryRaw = readxl::read_xlsx(path = "inst/extdata/GCP_AUS.xlsx", sheet = 'List of tables', skip = 3, col_names = c("code","table","code2","table2"))

usethis::use_data(ABSDirectoryRaw, overwrite = TRUE)
