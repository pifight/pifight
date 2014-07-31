defmodule Pifight.Controllers.Bots do
  use Phoenix.Controller
  use Jazz
  alias Pifight.Robot, as: Robot

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
    events = [{:ping, :bot1}, {:boom, 200, 200}]
    update = %{bots: bot_hash, events: events}

    json conn, JSON.encode!(update)
  end

  def bot_hash do
    bot_hash(Pifight.Referee.all_bots, %{})
  end

  def bot_hash([], acc), do: acc

  def bot_hash([h|t], acc) do
    [x, y] = Robot.position(h)
    attribs = %{health: Robot.health(h), x: x, y: y}
    bot_hash t, (acc |> Map.put(Robot.label(h), attribs))
  end

end
