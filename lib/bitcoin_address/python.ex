defmodule BitcoinAddress.Python do
  @moduledoc """
  Generate a Bitcoin address using Python libraries.
  """

  use Export.Python
  alias BitcoinAddress.Secp256k1

  @python_src :bitcoin_address |> :code.priv_dir() |> Path.basename()
  @python_file "bitcoin_address"

  @doc """
  Generate a Bitcoin address from a private key.

  ## Example:

      iex> private_key = BitcoinAddress.Secp256k1.example_private_key
      iex> BitcoinAddress.Python.generate(private_key)
      "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"

  """
  def generate(private_key \\ Secp256k1.example_private_key()) do
    with {:ok, pid} <- Python.start(python_path: @python_src),
         bitcoin_public_key <- create_bitcoin_public_key(pid, private_key),
         bitcoin_address <- create_bitcoin_address(pid, bitcoin_public_key) do
      IO.puts("Private key: #{inspect(private_key)}")
      IO.puts("Public key: #{inspect(bitcoin_public_key)}")
      IO.puts("Address: #{inspect(bitcoin_address)}")
      Python.stop(pid)
      bitcoin_address
    end
  end

  defp create_bitcoin_public_key(pid, private_key) do
    pid
    |> Python.call(@python_file, "create_bitcoin_public_key", [private_key])
    |> to_string()
  end

  defp create_bitcoin_address(pid, bitcoin_pub_key) do
    pid
    |> Python.call(@python_file, "bitcoin.pubkey_to_address", [bitcoin_pub_key])
    |> to_string()
  end
end