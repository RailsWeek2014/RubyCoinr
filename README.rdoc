== RubyCoinr

This project provides a local multiuser wallet managing webapp.

=== Using
This project needs at least Ruby version 2.1.2. After downloading and unpacking RubyCoinr, execute the following commands:

	bundle
	rake bower:install

`bundle` installs all needed gems and `bower` manages the frontend assets like `angular` or `bootstrap`.

== Project specification (in german)
(for details see [Roadmap.md](Roadmap.md))
=== Pflichtenheft
- startseite mit metadaten
- multiuser mit externem login
- mehrere wallets (exportieren, importieren, neu anlegen)
- transaktionen (status, veranlassen, historie angucken)
- kontostand

=== Optional
- kontakte (eingegangene/ausgegangene transaktionen benennen, nicht schon vorher)
- statt html auch json (ajax per angular)
- multilang
- passwort vergessen wie https://blockchain.info (mnemonic satz für das pw)
- latest transactions
- gegenwert verschiedener marketplaces in verschiedenen currencies
- mail notifications
