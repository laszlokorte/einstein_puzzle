defmodule EinsteinPuzzle do
  def right_of(a, b) do
    b - a == -1
  end

  def left_of(a, b) do
    b - a == 1
  end

  def next_to(a, b) do
    abs(b - a) == 1
  end

  def valid_single(single, rules) do
    rules
    |> Enum.all?(fn
      rule ->
        Enum.map(rule, fn
          {k, v} -> Map.get(single, k) == v
        end)
        |> then(&(Enum.all?(&1) or not Enum.any?(&1)))
    end)
  end

  def find_prop(selection, prop, val, relprop) do
    Enum.find_value(selection, fn sol ->
      if Map.get(sol, prop) == val, do: Map.get(sol, relprop)
    end)
  end

  def valid_relations(selection, rel_rules) do
    rel_rules
    |> Enum.all?(fn {propa, va, propb, vb, relprop, check} ->
      case {find_prop(selection, propa, va, relprop), find_prop(selection, propb, vb, relprop)} do
        {nil, _} -> true
        {_, nil} -> true
        {a, b} -> check.(a, b)
      end
    end)
  end

  def valid_selection(sel, {single_rules, rel_rules}) do
    all_different(sel) and Enum.all?(sel, &valid_single(&1, single_rules)) and
      valid_relations(sel, rel_rules)
  end

  def combine(acc, []) do
    acc
  end

  def combine(acc, [{prop, domain} | rest]) do
    Enum.flat_map(domain, fn v ->
      for a <- acc do
        Map.put(a, prop, v)
      end
    end)
    |> combine(rest)
  end

  def all_different([]), do: true

  def all_different([head | rest] = sel) do
    acc = Enum.map(head, fn {k, v} -> {k, MapSet.new([v])} end) |> Enum.into(Map.new())

    rest
    |> Enum.reduce(acc, fn s, acc ->
      Map.merge(acc, s, fn _k, v1, v2 -> MapSet.put(v1, v2) end)
    end)
    |> Enum.all?(fn {_, m} -> MapSet.size(m) == Enum.count(sel) end)
  end

  def find(combinations, selection, rules) do
    if Enum.count(selection) == 5 do
      if valid_selection(selection, rules) do
        selection
      end
    else
      if valid_selection(selection, rules) do
        combinations
        |> Enum.find_value(fn c ->
          find(combinations, [c | selection], rules)
        end)
      end
    end
  end

  def solve(domains, rules, rel_rules) do
    combinations = combine([%{}], domains) |> Enum.filter(&valid_single(&1, rules))
    MapSet.new(find(combinations, [], {rules, rel_rules}))
  end
end
