class User < ApplicationRecord
  has_many :rides
  has_many :attractions, through: :rides
  has_secure_password

  def user_name=(name)
    self.name = name
  end
  def user_name
    self.name
  end
  def mood
    self.happiness > self.nausea ? "happy" : "sad"
  end
end
