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

  def quads?
    matches.any? do |cards|
      cards.length >= 4
    end
  end

  def full_house?
    set? && two_pair?
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
    matches.any? do |cards|
      cards.length >= 3
    end
  end

  def two_pair?
    matches.length >= 2
  end

  def pair?
    matches.length >= 1
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
