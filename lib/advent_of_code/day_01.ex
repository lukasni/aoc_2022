defmodule AdventOfCode.Day01 do
  def part1(input) do
    input
    |> AdventOfCode.parse_lines(trim: false)
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.reject(&(&1 == [""]))
    |> Enum.map(&to_int_list/1)
    |> Enum.map(&Enum.sum/1)
    |> Enum.max()
  end

  def part2(input) do
    input
    |> AdventOfCode.parse_lines(trim: false)
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.reject(&(&1 == [""]))
    |> Enum.map(&to_int_list/1)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp to_int_list(list) do
    Enum.map(list, &String.to_integer/1)
  end
end
