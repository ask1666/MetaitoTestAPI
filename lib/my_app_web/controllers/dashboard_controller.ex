defmodule MyAppWeb.DashboardController do
  use MyAppWeb, :controller

  alias MyApp.DashboardSystem
  alias MyApp.DashboardSystem.Dashboard

  action_fallback MyAppWeb.FallbackController

  def index(conn, _params) do
    dashboards = DashboardSystem.list_dashboards()
    render(conn, "index.json", dashboards: dashboards)
  end

  def create(conn, %{"dashboard" => dashboard_params}) do
    with {:ok, %Dashboard{} = dashboard} <- DashboardSystem.create_dashboard(dashboard_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.dashboard_path(conn, :show, dashboard))
      |> render("show.json", dashboard: dashboard)
    end
  end

  def show(conn, %{"id" => id}) do
    dashboard = DashboardSystem.get_dashboard!(id)
    render(conn, "show.json", dashboard: dashboard)
  end

  def update(conn, %{"id" => id, "dashboard" => dashboard_params}) do
    dashboard = DashboardSystem.get_dashboard!(id)

    with {:ok, %Dashboard{} = dashboard} <- DashboardSystem.update_dashboard(dashboard, dashboard_params) do
      render(conn, "show.json", dashboard: dashboard)
    end
  end

  def delete(conn, %{"id" => id}) do
    dashboard = DashboardSystem.get_dashboard!(id)

    with {:ok, %Dashboard{}} <- DashboardSystem.delete_dashboard(dashboard) do
      send_resp(conn, :no_content, "")
    end
  end
end
