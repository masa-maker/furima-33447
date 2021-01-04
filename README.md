# README

# テーブル設計

## users テーブル

| Column        | Type   | Options                   |
|---------------|--------|---------------------------|
| NickName      | string | null: false, unique: true |
| Email         | string | null: false               |
| Password      | string | null: false               |
| LastName      | string | null: false               |
| FirstName     | string | null: false               |
| LastNameKana  | string | null: false               |
| FirstNameKana | string | null: false               |
### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column      | Type       | Option                         |
|-------------|------------|--------------------------------|
| ItemName    | string     | null: false                    |
| Info        | text       | null: false                    |
| Price       | integer    | null: false                    |
| User        | references | null: false, foreign_key: true |
### Association

- belongs_to :user
- belongs_to :purchase

##  purchasesテーブル

| Column             | Type       | Options                        |
| -------------------| ---------- | ------------------------------ |
| User               | references | null: false, foreign_key: true |
| Item               | references | null: false, foreign_key: true |
 
### Association

- belongs_to :user
- belongs_to :address
- has_one    :item

## address テーブル

| Column       | Type       | Options                        |
| -------------| ---------- | ------------------------------ |
| PortalCode   | integer    | null: false                    |
| City         | string     | null: false                    |
| Address      | string     | null: false                    |
| BuildingName | string     |                                |
| PhoneNumber  | integer    | null: false                    |
| Purchase     | references | null: false, foreign_key: true |

### Association

- has_one :purchase
