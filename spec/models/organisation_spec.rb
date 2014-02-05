require 'spec_helper'

describe Organisation do
  before do
    @org = Organisation.new(name: "Name", description: "Lorem Ipsum", area_description: "Lorem Ipsum")
  end

  subject { @org }

  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { should respond_to(:area_description) }

  it { should be_valid }


  describe "with no name" do
    before { @org.name = " " }
    it { should_not be_valid }
  end

  describe "with description that is too long" do
    before { @org.description = "a" * 1200 }
    it { should_not be_valid }
  end
end
