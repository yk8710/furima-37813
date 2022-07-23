class OrderBuyer
  include ActiveModel::Model
  attr_accessor :postal_code, :prefecture, :city, :block, :building_name, :phone_number, :user_id, :item_id

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Enter it as follows (e.g. 123-4567)"}
    validates :city
    validates :block
    validates :phone_number, format: {with: /\A\d{11}\z/, message: "invalid. Input only number"}
    validates :prefecture, numericality: {other_than: 0, message: "can't be blank"}
    validates :user_id
    validates :item_id
  end

  def save
    order = Order.create(user_id: user_id, item_id: item_id)
    Buyer.create(postal_code: postal_code, prefecture: prefecture, city: city, block: block, building_name: building_name, phone_number: phone_number)
  end
end