#rm(list = ls())
# utils::data(ABSDirectoryRaw, package = "Rquickdata")

ABSDirectory = data.frame(code = c(ABSDirectoryRaw$code, ABSDirectoryRaw$code2), table = c(ABSDirectoryRaw$table, ABSDirectoryRaw$table2))

usethis::use_data(ABSDirectory, overwrite = TRUE)
