require 'spec_helper'

describe Vote do

  let(:user) { FactoryGirl.create(:user) }
  let(:idea) { FactoryGirl.create(:idea) }
  let(:vote) { user.votes.build(idea_id: idea.id) }

  subject { vote }

  it { should be_valid }

  describe "Vote methods" do
    it { should respond_to(:user) }
    it { should respond_to(:idea) }
    its(:user) { should eq user }
    its(:idea) { should eq idea }
  end

  describe "when user id is not present" do
    before { vote.user_id = nil }
    it { should_not be_valid }
  end

  describe "when idea id is not present" do
    before { vote.idea_id = nil }
    it { should_not be_valid }
  end
end