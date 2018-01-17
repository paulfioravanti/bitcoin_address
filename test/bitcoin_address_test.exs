defmodule BitcoinAddressTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  alias BitcoinAddress.Secp256k1
  doctest BitcoinAddress

  @output_format ~r"""
  \A\
  Private key:\s"[0-9a-z]{64}"
  Public key:\s"[0-9a-z]{66}"
  Bitcoin address:\s"[1-9A-HJ-NP-Za-km-z]{26,35}"
  \z\
  """
  # https://en.wikipedia.org/wiki/Base58
  # https://en.bitcoin.it/wiki/Address
  @bitcoin_address_format ~r/\A[1-9A-HJ-NP-Za-km-z]{26,35}\z/
  @test_key_address "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"
  @test_key_output """
  Private key: \
  "038109007313a5807b2eccc082c8c3fbb988a973cacf1a7df9ce725c31b14776"
  Public key: \
  "0202a406624211f2abbdc68da3df929f938c3399dd79fac1b51b0e4ad1d26a47aa"
  Bitcoin address: "#{@test_key_address}"
  """

  describe "BitcoinAddress" do
    setup %{function: function, args: args} do
      func = fn -> apply(BitcoinAddress, function, args) end
      output = capture_io(func)
      result = func.()
      {:ok, [output: output, result: result]}
    end

    @tag function: :generate, args: [Secp256k1.generate_private_key()]
    test "generate(private_key)", %{output: output, result: result} do
      assert output =~ @output_format
      assert result =~ @bitcoin_address_format
    end

    @tag function: :generate, args: []
    test "generate()", %{output: output, result: result} do
      assert output =~ @output_format
      assert result =~ @bitcoin_address_format
    end

    @tag function: :generate, args: [:test]
    test "generate(:test)", %{output: output, result: result} do
      assert output == @test_key_output
      assert result == @test_key_address
    end
  end
end
