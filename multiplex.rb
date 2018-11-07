# debugging tools
require 'pry'
# parse csv files
require 'csv' 
# loads  settings file
require 'yaml'
# date/time arrithmetic
require 'active_support'
require 'active_support/core_ext/numeric/time'

# Assmptions
# 1: A theater will be cleaned after it's showing.  This will allow the movie to start immediatly at the beginning of the day


class Multiplex

  def initialize(file)
    @file = file
    # load the settings
    YAML::load_file(File.join(__dir__, 'settings.yml'))
    parse_movies
  end


  def parse_movies
    CSV.foreach(@file, :encoding=>"windows-1251:utf-8",:headers => true) do |orig_row|
      row = Hash[orig_row.to_hash.map { |k, v| [k.to_s.strip.downcase.gsub(" ","_").to_sym, v.to_s.encode("utf-8", "binary", :undef => :replace).strip] }]
      theater = Theater.new(row)
    end
  end


  def theater(row)

  end

end