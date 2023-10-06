class SeatsController < ApplicationController
  before_action :set_seat, only: %i[ show edit update destroy ]

  def index
    @seats = Seat.all
  end

  def show
  end

  def new
    @seat = Seat.new
  end

  def edit
  end

  def create
    @seat = Seat.new(seat_params)

    respond_to do |format|
      if @seat.save
        render :show, status: :created, location: @seat
      else
        render :new, status: :unprocessable_entity
      end
    end
  end

  def update
    turbo_stream_actions = []
    return head :ok if @seat.reserved?

    if @seat.free?
      @seat.mark_as_selected!
      @seat.cart = @cart
      turbo_stream_actions << turbo_stream.append('selected_seats', partial: 'seats/cart_item', locals: { seat: @seat })
    elsif @seat.selected? && @seat.cart == @cart
      @seat.mark_as_free!
      @seat.cart = nil
      turbo_stream_actions << turbo_stream.remove(helpers.dom_id(@seat, :cart_item))
    end

    @seat.save

    turbo_stream_actions << turbo_stream.replace("reserve_btn", partial: 'seats/reserve_btn', locals: { count: @cart.seats.count })

    render turbo_stream: turbo_stream_actions.join("\n"), status: :ok
  end

  def destroy
    @seat.destroy

    redirect_to seats_url, notice: "Seat was successfully destroyed."
  end

  private
    def set_seat
      @seat = Seat.find(params[:id])
    end

    def seat_params
      params.require(:seat).permit(:row, :column, :state, :cost, :cart_id)
    end
end
