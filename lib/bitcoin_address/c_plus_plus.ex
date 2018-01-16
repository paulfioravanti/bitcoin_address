defmodule BitcoinAddress.CPlusPlus do
  @moduledoc """
  Generate a Bitcoin address using C++ libraries.
  """

  alias BitcoinAddress.Secp256k1
  alias Cure.Server, as: Cure

  @cpp_executable "priv/bitcoin_address"
  # Integers representing C++ methods
  @generate_public_key 1
  @create_bitcoin_address 2

  @doc """
  Generate a Bitcoin address from a private key.

  ## Parameters

    - `private_key`: A string of characters.
    - `:test`: Flag to use a pregenerated private key.

  ## Example:

      iex> private_key = BitcoinAddress.Secp256k1.example_private_key
      iex> BitcoinAddress.CPlusPlus.generate(private_key)
      "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"

  """
  def generate(private_key \\ Secp256k1.generate_private_key())
  def generate(:test), do: generate(Secp256k1.example_private_key())
  def generate(private_key) do
    with {:ok, pid} <- Cure.start_link(@cpp_executable),
         bitcoin_public_key <- create_bitcoin_public_key(pid, private_key),
         bitcoin_address <- create_bitcoin_address(pid, bitcoin_public_key) do
      IO.puts("Private key: #{inspect(private_key)}")
      IO.puts("Public key: #{inspect(bitcoin_public_key)}")
      IO.puts("Bitcoin address: #{inspect(bitcoin_address)}")
      :ok = Cure.stop(pid)
      bitcoin_address
    end
  end

  defp create_bitcoin_public_key(pid, private_key) do
    call_cpp(pid, <<@generate_public_key, private_key :: binary>>)
  end

  defp create_bitcoin_address(pid, bitcoin_public_key) do
    call_cpp(pid, <<@create_bitcoin_address, bitcoin_public_key :: binary>>)
  end

  defp call_cpp(pid, data) do
    Cure.send_data(pid, data, :once)
    receive do
      {:cure_data, response} ->
        response
    end
  end
end
