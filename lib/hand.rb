class Hand
  def initialize(*hands_or_cards)
    @cards = []
    hands_or_cards.each do |hand_or_card|
      if hand_or_card.is_a?(Hand)
        @cards += hand_or_card.cards
      else
        @cards.push hand_or_card
      end
    end
  end

  def straight_flush?
    suited_cards.any? do |cards|
      Hand.new(*cards).straight?
    end
  end

  def quads?
    matched_cards.any? do |cards|
      cards.length >= 4
    end
  end

  def full_house?
    set? && two_pair?
  end

  def flush?
    suited_cards.any? do |cards|
      cards.length >= 5
    end
  end

  def straight?
    values = @cards.map{|card| card.value}.uniq.sort
    values.unshift 1 if values.include?(14) # ace can be low
    previous_value = 0
    count = 0
    values.each do |value|
      if value == previous_value + 1
        count += 1
      else
        count = 1
      end
      return true if count == 5
      previous_value = value
    end
    false
  end

  def set?
    matched_cards.any? do |cards|
      cards.length >= 3
    end
  end

  def two_pair?
    matched_cards.length >= 2
  end

  def pair?
    matched_cards.length >= 1
  end

  private
    def matched_cards
      matched_cards = []
      @cards.map{|card| card.value}.uniq.each do |value|
        cards = @cards.select{|card| card.value == value}
        matched_cards.push cards if cards.length > 1
      end
      matched_cards
    end

    def suited_cards
      @cards.map{|card| card.suit}.uniq.map do |suit|
        @cards.select{|card| card.suit == suit}
      end
    end
end
