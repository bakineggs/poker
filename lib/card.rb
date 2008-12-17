class Card
  include Comparable

  SUITS = ['Spades', 'Diamonds', 'Clubs', 'Hearts']

  attr_accessor :value
  attr_accessor :suit

  def initialize(suit, value)
    self.suit = suit
    self.value = value
  end

  def <=> other_card
    value <=> other_card.value
  end
end
