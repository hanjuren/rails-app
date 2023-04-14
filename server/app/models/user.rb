class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def after_sign_in(current_ip)
    update!(
      current_sign_in_at: DateTime.now,
      current_sign_in_ip: current_ip,
      last_sign_in_at: self.current_sign_in_at.present? ? self.current_sign_in_at : nil,
      last_sign_in_ip: self.current_sign_in_ip.present? ? self.current_sign_in_ip : nil,
    )
  end
end
