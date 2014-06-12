defmodule Pifight.Mixfile do
  use Mix.Project

  def project do
    [app: :pifight,
     version: "0.0.1",
     elixir: "~> 0.14.0",
     deps: deps]
  end

  # Configuration for the OTP application
  # Type `mix help compile.app` for more information
  def application do
    [ applications: [:cowboy, :plug],
      mod: { Pifight, []}
    ]
  end

  #   {:mydep, "~> 0.3.0"}
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1"}
  defp deps do
    [{ :plug, github: "elixir-lang/plug" },
      { :cowboy, github: "extend/cowboy" }]
  end
end
