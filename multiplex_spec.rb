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
      expect(@multiplex.open_time).to eq(@today.change(:hour => 10, :min => 30))
      expect(@multiplex.start_time).to eq(@today.change(:hour => 11, :min => 30))
      expect(@multiplex.close_time).to eq(@today.change(:hour => 23, :min => 30))
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

  end
end