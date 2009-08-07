require File.dirname(__FILE__) + '/helper'

module Poker
  describe Card, '#new' do
    it 'should accept the four suits' do
      lambda {
        ['Spades', 'Diamonds', 'Clubs', 'Hearts'].each do |suit|
          Card.new suit, 'Ace'
        end
      }.should_not raise_error
    end

    it 'should reject unknown suits' do
      lambda { Card.new 'Rubies', 'Ace' }.should raise_error(ArgumentError)
    end

    it 'should accept a string of a card name' do
      lambda {
        Card.new 'Spades', 'Ace'
        Card.new 'Spades', 'King'
        Card.new 'Spades', 'Queen'
        Card.new 'Spades', 'Jack'
        (2..10).each do |value|
          Card.new 'Spades', value.to_s
        end
      }.should_not raise_error
    end

    it 'should accept short representations of a card' do
      faces = {'Ace' => 'A', 'King' => 'K', 'Queen' => 'Q', 'Jack' => 'J', '10' => 'T'}
      (2..9).each {|value| faces[value.to_s] = value.to_s }
      {'Spades' => 's', 'Diamonds' => 'd', 'Clubs' => 'c', 'Hearts' => 'h'}.each do |suit, suit_short|
        faces.each do |face, face_short|
          Card.new("#{face_short}#{suit_short}").should == Card.new(suit, face)
        end
      end
    end

    it 'should reject unknown short representations' do
      lambda { Card.new 'Ar' }.should raise_error(ArgumentError)
      lambda { Card.new '1s' }.should raise_error(ArgumentError)
      lambda { Card.new '11s' }.should raise_error(ArgumentError)
      lambda { Card.new 'AsJc' }.should raise_error(ArgumentError)
    end

    it 'should reject unknown card names' do
      lambda { Card.new 'Spades', '1' }.should raise_error(ArgumentError)
      lambda { Card.new 'Spades', '11' }.should raise_error(ArgumentError)
      lambda { Card.new 'Spades', 'Joker' }.should raise_error(ArgumentError)
    end

    it 'should accept card values' do
      lambda {
        (2..14).each do |value|
          Card.new 'Spades', value
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
      lambda { Card.new 'Spades', 1 }.should raise_error(ArgumentError)
      lambda { Card.new 'Spades', 15 }.should raise_error(ArgumentError)
    end
  end

  describe Card, '#face' do
    it 'should return the face for that card' do
      Card.new('Spades', 'Ace').face.should == 'Ace'
      Card.new('Spades', 'King').face.should == 'King'
      Card.new('Spades', 'Queen').face.should == 'Queen'
      Card.new('Spades', 'Jack').face.should == 'Jack'
      (2..10).each do |value|
        Card.new('Spades', value).face.should == value.to_s
      end
    end
  end

  describe Card, '#value' do
    it 'should return the value for that card' do
      Card.new('Spades', 'Ace').value.should == 14
      Card.new('Spades', 'King').value.should == 13
      Card.new('Spades', 'Queen').value.should == 12
      Card.new('Spades', 'Jack').value.should == 11
      (2..10).each do |value|
        Card.new('Spades', value).value.should == value
      end
    end
  end

  describe Card, '#<=>' do
    it 'should order the cards by value' do
      Card.new('Spades', 'Ace').should > Card.new('Spades', 'King')
      Card.new('Spades', 'King').should > Card.new('Spades', 'Queen')
      Card.new('Spades', 'Queen').should > Card.new('Spades', 'Jack')
      Card.new('Spades', 'Jack').should > Card.new('Spades', '10')
      (2..9).each do |value|
        Card.new('Spades', value+1).should > Card.new('Spades', value)
      end
    end
  end
end
