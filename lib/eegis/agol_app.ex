defmodule Eegis.AgolApp do
  @moduledoc """
  Agol application
  """

  @callback app_name :: atom()

  defmacro __using__(_opts) do
    quote do
      @behaviour unquote(__MODULE__)
      import unquote(__MODULE__)

      def app_name, do: :my_app_name

      @doc """
      TODO da prevedere errori
      """

      defoverridable app_name: 0
    end
  end
end
