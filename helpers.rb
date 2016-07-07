require 'nokogiri'
require 'open-uri'

#helper method
def is_numeric?(s)
  begin
    Float(s)
  rescue
    false # not numeric
  else
    true # numeric
  end
end

#opens a link and returns an array of paths
def getPaths(link, nokoCss)
	
	handle = Nokogiri::HTML(open(link, 'User-Agent' => 'chrome'))
	links = []
	links << handle.css(nokoCss)
	paths = []
	links[0].each do |link|
		paths << link['href']
	end

	return paths
end

#opens a link and returns an array of paths
def getPathsAppend(link, nokoCss, mainLink)
	
	handle = Nokogiri::HTML(open(link, 'User-Agent' => 'chrome'))
	links = []
	links << handle.css(nokoCss)
	paths = []
	links[0].each do |link|
		paths << link['href']
	end
	newPaths = paths.map { |path| "#{mainLink}#{path}" }

	return newPaths
end

#gets data and inputs it into titles, dates, and urls arrays
def getData(path, nokoTitles, nokoDates, titles, dates, urls, locations, location)
	event = Nokogiri::HTML(open(path, 'User-Agent' => 'chrome'))
	titles << event.css(nokoTitles).text
	dates << event.css(nokoDates).text
	urls << path
	locations << location

end

# gets data, flattens and stores in titles, dates and urls arrays
def getsDataMultiple(path, nokoTitles, nokoDates, titles, dates, urls, locations, location)
	handle = Nokogiri::HTML(open(path, 'User-Agent' => 'chrome'))
	tempTitles = []
	tempDates = []
	tempTitles << handle.css(nokoTitles)
	tempDates << handle.css(nokoDates)

	tempTitles[0].each do |tempTitle|
		titles << tempTitle.text
		urls << path
		locations << location
	end
	
	tempDates[0].each do |tempDate|
		dates << tempDate.text
	end

end


#gets new link for next page
def getsNext(path, nokoCss)
	handle = Nokogiri::HTML(open(path, 'User-Agent' => 'chrome'))
	newLink = handle.css(nokoCss)[0]['href']
	return newLink
end

def getsNextAppend(path, nokoCss, mainLink)
	handle = Nokogiri::HTML(open(path, 'User-Agent' => 'chrome'))
	newLink = handle.css(nokoCss)[0]['href']
	nextLink = "#{mainLink}#{newLink}"
	return nextLink
end

# shows content of all current arrays
def showData(titles, dates, urls, locations)
	titles.each do |title|
		puts title
	end

	dates.each do |date|
		puts date
	end

	urls.each do |url|
		puts url
	end

	locations.each do |location|
		puts location
	end
end

# shows content of paths
def showPaths(paths)
	paths.each do |path|
		puts path
	end
end











