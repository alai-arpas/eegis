defmodule Eegis.AgolApp do
  @moduledoc """
  Agol application
  """

  @type anapp :: Atom
  @type auser :: Atom

  @callback init_app(app :: anapp, user :: auser) :: Atom

  defmacro __using__(_opts) do
    quote do
      @behaviour unquote(__MODULE__)
      import unquote(__MODULE__)

      def stringa do
        "In Myb"
      end

      def prova do
        "prova"
      end

      defoverridable prova: 0, stringa: 0
    end
  end
end
