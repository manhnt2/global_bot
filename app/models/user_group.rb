class UserGroup < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_many :program_params, as: :program_parammable

  enum role: { member: 0, admin: 1 }

  validates :role, presence: true
  validates :user_id, uniqueness: { scope: :group_id }
end
