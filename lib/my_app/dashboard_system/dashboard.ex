defmodule MyApp.DashboardSystem.Dashboard do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "dashboards" do
    field :title, :string
    has_many :link, MyApp.DashboardSystem.Link
    has_many :note, MyApp.DashboardSystem.Note
    belongs_to :user, MyApp.Auth.User

    timestamps()
  end

  @doc false
  def changeset(dashboard, attrs) do
    dashboard
    |> cast(attrs, [:title, :user_id])
    |> validate_required([:title])
    |> unique_constraint(:user_id)
  end
end
