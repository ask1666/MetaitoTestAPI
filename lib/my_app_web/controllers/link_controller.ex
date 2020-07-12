defmodule MyAppWeb.LinkController do
  use MyAppWeb, :controller

  alias MyApp.DashboardSystem
  alias MyApp.DashboardSystem.Link

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    links = DashboardSystem.list_links()
    render(conn, "index.json", links: links)
  end

  def create(conn, %{"dashboard_id" => dashboard_id, "link" => link_params}) do
    with {:ok, %Link{} = link} <- DashboardSystem.create_link(dashboard_id, link_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.link_path(conn, :show, link))
      |> render("show.json", link: link)
    end
  end

  def show(conn, %{"id" => id}) do
    link = DashboardSystem.get_link!(id)
    render(conn, "show.json", link: link)
  end

  def update(conn, %{"id" => id, "link" => link_params}) do
    link = DashboardSystem.get_link!(id)

    with {:ok, %Link{} = link} <- DashboardSystem.update_link(link, link_params) do
      render(conn, "show.json", link: link)
    end
  end

  def delete(conn, %{"id" => id}) do
    link = DashboardSystem.get_link!(id)

    with {:ok, %Link{}} <- DashboardSystem.delete_link(link) do
      send_resp(conn, :no_content, "")
    end
  end
end
