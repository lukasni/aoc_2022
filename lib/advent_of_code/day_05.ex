defmodule AdventOfCode.Day05 do
  def part1(input) do
    {stacks, moves} = parse_input(input)
      
    moves
    |> Enum.reduce(stacks, &do_move(&1, &2, reverse: true))
    |> get_top_crates()
  end

  def part2(input) do
    {stacks, moves} = parse_input(input)
      
    moves
    |> Enum.reduce(stacks, &do_move(&1, &2, reverse: false))
    |> get_top_crates()
  end
  
  defp parse_input(input) do
    [stacks, moves] = String.split(input, "\n\n", trim: true)

    stacks =
      stacks
      |> String.split("\n", trim: false)
      |> Enum.drop(-1)
      |> Enum.map(&split_crates/1)
      |> Enum.zip_with(& &1)
      |> Enum.map(fn stack -> Enum.reject(stack, &is_nil/1) end)
      |> Enum.with_index(fn elem, zbi -> {zbi+1, elem} end)
      |> Map.new()
      
    moves =
      moves
      |> String.split("\n", trim: true)
      |> Enum.map(&parse_moves/1)
      
    {stacks, moves}
  end

  defp split_crates(row) do
    row
    |> String.codepoints()
    |> Enum.chunk_every(4)
    |> clean_up_row()
  end

  defp clean_up_row(row) do
    for cell <- row do
      case cell do
        ["[", crate, "]" | _] -> crate
        _ -> nil
      end
    end
  end
  
  defp parse_moves(move) do
    #"move " <> <<count::utf8>> <> " from " <> <<from::utf8>> <> " to " <> <<dst::utf8>>
    
    [count, from, dst] = String.split(move, ["move ", " from ", " to "], trim: true)
    %{
      count: String.to_integer(count),
      from: String.to_integer(from),
      dst: String.to_integer(dst)
    }
  end
  
  defp do_move(move, stacks, opts) do
    {lifted, rest} = Enum.split(stacks[move.from], move.count)
    
    new = 
      case opts[:reverse] do
        true ->
          Enum.reverse(lifted) ++ stacks[move.dst]
        false ->
          lifted ++ stacks[move.dst]
      end
    
    stacks
    |> Map.put(move.from, rest)
    |> Map.put(move.dst, new)
  end
  
  defp get_top_crates(stacks) do
    for stack <- 1..map_size(stacks), into: "" do
      stacks[stack] |> hd
    end
  end
end
