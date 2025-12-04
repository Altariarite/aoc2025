defmodule D2Test do
  use ExUnit.Case, async: true
  use Mneme

  @example ~s(11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124)

  @input Path.join(__DIR__, "../input/d2") |> File.read!() |> String.trim()

  test "parse example" do
    auto_assert
    [["11", "22"], ["95", "115"], ["998", "1012"]] <- D2.parse(@example) |> Enum.take(3)
  end

  test "detect repeating" do
    auto_assert true <- D2.is_repeating_twice(446_446)
  end

  test "pick_repeating" do
    auto_assert [99] <- D2.get_repeating(["95", "115"], &D2.is_repeating_twice/1)
  end

  test "solve D1" do
    auto_assert(1_227_775_554 <- D2.solve_d1(@example))
    auto_assert(12_850_231_731 <- @input |> D2.solve_d1())
  end

  test "is_repeating" do
    auto_assert true <- D2.repeating?(12_121_21212)
    auto_assert true <- D2.repeating?(123_123_123)
  end

  test "solve D2" do
    auto_assert 4_174_379_265 <- D2.solve_d2(@example)
    auto_assert 24_774_350_322 <- D2.solve_d2(@input)
  end
end
