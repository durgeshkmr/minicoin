Shared Libraries
================

## minicoinconsensus

The purpose of this library is to make the verification functionality that is critical to Minicoin's consensus available to other applications, e.g. to language bindings.

### API

The interface is defined in the C header `minicoinconsensus.h` located in  `src/script/minicoinconsensus.h`.

#### Version

`minicoinconsensus_version` returns an `unsigned int` with the API version *(currently at an experimental `0`)*.

#### Script Validation

`minicoinconsensus_verify_script` returns an `int` with the status of the verification. It will be `1` if the input script correctly spends the previous output `scriptPubKey`.

##### Parameters
- `const unsigned char *scriptPubKey` - The previous output script that encumbers spending.
- `unsigned int scriptPubKeyLen` - The number of bytes for the `scriptPubKey`.
- `const unsigned char *txTo` - The transaction with the input that is spending the previous output.
- `unsigned int txToLen` - The number of bytes for the `txTo`.
- `unsigned int nIn` - The index of the input in `txTo` that spends the `scriptPubKey`.
- `unsigned int flags` - The script validation flags *(see below)*.
- `minicoinconsensus_error* err` - Will have the error/success code for the operation *(see below)*.

##### Script Flags
- `minicoinconsensus_SCRIPT_FLAGS_VERIFY_NONE`
- `minicoinconsensus_SCRIPT_FLAGS_VERIFY_P2SH` - Evaluate P2SH ([BIP16](https://github.com/minicoin/bips/blob/master/bip-0016.mediawiki)) subscripts
- `minicoinconsensus_SCRIPT_FLAGS_VERIFY_DERSIG` - Enforce strict DER ([BIP66](https://github.com/minicoin/bips/blob/master/bip-0066.mediawiki)) compliance
- `minicoinconsensus_SCRIPT_FLAGS_VERIFY_NULLDUMMY` - Enforce NULLDUMMY ([BIP147](https://github.com/minicoin/bips/blob/master/bip-0147.mediawiki))
- `minicoinconsensus_SCRIPT_FLAGS_VERIFY_CHECKLOCKTIMEVERIFY` - Enable CHECKLOCKTIMEVERIFY ([BIP65](https://github.com/minicoin/bips/blob/master/bip-0065.mediawiki))
- `minicoinconsensus_SCRIPT_FLAGS_VERIFY_CHECKSEQUENCEVERIFY` - Enable CHECKSEQUENCEVERIFY ([BIP112](https://github.com/minicoin/bips/blob/master/bip-0112.mediawiki))
- `minicoinconsensus_SCRIPT_FLAGS_VERIFY_WITNESS` - Enable WITNESS ([BIP141](https://github.com/minicoin/bips/blob/master/bip-0141.mediawiki))

##### Errors
- `minicoinconsensus_ERR_OK` - No errors with input parameters *(see the return value of `minicoinconsensus_verify_script` for the verification status)*
- `minicoinconsensus_ERR_TX_INDEX` - An invalid index for `txTo`
- `minicoinconsensus_ERR_TX_SIZE_MISMATCH` - `txToLen` did not match with the size of `txTo`
- `minicoinconsensus_ERR_DESERIALIZE` - An error deserializing `txTo`
- `minicoinconsensus_ERR_AMOUNT_REQUIRED` - Input amount is required if WITNESS is used

### Example Implementations
- [NMinicoin](https://github.com/NicolasDorier/NMinicoin/blob/master/NMinicoin/Script.cs#L814) (.NET Bindings)
- [node-libminicoinconsensus](https://github.com/bitpay/node-libminicoinconsensus) (Node.js Bindings)
- [java-libminicoinconsensus](https://github.com/dexX7/java-libminicoinconsensus) (Java Bindings)
- [minicoinconsensus-php](https://github.com/Bit-Wasp/minicoinconsensus-php) (PHP Bindings)
