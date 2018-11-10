require_relative 'multiplex'


describe Multiplex do

  it "converts time string to duration object" do
    string_time = "10:00"
    time_obj = Multiplex.convert_time_to_minutes_obj(string_time)
    expect(time_obj).to eq(10.hours)
  end


  describe "valid instance" do

    before do
      test_settings_path = File.join(__dir__, 'test_settings.yml')
      test_data_path     = File.join(__dir__, 'test_data.csv')
      @today             = Time.now.beginning_of_day
      @multiplex         = Multiplex.new(test_data_path, test_settings_path)
    end

    it "properly parsed the settings yml" do
      expect(@multiplex.open_time).to eq(@today.change(:hour => 10))
      expect(@multiplex.start_time).to eq(@today.change(:hour => 11))
      expect(@multiplex.close_time).to eq(@today.change(:hour => 23))
      expect(@multiplex.cleanup_time).to eq(2100.seconds)
      expect(@multiplex.hours_open).to eq(43200.0)
    end

    it "understands weekday_hours" do
      Multiplex::WEEKDAYS.each do |day|
        expect(@multiplex.weekday_hours?(day)).to be(true)
      end
    end

    it "understands weekend_hours" do
      Multiplex::WEEKENDS.each do |day|
        expect(@multiplex.weekday_hours?(day)).to be(false)
      end
    end

    it "parsed the showtimes correctly" do
      info = @multiplex.schedule[0]
      expect(info[:movie_title]).to eq("There's Something About Mary")
      expect(info[:release_year]).to eq("1998")
      expect(info[:mpaa_rating]).to eq("R")
      expect(info[:run_time]).to eq("2:14")



 # [{:movie_title=>,
 #  :release_year=>"1998",
 #  :mpaa_rating=>"R",
 #  :run_time=>"2:14",
 #  :showtimes=>
 #   [[2018-11-10 12:45:00 -0500, 2018-11-10 14:59:00 -0500],
 #    [2018-11-10 15:35:00 -0500, 2018-11-10 17:49:00 -0500],
 #    [2018-11-10 18:25:00 -0500, 2018-11-10 20:39:00 -0500],
 #    [2018-11-10 21:15:00 -0500, 2018-11-10 23:29:00 -0500]]}



    end

  end
end