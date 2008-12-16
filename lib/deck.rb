class Deck
  def initialize
    @cards = []
    @card_index = 0
    Card::SUITS.each do |suit|
      (2..14).each do |value|
        @cards.push Card.new(suit, value)
      end
    end
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
