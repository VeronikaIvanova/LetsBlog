require 'spec_helper'

describe Post do
   before do
    @post = Post.new(title:"Lorem ipsum", context: "Lorem ipsum", user_id: 1)
  end

  subject { @post }

  it { should respond_to(:title) }
  it { should respond_to(:context) }
  it { should respond_to(:user_id) }
  it { should be_valid }

  describe "when user_id is not present" do
    before { @micropost.user_id = nil }
    it { should_not be_valid }
  end
end
