defmodule PifightTest do
  use ExUnit.Case
  use PlugHelper
  use Jazz

  test "serving bot roster" do
    conn = simulate_request(Pifight.Router, :get, "/roster")
    assert conn.status == 200
    assert JSON.decode! conn.resp_body
    assert String.contains?(conn.resp_body, "Cromulent")
    assert String.contains?(resp_content_type(conn), "application/json")
  end

  test "serving bot state" do
    botstate = fetch_bot_state
    assert botstate.bots.bot3.health == 84
  end

  test "serving events" do
    botstate = fetch_bot_state
    Enum.any? botstate.events, &(["ping", "bot1"] = &1)
  end

  def fetch_bot_state do
    conn = simulate_request(Pifight.Router, :get, "/bots")
    assert conn.status == 200
    assert String.contains?(resp_content_type(conn), "application/json")
    decoded = JSON.decode!(conn.resp_body, keys: :atoms)
    decoded
  end

  def resp_content_type(conn) do
    headers = conn.resp_headers
    [content_type] = for {h,v} <- headers, h == "content-type", do: v
    content_type
  end
end
