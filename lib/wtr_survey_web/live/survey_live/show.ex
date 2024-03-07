defmodule WtrSurveyWeb.SurveyLive.Show do
  use WtrSurveyWeb, :live_view

  alias WtrSurvey.Surveys

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"survey_id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:survey, Surveys.get_survey!(id))}
  end

  defp page_title(:show), do: "Show Survey"
  defp page_title(:edit), do: "Edit Survey"
end
