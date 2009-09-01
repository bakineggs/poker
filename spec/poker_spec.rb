require File.dirname(__FILE__) + '/helper'

describe Poker do
  it 'should provide its version' do
    Poker::VERSION.should == '1.3'
  end
end
