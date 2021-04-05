defmodule SocialMediaV3.MixProject do
  use Mix.Project

  def project do
    [
      app: :social_media_v3,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :pbkdf2_elixir],
      mod: {SocialMediaV3.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ecto_sql, "~> 3.5"},
      {:postgrex, ">= 0.0.0"},
      {:jason, "~> 1.2"},
      {:plug_cowboy, "~> 2.4"},
      {:cors_plug, "~> 2.0"},
      {:pbkdf2_elixir, "~> 1.3"},
      {:absinthe_plug, "~> 1.5"}
    ]
  end
end
