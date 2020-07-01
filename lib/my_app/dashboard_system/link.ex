defmodule MyApp.DashboardSystem.Link do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title, :url]}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "links" do
    field :title, :string
    field :url, :string
    belongs_to :dashboard, MyApp.DashboardSystem.Dashboard

    timestamps()
  end

  @doc false
  def changeset(link, attrs) do
    link
    |> cast(attrs, [:title, :url])
    |> validate_required([:title, :url])
    |> unique_constraint(:title)
  end
end
