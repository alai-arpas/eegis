defmodule Eegis.ClientExample.AppCarg539Legenda do
  @moduledoc """
  Applicazione di esempio Agol(Arcgis On Line) che sfrutta le
  funzioni definite in Eegis.AgolApp
  """

  use Eegis.AgolApp

  def app_name, do: :carg_539

  ###############  LEGENDA #####################
  @leg_campi_base ~w(OBJECTID,UC_LEGE,SIGLA)

  def outFields_legenda, do: %{"outFields=" => Enum.join(@leg_campi_base, ",")}

  def get_legenda_by_objectid(objectid), do: get_legenda_by(:objectid, objectid)

  def get_legenda_by_uclege(uc_lege), do: get_legenda_by(:uc_lege, uc_lege)

  def get_legenda_by_sigla(sigla), do: get_legenda_by(:sigla, sigla)

  @doc """
  Funzione utilizzata da
      get_legenda_by_objectid
      get_legenda_by_uclege
      get_legenda_by_sigla

  genera la clausula "where"
      attrs = %{"where=" => nome_campo = il_valore}
  e usa la funzione get_a_feature definita in Eegis.AgolApp
      {records, _fields} = get_a_feature(:carg_539_legenda, attrs)
  """
  def get_legenda_by(campo, valore) do
    {nome_campo, il_valore} =
      case campo do
        :objectid ->
          {"OBJECTID", valore}

        :uc_lege ->
          {"UC_LEGE", valore}

        :sigla ->
          {"SIGLA", "'#{valore}'"}
      end

    attrs = %{"where=" => "#{nome_campo}=#{il_valore}"}
    {records, _fields} = get_a_feature(:carg_539_legenda, attrs)
    records
  end

  @doc """
  Estrae le foramzioni della legenda da Agol(Arcgis On Line)
  per la feature :carg_539_legenda e i campi definiti in outFields_legenda()
  """
  def list_formazioni_legenda() do
    {attrs, _fields} = get_a_feature(:carg_539_legenda, outFields_legenda())

    attrs
    |> Enum.map(fn mappa -> downcase(mappa) end)
    |> Enum.map(&Map.new/1)
  end

  @doc """
  Crea un record per la legenda. (Ancora da implementare)
  """
  def crea_legenda(attrs \\ %{}) do
    campi =
      Map.keys(attrs)
      |> Enum.join(",")

    "CREA legenda #{campi}"
  end

  def update_legenda(features) do
    # f1 = %{"attributes" => %{"OBJECTID" => 1, "SIGLA" => "h1m_ANDREA"}}
    # f2 = %{"attributes" => %{"OBJECTID" => 2, "SIGLA" => "h1n_ANDREA"}}
    # features = [f1, f2]
    update_features(:carg_539_legenda, features)
  end

  @doc """
  Cancella un record per objectid. (Ancora da implementare)
  """
  def delete_legenda(:agol, objectid) do
    "Delete legenda #{objectid}"
  end
end
