defmodule MyApp.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:links, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :url, :string
      add :dashboard_id, references(:dashboards, on_delete: :delete_all, null: false, type: :binary_id)

      timestamps()
    end

  end
end
