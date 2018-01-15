# Bitcoin Address

This is a demo repository that presents implementations in [Elixir][] for
generating a [Bitcoin address][] from a [private key][].

The following implementations are currently supplied:

- Pure Elixir, using [`bitcoin-elixir`][] for converting public keys into
  Bitcoin addresses.
- [Python][], using [Export][] to interface with [`pybitcointools`][] libraries.
- [C++][], using [Cure][] to interface with [`libbitcoin`][] libraries.

## Installation

The following instructions will focus on installation for MacOS.

### Dependencies

Use [Homebrew][] to install Bitcoin packages needed for non-Elixir code:

- `libbitcoin`: Various Bitcoin-related helper functions.
- `gcc`: Needed to compile the C++ files into the `priv/` directory
- `python`: Needed to run Python files in the `priv/` directory.
  Install either via brew or via a version control manager like [asdf][].

Install brew packages (includes the C++ libraries):

```sh
brew install bitcoin gcc [python]
```

Install Python packages:

```sh
pip install bitcoin
```

### Repository

```sh
git clone git@github.com:paulfioravanti/bitcoin_address.git
cd bitcoin_address
mix deps.get
```

## Run the Code

Open up an `iex` terminal and confirm that each implementation gives you the
same result:

```elixir
iex -S mix
iex(1)> BitcoinAddress.Elixir.generate()
Private key: "038109007313a5807b2eccc082c8c3fbb988a973cacf1a7df9ce725c31b14776"
Public key: "0202a406624211f2abbdc68da3df929f938c3399dd79fac1b51b0e4ad1d26a47aa"
Address: "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"
"1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"
iex(2)> BitcoinAddress.Python.generate()
Private key: "038109007313a5807b2eccc082c8c3fbb988a973cacf1a7df9ce725c31b14776"
Public key: "0202a406624211f2abbdc68da3df929f938c3399dd79fac1b51b0e4ad1d26a47aa"
Address: "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"
"1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"
iex(3)> BitcoinAddress.CPlusPlus.generate()
Private key: "038109007313a5807b2eccc082c8c3fbb988a973cacf1a7df9ce725c31b14776"
Public key: "0202a406624211f2abbdc68da3df929f938c3399dd79fac1b51b0e4ad1d26a47aa"
Address: "1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"
"1PRTTaJesdNovgne6Ehcdu1fpEdX7913CK"
```

## Tests

Each of the implementations has a sanity test check to just make sure it works,
and continues to work as expected.

### Run the test suite

```sh
mix test
```

[mix test.watch][] is included in this project, and hence all the tests,
as well as [Credo][] and [Dogma][] checks, can be continuously run when file
changes are made:

```sh
mix test.watch
```

## Helpful Resources

### Code

- [Mastering Bitcoin repo][]: Code samples from
  [Mastering Bitcoin 2nd Edition][] that I ported over to Elixir, using similar
  techniques as this repo.

### Blog Posts

- [Controlling a Bitcoin Node in Elixir][]
- [Using Python's Bitcoin libraries in Elixir][]
- [Using C++ Bitcoin libraries in Elixir][]

The latter two are blog posts I wrote documenting the things I needed to do
to get Elixir communicating with Python and C++.

## Social

[![Contact][twitter-badge]][twitter-url]<br />
[![Stack Overflow][stackoverflow-badge]][stackoverflow-url]

[asdf]: https://github.com/asdf-vm/asdf
[Bitcoin address]: https://en.bitcoin.it/wiki/Address
[`bitcoin-elixir`]: https://github.com/comboy/bitcoin-elixir
[C++]: http://www.cplusplus.com/
[Controlling a Bitcoin Node in Elixir]: http://www.east5th.co/blog/2017/09/04/controlling-a-bitcoin-node-with-elixir/
[Credo]: https://github.com/rrrene/credo
[Cure]: https://github.com/luc-tielen/Cure
[Dogma]: https://github.com/lpil/dogma
[Elixir]: https://github.com/elixir-lang/elixir
[Export]: https://github.com/fazibear/export
[Homebrew]: https://github.com/Homebrew/brew
[`libbitcoin`]: https://github.com/libbitcoin/libbitcoin
[Mastering Bitcoin 2nd Edition]: https://www.amazon.com/Mastering-Bitcoin-Programming-Open-Blockchain/dp/1491954388
[Mastering Bitcoin repo]: https://github.com/paulfioravanti/mastering_bitcoin
[mix test.watch]: https://github.com/lpil/mix-test.watch
[private key]: https://en.bitcoin.it/wiki/Private_key
[`pybitcointools`]: https://github.com/vbuterin/pybitcointools
[Python]: https://www.python.org/
[stackoverflow-badge]: http://stackoverflow.com/users/flair/567863.png
[stackoverflow-url]: http://stackoverflow.com/users/567863/paul-fioravanti
[twitter-badge]: https://img.shields.io/badge/contact-%40paulfioravanti-blue.svg
[twitter-url]: https://twitter.com/paulfioravanti
[Using C++ Bitcoin libraries in Elixir]: https://paulfioravanti.com/blog/2017/12/13/using-c-plus-plus-bitcoin-libraries-in-elixir/
[Using Python's Bitcoin libraries in Elixir]: https://paulfioravanti.com/blog/2017/12/04/using-pythons-bitcoin-libraries-in-elixir/
