defmodule WtrSurvey.Repo do
  use Ecto.Repo,
    otp_app: :wtr_survey,
    adapter: Ecto.Adapters.Postgres
end
