require 'poker'

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

    it 'should accept a string of card values' do
      Hand.new('6h Qs 4d 7c Jc 8s').should == Hand.new(*@cards)
    end

    it 'should accept string of card calues intermixed with cards and hands' do
      Hand.new('7c Jc', Hand.new(@cards[5]), *@cards[0..2]).should == Hand.new(*@cards)
    end
  end

  describe Hand do
    before do
      @straight_flush = Hand.new '6s 5s 9s 7s 8s'
      @quads = Hand.new '6h 6s 6c 7s 6d'
      @full_house = Hand.new '6s 6h 6d 7s 7c'
      @flush = Hand.new '6s Qs 3s 7s 8s'
      @straight = Hand.new '6s 5c 9s 7d 8h'
      @set = Hand.new '6s 6h 9s 6c 8d'
      @two_pair = Hand.new '6s 5h 6c 5d 8s'
      @pair = Hand.new '6h 5s 8c 7d 8s'
      @high_card = Hand.new '6h Qs 4d 7c Jd'
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
          Hand.new('As 2s 3s 4s 5s').should be_straight_flush
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
          Hand.new('As 2c 3s 4h 5d').should be_straight
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
        @straight_and_flush = Hand.new 'As Ts 9s 8c 7s 6s'
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
        @four_to_flush = Hand.new 'As Ts 8c 7s 6s'
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
        @open_ended = Hand.new 'As 9s 8c 7s 6s'
      end

      it 'should be open ended' do
        @open_ended.should be_open_ended
      end

      it 'should not be a straight' do
        @open_ended.should_not be_straight
      end

      it 'should not include Ace through 4' do
        Hand.new('As 2c 3s 4h 8d').should_not be_open_ended
      end

      it 'should not include Jack through Ace' do
        Hand.new('As Kc Qs Jh 8d').should_not be_open_ended
      end
    end

    describe 'gutshot' do
      it 'should include 1-card gaps between 1 card and 3 others' do
        Hand.new('Js 2c 5s 4h 6d').should be_gutshot
      end

      it 'should include 1-card gaps between 2 cards and 2 others' do
        Hand.new('Js 2c 5s 3h 6d').should be_gutshot
      end

      it 'should include 1-card gaps between 3 cards and 1 other' do
        Hand.new('Js 2c 3s 4h 6d').should be_gutshot
      end

      it 'should include Ace through 4' do
        Hand.new('As 2c 3s 4h 8d').should be_gutshot
      end

      it 'should include Jack through Ace' do
        Hand.new('As Kc Qs Jh 8d').should be_gutshot
      end
    end

    describe 'double gutshot' do
      it 'should include 2 1-card gaps between 1, 3, and 1 cards' do
        Hand.new('4s 6c 7s 8h Td').should be_double_gutshot
      end

      it 'should include 2 1-card gaps between 2, 2, and 2 cards' do
        Hand.new('4s 5c 7s 8h Td Jh').should be_double_gutshot
      end

      it 'should include 2 1-card gaps between 3, 1, and 3 cards' do
        Hand.new('4s 5c 6s 8h Td Jh Qc').should be_double_gutshot
      end

      it 'should not include 2-card gaps between 2 cards and 3 cards' do
        Hand.new('4s 5c 8s 9h Td').should_not be_double_gutshot
      end

      it 'should not include 2-card gaps between 3 cards and 2 cards' do
        Hand.new('4s 5c 6s 9h Td').should_not be_double_gutshot
      end

      it 'should not include 1-card gaps between 3 cards and 3 cards' do
        Hand.new('4s 5c 6s 8c 9h Td').should_not be_double_gutshot
      end
    end

    describe 'rankings' do
      before do
        @highest_quads = Hand.new 'Ac Ah As Ad Kh'
        @highest_full_house = Hand.new 'Ac Ah As Kd Kh'
        @highest_flush = Hand.new 'Ac Kc Qc Jc 9c'
        @highest_straight = Hand.new 'Ac Kh Qs Jd Th'
        @highest_set = Hand.new 'Ac Ah As Kd Qh'
        @highest_two_pair = Hand.new 'Ac Ah Ks Kd Qh'
        @highest_pair = Hand.new 'Ah Ad Ks Qd Jc'
        @highest_high_card = Hand.new 'Ah Ks Qd Jc 9d'
      end

      describe 'straight flush' do
        before do
          @highest_straight_flush = Hand.new 'Ac Kc Qc Jc Tc'
          @lowest_straight_flush = Hand.new 'Ac 2c 3c 4c 5c'
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
          @lowest_quads = Hand.new '2c 2h 2s 2d 3h'
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
          Hand.new('Ac Ah As Ad 2h').should > Hand.new('Kc Kh Ks Kd Qh')
        end

        it 'should consider the kicker if the quads are the same' do
          Hand.new('Ac Ah As Ad Qh').should > Hand.new('Ac Ah As Ad Jh')
        end
      end

      describe 'full house' do
        before do
          @lowest_full_house = Hand.new '2c 2h 2s 3d 3h'
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
          Hand.new('Ac Ah As 2d 2h').should > Hand.new('Kc Kh Ks Qd Qh')
        end

        it 'should consider the pair if the set is the same' do
          Hand.new('Ac Ah As Qd Qh').should > Hand.new('Ac Ah As Jd Jh')
        end
      end

      describe 'flush' do
        before do
          @lowest_flush = Hand.new '2c 3c 4c 5c 7c'
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
          Hand.new('As Ks 4s 3s 2s').should > Hand.new('As Qs Js Ts 9s')
        end
      end

      describe 'straight' do
        before do
          @lowest_straight = Hand.new 'Ac 2h 3s 4d 5h'
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
          @lowest_set = Hand.new '2s 2c 2h 3d 4c'
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
          Hand.new('7s 7c 7d 2h 3c').should > Hand.new('6s 6c 6d Kh Ac')
        end

        it 'should beat smaller kickers' do
          Hand.new('7s 7c 7d Ah Jc').should > Hand.new('7s 7c 7d Ah Tc')
        end
      end

      describe 'two pair' do
        before do
          @lowest_two_pair = Hand.new '2s 2c 3h 3d 4c'
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
          Hand.new('As Ac 2d 2h 3c').should > Hand.new('Ks Kc Qd Qh Ac')
        end

        it 'should beat smaller second pairs' do
          Hand.new('Ks Kc Qd Qh 2c').should > Hand.new('Ks Kc Jd Jh Ac')
        end

        it 'should beat smaller kickers' do
          Hand.new('Ks Kc Qd Qh Ac').should > Hand.new('Ks Kc Qd Qh Jc')
        end
      end

      describe 'pair' do
        before do
          @lowest_pair = Hand.new '2s 2c 3h 4d 5d'
        end

        it 'should beat a smaller pair' do
          @highest_pair.should > @pair
          @pair.should > @lowest_pair
        end

        it 'should beat any high card' do
          @lowest_pair.should > @highest_high_card
        end

        it 'should beat smaller kickers' do
          Hand.new('As Ac Kd Qh 2c').should > Hand.new('As Ac Kd Jh Tc')
        end
      end

      describe 'high card' do
        it 'should beat a smaller high card' do
          @highest_high_card.should > @high_card
        end

        it 'should beat a smaller subsequent card' do
          Hand.new('As Kc 4d 3h 2c').should > Hand.new('As Qc Jd Th 9c')
        end
      end
    end
  end
end
