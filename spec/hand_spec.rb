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
      Card.new('Hearts', 6),
      Card.new('Spades', 6),
      Card.new('Clubs', 6),
      Card.new('Spades', 7),
      Card.new('Diamonds', 6)
    )
    @full_house = Hand.new(
      Card.new('Spades', 6),
      Card.new('Hearts', 6),
      Card.new('Diamonds', 6),
      Card.new('Spades', 7),
      Card.new('Clubs', 7)
    )
    @flush = Hand.new(
      Card.new('Spades', 6),
      Card.new('Spades', 12),
      Card.new('Spades', 3),
      Card.new('Spades', 7),
      Card.new('Spades', 8)
    )
    @straight = Hand.new(
      Card.new('Spades', 6),
      Card.new('Clubs', 5),
      Card.new('Spades', 9),
      Card.new('Diamonds', 7),
      Card.new('Hearts', 8)
    )
    @set = Hand.new(
      Card.new('Spades', 6),
      Card.new('Hearts', 6),
      Card.new('Spades', 9),
      Card.new('Clubs', 6),
      Card.new('Diamonds', 8)
    )
    @two_pair = Hand.new(
      Card.new('Spades', 6),
      Card.new('Hearts', 5),
      Card.new('Clubs', 6),
      Card.new('Diamonds', 5),
      Card.new('Spades', 8)
    )
    @pair = Hand.new(
      Card.new('Hearts', 6),
      Card.new('Spades', 5),
      Card.new('Clubs', 8),
      Card.new('Diamonds', 7),
      Card.new('Spades', 8)
    )
    @high_card = Hand.new(
      Card.new('Hearts', 6),
      Card.new('Spades', 12),
      Card.new('Diamonds', 4),
      Card.new('Clubs', 7),
      Card.new('Diamonds', 11)
    )
  end

  describe 'straight flush' do
    it 'should be a straight flush' do
      @straight_flush.should be_straight_flush
    end

    it 'should be a flush' do
      @straight_flush.should be_flush
    end

    it 'should be a straight' do
      @straight_flush.should be_straight
    end

    it 'should not be anything else' do
      @straight_flush.should_not be_pair
      @straight_flush.should_not be_two_pair
      @straight_flush.should_not be_set
      @straight_flush.should_not be_full_house
      @straight_flush.should_not be_quads
    end

    describe 'wheel' do
      it 'should be a straight flush' do
        Hand.new(
          Card.new('Spades', 14),
          Card.new('Spades', 2),
          Card.new('Spades', 3),
          Card.new('Spades', 4),
          Card.new('Spades', 5)
        ).should be_straight_flush
      end
    end
  end

  describe 'quads' do
    it 'should be quads' do
      @quads.should be_quads
    end

    it 'should be a set' do
      @quads.should be_set
    end

    it 'should be a pair' do
      @quads.should be_set
    end

    it 'should not be anything else' do
      @quads.should_not be_two_pair
      @quads.should_not be_straight
      @quads.should_not be_flush
      @quads.should_not be_full_house
      @quads.should_not be_straight_flush
    end
  end

  describe 'full house' do
    it 'should be a full house' do
      @full_house.should be_full_house
    end

    it 'should be a set' do
      @full_house.should be_set
    end

    it 'should be two pair' do
      @full_house.should be_two_pair
    end

    it 'should be a pair' do
      @full_house.should be_pair
    end

    it 'should not be anything else' do
      @full_house.should_not be_straight
      @full_house.should_not be_flush
      @full_house.should_not be_quads
      @full_house.should_not be_straight_flush
    end
  end

  describe 'flush' do
    it 'should be a flush' do
      @flush.should be_flush
    end

    it 'should not be anything else' do
      @flush.should_not be_pair
      @flush.should_not be_two_pair
      @flush.should_not be_set
      @flush.should_not be_straight
      @flush.should_not be_full_house
      @flush.should_not be_quads
      @flush.should_not be_straight_flush
    end
  end

  describe 'straight' do
    it 'should be a straight' do
      @straight.should be_straight
    end

    it 'should not be anything else' do
      @straight.should_not be_pair
      @straight.should_not be_two_pair
      @straight.should_not be_set
      @straight.should_not be_flush
      @straight.should_not be_full_house
      @straight.should_not be_quads
      @straight.should_not be_straight_flush
    end

    describe 'wheel' do
      it 'should be a straight' do
        Hand.new(
          Card.new('Spades', 14),
          Card.new('Clubs', 2),
          Card.new('Spades', 3),
          Card.new('Hearts', 4),
          Card.new('Diamonds', 5)
        ).should be_straight
      end
    end
  end

  describe 'set' do
    it 'should be a set' do
      @set.should be_set
    end

    it 'should be a pair' do
      @set.should be_pair
    end

    it 'should not be anything else' do
      @set.should_not be_two_pair
      @set.should_not be_straight
      @set.should_not be_flush
      @set.should_not be_full_house
      @set.should_not be_quads
      @set.should_not be_straight_flush
    end
  end

  describe 'two pair' do
    it 'should be two pair' do
      @two_pair.should be_two_pair
    end

    it 'should be a pair' do
      @two_pair.should be_pair
    end

    it 'should not be anything else' do
      @two_pair.should_not be_set
      @two_pair.should_not be_straight
      @two_pair.should_not be_flush
      @two_pair.should_not be_full_house
      @two_pair.should_not be_quads
      @two_pair.should_not be_straight_flush
    end
  end

  describe 'pair' do
    it 'should be a pair' do
      @pair.should be_pair
    end

    it 'should not be anything else' do
      @pair.should_not be_two_pair
      @pair.should_not be_set
      @pair.should_not be_straight
      @pair.should_not be_flush
      @pair.should_not be_full_house
      @pair.should_not be_quads
      @pair.should_not be_full_house
    end
  end

  describe 'high card' do
    it 'should not be anything else' do
      @high_card.should_not be_pair
      @high_card.should_not be_two_pair
      @high_card.should_not be_set
      @high_card.should_not be_straight
      @high_card.should_not be_flush
      @high_card.should_not be_full_house
      @high_card.should_not be_quads
      @high_card.should_not be_straight_flush
    end
  end

  describe 'straight and flush' do
    before do
      @straight_and_flush = Hand.new(
        Card.new('Spades', 14),
        Card.new('Spades', 10),
        Card.new('Spades', 9),
        Card.new('Clubs', 8),
        Card.new('Spades', 7),
        Card.new('Spades', 6)
      )
    end

    it 'should be a straight' do
      @straight_and_flush.should be_straight
    end

    it 'should be a flush' do
      @straight_and_flush.should be_flush
    end

    it 'should not be a straight flush' do
      @straight_and_flush.should_not be_straight_flush
    end
  end
end
