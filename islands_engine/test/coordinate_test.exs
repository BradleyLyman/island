defmodule IslandsEngineTest.CoordinateTest do
  alias IslandsEngine.Coordinate

  use ExUnit.Case
  doctest Coordinate

  test "coordinates in the range 1..10 should be valid" do
    for row <- 1..10, col <- 1..10 do
      assert {:ok, %Coordinate{row: row, col: col}} == Coordinate.new(row, col)
    end
  end

  test "coordinates outside the range should be an error" do
    assert {:error, :invalid_coordinate} == Coordinate.new(1, 11)
    assert {:error, :invalid_coordinate} == Coordinate.new(11, 1)
    assert {:error, :invalid_coordinate} == Coordinate.new(5, 0)
    assert {:error, :invalid_coordinate} == Coordinate.new(0, 5)
    assert {:error, :invalid_coordinate} == Coordinate.new(1, -3)
  end
end
