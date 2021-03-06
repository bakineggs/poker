Gem::Specification.new do |s|
  s.name     = "poker"
  s.version  = "1.4.1"
  s.date     = "2009-06-13"
  s.summary  = "A library for constructing and comparing poker hands. Also provides a deck of cards."
  s.email    = "dan@bakineggs.com"
  s.homepage = "http://github.com/danbarry/poker"
  s.description = "A library for constructing and comparing poker hands. Also provides a deck of cards."
  s.has_rdoc = false
  s.authors  = ["Dan Barry"]
  s.files    = [
    "lib/poker/card.rb",
    "lib/poker/deck.rb",
    "lib/poker/hand.rb",
    "lib/poker.rb"
  ]
  s.test_files = [
    "spec/helper.rb",
    "spec/card_spec.rb",
    "spec/deck_spec.rb",
    "spec/hand_spec.rb"
  ]
end
