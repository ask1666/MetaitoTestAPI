defmodule MyApp.DashboardSystem.Note do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :title, :text, :markdown, :html_saved]}
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "notes" do
    field :html_saved, :boolean, default: false
    field :markdown, :boolean, default: false
    field :text, :string
    field :title, :string
    belongs_to :dashboard, MyApp.DashboardSystem.Dashboard

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:title, :text, :markdown, :html_saved])
    |> validate_required([:title, :text, :markdown, :html_saved])
  end
end
