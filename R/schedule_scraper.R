# This script would schedule a task to run on each log on.
# check_and_run_scraper.R - would check if an img file with
# today's date exists in the proj img/ dir and runs the scraper
# if no such file name found.
# Depending on your wishes - this script should be ran only once.

library("taskscheduleR")

# path to Rscript.exe
rscript_exe <- file.path( R.home(), "bin", "Rscript.exe" )
# path to the check-and-run script
script_path <- file.path( getwd(), "check_and_run_scraper.R" )

# schedule script to run 
taskscheduleR::taskscheduler_create(taskname = "packt_book_scraper", 
                                    rscript = script_path, 
                                    schedule = "ONLOGON", 
                                    Rexe = rscript_exe, 
                                    starttime = Sys.Date()
                                    )
