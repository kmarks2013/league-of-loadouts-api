class AddPlaintextToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :plaintext, :string
  end
end
