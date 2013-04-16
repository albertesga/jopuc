# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :avatar
  has_secure_password
  has_many :challenges, dependent: :destroy
  before_save { |user| user.email = email.downcase }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  # This method associates the attribute ":avatar" with a file attachment
  has_attached_file :avatar, styles: {
    thumb: '100x100>',
    square: '200x200#',
    medium: '300x300>'
    },:storage        => :s3, 
    :bucket => ENV['jopuc'],
    :access_key_id => ENV['AKIAJ2WLPDJAI4Q57UTA'],
    :secret_access_key => ENV['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']

    private

    def create_remember_token
      self.remember_token = SecureRandom.urlsafe_base64
    end
  end
