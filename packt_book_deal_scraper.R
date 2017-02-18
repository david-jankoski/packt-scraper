library("tidyverse")
library("png")
library("notifier")

# path to where you want the data to be saved
proj_path <- "C:/Users/DavidJankoski/Desktop/r_files/packt_book_of_day/" 
today <- format(Sys.Date(), "%d%m%g")

# path for the csv file
csv_path <- paste0(proj_path, "packt_book_deals.csv")
# path for the image
image_path <- paste0(proj_path, "img/image_", today, ".png")

# packt url for free learning deal of the day
packt <- "https://www.packtpub.com/packt/offers/free-learning"

# read html, extract all h2 headers and pretty format
# orig pattern "^<h2>|[[:space:]]|</h2>$"
deal_of_the_day <-
  packt %>%
  xml2::read_html() %>%
  rvest::html_nodes("h2") %>%
  stringr::str_replace_all(pattern = "^<h2>|\t|\n|</h2>$", replacement = "") %>%
  .[1]

# scrape the image for the book 
  packt %>%
  xml2::read_html() %>%
  rvest::html_nodes(".dotd-main-book-image") %>%
  rvest::html_node("img") %>%
  rvest::html_attr("src") %>%
  stringr::str_sub(start = 3L) %>%
  httr::GET() %>%
  httr::content() %>%
  png::writePNG(target = image_path)

# write csv
append_to_file <- file.exists(csv_path)

readr::write_csv(data_frame(Date = Sys.Date(), Book = deal_of_the_day),
                 path = csv_path, 
                 append = append_to_file,
                 col_names = !append_to_file)
  
# desktop notification
  notifier::notify(
    title = "Packt book deal of the day",
    msg = deal_of_the_day[1],
    image = image_path
    )
