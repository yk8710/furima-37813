# テーブル設計

## Users テーブル

| Column                 | Type   | Options                 |
| ---------------------- | ------ | ----------------------- |
| nickname               | string | null:false, unique:true |
| email                  | string | null:false              |
| password               | string | null:false              |
| first_name             | string | null:false              |
| last_name              | string | null:false              |
| first_name_kana        | string | null:false              |
| last_name_kana         | string | null:false              |

### Association
- has_many :Addresses
- has_many :Items
- has_one :Credit-cards

## Addresses テーブル

| Column                 | Type       | Options                       |
| ---------------------- | ---------- | ----------------------------- |
| user                   | references | null:false, foreign_key: true |
| postal_code            | string     | null:false                    |
| prefecture             | integer    | null:false                    |
| city                   | string     | null:false                    |
| house_number           | string     | null:false                    |
| building_name          | string     |                               |
| phone_number           | string     |                               |

### Association
- belongs_to :Users

## Itemsテーブル

| Column                 | Type       | Options                 |
| ---------------------- | ---------- | ----------------------- |
| user                   | references | foregn_key:true         |
| name                   | string     | null:false, index:true  |
| price                  | integer    | null:false              |
| explain                | text       | null:false              |
| status                 | integer    | null:false, default:0   |
| charge_bearer          | integer    | null:false, default:0   |
| shipping_area          | integer    | null:false              |
| delivary_days          | integer    | null:false              |
| category               | references | null:false              |
| postage                | string     | null:false              |

### Association
- belongs_to :Users
- belongs_to :Categories
- belonges_to :Images

## Categoriesテーブル

| Column                 | Type       | Options                 |
| ---------------------- | ---------- | ----------------------- |
| name                   | integer    | null:false              |

### Association
- has_many :Items

## Imagesテーブル

| Column                 | Type       | Options                      |
| ---------------------- | ---------- | ---------------------------- |
| item                   | references | null:false, foreign_key:true |
| item_image             | text       | null:false                   |

### Association
- has_many :Items

## Credit_cardsテーブル

| Column                 | Type       | Options                      |
| ---------------------- | ---------- | ---------------------------- |
| user                   | references | null:false, foreign_key:ture |
| card_campany           | string     | null:false                   |
| card_number            | string     | null:false                   |
| card_year              | integer    | null:false                   |
| card_month             | integer    | null:false                   |
| card_pass              | integer    | null:false                   |

### Association
-has_one :Users



