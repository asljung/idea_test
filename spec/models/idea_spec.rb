require 'spec_helper'

describe Idea do

  let(:user) { FactoryGirl.create(:user) }
  before { @idea = user.ideas.build(title: "Title", content: "Lorem ipsum", vote_count: 0, comment_count: 0) }

  subject { @idea }

  it { should respond_to(:title) }
  it { should respond_to(:content) }
  it { should respond_to(:area_id) }
  it { should respond_to(:user_id) }
  it { should respond_to(:user) }
  it { should respond_to(:voters) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "when user_id is not present" do
    before { @idea.user_id = nil }
    it { should_not be_valid }
  end

  describe "with no title" do
    before { @idea.title = " " }
    it { should_not be_valid }
  end

  describe "with blank content" do
    before { @idea.content = " " }
    it { should_not be_valid }
  end

  describe "with content that is too long" do
    before { @idea.content = "a" * 2200 }
    it { should_not be_valid }
  end
  
  describe "voting" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      @idea.save
      expect{user.vote!(@idea)}.to change{@idea.vote_count}.from(0).to(1)
    end
    its(:voters) { should include(user) }
    it { should be_voted(user) }

    describe "and unvoting" do
      before { user.unvote!(@idea) }
      it { should_not be_voted(user) }
    end
  end

  describe "commenting" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      @idea.save
      expect{user.comments.build(title: "Title", body: "Lorem ipsum", commentable: @idea)}.to change{@idea.comment_count}.from(0).to(1)
    end
    
  end

end
