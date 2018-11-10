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
      # binding.pry
    end

  end

  # it "finds the factorial of 5" do
  #   calculator = Factorial.new
  #   expect(calculator.factorial_of(5)).to eq(120)
  # end
end