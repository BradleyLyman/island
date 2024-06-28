defmodule IslandsEngineTest.IslandTest do
  use ExUnit.Case

  alias IslandsEngine.{Coordinate, Island}
  doctest Island

  defp c(row, col) do
    {:ok, coordinate} = Coordinate.new(row, col)
    coordinate
  end

  test "overlapping islands should indicate that they're overlapping" do
    assert {:ok, existing} = Island.new(:square, c(1, 1))
    assert {:ok, other} = Island.new(:square, c(2, 1))
    assert Island.overlaps?(existing, other)
  end

  test "disjoint islands should not indicate that they're overlapping" do
    assert {:ok, existing} = Island.new(:square, c(1, 1))
    assert {:ok, other} = Island.new(:square, c(3, 1))
    assert not Island.overlaps?(existing, other)
  end

  test "square island" do
    assert {:ok, %Island{coordinates: coords}} = Island.new(:square, c(1, 1))

    assert MapSet.equal?(
             coords,
             MapSet.new([
               c(1, 1),
               c(2, 1),
               c(1, 2),
               c(2, 2)
             ])
           )
  end

  test "atol island" do
    assert {:ok, %Island{coordinates: coords}} = Island.new(:atoll, c(1, 1))

    assert MapSet.equal?(
             coords,
             MapSet.new([
               c(1, 1),
               c(1, 2),
               c(2, 2),
               c(3, 1),
               c(3, 2)
             ])
           )
  end

  test "dot island" do
    assert {:ok, %Island{coordinates: coords}} = Island.new(:dot, c(1, 1))

    assert MapSet.equal?(coords, MapSet.new([c(1, 1)]))
  end

  test "l_shape island" do
    assert {:ok, %Island{coordinates: coords}} = Island.new(:l_shape, c(1, 1))

    assert MapSet.equal?(
             coords,
             MapSet.new([
               c(1, 1),
               c(2, 1),
               c(3, 1),
               c(3, 2)
             ])
           )
  end

  test "s_shape island" do
    assert {:ok, %Island{coordinates: coords}} = Island.new(:s_shape, c(1, 1))

    assert MapSet.equal?(
             coords,
             MapSet.new([
               c(1, 2),
               c(1, 3),
               c(2, 1),
               c(2, 2)
             ])
           )
  end

  test "island outside the normal coordinate range" do
    assert {:error, :invalid_coordinate} = Island.new(:s_shape, c(1, 10))
  end

  test "invalid island name" do
    assert {:error, :invalid_island_type} = Island.new(:some_island, c(1, 1))
  end
end
