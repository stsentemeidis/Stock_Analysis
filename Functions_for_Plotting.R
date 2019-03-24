### THIS PART CREATES FUNCTIONS THAT WILL PROVIDE TIME SERIES POLTS FOR THE DAILY STOCK RETURN OF ANY STOCK, AFTER 1999.


# Plotting any Nasdaq symbol, after 1999, along with its daily return
after_2000_return <- all_return_daily[date>'2000-01-01']  # for faster results
plotting_returns <- function(x){
  if (x %in% nasdaq_symbols$Symbol){
    
    ggplotly(ggplot(data=after_2000_return[after_2000_return$symbol == x,], aes(x=date, y=stock_log_return))+
               geom_line(color='cornflowerblue')+
               ggtitle("Daily Stock Returns") +
               xlab("Time Frame") + ylab("Stock Return")+
               theme_minimal()
    )
  }
}

plotting_returns('AAPL')


# Plotting any Nasdaq symbol, after 1999, along with its daiy stock price
after_2000_stocks <- all_stocks_complete[date>'2000-01-01'] # for faster results
plotting_stocks_price <- function(x){
  if (x %in% nasdaq_symbols$Symbol){
    
    ggplotly(ggplot(data=after_2000_stocks[after_2000_stocks$symbol == x,], aes(x=date,y=stock_price))+
               geom_line(color='cornflowerblue')+
               ggtitle("Daily Stock Price") +
               xlab("Time Frame") + ylab("Stock Price")+
               theme_minimal()
    )
  }
}

plotting_stocks_price('AAPL')


