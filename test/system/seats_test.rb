require "application_system_test_case"

class SeatsTest < ApplicationSystemTestCase
  setup do
    @seat = seats(:one)
  end

  test "visiting the index" do
    visit seats_url
    assert_selector "h1", text: "Seats"
  end

  test "should create seat" do
    visit seats_url
    click_on "New seat"

    fill_in "Cart", with: @seat.cart_id
    fill_in "Column", with: @seat.column
    fill_in "Cost", with: @seat.cost
    fill_in "Row", with: @seat.row
    fill_in "State", with: @seat.state
    click_on "Create Seat"

    assert_text "Seat was successfully created"
    click_on "Back"
  end

  test "should update Seat" do
    visit seat_url(@seat)
    click_on "Edit this seat", match: :first

    fill_in "Cart", with: @seat.cart_id
    fill_in "Column", with: @seat.column
    fill_in "Cost", with: @seat.cost
    fill_in "Row", with: @seat.row
    fill_in "State", with: @seat.state
    click_on "Update Seat"

    assert_text "Seat was successfully updated"
    click_on "Back"
  end

  test "should destroy Seat" do
    visit seat_url(@seat)
    click_on "Destroy this seat", match: :first

    assert_text "Seat was successfully destroyed"
  end
end
