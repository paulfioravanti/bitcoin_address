defmodule BitcoinAddress do
  @moduledoc """
  Documentation for BitcoinAddress.
  """

  @doc """
  Uses Elixir by default to generate a Bitcoin address.

  ## Parameters

    - `private_key`: A string of characters.
    - `:random`: A flag to indicate that a new private key should be generated.

  ## Example:

      iex> private_key = BitcoinAddress.Secp256k1.example_private_key
      iex> BitcoinAddress.generate(private_key)
      "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"
  """
  defdelegate generate(private_key), to: BitcoinAddress.Elixir
end
