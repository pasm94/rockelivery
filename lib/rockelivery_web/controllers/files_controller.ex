defmodule RockeliveryWeb.FilesController do
  use RockeliveryWeb, :controller

  alias Rockelivery.File, as: AppFile
  alias RockeliveryWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %AppFile{} = file} <- Rockelivery.create_file(params) do
      conn
      |> put_status(:created)
      |> render("create.json", file: file)
    end
  end
end
