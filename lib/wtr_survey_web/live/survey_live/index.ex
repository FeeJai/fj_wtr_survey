defmodule WtrSurveyWeb.SurveyLive.Index do
  use WtrSurveyWeb, :live_view

  alias WtrSurvey.Surveys
  alias WtrSurvey.Surveys.Survey

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :survey_collection, Surveys.list_survey())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"survey_id" => id}) do
    socket
    |> assign(:page_title, "Edit Survey")
    |> assign(:survey, Surveys.get_survey!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Survey")
    |> assign(:survey, %Survey{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Survey")
    |> assign(:survey, nil)
  end

  @impl true
  def handle_info({WtrSurveyWeb.SurveyLive.FormComponent, {:saved, survey}}, socket) do
    {:noreply, stream_insert(socket, :survey_collection, survey)}
  end

  @impl true
  def handle_event("delete", %{"survey_id" => id}, socket) do
    survey = Surveys.get_survey!(id)
    {:ok, _} = Surveys.delete_survey(survey)

    {:noreply, stream_delete(socket, :survey_collection, survey)}
  end
end
