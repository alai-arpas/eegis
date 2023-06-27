defmodule Eegis.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [
      Eegis.Agol
    ]

    opts = [strategy: :one_for_one, name: Eegis.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
