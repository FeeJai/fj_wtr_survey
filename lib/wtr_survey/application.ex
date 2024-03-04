defmodule WtrSurvey.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      WtrSurveyWeb.Telemetry,
      WtrSurvey.Repo,
      {DNSCluster, query: Application.get_env(:wtr_survey, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: WtrSurvey.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: WtrSurvey.Finch},
      # Start a worker by calling: WtrSurvey.Worker.start_link(arg)
      # {WtrSurvey.Worker, arg},
      # Start to serve requests, typically the last entry
      WtrSurveyWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: WtrSurvey.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    WtrSurveyWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
