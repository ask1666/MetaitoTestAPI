defmodule MyAppWeb.NoteController do
  use MyAppWeb, :controller

  alias MyApp.DashboardSystem
  alias MyApp.DashboardSystem.Note

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    notes = DashboardSystem.list_notes()
    render(conn, "index.json", notes: notes)
  end

  def create(conn, %{"dashboard_id" => dashboard_id, "note" => note_params}) do
    with {:ok, %Note{} = note} <- DashboardSystem.create_note(dashboard_id,note_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.note_path(conn, :show, note))
      |> render("show.json", note: note)
    end
  end

  def show(conn, %{"id" => id}) do
    note = DashboardSystem.get_note!(id)
    render(conn, "show.json", note: note)
  end

  def update(conn, %{"id" => id, "note" => note_params}) do
    note = DashboardSystem.get_note!(id)

    with {:ok, %Note{} = note} <- DashboardSystem.update_note(note, note_params) do
      render(conn, "show.json", note: note)
    end
  end

  def delete(conn, %{"id" => id}) do
    note = DashboardSystem.get_note!(id)

    with {:ok, %Note{}} <- DashboardSystem.delete_note(note) do
      send_resp(conn, :no_content, "")
    end
  end
end
