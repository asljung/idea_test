require 'spec_helper'

describe "Organisations pages" do

  subject { page }
  let(:org) { FactoryGirl.create(:organisation) }
  let!(:user) { FactoryGirl.create(:user, organisation: org) }
  before { sign_in user }

  describe "show" do
    let!(:user) { FactoryGirl.create(:user, organisation: org) }
    let!(:area) { FactoryGirl.create(:area, organisation: org) }
    let!(:i1) { FactoryGirl.create(:idea, area: area, user: user, title: "Idea title", content: "Foo") }

    before { visit organisation_path(org) }
    it { should have_title(org.name) }
    it { should have_content(org.name) }
    it { should have_content(org.description) }
    it { should have_content(area.title) }
    it { should have_content(i1.content) }
    it { should have_content(i1.title) }
    
  end
  
end
