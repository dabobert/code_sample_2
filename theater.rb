require 'pry'
require 'csv'
require 'active_support'
require 'active_support/core_ext/numeric/time'
# require 'active_support/core_ext/date/calculations'
# require 'active_support/core_ext/time/calculations'
# require 'active_support/core_ext/date_time/calculations'

# Assmptions
# 1: A 


class Theater

  def initialize(file)
    @file = file
    Time.new(Time.now.year,1,1, 13,30,0)
    @weekday_start = "08:00" #"08:00am"
    @weekday_end   = "23:00" #"11:00pm"
    @weekend_start = "10:30" #"10:30am"
    @weekend_end   = "23:30" #"11:30pm"
    @wee
    parse_movies
  end


  def parse_movies
    CSV.foreach(@file, :encoding=>"windows-1251:utf-8",:headers => true) do |orig_row|
      row = Hash[orig_row.to_hash.map { |k, v| [k.to_s.strip.downcase.gsub(" ","_").to_sym, v.to_s.encode("utf-8", "binary", :undef => :replace).strip] }]
      binding.pry
    end
  end


end