defmodule EinsteinPuzzleTest do
  use ExUnit.Case
  doctest EinsteinPuzzle

  @domain [
    zelle: [1, 2, 3, 4, 5],
    name: ~w(Henry James Ian John Ducan),
    trinkt: ~w(Tee Wein Wodka Bier Scotch),
    sport: ~w(Golf Solitär Poker Basketball Fußball),
    waffe: ~w(Säbel Buschmesser Axt Flinte Pistole),
    farbe: ~w(Rot Grün Gelb Blau Weiss)
  ]

  @single_rules [
    [name: "Henry", farbe: "Rot"],
    [name: "James", waffe: "Säbel"],
    [trinkt: "Wein", farbe: "Grün"],
    [name: "Ian", trinkt: "Tee"],
    [sport: "Golf", waffe: "Buschmesser"],
    [sport: "Solitär", farbe: "Gelb"],
    [trinkt: "Wodka", zelle: 3],
    [name: "John", zelle: 1],
    [sport: "Basketball", trinkt: "Bier"],
    [name: "Ducan", sport: "Fußball"]
  ]

  @relation_rules [
    {:farbe, "Grün", :farbe, "Weiss", :zelle, &EinsteinPuzzle.right_of/2},
    {:sport, "Poker", :waffe, "Axt", :zelle, &EinsteinPuzzle.next_to/2},
    {:sport, "Solitär", :waffe, "Flinte", :zelle, &EinsteinPuzzle.next_to/2},
    {:name, "John", :farbe, "Blau", :zelle, &EinsteinPuzzle.next_to/2},
    {:trinkt, "Scotch", :sport, "Poker", :zelle, &EinsteinPuzzle.next_to/2}
  ]

  @solution MapSet.new([
              %{
                farbe: "Gelb",
                zelle: 1,
                name: "John",
                trinkt: "Scotch",
                sport: "Solitär",
                waffe: "Axt"
              },
              %{
                farbe: "Blau",
                zelle: 2,
                name: "Ian",
                trinkt: "Tee",
                sport: "Poker",
                waffe: "Flinte"
              },
              %{
                farbe: "Rot",
                zelle: 3,
                name: "Henry",
                trinkt: "Wodka",
                sport: "Golf",
                waffe: "Buschmesser"
              },
              %{
                farbe: "Weiss",
                zelle: 4,
                name: "James",
                trinkt: "Bier",
                sport: "Basketball",
                waffe: "Säbel"
              },
              %{
                farbe: "Grün",
                zelle: 5,
                name: "Ducan",
                trinkt: "Wein",
                sport: "Fußball",
                waffe: "Pistole"
              }
            ])

  test "puzzle is solved correctly" do
    assert EinsteinPuzzle.solve(@domain, @single_rules, @relation_rules) == @solution
  end
end
