defmodule SecretHandshake do
  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @phrase_map %{
    0 => "wink",
    1 => "double blink",
    2 => "close your eyes",
    3 => "jump"
  }

  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    binary_char_list = Integer.to_charlist(code, 2)

    reversed_char_list = Enum.reverse(binary_char_list)
    bit_list =
      reversed_char_list
      |> Enum.map(fn char -> char == ?1 end)

    head = Enum.slice(bit_list, 0, 4)
    reverse? = Enum.at(bit_list, 4)

    phrases =
      Enum.with_index(head)
      |> Enum.map(fn {bit, index} ->
        if bit do
          @phrase_map[index]
        else
          nil
        end
      end)
      |> Enum.filter(fn phrase -> phrase end)

    if reverse? do
      Enum.reverse(phrases)
    else
      phrases
    end
  end
end

