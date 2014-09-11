class TransactionsController < ApplicationController
    include TransactionsHelper

    # only accessible to signed in users
    before_filter :authenticate_user!

    before_action :set_transaction, only: [:show, :edit, :update, :destroy]

    # GET /transactions
    # GET /transactions.json
    def index
        @transactions = Transaction.all
    end

    # GET /transactions/1
    # GET /transactions/1.json
    def show
    end

    # GET /transactions/new
    def new
        @transaction = Transaction.new
    end

    # GET /transactions/1/edit
    def edit
        redirect_to transactions_path, notice: 'Transactions are immutable!'
    end

    # POST /transactions
    # POST /transactions.json
    def create
        # not sent by form
        sender_addr = { :sender_addr => wallet_addr_for_id(transaction_params[:wallet_id]) }
        @transaction = Transaction.new(transaction_params.merge(sender_addr))

        respond_to do |format|
            if @transaction.save
                format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
                format.json { render :show, status: :created, location: @transaction }
            else
                format.html { render :new }
                format.json { render json: @transaction.errors, status: :unprocessable_entity }
            end
        end
    end

    # PATCH/PUT /transactions/1
    # PATCH/PUT /transactions/1.json
    def update
        redirect_to transactions_path, notice: 'Transactions are immutable!'
    end

    # DELETE /transactions/1
    # DELETE /transactions/1.json
    def destroy
        @transaction.destroy
        respond_to do |format|
            format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
            format.json { head :no_content }
        end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
        @transaction = Transaction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transaction_params
        params.require(:transaction).permit(:wallet_id, :receiver_addr, :amount, :fee, :label)
    end
    
end
