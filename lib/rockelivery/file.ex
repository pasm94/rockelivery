defmodule Rockelivery.File do
  use Ecto.Schema

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :path]

  @derive {Jason.Encoder, only: @required_params ++ [:id]}

  schema "files" do
    field :name, :string
    field :path, :string

    timestamps()
  end

  def changeset(struct \\ %__MODULE__{}, params) do
    struct
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:name, min: 3)
    |> validate_length(:path, min: 3)
  end
end
