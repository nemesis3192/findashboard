# Find patterns in stock charts
library(devtools)
devtools::install_github("prodipta/techchart")

# Load dependencies
source('Dependencies/getHistoricalData.R')
library(data.table)
library(techchart)


getPatterns = function(ticker)
{
  data <- getTickerHistory(ticker,startDate = '2018-01-01',endDate = '2021-01-01'
                      ,limit = 2000,as.xtse = TRUE)
  
  tmp <- lapply(as.list(1:4), function(x){
    pat <- find.pattern(data, pattern = pattern.db("all")[[x]])
    if(!is.null(pat))
    {
      nom <- as.data.frame(pat$matches[[1]]$name)
      dur <- as.data.frame(pat$matches[[1]]$duration)
      stat <- as.data.frame(pat$matches[[1]]$type)
      dat <- as.data.frame(pat$matches[[1]]$data)
      datx <- as.data.frame(pat$matches[[1]]$date)
      all <- cbind(row.names(dat),dat,nom,dur,stat,ticker,datx)
      colnames(all) <- c("Date","Data","Pattern","Duration","Status","Ticker","DateMatched")
      all
    }})
  tmp <- tmp[lapply(tmp,length)>0]
  tmp <- rbindlist(tmp,use.names = TRUE)
  tmp
}


