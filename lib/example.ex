defmodule Example do
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

  def run do
    IO.puts("Domains:")
    IO.inspect(@domain)
    IO.puts("Hints:")
    IO.inspect(@single_rules)
    IO.puts("Relational Hints:")
    IO.inspect(@relation_rules)

    IO.puts("Solutions:")
    EinsteinPuzzle.solve(@domain, @single_rules, @relation_rules) |> IO.inspect()
  end
end
