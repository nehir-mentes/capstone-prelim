# == Schema Information
#
# Table name: restaurants
#
#  id              :bigint           not null, primary key
#  restaurant_name :string
#  wine_menu       :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Restaurant < ApplicationRecord
  has_many  :sessions, dependent: :destroy
end
