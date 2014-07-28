defmodule Pifight.Contestant do
  use ExActor.GenServer
  alias Pifight.Robot, as: Robot

  defcast collision, state: state do
  end

  defcast position, state: state do
  end
end
