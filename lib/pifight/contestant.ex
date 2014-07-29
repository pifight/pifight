defmodule Pifight.Contestant do
  use ExActor.GenServer
  alias Pifight.Robot, as: Robot

  definit do
    initial_state(%{})
  end

  defcast collision, state: state do
    IO.puts "I LIKE TACOS"
    new_state(state)
  end

  defcast position, state: state do
  end
end
