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
    parse_movies
    display_showtimes
  end

  def parse_movies
    puts @today.strftime("%A %m/%d/%Y")
    CSV.foreach(@file, :encoding=>"windows-1251:utf-8",:headers => true) do |orig_row|
      row = Hash[orig_row.to_hash.map { |k, v| [k.to_s.strip.downcase.gsub(" ","_").to_sym, v.to_s.encode("utf-8", "binary", :undef => :replace).strip] }]
      info = row

      run_time = Multiplex.convert_time_to_minutes_obj(row[:run_time])
      total_time = run_time + @buffer_time

      num_viewings = @hours_open.to_i/total_time

      last = @close_time
      showtimes = 0.upto(num_viewings).collect do |i|
        # subtract running time
        value = last - run_time
        # round minutes to the latest 5 minute increment
        rounded_minutes = value.strftime("%M").to_i.floor_to(5)
        # set last to the computed value with the rounded minutes
        last = value.change :min => rounded_minutes
        [last, last + run_time]
      end.reverse
binding.pry
      @schedule << info

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
    #   create close time object
    @close_time  = @today + Multiplex.convert_time_to_minutes_obj(settings["#{key}_end".to_sym])
    @buffer_time = settings[:buffer_min].to_i.minutes
    @hours_open  = @close_time - @open_time
  end


  def display_showtimes
  end

end