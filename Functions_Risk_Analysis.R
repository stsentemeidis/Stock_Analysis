### THIS PART CREATES FUNCTIONS THAT WILL PROVIDE THE MAX AND MIN RISK STOCK, BASED ON A SPECIFIC GIVEN TIMEFRAME


# Maximum Risk function
MaximumRisk <- function(d=all_return_daily, start, end)
{
  data.period <-subset(all_return_daily, all_return_daily$date >= as.Date(start) & all_return_daily$date <= as.Date(end))
  for(i in nrow(data.period)){
    print(data.period[which(data.period$stock_log_return == max(data.period$stock_log_return)),c('symbol','stock_log_return')])
  }
}

MaximumRisk(all_return_daily, '2016-01-01', '2016-01-31')



# Lowest Risk function
LowestRisk <- function(d=all_return_daily, start, end)
{
  data.period <-subset(all_return_daily, all_return_daily$date >= as.Date(start) & all_return_daily$date <= as.Date(end))
  for(i in nrow(data.period)){
    print(data.period[which(data.period$stock_log_return == min(data.period$stock_log_return)),c('symbol','stock_log_return')])
  }
}

LowestRisk(all_return_daily, '2016-01-01', '2016-01-31')

