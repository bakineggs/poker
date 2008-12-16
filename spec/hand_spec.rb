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
      @pair.should be_pair
      @two_pair.should be_pair
      @set.should be_pair
      @quads.should be_pair
      @full_house.should be_pair
    end

    it "should return false without a pair" do
      @high_card.should_not be_pair
      @flush.should_not be_pair
      @straight.should_not be_pair
    end
  end

  describe '#two_pair?' do
    it "should return true with two pair" do
      @two_pair.should be_two_pair
      @full_house.should be_two_pair
    end

    it "should return false without" do
      @quads.should_not be_two_pair
      @set.should_not be_two_pair
      @flush.should_not be_two_pair
    end
  end

  describe '#set?' do
    it "should return true with a set" do
      @set.should be_set
      @quads.should be_set
      @full_house.should be_set
    end

    it "should return false without one" do
      @two_pair.should_not be_set
      @pair.should_not be_set
      @high_card.should_not be_set
      @flush.should_not be_set
    end
  end

  describe '#full_house?' do
    it "should return true with a full house" do
      @full_house.should be_full_house
    end

    it "should return false without a full house" do
      @two_pair.should_not be_full_house
      @quads.should_not be_full_house
      @flush.should_not be_full_house
    end
  end

  describe '#quads?' do
    it "should return true with quads" do
      @quads.should be_quads
    end

    it "should return false without" do
      @set.should_not be_quads
      @two_pair.should_not be_quads
    end
  end
end
