defmodule EinsteinPuzzleTest do
  use ExUnit.Case
  doctest EinsteinPuzzle

  @domain [
    house: [1, 2, 3, 4, 5],
    nationality: ~w(Englishman Spaniard Ukrainian Norwegian Japanese),
    drink: ~w(tea coffee milk orange_juice water),
    cigarette: ~w(OldGold Kools Chesterfields LuckyStrike Parliament),
    pet: ~w(dog snails fox horse zebra),
    color: ~w(red green yellow blue ivory)
  ]

  @single_rules [
    [nationality: "Englishman", color: "red"],
    [nationality: "Spaniard", pet: "dog"],
    [drink: "coffee", color: "green"],
    [nationality: "Ukrainian", drink: "tea"],
    [cigarette: "OldGold", pet: "snails"],
    [cigarette: "Kools", color: "yellow"],
    [drink: "milk", house: 3],
    [nationality: "Norwegian", house: 1],
    [cigarette: "LuckyStrike", drink: "orange_juice"],
    [nationality: "Japanese", cigarette: "Parliament"]
  ]

  @relation_rules [
    {:color, "green", :color, "ivory", :house, &EinsteinPuzzle.right_of/2},
    {:cigarette, "Chesterfields", :pet, "fox", :house, &EinsteinPuzzle.next_to/2},
    {:cigarette, "Kools", :pet, "horse", :house, &EinsteinPuzzle.next_to/2},
    {:nationality, "Norwegian", :color, "blue", :house, &EinsteinPuzzle.next_to/2}
  ]

  @solution MapSet.new([
              %{
                color: "yellow",
                house: 1,
                nationality: "Norwegian",
                drink: "water",
                cigarette: "Kools",
                pet: "fox"
              },
              %{
                color: "blue",
                house: 2,
                nationality: "Ukrainian",
                drink: "tea",
                cigarette: "Chesterfields",
                pet: "horse"
              },
              %{
                color: "red",
                house: 3,
                nationality: "Englishman",
                drink: "milk",
                cigarette: "OldGold",
                pet: "snails"
              },
              %{
                color: "ivory",
                house: 4,
                nationality: "Spaniard",
                drink: "orange_juice",
                cigarette: "LuckyStrike",
                pet: "dog"
              },
              %{
                color: "green",
                house: 5,
                nationality: "Japanese",
                drink: "coffee",
                cigarette: "Parliament",
                pet: "zebra"
              }
            ])

  test "greets the world" do
    assert EinsteinPuzzle.solve(@domain, @single_rules, @relation_rules) == @solution
  end
end
