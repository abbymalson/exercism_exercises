defmodule PigLatin do
  @consonants ~r/^(b|ch|c|d|f|g|h|j|k|l|m|n|p|qu|q|r|squ|sch|s|thr|th|t|v|w|x|y|z)+/
  @vowels ~r/^(a|e|i|o|u|yt|xr)/
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with @vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like @consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like @vowels, including "yt" and "xr".
  """
  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase)
    |> Enum.map(&(process_word(&1)))
    |> Enum.join(" ")
  end
  defp process_word(word) do
    # <> concat in elixir
    # This should come at the end since it's the end of the word :)
    cond do
      String.match?(word, @vowels) -> word <> "ay"
      String.match?(word, @consonants) ->
        [first, remaining] = String.split(word, @consonants, include_captures: true, trim: true)
        remaining <> first <> "ay"
      true -> word
    end
  end
end

