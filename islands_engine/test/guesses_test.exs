defmodule IslandsEngineTest.GuessesTest do
  alias IslandsEngine.Guesses
  alias IslandsEngine.Coordinate

  use ExUnit.Case
  doctest Guesses

  test "add hit should silently reject duplicates" do
    {:ok, c1} = Coordinate.new(1, 1)

    guesses =
      Guesses.new()
      |> Guesses.add_hit(c1)
      |> Guesses.add_hit(c1)

    assert guesses == %Guesses{hits: MapSet.new([c1]), misses: MapSet.new()}
  end

  test "add miss should silently reject duplicates" do
    {:ok, c1} = Coordinate.new(1, 1)

    guesses =
      Guesses.new()
      |> Guesses.add_miss(c1)
      |> Guesses.add_miss(c1)

    assert guesses == %Guesses{hits: MapSet.new(), misses: MapSet.new([c1])}
  end
end
