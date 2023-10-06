Rails.application.config.after_initialize do
  if ActiveRecord::Base.connection.table_exists?('seats') && ActiveRecord::Base.connection.table_exists?('carts')
    Seat.update_all(cart_id: nil, state: "free")
    Cart.destroy_all
  else
    Rails.logger.warn("Tables 'seats' and/or 'carts' do not exist. Skipping initialization.")
  end
end
