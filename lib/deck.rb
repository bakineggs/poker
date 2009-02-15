module Poker
  class Deck
    attr_reader :cards

    def initialize
      @cards = Card::SUITS.map do |suit|
        Card::FACES.map do |value|
          Card.new(suit, value)
        end
      end.flatten
      @card_index = 0
    end

    def shuffle
      @cards = @cards.sort_by {rand}
      @card_index = 0
      self
    end

    def next(quantity = 1)
      raise IndexError if @card_index + quantity > 52
      @cards[@card_index...(@card_index += quantity)]
    end

    private
      attr_writer :cards
  end
end
