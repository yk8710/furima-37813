# テーブル設計

## Users テーブル

| Column                 | Type   | Options                 |
| ---------------------- | ------ | ----------------------- |
| nickname               | string | null:false              |
| email                  | string | null:false, unique:true |
| encrypted_password     | string | null:false              |
| first_name             | string | null:false              |
| last_name              | string | null:false              |
| first_name_kana        | string | null:false              |
| last_name_kana         | string | null:false              |
| birthday               | date   | null:false              |

### Association
- has_many :items
- has_many :orders

## Itemsテーブル

| Column                 | Type       | Options                     |
| ---------------------- | ---------- | --------------------------- |
| user_id                | references | null:false, foregn_key:true |
| name                   | string     | null:false                  |
| price                  | integer    | null:false                  |
| explain                | text       | null:false                  |
| item_status_id         | integer    | null:false                  |
| shipping_cost_id       | integer    | null:false                  |
| shipping_date_id       | integer    | null:false                  |
| category_id            | references | null:false                  |
| prefecture_id          | integer    | null:false                  |

### Association
- belongs_to :users
- has_one :order

## Ordersテーブル

| Column                 | Type       | Options                       |
| ---------------------- | ---------- | ----------------------------- |
| user_id                | references | null:false, foreign_key: true | 
| item_id                | references | null:false, foreign_key: ture |

### Association
- belongs_to :users
- belongs_to :item
- has_one :buyers

## Buyers テーブル
| Column                 | Type       | Options                       |
| ---------------------- | ---------- | ----------------------------- |
| orders_id              | references | null:false, foreign_key:ture  |
| postal_code            | string     | null:false                    |
| prefecture_id          | integer    | null:false                    |
| city                   | string     | null:false                    |
| block                  | string     | null:false                    |
| building_name          | string     |                               |
| phone_number           | string     | null:false                    |

### Association
- belongs_to :orders