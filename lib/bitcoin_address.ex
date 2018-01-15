defmodule BitcoinAddress do
  @moduledoc """
  Documentation for BitcoinAddress.
  """

  alias BitcoinAddress.Secp256k1

  @doc """
  Uses Elixir to generate a Bitcoin address.

  ## Parameters

    - `private_key`: A string of characters.
    - `:random`: A flag to indicate that a new private key should be generated.
  """
  def generate(private_key \\ Secp256k1.example_private_key)
  def generate(:random) do
    Secp256k1.generate_private_key()
    |> generate()
  end
  defdelegate generate(private_key), to: BitcoinAddress.Elixir
end
