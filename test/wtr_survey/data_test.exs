defmodule WtrSurvey.DataTest do
  use WtrSurvey.DataCase

  alias WtrSurvey.Data

  describe "prompts" do
    alias WtrSurvey.Data.Prompt

    import WtrSurvey.DataFixtures

    @invalid_attrs %{title: nil}

    test "list_prompts/0 returns all prompts" do
      prompt = prompt_fixture()
      assert Data.list_prompts() == [prompt]
    end

    test "get_prompt!/1 returns the prompt with given id" do
      prompt = prompt_fixture()
      assert Data.get_prompt!(prompt.id) == prompt
    end

    test "create_prompt/1 with valid data creates a prompt" do
      valid_attrs = %{title: "some title"}

      assert {:ok, %Prompt{} = prompt} = Data.create_prompt(valid_attrs)
      assert prompt.title == "some title"
    end

    test "create_prompt/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_prompt(@invalid_attrs)
    end

    test "update_prompt/2 with valid data updates the prompt" do
      prompt = prompt_fixture()
      update_attrs = %{title: "some updated title"}

      assert {:ok, %Prompt{} = prompt} = Data.update_prompt(prompt, update_attrs)
      assert prompt.title == "some updated title"
    end

    test "update_prompt/2 with invalid data returns error changeset" do
      prompt = prompt_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_prompt(prompt, @invalid_attrs)
      assert prompt == Data.get_prompt!(prompt.id)
    end

    test "delete_prompt/1 deletes the prompt" do
      prompt = prompt_fixture()
      assert {:ok, %Prompt{}} = Data.delete_prompt(prompt)
      assert_raise Ecto.NoResultsError, fn -> Data.get_prompt!(prompt.id) end
    end

    test "change_prompt/1 returns a prompt changeset" do
      prompt = prompt_fixture()
      assert %Ecto.Changeset{} = Data.change_prompt(prompt)
    end
  end

  describe "answers" do
    alias WtrSurvey.Data.Answer

    import WtrSurvey.DataFixtures

    @invalid_attrs %{participant: nil, you: nil}

    test "list_answers/0 returns all answers" do
      answer = answer_fixture()
      assert Data.list_answers() == [answer]
    end

    test "get_answer!/1 returns the answer with given id" do
      answer = answer_fixture()
      assert Data.get_answer!(answer.id) == answer
    end

    test "create_answer/1 with valid data creates a answer" do
      valid_attrs = %{participant: 120.5, you: 120.5}

      assert {:ok, %Answer{} = answer} = Data.create_answer(valid_attrs)
      assert answer.participant == 120.5
      assert answer.you == 120.5
    end

    test "create_answer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Data.create_answer(@invalid_attrs)
    end

    test "update_answer/2 with valid data updates the answer" do
      answer = answer_fixture()
      update_attrs = %{participant: 456.7, you: 456.7}

      assert {:ok, %Answer{} = answer} = Data.update_answer(answer, update_attrs)
      assert answer.participant == 456.7
      assert answer.you == 456.7
    end

    test "update_answer/2 with invalid data returns error changeset" do
      answer = answer_fixture()
      assert {:error, %Ecto.Changeset{}} = Data.update_answer(answer, @invalid_attrs)
      assert answer == Data.get_answer!(answer.id)
    end

    test "delete_answer/1 deletes the answer" do
      answer = answer_fixture()
      assert {:ok, %Answer{}} = Data.delete_answer(answer)
      assert_raise Ecto.NoResultsError, fn -> Data.get_answer!(answer.id) end
    end

    test "change_answer/1 returns a answer changeset" do
      answer = answer_fixture()
      assert %Ecto.Changeset{} = Data.change_answer(answer)
    end
  end
end
