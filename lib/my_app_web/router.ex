defmodule MyAppWeb.Router do
  use MyAppWeb, :router

  pipeline :api do
    plug CORSPlug, origin: ["http://localhost:8080"]
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :api_auth do
    plug :ensure_authenticated
  end

  scope "/", MyAppWeb do

  end

  scope "/api", MyAppWeb do
    pipe_through :api
    post "/users/sign_in", UserController, :sign_in
    resources "/users", UserController, except: [:show, :new, :edit]

    options "/users", UserController, :options
    options "/users/sign_in", UserController, :options


  end

  scope "/api", MyAppWeb do
    pipe_through [:api, :api_auth]
    get "/users/show_user", UserController, :show
    get "/getDashboard/", DashboardController, :show
    delete "/dashboards", DashboardController, :delete
    resources "/dashboards", DashboardController, except: [:new, :edit]
    resources "/links", LinkController, except: [:new, :edit]
    resources "/notes", NoteController, except: [:new, :edit]


    options "/dashboards", UserController, :options
    options "/links", UserController, :options
    options "/notes", UserController, :options

  end

  defp ensure_authenticated(conn, _opts) do
    case get_session(conn, :current_user_id) do
      nil ->
        conn
        |> put_status(:unauthorized)
        |> put_view(MyAppWeb.ErrorView)
        |> render("401.json", message: "unauthenticated user")
        |> halt()
      current_user_id ->
        assign(conn, :current_user, MyApp.Auth.get_user!(current_user_id))
    end
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: MyAppWeb.Telemetry
    end
  end
end
