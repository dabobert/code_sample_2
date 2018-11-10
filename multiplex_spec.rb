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
      @multiplex         = Multiplex.new(test_data_path, test_settings_path)
    end

    it "properly parsed the settings yml" do
      today = Time.now.beginning_of_day
      expect(@multiplex.open_time).to eq(today.change(:hour => 10, :min => 30))
      expect(@multiplex.start_time).to eq(today.change(:hour => 11, :min => 30))
      expect(@multiplex.close_time).to eq(today.change(:hour => 23, :min => 30))
      expect(@multiplex.cleanup_time).to eq(2100.seconds)
      expect(@multiplex.hours_open).to eq(43200.0)
    end

  end

  # it "finds the factorial of 5" do
  #   calculator = Factorial.new
  #   expect(calculator.factorial_of(5)).to eq(120)
  # end
end