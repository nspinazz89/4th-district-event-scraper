require 'nokogiri'
require 'open-uri'
require_relative '../helpers.rb'

def scrapeBossierChamber (titles, dates, urls, locations)

	puts "Beginning to scrape from Bossier Chamber"

	beginLength = titles.length
	
	link = "https://bossierchamber.com/what-we-do/events/"
	location = "Shreveport/Bossier"
	handleCss = "table#wp-calendar tbody tr td a"

	paths = getPaths(link, handleCss)
	titleCss = "div.singlePage header.entry-header h1.entry-title"
	dateCss = "ul.eo-event-meta li"
	
	# this is an ugly way to handle the possibility that a page might have multiple events
	# a recursive solution would be more elegant, will think aboout how best to implement this later
	paths.each do |path|
		if path.include? "event/on/"
			subPaths = getPaths(path, "h3.entry-title a")
			subPaths.each do |subPath|
				getData(subPath, titleCss, dateCss, titles, dates, urls, locations, location)
			end
		else
			getData(path, titleCss, dateCss, titles, dates, urls, locations, location)
		end
	end
	# trim dates	
	dates.each do |date|
		date.slice! "Start: "
	end

	puts "Added #{titles.length - beginLength} events"
	puts "Completed scrape of Bossier Chamber"
	return titles, dates, urls, locations
end
