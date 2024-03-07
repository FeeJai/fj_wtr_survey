defmodule WtrSurveyWeb.PromptLive.Index do
  use WtrSurveyWeb, :live_view

  alias WtrSurvey.Data
  alias WtrSurvey.Data.Prompt

  @impl true
  def mount(_params = %{"survey_id" => survey_id}, _session, socket) do
    {:ok,
     socket
     |> assign(:survey_id, survey_id)
     |> stream(:prompts, Data.list_prompts())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Prompt")
    |> assign(:prompt, Data.get_prompt!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Prompt")
    |> assign(:prompt, %Prompt{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Prompts")
    |> assign(:prompt, nil)
  end

  @impl true
  def handle_info({WtrSurveyWeb.PromptLive.FormComponent, {:saved, prompt}}, socket) do
    {:noreply, stream_insert(socket, :prompts, prompt)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    prompt = Data.get_prompt!(id)
    {:ok, _} = Data.delete_prompt(prompt)

    {:noreply, stream_delete(socket, :prompts, prompt)}
  end
end
