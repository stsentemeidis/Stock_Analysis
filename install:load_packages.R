### THIS PART CHECKS IF NECESSARY PACKAGES ARE INSTALLED AND LOADED
start_time <- Sys.time()
print(paste0('---START--- Starting at ',start_time))

packages_list <- c('ggplot2',
                   'quantmod',
                   'readxl',
                   'tseries',
                   'lubridate',
                   'highcharter',
                   'zoo',
                   'lattice',
                   'mice',
                   'Amelia',
                   'tidyr',
                   'gridExtra',
                   'leaflet',
                   'jtools',
                   'lattice',
                   'car',
                   'caret',
                   'plotly',
                   'data.table',
                   'cluster',
                   'fpc',
                   'scales',
                   'prettydoc')

for (i in packages_list){
  if(!i%in%installed.packages()){
    install.packages(i, dependencies = TRUE)
    library(i, character.only = TRUE)
  } else {
    library(i, character.only = TRUE)
  }
}

print(paste0('[', round(difftime(Sys.time(),start_time, units = 'secs'),1), 's]: ',
             'All necessary packages installed and loaded'))