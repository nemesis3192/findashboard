

fig <- plot_ly(x = as.Date(as.character(tickerData$date)), type="candlestick",
                      open = tickerData$open, close = tickerData$close,
                      high = tickerData$high, low = tickerData$low) 
fig <- fig %>% layout(title = "Basic Candlestick Chart")

fig


# Candlechart analysis
tickerData$M <-(tickerData$open+tickerData$close)/2     # Median
tickerData$US <- tickerData$high - pmax(tickerData$open,tickerData$close)
tickerData$LS <- pmin(tickerData$open,tickerData$close) - tickerData$low
tickerData$WC <- tickerData$high - tickerData$low
tickerData$BL <- abs(tickerData$open - tickerData$close)



# Generate charts




# Sample output
getTickerHistory(ticker='ADANIPOWER.XNSE',startDate = '2021-02-01'
                 ,endDate = '2021-06-08',limit = 1000) %>% 
                    getcharts(.) -> charts






# Individual stock analysis





xtsData %>% Ad() %>% chartSeries()

xtsData %>%
  chartSeries(TA='addBBands();
                    addBBands(draw="p");
                    addVo();
                    addMACD()', 
              theme="white"
  ) 



xtsData %>%
  Ad() %>%
  dailyReturn(type = 'log') %>% 
  head() 


xtsData_log_returns <- xtsData %>%
  Ad() %>%
  dailyReturn(type = "log")
names(xtsData_log_returns) <- "xtsData.Log.Returns"
# Plot the log-returns    
xtsData_log_returns %>%    
  ggplot(aes(x = xtsData.Log.Returns)) + 
  geom_histogram(bins = 100) + 
  geom_density() +
  geom_rug(alpha = 0.5) 


probs <- c(.005, .025, .25, .5, .75, .975, .995)
dist_log_returns <- xtsData_log_returns %>% 
  quantile(probs = probs, na.rm = TRUE)
dist_log_returns




install.packages("remotes")
remotes::install_github("pverspeelt/Quantfunctions")


ticker <- 'RELIANCE.XNSE'