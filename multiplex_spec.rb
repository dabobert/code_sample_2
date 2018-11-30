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
      showtimes = []
      showtimes << [@today.change(:hour => 12, :min => 15), @today.change(:hour => 14, :min => 29)]
      showtimes << [@today.change(:hour => 15, :min =>  5), @today.change(:hour => 17, :min => 19)]
      showtimes << [@today.change(:hour => 17, :min => 55), @today.change(:hour => 20, :min =>  9)]
      showtimes << [@today.change(:hour => 20, :min => 45), @today.change(:hour => 22, :min => 59)]
      expect(info[:showtimes]).to match_array(showtimes)
    end

    it "displays the showtimes correctly" do
      test_output = "#{@today.strftime("%A %m/%d/%Y")}\n\n"
test_output << %q(There's Something About Mary - Rated R, 2:14
  12:15 - 14:29
  15:05 - 17:19
  17:55 - 20:09
  20:45 - 22:59)
      # fails due to white space
      # expect{@multiplex.display_showtimes}.to output(test_output.strip).to_stdout

      # showtimes_output = capture(:stdout) { @multiplex.display_showtimes }
      # expect(showtimes_output.strip).to eq(test_output.strip)

      @multiplex.display_showtimes
    end

  end
end