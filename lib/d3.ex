defmodule D3 do
  def to_intlist(s) do
    s |> String.to_charlist() |> Enum.map(&String.to_integer/1)
  end

  @spec find_2_largest(integer()) :: integer()
  def find_2_largest(i) do
    l = Integer.digits(i)

    {fst, i} =
      l |> Enum.drop(-1) |> Stream.with_index() |> Enum.max_by(fn {n, _} -> n end)

    snd = l |> Enum.drop(i + 1) |> Enum.max()

    [fst, snd] |> Integer.undigits()
  end

  def solve_p1(s) do
    s
    |> String.split("\n")
    |> Stream.map(&String.to_integer/1)
    |> Stream.map(&find_2_largest/1)
    |> Enum.sum()
  end

  def max_12(i) do
    l = Integer.digits(i)
    find_all_max(l, 12) |> Integer.undigits()
  end

  def find_all_max(_, 0), do: []

  def find_all_max(l, rem) when length(l) == rem, do: l

  def find_all_max(l, rem) do
    {[hd | tl], rem} = next_max(l, rem)
    [hd | find_all_max(tl, rem)]
  end

  def next_max(l, remaining_digits) do
    {_, i} =
      l
      |> Enum.drop(-remaining_digits + 1)
      |> Stream.with_index()
      |> Enum.max_by(fn {n, _} -> n end)

    {l |> Enum.drop(i), remaining_digits - 1}
  end

  def solve_p2(s) do
    s
    |> String.split("\n")
    |> Stream.map(&String.to_integer/1)
    |> Stream.map(&max_12/1)
    |> Enum.sum()
  end
end
