class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.text :body
      t.belongs_to :user, index: true
      t.belongs_to :post, index: true

      t.timestamps
    end
  end
end
 