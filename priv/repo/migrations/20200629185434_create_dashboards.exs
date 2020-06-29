defmodule MyApp.Repo.Migrations.CreateDashboards do
  use Ecto.Migration

  def change do
    create table(:dashboards, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :user_id, references(:users, on_delete: :delete_all, null: false, type: :binary_id)

      timestamps()
    end

    create unique_index(:dashboards, [:user_id])
  end
end
