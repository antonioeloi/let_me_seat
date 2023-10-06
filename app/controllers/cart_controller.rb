class CartController < ApplicationController
  def reserve
    ActiveRecord::Base.transaction do
      @cart.seats.each do |seat|
        seat.mark_as_reserved!
      end
    end

    session[:cart_id] = nil

    redirect_to root_path, notice: 'Seats reserved'
  end
end
