module Poker
  class Card
    include Comparable

    SUITS = ['Spades', 'Diamonds', 'Clubs', 'Hearts']
    VALUES = {
      'Ace' => 14,
      'King' => 13,
      'Queen' => 12,
      'Jack' => 11,
      '10' => 10,
      '9' => 9,
      '8' => 8,
      '7' => 7,
      '6' => 6,
      '5' => 5,
      '4' => 4,
      '3' => 3,
      '2' => 2,
    }
    FACES = VALUES.keys

    attr_accessor :value
    attr_accessor :suit

    def initialize(suit, face_or_value)
      self.suit = suit
      self.value = VALUES[face_or_value] || face_or_value
      raise ArgumentError unless SUITS.include?(suit) && VALUES.has_value?(value)
    end

    def face
      VALUES.index(value)
    end

    def <=> other_card
      value <=> other_card.value
    end
  end
end
