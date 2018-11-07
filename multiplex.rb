# gem: debugging tools
require 'pry'
# core: parse csv files
require 'csv' 
# core: loads  settings file
require 'yaml'
# gem: handles rounding
require 'rounding'
# gem: date/time arithmetic
require 'active_support'
require 'active_support/core_ext/numeric/time'

# Assmptions
# 1: A theater will be cleaned after it's showing.  This will allow the movie to start immediatly at the beginning of the day


class Multiplex

  # converts a time in format hh:mm to ActiveSupport::Duration object
  def self.convert_time_to_minutes_obj(string_time)
    hours, min  = string_time.split(":")
    hours.to_i.hours + min.to_i.minutes
  end

  def initialize(file)
    @file = file
    @today = Time.now.beginning_of_day
    @schedule = []
    parse_settings
    parse_showtimes
  end

  def parse_showtimes
    CSV.foreach(@file, :encoding=>"windows-1251:utf-8",:headers => true) do |orig_row|
      row = Hash[orig_row.to_hash.map { |k, v| [k.to_s.strip.downcase.gsub(" ","_").to_sym, v.to_s.encode("utf-8", "binary", :undef => :replace).strip] }]
      info = row
      showtimes = []
      run_time = Multiplex.convert_time_to_minutes_obj(row[:run_time])

      last = @close_time - run_time
      loop do
        # round minutes to the latest 5 minute increment
        rounded_minutes = last.strftime("%M").to_i.floor_to(5)
        # set last to the computed current with the rounded minutes
        last = last.change :min => rounded_minutes
        showtimes << [last, last + run_time]
        # decrement last showing by cleanup time
        last = last - @cleanup_time - run_time
        break if last < @start_time
      end
      @schedule << info.merge(:showtimes => showtimes.reverse)
    end
  end

  def parse_settings
    # load the settings
    settings = YAML::load_file(File.join(__dir__, 'settings.yml'))
    # for testing purposes day of the week can be set via the settings
    day_of_week = settings[:day_of_week] || @today.wday
    # check if today is a weekday or not
    if [1,2,3,4].include?(@today.wday)
      key = "weekday"
    else
      key = "weekend"
    end
    # doing all of this so we can use activesupport's date/time arithmetic functionality
    #   create open time object
    @open_time   = @today + Multiplex.convert_time_to_minutes_obj(settings["#{key}_start".to_sym])
    @start_time  = @open_time + settings[:setup_min].to_i.minutes
    @close_time  = @today + Multiplex.convert_time_to_minutes_obj(settings["#{key}_end".to_sym])
    @cleanup_time= settings[:cleanup_min].to_i.minutes
    @hours_open  = @close_time - @start_time
  end


  def display_showtimes
    puts @today.strftime("%A %m/%d/%Y")
    @schedule.each do |movie_info|
      puts
      puts "#{movie_info[:movie_title]} - Rated #{movie_info[:mpaa_rating]}, #{movie_info[:run_time]}"
      movie_info[:showtimes].each do |showtimes|
        puts "  #{showtimes[0].strftime("%H:%M")} - #{showtimes[1].strftime("%H:%M")}"
      end
    end
  end

end