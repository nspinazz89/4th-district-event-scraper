require 'nokogiri'
require 'open-uri'
require_relative '../helpers.rb'

def scrapeWebster (titles, dates, urls, locations)
	beginLength = titles.length
	puts "Beginning to scrape Webster event list..."
	link = "http://www.visitwebster.net/events"
	websterCss = "div.LeftColumn div.sfContentBlock p strong a"
	location = "Webster"
	
	#open link and get paths
	paths = getPaths(link, websterCss)
	
	titleCss = "div.sfeventDetails h1.sfeventTitle"
	dateCss = "div.sfeventDetails h2"

	# append data to titles, dates, and urls arrays
	paths.each do |path|
		getData(path, titleCss, dateCss, titles, dates, urls, locations, location)
	end

	puts "Added #{titles.length - beginLength} events"

	puts "Completed scraping of Webster ever list"
	return titles, dates, urls, locations
end