defmodule BitcoinAddressElixirTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  alias BitcoinAddress.Secp256k1
  doctest BitcoinAddress.Elixir

  describe "BitcoinAddress.Elixir" do
    setup(%{private_key: private_key})do
      result = capture_io(fn -> BitcoinAddress.Elixir.generate(private_key) end)
      expected =
        """
        Private key: \
        "038109007313a5807b2eccc082c8c3fbb988a973cacf1a7df9ce725c31b14776"
        Public key: \
        "0202a406624211f2abbdc68da3df929f938c3399dd79fac1b51b0e4ad1d26a47aa"
        Address: "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"
        """
      {:ok, [result: result, expected: expected]}
    end

    @tag private_key: Secp256k1.example_private_key
    test "generate()", %{result: result, expected: expected} do
      assert result == expected
    end
  end
end
