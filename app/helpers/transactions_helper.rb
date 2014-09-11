module TransactionsHelper

    def clustered_txs_by_wallet
        Transaction.all.to_a.cluster :wallet_id
    end

    def clustered_txs_by_status
        Transaction.all.to_a.cluster :confirmed
    end

    def wallet_label_for_id id
        Wallet.find(id).label
    end

    def wallet_addr_for_id id
        Wallet.find(id).curr_key.address
    end

end
