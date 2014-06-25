defmodule Pifight.RefereeTest do
  use ExUnit.Case
  alias Pifight.Robot, as: Robot
  alias Pifight.Referee, as: Referee

  test "has a bot" do
    bot = Referee.get_bot(1)
    [_, _] = Robot.position(bot)
  end

  test "sends ticks to bots" do
    bot = Referee.get_bot(1)
    IO.inspect bot
    [initial_x, _] = Robot.position(bot)
    Referee.bout_start
    :timer.sleep(500)
    [new_x, _] = Robot.position(bot)
    assert new_x > initial_x
  end
end
