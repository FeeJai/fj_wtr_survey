defmodule WtrSurveyWeb.PromptLive.Show do
  use WtrSurveyWeb, :live_view

  alias WtrSurvey.Data
  alias WtrSurvey.Data.Answer

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    prompt = Data.get_prompt!(id)

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:prompt, prompt)
     |> assign(:you, prompt.max)
     |> assign(:participant, 0)}
  end

  @impl true
  def handle_event("add", _params, socket) do
    prompt = socket.assigns.prompt
    participant = socket.assigns.participant
    you = socket.assigns.you

    if you < prompt.max do
      {:noreply,
       socket
       |> assign(:participant, participant - prompt.factor)
       |> assign(:you, you + 1)}
    else
      {:noreply, socket}
    end
  end

  @impl true
  def handle_event("subtract", _params, socket) do
    prompt = socket.assigns.prompt
    participant = socket.assigns.participant
    you = socket.assigns.you

    if you > 0 do
      {:noreply,
       socket
       |> assign(:participant, participant + prompt.factor)
       |> assign(:you, you - 1)}
    else
      {:noreply, socket}
    end
  end

  @impl true
  def handle_event("save", _params, socket) do
    prompt = socket.assigns.prompt

    case Data.create_answer(%{
           "you" => socket.assigns.you,
           "participant" => socket.assigns.participant,
           "prompt_id" => prompt.id
         }) do
      {:ok, _answer} ->
        {:noreply,
         socket |> put_flash(:info, "Answer saved successfully") |> push_redirect(to: ~p"/")}

      {:error, _changeset} ->
        {:noreply, socket |> put_flash(:warning, "Error when saving answer")}
    end
  end

  defp page_title(:show), do: "Show Prompt"
  defp page_title(:edit), do: "Edit Prompt"
end
