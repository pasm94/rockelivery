defmodule Rockelivery.Files.Create do
  alias Rockelivery.{Error, Repo}
  alias Rockelivery.File, as: RockeliveryFile

  def call(%{"file" => file}) do
    # IO.inspect(file.filename)

    # upload = %Plug.Upload{
    #   content_type: "image",
    #   filename: "1.png",
    #   path: "#{File.cwd!()}/haa.png"
    # }

    # extension = Path.extname(file.filename)
    File.cp(file.path, "#{File.cwd!()}/xyj_files/#{file.filename}")

    save(%{name: file.filename, path: "#{File.cwd!()}/xyj_files/"})
  end

  defp save(params) do
    params
    |> RockeliveryFile.changeset()
    |> Repo.insert()
    |> handle_insert()
  end

  defp handle_insert({:ok, %RockeliveryFile{}} = result), do: result

  defp handle_insert({:error, result}), do: {:error, Error.build(:bad_request, result)}
end
