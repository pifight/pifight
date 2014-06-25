defmodule Pifight.RefereeTest do
  use ExUnit.Case
  alias Pifight.Robot, as: Robot
  alias Pifight.Referee, as: Referee

  test "has a bot" do
    bot = Referee.get
    [_, _] = Robot.position(bot)
  end

  test "sends ticks to bots" do
    bot = Referee.get
    [initial_x, _] = Robot.position(bot)
    Referee.bout_start
    Robot.move(bot, %{speed: 2, heading: 90})
    :timer.sleep(500)
    [new_x, _] = Robot.position(bot)
    assert new_x > initial_x
  end

  test "autotick" do
    {:ok, bot} = Robot.start(%{x: 200, y: 200})
    Robot.move(bot, %{speed: 2, heading: 90})
    :timer.apply_interval(10, Robot, :tick, [bot])
    :timer.sleep(500)
    [x, _] = Robot.position(bot)
    assert x >= 240
  end
end
