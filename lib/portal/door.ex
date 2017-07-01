defmodule Portal.Door do
  @moduledoc """
  Creates a Portal door, which can then be used to transfer data.
  """

  @doc """
  Starts a door with the given `color`.

  The color is given as a name so we can identify
  the door by color name instead of using a PID.

  Returns `{:ok, pid}` where `pid` is the PID of the created process.
  """
  @spec start_link(:atom) :: {:ok, pid}
  def start_link(color) do
    Agent.start_link(fn -> [] end, name: color)
  end

  @doc """
  Returns the data currently in `door`.
  """
  @spec get(pid) :: list
  def get(door) do
    Agent.get(door, fn list -> list end)
  end

  @doc """
  Pushes `value` into `door`.

  Returns `:ok`.
  """
  @spec push(pid, number) :: :ok
  def push(door, value) do
    Agent.update(door, fn list -> [value|list] end)
  end

  @doc """
  Pops a value from the `door`.

  Returns `{:ok, value}` if there is a value
  or `:error` if the door is currently empty.
  """
  @spec pop(pid) :: {:ok, number} | :error
  def pop(door) do
    Agent.get_and_update(door, fn
      []          -> {:error, []}
      [head|tail] -> {{:ok, head}, tail}
    end)
  end
end
