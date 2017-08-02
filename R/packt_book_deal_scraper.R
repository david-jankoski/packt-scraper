suppressPackageStartupMessages(library("tidyverse"))
suppressPackageStartupMessages(library("notifier"))
suppressPackageStartupMessages(library("magick"))

# Locate project dir -----

# find out from cmd args in which dir is this project sitting
cmd_args <- commandArgs()

proj_dir <-
  grep(
    "packt_book_deal_scraper.R",
    cmd_args,
    value = TRUE
  )

proj_dir <-
  gsub("--file=", "", proj_dir) %>%
  dirname() %>%
  dirname()

# packt url for free learning deal of the day
packt <- "https://www.packtpub.com/packt/offers/free-learning"


# Scrape book deal of the day -----

# read in html
parse_site <-
  packt %>%
  httr::GET() %>%
  httr::content()

# extract the title of the deal of
# the day and remove any extra
# spacing and indentation around it
book_deal <-
  parse_site %>%
  rvest::html_nodes(".dotd-title") %>%
  rvest::html_text() %>%
  stringr::str_replace_all("\\n*\\t*", "")

# scrape the image for the book

# read in the img string
img_link <-
  parse_site %>%
  rvest::html_nodes(".dotd-main-book-image") %>%
  rvest::html_node("img") %>%
  rvest::html_attr("src") %>%
  stringr::str_replace_all(" ", "%20")

# get the format of today's img
img_formats <- c(".jpg", ".jpeg", ".png")

todays_format <-
  stringr::str_detect(img_link, c(".jpg$", ".jpeg$", ".png$")) %>%
  img_formats[.]

# construct path for saving the img
today_img <-
  paste0("image_",
         format(Sys.Date(), "%d%m%g"),
         todays_format
         )
image_path <- file.path(proj_dir, "data", "img", today_img)

# write out img
img_link %>%
  paste0("http:", .) %>%
  magick::image_read() %>%
  magick::image_write(path = image_path)

# write csv

# path for the csv file
csv_path <- file.path(proj_dir, "data", "packt_book_deals.csv")

# should we append to pre-existing or create new file
append_to_file <- file.exists(csv_path)

readr::write_csv(data_frame( Date = Sys.Date(), Book = book_deal ),
                 path = csv_path,
                 append = append_to_file,
                 col_names = !append_to_file)

# desktop notification
notifier::notify(
  title = "Packt book deal of the day",
  msg = book_deal,
  image = image_path)
