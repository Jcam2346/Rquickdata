#' ultraread
#' @description Create Dataframes from CSV, XLSX or DBI connections
#' @param filepath Required for csv and xlsx file reading
#' @param type Defaults to "csv", also accepts "xlsx" filetype or "db" to get started with a database connection
#' @param sheetnum Defaults to 1, preferably use the index number of the sheet being returned as a dataframe. Only relevant for xlsx files
#' @param headed Defaults to TRUE, turns the first row into the column names of the returned dataframe
#' @param encoded Defaults to "UTF-8". The encoding you require for reading your file. Only relevant to CSVs
#' @param driver Defaults to "ODBC Driver 17 for SQL Server". The DBI::dbConnect compatible driver you wish to use. The driver must be installed correctly on your computer. See https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-ver16
#' @param server The database server you wish to connect to
#' @param database The name of the database you wish to connect to
#' @param uid Your username or user-identification for logging into the database
#' @param pwd Your password for logging into the database
#' @param port Defaults to 1433. The port you wish to connect to the database via
#'
#' @return Your csv or xlsx sheet as a dataframe, otherwise a database connection.
#' @export
#'
#' @note Will result in error when filepath is given but csv or xlsx types are specified. For database connections, the ODBC driver you specify must be installed on the computer you are using. It also must have established a connection to the database. For more info see https://learn.microsoft.com/en-us/sql/connect/odbc/download-odbc-driver-for-sql-server?view=sql-server-ver16
#'
#' @examples ## Not run:
#' @examples df = ultraread(filepath = "./encoding test.xlsx", type = "xlsx", sheetnum = 2, headed = TRUE)
#' @examples df = ultraread(filepath = "./encoding test.csv", type = "csv", headed = TRUE, encoded = "latin1")
#' @examples con = ultraread(server = "company.database.windows.net", database = "sales_db", uid = "user_x", pwd = "secret_password", port = 1433)
#' @examples ##End(Not run)
ultraread = function(filepath = NULL, type = "csv", sheetnum = 1, headed = TRUE, encoded = "UTF-8", driver = "ODBC Driver 17 for SQL Server", server = "nameof.database.windows.net", database = "nameofdatabase", uid = "database_username", pwd = "databasepassword", port = 1433){
  if (is.null(filepath) & (type != "db")){
    error = function(e){
      print("No filepath supplied")
    }
  } else
  if (type == "db"){
    con <- DBI::dbConnect(odbc::odbc(), Driver = driver, Server = server, Database = database, UID = uid, PWD = pwd, Port = port)
    return(con)
    } else
  if (type == "csv" & (!is.null(filepath))){
    mycsv <- utils::read.csv(file = filepath, header = headed, encoding = encoded, check.names = FALSE)
    return(mycsv)
  } else
  if (type == "xlsx" & (!is.null(filepath))){
    #auto encodes UTF-8
    myxlsx <- readxl::read_xlsx(path = filepath, sheet = sheetnum, col_names = headed, .name_repair = "minimal")
    return(myxlsx)
  } else
    stop("Double check variables")
    # warning = function(w){
    #   print("Warning, something isn't right.")
    # }
    # finally = {
    #   print("ultraread was successful")
    # }
}

