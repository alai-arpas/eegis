defmodule Eegis.ClientExample.AppCarg539 do
  use Eegis.AgolApp

  def app_name, do: :carg_539

  ###############  LEGENDA #####################
  @leg_campi_base ~w(OBJECTID,UC_LEGE,SIGLA)


  def outFields_legenda do
    %{"outFields=" => Enum.join(@leg_campi_base, ",")}
  end

  defp agol_legenda, do: get_a_feature(:carg_539_legenda, outFields_legenda())

  defp agol_legenda_query(campo, valore) do
    {c, v} =
      case campo do
        :objectid ->
          {"OBJECTID", valore}

        :uc_lege ->
          {"UC_LEGE", valore}

        :sigla ->
          {"SIGLA", "'#{valore}'"}
      end

    attrs = %{"where=" => "#{c}=#{v}"}
    IO.inspect(attrs, label: "attributi")
    {records, _fields} = get_a_feature(:carg_539_legenda, attrs)
    records
  end

  def list_formazioni() do
    {attrs, _fields} = agol_legenda()

    attrs
    |> Enum.map(fn mappa -> downcase(mappa) end)
    |> Enum.map(&Map.new/1)
  end

  def crea_legenda(attrs \\ %{}) do
    campi =
      Map.keys(attrs)
      |> Enum.join(",")

    "CREA legenda #{campi}"
  end

  def get_legenda_by_objectid(objectid) do
    agol_legenda_query(:objectid, objectid)
  end

  def get_legenda_by_uclege(uc_lege) do
    agol_legenda_query(:uc_lege, uc_lege)
  end

  def get_legenda_by_sigla(sigla) do
    agol_legenda_query(:sigla, sigla)
  end

  def update_legenda(features) do
    # f1 = %{"attributes" => %{"OBJECTID" => 1, "SIGLA" => "h1m_ANDREA"}}
    # f2 = %{"attributes" => %{"OBJECTID" => 2, "SIGLA" => "h1n_ANDREA"}}
    # features = [f1, f2]
    update_features(:carg_539_legenda, features)
  end

  def delete_legenda(:agol, objectid) do
    "Delete legenda #{objectid}"
  end

  ###############  CAMPIONI #####################
  @camp_campi_base ~w(OBJECTID_1,SIGL_CAM)

  def outFields_campioni do
    %{"outFields=" => Enum.join(@camp_campi_base, ",")}
  end

  def agol_campioni, do: get_a_feature(:carg_539_campioni, outFields_campioni())

  def agol_campioni_query(sigl_cam) do
    attrs = %{"where=" => "SIGL_CAM='#{sigl_cam}'"}
    get_a_feature(:carg_539_campioni, attrs)
  end
end
