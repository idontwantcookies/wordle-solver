defmodule WordleTest do
  use ExUnit.Case, async: true
  doctest Wordle

  setup :words

  describe "solve/2" do
    test "finds given word and returns ok", %{words: words} do
      assert {:ok, _guesses} = Wordle.solve(words, "dont")
    end

    test "keeps track of words tried before coming to the final solution", %{words: words} do
      assert {:ok, guesses} = Wordle.solve(words, "dont")
      assert ["dont", "easy"] = guesses
    end
  end

  describe "best_guess/2" do
    test "suggests first word when there are no guesses", %{words: words} do
      assert Wordle.best_guess(words, []) == Enum.at(words, 0)
    end

    test "suggests first complement word when possible", %{words: words} do
      assert Wordle.best_guess(words, ["test"]) == "test"
    end
  end

  defp words(context) do
    words = ~w(easy here fret test heal deal feel yoga stay dont)

    Map.put(context, :words, words)
  end
end
