# Adapted from the original Python script located here:
# https://github.com/bitcoinbook/bitcoinbook/blob/second_edition/code/key-to-address-ecc-example.py
#
# The goal was to make this script act more like an API wrapper around Python's
# bitcoin library that the Elixir code could call.
# Where possible, the Elixir code calls methods on `bitcoin` directly, but there
# are cases where strings passed via erlport need to be parsed/decoded on the
# python side, and that's why the methods below exist.
#
# NOTE: All methods that accept strings from Elixir have to be decoded into
# UTF-8 in order to work correctly. Elixir passes strings to Python as a
# sequence of bytes, interpreted as `b'...'` literals in Python 3.
# Without the decoding, errors happen.
# REF: https://stackoverflow.com/questions/6269765/what-does-the-b-character-do-in-front-of-a-string-literal
import bitcoin

# Decode hex private key into decimal number
def create_bitcoin_public_key(private_key):
  decoded_private_key = bitcoin.decode_privkey(private_key, "hex")
  public_key = bitcoin.fast_multiply(bitcoin.G, decoded_private_key)
  (public_key_x, public_key_y) = public_key
  if (public_key_y % 2) == 0:
    compressed_prefix = "02"
  else:
    compressed_prefix = "03"
  # 64 represents the minimum length of the string required returned back.
  # Zeros will be prepended to a string until it meets the length requirement.
  # Less characters than 64 will result in an invalid public key.
  return compressed_prefix + bitcoin.encode(public_key_x, 16, 64)
