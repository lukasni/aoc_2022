defmodule AdventOfCode do
  @moduledoc """
  Documentation for AdventOfCode.
  """

  def parse_lines(input, opts \\ [trim: true]) do
    input
    |> String.split("\n", opts)
  end
end
