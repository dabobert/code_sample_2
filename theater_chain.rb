require_relative 'multiplex'
require 'pry'

class TheaterChain

	# code we did together
  def initialize(file, path_to_settings=File.join(__dir__, 'settings_theater_chain.yml'))
    @path_to_settings = path_to_settings
    @file = file
    @today = Time.now.beginning_of_day
    @schedule = []
    parse_settings
  end


  # code we did in the branch that was abandonded
  def parse_mutli_settings_orig
    # load the settings
    @locations = {}
    YAML::load_file(@path_to_settings).each do |location_id, settings|
      # # for testing purposes day of the week can be set via the settings
      # day_of_week = settings[:day_of_week] || @today.wday
      # check if today is a weekday or not
      if weekday_hours?
        key = "weekday"
      else
        key = "weekend"
      end
      
      open_time   = @today + Multiplex.convert_time_to_minutes_obj(settings["#{key}_start".to_sym])
      start_time  = open_time + settings[:setup_min].to_i.minutes
      close_time  = @today + Multiplex.convert_time_to_minutes_obj(settings["#{key}_end".to_sym])
      cleanup_time= settings[:cleanup_min].to_i.minutes
      hours_open  = close_time - start_time
      time_info = {:open_time => open_time, :start_time => start_time, :close_time => close_time, :cleanup_time => cleanup_time, :hours_open => hours_open}
      @locations[location_id] = time_info
    end
  end

  # new code: no need to parse the values from the yml, just put them in a hash
  def parse_settings
    # load the settings
    @raw_location_settings = {}
    YAML::load_file(@path_to_settings).each do |location_id, settings|
      @raw_location_settings[location_id] = settings
    end
  end



  # new code: display times for all theatres
  def display_showtimes
  	@raw_location_settings.each do |location_id, settings| 
  		puts "#{location_id}--------"
	  	m2 = Multiplex.new(ARGV[0], :settings_hash => settings)
			m2.display_showtimes
		end
  end

end