USE food_delivery;

-- USERS
INSERT INTO users (name, email, phone, address) VALUES
('Alice Smith', 'alice@example.com', '1234567890', '123 Main St'),
('Bob Johnson', 'bob@example.com', '0987654321', '456 Elm St'),
('Charlie Ray', 'charlie@example.com', '1122334455', '789 Pine St');

-- RESTAURANTS
INSERT INTO restaurants (name, address, phone, rating, is_active) VALUES
('Pizza Palace', '789 Maple Ave', '1112223333', 4.5, TRUE),
('Sushi Spot', '321 Oak Blvd', '4445556666', 4.0, TRUE);

-- MENU ITEMS
INSERT INTO menu_items (restaurant_id, name, description, price, is_available) VALUES
(1, 'Pepperoni Pizza', 'Spicy and cheesy', 12.99, TRUE),
(1, 'Veggie Pizza', 'Loaded with veggies', 10.99, TRUE),
(2, 'California Roll', 'Crab, avocado, cucumber', 8.99, TRUE),
(2, 'Tuna Sashimi', 'Fresh raw tuna', 11.49, TRUE);

-- DELIVERY AGENTS
INSERT INTO delivery_agents (name, phone, status) VALUES
('David Rider', '9990001111', 'available'),
('Ella Courier', '8887776666', 'available');

-- ORDERS
INSERT INTO orders (user_id, restaurant_id, total_amount, status) VALUES
(1, 1, 23.98, 'placed'),
(2, 2, 20.48, 'accepted'),
(3, 1, 12.99, 'delivered');

-- ORDER ITEMS
INSERT INTO order_items (order_id, item_id, quantity) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 1),
(2, 4, 1),
(3, 1, 1);

-- ORDER ASSIGNMENTS
INSERT INTO order_assignments (order_id, agent_id) VALUES
(1, 1),
(2, 2),
(3, 1);

-- AGENT LOCATIONS
INSERT INTO agent_locations (agent_id, latitude, longitude) VALUES
(1, 37.7749, -122.4194),
(2, 34.0522, -118.2437);

-- REVIEWS
INSERT INTO reviews (user_id, restaurant_id, agent_id, rating, review_text, review_type) VALUES
(1, 1, NULL, 5, 'Great pizza and service!', 'restaurant'),
(2, NULL, 2, 4, 'Agent was fast and friendly.', 'agent');

-- PROMO CODES
INSERT INTO promo_codes (code, discount_percent, min_order_amount, expiry_date, is_active) VALUES
('SAVE10', 10.00, 15.00, '2025-12-31', TRUE),
('WELCOME5', 5.00, 10.00, '2025-12-31', TRUE);

-- ORDER PROMOS
INSERT INTO order_promos (order_id, promo_id, applied_at) VALUES
(1, 1, NOW());

-- PAYMENTS
INSERT INTO payments (order_id, method, status, amount, paid_at) VALUES
(1, 'card', 'completed', 21.58, NOW()),
(2, 'wallet', 'pending', 18.43, NOW());

-- RESTAURANT HOURS
INSERT INTO restaurant_hours (restaurant_id, day_of_week, open_time, close_time) VALUES
(1, 'Mon', '10:00:00', '22:00:00'),
(1, 'Tue', '10:00:00', '22:00:00'),
(2, 'Mon', '11:00:00', '21:00:00');

-- SCHEDULED ORDERS
INSERT INTO scheduled_orders (user_id, restaurant_id, delivery_time, status) VALUES
(1, 2, '2025-06-30 13:00:00', 'scheduled'),
(2, 1, '2025-07-01 18:30:00', 'cancelled');
