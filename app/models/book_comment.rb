class BookComment < ApplicationRecord

	belongs_to :user
  belongs_to :book

  validates :comment, length: { minimum: 2 }, presence: true

end
