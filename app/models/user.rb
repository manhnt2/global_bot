class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :user_groups
  has_many :programs, as: :programmable
  has_many :program_params, as: :program_parammable

  # validates :name, presence: true
end
