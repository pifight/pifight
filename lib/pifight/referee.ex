defmodule Pifight.Referee do
  use ExActor.GenServer, export: :referee
  alias Pifight.Robot, as: Robot


  definit do
    {:ok, bot} = Robot.start(%{x: 200, y: 200})
    initial_state(%{started: false, bots: [bot]})
  end

  defcall get_bot(_index), state: state do
    b = bot(4, state)
    reply(b)
  end

  defcast bout_start, state: state do
    abot = bot(4, state)
    Robot.move(abot, %{speed: 2, heading: 90})
    :timer.apply_interval(10, Robot, :tick, [abot])
    # state |> Map.put(:started, true) |> new_state
    noreply
  end

  defcall started, state: state do
    state.started
  end

  def bot(index, state) do
    bot = state |> Map.get(:bots) |> List.first
  end
end
