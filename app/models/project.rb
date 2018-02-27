class Project < ApplicationRecord
  enum project_type: { unipos: 0 }

  has_many :groups

  validates :project_type, presence: true
  validates :project_type, uniqueness: true
end
