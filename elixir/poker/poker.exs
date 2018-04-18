defmodule Poker do
  @doc """
  Given a list of poker hands, return a list containing the highest scoring hand.

  If two or more hands tie, return the list of tied hands in the order they were received.

  The basic rules and hand rankings for Poker can be found at:

  https://en.wikipedia.org/wiki/List_of_poker_hands

  For this exercise, we'll consider the game to be using no Jokers,
  so five-of-a-kind hands will not be tested. We will also consider
  the game to be using multiple decks, so it is possible for multiple
  players to have identical cards.

  Aces can be used in low (A 2 3 4 5) or high (10 J Q K A) straights, but do not count as
  a high card in the former case.

  For example, (A 2 3 4 5) will lose to (2 3 4 5 6).

  You can also assume all inputs will be valid, and do not need to perform error checking
  when parsing card values. All hands will be a list of 5 strings, containing a number
  (or letter) for the rank, followed by the suit.

  Ranks (lowest to highest): 2 3 4 5 6 7 8 9 10 J Q K A
  Suits (order doesn't matter): C D H S

  Example hand: ~w(4S 5H 4C 5D 4H) # Full house, 5s over 4s
  """
  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand(hands) do
    if length(hands) == 1 do
      hands
    else
      Enum.reduce(hands, nil, &find_winning_hand/2)
    end
  end

  def find_winning_hand(hand, nil) do
    hand
  end

  def find_winning_hand(hand, high_hand) do
    highest_card_in_hand = hand
    |> find_high_card_in_hand

    highest_card_in_high_hand = hand
    |> find_high_card_in_hand

    if (highest_card_in_hand > highest_card_in_high_hand) do
      hand
    else
      high_hand
    end
  end

  def find_high_card_in_hand(hand) do
    Enum.reduce(hand, acc = 0, fn(card, acc) -> compare_card_for_high_value(card, acc) end)
  end

  def compare_card_for_high_value(card, value) do
    card_value = get_card_rank(card)
    IO.inspect(card_value, label: :card_value)
    IO.inspect(value, label: :value)
    if(card_value > value) do
      card_value
    else
      value
    end
  end

  def get_card_rank(card)  do
    card
    |> String.slice(-1, 1)
    |> get_card_rank_map
  end

  def get_card_rank_map(rank) do
    %{
      "2" => 2,
      "3" => 3,
      "4" => 4,
      "5" => 5,
      "6" => 6,
      "7" => 7,
      "8" => 8,
      "9" => 9,
      "10" => 10,
      "J" => 11,
      "Q" => 12,
      "K" => 13,
      "A" => 14
    }[rank]
  end
end
