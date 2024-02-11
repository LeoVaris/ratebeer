require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "is saved with correct values" do
    br = Brewery.new name: "test", year: 2000
    b = Beer.create name: "testbeer", style: "teststyle", brewery: br

    expect(b).to be_valid
  end

  describe "is not saved" do
    let(:test_brewery) { Brewery.new name: "test", year: 2000 }

    it "without a name" do
      b = Beer.create style: "teststyle", brewery: test_brewery

      expect(b).not_to be_valid
    end

    it "without a style" do
      b = Beer.create name: "testbeer", brewery: test_brewery

      expect(b).not_to be_valid
    end
  end
end
