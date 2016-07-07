require 'mail'

def sendEmail(newEventCount, newEventArray)

	if newEventArray.to_a.empty? == true
		emailBodyText = "No new events were added this week."
	else
		newEventString = "The new events are: "
		newEventArray.each do |event|
			newEventString = newEventString + event + "\n"
		end
		emailBodyText = "#{newEventCount} events were added this week. #{newEventString}"
	end	

	options = { :address => "smtp.gmail.com",
				:port => 587,
				:domain => '',
				:user_name => '',
				:password => '',
				:authentication => 'plain',
				:enable_starttls_auto => true }

	Mail.defaults do 
		delivery_method :smtp, options
	end

	mail = Mail.new do 
		from ''
		to ''
		subject 'Weekly Scrape Results'
		body emailBodyText

		add_file './events.csv'
	end

	mail.deliver!
end