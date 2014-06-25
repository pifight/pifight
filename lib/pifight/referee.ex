defmodule Pifight.Referee do
  use ExActor.GenServer, export: :referee
  alias Pifight.Robot, as: Robot


  definit do
    {:ok, bot} = Robot.start(%{x: 200, y: 200})
    initial_state(bot)
  end

  defcall get, state: state do
    reply(state)
  end

  defcast bout_start, state: state do
    :timer.apply_interval(10, Robot, :tick, [state])
    noreply
  end
end
