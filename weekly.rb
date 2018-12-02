require_relative 'multiplex'

raise "Failed to include showtimes file" if ARGV[0].nil?

# new code
(0).upto(6).each do |day_index|
	date = (Time.now + (24*day_index).hours).to_s
	m2 = Multiplex.new(ARGV[0], :day_of_week => date)
	m2.display_showtimes
end