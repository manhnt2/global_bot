class Group < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  belongs_to :project

  has_many :user_groups
  has_many :programs, as: :programmable

  accepts_nested_attributes_for :user_groups

  validates :name, presence: true
end
