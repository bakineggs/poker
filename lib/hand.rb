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

  def set?
    matches.any? do |cards|
      cards.length >= 3
    end
  end

  def pair?
    matches.length > 0
  end

  private
    def matches
      matches = []
      values = @cards.map{|card| card.value}.uniq
      values.each do |value|
        cards = @cards.select{|card| card.value == value}
        matches.push cards if cards.length > 1
      end
      matches
    end
end
