# == Schema Information
#
# Table name: sessions
#
#  id         :bigint           not null, primary key
#  owner      :integer
#  restaurant :string
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Session < ApplicationRecord
  belongs_to :user, foreign_key: "owner"
  has_many  :messages, dependent: :destroy

  validates :title, presence: { message: "Title can't be blank" }
  validates :restaurant, presence: { message: "Restaurant can't be blank" }
  validates :owner, presence: { message: "Owner of session can't be blank" }
end
