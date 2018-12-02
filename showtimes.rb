require_relative 'multiplex'

raise "Failed to include showtimes file" if ARGV[0].nil?

m = Multiplex.new(ARGV[0])
m.display_showtimes