class Card
  SUITS = ['Spades', 'Diamonds', 'Clubs', 'Hearts']

  attr_accessor :value
  attr_accessor :suit

  def initialize(suit, value)
    self.suit = suit
    self.value = value
  end
end
