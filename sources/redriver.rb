require 'nokogiri'
require 'open-uri'
require_relative '../helpers.rb'

def scrapeRedRiver (titles, dates, urls, locations)
	beginLength = titles.length
	location = "Red River"
	
	puts "Beginning to scrape Red River event list..."
	link = "http://redriverparish.org/chamberevents/list/"
	titleCss = "div.av-tribe-events-content-wrap h2 a"
	dateCss = "div.tribe-events-event-meta div.tribe-event-schedule-details"

	# get data from current calendar page
	getsDataMultiple(link, titleCss, dateCss, titles, dates, urls, locations, location)

	# showData(titles, dates, urls, locations)
	
	puts "Added #{titles.length - beginLength} events"

	puts "Completed scraping of Red River event list"
	return titles, dates, urls, locations
end