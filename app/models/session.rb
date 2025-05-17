# == Schema Information
#
# Table name: sessions
#
#  id            :bigint           not null, primary key
#  owner         :integer
#  title         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :bigint
#
# Indexes
#
#  index_sessions_on_restaurant_id  (restaurant_id)
#
# Foreign Keys
#
#  fk_rails_...  (restaurant_id => restaurants.id)
#
class Session < ApplicationRecord
  belongs_to :user, foreign_key: "owner"
  has_many  :messages, dependent: :destroy
  belongs_to :restaurant

  validates :title, presence: { message: "Title can't be blank" }
  validates :restaurant_id, presence: { message: "Restaurant can't be blank" }
  validates :owner, presence: { message: "Owner of session can't be blank" }
end
