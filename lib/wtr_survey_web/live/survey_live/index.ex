defmodule WtrSurveyWeb.SurveyLive.Index do
  use WtrSurveyWeb, :live_view

  alias WtrSurvey.Data
  alias WtrSurvey.Data.Survey

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :surveys, Data.list_surveys())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Survey")
    |> assign(:survey, Data.get_survey!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Survey")
    |> assign(:survey, %Survey{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Surveys")
    |> assign(:survey, nil)
  end

  @impl true
  def handle_info({WtrSurveyWeb.SurveyLive.FormComponent, {:saved, survey}}, socket) do
    {:noreply, stream_insert(socket, :surveys, survey)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    survey = Data.get_survey!(id)
    {:ok, _} = Data.delete_survey(survey)

    {:noreply, stream_delete(socket, :surveys, survey)}
  end
end
