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
      {:ex_doc, "~> 0.34", only: :dev, runtime: false, warn_if_outdated: true},
      {:makeup_eex, "~> 2.0", only: :docx},
      {:req, "~> 0.5.15"},
      {:httpoison, "~> 2.2"},
      {:poison, "~> 6.0"}
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
