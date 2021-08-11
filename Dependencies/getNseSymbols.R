# 2021-06-27
# Author: Sahil Shinde
# Project: Finance Dashboard
# Function: getNseSymbols

library(httr)
library(jsonlite)
library(magrittr)


tickers <- c('HDFCBAN')


burl <- "http://api.marketstack.com/v1/"

accesskey <- '0fa2b421abc1ebe62ac4aac748900a30'


getNSEsymbols <- function(baseurl=burl, token=accesskey,limit = 1000){
  endpoint <- 'exchanges/xnse/tickers?'
  url <- paste0(baseurl,endpoint,'access_key=',token,'&limit=',limit)
  
  output <- httr::GET(url) %>% content(., as="text", encoding="UTF-8") 
  data <- fromJSON(output)
  tickers <- data$data$tickers
  return(tickers)
}