class Hand
  include Comparable

  def initialize(*hands_or_cards)
    @cards = hands_or_cards.map do |hand_or_card|
      if hand_or_card.is_a?(Hand)
        hand_or_card.cards
      else
        hand_or_card
      end
    end.flatten.sort.reverse
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
    @straight ||= straight_cards.any? do |cards|
      cards.length >= 5
    end
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

  def <=> other_hand
    if (by_rank = rank <=> other_hand.rank) == 0
      value <=> other_hand.value
    else
      by_rank
    end
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

    def value
      @value ||= if straight_flush?
        Hand.new(*suited_cards.find{|cards| cards.length >= 5}).unsuited!.value
      elsif quads?
        quads = matched_cards.find{|cards| cards.length == 4}
        14 * quads.first.value +
        (@cards - quads).first.value
      elsif full_house?
        set = matched_cards.find{|cards| cards.length == 3}
        14 * set.first.value +
        (matched_cards - [set])[0][0].value
      elsif flush?
        weighted_sum(suited_cards.find{|cards| cards.length >= 5}, 5)
      elsif straight?
        straight_cards.last.last.value
      elsif set?
        14 ** 5 * matched_cards[0][0].value +
        weighted_sum(@cards - matched_cards.flatten, 2)
      elsif two_pair?
        14 ** 6 * matched_cards[0][0].value +
        14 ** 5 * matched_cards[1][0].value +
        weighted_sum(@cards - matched_cards.flatten, 1)
      elsif pair?
        14 ** 5 * matched_cards[0][0].value +
        weighted_sum(@cards - matched_cards.flatten, 3)
      else
        weighted_sum(@cards, 5)
      end
    end

    def unsuited!
      @suited_cards = []
      self
    end

  private
    def weighted_sum(cards, count)
      weighted_sum = 0
      cards.first(count).each_with_index do |card, i|
        weighted_sum += 14 ** (4 - i) * card.value
      end
      weighted_sum
    end

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

    def straight_cards
      @straight_cards ||= (1..10).map do |low| # straight can start at a low ace up to a 10
        high = low + 4
        cards = (low..high).map do |value|
          @cards.find{|card| card.value % 13 == value % 13} # %13 allows an ace to be high or low
        end.compact
      end.select{|cards| cards.length == 5}
    end
end
