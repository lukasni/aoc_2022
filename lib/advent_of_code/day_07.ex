defmodule AdventOfCode.Day07 do
  def part1(input) do
    input
    |> AdventOfCode.parse_lines()
    |> get_dir_sizes()
    |> Map.values()
    |> Enum.filter(&(&1 <= 100_000))
    |> Enum.sum()
  end

  def part2(input) do
    dir_sizes =
      input
      |> AdventOfCode.parse_lines()
      |> get_dir_sizes()

    required_space = 30_000_000
    total_disk = 70_000_000
    free_space = total_disk - dir_sizes[:/]
    need_to_free = required_space - free_space

    dir_sizes
    |> Map.values()
    |> Enum.filter(&(&1 >= need_to_free))
    |> Enum.min()
  end

  defp get_dir_sizes(input) do
    input
    |> Enum.map(&parse_line/1)
    |> Enum.reduce({%{:/ => 0}, []}, &build_tree/2)
    |> elem(0)
  end

  defp parse_line(line) do
    case line do
      "$ cd .." ->
        # move up one directory
        {:cd, :..}

      "$ cd /" ->
        # move to root dir
        {:cd, :/}

      "$ cd " <> target_dir ->
        # move to `target_dir`
        {:cd, String.to_atom(target_dir)}

      "$ ls" ->
        :ls

      "dir " <> name ->
        # create directory `name` under current dir
        {:mkdir, String.to_atom(name)}

      file ->
        [size, name] = String.split(file, " ")
        # put name => size in current directory
        {:create, name, String.to_integer(size)}
    end
  end

  defp build_tree({:cd, :/}, {tree, _current_path}), do: {tree, [:/]}
  defp build_tree({:cd, :..}, {tree, [_ | new_path]}), do: {tree, new_path}
  defp build_tree({:cd, dir}, {tree, current_path}), do: {tree, [dir | current_path]}
  defp build_tree(:ls, {tree, path}), do: {tree, path}

  defp build_tree({:mkdir, name}, {tree, current_path}) do
    tree = Map.update(tree, [name | current_path], 0, & &1)

    {tree, current_path}
  end

  defp build_tree({:create, _name, size}, {tree, current_path}) do
    tree = increase_dir_size(current_path, tree, size)

    {tree, current_path}
  end

  defp increase_dir_size([:/], sizes, size) do
    Map.update(sizes, :/, 0, &(&1 + size))
  end

  defp increase_dir_size(dir, sizes, size) do
    sizes = Map.update(sizes, dir, 0, &(&1 + size))

    increase_dir_size(tl(dir), sizes, size)
  end
end
