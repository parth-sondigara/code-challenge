class Order < ApplicationRecord
  belongs_to :user
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  after_create_commit :send_order_confirmation

  private

  def send_order_confirmation
    NotificationMailer.order_confirmation(self).deliver_later
  end
end
