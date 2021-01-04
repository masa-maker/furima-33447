# README

# テーブル設計

## users テーブル

| Column                    | Type    | Options                   |
|---------------------------|---------|---------------------------|
| nick_name                 | string  | null: false               |
| email                     | string  | null: false               |
| encrypted_password        | string  | null: false               |
| last_name                 | string  | null: false               |
| first_name                | string  | null: false               |
| last_name_kana            | string  | null: false               |
| first_name_kana           | string  | null: false               |
| birth                     | date    | null: false               |
### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column          | Type       | Option                         |
|-----------------|------------|--------------------------------|
| item_name       | string     | null: false                    |
| info            | text       | null: false                    |
| price           | integer    | null: false                    |
| user            | references | null: false, foreign_key: true |
| category        | integer    | null: false                    |
| item_status     | integer    | null: false                    |
| shipping_charge | integer    | null: false                    |
| prefecture      | integer    | null: false                    |
| shipping_date   | integer    | null: false                    |
### Association

- belongs_to :user
- has_one    :purchase

##  purchasesテーブル

| Column             | Type       | Options                        |
| -------------------| ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |
 
### Association

- belongs_to    :user
- has_one       :address
- belongs_to    :item

## address テーブル

| Column        | Type       | Options                        |
| --------------| ---------- | ------------------------------ |
| portal_code   | string     | null: false                    |
| prefecture    | string     | null: false                    |
| city          | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     |                                |
| phone_number  | string     | null: false                    |
| purchase      | references | null: false, foreign_key: true |

### Association

- has_one :purchase
