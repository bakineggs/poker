require File.dirname(__FILE__) + '/helper'

describe Hand do
  before do
    @straight_flush = Hand.new(
      Card.new('Spades', 6),
      Card.new('Spades', 5),
      Card.new('Spades', 9),
      Card.new('Spades', 7),
      Card.new('Spades', 8)
    )
    @quads = Hand.new(
      Card.new('Spades', 6),
      Card.new('Clubs', 6),
      Card.new('Spades', 9),
      Card.new('Hearts', 6),
      Card.new('Diamonds', 6)
    )
    @full_house = Hand.new(
      Card.new('Spades', 6),
      Card.new('Clubs', 6),
      Card.new('Spades', 9),
      Card.new('Hearts', 9),
      Card.new('Diamonds', 6)
    )
    @flush = Hand.new(
      Card.new('Spades', 6),
      Card.new('Spades', 2),
      Card.new('Spades', 11),
      Card.new('Spades', 7),
      Card.new('Spades', 8)
    )
    @straight = Hand.new(
      Card.new('Spades', 6),
      Card.new('Clubs', 10),
      Card.new('Hearts', 9),
      Card.new('Spades', 7),
      Card.new('Diamonds', 8)
    )
    @set = Hand.new(
      Card.new('Spades', 6),
      Card.new('Clubs', 6),
      Card.new('Spades', 12),
      Card.new('Hearts', 9),
      Card.new('Diamonds', 6)
    )
    @two_pair = Hand.new(
      Card.new('Spades', 12),
      Card.new('Clubs', 6),
      Card.new('Spades', 9),
      Card.new('Hearts', 9),
      Card.new('Diamonds', 6)
    )
    @pair = Hand.new(
      Card.new('Spades', 6),
      Card.new('Clubs', 12),
      Card.new('Spades', 14),
      Card.new('Hearts', 9),
      Card.new('Diamonds', 6)
    )
    @high_card = Hand.new(
      Card.new('Spades', 6),
      Card.new('Clubs', 12),
      Card.new('Spades', 14),
      Card.new('Hearts', 9),
      Card.new('Diamonds', 2)
    )
  end

  describe '#pair?' do
    it "should return true with a pair" do
      @pair.pair?.should == true
      @set.pair?.should == true
      @quads.pair?.should == true
      @full_house.pair?.should == true
    end

    it "should return false without a pair" do
      @high_card.pair?.should == false
      @flush.pair?.should == false
      @straight.pair?.should == false
    end
  end

  describe '#set?' do
    it "should return true with a set" do
      @set.set?.should == true
      @quads.set?.should == true
      @full_house.set?.should == true
    end

    it "should return false without one" do
      @two_pair.set?.should == false
      @pair.set?.should == false
      @high_card.set?.should == false
      @flush.set?.should == false
    end
  end
end
