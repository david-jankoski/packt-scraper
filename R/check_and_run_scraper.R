# This small script checks if an image file with today's date
# already exists in the img/ dir - and runs if no such file name
# was found.
suppressPackageStartupMessages(library("lubridate"))
suppressPackageStartupMessages(library("notifier"))

# find out from cmd args in which dir is this project sitting
cmd_args <- commandArgs()

proj_dir <-
  grep(
    "check_and_run_scraper.R",
    cmd_args,
    value = TRUE
  )
proj_dir <- dirname( gsub("--file=", "", proj_dir) )

# path to todays img
today_img <- paste0( "image_" , format( Sys.Date(), "%d%m%g" ) )
img_exists <-
  length(
    list.files(path = "data/img/", pattern = today_img)
    )

# check if its after noon and the deal from the day
# before has been updated
#after_noon <- lubridate::hour(Sys.time()) > 12L
after_noon <- TRUE
if ( !img_exists && after_noon ) {
  # path to rscript
  rscript <- file.path( R.home(), "bin", "Rscript" )
  if (.Platform$OS.type == "windows" ) rscript <- paste0(rscript, ".exe")
  # path to script
  script_path <- file.path( proj_dir, "packt_book_deal_scraper.R" )
  # run
  system2(rscript, script_path)
}
