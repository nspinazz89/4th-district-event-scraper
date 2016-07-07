require 'nokogiri'
require 'open-uri'
require_relative '../helpers.rb'

def scrapeVillePlatte (titles, dates, urls, locations)
	beginLength = titles.length
	count = 0
	puts "Beginning to scrape Ville Platte event list..."
	link = "http://www.villeplattechamber.com/up-coming-2/"
	location = "Ville Platte"
	
	handleCss = "div.event-link a.event-title"
	
	#open link and get paths
	paths = getPaths(link, handleCss)

	#showPaths(paths)
	
	titleCss = "header.entry-header h2.entry-title"
	dateCss = "div.entry-content span.entry-date.date"

	# append data to titles, dates, and urls arrays
	paths.each do |path|
		getData(path, titleCss, dateCss, titles, dates, urls, locations, location)
	end
	
	#showData(titles, dates, urls, locations)
	
	puts "Added #{titles.length - beginLength} events"

	puts "Completed scraping of Ville Platte event list"
	return titles, dates, urls, locations
end