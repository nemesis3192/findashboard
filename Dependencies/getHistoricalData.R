# 2021-04-27
# Author: Sahil Shinde
# Project: Finance Dashboard
# Function: getHistoricalData

library(httr)
library(jsonlite)
library(dplyr)


tickers <- c('HDFCBAN')


burl <- "http://api.marketstack.com/v1/"

accesskey <- '0fa2b421abc1ebe62ac4aac748900a30'






getTickerHistory <- function(ticker, baseurl=burl, token=accesskey,startDate, endDate,limit,as.xtse = FALSE)
{
  endpoint <- "eod?"
  url <- paste0(baseurl,endpoint,'access_key=',token,'&symbols=',ticker,'&limit=',limit)
  
  output <- httr::GET(url) %>% content(.,as='text',encoding = 'UTF-8')
  data <- fromJSON(output)
  eodData <- data$data
  if(as.xtse){
    datadf <- eodData
    datadf$Adjusted <- datadf$adj_close
    xtsData <- datadf %>% select(.,date,open,close,low,high,volume,Adjusted,split_factor,symbol)
    xtsData$date <- as.Date(xtsData$date)
    rownames(xtsData) <- xtsData$date
    xtsData$date <- NULL
    xtsData <- as.xts(xtsData)
    return(xtsData)
  }else{
    return(eodData)
  }
  
}
