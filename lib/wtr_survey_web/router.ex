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
    live "/surveys/:survey_id/edit", SurveyLive.Index, :edit

    live "/surveys/:survey_id", SurveyLive.Show, :show
    live "/surveys/:survey_id/show/edit", SurveyLive.Show, :edit

    live "/surveys/:survey_id/prompts", PromptLive.Index, :index
    live "/surveys/:survey_id/prompts/new", PromptLive.Index, :new
    live "/surveys/:survey_id/prompts/:id/edit", PromptLive.Index, :edit

    live "/surveys/:survey_id/prompts/:id", PromptLive.Show, :show
    live "/surveys/:survey_id/prompts/:id/show/edit", PromptLive.Show, :edit

    live "/take_survey/survey/:survey_id", TakeLive.StartSurvey, :take_survey
    live "/take_survey/session/:session_id", TakeLive.AnswerSurvey, :answer_survey

    live "/answers", AnswerLive.Index, :index
    live "/answers/new", AnswerLive.Index, :new
    live "/answers/:id/edit", AnswerLive.Index, :edit

    live "/answers/:id", AnswerLive.Show, :show
    live "/answers/:id/show/edit", AnswerLive.Show, :edit
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
