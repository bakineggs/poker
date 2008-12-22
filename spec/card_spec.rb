require File.dirname(__FILE__) + '/helper'

describe Card, '#new' do
  it 'should accept the four suits' do
    lambda {
      ['Spades', 'Diamonds', 'Clubs', 'Hearts'].each do |suit|
        Card.new(suit, 'Ace')
      end
    }.should_not raise_error
  end

  it 'should reject unknown suits' do
    lambda { Card.new('Rubies', 'Ace') }.should raise_error(ArgumentError)
  end

  it 'should accept a string of a card name' do
    lambda {
      Card.new('Spades', 'Ace')
      Card.new('Spades', 'King')
      Card.new('Spades', 'Queen')
      Card.new('Spades', 'Jack')
      (2..10).each do |value|
        Card.new('Spades', value.to_s)
      end
    }.should_not raise_error
  end

  it 'should reject unknown card names' do
    lambda { Card.new('Spades', '1') }.should raise_error(ArgumentError)
    lambda { Card.new('Spades', '11') }.should raise_error(ArgumentError)
    lambda { Card.new('Spades', 'Joker') }.should raise_error(ArgumentError)
  end

  it 'should accept card values' do
    lambda {
      (2..14).each do |value|
        Card.new('Spades', value)
      end
    }.should_not raise_error
  end

  it 'should consider cards made by face and value the same' do
    Card.new('Spades', 'Ace').should == Card.new('Spades', 14)
    Card.new('Spades', 'King').should == Card.new('Spades', 13)
    Card.new('Spades', 'Queen').should == Card.new('Spades', 12)
    Card.new('Spades', 'Jack').should == Card.new('Spades', 11)
    (2..10).each do |value|
      Card.new('Spades', value.to_s).should == Card.new('Spades', value)
    end
  end

  it 'should reject values outside the range' do
    lambda { Card.new('Spades', 1) }.should raise_error(ArgumentError)
    lambda { Card.new('Spades', 15) }.should raise_error(ArgumentError)
  end
end
