defmodule WtrSurveyWeb.ResultsController do
  use WtrSurveyWeb, :controller

  alias WtrSurvey.Surveys
  alias WtrSurvey.Repo

  def show(conn, %{"survey_id" => survey_id}) do
    # The home page is often custom made,
    # so skip the default app layout.

    survey =
      Surveys.get_survey!(survey_id)
      |> Repo.preload(:prompts)

    # Get all sessions for this survey
    answer_sessions = WtrSurvey.Data.list_sessions_by_survey_id(survey.id)

    render(conn, :show, survey: survey, answer_sessions: answer_sessions)
  end
end
