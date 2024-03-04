defmodule WtrSurveyWeb.SurveyLive.FormComponent do
  use WtrSurveyWeb, :live_component

  alias WtrSurvey.Data

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage survey records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="survey-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Survey</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{survey: survey} = assigns, socket) do
    changeset = Data.change_survey(survey)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"survey" => survey_params}, socket) do
    changeset =
      socket.assigns.survey
      |> Data.change_survey(survey_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"survey" => survey_params}, socket) do
    save_survey(socket, socket.assigns.action, survey_params)
  end

  defp save_survey(socket, :edit, survey_params) do
    case Data.update_survey(socket.assigns.survey, survey_params) do
      {:ok, survey} ->
        notify_parent({:saved, survey})

        {:noreply,
         socket
         |> put_flash(:info, "Survey updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_survey(socket, :new, survey_params) do
    case Data.create_survey(survey_params) do
      {:ok, survey} ->
        notify_parent({:saved, survey})

        {:noreply,
         socket
         |> put_flash(:info, "Survey created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
