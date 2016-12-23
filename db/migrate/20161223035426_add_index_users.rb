class AddIndexUsers < ActiveRecord::Migration[5.0]
  def change

  	add_index(:users, :age, name: 'index_users_on_age', using: 'btree')
  	add_index(:users, :gender, name: 'index_users_on_gender', using: 'btree')
  end
end
