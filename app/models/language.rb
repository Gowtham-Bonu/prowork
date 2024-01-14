class Language < ApplicationRecord
  belongs_to :profile

  validates :name, :proficiency, presence: true
  validates :name, uniqueness: { scope: :profile_id, message: 'languages should be unique' }
end