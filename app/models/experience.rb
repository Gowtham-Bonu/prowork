class Experience < ApplicationRecord
  belongs_to :profile

  validates :company, :title, :country, :end_date, presence: true
  validates :start_date, comparison: {less_than: :end_date}
end