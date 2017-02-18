# This small script checks if an image file with today's date
# already exists in the img/ dir - and runs if no such file name 
# was found.

# path to where this project sits
proj_path <- "C:/Users/DavidJankoski/Desktop/r_files/packt_book_of_day/" 

# path to todays img
todays_img <- paste0(proj_path, "img/image_" , format(Sys.Date(), "%d%m%g"), ".png")

if (!file.exists(todays_img)) {
  # path to rscript.exe
  r_path <- "C:/Program Files/R/R-3.3.0/bin/Rscript.exe"
  # path to script
  script_path <- paste0(proj_path, "packt_book_deal_scraper.R")
  # run
  system2(r_path, script_path)
}
