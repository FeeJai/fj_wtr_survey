defmodule WtrSurveyWeb.AnswerLive.FormComponent do
  use WtrSurveyWeb, :live_component

  alias WtrSurvey.Data

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage answer records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="answer-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:you]} type="number" label="You" step="any" />
        <.input field={@form[:participant]} type="number" label="Participant" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Answer</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{answer: answer} = assigns, socket) do
    changeset = Data.change_answer(answer)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"answer" => answer_params}, socket) do
    changeset =
      socket.assigns.answer
      |> Data.change_answer(answer_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"answer" => answer_params}, socket) do
    save_answer(socket, socket.assigns.action, answer_params)
  end

  defp save_answer(socket, :edit, answer_params) do
    case Data.update_answer(socket.assigns.answer, answer_params) do
      {:ok, answer} ->
        notify_parent({:saved, answer})

        {:noreply,
         socket
         |> put_flash(:info, "Answer updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_answer(socket, :new, answer_params) do
    case Data.create_answer(answer_params) do
      {:ok, answer} ->
        notify_parent({:saved, answer})

        {:noreply,
         socket
         |> put_flash(:info, "Answer created successfully")
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
