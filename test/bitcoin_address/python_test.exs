defmodule BitcoinAddressPythonTest do
  use ExUnit.Case, async: true
  import ExUnit.CaptureIO
  alias BitcoinAddress.Secp256k1
  doctest BitcoinAddress.Python

  describe "BitcoinAddress.Python" do
    setup %{function: function, args: args} do
      func = fn -> apply(BitcoinAddress.Python, function, args) end
      output = capture_io(func)
      result = func.()
      {:ok, [output: output, result: result]}
    end

    @tag function: :generate, args: [Secp256k1.generate_private_key()]
    test "generate(private_key)", %{output: output, result: result} do
      # https://en.wikipedia.org/wiki/Base58
      # https://en.bitcoin.it/wiki/Address
      expected_output = ~r"""
      \A\
      Private key:\s"[0-9a-z]{64}"
      Public key:\s"[0-9a-z]{66}"
      Bitcoin address:\s"[1-9A-HJ-NP-Za-km-z]{26,35}"
      \z\
      """

      expected_result = ~r/\A[1-9A-HJ-NP-Za-km-z]{26,35}\z/

      assert output =~ expected_output
      assert result =~ expected_result
    end

    @tag function: :generate, args: []
    test "generate()", %{output: output, result: result} do
      # https://en.wikipedia.org/wiki/Base58
      # https://en.bitcoin.it/wiki/Address
      expected_output = ~r"""
      \A\
      Private key:\s"[0-9a-z]{64}"
      Public key:\s"[0-9a-z]{66}"
      Bitcoin address:\s"[1-9A-HJ-NP-Za-km-z]{26,35}"
      \z\
      """

      expected_result = ~r/\A[1-9A-HJ-NP-Za-km-z]{26,35}\z/

      assert output =~ expected_output
      assert result =~ expected_result
    end

    @tag function: :generate, args: [:test]
    test "generate(:test)", %{output: output, result: result} do
      expected_output = """
      Private key: \
      "038109007313a5807b2eccc082c8c3fbb988a973cacf1a7df9ce725c31b14776"
      Public key: \
      "0202a406624211f2abbdc68da3df929f938c3399dd79fac1b51b0e4ad1d26a47aa"
      Bitcoin address: "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"
      """

      expected_result = "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"

      assert output == expected_output
      assert result == expected_result
    end
  end
end
