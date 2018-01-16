defmodule BitcoinAddress.Elixir do
  @moduledoc """
  Generate a Bitcoin address using only Elixir.
  """

  alias Bitcoin.Key.Public, as: BitcoinPublicKey
  alias BitcoinAddress.Secp256k1

  @doc """
  Generate a Bitcoin address from a private key.

  ## Parameters

    - `private_key`: A string of characters.
    - `:random`: A flag to indicate that a new private key should be generated.

  ## Example:

      iex> private_key = BitcoinAddress.Secp256k1.example_private_key
      iex> BitcoinAddress.Elixir.generate(private_key)
      "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"

  """
  def generate(private_key \\ Secp256k1.example_private_key())
  def generate(:random), do: generate(Secp256k1.generate_private_key())
  def generate(private_key) do
    with bitcoin_public_key <- Secp256k1.bitcoin_public_key(private_key),
         bitcoin_address <- create_bitcoin_address(bitcoin_public_key) do
      IO.puts("Private key: #{inspect(private_key)}")
      IO.puts("Public key: #{inspect(bitcoin_public_key)}")
      IO.puts("Address: #{inspect(bitcoin_address)}")
      bitcoin_address
    end
  end

  defp create_bitcoin_address(bitcoin_public_key) do
    bitcoin_public_key
    |> Base.decode16!(case: :lower)
    |> BitcoinPublicKey.to_address()
  end
end
