require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  before do
    @task = user.tasks.build(title:'hoge')
  end
  subject { @task }

  it { should respond_to :title }
  it { should respond_to :user_id }
  it { should respond_to(:user) }
  its(:user) { should eq user }

  describe "when user_id is not present" do
    before { @task.user_id = nil }
    it { should_not be_valid }
  end
end
