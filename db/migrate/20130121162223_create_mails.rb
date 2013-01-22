class CreateMails < ActiveRecord::Migration
  def change
    create_table :mails do |t|
      t.string :subject
      t.text :msgbody
      t.boolean :read
      t.integer :sender_id
      t.integer :receiver_id

      t.timestamps
    end
  end
end
