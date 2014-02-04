require 'spec_helper'

describe Area do
  before do
    @area = Area.new(title: "Title", description: "Lorem Ipsum")
  end

  subject { @area }

  it { should respond_to(:title) }
  it { should respond_to(:description) }

  it { should be_valid }


  describe "with no title" do
    before { @area.title = " " }
    it { should_not be_valid }
  end

  describe "with blank description" do
    before { @area.description = " " }
    it { should_not be_valid }
  end

  describe "with description that is too long" do
    before { @area.description = "a" * 1200 }
    it { should_not be_valid }
  end
end
