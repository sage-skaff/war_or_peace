class Turn
  attr_reader :player1,
              :player2,
              :spoils_of_war,
              :the_void
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
    @the_void = []
  end

  def type
    if player1.deck.rank_of_card_at(0) != player2.deck.rank_of_card_at(0)
      :basic
    elsif player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) && player1.deck.rank_of_card_at(2) != player2.deck.rank_of_card_at(2)
      :war
    elsif player1.deck.rank_of_card_at(0) == player2.deck.rank_of_card_at(0) && player1.deck.rank_of_card_at(2) == player2.deck.rank_of_card_at(2)
      :mutually_assured_destruction
    end
  end

  def winner
    if type == :basic
      if player1.deck.rank_of_card_at(0) > player2.deck.rank_of_card_at(0)
        player1
      elsif player2.deck.rank_of_card_at(0) > player1.deck.rank_of_card_at(0)
        player2
      end

    elsif type == :war
      if player1.deck.rank_of_card_at(2) > player2.deck.rank_of_card_at(2)
        player1
      elsif player2.deck.rank_of_card_at(2) > player1.deck.rank_of_card_at(2)
        player2
      end

    elsif type == :mutually_assured_destruction
      "No Winner"
    end
  end

  def pile_cards
    if type == :basic
      spoils_of_war << player1.deck.remove_card
      spoils_of_war << player2.deck.remove_card
      
    elsif type == :war
      3.times do
        spoils_of_war << player1.deck.remove_card
        spoils_of_war << player2.deck.remove_card
      end

    elsif type == :mutually_assured_destruction
      3.times do
        the_void << player1.deck.remove_card
        the_void << player2.deck.remove_card
      end
    end
  end

  def award_spoils(winner)
    if winner == player1
      spoils_of_war.each do |spoils|
        player1.deck.add_card(spoils)
      end

    elsif winner == player2
      spoils_of_war.each do |spoils|
        player2.deck.add_card(spoils)
      end
    end
  end
end
