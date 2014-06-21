defmodule PifightTest do
  use ExUnit.Case
  use PlugHelper

  test "serving bot roster" do
    conn = simulate_request(Pifight.Router, :get, "/roster")
    assert conn.status == 200
    assert String.contains?(conn.resp_body, "Shinkansen")
    assert String.contains?(content_type(conn), "application/json")
  end

  test "serving bot state" do
    conn = simulate_request(Pifight.Router, :get, "/bots")
    assert conn.status == 200
    assert String.contains?(content_type(conn), "application/json")
    assert Regex.match?(~r/"health": 82/, conn.resp_body)
  end

  def content_type(conn) do
    headers = conn.resp_headers
    [content_type] = for {h,v} <- headers, h == "content-type", do: v
    content_type
  end
end
