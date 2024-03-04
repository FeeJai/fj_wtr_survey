defmodule WtrSurveyWeb.SurveyLive.Show do
  use WtrSurveyWeb, :live_view

  alias WtrSurvey.Data

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:survey, Data.get_survey!(id))
     |> assign(:left, 0)
     |> assign(:right, 0)}
  end

  @impl true
  def handle_event("add", %{"left" => current}, socket) do
    {:noreply, socket |> assign(:left, String.to_integer(current) + 1)}
  end

  @impl true
  def handle_event("add", %{"right" => current}, socket) do
    {:noreply, socket |> assign(:right, String.to_integer(current) + 1)}
  end

  defp page_title(:show), do: "Show Survey"
  defp page_title(:edit), do: "Edit Survey"
end
