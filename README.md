# DB設計

## users table
  deviseを用いて作成

| Column | Type |          Option          |
|:------:|:------:|:-------------------------|
| name | string | null: false, unique: true |

### Association
* has_many :group_users
* has_many :groups, through: group_users
* has_many :massages


## groups table
| Column |  Type  |          Option          |
|:------:|:------:|:-------------------------|
| name | string | null: false, unique: true |

### Association
* has_many :group_users
* has_many :users, through: :group_users
* has_many :messages


## group_users table
| Column |  Type  |          Option          |
|:------:|:------:|:-------------------------|
| user_id | integer| foreign_key: true |
| group_id | integer | foreign_key: true |

### Association
* belongs_to :user
* belongs_to :group


## messages table
| Column |  Type  |          Option          |
|:------:|:------:|:-------------------------|
| body | text | null: false |
| image | text ||
| timestamps |  | null: false |
| user_id | integer| foreign_key: true |
| group_id | integer| foreign_key: true |

### Association
* belongs_to :user
* belongs_to :group
