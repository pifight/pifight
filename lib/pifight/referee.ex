defmodule Pifight.Referee do
  use ExActor.GenServer, export: :referee
  alias Pifight.Robot, as: Robot
  alias Pifight.Contestant, as: Contestant
  alias Pifight.Arena, as: Arena

  definit do
    {:ok, contestant} = Contestant.start
    bot_pids = create_bots(bot_labels, contestant, [])
    initial_state(%{started: false, bots: bot_pids})
  end

  defcall get_bot(index), state: state do
    b = bot(index, state)
    reply(b)
  end

  defcall all_bots, state: state do
    reply(state.bots)
  end

  defcast bout_start, state: state do
    unless started?(state) do
      roll_bots(state.bots)
    end
    state |> Map.put(:started, true) |> new_state
  end

  #####

  def create_bots([], _, pids) do
    pids
  end

  def create_bots([h|t], contestant, pids) do
    [x, y] = random_position
    {:ok, bot} = Robot.start(%{x: x, y: y, contestant: contestant, label: h})
    create_bots(t, contestant, [bot|pids])
  end

  def bot_labels do
    [:bot1, :bot2, :bot3, :bot4, :bot5]
  end

  def roll_bots([]) do
  end

  def roll_bots([h|t]) do
    Robot.move(h, %{speed: 2, heading: 90})
    :timer.apply_interval(100, Robot, :tick, [h])
    roll_bots(t)
  end

  def started?(state) do
    state.started
  end

  def bot(index, state) do
    bot = state |> Map.get(:bots) |> Enum.at(index-1)
  end

  def random_position do
    x = :random.uniform * (Arena.max_x - Arena.min_x) + Arena.min_x
    y = :random.uniform * (Arena.max_y - Arena.min_y) + Arena.min_y
    [x,y]
  end
end
