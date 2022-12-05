defmodule AdventOfCode.Day03 do
  def part1(input) do
    input
    |> AdventOfCode.parse_lines()
    |> Stream.map(&to_charlist/1)
    |> Stream.map(&split/1)
    |> Stream.map(&find_misplaced/1)
    |> Stream.map(&get_priority/1)
    |> Enum.sum()
  end

  def part2(input) do
    input
    |> AdventOfCode.parse_lines()
    |> Stream.map(&to_charlist/1)
    |> Stream.map(&MapSet.new/1)
    |> Stream.chunk_every(3)
    |> Stream.map(&get_badge/1)
    |> Stream.map(&get_priority/1)
    |> Enum.sum()
  end

  defp split(list) do
    len = round(length(list) / 2)
    {first, second} = Enum.split(list, len)
    {MapSet.new(first), MapSet.new(second)}
  end

  defp find_misplaced({first, second}) do
    MapSet.intersection(first, second)
    |> MapSet.to_list()
    |> hd
  end

  defp get_priority(item) do
    cond do
      item in ?A..?Z ->
        item - ?A + 27

      item in ?a..?z ->
        item - ?a + 1

      true ->
        nil
    end
  end

  defp get_badge([one, two, three]) do
    MapSet.intersection(one, two)
    |> MapSet.intersection(three)
    |> MapSet.to_list()
    |> hd()
  end
end
