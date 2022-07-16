class Item < ApplicationRecord
  belongs_to :user

  validates :category_id, numericality: { other_than: 0, message: "Category can't be blank"}
  validates :item_status_id, numericality: { other_than: 0, message: "Item status can't be blank" }
  validates :prefecture_id, numericality: { other_than: 0, message: "Prefecture can't be blank"}
  validates :shipping_cost_id, numericality: { other_than: 0, message: "Shipping cost can't be blank" }
  validates :shipping_date_id, numericality: { other_than: 0, message: "Shipping date can't be blank"}
end
