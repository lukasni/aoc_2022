defmodule AdventOfCode.Day06 do
  def part1(input) do
    input
    |> String.graphemes()
    |> find_marker(4)
  end

  def part2(input) do
    input
    |> String.graphemes()
    |> find_marker(14)
  end

  def find_marker(input, length) do
    input
    |> Enum.chunk_every(length,1)
    |> Enum.with_index(length)
    |> Enum.find_value(fn {list, index} ->
      case has_duplicates?(list) do
        true ->
          nil
        false ->
          index
      end
    end)
  end

  def has_duplicates?(list) do
    Enum.uniq(list) != list
  end
end
