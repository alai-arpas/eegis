defmodule Eegis.Portal do

  alias Eegis.Env

  def file_LIT do

  end

  def home do
    Env.esri_portal_noi()
  end

  def item_properties_json() do
    item_properties = %{
      "title" => "titolo LIT_2005.csv",
      "tags" => "LIT;CSV",
      "description" => "descrizione LIT_2005.csv",
      "commentsEnabled" => False
    }
    {:ok, jsonitprop} = Jason.encode(item_properties)
    jsonitprop
  end

  def crea_url do
    stringa = "#{home()}/users//"
  end

  def get_token_me do

  end

end
