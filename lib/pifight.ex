defmodule Pifight do
  use Application

  def start(_type, _args) do
    # opts = [port: 4000]

    # Plug.Adapters.Cowboy.http(Pifight.Router, [], opts)
    # Pifight.Supervisor.start_link

    dispatch = :cowboy_router.compile([
                 {:_, [{"/", Pifight.TopPageHandler, []}]}
               ])
    {:ok, _} = :cowboy.start_http(:http, 100,
                                  [port: 8080],
                                  [env: [dispatch: dispatch]])
    Pifight.Supervisor.start_link
  end
end
