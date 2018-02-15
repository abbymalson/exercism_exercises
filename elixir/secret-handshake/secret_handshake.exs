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
  @spec commands(code :: integer) :: list(String.t())
  def commands(code) do
    # convert code to binary string
    binary_char_list = Integer.to_charlist(code, 2)

    # store the results of the checks in a string/array/list so we can revers the action if there is a NOT

    # Find the length of the string?
    # should be able to
    count(binary_char_list)
    # ...
    # Enum.map(Integer.to_charlist(code, 2))
    Enum.map(binary_char_list)
    # Enum.slice(binary_char_list, position)
    # if 5 characters, and that value is a '1' then flip the results ...

    # if at position 4th position jump (and value is '1') - Jump

    # if at 3rd position - Close your eyes

    # if at 2nd position - double blink
    # if at 1st position - Check for Wink
  end
end

