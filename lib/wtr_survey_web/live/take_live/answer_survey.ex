defmodule WtrSurveyWeb.TakeLive.AnswerSurvey do
  use WtrSurveyWeb, :live_view

  @impl true
  def mount(%{"session_id" => session_id}, _session, socket) do
    session = WtrSurvey.Data.get_session!(session_id)

    next_prompt = get_next_prompt(session)

    {:ok,
     socket
     |> assign(session: session)
     |> socket_for_next_prompt(next_prompt)}
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

    case WtrSurvey.Data.create_answer(%{
           "session_id" => socket.assigns.session.id,
           "you" => socket.assigns.you,
           "participant" => socket.assigns.participant,
           "prompt_id" => prompt.id
         }) do
      {:ok, _answer} ->
        session = socket.assigns.session
        next_prompt = get_next_prompt(session)

        {:noreply,
         socket
         |> put_flash(:info, "Answer saved successfully")
         |> socket_for_next_prompt(next_prompt)}

      {:error, _changeset} ->
        {:noreply, socket |> put_flash(:warning, "Error when saving answer")}
    end
  end

  defp socket_for_next_prompt(socket, prompt) do
    if prompt == nil do
      socket
      |> assign(completed: true)
    else
      socket
      |> assign(completed: false)
      |> assign_prompt_values(prompt)
    end
  end

  defp get_next_prompt(session) do
    survey_id = session.survey_id
    prompts = WtrSurvey.Data.list_unanswered_prompts_by_session_id(survey_id, session.id)

    List.first(prompts)
  end

  defp assign_prompt_values(socket, prompt) do
    y_scale_max = max(prompt.max, prompt.max * prompt.factor) |> ceil() |> trunc()

    participant_1_amount = ceil(prompt.max / 2)
    participant_2_amount = (prompt.max - participant_1_amount) * prompt.factor

    socket
    |> assign(:prompt, prompt)
    |> assign(:you, participant_1_amount)
    |> assign(:participant, participant_2_amount)
    |> assign(:y_scale_max, y_scale_max)
  end
end
