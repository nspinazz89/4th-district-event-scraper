require 'nokogiri'
require 'open-uri'
require_relative '../helpers.rb'

def scrapeStLandry (titles, dates, urls, locations)
	beginLength = titles.length
	location = "St. Landry"
	
	puts "Beginning to scrape St. Landry event list..."
	link = "http://www.cajuntravel.com/events.php?startdate=06%2F29%2F2016&enddate=11%2F30%2F2016&city=eunice&category=all&limit=all"
	titleCss = "div.text span.title-link"
	dateCss = "li.clearfix span.city"

	# get data from current calendar page
	getsDataMultiple(link, titleCss, dateCss, titles, dates, urls, locations, location)
	
	puts "Added #{titles.length - beginLength} events"

	puts "Completed scraping of St. Landry event list"
	return titles, dates, urls, locations
end