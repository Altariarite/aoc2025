defmodule D3Test do
  use ExUnit.Case, async: true
  use Mneme

  @example ~s(987654321111111
811111111111119
234234234234278
818181911112111)

  @input Path.join(__DIR__, "../input/d3") |> File.read!() |> String.trim()

  test "turn on largest 2" do
    auto_assert 98 <- D3.find_2_largest(987_654_321_111)
    auto_assert 92 <- 818_181_911_112_111 |> D3.find_2_largest()

    auto_assert 99 <-
                  4_466_395_697_424_268_345_845_444_435_653_448_432_633_445_644_934_252_297_266_844_237_444_446_338_517_598_273_746_441_644_874_441_323
                  |> D3.find_2_largest()
  end

  test "solve p1" do
    auto_assert 357 <- D3.solve_p1(@example)
    auto_assert 16854 <- D3.solve_p1(@input)
  end

  test "find largest 12" do
    auto_assert 987_654_321_111 <- D3.max_12(987_654_321_111)
    auto_assert 888_911_112_111 <- D3.max_12(818_181_911_112_111)
    auto_assert D3.max_12(811_111_111_111_119)
    auto_assert 434_234_234_278 <- D3.max_12(234_234_234_234_278)
  end

  test "solve p2" do
    auto_assert 3_121_910_778_619 <- D3.solve_p2(@example)
    auto_assert 167_526_011_932_478 <- D3.solve_p2(@input)
  end
end
