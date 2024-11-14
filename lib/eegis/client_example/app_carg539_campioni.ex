defmodule Eegis.ClientExample.AppCarg539Campioni do
  @moduledoc """
  Applicazione di esempio Agol(Arcgis On Line) che sfrutta le
  funzioni definite in Eegis.AgolApp
  """

  use Eegis.AgolApp

  def app_name, do: :carg_539

  ###############  CAMPIONI #####################
  @campi_base ~w(OBJECTID,SIGL_CAM,LAYER,NEW)

  def outFields, do: %{"outFields=" => Enum.join(@campi_base, ",")}


  def get_by_sigla_campione(sigla), do: get_by(:sigl_cam, sigla)

  @doc """
  Funzione utilizzata da
      get_by_sigla_campione


  genera la clausula "where"
      attrs = %{"where=" => nome_campo = il_valore}
  e usa la funzione get_a_feature definita in Eegis.AgolApp
      {records, _fields} = get_a_feature(:carg_539_campioni, attrs)
  """
  def get_by(campo, valore) do
    {nome_campo, il_valore} =
      case campo do
        :objectid ->
          {"OBJECTID", valore}

        :sigl_cam ->
          {"SIGL_CAM", valore}

      end

    attrs = %{"where=" => "#{nome_campo}=#{il_valore}"}
    {records, _fields} = get_a_feature(:carg_539_campioni, attrs)
    records
  end

  @doc """
  Estrae i campioni da Agol(Arcgis On Line)
  per la feature :carg_539_campioni e i campi definiti in outFields()
  """
  def list_all() do
    {attrs, _fields} = get_a_feature(:carg_539_campioni, outFields())

    attrs
    |> Enum.map(fn mappa -> downcase(mappa) end)
    |> Enum.map(&Map.new/1)
  end


end
