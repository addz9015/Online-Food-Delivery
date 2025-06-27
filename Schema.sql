-- Create and select database
CREATE DATABASE IF NOT EXISTS food_delivery;
USE food_delivery;

-- USERS
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    address TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- RESTAURANTS
CREATE TABLE restaurants (
    restaurant_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address TEXT NOT NULL,
    phone VARCHAR(15),
    rating DECIMAL(2,1) DEFAULT 0.0,
    is_active BOOLEAN DEFAULT TRUE
);

-- MENU ITEMS
CREATE TABLE menu_items (
    item_id INT AUTO_INCREMENT PRIMARY KEY,
    restaurant_id INT,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL,
    is_available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- ORDERS
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    restaurant_id INT,
    total_amount DECIMAL(10,2),
    status ENUM('placed','accepted','prepared','out_for_delivery','delivered','cancelled') DEFAULT 'placed',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- ORDER ITEMS
CREATE TABLE order_items (
    order_item_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    item_id INT,
    quantity INT NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES menu_items(item_id)
);

-- DELIVERY AGENTS
CREATE TABLE delivery_agents (
    agent_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(15) UNIQUE NOT NULL,
    status ENUM('available','unavailable','on_delivery') DEFAULT 'available'
);

-- ORDER ASSIGNMENTS
CREATE TABLE order_assignments (
    assignment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    agent_id INT,
    assigned_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (agent_id) REFERENCES delivery_agents(agent_id)
);

-- AGENT LOCATIONS
CREATE TABLE agent_locations (
    location_id INT AUTO_INCREMENT PRIMARY KEY,
    agent_id INT,
    latitude DECIMAL(9,6),
    longitude DECIMAL(9,6),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (agent_id) REFERENCES delivery_agents(agent_id)
);

-- REVIEWS (Bonus Feature)
CREATE TABLE reviews (
    review_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    restaurant_id INT,
    agent_id INT,
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    review_text TEXT,
    review_type ENUM('restaurant', 'agent') NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
    FOREIGN KEY (agent_id) REFERENCES delivery_agents(agent_id)
);

-- PROMO CODES (Bonus Feature)
CREATE TABLE promo_codes (
    promo_id INT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(50) UNIQUE NOT NULL,
    discount_percent DECIMAL(5,2),
    min_order_amount DECIMAL(10,2),
    expiry_date DATE,
    is_active BOOLEAN DEFAULT TRUE
);

-- ORDER PROMOS (Bonus Feature)
CREATE TABLE order_promos (
    order_id INT,
    promo_id INT,
    applied_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (order_id, promo_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (promo_id) REFERENCES promo_codes(promo_id)
);

-- PAYMENTS (Bonus Feature)
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    method ENUM('cash', 'card', 'wallet') NOT NULL,
    status ENUM('pending', 'completed', 'failed') DEFAULT 'pending',
    amount DECIMAL(10,2),
    paid_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- RESTAURANT HOURS (Bonus Feature)
CREATE TABLE restaurant_hours (
    restaurant_id INT,
    day_of_week ENUM('Mon','Tue','Wed','Thu','Fri','Sat','Sun'),
    open_time TIME,
    close_time TIME,
    PRIMARY KEY (restaurant_id, day_of_week),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);

-- SCHEDULED ORDERS (Bonus Feature)
CREATE TABLE scheduled_orders (
    scheduled_order_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    restaurant_id INT,
    delivery_time DATETIME,
    status ENUM('scheduled','cancelled','completed') DEFAULT 'scheduled',
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);
