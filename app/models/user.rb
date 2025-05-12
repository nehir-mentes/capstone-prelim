# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string
#  password   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  has_many  :sessions, foreign_key: "owner", dependent: :destroy
  validates :password, presence: { message: "Password can't be blank" }
  validates :email, presence: { message: "Email can't be blank" }
end
