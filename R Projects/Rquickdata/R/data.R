#' @title ABSDirectory
#'
#' @description
#' A subset of 2021 Australian Bureau of Statistics Census data found at:
#' 'https://www.abs.gov.au/census/find-census-data/community-profiles/2021/AUS/download/GCP_AUS.xlsx'.
#' It represents data at the federal level.
#'
#' The sheet named 'List of tables' is imported from the \code{xlsx} file
#' The first 3 rows are skipped and new column names assigned \code{c("code","table","code2","table2")}
#' The corresponding columns are then merged into 2 final columns, \code{c("code","table")}
#'
#' @format ## `ABSDirectory`
#' A \code{data.frame} with 62 rows and 2 columns, which are:
#' \describe{
#' \item(code){the 3 character ABS string representing a table}
#' \item(table){the name of an ABS table}
#' }
#' @source <https://www.abs.gov.au/census/find-census-data/community-profiles/2021/AUS/download/GCP_AUS.xlsx>
"ABSDirectory"
