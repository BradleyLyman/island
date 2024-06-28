defmodule IslandsEngine.Board do
  alias IslandsEngine.Coordinate

  def new() do
    %{}
  end

  def display(board) do
    all_hits =
      Enum.reduce(board, MapSet.new(), fn {_name, island}, hits ->
        MapSet.union(hits, island.hit_coordinates)
      end)

    all_coordinates =
      Enum.reduce(board, MapSet.new(), fn {_name, island}, coords ->
        MapSet.union(coords, island.coordinates)
      end)

    rows =
      Enum.map(1..10, fn row ->
        row_chars =
          Enum.map(1..10, fn col ->
            {:ok, coord} = Coordinate.new(row, col)

            cond do
              MapSet.member?(all_hits, coord) -> "X"
              MapSet.member?(all_coordinates, coord) -> "O"
              true -> "."
            end
          end)

        "|" <> Enum.join(row_chars) <> "|\n"
      end)

    Enum.join([
      "------------\n",
      Enum.join(rows),
      "------------\n"
    ])
  end
end
