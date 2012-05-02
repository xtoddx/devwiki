class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :body_markup
      t.text :body_html
      t.timestamps
    end
  end
end
