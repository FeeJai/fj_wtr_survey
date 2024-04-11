defmodule WtrSurveyWeb.PromptLive.Show do
  use WtrSurveyWeb, :live_view

  alias WtrSurvey.Data

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id, "survey_id" => survey_id}, _, socket) do
    prompt = Data.get_prompt!(id)

    y_scale_max = max(prompt.max, prompt.max * prompt.factor) |> ceil() |> trunc()

    participant_1_amount = ceil(prompt.max / 2)
    participant_2_amount = (prompt.max - participant_1_amount) * prompt.factor

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:prompt, prompt)
     |> assign(:survey_id, survey_id)
     |> assign(:you, participant_1_amount)
     |> assign(:participant, participant_2_amount)
     |> assign(:y_scale_max, y_scale_max)}
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
