defmodule AdventOfCode.Day04 do
  def part1(input) do
    input
    |> AdventOfCode.parse_lines()
    |> Enum.map(&parse_pairs/1)
    |> Enum.map(&subset?/1)
    |> Enum.count(& &1)
  end

  def part2(input) do
    input
    |> AdventOfCode.parse_lines()
    |> Enum.map(&parse_pairs/1)
    |> Enum.map(&overlap?/1)
    |> Enum.count(& &1)
  end

  defp parse_pairs(pair) do
    [i1, e1, i2, e2] =
      pair
      |> String.split(["-", ","])
      |> Enum.map(&String.to_integer/1)

    {MapSet.new(i1..e1), MapSet.new(i2..e2)}
  end

  defp subset?({s1, s2}) do
    MapSet.subset?(s1, s2) or MapSet.subset?(s2, s1)
  end

  defp overlap?({s1, s2}) do
    not MapSet.disjoint?(s1, s2)
  end
end
