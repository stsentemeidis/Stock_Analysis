### THIS PART CREATES THE LINEAR REGRESSION MODEL, TO INVESTIGATE WHETHER THERE IS A RELATIONSHIP BETWEEN VOLATILITY AND RETURN.


# Linear model
# First we split our data to train and test sample, by 80% - 20% respectively.
set.seed(2018)
train.size <- 0.8
train.index <- sample.int(length(return_mean_daily_by_symbol$avg_stock_return), round(length(return_mean_daily_by_symbol$avg_stock_return) * train.size))
train.sample <- return_mean_daily_by_symbol[train.index,]
test.sample <- return_mean_daily_by_symbol[-train.index,]

# Develop the model with the mean return as response, and the volatility as independent variable.
model_0 <- lm(avg_stock_return~sd_stock_return, data = train.sample)

# Then, we analyze the effect of the absolute value of the VIX on stock market returns. 
# Seeing the output of the regression analysis,
# we can conclude that the VIX and the returns have a slightly positive relationship 
# with a coefficient of -0.01363 and an (intercept) coefficient of 0.0001795
# Considering the regression output we can conclude that the level of the VIX has a statistically 
# significant effect on stock market returns, at a 20% level.
lm_stats <- summary(model_0)
lm_stats

ggplotly(ggplot(return_mean_daily_by_symbol,aes(x=return_mean_daily_by_symbol$avg_stock_return,
                                       y=return_mean_daily_by_symbol$sd_stock_return))+
  geom_point(size=2, colour='orange')+
  ggtitle("Plot returns with volatility") +
  xlab("Avg Return") + ylab("Avg Volatility")+
  geom_text(label=return_mean_daily_by_symbol$symbol, size =2.75)+
  theme_minimal())

# As we cannot be accurate about our estimates, let's calculate the confidence intervals of the Volatility.
confint(model_0, level=.95)
plot_summs(model_0, scale = TRUE, plot.distributions = TRUE, inner_ci_level = 0.95)
