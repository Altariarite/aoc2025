defmodule D4 do
  def parse_row(row, i) do
    row
    |> String.to_charlist()
    |> Enum.with_index()
    |> Enum.map(fn {c, j} -> {{i, j}, c} end)
  end

  def parse(s) do
    s
    |> String.split("\n")
    |> Enum.with_index()
    |> Stream.flat_map(fn {r, i} -> parse_row(r, i) end)
    |> Map.new()
  end

  @doc "The forklifts can only access a roll of paper if there are fewer than four rolls of paper in the eight adjacent positions."
  def count_adj(m, {i, j}) do
    adj =
      for {di, dj} <- [{1, 0}, {1, 1}, {1, -1}, {0, 1}, {0, -1}, {-1, 0}, {-1, 1}, {-1, -1}] do
        Map.get(m, {i + di, j + dj}, ?.)
      end

    adj
    |> Stream.filter(fn s -> s == ?@ end)
    |> Enum.count()
  end

  def get_all_adj(m) do
    {r, c} = Map.keys(m) |> Enum.max()

    for i <- 0..r do
      for j <- 0..c, Map.get(m, {i, j}) == ?@ do
        {i, j, count_adj(m, {i, j})}
      end
    end
    |> List.flatten()
  end

  def solve_p1(m) do
    m
    |> get_all_adj()
    |> Enum.count(fn {_, _, c} -> c < 4 end)
  end

  def remove(m) do
    m
    |> get_all_adj()
    |> Enum.reduce({0, m}, fn {i, j, c}, {count, m} ->
      if c < 4 do
        {count + 1, Map.put(m, {i, j}, ?x)}
      else
        {count, m}
      end
    end)
  end

  def keep_removing(m, count) do
    {c, new_m} = remove(m)

    cond do
      c == 0 -> count
      :else -> keep_removing(new_m, count + c)
    end
  end
end
