class Keypair < ActiveRecord::Base
    belongs_to :wallet

    validates :privkey, presence: true
    validates :pubkey, presence: true

    after_create :set_defaults

    # set defaults
    def set_defaults
        self.used ||= false
    end

end
