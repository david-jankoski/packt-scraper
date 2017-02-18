# This script would schedule a task to run on each log on.
# check_and_run_scraper.R - would check if an img file with
# today's date exists in the proj img/ dir and runs the scraper
# if no such file name found.
# Depending on your wishes - this script should be ran only once.

library("taskscheduleR")

# path to where this project sits
proj_path <- "C:/Users/DavidJankoski/Desktop/r_files/packt_book_of_day/" 

# path to the check-and-run script
script_path <- paste0(proj_path, "scheduled_task/check_and_run_scraper.R")
  
# schedule script to run 
taskscheduler_create(taskname = "packt_book_scraper", 
                     rscript = script_path, 
                     schedule = "ONLOGON", 
                     Rexe = "C:/Program Files/R/R-3.3.0/bin/Rscript.exe", 
                     starttime = Sys.Date() + 1)
