# run this script in order to
# install all the required libs
# for the packt-scraper
install.packages("tidyverse")
install.packages("magick")
install.packages("devtools")
# notifer is broken at time of writing (1st Aug 2017)
# so we need to get last working version
devtools::install_version("notifier", version="1.0.0")
