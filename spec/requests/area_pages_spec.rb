require 'spec_helper'

describe "Area pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "show" do
    let(:user) { FactoryGirl.create(:user) }
    let(:area) { FactoryGirl.create(:area) }
    let!(:i1) { FactoryGirl.create(:idea, area: area, user: user, title: "Idea title", content: "Foo") }

    before { visit area_path(area) }
    it { should have_content(area.description) }
    it { should have_title(area.title) }
    it { should have_content(i1.content) }
    it { should have_content(i1.title) }
    
  end

end
