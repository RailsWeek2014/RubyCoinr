require 'bitcoin'

class WalletsController < ApplicationController
    # only accessible to signed in users
    before_filter :authenticate_user!

    before_action :set_wallet, only: [:show, :edit, :update, :destroy]

    # GET /wallets
    # GET /wallets.json
    def index
        @wallets = Wallet.all
    end

    # GET /wallets/1
    # GET /wallets/1.json
    def show
    end

    # GET /wallets/new
    def new
        @wallet = Wallet.new user: current_user
    end

    # GET /wallets/1/edit
    def edit
    end

    # POST /wallets
    # POST /wallets.json
    def create
        begin
            @wallet = Wallet.new(wallet_params)
            @wallet.user = current_user
        rescue Exception
            @wallet.errors << 'Label too long'
        end

        respond_to do |format|
            if @wallet.save
                format.html { redirect_to @wallet, notice: 'Wallet was successfully created.' }
                format.json { render :show, status: :created, location: @wallet }
            else
                format.html { render :new }
                format.json { render json: @wallet.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /wallets/1
    # PATCH/PUT /wallets/1.json
    def update
        respond_to do |format|
            if @wallet.update(wallet_params)
                format.html { redirect_to @wallet, notice: 'Wallet was successfully updated.' }
                format.json { render :show, status: :ok, location: @wallet }
            else
                format.html { render :edit }
                format.json { render json: @wallet.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /wallets/1
    # DELETE /wallets/1.json
    def destroy
        @wallet.destroy
        respond_to do |format|
            format.html { redirect_to wallets_url, notice: 'Wallet was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    # export wallet as json
    def export
        set_wallet
        send_data(Btc.wallet_to_json(@wallet), type: 'text/json; charset=utf-8; header=present',
            disposition: 'attachment; filename=wallet.aes.json')
        # `wallet.aes.json` for blockchain compatibility, although the
        # wallet format couldn’t be valid at the moment TODO
    end

    # import wallet from json
    def import
        args = Hash.new
        w = JSON.parse(params[:wallet].read())
        keys = []

        if w['label'] && w['label'].length > 0
            args['label'] = w['label']
        end

        if w['keys'].any? && w['keys'].length > 0
            w['keys'].each do |k|
                key = Hash.new

                # private key
                unless Btc.wif_is_valid?(k['priv'])
                    raise Exception.new('Invalid private key detected.')
                else
                    key['privkey'] = Btc.convert_wif_to_priv_key(k['priv'])
                end

                # gen public key form converted private key
                key['pubkey'] = Bitcoin::Key.new(key['privkey']).pub

                # validate and set address of keypair
                addr = Bitcoin.pubkey_to_address(key['pubkey'])

                unless (k['addr'] == addr) || Bitcoin.valid_address?(k['addr'])
                    raise Exception.new('Invalid address detected: ' + k['addr'])
                else
                    key['address'] = k['addr']
                end

                # set whether keypair was used before or not
                unless k['tag'] == 2
                    key['used'] = false
                else
                    key['used'] = true
                end

                # gen qrcode from address
                key['addr_qrcode_svg'] = RQRCode::QRCode.new('bitcoin:' + key['address'], :size => 10, :level => 'h').to_svg

                keys << key
            end
        else
            @wallet.errors.add(:base, 'Wallet has no key.')
        end

        # create wallet
        @wallet = Wallet.new(args)

        # save old keypairs
        keys.each do |k|
            # all clear, save keypairs
            @wallet.keypairs << Keypair.new(k)
        end

        # quick check for existing wallet with label
        # FIXME: not so generous existence checking
        if Wallet.exists?(['label LIKE ?', "%#{ @wallet.label }%"])
            @wallet.errors.add(:base, 'Wallet with label “%s” already exists' % [@wallet.label])
        end

        unless @wallet.errors.any?
            # relate wallet to current user
            @wallet.user = current_user

            if @wallet.save
                redirect_to @wallet, notice: 'Wallet was successfully imported.'
            end
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_wallet
        @wallet = Wallet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wallet_params
        params.require(:wallet).permit(:label, :password)
    end
end