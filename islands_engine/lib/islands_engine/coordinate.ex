defmodule IslandsEngine.Coordinate do
  alias __MODULE__

  @typedoc """
  A coordinate is an ordered pair of integers representing a location as a row
  and column. Rows and columns in the range 1..10
  """
  @type t :: %__MODULE__{row: integer, col: integer}

  @type set :: MapSet.t(Coordinate.t())

  @board_range 1..10

  @enforce_keys [:row, :col]
  defstruct [:row, :col]

  @spec new(row :: integer, col :: integer) ::
          {:ok, t()} | {:error, :invalid_coordinate}
  def new(row, col) when row in @board_range and col in @board_range do
    {:ok, %Coordinate{row: row, col: col}}
  end

  def new(_row, _col) do
    {:error, :invalid_coordinate}
  end
end
