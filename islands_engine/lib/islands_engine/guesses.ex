defmodule IslandsEngine.Guesses do
  alias __MODULE__

  @enforce_keys [:hits, :misses]
  defstruct [:hits, :misses]

  def new() do
    %Guesses{hits: MapSet.new(), misses: MapSet.new()}
  end

  def add_hit(guesses, coordinate) do
    update_in(guesses.hits, &MapSet.put(&1, coordinate))
  end

  def add_miss(guesses, coordinate) do
    update_in(guesses.misses, &MapSet.put(&1, coordinate))
  end
end
