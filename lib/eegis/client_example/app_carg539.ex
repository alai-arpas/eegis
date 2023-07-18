defmodule Eegis.ClientExample.AppCarg539 do
  use Eegis.AgolApp

  def app_name, do: :carg_539

  ###############  LEGENDA #####################
  @leg_campi_base ~w(OBJECTID,UC_LEGE,SIGLA)

  def outFields_legenda do
    %{"outFields=" => Enum.join(@leg_campi_base, ",")}
  end

  def agol_legenda, do: get_a_feature(:carg_539_legenda, outFields_legenda())

  def agol_legenda_query(uc_lege) do
    attrs = %{"where=" => "UC_LEGE=#{uc_lege}"}
    get_a_feature(:carg_539_legenda, attrs)
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
