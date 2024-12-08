class Order < ApplicationRecord
  belongs_to :customer, class_name: "User", foreign_key: :customer_id
  belongs_to :performer, class_name: "User", foreign_key: :performer_id, optional: true
  has_one_attached :file
  has_one_attached :completed_file
  #after_update :send_customer_notification
  # enum status: [:active, :in_progress, :done, :canceled]

  include AASM

  aasm column: 'status' do
    
    state :active, initial: true
    state :in_progress
    state :completed
    state :canceled

    
    event :start do
      transitions from: :active, to: :in_progress
    end

    event :complete do
      transitions from: :in_progress, to: :completed
    end

    event :cancel do
      transitions from: [:pending, :in_progress], to: :canceled
    end
  end

  private

  # def send_customer_notification
  #   NotificationMailer.order_status(self.id).deliver_later if save_changed_to_status?
  # end

end
