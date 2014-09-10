require 'bitcoin'
require 'json'

class Btc

    # == BITCOIN WALLET IMPORT FORMAT ==

    # convert private key to wallet import format for export
    public
    def self.convert_priv_key_to_wif privkey
        extended = '80' + privkey
        checksum = Bitcoin.sha256(Bitcoin.sha256(extended)).bytes[0..7].pack('c*').upcase
        Bitcoin.encode_base58(extended + checksum)
    end

    # convert wif back to standard private key format
    def self.convert_wif_to_priv_key wif
        # validate wif
        raise Exception.new 'Invalid WIF' unless wif_is_valid? wif

        # decode wif
        base = Bitcoin.decode_base58(wif)

        # drop checksum
        shortened = base.bytes[0..(base.length-9)].pack('c*').upcase

        # cut off 0x80 and return
        shortened.bytes[2..shortened.length].pack('c*').upcase
    end

    # check wallet import formatted private key whether it’s valid or not
    def self.wif_is_valid? wif = nil
        return false unless wif

        base = Bitcoin.decode_base58 wif
        # this gets compared with the checksum
        wif_rest = base.bytes[(base.length - 8)..base.length].pack('c*').upcase

        # calculate checksum
        shortened = base.bytes[0..(base.length-9)].pack('c*').upcase
        checksum = Bitcoin.sha256(Bitcoin.sha256(shortened)).bytes[0..7].pack('c*').upcase

        if checksum == wif_rest
            true
        else
            false
        end
    end

    # export/import of wallet
    # format: https://blockchain.info/wallet/wallet-format

    # convert wallet to 
    def self.wallet_to_json wallet
        json = Hash.new

        # set wallet label if exists
        if wallet.label && wallet.label.length > 0
            json['label'] = wallet.label
        end

        # convert keys
        if wallet.keypairs.any?
            json['keys'] = []

            wallet.keypairs.each do |keypair|
                key = Hash.new

                # 
                if keypair.used
                    key['tag']  = 2
                end

                key['addr'] = keypair.address
                key['priv'] = convert_priv_key_to_wif keypair.privkey

                json['keys'] << key
            end
        end

        JSON.pretty_generate(json)
    end

end