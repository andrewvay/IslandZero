class User < ActiveRecord::Base
  # :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :async

  before_save do
    self.is_admin = true if User.count == 0
    self.nickname = self.email.split('@').first if self.nickname.nil?
  end

  has_many :posts, inverse_of: :user
  has_many :messages, inverse_of: :user
end
