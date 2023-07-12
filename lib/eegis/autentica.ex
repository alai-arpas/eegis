defmodule Eegis.Autentica do
  alias Eegis.HttpRequest, as: HttpReq
  # alias Eegis.Utenti
  defstruct [:token, :valido_da, :scade, user: :no_token]

  defp user_services, do: Application.get_env(:eegis, :user_services, %{})

  defp token_needed?({_usr_srv, data}), do: Map.get(data, :public, false)

  def elabora_user_srv do
    {pubblico, privato} =
      user_services()
      |> Enum.to_list()
      |> Enum.split_with(&token_needed?/1)

    {pubblico, Enum.map(privato, &elabora_privato/1)}
  end

  defp elabora_privato({usr_srv, data}) do
    app_id = Map.get(data, :app_id)
    app_secret = Map.get(data, :app_secret)

    il_token = token(app_id, app_secret)
    new_data = Map.put(data, :token, il_token)
    {usr_srv, new_data}
  end

  defp completa(my_token) do
    adesso = DateTime.now!("Etc/UTC")
    finisce = my_token["expires_in"]
    scadenza = DateTime.add(adesso, finisce, :second)
    my_token = Map.put(my_token, "log_now", adesso)
    Map.put(my_token, "scade", scadenza)
  end

  defp token(id, secret, expiration \\ "21600") do
    url = Application.get_env(:eegis, :url_esri_token)

    payload =
      "client_id=#{id}&client_secret=#{secret}&grant_type=client_credentials&expiration=#{expiration}"

    case HttpReq.post(url, payload) do
      {:error, reason} ->
        IO.inspect(reason)
        {:error, reason}

      my_token ->
        completa(my_token)
    end
  end
end
