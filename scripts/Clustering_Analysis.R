### THIS PART CREATES THE CLUSTERING ANALYSIS, FOR THE DIFFERENT COMPANIES BEHIND THE STOCKS


# Clustering Analysis
return_mean_daily_0 <- return_mean_daily_by_symbol

# Remove the text from our data table, for the analysis. We have already taken care NULL Values.
return_mean_daily_0$symbol <- NULL
return_mean_daily_0$Name <- NULL
rescale(return_mean_daily_0$avg_stock_return)
rescale(return_mean_daily_0$sd_stock_return)
results <- kmeans(return_mean_daily_0, 3)
table_cluster <-table(return_mean_daily_by_symbol$symbol, results$cluster)
table_cluster

# plotting our Clustering Results
results$cluster=factor(results$cluster)
centers=as.data.frame(results$centers)

# Plot 1
ggplotly(ggplot(data=return_mean_daily_0[,c("avg_stock_return", "sd_stock_return")], aes(x=return_mean_daily_0$avg_stock_return, 
                                                                  y=return_mean_daily_0$sd_stock_return, 
                                                                  color=results$cluster )) + geom_point(cex=1.5)+
  ggtitle("K-Means") +
  xlab("Average Return") + ylab(" Volatility"))

# Plot 2
plotcluster(return_mean_daily_0[,c("avg_stock_return", "sd_stock_return")], results$cluster)

# Plot 3
clusplot(return_mean_daily_0[,c("avg_stock_return", "sd_stock_return")], results$cluster, color=TRUE, shade=FALSE, labels = 2, lines=0,
         xlab = "Average Return", ylab = " Volatility", main = 'K-means')

# Detecting Outliers,
centers1 <- results$centers[results$cluster, ] # "centers" is a data frame of 3 centers but the length of iris dataset so we can canlculate distance difference easily.
distances <- sqrt(rowSums((return_mean_daily_0 - centers1)^2))
outliers <- order(distances, decreasing=T)[1:5]
print(outliers)
print(return_mean_daily_0[outliers,])


# Plotting the Outliers
plot(return_mean_daily_0[,c("avg_stock_return", "sd_stock_return")], pch=19, col=results$cluster, cex=1)
points(results$centers[,c("avg_stock_return", "sd_stock_return")], col=1:3, pch=15, cex=2)
points(return_mean_daily_0[outliers, c("avg_stock_return", "sd_stock_return")], pch="+", col=4, cex=3)

