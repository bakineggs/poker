module Poker
  class Card
    include Comparable

    SUITS_SHORTHAND = {
      'Spades' => 's',
      'Diamonds' => 'd',
      'Clubs' => 'c',
      'Hearts' => 'h'
    }
    SUITS = SUITS_SHORTHAND.keys
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
    FACES_SHORTHAND = {
      'Ace' => 'A',
      'King' => 'K',
      'Queen' => 'Q',
      'Jack' => 'J',
      '10' => 'T',
      '9' => '9',
      '8' => '8',
      '7' => '7',
      '6' => '6',
      '5' => '5',
      '4' => '4',
      '3' => '3',
      '2' => '2'
    }

    attr_reader :value, :suit

    def initialize suit_or_chars, face_or_value = nil
      if face_or_value.nil?
        raise ArgumentError unless suit_or_chars.length == 2
        face_or_value = FACES_SHORTHAND.index(suit_or_chars[0, 1])
        suit_or_chars = SUITS_SHORTHAND.index(suit_or_chars[1, 1])
      end
      self.suit = suit_or_chars
      self.value = VALUES[face_or_value] || face_or_value
      raise ArgumentError unless SUITS.include?(suit_or_chars) && VALUES.has_value?(value)
    end

    def face
      VALUES.index(value)
    end

    def <=> other_card
      value <=> other_card.value
    end

    private
      attr_writer :value, :suit
  end
end
