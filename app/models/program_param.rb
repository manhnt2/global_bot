class ProgramParam < ApplicationRecord
  belongs_to :program_parammable, polymorphic: true
  belongs_to :program

  enum status: { ok: 0, error: 1 }

  validates :unipos_request, format: { with: /\Acurl\s'https\:\/\/unipos\.me\/[cq]\/jsonrpc.+--data-binary.+"from_member_id":"[0-9a-z\-]+".+--compressed\z/ }
  validates :program_parammable, presence: true
  validate :check_unipos_request

  before_validation :extract_data

  private

  def check_unipos_request
    if unipos_request_changed?
      if /\Acurl\s'https\:\/\/unipos\.me\/[cq]\/jsonrpc.+--data-binary.+"from_member_id":"[0-9a-z\-]+".+--compressed\z/ !~ unipos_request
        errors[:unipos_request] << 'invalid'
        throw :abort
      end

      response = JSON.parse(`#{unipos_request}`) rescue { error: 'unkown_error' }
      if response[:error]
        errors[:unipos_request] << 'invalid'
        throw :abort
      else
        self.status = :ok
      end
    end
  end

  def extract_data
    if unipos_request_changed?
      self.unipos_request = unipos_request.gsub('unipos.me/q/', 'unipos.me/c/')
      self.unipos_user_id = $1 if unipos_request =~ /"from_member_id":"([0-9a-z\-]+)"/
    end
  end
end
