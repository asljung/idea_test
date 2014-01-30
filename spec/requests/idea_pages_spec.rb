require 'spec_helper'

describe "Idea pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  before { sign_in user }

  describe "main idea creation" do
    before { visit submit_path }

    describe "with invalid information" do

      it "should not create a idea" do
        expect { click_button "Submit" }.not_to change(Idea, :count)
      end

      describe "error messages" do
        before { click_button "Submit" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'idea_content', with: "Lorem ipsum" 
          fill_in 'idea_title', with: "Lorem"}
      it "should create a idea" do
        expect { click_button "Submit" }.to change(Idea, :count).by(1)
      end
    end
  end

  describe "idea creation" do
    before { visit root_path }

    describe "with invalid information" do

      it "should not create a idea" do
        expect { click_button "Submit" }.not_to change(Idea, :count)
      end

      describe "error messages" do
        before { click_button "Submit" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before { fill_in 'idea_content', with: "Lorem ipsum" 
          fill_in 'idea_title', with: "Lorem"}
      it "should create a idea" do
        expect { click_button "Submit" }.to change(Idea, :count).by(1)
      end
    end
  end

  describe "idea destruction" do
    before { FactoryGirl.create(:idea, user: user) }

    describe "as correct user" do
      before { visit root_path }

      it "should delete a idea" do
        expect { click_link "Delete" }.to change(Idea, :count).by(-1)
      end
    end
  end

  describe "show" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:i1) { FactoryGirl.create(:idea, user: user, title: "Title", content: "Foo") }

    before { visit idea_path(i1) }

    it { should have_content(i1.content) }
    it { should have_title(i1.title) }

    describe "add comment form" do
      before {fill_in 'comment_body', with:"Lorem Ipsum"}
      it "should create comment" do
      expect { click_button "Post Comment" }.to change(Comment, :count).by(1)
    end
    end

    describe "comments" do
      let!(:c1) { FactoryGirl.create(:comment, user: user, commentable: i1) }
      it { should have_content(c1.body) }
      it { should have_content(c1.title) }
    end

  end

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:i1) { FactoryGirl.create(:idea, user: user, title: "Title", content: "Foo") }

    before do
      sign_in user
      visit edit_idea_path(i1)
    end

    describe "page" do
      it { should have_content("Update your idea") }
      it { should have_title("Edit idea") }
    end

    describe "with invalid information" do
      before do
        fill_in "Title", with: " " 
        click_button "Save changes"
      end

      it { should have_content('error') }
    end

    describe "with valid information" do
      let(:new_title)  { "New Title" }
      let(:new_content) { "New Content" }
      before do
        fill_in "Title",             with: new_title
        fill_in "Content",            with: new_content
        click_button "Save changes"
      end

      it { should have_title(new_title) }
      it { should have_content(new_content) }
      it { should have_selector('div.alert.alert-success') }
      specify { expect(i1.reload.title).to  eq new_title }
      specify { expect(i1.reload.content).to eq new_content }
    end
  end
end
