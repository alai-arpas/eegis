defmodule Eegis.HttpRequest do
  @moduledoc ~S'''
  Utilità generiche Api rest
  '''

  def headers do
    [
      {"Accept", "application/json"},
      {"Content-Type", "application/x-www-form-urlencoded"},
      {"Cache-Control", "no-cache, no-store, must-revalidate"}
    ]
  end

  def options do
    [recv_timeout: :infinity]
  end

  ############ POST_REQUWAR
  defp converti(mappa) do
    {:ok, stringa} = Poison.encode(mappa)
    stringa
  end

  defp elabora(features) do
    stringa =
      features
      |> Enum.map(&converti(&1))
      |> Enum.join(",")

    stringa
    |> String.replace("\"", "%22")
  end

  def post_request(url, params, features) do
    request = %HTTPoison.Request{
      method: :post,
      url: "#{url}?features=[#{elabora(features)}]",
      params: params,
      headers: [{"Accept", "application/json"}]
    }

    result =
      case HTTPoison.request(request) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          {:ok, decodificato} =
            body
            |> Poison.decode()

          decodificato

        {:ok, %HTTPoison.Response{status_code: 404}} ->
          IO.puts("Not found :(")
          {:error, codice: "404"}

        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.inspect(reason)
          {:error, codice: reason}
      end

    result
  end

  ############ FINE - POST_REQUEST

  def post(url, payload) do
    result =
      case HTTPoison.post(url, payload, headers(), options()) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          {:ok, decodificato} =
            body
            |> Poison.decode()

          decodificato

        {:ok, %HTTPoison.Response{status_code: 404}} ->
          IO.puts("Not found :(")
          {:error, codice: "404"}

        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.inspect(reason)
          {:error, codice: reason}
      end

    result
  end

  def get(url) do
    result =
      case HTTPoison.get(url, headers(), options()) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          Poison.decode(body)

        {:ok, %HTTPoison.Response{status_code: 404}} ->
          IO.puts("Not found :(")
          {:error, codice: "404"}

        {:error, %HTTPoison.Error{reason: reason}} ->
          IO.inspect(reason)
          {:error, codice: reason}
      end

    result
  end
end
