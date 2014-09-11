# RubyCoinr
This project provides a local multiuser wallet managing webapp.

### Using
This project needs at least Ruby version 2.1.2. After downloading and unpacking RubyCoinr, execute `bundle` to install the dependencies. 

You need to register RubyCoinr as a twitter app to get api key and secret. Once you did, paste them in `config/secrets.yml`. **Note:** The app must be allowed to be used to *sign in with twitter* and the callback url should be set to `http://127.0.0.1:3000/auth/twitter/callback` if you’re in development mode. (I advise against running this project in production mode anyway.)  Call `rake secret` and paste the string as `secret_key_base`.

Run RubyCoinr with `rails server`.

## Project specification (in german)
(for details see [Roadmap.md](Roadmap.md))

### Pflichtenheft
- startseite mit metadaten
- multiuser mit externem login
- mehrere wallets (exportieren, importieren, neu anlegen)
- transaktionen (status, veranlassen, historie angucken)
- kontostand (geht nicht aufgrund von fehlern mit storage von `bitcoin-ruby`)

### Optional
- kontakte (eingegangene/ausgegangene transaktionen benennen, nicht schon vorher)
- statt html auch json (ajax per angular)
- multilang
- passwort vergessen wie [Blockchain](https://blockchain.info) (mnemonic satz für das pw)
- latest transactions
- gegenwert verschiedener marketplaces in verschiedenen currencies
- mail notifications
