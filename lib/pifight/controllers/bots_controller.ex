defmodule Pifight.Controllers.Bots do
  use Phoenix.Controller
  use Jazz

  defimpl JSON.Encoder, for: Tuple do
    def to_json(self, _options) do
      case self do
        {:ping, bot} -> ["ping", to_string(bot)]
        {:boom, x, y} -> ["boom", x, y]
      end
    end
  end

  def index(conn) do
    Pifight.Referee.bout_start
    bot4 = Pifight.Referee.get_bot(4)
    [x, y] = Pifight.Robot.position(bot4)
    bots = %{bot1: %{health: 100, x: 450, y: 50},
      bot2: %{health: 51, x: 40, y: 40},
      bot3: %{health: 84, x: 150, y: 100},
      bot4: %{health: 82, x: x, y: y},
      bot5: %{health: 15, x: 370, y: 220}}
    events = [{:ping, :bot1}, {:boom, 200, 200}]
    update = %{bots: bots, events: events}

    json conn, JSON.encode!(update)
  end
end
