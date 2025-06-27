--  View all users
SELECT * FROM users;

--  View all restaurants (active only)
SELECT * FROM restaurants WHERE is_active = TRUE;

--  View menu items for a restaurant
SELECT * FROM menu_items WHERE restaurant_id = 1;

--  Place a new order
INSERT INTO orders (user_id, restaurant_id, total_amount)
VALUES (1, 1, 23.98);

-- Insert items for the last order (assume item_id = 1, 2)
SET @last_order_id = LAST_INSERT_ID();
INSERT INTO order_items (order_id, item_id, quantity) VALUES
(@last_order_id, 1, 1),
(@last_order_id, 2, 1);

--  Update order status
UPDATE orders SET status = 'prepared' WHERE order_id = 1;

--  Assign delivery agent to an order
INSERT INTO order_assignments (order_id, agent_id)
VALUES (1, 1);

--  Update agent status
UPDATE delivery_agents SET status = 'on_delivery' WHERE agent_id = 1;

--  Update agent location
INSERT INTO agent_locations (agent_id, latitude, longitude)
VALUES (1, 37.7749, -122.4194);

--  Track live order with agent location
SELECT o.order_id, o.status, da.name AS agent_name, al.latitude, al.longitude
FROM orders o
JOIN order_assignments oa ON o.order_id = oa.order_id
JOIN delivery_agents da ON oa.agent_id = da.agent_id
JOIN agent_locations al ON da.agent_id = al.agent_id
WHERE o.order_id = 1
ORDER BY al.updated_at DESC
LIMIT 1;

-- Get reviews for a restaurant
SELECT rating, review_text
FROM reviews
WHERE restaurant_id = 1 AND review_type = 'restaurant';

-- Get reviews for a delivery agent
SELECT rating, review_text
FROM reviews
WHERE agent_id = 1 AND review_type = 'agent';

-- List active promo codes
SELECT * FROM promo_codes
WHERE is_active = TRUE AND expiry_date >= CURDATE();

-- Apply a promo code to an order
INSERT INTO order_promos (order_id, promo_id)
VALUES (1, 1);

--  Add a payment record
INSERT INTO payments (order_id, method, status, amount)
VALUES (1, 'card', 'completed', 21.58);

--  Check restaurant operating hours
SELECT * FROM restaurant_hours
WHERE restaurant_id = 1 AND day_of_week = 'Mon';

-- List all scheduled orders
SELECT * FROM scheduled_orders
WHERE delivery_time >= NOW()
ORDER BY delivery_time;

-- Top 3 restaurants by order volume
SELECT r.name, COUNT(*) AS order_count
FROM orders o
JOIN restaurants r ON o.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_id
ORDER BY order_count DESC
LIMIT 3;

-- Most popular menu items
SELECT mi.name, COUNT(*) AS total_ordered
FROM order_items oi
JOIN menu_items mi ON oi.item_id = mi.item_id
GROUP BY mi.item_id
ORDER BY total_ordered DESC;

-- Busiest delivery agents
SELECT da.name, COUNT(*) AS deliveries
FROM order_assignments oa
JOIN delivery_agents da ON oa.agent_id = da.agent_id
GROUP BY da.agent_id
ORDER BY deliveries DESC;
