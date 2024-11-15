defmodule Eegis.MixProject do
  use Mix.Project

  @version "0.1.17"

  def project do
    [
      app: :eegis,
      version: @version,
      description: description(),
      package: package(),
      docs: docs(),
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  defp docs do
    [
      main: "Eegis",
      source_ref: "v#{@version}",
      source_url: "https://github.com/alai-arpas/eegis"
    ]
  end

  defp description do
    "Elixir client"
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {Eegis.Application, []},
      extra_applications: [:logger],
      env: [
        url_esri_token: "https://www.arcgis.com/sharing/rest/oauth2/token",
        expiration: 21600
      ]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.29", only: :dev, runtime: false},
      {:makeup_eex, ">= 0.1.1", only: :docs},
      {:finch, "~> 0.13"},
      {:req, "~> 0.3.9"},
      {:httpoison, "~> 2.1"},
      {:poison, "~> 5.0"}

      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
    ]
  end

  defp package() do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/alai-arpas/eegis"}
    ]
  end

  defp aliases do
    [
      awv: ["eegis -awv"]
    ]
  end
end
