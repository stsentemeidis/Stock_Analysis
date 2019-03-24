### THIS PART GETS STOCK INFORMATION FROM THE FILES PREPARED AND PROCESSES THEM.


# Calculate different level aggregations for potential further use
stocks_mean_daily_by_symbol <- all_stocks_complete[, list(avg_stock_price = mean(stock_price),
                                                          sd_stock_price = sd(stock_price)),
                                                   by = list(symbol)]

stocks_mean_daily_by_symbol <- merge(stocks_mean_daily_by_symbol,nasdaq_symbols, by.x = 'symbol', by.y = 'Symbol')

############################################################################################################################
stocks_mean_daily_by_symbol_year <- all_stocks_complete[, list(avg_stock_price = mean(stock_price),
                                                               sd_stock_price = sd(stock_price)),
                                                        by = list(date,symbol)]

stocks_mean_daily_by_symbol_year <- merge(stocks_mean_daily_by_symbol_year,nasdaq_symbols, by.x = 'symbol', by.y = 'Symbol')

############################################################################################################################
stocks_mean_daily_by_month_year <- all_stocks_complete[, list(avg_stock_price = mean(stock_price),
                                                              sd_stock_price = sd(stock_price)),
                                                       by = list(year,month)]
############################################################################################################################
return_mean_daily_by_symbol <- all_return_daily[, list(avg_stock_return = mean(stock_log_return),
                                                       sd_stock_return  = sd(stock_log_return)),
                                                by = list(symbol)]

return_mean_daily_by_symbol <- merge(return_mean_daily_by_symbol,nasdaq_symbols, by.x = 'symbol', by.y = 'Symbol')
############################################################################################################################
return_mean_daily_by_symbol_year <- all_return_daily[, list(avg_stock_return  = mean(stock_log_return),
                                                            sd_stock_return  = sd(stock_log_return)),
                                                     by = list(date,symbol)]

return_mean_daily_by_symbol_year <- merge(return_mean_daily_by_symbol_year,nasdaq_symbols, by.x = 'symbol', by.y = 'Symbol')
############################################################################################################################
return_mean_daily_by_month_year <- all_return_daily[, list(avg_stock_return  = mean(stock_log_return),
                                                           sd_stock_return  = sd(stock_log_return)),
                                                    by = list(year,month)]

