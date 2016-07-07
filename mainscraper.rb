require 'nokogiri'
require 'open-uri'
require 'csv'
require 'sequel'

require './helpers.rb'
require './eventmodel.rb'
require './mailer.rb'


Dir["./sources/*.rb"].each {|file| require file }

# arrays to store data
events = []
titles = []
dates = []
urls = []
locations = []

# scrape all relevant sources
scrapeCaddo(titles, dates, urls, locations)
scrapeShreveChamber(titles, dates, urls, locations)
scrapeBossierChamber(titles, dates, urls, locations)
scrapeWebster(titles, dates, urls, locations)
scrapeHeliopolis(titles, dates, urls, locations)
scrapeNatchitoches(titles, dates, urls, locations)
scrapeLeesville(titles, dates, urls, locations)
scrapeBeauregard(titles, dates, urls, locations)
scrapeVillePlatte(titles, dates, urls, locations)
scrapeStLandry(titles, dates, urls, locations)
scrapeRedRiver(titles, dates, urls, locations)
scrapeSabine(titles, dates, urls, locations)

# iterate over titles, dates, and urls and create a new event object for each
eventsLength = titles.length
for i in 0..eventsLength-1
	events << Event.new(titles[i], dates[i], urls[i], locations[i])
end

# create a local Sequel database to store all events 
DB = Sequel.sqlite("./events.db")

# create a database handle
eventDB = DB[:events]

# create a counter to keep track of new events added on each run
newEventCount = 0
newEventArray = []
# iterate over events array and insert events in database, successful insert increases newEventCount, otherwise catch the exception
events.each do |event|
	begin
		eventDB.insert(
			:title => event.get_title, 
			:date => event.get_date, 
			:url => event.get_url, 
			:location => event.get_location
			)

		newEventCount += 1
		newEventArray << event.get_title
	rescue Sequel::UniqueConstraintViolation
	end
end

puts "Writing to CSV"

# write data to CSV
CSV.open("events.csv", "w") do |csv|
	csv << ["Title", "Date", "URL", "Location"]
	for event in events
		csv << [event.get_title, event.get_date, event.get_url, event.get_location]
	end
end

puts "Sending Email"
sendEmail(newEventCount, newEventArray)



