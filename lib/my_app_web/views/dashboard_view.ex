defmodule MyAppWeb.DashboardView do
  use MyAppWeb, :view
  alias MyAppWeb.DashboardView

  def render("index.json", %{dashboards: dashboards}) do
    %{data: render_many(dashboards, DashboardView, "dashboard.json")}
  end

  def render("show.json", %{dashboard: dashboard}) do
    %{data: render_one(dashboard, DashboardView, "dashboard.json")}
  end

  def render("dashboard.json", %{dashboard: dashboard}) do
    %{id: dashboard.id,
      title: dashboard.title}
  end
end
