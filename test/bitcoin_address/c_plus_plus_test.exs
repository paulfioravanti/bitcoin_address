defmodule BitcoinAddressCPlusPlusTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  alias BitcoinAddress.Secp256k1
  doctest BitcoinAddress.CPlusPlus

  describe "BitcoinAddress.CPlusPlus" do
    setup(%{function: function, args: args})do
      result =
        capture_io(fn -> apply(BitcoinAddress.CPlusPlus, function, args) end)
      {:ok, [result: result]}
    end

    @tag function: :generate, args: [Secp256k1.example_private_key]
    test "generate(private_key)", %{result: result} do
      expected =
        """
        Private key: \
        "038109007313a5807b2eccc082c8c3fbb988a973cacf1a7df9ce725c31b14776"
        Public key: \
        "0202a406624211f2abbdc68da3df929f938c3399dd79fac1b51b0e4ad1d26a47aa"
        Address: "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"
        """
      assert result == expected
    end

    @tag function: :generate, args: []
    test "generate()", %{result: result} do
      expected =
        """
        Private key: \
        "038109007313a5807b2eccc082c8c3fbb988a973cacf1a7df9ce725c31b14776"
        Public key: \
        "0202a406624211f2abbdc68da3df929f938c3399dd79fac1b51b0e4ad1d26a47aa"
        Address: "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"
        """
      assert result == expected
    end

    @tag function: :generate, args: [:random]
    test "generate(:random)", %{result: result} do
      # https://en.wikipedia.org/wiki/Base58
      expected =
        ~r"""
        \A\
        Private key:\s"[0-9a-z]{64}"
        Public key:\s"[0-9a-z]{66}"
        Address:\s"[1-9A-HJ-NP-Za-km-z]{34}"
        \z\
        """
      assert result =~ expected
    end
  end
end
