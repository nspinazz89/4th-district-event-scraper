require 'nokogiri'
require 'open-uri'
require_relative '../helpers.rb'

def scrapeMansfield (titles, dates, urls, locations)
	beginLength = titles.length
	count = 0
	puts "Beginning to scrape Mansfield event list..."
	link = "http://www.townplanner.com/index.php?"
	location = "Mansfield"
	while count < 7 do
		handleCss = "div.shelf h6 a"
		
		#open link and get paths
		paths = getPaths(link, handleCss)

		#showPaths(paths)
			
		titleCss = "div.container div.contact.eleven.columns h3"
		dateCss = "div.five.columns p.semi.title.style-2 strong"

		# append data to titles, dates, and urls arrays
		paths.each do |path|
			getData(path, titleCss, dateCss, titles, dates, urls, locations, location)
		end
		# next link, because this website has some very weird stuff going in how it paginates
		nokoCss = "div.pagination ul.pages li a"
		handle = Nokogiri::HTML(open(link, 'User-Agent' => 'chrome'))
		if count == 0
			newLink = handle.css(nokoCss)[0]['href']
			link = "http://www.townplanner.com/#{newLink}"
		else
			newLink = handle.css(nokoCss)[1]['href']
			link = "http://www.townplanner.com/#{newLink}"
		end
		
		count = count + 1
		
	end
	showData(titles, dates, urls, locations)
	

	puts "Added #{titles.length - beginLength} events"

	puts "Completed scraping of Mansfield event list"
	return titles, dates, urls, locations
end