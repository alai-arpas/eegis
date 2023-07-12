defmodule Mix.Tasks.Eegis do
  use Mix.Task

  @shortdoc "Gestione versione Eegis"

  @moduledoc """
  Prints Eegis tasks and their information.
      $ mix eegis
  To print the Eegis version, pass `-v` or `--version`, for example:
      $ mix phx --version
  To print the Eegis version, pass `-v` or `--version`, for example:
      $ mix eegis --bump
  """

  @version Mix.Project.config()[:version]

  @impl true
  @doc false
  def run([opzione]) when opzione in ~w(-v --version) do
    Mix.shell().info("Eegis v#{@version}")
  end

  @impl true
  @doc false
  def run([opzione]) when opzione in ~w(-b --bump) do
    Mix.shell().info("bump Eegis v#{@version}")
  end

  @impl true
  @doc false
  def run([opzione]) when opzione in ~w(-a --app) do
    Mix.shell().info("App Eegis v#{@version}")
  end

  def run(args) do
    case args do
      [] -> general()
      _ -> Mix.raise("Invalid arguments, expected: mix eegis")
    end
  end

  defp general() do
    Application.ensure_all_started(:eegis)
    Mix.shell().info("Gestione versione")
    Mix.shell().info("Eegis v#{Application.spec(:eegis, :vsn)}")
    Mix.shell().info("\n## Options\n")
    Mix.shell().info("-v, --version        # Prints     Eegis version\n")
    Mix.shell().info("-b, --bump           # Incrementa Eegis version\n")
    Mix.Tasks.Help.run(["--search", "phx."])
  end
end
