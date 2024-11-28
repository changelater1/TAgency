class Order < ApplicationRecord
  belongs_to :customer, class_name: "User", foreign_key: :customer_id
  belongs_to :performer, class_name: "User", foreign_key: :performer_id, optional: true
  has_one_attached :file
  enum status: [:active, :in_progress, :done, :canceled]
end
