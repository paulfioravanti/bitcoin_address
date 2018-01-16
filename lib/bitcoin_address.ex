defmodule BitcoinAddress do
  @moduledoc """
  Documentation for BitcoinAddress.
  """

  alias BitcoinAddress.Secp256k1

  @doc """
  Uses Elixir by default to generate a Bitcoin address.
  """
  defdelegate generate(private_key), to: BitcoinAddress.Elixir
end
