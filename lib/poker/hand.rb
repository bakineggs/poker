module Poker
  class Hand
    include Comparable
    attr_reader :cards

    def initialize *params
      @cards = params.map do |param|
        case param
        when Hand then param.cards
        when Card then param
        when String then param.split(' ').map {|str| Card.new str}
        end
      end.flatten.uniq.sort.reverse
    end

    def straight_flush?
      @straight_flush ||= suited_cards.any? do |cards|
        Hand.new(*cards).straight?
      end
    end

    def quads?
      @quads ||= matched_cards.any? do |cards|
        cards.length >= 4
      end
    end

    def full_house?
      @full_house ||= set? && two_pair?
    end

    def flush?
      @flush ||= suited_cards.any? do |cards|
        cards.length >= 5
      end
    end

    def straight?
      @straight ||= !straight_cards.empty?
    end

    def set?
      @set ||= matched_cards.any? do |cards|
        cards.length >= 3
      end
    end

    def two_pair?
      @two_pair ||= matched_cards.length >= 2
    end

    def pair?
      @pair ||= matched_cards.length >= 1
    end

    def four_to_flush?
      @four_to_flush ||= suited_cards.any? do |cards|
        cards.length >= 4
      end
    end

    def open_ended?
      @open_ended ||= straight_cards(4).any? do |cards|
        cards.first.face != 'Ace' && cards.last.face != 'Ace'
      end
    end

    def gutshot?
      @gutshot ||= !gutshot_cards.empty?
    end

    def double_gutshot?
      @double_gutshot ||= gutshot_cards.length >= 2
    end

    def <=> other_hand
      return rank <=> other_hand.rank unless rank == other_hand.rank
      return 0 if tie_breaker == other_hand.tie_breaker
      tie_breaker.each_with_index do |card, i|
        compared = card.value <=> other_hand.tie_breaker[i].value
        return compared unless compared == 0
      end
    end

    def to_s
      cards.map(&:to_s).join ' '
    end

    protected
      def rank
        @rank ||= if straight_flush?: 8
        elsif quads?: 7
        elsif full_house?: 6
        elsif flush?: 5
        elsif straight?: 4
        elsif set?: 3
        elsif two_pair?: 2
        elsif pair?: 1
        else; 0
        end
      end

      def tie_breaker
        @tie_breaker ||= if flush?
          Hand.new(*suited_cards.find{|cards| cards.length >= 5}).unsuited!.tie_breaker
        elsif quads?
          quads = matched_cards.find{|cards| cards.length == 4}
          quads + [(@cards - quads).first]
        elsif full_house?
          set = matched_cards.find{|cards| cards.length == 3}
          set + (matched_cards - [set]).first.first(2)
        elsif straight?
          [straight_cards.last.last]
        elsif set?
          set = matched_cards.first
          set + (@cards - set).first(2)
        elsif two_pair?
          two_pair = matched_cards.first(2).flatten
          two_pair + [(@cards - two_pair).first]
        elsif pair?
          pair = matched_cards.first
          pair + (@cards - pair).first(3)
        else
          @cards.first(5)
        end
      end

      def unsuited!
        @suited_cards = []
        self
      end

    private
      def matched_cards
        @matched_cards ||= @cards.map{|card| card.value}.uniq.map do |value|
          cards = @cards.select{|card| card.value == value}
          cards.length > 1 ? cards : nil
        end.compact
      end

      def suited_cards
        @suited_cards ||= @cards.map{|card| card.suit}.uniq.map do |suit|
          @cards.select{|card| card.suit == suit}
        end
      end

      def straight_cards length = 5
        @straight_cards ||= {}
        @straight_cards[length] ||= (1..14-(length-1)).map do |low| # straight can start at a low ace up to a 10
          high = low + (length - 1)
          cards = (low..high).map do |value|
            @cards.find{|card| card.value % 13 == value % 13} # %13 allows an ace to be high or low
          end.compact
        end.select{|cards| cards.length == length}
      end

      def gutshot_cards
        @gutshot_cards ||= (1..10).map do |low|
          high = low + 4
          (low..high).reject do |value|
            @cards.find{|card| card.value % 13 == value % 13}
          end
        end.reject{|cards| cards.length != 1}.uniq.flatten
      end
  end
end
