require_relative 'multiplex'

raise "Failed to include showtimes file" if ARGV[0].nil?

# m = Multiplex.new(ARGV[0])
# m.display_showtimes



time_hash = { :weekday_start => "08:00", :weekday_end =>  "23:00", :weekend_start => "10:30", :weekend_end => "23:30", :cleanup_min => 35, :setup_min => 60 }
m2 = Multiplex.new(ARGV[0], :settings_hash => time_hash)
m2.display_showtimes