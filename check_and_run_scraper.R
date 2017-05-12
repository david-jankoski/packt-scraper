# This small script checks if an image file with today's date
# already exists in the img/ dir - and runs if no such file name 
# was found.

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
todays_img <- file.path( proj_dir, "img", today_img )

if ( !file.exists(todays_img) ) {
  # path to rscript.exe
  rscript_path <- file.path( R.home(), "bin", "Rscript.exe" )
  # path to script
  script_path <- file.path( proj_dir, "packt_book_deal_scraper.R" )
  # run
  system2(rscript_path, script_path)
}
