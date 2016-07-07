require 'nokogiri'
require 'open-uri'
require_relative '../helpers.rb'

def scrapeHeliopolis (titles, dates, urls, locations)
	beginLength = titles.length
	count = 0
	puts "Beginning to scrape Heliopolis event list..."
	link = "http://heliopolis.la/events/"
	location = "Shreveport/Bossier"
	while count < 2 do
		handleCss = "h2.tribe-events-list-event-title a.tribe-event-url"
		
		#open link and get paths
		paths = getPaths(link, handleCss)

		#showPaths(paths)
		
		titleCss = "h1.tribe-events-single-event-title"
		dateCss = "div.tribe-events-schedule.tribe-clearfix h2"

		# append data to titles, dates, and urls arrays
		paths.each do |path|
			getData(path, titleCss, dateCss, titles, dates, urls, locations, location)
		end
		# next link, kind of hacky, but they have some ajax that prevents grabbing the URL from the next button element
		link = "http://heliopolis.la/events/?action=tribe_photo&tribe_paged=2&tribe_event_display=photo"
		count = count + 1
	end

	# showData(titles, dates, urls, locations)

	#trimming dates
	dates.each do |date|
		date = date.split("at").first
	end

	puts "Added #{titles.length - beginLength} events"

	puts "Completed scraping of Heliopolis event list"
	return titles, dates, urls, locations
end