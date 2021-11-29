defmodule RockeliveryWeb.FilesView do
  use RockeliveryWeb, :view

  alias Rockelivery.File

  def render("create.json", %{file: %File{} = file}) do
    %{
      message: "File created!",
      file: file
    }
  end
end
