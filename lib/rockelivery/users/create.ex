defmodule Rockelivery.Users.Create do
  alias Rockelivery.{Error, Repo, User}

  @moduledoc """
  Testando documentação do Moduledoc

  Teste da função call/1
  """

  @doc """
  Função para testar moduledoc

  ## Bora ver

  - parametro: struct do user

  ## Exemplo

      iex> 1 + 1
      2
  """
  def call(params) do
    cep = Map.get(params, "cep")
    changeset = User.changeset(params)

    with {:ok, %User{}} <- User.build(changeset),
         {:ok, _cep_info} <- client().get_cep_info(cep),
         {:ok, %User{}} = user <- Repo.insert(changeset) do
      user
    else
      {:error, %Error{}} = error -> error
      {:error, result} -> {:error, Error.build(:bad_request, result)}
    end
  end

  defp client do
    :rockelivery
    |> Application.fetch_env!(__MODULE__)
    |> Keyword.get(:via_cep_adapter)
  end
end
