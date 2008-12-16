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

  def pair?
    @cards.any?{|card|
      (@cards-[card]).any?{|other_card|
        card.value == other_card.value
      }
    }
  end
end
