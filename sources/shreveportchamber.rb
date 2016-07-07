require 'nokogiri'
require 'open-uri'
require_relative '../helpers.rb'

def scrapeShreveChamber (titles, dates, urls, locations)

	puts "Beginning to scrape from Shreveport Chamber..."
	
	beginLength = titles.length
	count = 0

	# open a link
	link = "http://www.shreveportchamber.org/calendar.php"
	location = "Shreveport/Bossier"
	mainLink = "http://www.shreveportchamber.org"

	while count < 6 do
		handleCss = "table.middle tbody.table-body a.general-small"
		paths = getPaths(link, handleCss)
		# doing this to only get event links and not day links 
		paths.delete_if { |path| path.include? "d="}
		# append path to main for complete paths array 
		completePaths = paths.map { |path| "http://www.shreveportchamber.org/" + path }

		# showPaths(completePaths)
		titleCss = "div.middle_block tr.table-head > td"
		dateCss = "tbody.table-body tr.alt1 span"

		completePaths.each do |path|
			getData(path, titleCss, dateCss, titles, dates, urls, locations, location)
		end
		nextCss = "div.middle_block table.middle tr.table-head td[align='right'] a"
		newLink = getsNextAppend(link, nextCss, mainLink)
		link = newLink
		count = count + 1
	end
	
	#trim titles and dates 
	titles.each do |title|
		title.slice! "Time is in GMT -6 time."
	end
	dates.each do |date|
		date.slice! "Date: "
	end

	# showData(titles, dates, urls, locations)

	puts "Added #{titles.length - beginLength} events"
	puts "Completed scraping of Shreveport Chamber"
	return titles, dates, urls, locations
end


