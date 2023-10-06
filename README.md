Real-Time Theater Seat Booking System

## Description
This project is a technical challenge for a job position. The task is to develop a prototype of a real-time, high-performance theater seat booking system, completely implemented in the Ruby on Rails framework.

Each user/browser (no authentication or user account required) views a map of the theater with 25 x 20 seats (represented as a matrix of small circles). The seats are color-coded: green (available), red (reserved), light red (selected by another user), or gray (selected by the current user). There is also a button to reserve (add to cart) the selected seats.

As soon as a user selects a seat, it should appear as light red to all other users. When a user reserves their selected seats, these seats should appear as red. This should happen in real-time, without the need to reload the page, and with minimal latency.

Associated with the seat map, on the same page, is a "cart" displaying the selected seats. Each seat has an associated price and is added/removed from the cart without needing to refresh the page. The cart is always updated with the selected seats and displays the total amount payable. For this part, we suggest developing a Stimulus controller.

## How to Run the Project
1. Clone the repository using `git clone <repository-url>`.
2. Navigate into the project directory.
3. Run the setup script with `./bin/setup`. This script will:
    - Install the necessary dependencies.
    - Prepare the database and run seeds.
    - Clear old logs and temp files.
4. Ensure that Redis is running on the default port.
5. Start your server using `. bin/dev`.

## Technical Remarks
- Selected seats by other users appear light red but are still clickable. Clicking affects the cart list but doesn't update the seat because it's selected by another user. An improvement could be to disable clicking for those seats but it's not relevant to this challenge.
- A Stimulus controller is used to update the total cost display.
- When a seat is updated (either selected or reserved), `broadcast_replace_to "seats", partial: "seats/seat", locals: { seat: self }` is used to update all client views by replacing the seat. This ensures that both selection and reservation actions update all clients' views in real-time.
- When selecting a seat, `turbo_stream.append('selected_seats', partial: 'seats/cart_item', locals: { seat: @seat })` is used to add the new seat to the cart list.
- When deselecting a seat, `turbo_stream.remove(helpers.dom_id(@seat, :cart_item))` is used to remove the seat from the cart list.
- The reserve button is updated using `turbo_stream.replace("reserve_btn", partial: 'seats/reserve_btn', locals: { count: @cart.seats.count })`. This button is disabled when the cart is empty (this is an improvement and was not required by the challenge).
