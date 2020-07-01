defmodule MyApp.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string
      add :text, :string
      add :markdown, :boolean, default: false, null: false
      add :html_saved, :boolean, default: false, null: false
      add :dashboard_id, references(:dashboards, on_delete: :delete_all, null: false, type: :binary_id)

      timestamps()
    end

    create unique_index(:notes, [:title])
  end
end
