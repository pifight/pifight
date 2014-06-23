defmodule Pifight.Mixfile do
  use Mix.Project

  def project do
    [ app: :pifight,
      version: "0.0.1",
      elixir: "~> 0.14.0",
      deps: deps,
      test_coverage: [tool: ExCoveralls] ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Pifight, [] },
      applications: [:phoenix]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:phoenix, "0.2.10"},
      {:cowboy, "~> 0.10.0", github: "extend/cowboy", optional: true},
      {:httpotion, github: "myfreeweb/httpotion"},
      {:jazz, "0.1.1", [hex_app: :jazz]},
      {:excoveralls, github: "parroty/excoveralls"}
    ]
  end
end
