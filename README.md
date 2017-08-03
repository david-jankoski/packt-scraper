## Packt Book of the Day Scraper

A small project that pushes desktop notifications to the user about free book of the day deal from the Packt website.  

## Packt Website

[Packt](https://www.packtpub.com/) is a website that offers learning materials for various kinds of IT related things. Each day there is a different book offered as a book-of-the-day deal for [free](https://www.packtpub.com/packt/offers/free-learning)! In order to get the book just head over to their website and make yourself an account which enables you to download the books in couple of different formats.  

## Motivation  

Usually (at least for me) these things end up in some dark corner in the bookmarks - maybe I would go back and check the website for a couple of days in a row, but then I would slowly forget about it and every now and then remember to check back in on some free learning materials.  
So I thought to piece together a small scraper that would get the book deal of the day and push a desktop notification when i log in. That way I could stay informed and never miss the chance to obtain some nice material on a topic of interest.  

## Code

The code is really just 2 `R` scripts sitting in the `R/` dir.  

 - [`packt_book_deal_scraper`](R/packt_book_deal_scraper.R) is the main script which goes out and grabs the title and the associated cover image of the book deal of the day. It uses the handy [notifier](https://github.com/gaborcsardi/notifier) package by [Gábor Csárdi](https://github.com/gaborcsardi) to push a desktop notification to the user. Additionally I was interested in doing some analysis of the languages, technologies and frameworks that are being offered over time - so it stores all the info in a csv file as well.  
 
 - [`check_and_run_scraper`](R/check_and_run_scraper.R) is the script that gets executed on each user log on. It checks if it already has today's information in the `data/` dir and launches the scraper if not, otherwise it does nothing.  

In the [`data/`](data/) dir some sample data and images can be found.


### Scheduling the scraper

I included a short explanation on easy ways to turn this into a scheduled task on linux and windows machines in [`schedule_scraper`](schedule_scraper.md)

### To Do 

 - For the analysis part need to find a way how to automatically detect the keyword that stands for a certain language/technology from the book title. I'm sure there is somewhere out there a nice list of all possible languages and technologies under the sun that could be matched against.  
 
 - A possible adaptation for the purpose of this scraper would be to just store some keywords that one is interested in like e.g. "machine learning", "data structures c" and fuzzy-match against it in order to signal an offer tailored to one's interests.  
 

In case anyone ever reads this far - thanks for taking the time and please let me know what doesn't work as expected and we'll fix things together.  
