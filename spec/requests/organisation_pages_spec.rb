require 'spec_helper'

describe "Organisations pages" do

  subject { page }
  let(:org) { FactoryGirl.create(:organisation) }
  let!(:user) { FactoryGirl.create(:user, organisation: org) }
  

  describe "show" do
    before { sign_in user }
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

  describe "new" do
    before { visit new_organisation_path }

    describe "fill in correct information" do

      before { 
        fill_in 'organisation_name', with: "Test Company" 
        fill_in 'organisation_subdomain', with: "company"
        fill_in 'organisation_users_attributes_0_name', with: "admin"
        fill_in 'organisation_users_attributes_0_email', with: "admin@company.com"
        fill_in 'organisation_users_attributes_0_password', with: "foobar"
        fill_in 'organisation_users_attributes_0_password_confirmation', with: "foobar"
      }
      it "should create a organisation" do
        expect { click_button "Create my account" }.to change(Organisation, :count).by(1)
      end
    end

  end
  
end
