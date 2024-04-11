defmodule WtrSurveyWeb.PageController do
  use WtrSurveyWeb, :controller

  alias WtrSurvey.Surveys

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.

    survey_collection = Surveys.list_active_survey()
    render(conn, :home, survey_collection: survey_collection)
  end
end
