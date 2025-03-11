class User < ApplicationRecord
  has_many :orders, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  after_create_commit :send_welcome_email

  private

  def send_welcome_email
    NotificationMailer.welcome_email(self).deliver_later
  end
end
