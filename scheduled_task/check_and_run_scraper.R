# This small script checks if an image file with today's date
# already exists in the img/ dir - and runs if no such file name 
# was found.

# path to todays img
today_img <- paste0( "image_" , format( Sys.Date(), "%d%m%g" ), ".png" )
todays_img <- file.path( getwd(), "img", today_img )

if ( !file.exists(todays_img) ) {
  # path to rscript.exe
  rscript_path <- file.path( R.home(), "bin", "Rscript.exe" )
  # path to script
  script_path <- file.path( getwd(), "packt_book_deal_scraper.R" )
  # run
  system2(rscript_path, script_path)
}
