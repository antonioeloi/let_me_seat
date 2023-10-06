class Seat < ApplicationRecord
  belongs_to :cart, optional: true

  validates :row, :column, :cost, presence: true
  validates :row, :column, numericality: { integer: true }
  validates :cost, numericality: { only_integer: true, greater_than: 0 }

  after_update_commit :broadcast_seat_update

  state_machine :state, initial: :free do
    state :free
    state :selected
    state :reserved


    event :mark_as_free do
      transition %i[selected reserved] => :free
    end

    event :mark_as_selected do
      transition %i[free] => :selected
    end

    event :mark_as_reserved do
      transition %i[selected] => :reserved
    end
  end

  private

  def broadcast_seat_update
    broadcast_replace_to "seats", partial: "seats/seat", locals: { seat: self }
  end
end
