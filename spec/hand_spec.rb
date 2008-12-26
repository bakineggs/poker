require File.dirname(__FILE__) + '/helper'

module Poker
  describe Hand, '#new' do
    before do
      @cards = [
        Card.new('Hearts', '6'),
        Card.new('Spades', 'Queen'),
        Card.new('Diamonds', '4'),
        Card.new('Clubs', '7'),
        Card.new('Diamonds', 'Jack'),
        Card.new('Spades', '8')
      ]
    end

    it 'should contain the given cards' do
      Hand.new(*@cards).cards.sort.should == @cards.sort
    end

    it 'should contain the cards in any given hands' do
      Hand.new(Hand.new(*@cards[0..2]), Hand.new(*@cards[3..5])).cards.sort.should == @cards.sort
    end

    it 'should accept a combination of hands and cards' do
      Hand.new(Hand.new(*@cards[0..2]), *@cards[3..5]).cards.sort.should == @cards.sort
    end

    it 'should ignore the same card if given twice' do
      Hand.new(@cards[3], *@cards).cards.sort.should == @cards.sort
    end

    it 'should ignore the same card if given in two hands' do
      Hand.new(Hand.new(*@cards[0..3]), Hand.new(*@cards[2..5])).cards.sort.should == @cards.sort
    end

    it 'should ignore the same card if given in a combo of cards and hands' do
      Hand.new(Hand.new(*@cards[0..3]), *@cards[2..5]).cards.sort.should == @cards.sort
    end
  end

  describe Hand do
    before do
      @straight_flush = Hand.new(
        Card.new('Spades', '6'),
        Card.new('Spades', '5'),
        Card.new('Spades', '9'),
        Card.new('Spades', '7'),
        Card.new('Spades', '8')
      )
      @quads = Hand.new(
        Card.new('Hearts', '6'),
        Card.new('Spades', '6'),
        Card.new('Clubs', '6'),
        Card.new('Spades', '7'),
        Card.new('Diamonds', '6')
      )
      @full_house = Hand.new(
        Card.new('Spades', '6'),
        Card.new('Hearts', '6'),
        Card.new('Diamonds', '6'),
        Card.new('Spades', '7'),
        Card.new('Clubs', '7')
      )
      @flush = Hand.new(
        Card.new('Spades', '6'),
        Card.new('Spades', 'Queen'),
        Card.new('Spades', '3'),
        Card.new('Spades', '7'),
        Card.new('Spades', '8')
      )
      @straight = Hand.new(
        Card.new('Spades', '6'),
        Card.new('Clubs', '5'),
        Card.new('Spades', '9'),
        Card.new('Diamonds', '7'),
        Card.new('Hearts', '8')
      )
      @set = Hand.new(
        Card.new('Spades', '6'),
        Card.new('Hearts', '6'),
        Card.new('Spades', '9'),
        Card.new('Clubs', '6'),
        Card.new('Diamonds', '8')
      )
      @two_pair = Hand.new(
        Card.new('Spades', '6'),
        Card.new('Hearts', '5'),
        Card.new('Clubs', '6'),
        Card.new('Diamonds', '5'),
        Card.new('Spades', '8')
      )
      @pair = Hand.new(
        Card.new('Hearts', '6'),
        Card.new('Spades', '5'),
        Card.new('Clubs', '8'),
        Card.new('Diamonds', '7'),
        Card.new('Spades', '8')
      )
      @high_card = Hand.new(
        Card.new('Hearts', '6'),
        Card.new('Spades', 'Queen'),
        Card.new('Diamonds', '4'),
        Card.new('Clubs', '7'),
        Card.new('Diamonds', 'Jack')
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
            Card.new('Spades', 'Ace'),
            Card.new('Spades', '2'),
            Card.new('Spades', '3'),
            Card.new('Spades', '4'),
            Card.new('Spades', '5')
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
            Card.new('Spades', 'Ace'),
            Card.new('Clubs', '2'),
            Card.new('Spades', '3'),
            Card.new('Hearts', '4'),
            Card.new('Diamonds', '5')
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
          Card.new('Spades', 'Ace'),
          Card.new('Spades', '10'),
          Card.new('Spades', '9'),
          Card.new('Clubs', '8'),
          Card.new('Spades', '7'),
          Card.new('Spades', '6')
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

    describe 'four to flush' do
      before do
        @four_to_flush = Hand.new(
          Card.new('Spades', 'Ace'),
          Card.new('Spades', '10'),
          Card.new('Clubs', '8'),
          Card.new('Spades', '7'),
          Card.new('Spades', '6')
        )
      end

      it 'should be four to a flush' do
        @four_to_flush.should be_four_to_flush
      end

      it 'should not be a flush' do
        @four_to_flush.should_not be_flush
      end
    end

    describe 'open ended' do
      before do
        @open_ended = Hand.new(
          Card.new('Spades', 'Ace'),
          Card.new('Spades', '9'),
          Card.new('Clubs', '8'),
          Card.new('Spades', '7'),
          Card.new('Spades', '6')
        )
      end

      it 'should be open ended' do
        @open_ended.should be_open_ended
      end

      it 'should not be a straight' do
        @open_ended.should_not be_straight
      end

      it 'should not include Ace through 4' do
        Hand.new(
          Card.new('Spades', 'Ace'),
          Card.new('Clubs', '2'),
          Card.new('Spades', '3'),
          Card.new('Hearts', '4'),
          Card.new('Diamonds', '8')
        ).should_not be_open_ended
      end

      it 'should not include Jack through Ace' do
        Hand.new(
          Card.new('Spades', 'Ace'),
          Card.new('Clubs', 'King'),
          Card.new('Spades', 'Queen'),
          Card.new('Hearts', 'Jack'),
          Card.new('Diamonds', '8')
        ).should_not be_open_ended
      end
    end

    describe 'gutshot' do
      it 'should include 1-card gaps between 1 card and 3 others' do
        Hand.new(
          Card.new('Spades', 'Jack'),
          Card.new('Clubs', '2'),
          Card.new('Spades', '5'),
          Card.new('Hearts', '4'),
          Card.new('Diamonds', '6')
        ).should be_gutshot
      end

      it 'should include 1-card gaps between 2 cards and 2 others' do
        Hand.new(
          Card.new('Spades', 'Jack'),
          Card.new('Clubs', '2'),
          Card.new('Spades', '5'),
          Card.new('Hearts', '3'),
          Card.new('Diamonds', '6')
        ).should be_gutshot
      end

      it 'should include 1-card gaps between 3 cards and 1 other' do
        Hand.new(
          Card.new('Spades', 'Jack'),
          Card.new('Clubs', '2'),
          Card.new('Spades', '3'),
          Card.new('Hearts', '4'),
          Card.new('Diamonds', '6')
        ).should be_gutshot
      end

      it 'should include Ace through 4' do
        Hand.new(
          Card.new('Spades', 'Ace'),
          Card.new('Clubs', '2'),
          Card.new('Spades', '3'),
          Card.new('Hearts', '4'),
          Card.new('Diamonds', '8')
        ).should be_gutshot
      end

      it 'should include Jack through Ace' do
        Hand.new(
          Card.new('Spades', 'Ace'),
          Card.new('Clubs', 'King'),
          Card.new('Spades', 'Queen'),
          Card.new('Hearts', 'Jack'),
          Card.new('Diamonds', '8')
        ).should be_gutshot
      end
    end

    describe 'double gutshot' do
      it 'should include 2 1-card gaps between 1, 3, and 1 cards' do
        Hand.new(
          Card.new('Spades', '4'),
          Card.new('Clubs', '6'),
          Card.new('Spades', '7'),
          Card.new('Hearts', '8'),
          Card.new('Diamonds', '10')
        ).should be_double_gutshot
      end

      it 'should include 2 1-card gaps between 2, 2, and 2 cards' do
        Hand.new(
          Card.new('Spades', '4'),
          Card.new('Clubs', '5'),
          Card.new('Spades', '7'),
          Card.new('Hearts', '8'),
          Card.new('Diamonds', '10'),
          Card.new('Hearts', 'Jack')
        ).should be_double_gutshot
      end

      it 'should include 2 1-card gaps between 3, 1, and 3 cards' do
        Hand.new(
          Card.new('Spades', '4'),
          Card.new('Clubs', '5'),
          Card.new('Spades', '6'),
          Card.new('Hearts', '8'),
          Card.new('Diamonds', '10'),
          Card.new('Hearts', 'Jack'),
          Card.new('Clubs', 'Queen')
        ).should be_double_gutshot
      end

      it 'should not include 2-card gaps between 2 cards and 3 cards' do
        Hand.new(
          Card.new('Spades', '4'),
          Card.new('Clubs', '5'),
          Card.new('Spades', '8'),
          Card.new('Hearts', '9'),
          Card.new('Diamonds', '10')
        ).should_not be_double_gutshot
      end

      it 'should not include 2-card gaps between 3 cards and 2 cards' do
        Hand.new(
          Card.new('Spades', '4'),
          Card.new('Clubs', '5'),
          Card.new('Spades', '6'),
          Card.new('Hearts', '9'),
          Card.new('Diamonds', '10')
        ).should_not be_double_gutshot
      end

      it 'should not include 1-card gaps between 3 cards and 3 cards' do
        Hand.new(
          Card.new('Spades', '4'),
          Card.new('Clubs', '5'),
          Card.new('Spades', '6'),
          Card.new('Clubs', '8'),
          Card.new('Hearts', '9'),
          Card.new('Diamonds', '10')
        ).should_not be_double_gutshot
      end
    end

    describe 'rankings' do
      before do
        @highest_quads = Hand.new(
          Card.new('Clubs', 'Ace'),
          Card.new('Hearts', 'Ace'),
          Card.new('Spades', 'Ace'),
          Card.new('Diamonds', 'Ace'),
          Card.new('Hearts', 'King')
        )
        @highest_full_house = Hand.new(
          Card.new('Clubs', 'Ace'),
          Card.new('Hearts', 'Ace'),
          Card.new('Spades', 'Ace'),
          Card.new('Diamonds', 'King'),
          Card.new('Hearts', 'King')
        )
        @highest_flush = Hand.new(
          Card.new('Clubs', 'Ace'),
          Card.new('Clubs', 'King'),
          Card.new('Clubs', 'Queen'),
          Card.new('Clubs', 'Jack'),
          Card.new('Clubs', '9')
        )
        @highest_straight = Hand.new(
          Card.new('Clubs', 'Ace'),
          Card.new('Hearts', 'King'),
          Card.new('Spades', 'Queen'),
          Card.new('Diamonds', 'Jack'),
          Card.new('Hearts', '10')
        )
        @highest_set = Hand.new(
          Card.new('Clubs', 'Ace'),
          Card.new('Hearts', 'Ace'),
          Card.new('Spades', 'Ace'),
          Card.new('Diamonds', 'King'),
          Card.new('Hearts', 'Queen')
        )
        @highest_two_pair = Hand.new(
          Card.new('Clubs', 'Ace'),
          Card.new('Hearts', 'Ace'),
          Card.new('Spades', 'King'),
          Card.new('Diamonds', 'King'),
          Card.new('Hearts', 'Queen')
        )
        @highest_pair = Hand.new(
          Card.new('Hearts', 'Ace'),
          Card.new('Diamonds', 'Ace'),
          Card.new('Spades', 'King'),
          Card.new('Diamonds', 'Queen'),
          Card.new('Clubs', 'Jack')
        )
        @highest_high_card = Hand.new(
          Card.new('Hearts', 'Ace'),
          Card.new('Spades', 'King'),
          Card.new('Diamonds', 'Queen'),
          Card.new('Clubs', 'Jack'),
          Card.new('Diamonds', '9')
        )
      end

      describe 'straight flush' do
        before do
          @highest_straight_flush = Hand.new(
            Card.new('Clubs', 'Ace'),
            Card.new('Clubs', 'King'),
            Card.new('Clubs', 'Queen'),
            Card.new('Clubs', 'Jack'),
            Card.new('Clubs', '10')
          )
          @lowest_straight_flush = Hand.new(
            Card.new('Clubs', 'Ace'),
            Card.new('Clubs', '2'),
            Card.new('Clubs', '3'),
            Card.new('Clubs', '4'),
            Card.new('Clubs', '5')
          )
        end

        it 'should beat a smaller straight flush' do
          @highest_straight_flush.should > @straight_flush
          @straight_flush.should > @lowest_straight_flush
        end

        it 'should beat any quads' do
          @lowest_straight_flush.should > @highest_quads
        end

        it 'should beat any full house' do
          @lowest_straight_flush.should > @highest_full_house
        end

        it 'should beat any flush' do
          @lowest_straight_flush.should > @highest_flush
        end

        it 'should beat any straight' do
          @lowest_straight_flush.should > @highest_straight
        end

        it 'should beat any set' do
          @lowest_straight_flush.should > @highest_set
        end

        it 'should beat any two pair' do
          @lowest_straight_flush.should > @highest_two_pair
        end

        it 'should beat any pair' do
          @lowest_straight_flush.should > @highest_pair
        end

        it 'should beat any high card' do
          @lowest_straight_flush.should > @highest_high_card
        end
      end

      describe 'quads' do
        before do
          @lowest_quads = Hand.new(
            Card.new('Clubs', '2'),
            Card.new('Hearts', '2'),
            Card.new('Spades', '2'),
            Card.new('Diamonds', '2'),
            Card.new('Hearts', '3')
          )
        end

        it 'should beat smaller quads' do
          @highest_quads.should > @quads
          @quads.should > @lowest_quads
        end

        it 'should beat any full house' do
          @lowest_quads.should > @highest_full_house
        end

        it 'should beat any flush' do
          @lowest_quads.should > @highest_flush
        end

        it 'should beat any straight' do
          @lowest_quads.should > @highest_straight
        end

        it 'should beat any set' do
          @lowest_quads.should > @highest_set
        end

        it 'should beat any two pair' do
          @lowest_quads.should > @highest_two_pair
        end

        it 'should beat any pair' do
          @lowest_quads.should > @highest_pair
        end

        it 'should beat any high card' do
          @lowest_quads.should > @highest_high_card
        end

        it 'should consider the quads first' do
          Hand.new(
            Card.new('Clubs', 'Ace'),
            Card.new('Hearts', 'Ace'),
            Card.new('Spades', 'Ace'),
            Card.new('Diamonds', 'Ace'),
            Card.new('Hearts', '2')
          ).should > Hand.new(
            Card.new('Clubs', 'King'),
            Card.new('Hearts', 'King'),
            Card.new('Spades', 'King'),
            Card.new('Diamonds', 'King'),
            Card.new('Hearts', 'Queen')
          )
        end

        it 'should consider the kicker if the quads are the same' do
          Hand.new(
            Card.new('Clubs', 'Ace'),
            Card.new('Hearts', 'Ace'),
            Card.new('Spades', 'Ace'),
            Card.new('Diamonds', 'Ace'),
            Card.new('Hearts', 'Queen')
          ).should > Hand.new(
            Card.new('Clubs', 'Ace'),
            Card.new('Hearts', 'Ace'),
            Card.new('Spades', 'Ace'),
            Card.new('Diamonds', 'Ace'),
            Card.new('Hearts', 'Jack')
          )
        end
      end

      describe 'full house' do
        before do
          @lowest_full_house = Hand.new(
            Card.new('Clubs', '2'),
            Card.new('Hearts', '2'),
            Card.new('Spades', '2'),
            Card.new('Diamonds', '3'),
            Card.new('Hearts', '3')
          )
        end

        it 'should beat a smaller full house' do
          @highest_full_house.should > @full_house
          @full_house.should > @lowest_full_house
        end

        it 'should beat any flush' do
          @lowest_full_house.should > @highest_flush
        end

        it 'should beat any straight' do
          @lowest_full_house.should > @highest_straight
        end

        it 'should beat any set' do
          @lowest_full_house.should > @highest_set
        end

        it 'should beat any two pair' do
          @lowest_full_house.should > @highest_two_pair
        end

        it 'should beat any pair' do
          @lowest_full_house.should > @highest_pair
        end

        it 'should beat any high card' do
          @lowest_full_house.should > @highest_high_card
        end

        it 'should consider the set first' do
          Hand.new(
            Card.new('Clubs', 'Ace'),
            Card.new('Hearts', 'Ace'),
            Card.new('Spades', 'Ace'),
            Card.new('Diamonds', '2'),
            Card.new('Hearts', '2')
          ).should > Hand.new(
            Card.new('Clubs', 'King'),
            Card.new('Hearts', 'King'),
            Card.new('Spades', 'King'),
            Card.new('Diamonds', 'Queen'),
            Card.new('Hearts', 'Queen')
          )
        end

        it 'should consider the pair if the set is the same' do
          Hand.new(
            Card.new('Clubs', 'Ace'),
            Card.new('Hearts', 'Ace'),
            Card.new('Spades', 'Ace'),
            Card.new('Diamonds', 'Queen'),
            Card.new('Hearts', 'Queen')
          ).should > Hand.new(
            Card.new('Clubs', 'Ace'),
            Card.new('Hearts', 'Ace'),
            Card.new('Spades', 'Ace'),
            Card.new('Diamonds', 'Jack'),
            Card.new('Hearts', 'Jack')
          )
        end
      end

      describe 'flush' do
        before do
          @lowest_flush = Hand.new(
            Card.new('Clubs', '2'),
            Card.new('Clubs', '3'),
            Card.new('Clubs', '4'),
            Card.new('Clubs', '5'),
            Card.new('Clubs', '7')
          )
        end

        it 'should beat a smaller flush' do
          @highest_flush.should > @flush
          @flush.should > @lowest_flush
        end

        it 'should beat any straight' do
          @lowest_flush.should > @highest_straight
        end

        it 'should beat any set' do
          @lowest_flush.should > @highest_set
        end

        it 'should beat any two pair' do
          @lowest_flush.should > @highest_two_pair
        end

        it 'should beat any pair' do
          @lowest_flush.should > @highest_pair
        end

        it 'should beat any high card' do
          @lowest_flush.should > @highest_high_card
        end

        it 'should compare the highest cards in the flush' do
          Hand.new(
            Card.new('Spades', 'Ace'),
            Card.new('Spades', 'King'),
            Card.new('Spades', '4'),
            Card.new('Spades', '3'),
            Card.new('Spades', '2')
          ).should > Hand.new(
            Card.new('Spades', 'Ace'),
            Card.new('Spades', 'Queen'),
            Card.new('Spades', 'Jack'),
            Card.new('Spades', '10'),
            Card.new('Spades', '9')
          )
        end
      end

      describe 'straight' do
        before do
          @lowest_straight = Hand.new(
            Card.new('Clubs', 'Ace'),
            Card.new('Hearts', '2'),
            Card.new('Spades', '3'),
            Card.new('Diamonds', '4'),
            Card.new('Hearts', '5')
          )
        end

        it 'should beat a smaller straight' do
          @highest_straight.should > @straight
          @straight.should > @lowest_straight
        end

        it 'should beat any set' do
          @lowest_straight.should > @highest_set
        end

        it 'should beat any two pair' do
          @lowest_straight.should > @highest_two_pair
        end

        it 'should beat any pair' do
          @lowest_straight.should > @highest_pair
        end

        it 'should beat any high card' do
          @lowest_straight.should > @highest_high_card
        end
      end

      describe 'set' do
        before do
          @lowest_set = Hand.new(
            Card.new('Spades', '2'),
            Card.new('Clubs', '2'),
            Card.new('Hearts', '2'),
            Card.new('Diamonds', '3'),
            Card.new('Clubs', '4')
          )
        end

        it 'should beat a smaller set' do
          @highest_set.should > @set
          @set.should > @lowest_set
        end

        it 'should beat any two pair' do
          @lowest_set.should > @highest_two_pair
        end

        it 'should beat any pair' do
          @lowest_set.should > @highest_pair
        end

        it 'should beat any high card' do
          @lowest_set.should > @highest_high_card
        end

        it 'should beat smaller sets' do
          Hand.new(
            Card.new('Spades', '7'),
            Card.new('Clubs', '7'),
            Card.new('Diamonds', '7'),
            Card.new('Hearts', '2'),
            Card.new('Clubs', '3')
          ).should > Hand.new(
            Card.new('Spades', '6'),
            Card.new('Clubs', '6'),
            Card.new('Diamonds', '6'),
            Card.new('Hearts', 'King'),
            Card.new('Clubs', 'Ace')
          )
        end

        it 'should beat smaller kickers' do
          Hand.new(
            Card.new('Spades', '7'),
            Card.new('Clubs', '7'),
            Card.new('Diamonds', '7'),
            Card.new('Hearts', 'Ace'),
            Card.new('Clubs', 'Jack')
          ).should > Hand.new(
            Card.new('Spades', '7'),
            Card.new('Clubs', '7'),
            Card.new('Diamonds', '7'),
            Card.new('Hearts', 'Ace'),
            Card.new('Clubs', '10')
          )
        end
      end

      describe 'two pair' do
        before do
          @lowest_two_pair = Hand.new(
            Card.new('Spades', '2'),
            Card.new('Clubs', '2'),
            Card.new('Hearts', '3'),
            Card.new('Diamonds', '3'),
            Card.new('Clubs', '4')
          )
        end

        it 'should beat a smaller two pair' do
          @highest_two_pair.should > @two_pair
          @two_pair.should > @lowest_two_pair
        end

        it 'should beat any pair' do
          @lowest_two_pair.should > @highest_pair
        end

        it 'should beat any high card' do
          @lowest_two_pair.should > @highest_high_card
        end

        it 'should beat smaller first pairs' do
          Hand.new(
            Card.new('Spades', 'Ace'),
            Card.new('Clubs', 'Ace'),
            Card.new('Diamonds', '2'),
            Card.new('Hearts', '2'),
            Card.new('Clubs', '3')
          ).should > Hand.new(
            Card.new('Spades', 'King'),
            Card.new('Clubs', 'King'),
            Card.new('Diamonds', 'Queen'),
            Card.new('Hearts', 'Queen'),
            Card.new('Clubs', 'Ace')
          )
        end

        it 'should beat smaller second pairs' do
          Hand.new(
            Card.new('Spades', 'King'),
            Card.new('Clubs', 'King'),
            Card.new('Diamonds', 'Queen'),
            Card.new('Hearts', 'Queen'),
            Card.new('Clubs', '2')
          ).should > Hand.new(
            Card.new('Spades', 'King'),
            Card.new('Clubs', 'King'),
            Card.new('Diamonds', 'Jack'),
            Card.new('Hearts', 'Jack'),
            Card.new('Clubs', 'Ace')
          )
        end

        it 'should beat smaller kickers' do
          Hand.new(
            Card.new('Spades', 'King'),
            Card.new('Clubs', 'King'),
            Card.new('Diamonds', 'Queen'),
            Card.new('Hearts', 'Queen'),
            Card.new('Clubs', 'Ace')
          ).should > Hand.new(
            Card.new('Spades', 'King'),
            Card.new('Clubs', 'King'),
            Card.new('Diamonds', 'Queen'),
            Card.new('Hearts', 'Queen'),
            Card.new('Clubs', 'Jack')
          )
        end
      end

      describe 'pair' do
        before do
          @lowest_pair = Hand.new(
            Card.new('Spades', '2'),
            Card.new('Clubs', '2'),
            Card.new('Hearts', '3'),
            Card.new('Diamonds', '4'),
            Card.new('Diamonds', '5')
          )
        end

        it 'should beat a smaller pair' do
          @highest_pair.should > @pair
          @pair.should > @lowest_pair
        end

        it 'should beat any high card' do
          @lowest_pair.should > @highest_high_card
        end

        it 'should beat smaller kickers' do
          Hand.new(
            Card.new('Spades', 'Ace'),
            Card.new('Clubs', 'Ace'),
            Card.new('Diamonds', 'King'),
            Card.new('Hearts', 'Queen'),
            Card.new('Clubs', '2')
          ).should > Hand.new(
            Card.new('Spades', 'Ace'),
            Card.new('Clubs', 'Ace'),
            Card.new('Diamonds', 'King'),
            Card.new('Hearts', 'Jack'),
            Card.new('Clubs', '10')
          )
        end
      end

      describe 'high card' do
        it 'should beat a smaller high card' do
          @highest_high_card.should > @high_card
        end

        it 'should beat a smaller subsequent card' do
          Hand.new(
            Card.new('Spades', 'Ace'),
            Card.new('Clubs', 'King'),
            Card.new('Diamonds', '4'),
            Card.new('Hearts', '3'),
            Card.new('Clubs', '2')
          ).should > Hand.new(
            Card.new('Spades', 'Ace'),
            Card.new('Clubs', 'Queen'),
            Card.new('Diamonds', 'Jack'),
            Card.new('Hearts', '10'),
            Card.new('Clubs', '9')
          )
        end
      end
    end
  end
end