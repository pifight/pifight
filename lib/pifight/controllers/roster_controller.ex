defmodule Pifight.Controllers.Roster do
  use Phoenix.Controller

  def index(conn) do
    json conn, '''
  {
  "bot1":{"name": "Shinkansen", "icon": "bots/bot1.svg",
      "color": "#2251ff", "health": 100},
  "bot2":{"name": "Olieribos", "icon": "bots/bot2.svg",
      "color": "#552245",  "health": 100},
  "bot3":{"name": "Veldspar", "icon": "bots/bot3.svg",
    "color": "#11bb11",  "health": 100},
  "bot4":{"name": "Cromulent", "icon": "bots/bot4.svg",
    "color": "#654321",  "health": 100},
  "bot5":{"name": "Zazz", "icon": "bots/bot5.svg",
    "color": "#222222",  "health": 100}
}
'''
  end
end
