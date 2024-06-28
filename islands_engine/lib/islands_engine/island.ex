defmodule IslandsEngine.Island do
  alias __MODULE__
  alias IslandsEngine.Coordinate

  @typedoc """
  An island tracks the coordinates for each occupied square as well as each
  square that has been hit by a guess.
  """
  @type t :: %__MODULE__{
          coordinates: Coordinate.set(),
          hit_coordinates: Coordinate.set()
        }

  @enforce_keys [:coordinates, :hit_coordinates]
  defstruct [:coordinates, :hit_coordinates]

  @spec new(atom(), Coordinate.t()) ::
          {:ok, Island.t()} | {:error, :invalid_coordinate}
  def new(shape, %Coordinate{} = upper_left) do
    with [_ | _] = offsets <- offsets(shape),
         %MapSet{} = coordinates <- generate_coordinates(offsets, upper_left) do
      {:ok, %Island{coordinates: coordinates, hit_coordinates: MapSet.new()}}
    else
      error -> error
    end
  end

  @spec overlaps?(t(), t()) :: boolean()
  def overlaps?(existing, other) do
    not MapSet.disjoint?(existing.coordinates, other.coordinates)
  end

  #############################################################################
  ## Private API
  #############################################################################

  @spec generate_coordinates(list({integer(), integer()}), Coordinate.t()) ::
          Coordinate.set()
          | {:error, :invalid_coordinate}
  defp generate_coordinates(offsets, upper_left) do
    Enum.reduce_while(offsets, MapSet.new(), fn offset, coordinates ->
      coordinates |> put_with_offset(upper_left, offset)
    end)
  end

  @spec put_with_offset(
          Coordinate.set(),
          Coordinate.t(),
          {integer(), integer()}
        ) ::
          {:cont, Coordinate.set()}
          | {:halt, {:error, :invalid_coordinate}}
  defp put_with_offset(coordinates, coordinate, offset) do
    %Coordinate{row: row, col: col} = coordinate
    {row_offset, col_offset} = offset

    case Coordinate.new(row + row_offset, col + col_offset) do
      {:ok, with_offset} ->
        {:cont, coordinates |> MapSet.put(with_offset)}

      {:error, :invalid_coordinate} ->
        {:halt, {:error, :invalid_coordinate}}
    end
  end

  @spec offsets(atom()) ::
          list({integer(), integer()}) | {:error, :invalid_island_type}

  defp offsets(:square) do
    [{0, 0}, {0, 1}, {1, 0}, {1, 1}]
  end

  defp offsets(:atoll) do
    [{0, 0}, {0, 1}, {1, 1}, {2, 0}, {2, 1}]
  end

  defp offsets(:dot) do
    [{0, 0}]
  end

  defp offsets(:l_shape) do
    [{0, 0}, {1, 0}, {2, 0}, {2, 1}]
  end

  defp offsets(:s_shape) do
    [{0, 1}, {0, 2}, {1, 0}, {1, 1}]
  end

  defp offsets(_) do
    {:error, :invalid_island_type}
  end
end
