defmodule D2 do
  def parse(s) do
    s
    |> String.split(",")
    |> Stream.map(&String.split(&1, "-"))
  end

  def is_repeating_twice(num) do
    s =
      num
      |> Integer.to_string()

    {first, second} =
      s |> String.split_at(div(String.length(s), 2))

    first == second
  end

  def get_repeating([lo, hi], pred) do
    for i <- String.to_integer(lo)..String.to_integer(hi), pred.(i) do
      i
    end
  end

  def solve_d1(s) do
    s
    |> parse()
    |> Stream.flat_map(&get_repeating(&1, fn n -> is_repeating_twice(n) end))
    |> Enum.sum()
  end

  def repeating?(num) when is_integer(num), do: repeating?(Integer.to_string(num))

  def repeating?(str) do
    (str <> str)
    |> String.slice(1..-2//1)
    |> String.contains?(str)
  end

  def solve_d2(s) do
    s
    |> parse()
    |> Stream.flat_map(&get_repeating(&1, fn n -> repeating?(n) end))
    |> Enum.sum()
  end
end
