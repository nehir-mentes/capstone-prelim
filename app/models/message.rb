# == Schema Information
#
# Table name: messages
#
#  id         :bigint           not null, primary key
#  content    :string
#  role       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  session_id :integer
#
class Message < ApplicationRecord
  belongs_to :session
  validates :session_id, presence: { message: "Session_ID cannot be blank" }
  validates :role, presence: { message: "Role cannot be blank" }
  validates :content, presence: { message: "Input cannot be blank" }
end
