defmodule D1 do
  @path Path.join(__DIR__, "../input/d1")

  def parse([?L | tl]), do: {:left, tl |> List.to_integer()}
  def parse([?R | tl]), do: {:right, tl |> List.to_integer()}

  def rotate(curr, {:left, n}), do: rem(100 + curr - n + 100 * div(n, 100), 100)
  def rotate(curr, {:right, n}), do: rem(curr + n, 100)

  @doc """
  Counts the last zero point, and the passing point, but not the first point
  """
  def rotate_and_count(curr, {:right, n}) do
    res = rotate(curr, {:right, n})
    cycles = div(n + curr, 100)

    {res, cycles}
  end

  def rotate_and_count(curr, {:left, n}) do
    res = rotate(curr, {:left, n})

    cycles =
      cond do
        curr - n > 0 ->
          0

        curr == 0 ->
          div(abs(curr - n), 100)

        :else ->
          div(abs(curr - n), 100) + 1
      end

    {res, cycles}
  end

  def read(s) do
    s
    |> String.trim()
    |> String.split("\n")
    |> Stream.map(&to_charlist/1)
    |> Enum.map(&parse/1)
  end

  def solve_p1(s) do
    s
    |> read()
    |> Enum.reduce({50, 0}, fn x, {curr, count} ->
      if rotate(curr, x) == 0 do
        {0, count + 1}
      else
        {rotate(curr, x), count}
      end
    end)
  end

  def solve_p2(s) do
    s
    |> read()
    |> Enum.reduce({50, 0}, fn x, {curr, count} ->
      {n, c} = rotate_and_count(curr, x)
      if c != 0, do: IO.inspect({curr, x})
      {n, count + c}
    end)
  end

  def p1() do
    File.read!(@path)
    |> solve_p1
  end

  def p2() do
    File.read!(@path)
    |> solve_p2
  end
end
