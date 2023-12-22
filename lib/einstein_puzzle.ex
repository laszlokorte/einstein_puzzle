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

  def solve(domains, rules, rel_rules) do
    goal_count = Enum.find_value(domains, &Enum.count(elem(&1, 1)))
    combinations = combinations([%{}], domains) |> Enum.filter(&valid_single(&1, rules))
    
    find(combinations, goal_count, [], rel_rules) |> MapSet.new
  end

  defp valid_single(single, rules) do
    rules
    |> Enum.all?(fn
      rule ->
        Enum.map(rule, fn
          {k, v} -> Map.get(single, k) == v
        end)
        |> then(&(Enum.all?(&1) or not Enum.any?(&1)))
    end)
  end

  defp find_prop(selection, prop, val, relprop) do
    Enum.find_value(selection, fn sol ->
      if Map.get(sol, prop) == val, do: Map.get(sol, relprop)
    end)
  end

  defp valid_relations(selection, rel_rules) do
    rel_rules
    |> Enum.all?(fn {propa, va, propb, vb, relprop, check} ->
      case {find_prop(selection, propa, va, relprop), find_prop(selection, propb, vb, relprop)} do
        {nil, _} -> true
        {_, nil} -> true
        {a, b} -> check.(a, b)
      end
    end)
  end

  defp valid_selection(sel, rel_rules) do
    valid_relations(sel, rel_rules) and all_different(sel)
  end

  defp combinations(acc, []) do
    acc
  end

  defp combinations(acc, [{prop, domain} | rest]) do
    Enum.flat_map(domain, fn v ->
      Enum.map(acc, &Map.put(&1, prop, v))
    end)
    |> combinations(rest)
  end

  defp all_different([]), do: true

  defp all_different([head | rest] = sel) do
    acc = head |> Enum.map(fn {k, v} -> {k, MapSet.new([v])} end) |> Map.new()

    rest
    |> Enum.reduce(acc, &Map.merge(&2, &1, fn _k, a, v2 -> MapSet.put(a, v2) end))
    |> Enum.all?(&(MapSet.size(elem(&1, 1)) == Enum.count(sel)))
  end

  defp find(combinations, goal_count, selection, rel_rules) do
    current_count = Enum.count(selection)
    cond do
      current_count > goal_count -> 
        nil
      current_count == goal_count -> 
        if valid_selection(selection, rel_rules), do: selection
      true -> 
        if valid_selection(selection, rel_rules) do
          Enum.find_value(combinations, &find(combinations, goal_count, [&1 | selection], rel_rules))
      end
    end
  end
end
