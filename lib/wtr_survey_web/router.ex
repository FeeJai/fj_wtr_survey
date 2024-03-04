defmodule WtrSurveyWeb.Router do
  use WtrSurveyWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {WtrSurveyWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", WtrSurveyWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/surveys", SurveyLive.Index, :index
    live "/surveys/new", SurveyLive.Index, :new
    live "/surveys/:id/edit", SurveyLive.Index, :edit

    live "/surveys/:id", SurveyLive.Show, :show
    live "/surveys/:id/show/edit", SurveyLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", WtrSurveyWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:wtr_survey, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: WtrSurveyWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
