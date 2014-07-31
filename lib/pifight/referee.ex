defmodule Pifight.Referee do
  use ExActor.GenServer, export: :referee
  alias Pifight.Robot, as: Robot
  alias Pifight.Contestant, as: Contestant


  definit do
    # I know, I know.
    {:ok, contestant} = Contestant.start
    {:ok, bot1} = Robot.start(%{x: 10, y: 110, contestant: contestant})
    {:ok, bot2} = Robot.start(%{x: 50, y: 50, contestant: contestant})
    {:ok, bot3} = Robot.start(%{x: 200, y: 40, contestant: contestant})
    {:ok, bot4} = Robot.start(%{x: 200, y: 200, contestant: contestant})
    {:ok, bot5} = Robot.start(%{x: 330, y: 32, contestant: contestant})
    initial_state(%{started: false, bots: [bot1, bot2, bot3, bot4, bot5]})
  end

  defcall get_bot(index), state: state do
    b = bot(index, state)
    reply(b)
  end

  defcast bout_start, state: state do
    unless started?(state) do
      abot = bot(4, state)
      Robot.move(abot, %{speed: 2, heading: 90})
      :timer.apply_interval(100, Robot, :tick, [abot])
    end
    state |> Map.put(:started, true) |> new_state
  end

  #####

  def started?(state) do
    state.started
  end

  def bot(index, state) do
    bot = state |> Map.get(:bots) |> Enum.at(index-1)
  end
end
