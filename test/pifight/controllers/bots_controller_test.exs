defmodule Pifight.Controllers.BotsTest do
  use ExUnit.Case
  alias Pifight.Controllers.Bots, as: Controller

  setup do
    Pifight.Referee.bout_start
  end

  test "bot_hash" do
    hash = Controller.bot_hash
    bot = Map.fetch!(hash, :bot1)
    assert Map.fetch!(bot, :health) <= 100
  end
end
#