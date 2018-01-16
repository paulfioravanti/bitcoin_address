defmodule BitcoinAddress do
  @moduledoc """
  Documentation for BitcoinAddress.
  """

  @doc """
  Uses Elixir by default to generate a Bitcoin address.

  ## Parameters

    - `private_key`: A string of characters.
    - `:test`: Flag to use a pregenerated private key.

  ## Example:

      iex> private_key = BitcoinAddress.Secp256k1.example_private_key
      iex> BitcoinAddress.generate(private_key)
      "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"
  """
  defdelegate generate, to: BitcoinAddress.Elixir
  defdelegate generate(private_key), to: BitcoinAddress.Elixir
end
