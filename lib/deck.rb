class Deck
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
  end

  def next_card
    card = @cards[@card_index]
    @card_index += 1
    card
  end
end
