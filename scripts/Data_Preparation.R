### THIS PART GETS STOCK INFORMATION FROM YAHOO, STORES THEM AND PREPARES THEM FOR ANALYSIS

# Read CSV with NASDAQ symbols
nasdaq_symbols <- read_excel("dataset/nasdaq_symbols.xlsx")


# For each symbol, it quotes YAHOO and gets only the Adj.Close price, as this is the one needed for the analysis.
# The date is the index.

all_stocks <- NULL
increment <- 1
for (i in nasdaq_symbols$Symbol){
  
  temp_stocks <- get.hist.quote(instrument = i,quote = 'AdjClose', provider = 'yahoo', compression = 'd', quiet = TRUE, retclass = 'zoo')
  if(increment == 1){
    all_stocks <- temp_stocks
  }
  else{
    all_stocks <- merge(all_stocks,temp_stocks)
  }
  increment <- increment + 1
  
}


# Assign colnames (the same as the symbol)
colnames(all_stocks) = nasdaq_symbols$Symbol

# change to timeseries format
all_stocks <- xts(all_stocks) 

# Check for NAs
summary(all_stocks)
nrow(all_stocks)

# Before calculating the return and the mean, we take care of the NAs. So, with the na.locf function, we fill the missing values
# with the closest Not NA value in order to have a return of 0 and not null.
all_stocks_complete <- all_stocks %>%
  na.locf(., na.rm = FALSE) %>%
  na.locf(., fromLast = TRUE)

nrow(all_stocks_complete)

# Calculating the compounded return using diff and log and assigning it to a new table
all_return_daily <- diff(log(all_stocks_complete))

# Remove the last row as it stays NA
all_return_daily <- all_return_daily[-1,]

# Add day, month, year as separate columns

all_stocks_complete$day <- day(index(all_stocks_complete))
all_stocks_complete$month <- month(index(all_stocks_complete))
all_stocks_complete$year <- year(index(all_stocks_complete))


all_return_daily$day <- day(index(all_return_daily))
all_return_daily$month <- month(index(all_return_daily))
all_return_daily$year <- year(index(all_return_daily))

# Convert the data into table format for proper analysis
all_stocks_complete <- data.table(as.data.frame(coredata(all_stocks_complete)))
all_return_daily<- data.table(as.data.frame(coredata(all_return_daily)))


# Using melt function to change the data into a long format
all_stocks_complete <- data.table(melt(all_stocks_complete, id.vars = c('day','month','year')))
all_return_daily <- data.table(melt(all_return_daily, id.vars = c('day','month','year')))

# Create the date as a column, to be able to use it for the analysis (not useful as index)
all_stocks_complete$date <- as.Date(with(all_stocks_complete, paste(day, month, year,sep="-")), "%d-%m-%Y")
all_return_daily$date <- as.Date(with(all_return_daily, paste(day, month, year,sep="-")), "%d-%m-%Y")

# Re-assign names to the columns
names(all_stocks_complete) <- c('day','month','year','symbol','stock_price','date')
names(all_return_daily) <- c('day','month','year','symbol','stock_log_return','date')

# Remove Scientific Format for stock price and stock log return
format(all_stocks_complete$stock_price, scientific=FALSE)
format(all_return_daily$stock_log_return, scientific=FALSE)

# Preview Data 
tail(all_stocks_complete)
tail(all_return_daily)


