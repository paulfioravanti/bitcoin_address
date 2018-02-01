defmodule BitcoinAddress do
  @moduledoc """
  Documentation for BitcoinAddress.
  """

  @doc """
  Uses Elixir by default to generate a Bitcoin address, generating a private
  key at random.

  ## Example:

      iex> address = BitcoinAddress.generate()
      iex> base58_pattern = ~r/\\A[1-9A-HJ-NP-Za-km-z]{26,35}\\z/
      iex> address =~ base58_pattern
      true
  """
  defdelegate generate, to: BitcoinAddress.Elixir

  @doc """
  Uses Elixir by default to generate a Bitcoin address.

  ## Parameters

    - `private_key`: A string of characters.
    - `:test`: Flag to use a pregenerated private key.

  ## Examples:

      iex> private_key = BitcoinAddress.Secp256k1.example_private_key
      iex> BitcoinAddress.generate(private_key)
      "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"

      iex> BitcoinAddress.generate(:test)
      "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"
  """
  defdelegate generate(private_key), to: BitcoinAddress.Elixir
end
