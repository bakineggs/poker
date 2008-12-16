require File.dirname(__FILE__) + '/helper'

describe Hand, '#pair?' do
  it "should return true with multiple cards of the same value" do
    hand = Hand.new(
      Card.new('Spades', 6),
      Card.new('Clubs', 9),
      Card.new('Diamonds', 5),
      Card.new('Diamonds', 6),
      Card.new('Hearts', 4)
    )
    hand.pair?.should == true
  end

  it "should return false if there are no paired cards" do
    hand = Hand.new(
      Card.new('Spades', 6),
      Card.new('Clubs', 9),
      Card.new('Diamonds', 5),
      Card.new('Diamonds', 7),
      Card.new('Hearts', 4)
    )
    hand.pair?.should == false
  end
end
