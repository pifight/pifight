defmodule Pifight.Controllers.Bots do
  use Phoenix.Controller

  def index(conn) do
    json conn, '''
{
  "bot1":{"x": 350, "y": 50, "health": 100},
  "bot2":{"x": 80, "y": 90, "health": 51},
  "bot3":{"x": 150, "y": 100, "health": 84},
  "bot4":{"x": 200, "y": 140, "health": 82},
  "bot5":{"x": 340, "y": 145, "health": 15}
}
'''
  end
end
