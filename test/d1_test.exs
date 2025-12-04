defmodule D1Test do
  use ExUnit.Case, async: true
  use Mneme

  @example ~s(L68
L30
R48
L5
R60
L55
L1
L99
R14
L82)

  test "solves p2" do
    auto_assert({32, 6} <- D1.solve_p2(@example))
  end

  test "count 0s left" do
    auto_assert({82, 1} <- D1.rotate_and_count(50, {:left, 68}))
    auto_assert({82, 2} <- D1.rotate_and_count(50, {:left, 168}))
    auto_assert({0, 1} <- D1.rotate_and_count(0, {:left, 100}))
    auto_assert({0, 1} <- D1.rotate_and_count(50, {:left, 50}))
    auto_assert({0, 2} <- D1.rotate_and_count(50, {:left, 150}))
    auto_assert({95, 0} <- D1.rotate_and_count(0, {:left, 5}))
  end

  test "count 0s" do
    auto_assert({50, 10} <- D1.rotate_and_count(50, {:right, 1000}))
    auto_assert({0, 2} <- D1.rotate_and_count(52, {:right, 148}))

    auto_assert({0, 1} <- D1.rotate_and_count(0, {:right, 100}))

    auto_assert({0, 1} <- D1.rotate_and_count(50, {:right, 50}))
    auto_assert({55, 1} <- D1.rotate_and_count(95, {:right, 60}))
  end

  test "solves p1" do
    auto_assert({32, 3} <- D1.solve_p1(@example))
  end

  test "rotates" do
    auto_assert(82 <- 50 |> D1.rotate({:left, 68}))
  end

  test "parses list" do
    auto_assert(
      [
        left: 68,
        left: 30,
        right: 48,
        left: 5,
        right: 60,
        left: 55,
        left: 1,
        left: 99,
        right: 14,
        left: 82
      ] <- D1.read(@example)
    )
  end
end
