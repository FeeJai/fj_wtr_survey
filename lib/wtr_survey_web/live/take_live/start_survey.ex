defmodule WtrSurveyWeb.TakeLive.StartSurvey do
  use WtrSurveyWeb, :live_view

  alias WtrSurvey.Surveys
  alias WtrSurvey.Surveys.Survey
  alias WtrSurvey.Data.Session

  @impl true
  def mount(%{"survey_id" => survey_id}, _session, socket) do
    survey = Surveys.get_survey!(survey_id)

    {:ok,
     socket
     |> assign(survey: survey)
     |> assign_form(Session.changeset(%Session{}, %{survey_id: survey.id}))}
  end

  def handle_event("validate", %{"session" => session_params}, socket) do
    survey = socket.assigns.survey

    changeset =
      %Session{}
      |> Session.changeset(Map.put(session_params, "survey_id", survey.id))
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  @impl true
  def handle_event("save", %{"session" => session_params}, socket) do
    survey = socket.assigns.survey
    session_params = Map.put(session_params, "survey_id", survey.id)

    case WtrSurvey.Data.create_session(session_params) do
      {:ok, session} ->
        {:noreply, push_navigate(socket, to: ~p"/take_survey/session/#{session.id}")}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @survey.title %>
        <:subtitle>You are about to start answering this survey. Please tell us your name</:subtitle>
      </.header>

      <.simple_form for={@form} id="survey-start-form" phx-change="validate" phx-submit="save">
        <.input field={@form[:participant_name]} type="text" label="Your name" />
        <:actions>
          <.button phx-disable-with="Starting...">Begin Survey</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end
end
