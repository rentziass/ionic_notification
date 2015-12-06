class AddDeviceTokensTo<%= table_name.camelize %> < ActiveRecord::Migration
  def self.up
    add_column :<%= table_name %>, :device_tokens, :text
  end

  def down
    remove_column :<%= table_name %>, :device_tokens
  end
end
