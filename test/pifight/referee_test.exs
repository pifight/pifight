defmodule Pifight.RefereeTest do
  use ExUnit.Case
  alias Pifight.Robot, as: Robot
  alias Pifight.Referee, as: Referee
  alias Pifight.Arena, as: Arena

  test "has a bot" do
    bot = Referee.get_bot(1)
    [_, _] = Robot.position(bot)
  end

  test "sends ticks to bots" do
    bot = Referee.get_bot(4)
    [initial_x, _] = Robot.position(bot)
    Referee.bout_start
    :timer.sleep(500)
    [new_x, _] = Robot.position(bot)
    assert new_x > initial_x
  end

  test "get_bot by index" do
    bot1 = Referee.get_bot(1)
    bot2 = Referee.get_bot(2)
    assert bot1 != bot2
  end

  test "random_position" do
    [a, b] = Referee.random_position
    assert a >= Arena.min_x
    assert a <= Arena.max_x
  end
end
