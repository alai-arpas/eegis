defmodule Eegis.AgolMyFses do
  use Eegis.AgolFses

  @impl Eegis.AgolFses
  def srv, do: "services6"

  @impl Eegis.AgolFses
  def user, do: :alai
end
