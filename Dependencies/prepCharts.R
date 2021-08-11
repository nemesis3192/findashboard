# 2021-06-27
# Author: Sahil Shinde
# Project: Finance Dashboard
# Function: prepCharts

library(dplyr)
library(plotly)
library(quantmod)
library(xts)
library(magrittr)


prepcharts <- function(datadf){
  datadf$Adjusted <- datadf$adj_close
  xtsData <- datadf %>% select(.,date,open,close,low,high,volume,Adjusted)
  xtsData$date <- as.Date(xtsData$date)
  rownames(xtsData) <- xtsData$date
  xtsData$date <- NULL
  xtsData <- as.xts(xtsData)
  
  xtsData %>% Ad() %>% chartSeries() -> serieschart
  
  xtsData %>%
    chartSeries(TA='addBBands();
                    addBBands(draw="p");
                    addVo();
                    addMACD()', 
                theme="white"
    ) -> macdChart
  
  
  fig <- plot_ly(x = as.Date(as.character(datadf$date)), type="candlestick",
                 open = datadf$open, close = datadf$close,
                 high = datadf$high, low = datadf$low) 
  fig <- fig %>% layout(title = "Basic Candlestick Chart")
  
  return(list(a=serieschart,b=macdChart,c=fig))
}