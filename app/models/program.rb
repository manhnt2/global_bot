class Program < ApplicationRecord
  belongs_to :programmable, polymorphic: true

  has_many :program_params

  enum program_type: { share_each_group_member: 0 }

  validates :program_type, presence: true
  validates :unipos_share_number, numericality: { greater_than: 0 }

  validates :programmable_type, uniqueness: { scope: :programmable_id }
end
