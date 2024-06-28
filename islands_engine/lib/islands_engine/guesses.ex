defmodule IslandsEngine.Guesses do
  alias __MODULE__
  alias IslandsEngine.Coordinate

  @typedoc """
  Represents a player's successful and failed guesses.
  """
  @type t :: %__MODULE__{
          hits: Coordinate.set(),
          misses: Coordinate.set()
        }

  @enforce_keys [:hits, :misses]
  defstruct [:hits, :misses]

  @spec new() :: t()
  def new() do
    %Guesses{hits: MapSet.new(), misses: MapSet.new()}
  end

  @spec add(t(), :hit, Coordinate.t()) :: t()
  def add(%Guesses{} = guesses, :hit, %Coordinate{} = coordinate) do
    add_hit(guesses, coordinate)
  end

  @spec add(t(), :miss, Coordinate.t()) :: t()
  def add(%Guesses{} = guesses, :miss, %Coordinate{} = coordinate) do
    add_miss(guesses, coordinate)
  end

  #############################################################################
  ## Private API
  #############################################################################

  @spec add_hit(t(), Coordinate.t()) :: t()
  defp add_hit(guesses, coordinate) do
    update_in(guesses.hits, &MapSet.put(&1, coordinate))
  end

  @spec add_miss(t(), Coordinate.t()) :: t()
  defp add_miss(guesses, coordinate) do
    update_in(guesses.misses, &MapSet.put(&1, coordinate))
  end
end
