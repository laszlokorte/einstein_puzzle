# EinsteinPuzzle

Einstein Puzzle Solver


```elixir
EinsteinPuzzle.solve([
  house: [1, 2, 3, 4, 5],
  nationality: ~w(Englishman Spaniard Ukrainian Norwegian Japanese),
  drink: ~w(tea coffee milk orange_juice water),
  cigarette: ~w(OldGold Kools Chesterfields LuckyStrike Parliament),
  pet: ~w(dog snails fox horse zebra),
  color: ~w(red green yellow blue ivory)
], [
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
], [
  {:color, "green", :color, "ivory", :house, &EinsteinPuzzle.right_of/2},
  {:cigarette, "Chesterfields", :pet, "fox", :house, &EinsteinPuzzle.next_to/2},
  {:cigarette, "Kools", :pet, "horse", :house, &EinsteinPuzzle.next_to/2},
  {:nationality, "Norwegian", :color, "blue", :house, &EinsteinPuzzle.next_to/2}
])
```