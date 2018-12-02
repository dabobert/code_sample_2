
require_relative 'theater_chain'

raise "Failed to include showtimes file" if ARGV[0].nil?

# m = Multiplex.new(ARGV[0])
# m.display_showtimes



chain = TheaterChain.new(ARGV[0])
chain.display_showtimes