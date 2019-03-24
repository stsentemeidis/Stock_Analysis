### THIS SCRIPT CALLS ALL SUB-SCRIPTS TO READ AND PREPARE THE DATASET,
### RUN THE ANALYSIS AND OUTPUT RELEVANT DATAF FILES

start_time <- Sys.time()
print(paste0('---START--- Starting at ',start_time))

# Setting Working Directory at the Stocks_R_final folder
setwd('/Users/stavrostsentemeidis/Desktop/Stocks_R_Final')

# Install necessary packages
source('scripts/install:load_packages.R')

# Load, Read Data and Prepare Working Dataset
source('scripts/Data_Preparation.R')

# Create Different Detailed Aggregations
source('scripts/Diff_Aggregations.R')

# Create Functions for Risk Analysis
source('scripts/Functions_Risk_Analysis.R')

# Create Functions for Plotting
source('scripts/Functions_for_Plotting.R')

# Calculate Linear Regression
source('scripts/Linear_Regression.R')

# Calculate Clustering Analysis
source('scripts/Clustering_Analysis.R')

print(paste0('[', round(difftime(Sys.time(),start_time, units = 'secs'),1), 's]: ',
             'All operations are over! ---END---'))