defmodule D4Test do
  use ExUnit.Case, async: true
  use Mneme

  @example ~s(..@@.@@@@.
@@@.@.@.@@
@@@@@.@.@@
@.@@@@..@.
@@.@@@@.@@
.@@@@@@@.@
.@.@.@.@@@
@.@@@.@@@@
.@@@@@@@@.
@.@.@@@.@.
)
  @input Path.join(__DIR__, "../input/d4") |> File.read!()

  test "parse into map" do
    auto_assert [{{0, 0}, ?@}, {{0, 1}, ?@}, {{0, 2}, ?@}, {{0, 3}, ?.}] <-
                  D4.parse_row("@@@.@.@.@@", 0) |> Enum.take(4)

    auto_assert ?. <- D4.parse(@example) |> Map.get({0, 0})
  end

  test "count" do
    auto_assert 3 <- D4.parse(@example) |> D4.count_adj({0, 2})
    auto_assert 1 <- @input |> D4.parse() |> D4.count_adj({0, 0})
  end

  test "solve p1" do
    auto_assert 13 <- D4.parse(@example) |> D4.solve_p1()
    auto_assert 1540 <- D4.parse(@input) |> D4.solve_p1()
  end

  test "remove" do
    {c, m} = D4.parse(@example) |> D4.remove()
    assert c == 13
    assert Map.get(m, {0, 2})
  end

  test "keep removing" do
    auto_assert 43 <- D4.parse(@example) |> D4.keep_removing(0)
  end

  test "solve p2" do
    auto_assert 8972 <- D4.parse(@input) |> D4.keep_removing(0)
  end
end
