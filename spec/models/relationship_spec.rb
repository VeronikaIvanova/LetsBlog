require 'spec_helper'

describe Relationship do
  describe "follower methods" do
    it { should respond_to(:follower) }
    it { should respond_to(:followed) }

 
  end
end
