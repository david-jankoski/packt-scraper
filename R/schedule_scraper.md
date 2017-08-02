This is a brief explanation on how to schedule a task to run on each log on.  

## Linux 

Since the cron utility does not offer `ONLOGON` option (or I could not figure out how), the simplest way I found was:  
 1. make a small bash script ...
    `sudo gedit packt_scraper_schtask.sh`  
 
 2. ... containing the following 3 lines ...  
    ```
    #!/bin/bash
    
    sleep 180
    /usr/bin/Rscript ~/projects/packt-scraper/R/check_and_run_scraper.R
    ``` 
  
  3. give it permissions  
    `chmod +x packt_scraper_schtask.sh`  
  
  4. and add it to the startup applications in `gnome-sessions-properties`  

I followed the approach outlined in [this](https://askubuntu.com/questions/206432/how-can-i-write-a-shell-script-that-will-run-at-startup-and-introduce-a-delay-in) and it worked for me.  
The task itself has a 3 minute delay - which means the notification should pop up 3 minutes after login.  

## Windows

The windows task scheduler utility does have a `ONLOGON` option which makes it even easier and we can do everything from withing R itself.  

```
# of course there is already an R package for this
if (!require("taskscheduleR"))
  install.packages("taskscheduleR")
library("taskscheduleR")

# path to Rscript
rscript <- file.path( R.home(), "bin", "Rscript" )
if (.Platform$OS.type == "windows" ) rscript <- paste0(rscript, ".exe")

# path to the check-and-run script
proj_dir <- # getwd()  # if you cloned this as Rproj
script_path <- file.path(proj_dir, "check_and_run_scraper.R")

# schedule script to run
taskscheduleR::taskscheduler_create(taskname = "packt_book_scraper",
                                    rscript = script_path,
                                    schedule = "ONLOGON",
                                    Rexe = rscript_exe,
                                    starttime = Sys.Date()
                                    )

```
