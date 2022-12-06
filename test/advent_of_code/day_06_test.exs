defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06

  @p1_inputs [
    {"mjqjpqmgbljsphdztnvjfqwrcgsmlb", 7},
    {"bvwbjplbgvbhsrlpgdmjqwftvncz", 5},
    {"nppdvjthqldpwncqszvftbrmjlhg", 6},
    {"nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 10},
    {"zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 11}
  ]

  @p2_inputs [
    {"mjqjpqmgbljsphdztnvjfqwrcgsmlb", 19},
    {"bvwbjplbgvbhsrlpgdmjqwftvncz", 23},
    {"nppdvjthqldpwncqszvftbrmjlhg", 23},
    {"nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", 29},
    {"zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", 26}
  ]

  test "part1" do
    for {input, expected} <- @p1_inputs do
      result = part1(input)

      assert result == expected
    end
  end

  test "part2" do
    for {input, expected} <- @p2_inputs do
      result = part2(input)

      assert result == expected
    end
  end
end
