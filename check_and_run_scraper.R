# This small script checks if an image file with today's date
# already exists in the img/ dir - and runs if no such file name 
# was found.

library("lubridate")
library("notifier")

# find out from cmd args in which dir is this project sitting
cmd_args <- commandArgs()
proj_dir <- 
  grep(
    "packt_book_of_day/check_and_run_scraper.R", 
    cmd_args, 
    value = TRUE
  )
proj_dir <- dirname( gsub("--file=", "", proj_dir) )

# path to todays img
today_img <- paste0( "image_" , format( Sys.Date(), "%d%m%g" ), ".png" )
image_path <- file.path( proj_dir, "img", today_img )

# check if its after noon and the deal from the day
# before has been updated
after_noon <- lubridate::hour(Sys.time()) > 12L

if ( !file.exists(image_path) && after_noon ) {
  # path to rscript.exe
  rscript_exe <- file.path( R.home(), "bin", "Rscript.exe" )
  # path to script
  script_path <- file.path( proj_dir, "packt_book_deal_scraper.R" )
  # run
  system2(rscript_exe, script_path)
} else {
  # desktop notification
  notifier::notify(
    title = "Packt book deal of the day",
    msg = "You got already today's deal",
    image = image_path)
}

