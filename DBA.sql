-- 1. 準備乾淨的資料庫環境
DROP DATABASE IF EXISTS beverage_system;
CREATE DATABASE beverage_system;
USE beverage_system;

-- 2. 建立【CATEGORY】分類表
CREATE TABLE CATEGORY (
    category_id VARCHAR(10) PRIMARY KEY,
    category_name VARCHAR(50)
);

-- 3. 建立【BRAND】品牌表
CREATE TABLE BRAND (
    brand_id VARCHAR(10) PRIMARY KEY,
    brand_name VARCHAR(50),
    brand_eng_name VARCHAR(50),
    feature TEXT,
    lat DECIMAL(10, 8),      -- 緯度
    lng DECIMAL(11, 8),      -- 經度
    brand_color VARCHAR(7),  -- 品牌代表色
    logo_path VARCHAR(255),  -- Logo 檔案路徑
    rating DECIMAL(2, 1)     -- 評分 (1.0~5.0)
);

-- 4. 建立【STORE】門市表
CREATE TABLE STORE (
    store_id VARCHAR(10) PRIMARY KEY,
    brand_id VARCHAR(10),
    address VARCHAR(255),
    phone VARCHAR(20),
    opening_hours VARCHAR(50)
);

-- 5. 建立【STANDARD_TOPPING】標準配料表
CREATE TABLE STANDARD_TOPPING (
    standard_id VARCHAR(10) PRIMARY KEY,
    standard_name VARCHAR(50)
);

-- 6. 建立【TOPPING】品牌配料表
CREATE TABLE TOPPING (
    topping_id VARCHAR(10) PRIMARY KEY,
    brand_id VARCHAR(10),
    standard_id VARCHAR(10),
    topping_name VARCHAR(50),
    topping_eng_name VARCHAR(50),
    extra_price INT
);

-- 7. 建立【DRINK】飲品表
CREATE TABLE DRINK (
    drink_id VARCHAR(10) PRIMARY KEY,
    brand_id VARCHAR(10),
    category_id VARCHAR(10),
    drink_name VARCHAR(100),
    drink_eng_name VARCHAR(100),
    base_tea VARCHAR(50),
    price INT
);

-- 8. 建立【DRINK_TOPPING】飲品配料關聯表 (多對多)
CREATE TABLE DRINK_TOPPING (
    drink_id VARCHAR(10),
    topping_id VARCHAR(10),
    PRIMARY KEY (drink_id, topping_id)
);
-- 第一步：暫時關閉檢查，確保塞資料不會被外鍵卡住
SET FOREIGN_KEY_CHECKS = 0;

-- 第二步：清空表格（如果你想重新匯入，這行能確保不會有重複的資料報錯）
TRUNCATE TABLE CATEGORY;

-- 第三步：貼上你從網站複製過來的 INSERT 語法
INSERT INTO `CATEGORY` (`category_id`, `category_name`) VALUES ('C01', '奶茶');
INSERT INTO `CATEGORY` (`category_id`, `category_name`) VALUES ('C02', '奶蓋茶');
INSERT INTO `CATEGORY` (`category_id`, `category_name`) VALUES ('C03', '原味茶');
INSERT INTO `CATEGORY` (`category_id`, `category_name`) VALUES ('C04', '拿鐵');
INSERT INTO `CATEGORY` (`category_id`, `category_name`) VALUES ('C05', '特調');
INSERT INTO `CATEGORY` (`category_id`, `category_name`) VALUES ('C06', '鮮果');

-- 第四步：把檢查開啟
SET FOREIGN_KEY_CHECKS = 1;

-- 第五步：檢查一下結果
SELECT * FROM CATEGORY;
TRUNCATE TABLE BRAND;
INSERT INTO BRAND (brand_id, brand_name, brand_eng_name, feature, lat, lng, brand_color, logo_path, rating) VALUES 
('B01', '50嵐', '50 Lan', '平價大眾款，品項豐富', 24.79715089, 120.9759974, '#FFD700', '/logos/50lan.png', 2.9),
('B02', 'CoCo都可', 'CoCo Tea', '鮮果茶與奶茶為主', 24.79698532, 120.9759035, '#EF7D1A', '/logos/coco.png', 4.0),
('B03', '清心福全', 'Ching Shin', '優多系列為招牌', 24.79588846, 120.974554, '#005743', '/logos/chingshin.png', 1.7),
('B04', '迷客夏', 'Milksha', '鮮奶系列為主打', 24.79676861, 120.9759866, '#83A731', '/logos/milksha.png', 3.8),
('B05', '可不可', 'KEBUKE', '熟成紅茶專門店', 24.79657625, 120.9757104, '#003E52', '/logos/kebuke.png', 4.2),
('B06', 'MOREiN沫飲', 'MOREiN', '波本香草奶蓋為特色', 24.79718742, 120.9762575, '#010101', '/logos/morein.png', 4.7),
('B07', '大茗本位', 'Da Ming', '酪梨奶蓋為招牌', 24.79691714, 120.9761556, '#B06651', '/logos/daming.png', 3.6),
('B08', '麻古茶坊', 'MACU', '果粒茶創始品牌', 24.79795197, 120.9771534, '#E61919', '/logos/macu.png', 3.9),
('B09', '上宇林', 'Shang Yu Lin', '雪浮奶蓋與原味茶為特色', 24.79655016, 120.9755973, '#765232', '/logos/shangyulin.png', 3.7),
('B10', '清原芋圓', 'Ching Yuan', '芋頭甜品與飲品混合', 24.79803092, 120.9773522, '#A778A6', '/logos/chingyuan.png', 4.1);
-- 檢查結果
SELECT * FROM BRAND;
TRUNCATE TABLE STORE;
INSERT INTO `STORE` (`store_id`, `brand_id`, `address`, `phone`, `opening_hours`) VALUES ('S001', 'B01', '300新竹市東區食品路184號', '03-562-8050', '10:00 – 22:00');
INSERT INTO `STORE` (`store_id`, `brand_id`, `address`, `phone`, `opening_hours`) VALUES ('S002', 'B02', '300新竹市東區食品路198號', '03-561-7227', '10:00 – 21:30');
INSERT INTO `STORE` (`store_id`, `brand_id`, `address`, `phone`, `opening_hours`) VALUES ('S003', 'B03', '300新竹市東區食品路231號', '03-561-1367', '10:00 – 21:30');
INSERT INTO `STORE` (`store_id`, `brand_id`, `address`, `phone`, `opening_hours`) VALUES ('S004', 'B04', '300新竹市東區食品路175號', '03-571-3003', '11:00 – 20:45');
INSERT INTO `STORE` (`store_id`, `brand_id`, `address`, `phone`, `opening_hours`) VALUES ('S005', 'B05', '300新竹市東區食品路187號', '03-575-1363', '10:00 – 22:00');
INSERT INTO `STORE` (`store_id`, `brand_id`, `address`, `phone`, `opening_hours`) VALUES ('S006', 'B06', '300新竹市東區食品路182號', '03-561-1858', '10:00 – 21:00');
INSERT INTO `STORE` (`store_id`, `brand_id`, `address`, `phone`, `opening_hours`) VALUES ('S007', 'B07', '300新竹市東區食品路167號', '03-573-0586', '10:00 – 21:00');
INSERT INTO `STORE` (`store_id`, `brand_id`, `address`, `phone`, `opening_hours`) VALUES ('S008', 'B08', '300新竹市東區食品路130號', '03-666-3320', '10:00 – 22:00');
INSERT INTO `STORE` (`store_id`, `brand_id`, `address`, `phone`, `opening_hours`) VALUES ('S009', 'B09', '300新竹市東區食品路189號', '03-525-0600', '10:00 – 22:00');
INSERT INTO `STORE` (`store_id`, `brand_id`, `address`, `phone`, `opening_hours`) VALUES ('S010', 'B10', '300新竹市東區食品路124號', '03-562-1509', '09:00 – 21:00');
SELECT * FROM STORE;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE STANDARD_TOPPING;

INSERT INTO STANDARD_TOPPING (standard_id, standard_name) VALUES
('ST01', '波霸'),
('ST02', '椰果'),
('ST03', '燕麥'),
('ST04', '冰淇淋'),
('ST05', '布丁'),
('ST06', '仙草凍'),
('ST07', '茶凍'),
('ST08', '粉角'),
('ST09', '寒天晶球'),
('ST10', '粉粿'),
('ST11', '奶蓋'),
('ST12', '養樂多');

SET FOREIGN_KEY_CHECKS = 1;

-- ===================================================
-- 6. 建立【TOPPING】品牌配料表 (已全面修正 standard_id 外鍵對接錯誤)
-- ===================================================
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE TOPPING;

INSERT INTO `TOPPING` (`topping_id`, `brand_id`, `standard_id`, `topping_name`, `topping_eng_name`, `extra_price`) VALUES 
-- 💡 B01 50嵐
('T0105', 'B01', 'ST01', '波霸(大珍珠)', 'Bubble', '10'),
('T0110', 'B01', 'ST02', '椰果', 'Coconut Jelly', '10'),
('T0112', 'B01', 'ST03', '燕麥', 'Oat', '10'),
('T0104', 'B01', 'ST04', '香草冰淇淋', 'Ice Cream', '15'),
('T0103', 'B01', 'ST05', '布丁', 'Pudding', '15'),

-- 💡 B02 CoCo都可 (修正：珍珠=ST01, 布丁=ST05, 仙草=ST06, 椰果=ST02, 茶凍=ST07, 粉角=ST08)
('T0205', 'B02', 'ST01', '珍珠', 'Tapioca Pearl', '10'),
('T0203', 'B02', 'ST05', '布丁', 'Pudding', '10'),
('T0201', 'B02', 'ST06', '仙草', 'Grass Jelly', '10'),
('T0210', 'B02', 'ST02', '椰果', 'Nata Jelly', '10'),
('T0208', 'B02', 'ST07', '茉香茶凍', 'Jasmine Green Jelly', '10'),
('T0206', 'B02', 'ST08', '粉角', 'Tapioca Cube', '10'),

-- 💡 B03 清心福全 (修正：珍珠=ST01, 茶凍=ST07, 椰果=ST02, 仙草凍=ST06, 布丁=ST05)
('T0305', 'B03', 'ST01', '珍珠', 'Bubble', '10'),
('T0308', 'B03', 'ST07', '茉綠茶凍', 'Jasmine Green Jelly', '10'),
('T0310', 'B03', 'ST02', '椰果', 'Coconut Jelly', '10'),
('T0301', 'B03', 'ST06', '仙草凍', 'Grass Jelly', '5'),
('T0303', 'B03', 'ST05', '布丁', 'Pudding', '15'),

-- 💡 B04 迷客夏 (修正：珍珠=ST01, 仙草凍=ST06, 綠茶凍=ST07, 脆啵啵=ST09, 粉粿=ST10)
('T0405', 'B04', 'ST01', '珍珠', 'Bubble (White Jade)', '10'),
('T0401', 'B04', 'ST06', '仙草凍', 'Grass Jelly', '10'),
('T0408', 'B04', 'ST07', '綠茶凍', 'Green Tea Jelly', '10'),
('T0409', 'B04', 'ST09', '脆啵啵球', 'Popping Boba', '15'),
('T0407', 'B04', 'ST10', '桂香粉粿', 'Osmanthus Jelly Cake', '15'),

-- 💡 B05 可不可 (修正：白玉=ST01, 水玉=ST09, 蕎麥凍=ST07)
('T0505', 'B05', 'ST01', '白玉', 'Bubble (White Jade)', '10'),
('T0509', 'B05', 'ST09', '水玉', 'Water Jade Pearl', '10'),
('T0508', 'B05', 'ST07', '榛果蕎麥凍', 'Hazelnut Buckwheat Jelly', '15'),

-- 💡 B06 MOREiN沫飲 (修正：珍珠=ST01, 粉粿=ST10, 奶蓋=ST11)
('T0605', 'B06', 'ST01', '蜂蜜珍珠', 'Honey Bubble', '10'),
('T0607', 'B06', 'ST10', '手作黑糖粉粿', 'Brown Sugar Jelly Cake', '15'),
('T0608', 'B06', 'ST10', '手作咖啡粉粿', 'Caramel Coffee Jelly Cake', '15'),
('T0602', 'B06', 'ST11', '波本香草奶蓋', 'Vanilla Milk Foam', '30'),

-- 💡 B07 大茗本位 (修正：珍珠=ST01, 仙草=ST06, 蕎麥凍=ST07, 粉粿=ST10, 奶蓋=ST11)
('T0705', 'B07', 'ST01', '波霸珍珠', 'Bubble', '10'),
('T0701', 'B07', 'ST06', '嫩仙草', 'Grass Jelly', '10'),
('T0708', 'B07', 'ST07', '烤糖蕎麥凍', 'Buckwheat Jelly', '20'),
('T0707', 'B07', 'ST10', '咖啡粉粿', 'Coffee Jelly', '20'),
('T0702', 'B07', 'ST11', '酪梨奶蓋', 'Avocado Milk Foam', '35'),

-- 💡 B08 麻古茶坊 (修正：粉粿=ST10, 養樂多=ST12, 椰果=ST02, 波霸=ST01, 仙草=ST06, 綠茶凍=ST07, 芝芝=ST11)
('T0807', 'B08', 'ST10', '紅萱粉粿', 'Hung Xuan Tea Jelly', '10'),
('T0811', 'B08', 'ST12', '養樂多', 'Yakult', '10'),
('T0810', 'B08', 'ST02', '椰果', 'Coconut Jelly', '10'),
('T0805', 'B08', 'ST01', '波霸', 'Bubble', '10'),
('T0801', 'B08', 'ST06', '仙草凍', 'Grass Jelly', '10'),
('T0808', 'B08', 'ST07', '綠茶凍', 'Green Tea Jelly', '10'),
('T0802', 'B08', 'ST11', '芝芝', 'Cheese Foam', '20'),

-- 💡 B09 上宇林 (修正：珍珠=ST01, 椰果=ST02, 仙草=ST06, 粉角=ST08, 綠茶凍=ST07, 布丁=ST05, 多多=ST12, 冰淇淋=ST04, 粉粿=ST10)
('T0905', 'B09', 'ST01', '珍珠', 'Pearl', '10'),
('T0910', 'B09', 'ST02', '椰果', 'Coconut Jelly', '10'),
('T0901', 'B09', 'ST06', '仙草凍', 'Grass Jelly', '10'),
('T0906', 'B09', 'ST08', '手工粉角', 'Tapioca Cube', '10'),
('T0908', 'B09', 'ST07', '茉莉綠茶凍', 'Jasmine Green Jelly', '10'),
('T0903', 'B09', 'ST05', '布丁', 'Pudding', '15'),
('T0911', 'B09', 'ST12', '多多', 'Yakult', '20'),
('T0904', 'B09', 'ST04', '香草冰淇淋', 'Ice Cream', '20'),
('T0907', 'B09', 'ST10', '黑糖Q粿', 'Brown Sugar Jelly', '20'),

-- 💡 B10 清原芋圓 (修正：珍珠=ST01, 椰果=ST02, 仙草=ST06, QQ角/粉角=ST08)
('T1005', 'B10', 'ST01', '珍珠', 'Bubble', '10'),
('T1010', 'B10', 'ST02', '椰果', 'Coconut Jelly', '10'),
('T1001', 'B10', 'ST06', '仙草', 'Grass Jelly', '10'),
('T1006', 'B10', 'ST08', 'QQ角', 'Tapioca Cube', '20');

SET FOREIGN_KEY_CHECKS = 1;
-- 驗證匯入結果
SELECT * FROM TOPPING;
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE DRINK; -- 清空舊的飲料資料
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D001', 'B01', 'C03', '茉莉綠茶', 'Jasmine Green Tea', '綠茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D002', 'B01', 'C03', '阿薩姆紅茶', 'Assam Black Tea', '紅茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D003', 'B01', 'C03', '四季春青茶', 'Four Season Tea', '青茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D004', 'B01', 'C03', '黃金烏龍', 'Oolong Tea', '烏龍茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D005', 'B01', 'C06', '微檸檬紅茶', 'Light Lemon Black Tea', '紅茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D006', 'B01', 'C06', '微檸檬青茶', 'Light Lemon Four Season Tea', '青茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D007', 'B01', 'C06', '檸檬綠茶', 'Lemon Green Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D008', 'B01', 'C06', '檸檬青茶', 'Lemon Four Season Tea', '青茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D009', 'B01', 'C06', '梅の綠', 'Plum Green Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D010', 'B01', 'C06', '8冰綠', 'No.8 Green', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D011', 'B01', 'C06', '情人茶', 'Lover\'s Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D012', 'B01', 'C06', '柚子紅茶', 'Yuzu Black Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D013', 'B01', 'C06', '柚子綠茶', 'Yuzu Green Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D014', 'B01', 'C06', '柚子青茶', 'Yuzu Four Season Tea', '青茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D015', 'B01', 'C06', '柚子烏龍', 'Yuzu Oolong Tea', '烏龍茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D016', 'B01', 'C06', '旺來紅茶', 'Pineapple Black Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D017', 'B01', 'C06', '旺來青茶', 'Pineapple Four Season Tea', '青茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D018', 'B01', 'C05', '冰淇淋紅茶', 'Ice Cream Black Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D019', 'B01', 'C05', '多多綠', 'Yakult Green Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D020', 'B01', 'C05', '多多紅', 'Yakult Black Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D021', 'B01', 'C01', '奶茶', 'Milk Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D022', 'B01', 'C01', '奶綠', 'Green Milk Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D023', 'B01', 'C01', '烏龍奶', 'Oolong Milk Tea', '烏龍茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D024', 'B01', 'C01', '椰果奶茶', 'Coconut Jelly Milk Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D025', 'B01', 'C01', '波霸奶茶', 'Bubble Milk Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D026', 'B01', 'C01', '燕麥奶茶', 'Oat Milk Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D027', 'B01', 'C01', '燕麥奶青', 'Oat Four Season Milk Tea', '青茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D028', 'B01', 'C01', '燕麥烏龍奶', 'Oat Oolong Milk Tea', '烏龍茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D029', 'B01', 'C01', '布丁奶茶', 'Pudding Milk Tea', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D030', 'B01', 'C05', '冰淇淋奶茶', 'Ice Cream Milk Tea', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D031', 'B01', 'C02', '紅茶瑪奇朵', 'Black Tea Macchiato', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D032', 'B01', 'C02', '青茶瑪奇朵', 'Four Season Tea Macchiato', '青茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D033', 'B01', 'C01', '阿華田', 'Ovaltine', '可可', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D034', 'B01', 'C01', '燕麥阿華田', 'Oat Ovaltine', '可可', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D035', 'B01', 'C01', '可可芭蕾', 'Cacao Barry', '可可', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D036', 'B01', 'C04', '紅茶拿鐵', 'Black Tea Latte', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D037', 'B01', 'C04', '綠茶拿鐵', 'Green Tea Latte', '綠茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D038', 'B01', 'C04', '烏龍拿鐵', 'Oolong Tea Latte', '烏龍茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D039', 'B01', 'C04', '波霸紅茶拿鐵', 'Bubble Black Tea Latte', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D040', 'B01', 'C04', '燕麥紅茶拿鐵', 'Oat Black Tea Latte', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D041', 'B01', 'C04', '布丁紅茶拿鐵', 'Pudding Black Tea Latte', '紅茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D042', 'B01', 'C05', '冰淇淋紅茶拿鐵', 'Ice Cream Black Tea Latte', '紅茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D043', 'B01', 'C04', '阿華田拿鐵', 'Ovaltine Latte', '可可', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D044', 'B01', 'C04', '燕麥阿華田拿鐵', 'Oat Ovaltine Latte', '可可', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D045', 'B01', 'C04', '可可芭蕾拿鐵', 'Cacao Barry Latte', '紅茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D046', 'B01', 'C06', '柚子茶', 'Yuzu Juice', '果汁', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D047', 'B01', 'C06', '8冰茶', 'No.8 Juice', '果汁', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D048', 'B01', 'C06', '檸檬汁', 'Lemon Juice', '果汁', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D049', 'B01', 'C06', '金桔檸檬', 'Kumquat Lemon Juice', '果汁', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D050', 'B01', 'C06', '檸檬梅汁', 'Lemon Plum Juice', '果汁', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D051', 'B01', 'C05', '檸檬多多', 'Lemon Yakult Juice', '果汁', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D052', 'B02', 'C06', '百香雙響炮', 'Passion Fruit Tea with Tapioca & Coconut Jelly', '綠茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D053', 'B02', 'C06', '鮮榨蘋果百香', 'Fresh Apple Passion Fruit Tea', '綠茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D054', 'B02', 'C06', '百香果綠茶', 'Passion Fruit Green Tea', '綠茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D055', 'B02', 'C06', '芒果綠茶', 'Mango Green Tea', '綠茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D056', 'B02', 'C05', '綠茶養樂多', 'Yakult Green Tea', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D057', 'B02', 'C06', '葡萄柚果粒茶', 'Grapefruit Green Tea', '綠茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D058', 'B02', 'C06', '金桔檸檬', 'Kumquat Lemon', '果汁', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D059', 'B02', 'C06', '蜜香檸凍紅茶', 'Honey Lemon Black Tea', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D060', 'B02', 'C06', '蜜香檸凍青茶', 'Honey Lemon Highland Tea', '青茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D061', 'B02', 'C06', '蜜香檸凍綠茶', 'Honey Lemon Green Tea', '綠茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D062', 'B02', 'C06', '檸檬奇遇桔', 'Kumquat Lemon With Chia Seed', '果汁', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D063', 'B02', 'C06', '粉角冬瓜檸檬', 'Winter Melon Lemon with Gem Boba', '冬瓜茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D064', 'B02', 'C06', '檸檬紅茶', 'Lemon Black Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D065', 'B02', 'C06', '檸檬綠茶', 'Lemon  Green Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D066', 'B02', 'C05', '綠豆沙', 'Mung Bean Smoothie', '綠豆', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D067', 'B02', 'C05', '綠豆沙牛奶', 'Mung Bean Milk Smoothie', '綠豆', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D068', 'B02', 'C01', '珍珠奶茶', 'Bubble Milk Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D069', 'B02', 'C01', '奶茶三兄弟', 'Milk Tea with Bubble & Pudding & Grass Jelly', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D070', 'B02', 'C01', 'QQ奶茶', 'Milk Tea with Bubble & Taro Balls)', '紅茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D071', 'B02', 'C01', '布丁奶茶', 'Pudding Milk Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D072', 'B02', 'C01', '西谷露奶茶', 'Sago Milk Tea', '紅茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D073', 'B02', 'C01', '仙草凍奶茶', 'Grass Jelly Milk Tea', '紅茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D074', 'B02', 'C01', '阿薩姆奶茶', 'Assam Milk Tea', '紅茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D075', 'B02', 'C01', '茉香奶綠', 'Jasmine Milk Tea', '綠茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D076', 'B02', 'C03', '四季春青茶', 'Four Season Tea', '青茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D077', 'B02', 'C03', '手採紅茶', 'Black Tea', '紅茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D078', 'B02', 'C03', '茉莉綠茶', 'Jasmine Green Tea', '綠茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D079', 'B02', 'C03', '琥珀烏龍', 'Oolong Tea', '烏龍茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D080', 'B02', 'C05', '蕎麥冬瓜露', 'Buckwheat Winter Melon Tea', '蕎麥茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D081', 'B02', 'C03', '蕎麥茶', 'Buckwheat Tea', '蕎麥茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D082', 'B02', 'C03', '手做冬瓜露', 'Winter Melon Drink', '冬瓜茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D083', 'B02', 'C04', '英式鮮奶茶', 'Black Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D084', 'B02', 'C04', '日焙鮮奶茶', 'Roasted Green Tea Latte', '綠茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D085', 'B02', 'C04', '珍珠鮮奶茶', 'Bubble Black Tea Latte', '紅茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D086', 'B02', 'C04', 'QQ鮮奶茶', 'Black Tea Latte With Bubble & Coconut Jelly', '紅茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D087', 'B02', 'C04', '28茉輕乳茶', '28 Jasmine Milk Tea', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D088', 'B02', 'C04', '28茉粉角輕乳茶', '28 Jasmine Milk Tea with Gem Boba', '綠茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D089', 'B03', 'C05', '優多紅茶', 'Yogurt Black Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D090', 'B03', 'C05', '優多青茶', 'Yogurt Four Seasons Oolong Tea', '青茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D091', 'B03', 'C05', '優多百香果', 'Yogurt Passion Fruit', '果汁', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D092', 'B03', 'C05', '優多葡萄柚', 'Yogurt Grapefruit', '果汁', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D093', 'B03', 'C05', '優多檸檬', 'Yogurt Lemon', '果汁', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D094', 'B03', 'C05', '優多綠茶', 'Yogurt Green Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D095', 'B03', 'C06', '蘆薈蜂蜜檸檬', 'Honey Lemon Aloe', '果汁', '90');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D096', 'B03', 'C06', '蜂蜜檸檬', 'Honey Lemon', '果汁', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D097', 'B03', 'C06', '金桔檸檬', 'Kumquat Lemon', '果汁', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D098', 'B03', 'C06', '檸檬紅茶', 'Lemon Black Tea', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D099', 'B03', 'C06', '檸檬綠茶', 'Lemon Green Tea', '綠茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D100', 'B03', 'C06', '梅子綠茶', 'Plum Green Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D101', 'B03', 'C05', '冰淇淋紅茶', 'Ice Cream Black Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D102', 'B03', 'C05', '冰淇淋奶茶', 'Ice Cream Milk Tea', '紅茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D103', 'B03', 'C05', '蘋果醋', 'Apple Cider Vinegar', '果醋', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D104', 'B03', 'C05', '蘋果醋紅茶', 'Apple Cider Vinegar Black Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D105', 'B03', 'C05', '蜂蜜蘋果醋', 'Honey Apple Cider Vinegar', '果醋', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D106', 'B03', 'C05', '藍莓醋', 'Blueberry Vinegar Drink', '果醋', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D107', 'B03', 'C05', '蜂蜜藍莓醋', 'Honey Blueberry Vinegar', '果醋', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D108', 'B03', 'C03', '冬瓜茶', 'Winter Melon Tea', '冬瓜茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D109', 'B03', 'C06', '冬瓜檸檬', 'Winter Melon Lemon Tea', '冬瓜茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D110', 'B03', 'C05', '冬瓜菁茶', 'Winter Melon Green Tea', '青茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D111', 'B03', 'C06', '百香果綠茶', 'Passion Fruit Green Tea', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D112', 'B03', 'C06', '雙Q百香果綠茶', 'Passion Fruit Green Tea With Tapioca & Coconut Jelly', '綠茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D113', 'B03', 'C01', '茶凍奶綠', 'Green Milk Tea with Tea Jelly', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D114', 'B03', 'C01', '珍珠奶茶', 'Bubble Milk Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D115', 'B03', 'C01', '錫蘭奶紅', 'Ceylon Black Milk Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D116', 'B03', 'C01', '烏龍奶茶', 'Oolong Milk Tea', '烏龍茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D117', 'B03', 'C01', '特級奶綠', 'Premium Green Milk Tea', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D118', 'B03', 'C01', '極品奶菁', 'Premium Oolong Milk Tea', '青茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D119', 'B03', 'C01', '烏龍奶菁', 'Oolong Green Milk Tea', '烏龍茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D120', 'B03', 'C01', '四季奶茶', 'Four Seasons Oolong Milk Tea', '青茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D121', 'B03', 'C04', '鮮奶茶', 'Black Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D122', 'B03', 'C04', '珍珠蜂蜜鮮奶普洱', 'Honey Bubble Puer Tea Latte', '普洱茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D123', 'B03', 'C04', '珍珠鮮奶茶', 'Bubble Black Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D124', 'B03', 'C04', '鮮奶冬瓜', 'Winter Melon Milk Tea', '冬瓜茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D125', 'B03', 'C04', '頂級可可拿鐵', 'Premium Chocolate Latte', '可可', '85');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D126', 'B03', 'C03', '極品菁茶', 'Premium Oolong Tea', '青茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D127', 'B03', 'C03', '錫蘭紅茶', 'Ceylon Black Tea', '紅茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D128', 'B03', 'C03', '特級綠茶', 'Finest Green Tea', '綠茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D129', 'B03', 'C03', '原鄉四季', 'Four Seasons Oolong Tea', '青茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D130', 'B03', 'C03', '特遠普洱', 'Finest Puer Tea', '普洱茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D131', 'B04', 'C04', '娜杯紅茶拿鐵', 'Naber Black Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D132', 'B04', 'C04', '伯爵紅茶拿鐵', 'Earl Grey Tea Latte', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D133', 'B04', 'C04', '大正紅茶拿鐵', 'Taisho Black Tea Latte', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D134', 'B04', 'C04', '琥珀烏龍拿鐵', 'Oolong Tea Latte', '烏龍茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D135', 'B04', 'C04', '茶香綠茶拿鐵', 'Green Tea Latte', '綠茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D136', 'B04', 'C04', '原片青茶拿鐵', 'Oolong Tea Latte', '青茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D137', 'B04', 'C04', '珍珠伯爵拿鐵', 'Bubble  Earl Grey Black Tea Latte', '紅茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D138', 'B04', 'C04', '珍珠大正拿鐵', 'Bubble Taisho Black Tea Latte', '紅茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D139', 'B04', 'C04', '珍珠娜杯紅茶拿鐵', 'Bubble Naber Tea Latte', '紅茶', '80');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D140', 'B04', 'C04', '伯爵可可拿鐵', 'Earl Grey Cacao Latte', '紅茶', '85');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D141', 'B04', 'C03', '娜杯紅茶', 'Naber Black Tea', '紅茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D142', 'B04', 'C03', '伯爵紅茶', 'Earl Grey Black Tea', '紅茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D143', 'B04', 'C03', '大正紅茶', 'Taisho Black Tea', '紅茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D144', 'B04', 'C03', '原片初露青茶', 'Oolong Tea', '青茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D145', 'B04', 'C03', '茉莉原淬綠茶', 'Jasmine Green Tea', '綠茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D146', 'B04', 'C03', '琥珀高峰烏龍', 'Amber Oolong Tea', '烏龍茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D147', 'B04', 'C05', '芋頭鮮奶', 'Taro Milk', '芋泥', '90');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D148', 'B04', 'C05', '珍珠鮮奶', 'Bubble Milk', '鮮奶', '90');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D149', 'B04', 'C05', '嫩仙草凍鮮奶', 'Grass Jelly Milk', '鮮奶', '85');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D150', 'B04', 'C04', '法芙娜可可鮮奶', 'Valrhona Cacao Milk', '可可', '100');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D151', 'B04', 'C03', '輕纖蕎麥茶', 'Buckwheat Tea', '蕎麥茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D152', 'B04', 'C04', '輕纖蕎麥拿鐵', 'Buckwheat Tea Latte', '蕎麥茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D153', 'B04', 'C03', '焙香決明大麥', 'Roasted Barley Tea', '蕎麥茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D154', 'B04', 'C04', '焙香大麥拿鐵', 'Roasted Barley Latte', '蕎麥茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D155', 'B04', 'C03', '原鄉冬瓜茶', 'Winter Melon Tea', '冬瓜茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D156', 'B04', 'C06', '冬瓜檸檬', 'Winter Melon Lemon', '冬瓜茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D157', 'B04', 'C05', '冬瓜麥茶', 'Winter Melon Barley Tea', '蕎麥茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D158', 'B04', 'C06', '熟醸青梅綠', 'Pickled Plum Green Tea', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D159', 'B04', 'C06', '熟醸青梅檸', 'Pickled Plum Lemon Tea', '果汁', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D160', 'B04', 'C06', '白甘蔗青茶', 'Sugarcane Oolong Tea', '青茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D161', 'B04', 'C06', '冬瓜青茶', 'Winter Melon Oolong Tea', '青茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D162', 'B04', 'C06', '柳丁綠茶', 'Orange Green Tea', '綠茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D163', 'B04', 'C06', '柳丁青茶', 'Orange  Oolong Tea', '青茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D164', 'B04', 'C06', '青檸香茶', 'Lime Tea', '青茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D165', 'B04', 'C06', '蜂蜜檸檬晶凍', 'Honey Lemon Jelly Tea', '果汁', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D166', 'B04', 'C06', '香柚綠茶', 'Grapefruit Green Tea', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D167', 'B04', 'C05', '養樂多綠', 'Yakult Green Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D168', 'B04', 'C06', '冰萃柳丁', 'Cold Brew Orange', '果汁', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D169', 'B05', 'C03', '熟成紅茶', 'Aged Black Tea', '紅茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D170', 'B05', 'C03', '麗春紅茶', 'Rose Black Tea', '紅茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D171', 'B05', 'C03', '胭脂紅茶', 'Carmine Black Tea', '紅茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D172', 'B05', 'C03', '半熟烏龍', 'Semi-Ripe Oolong', '烏龍茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D173', 'B05', 'C03', '春芽綠茶', 'Spring Bud Green Tea', '綠茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D174', 'B05', 'C03', '雪花冷露', 'Snowflake Winter Melon', '冬瓜茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D175', 'B05', 'C05', '熟成冷露', 'Aged Winter Melon', '紅茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D176', 'B05', 'C05', '春芽冷露', 'Spring Bud Winter Melon', '綠茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D177', 'B05', 'C05', '半熟烏龍冷露', 'Semi-Ripe Oolong Winter Melon', '烏龍茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D178', 'B05', 'C05', '胭脂冷露', 'Carmine Winter Melon', '紅茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D179', 'B05', 'C06', '檸檬冷露', 'Lemon Winter Melon', '果汁', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D180', 'B05', 'C01', '熟成奶茶', 'Aged Milk Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D181', 'B05', 'C01', '胭脂奶茶', 'Carmine Milk Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D182', 'B05', 'C01', '白玉奶茶', 'White Bubble Milk Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D183', 'B05', 'C04', '熟成歐蕾', 'Aged Milk Tea Latte', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D184', 'B05', 'C04', '冷露歐蕾', 'Winter Melon Milk Tea Latte', '冬瓜茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D185', 'B05', 'C04', '金蜜歐蕾', 'Gold Honey Milk Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D186', 'B05', 'C04', '胭脂歐蕾', 'Carmine Milk Tea Latte', '紅茶', '69');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D187', 'B05', 'C04', '白玉歐蕾', 'White Bubble Black Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D188', 'B05', 'C04', '鶯鶯歐蕾', 'Warbler Milk Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D189', 'B05', 'C04', '熟成榛果歐蕾', 'Aged Hazelnut Milk Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D190', 'B05', 'C04', '墨玉鶯鶯歐蕾', 'Black Jade Warbler Latte', '紅茶', '80');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D191', 'B05', 'C04', '半熟烏龍歐蕾', 'Semi-Ripe Oolong Latte', '烏龍茶', '69');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D192', 'B05', 'C04', '半熟烏龍厚乳', 'Semi-Ripe Oolong Heavy Milk Latte', '烏龍茶', '69');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D193', 'B05', 'C06', '熟檸紅茶', 'Aged Lemon Black Tea', '紅茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D194', 'B05', 'C06', '春檸綠茶', 'Spring Lemon Green Tea', '綠茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D195', 'B05', 'C06', '春梅冰茶', 'Spring Plum Iced Tea', '果汁', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D196', 'B05', 'C05', '太妃熟成', 'Toffee Aged Tea', '紅茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D197', 'B05', 'C05', '金蜜熟成', 'Gold Honey Aged Tea', '紅茶', '58');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D198', 'B05', 'C05', '胭脂多多', 'Carmine Yakult Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D199', 'B05', 'C03', '輕纖穀奈茶', 'Grain Tea', '蕎麥茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D200', 'B05', 'C05', '穀奈冷露', 'Grain Winter Melon Tea', '蕎麥茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D201', 'B05', 'C04', '穀奈歐蕾', 'Grain Milk Tea Latte', '蕎麥茶', '69');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D202', 'B05', 'C06', '金蜜檸檬', 'Gold Honey Lemon Tea', '蕎麥茶', '58');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D203', 'B05', 'C05', '雪藏紅茶', 'Ice Cream Black Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D204', 'B05', 'C05', '雪藏奶茶', 'Ice Cream Milk Tea', '紅茶', '69');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D205', 'B06', 'C03', '四季青茶', 'Four Seasons Tea', '青茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D206', 'B06', 'C03', '黃金蕎麥', 'Buckwheat Tea', '蕎麥茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D207', 'B06', 'C03', '舞鶴紅茶', 'Honey Flavored Black Tea', '紅茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D208', 'B06', 'C03', '茉綠茶', 'Jasmine Green Tea', '綠茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D209', 'B06', 'C03', '肯亞紅茶', 'Kenya Black Tea', '紅茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D210', 'B06', 'C03', '嵐烏龍', 'Oolong Tea', '烏龍茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D211', 'B06', 'C03', '香韻青茶', 'Gardenia Four Seasons Green Tea', '青茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D212', 'B06', 'C04', '盧哈娜拿鐵', 'Black Tea Latte', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D213', 'B06', 'C04', '茉香拿鐵', 'Green Tea Latte', '綠茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D214', 'B06', 'C04', '烏龍拿鐵', 'Oolong Tea Latte', '烏龍茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D215', 'B06', 'C04', '黃金蕎麥拿鐵', 'Buckwheat Tea Latte', '蕎麥茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D216', 'B06', 'C04', '舞鶴紅茶拿鐵', 'Honey Flavored Black Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D217', 'B06', 'C04', '珍珠紅茶拿鐵', 'Bubble Black Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D218', 'B06', 'C04', '黑糖粉粿拿鐵', 'Jelly Cake Black Tea Latte', '紅茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D219', 'B06', 'C04', '黑焦拿鐵', 'Caramel Coffee Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D220', 'B06', 'C04', '黑焦粉粿拿鐵', 'Caramel Jelly Coffee Tea Latte', '紅茶', '80');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D221', 'B06', 'C02', '波本香草奶蓋綠', 'Green Tea With Vanilla Milk Foam', '綠茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D222', 'B06', 'C02', '波本香草奶蓋蕎麥', 'Buckwheat Tea With Vanilla Milk Foam', '蕎麥茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D223', 'B06', 'C02', '波本香草奶茶紅', 'Black Tea With Vanilla Milk Foam', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D224', 'B06', 'C02', '波本香草奶蓋青', 'Four Seasons Tea With Vanilla Milk Foam', '青茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D225', 'B06', 'C02', '波本香草奶蓋烏龍', 'Oolong Tea With Vanilla Milk Foam', '烏龍茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D226', 'B06', 'C01', '盧哈娜奶茶', 'Milk Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D227', 'B06', 'C01', '茉香奶茶', 'Green Milk Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D228', 'B06', 'C01', '烏龍奶茶', 'Oolong Milk Tea', '烏龍茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D229', 'B06', 'C01', '黃金蕎麥奶茶', 'Buckwheat Milk Tea', '蕎麥茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D230', 'B06', 'C01', '黑糖粉粿奶茶', 'Jelly Cake Milk Tea', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D231', 'B06', 'C01', '蕎麥粉粿奶茶', 'Jelly Cake Buckwheat Milk Tea', '蕎麥茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D232', 'B06', 'C01', '舞鶴奶茶', 'Honey Flavored Milk Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D233', 'B06', 'C01', '珍珠奶茶', 'Bubble Milk Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D234', 'B06', 'C06', '香韻青蘋', 'Apple Taiwanese Ching Tea', '果汁', '69');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D235', 'B06', 'C06', '青森蘋粿', 'Jelly Cake Apple Four Seasons Tea', '果汁', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D236', 'B06', 'C06', '青森蜜桃烏龍', 'Apple Peach Oolong Tea', '烏龍茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D237', 'B06', 'C06', '雙柚熱烏龍', 'Double Pomelo Oolong Tea', '烏龍茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D238', 'B06', 'C06', '香橙翡翠綠', 'Orange Green Tea', '綠茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D239', 'B06', 'C06', '鮮榨凍檸紅', 'Lemon Black Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D240', 'B06', 'C06', '鮮榨凍檸綠', 'Lemon Green Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D241', 'B06', 'C06', '甘蔗四季青', 'Sugar Cane Four Seasons Tea', '青茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D242', 'B06', 'C03', '舞鶴焦糖燉奶', 'Panna Cotta Honey Flavored Black Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D243', 'B06', 'C03', '手工冬瓜露', 'Winter Melon Tea', '冬瓜茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D244', 'B06', 'C05', '黃金蕎麥冬露', 'Winter Melon Buckwheat Tea', '蕎麥茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D245', 'B06', 'C03', '香韻冬露', 'Winter Melon Gardenia Four Seasons Tea', '冬瓜茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D246', 'B06', 'C05', '冬露紅茶', 'Winter Melon Black Tea', '紅茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D247', 'B06', 'C05', '冬露青茶', 'Winter Melon Four Seasons Tea', '青茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D248', 'B06', 'C06', '鮮檸冬露', 'Lemon Winter Melon Tea', '冬瓜茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D249', 'B07', 'C03', '玉露青茶', 'Taiwanese Ching Tea', '青茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D250', 'B07', 'C03', '桂花青茶', 'Osmanthus Ching Tea', '青茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D251', 'B07', 'C03', '炭燒青茶', 'Oolong Tea', '青茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D252', 'B07', 'C03', '翡翠綠茶', 'Jasmine Green Tea', '綠茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D253', 'B07', 'C03', '紅玉紅茶', 'Taiwanese Black Tea', '紅茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D254', 'B07', 'C03', '御品冬瓜露', 'Winter Melon Drink', '冬瓜茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D255', 'B07', 'C03', '熟成油切蕎麥', 'Buckwheat Tea', '蕎麥茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D256', 'B07', 'C03', '冷萃東方美人', 'Cold Brew Oriental Beauty Tea', '烏龍茶', '59');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D257', 'B07', 'C03', '冷萃半熟金萱', 'Cold Brew Jin Xuan Tea', '青茶', '59');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D258', 'B07', 'C04', '紅茶拿鐵', 'Black Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D259', 'B07', 'C04', '翡翠拿鐵', 'Jasmine Green Tea Latte', '綠茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D260', 'B07', 'C04', '鐵觀音拿鐵', 'Oolong Tea Latte', '烏龍茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D261', 'B07', 'C05', '仙草嫩奶', 'Grass Jelly Milk', '鮮奶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D262', 'B07', 'C05', '珍珠粉粿牛奶', 'Milk with Bubble & Coffee Jelly', '鮮奶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D263', 'B07', 'C02', '酪梨奶蓋紅玉', 'Taiwanese Black Tea With Avocado Milk Foam', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D264', 'B07', 'C02', '酪梨奶蓋綠茶', 'Taiwanese Jasmine Green Tea With Avocado Milk Foam', '綠茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D265', 'B07', 'C02', '酪梨奶蓋烏龍', 'Oolong Tea With Avocado Milk Foam', '烏龍茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D266', 'B07', 'C02', '酪梨奶蓋冬瓜露', 'Winter Melon Drink With Avocado Milk Foam', '冬瓜茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D267', 'B07', 'C01', '玉露奶青', 'Taiwanese Ching Milk Tea', '青茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D268', 'B07', 'C01', '桂花奶青', 'Osmanthus Ching Milk Tea', '青茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D269', 'B07', 'C01', '懷舊經典奶茶', 'Milk Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D270', 'B07', 'C01', '翡翠奶綠', 'Green Milk Tea', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D271', 'B07', 'C01', '鐵觀音奶茶', 'Oolong Milk Tea', '烏龍茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D272', 'B07', 'C01', '熟成蕎麥奶茶', 'Buckwheat Milk Tea', '蕎麥茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D273', 'B07', 'C01', '珍珠奶茶', 'Bubble Milk Tea', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D274', 'B07', 'C01', '烤糖蕎麥凍奶', 'Buckwheat Jelly Taiwanese Ching Milk Tea', '蕎麥茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D275', 'B07', 'C01', '珈琲粉粿蕎麥奶', 'Coffee Jelly with Buckwheat Milk Tea', '蕎麥茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D276', 'B07', 'C06', '蘋果玉露青', 'Apple Taiwanese Ching Tea', '青茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D277', 'B07', 'C06', '老奶奶的鳳梨田', 'Pineapple Juice Taiwanese Ching Tea', '青茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D278', 'B07', 'C06', '甘蔗玉露青', 'Sugar Cane Taiwanese Ching Tea', '青茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D279', 'B07', 'C05', '冬瓜玉露青', 'Winter Melon Taiwanese Ching Tea', '青茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D280', 'B07', 'C06', '纖檸冬瓜露', 'Lemon Winter Melon Drink', '冬瓜茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D281', 'B07', 'C05', '翡翠多多青', 'Yakult Jasmine Green Tea', '青茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D282', 'B07', 'C06', '檸檬桂花青', 'Lemon Osmanthus Ching Tea', '青茶', '69');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D283', 'B07', 'C06', '柳橙翡翠青', 'Orange Jasmine Green Tea', '青茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D284', 'B08', 'C06', '香橙果粒茶', 'Orange & Passion Fruit Green Tea', '綠茶', '85');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D285', 'B08', 'C06', '柳橙果粒茶', 'Orange Red Oolong Tea', '烏龍茶', '80');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D286', 'B08', 'C06', '葡萄柚果粒茶', 'Grapefruit Green Tea', '綠茶', '80');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D287', 'B08', 'C06', '葡萄柚果粒蜜茶', 'Grapefruit Honey Tea', '綠茶', '80');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D288', 'B08', 'C06', '粉粿橙香紅萱', 'Orange  Red Ooling Tea  With Red Ooling Jelly', '烏龍茶', '85');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D289', 'B08', 'C06', '橙香紅萱', 'Orange With Red Ooling Tea', '烏龍茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D290', 'B08', 'C06', '柚香紅萱', 'Grapefruit With Red Ooling Tea', '烏龍茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D291', 'B08', 'C06', '百香雙Q果', 'Fresh Passion Fruit with Bubble & Coconut Jelly', '綠茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D292', 'B08', 'C06', '百香綠茶', 'Passion Fruit Green Tea', '綠茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D293', 'B08', 'C05', '百香多多', 'Passion Fruit Yakult Tea', '果汁', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D294', 'B08', 'C06', '翡翠柳橙', 'Orange  Jasmine Green Tea', '綠茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D295', 'B08', 'C06', '粉粿冰萃檸檬', 'Lemonade With Red Ooling Jelly', '果汁', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D296', 'B08', 'C06', '冰萃檸檬', 'Lemonade', '果汁', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D297', 'B08', 'C06', '蜂蜜檸檬', 'Honey Lemonade', '果汁', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D298', 'B08', 'C06', '柚香翡翠茶', 'Grapefruit Jasmine Green Tea', '綠茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D299', 'B08', 'C03', '粉粿金萱', 'Jinhsuan Red Oolong Taiwanese Jelly', '青茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D300', 'B08', 'C03', '紅萱烏龍', 'Red Oolong Tea', '烏龍茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D301', 'B08', 'C03', '高山金萱', 'Alishan Jinhsuan Tea', '烏龍茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D302', 'B08', 'C03', '翡翠綠茶', 'Green Tea', '綠茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D303', 'B08', 'C03', '錫蘭紅茶', 'Ceylon Black Tea', '紅茶', '40');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D304', 'B08', 'C06', '蜜桃紅茶', 'Peach Black Tea', '紅茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D305', 'B08', 'C03', '紅萱雙Q', 'Red Oolong Tea with Bubble & Coconut Jelly', '烏龍茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D306', 'B08', 'C03', '金萱雙Q', 'Jinhsuan Tea with Bubble & Coconut Jelly', '烏龍茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D307', 'B08', 'C01', '錫蘭奶茶', 'Ceylon Milk Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D308', 'B08', 'C01', '波霸奶茶', 'Bubble Milk Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D309', 'B08', 'C01', '仙草凍奶茶', 'Grass Jelly Milk Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D310', 'B08', 'C01', '玫瑰奶茶', 'Rose Black Tea Latte', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D311', 'B08', 'C01', '阿華田', 'Ovaltine', '可可', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D312', 'B08', 'C02', '芝芝金萱茶', 'Jinhsuan Oolong Tea With Cheese Foam', '青茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D313', 'B08', 'C02', '芝芝錫蘭紅茶', 'Ceylon Black Tea  With Cheese Foam', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D314', 'B08', 'C02', '芝芝金萱雙Q', 'Jinhsuan Oolong Tea With Cheese Foam, Bubble & Coconut Jelly', '青茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D315', 'B08', 'C02', '芝芝翡翠綠茶', 'Jasmine Green Cheese Tea', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D316', 'B08', 'C02', '芝芝蜜桃紅茶', 'Peach Black Tea With Cheese Foam', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D317', 'B08', 'C02', '芝芝錫蘭奶茶', 'Ceylon Milk Tea  With Cheese Foam', '紅茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D318', 'B08', 'C02', '芝芝阿華田', 'Cheese Ovalttine', '可可', '80');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D319', 'B08', 'C03', '蕎麥綠寶石', 'Emerald Buckwheat Tea', '蕎麥茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D320', 'B08', 'C04', '粉粿紅茶拿鐵', 'Black Tea Latte with Red Oolong Taiwanese Jelly', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D321', 'B08', 'C04', '紅茶拿鐵', 'Black Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D322', 'B08', 'C04', '波霸紅茶拿鐵', 'Bubble Black Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D323', 'B08', 'C04', '仙草凍紅茶拿鐵', 'Grass Jelly Black Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D324', 'B08', 'C04', '阿華田拿鐵', 'Ovaltine Latte', '可可', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D325', 'B08', 'C04', '玫瑰紅茶拿鐵', 'Rose Black Tea Latte', '紅茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D326', 'B09', 'C03', '上宇林青茶', 'Highland Tea', '青茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D327', 'B09', 'C03', '上宇林紅茶', 'Black Tea', '紅茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D328', 'B09', 'C03', '三窨花綠茶', 'Green Tea', '綠茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D329', 'B09', 'C03', '蟲蝕烏龍茶', 'Oolong Tea', '烏龍茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D330', 'B09', 'C03', '東方美人', 'Oriental Beauty Tea', '烏龍茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D331', 'B09', 'C03', '紅龍茗茶', 'Oolong Black Tea', '烏龍茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D332', 'B09', 'C03', '綠龍茗茶', 'Oolong Green Tea', '烏龍茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D333', 'B09', 'C03', '青龍茗茶', 'Oolong Highland Tea', '烏龍茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D334', 'B09', 'C02', '雪浮奶紅茶', 'Black Tea with Cheese Foam', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D335', 'B09', 'C02', '雪浮奶綠茶', 'Green Tea with Cheese Foam', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D336', 'B09', 'C02', '雪浮奶青茶', 'Highland Tea with Cheese Foam', '青茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D337', 'B09', 'C02', '雪浮奶烏龍茶', 'Oolong Tea with Cheese Foam', '烏龍茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D338', 'B09', 'C02', '雪浮奶美人', 'Oriental Beauty Tea with Cheese Foam', '烏龍茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D339', 'B09', 'C04', '鼎極鮮奶茶', 'Signature Milk Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D340', 'B09', 'C04', '太極鮮奶茶', 'Black Tea Latte with Tapioca Ball & Bubble', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D341', 'B09', 'C04', '紅龍鮮奶茶', 'Oolong Milk Tea', '烏龍茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D342', 'B09', 'C04', '鐵觀音鮮奶茶', 'Iron Guanyin Milk Tea', '青茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D343', 'B09', 'C04', '鮮奶綠茶', 'Green Milk Tea', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D344', 'B09', 'C04', '鮮奶青茶', 'Highland Milk Tea', '青茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D345', 'B09', 'C04', '烏龍鮮奶茶', 'Oolong Milk Tea', '烏龍茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D346', 'B09', 'C04', '美人鮮奶茶', 'Oriental Beauty Milk Tea', '烏龍茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D347', 'B09', 'C04', '冬瓜鮮奶', 'White Gourd Milk Tea', '冬瓜茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D348', 'B09', 'C04', '冬瓜鮮奶茶', 'White Gourd with Milk Tea', '冬瓜茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D349', 'B09', 'C05', '冰淇淋鮮奶茶', 'Ice Cream Milk Tea', '紅茶', '80');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D350', 'B09', 'C04', '手工粉角鮮奶茶', 'Tapioca Ball Milk Tea', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D351', 'B09', 'C04', '仙草凍鮮奶茶', 'Grass Jelly Milk Tea', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D352', 'B09', 'C04', '椰果鮮奶茶', 'Coconut Jelly Milk Tea', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D353', 'B09', 'C04', '布丁鮮奶茶', 'Pudding Milk Tea', '紅茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D354', 'B09', 'C04', '珍珠鮮奶茶', 'Bubble Black Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D355', 'B09', 'C04', '茉莉綠茶凍鮮奶茶', 'Jasmine Green Jelly Milk Tea', '綠茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D356', 'B09', 'C04', '黑糖Q粿鮮奶茶', 'Brown Sugar Jelly Milk Tea', '紅茶', '80');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D357', 'B09', 'C04', '甘蔗拿鐵', 'Sugarcane Milk Tea', '青茶', '80');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D358', 'B09', 'C05', '黃金多多綠', 'Yakult Green Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D359', 'B09', 'C06', '梅香綠茶', 'Plum Green Tea', '綠茶', '50');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D360', 'B09', 'C06', '脆梅綠茶', 'Pickled Plum Green Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D361', 'B09', 'C03', '冬瓜茶', 'White Gourd Drink', '冬瓜茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D362', 'B09', 'C05', '冬瓜紅茶', 'White Gourd Black Tea', '紅茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D363', 'B09', 'C05', '冬瓜青茶', 'White Gourd Highland Tea', '青茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D364', 'B09', 'C05', '冬瓜綠茶', 'White Gourd Green Tea', '綠茶', '45');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D365', 'B09', 'C06', '冬瓜檸檬', 'White Gourd Lemon', '冬瓜茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D366', 'B09', 'C06', '檸檬紅茶', 'Black Tea Lemonade', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D367', 'B09', 'C06', '檸檬青茶', 'Highland Lemonade', '青茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D368', 'B09', 'C06', '檸檬綠茶', 'Green Tea Lemonade', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D369', 'B09', 'C06', '香橙青茶', 'Orange Highland  Tea', '青茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D370', 'B09', 'C06', '香橙綠茶', 'Orange Green Tea', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D371', 'B09', 'C06', '葡萄柚青', 'Grapefruit Highland Tea', '青茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D372', 'B09', 'C06', '葡萄柚綠茶', 'Grapefruit Green Tea', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D373', 'B09', 'C06', '蔓越莓紅茶', 'Cranberry Black Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D374', 'B09', 'C06', '蔓越莓青茶', 'Cranberry Highland Tea', '青茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D375', 'B09', 'C06', '蔓越莓綠茶', 'Cranberry Green Tea', '綠茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D376', 'B09', 'C06', '甘蔗紅茶', 'Sugarcane Black Tea', '紅茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D377', 'B09', 'C06', '甘蔗青茶', 'Sugarcane Highland Tea', '青茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D378', 'B09', 'C06', '甘蔗綠茶', 'Sugarcane Green Tea', '綠茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D379', 'B09', 'C06', '甘蔗烏龍茶', 'Sugarcane Oolong Tea', '烏龍茶', '60');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D380', 'B09', 'C06', '甘蔗柳橙', 'Sugarcane Orange', '綠茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D381', 'B09', 'C06', '甘蔗檸檬', 'Sugarcane Lemon', '果汁', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D382', 'B09', 'C06', '甘蔗蔓越莓', 'Sugarcane Cranberry', '綠茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D383', 'B09', 'C01', '泰式奶茶', 'Thai Milk Tea', '紅茶', '65');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D384', 'B10', 'C05', '綠豆沙牛奶', 'Mung Bean Milk Smoothie', '綠豆', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D385', 'B10', 'C05', '懷舊綠豆沙', 'Mung Bean Smoothie', '綠豆', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D386', 'B10', 'C05', '芋頭牛奶沙', 'Taro Milk Smoothie', '芋泥', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D387', 'B10', 'C04', '芋泥鮮奶紅', 'Taro Black Tea Latte', '芋泥', '90');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D388', 'B10', 'C04', '芋泥鮮奶綠', 'Taro Green Tea Latte', '芋泥', '90');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D389', 'B10', 'C04', '芋泥鮮奶青', 'Taro Highland Tea Latte', '芋泥', '90');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D390', 'B10', 'C05', '紫芋波波沙', 'Purple Taro Smoothie', '芋泥', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D391', 'B10', 'C05', '濃芋珍珠純鮮奶', 'Taro Fresh Milk with Bubbles', '芋泥', '90');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D392', 'B10', 'C05', '濃芋純鮮奶', 'Taro Milk', '芋泥', '90');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D393', 'B10', 'C04', '鮮奶紅茶', 'Black Tea Latte', '紅茶', '70');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D394', 'B10', 'C04', '鮮奶青茶', 'Four Seasons Tea Latte', '青茶', '75');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D395', 'B10', 'C04', '珍珠鮮奶紅茶', 'Bubble Black Tea Latte', '紅茶', '80');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D396', 'B10', 'C04', '珍珠鮮奶青茶', 'Bubble Four Seasons Tea Latte', '青茶', '85');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D397', 'B10', 'C01', '珍珠奶茶', 'Bubble Milk Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D398', 'B10', 'C01', '仙草凍奶茶', 'Grass Jelly Milk Tea', '紅茶', '55');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D399', 'B10', 'C03', '熟成紅茶', 'Aged Black Tea', '紅茶', '30');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D400', 'B10', 'C03', '茉香綠茶', 'Jasmine Green Tea', '綠茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D401', 'B10', 'C03', '四季青茶', 'Four Seasons Oolong Tea', '青茶', '35');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D402', 'B10', 'C03', '輕焙米香烏龍', 'Light-Oolong Tea', '烏龍茶', '30');
INSERT INTO `DRINK` (`drink_id`, `brand_id`, `category_id`, `drink_name`, `drink_eng_name`, `base_tea`, `price`) VALUES ('D403', 'B10', 'C05', '冬瓜青茶', 'White Gourd Highland Tea', '青茶', '35');

SET FOREIGN_KEY_CHECKS = 1;
-- 1. 環境準備
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE `DRINK_TOPPING`;

-- 2. 批量匯入所有資料
INSERT INTO `DRINK_TOPPING` (`drink_id`, `topping_id`) VALUES
('D001', 'T0103'), ('D001', 'T0104'), ('D001', 'T0105'), ('D001', 'T0110'), ('D001', 'T0112'),
('D002', 'T0103'), ('D002', 'T0104'), ('D002', 'T0105'), ('D002', 'T0110'), ('D002', 'T0112'),
('D003', 'T0103'), ('D003', 'T0104'), ('D003', 'T0105'), ('D003', 'T0110'), ('D003', 'T0112'),
('D004', 'T0103'), ('D004', 'T0104'), ('D004', 'T0105'), ('D004', 'T0110'), ('D004', 'T0112'),
('D005', 'T0103'), ('D005', 'T0104'), ('D005', 'T0105'), ('D005', 'T0110'), ('D005', 'T0112'),
('D006', 'T0103'), ('D006', 'T0104'), ('D006', 'T0105'), ('D006', 'T0110'), ('D006', 'T0112'),
('D007', 'T0103'), ('D007', 'T0104'), ('D007', 'T0105'), ('D007', 'T0110'), ('D007', 'T0112'),
('D008', 'T0103'), ('D008', 'T0104'), ('D008', 'T0105'), ('D008', 'T0110'), ('D008', 'T0112'),
('D009', 'T0103'), ('D009', 'T0104'), ('D009', 'T0105'), ('D009', 'T0110'), ('D009', 'T0112'),
('D010', 'T0103'), ('D010', 'T0104'), ('D010', 'T0105'), ('D010', 'T0110'), ('D010', 'T0112'),
('D011', 'T0103'), ('D011', 'T0104'), ('D011', 'T0105'), ('D011', 'T0110'), ('D011', 'T0112'),
('D012', 'T0103'), ('D012', 'T0104'), ('D012', 'T0105'), ('D012', 'T0110'), ('D012', 'T0112'),
('D013', 'T0103'), ('D013', 'T0104'), ('D013', 'T0105'), ('D013', 'T0110'), ('D013', 'T0112'),
('D014', 'T0103'), ('D014', 'T0104'), ('D014', 'T0105'), ('D014', 'T0110'), ('D014', 'T0112'),
('D015', 'T0103'), ('D015', 'T0104'), ('D015', 'T0105'), ('D015', 'T0110'), ('D015', 'T0112'),
('D016', 'T0103'), ('D016', 'T0104'), ('D016', 'T0105'), ('D016', 'T0110'), ('D016', 'T0112'),
('D017', 'T0103'), ('D017', 'T0104'), ('D017', 'T0105'), ('D017', 'T0110'), ('D017', 'T0112'),
('D018', 'T0103'), ('D018', 'T0104'), ('D018', 'T0105'), ('D018', 'T0110'), ('D018', 'T0112'),
('D019', 'T0103'), ('D019', 'T0104'), ('D019', 'T0105'), ('D019', 'T0110'), ('D019', 'T0112'),
('D020', 'T0103'), ('D020', 'T0104'), ('D020', 'T0105'), ('D020', 'T0110'), ('D020', 'T0112'),
('D021', 'T0103'), ('D021', 'T0104'), ('D021', 'T0105'), ('D021', 'T0110'), ('D021', 'T0112'),
('D022', 'T0103'), ('D022', 'T0104'), ('D022', 'T0105'), ('D022', 'T0110'), ('D022', 'T0112'),
('D023', 'T0103'), ('D023', 'T0104'), ('D023', 'T0105'), ('D023', 'T0110'), ('D023', 'T0112'),
('D024', 'T0103'), ('D024', 'T0104'), ('D024', 'T0105'), ('D024', 'T0110'), ('D024', 'T0112'),
('D025', 'T0103'), ('D025', 'T0104'), ('D025', 'T0105'), ('D025', 'T0110'), ('D025', 'T0112'),
('D026', 'T0103'), ('D026', 'T0104'), ('D026', 'T0105'), ('D026', 'T0110'), ('D026', 'T0112'),
('D027', 'T0103'), ('D027', 'T0104'), ('D027', 'T0105'), ('D027', 'T0110'), ('D027', 'T0112'),
('D028', 'T0103'), ('D028', 'T0104'), ('D028', 'T0105'), ('D028', 'T0110'), ('D028', 'T0112'),
('D029', 'T0103'), ('D029', 'T0104'), ('D029', 'T0105'), ('D029', 'T0110'), ('D029', 'T0112'),
('D030', 'T0103'), ('D030', 'T0104'), ('D030', 'T0105'), ('D030', 'T0110'), ('D030', 'T0112'),
('D031', 'T0103'), ('D031', 'T0104'), ('D031', 'T0105'), ('D031', 'T0110'), ('D031', 'T0112'),
('D032', 'T0103'), ('D032', 'T0104'), ('D032', 'T0105'), ('D032', 'T0110'), ('D032', 'T0112'),
('D033', 'T0103'), ('D033', 'T0104'), ('D033', 'T0105'), ('D033', 'T0110'), ('D033', 'T0112'),
('D034', 'T0103'), ('D034', 'T0104'), ('D034', 'T0105'), ('D034', 'T0110'), ('D034', 'T0112'),
('D035', 'T0103'), ('D035', 'T0104'), ('D035', 'T0105'), ('D035', 'T0110'), ('D035', 'T0112'),
('D036', 'T0103'), ('D036', 'T0104'), ('D036', 'T0105'), ('D036', 'T0110'), ('D036', 'T0112'),
('D037', 'T0103'), ('D037', 'T0104'), ('D037', 'T0105'), ('D037', 'T0110'), ('D037', 'T0112'),
('D038', 'T0103'), ('D038', 'T0104'), ('D038', 'T0105'), ('D038', 'T0110'), ('D038', 'T0112'),
('D039', 'T0103'), ('D039', 'T0104'), ('D039', 'T0105'), ('D039', 'T0110'), ('D039', 'T0112'),
('D040', 'T0103'), ('D040', 'T0104'), ('D040', 'T0105'), ('D040', 'T0110'), ('D040', 'T0112'),
('D041', 'T0103'), ('D041', 'T0104'), ('D041', 'T0105'), ('D041', 'T0110'), ('D041', 'T0112'),
('D042', 'T0103'), ('D042', 'T0104'), ('D042', 'T0105'), ('D042', 'T0110'), ('D042', 'T0112'),
('D043', 'T0103'), ('D043', 'T0104'), ('D043', 'T0105'), ('D043', 'T0110'), ('D043', 'T0112'),
('D044', 'T0103'), ('D044', 'T0104'), ('D044', 'T0105'), ('D044', 'T0110'), ('D044', 'T0112'),
('D045', 'T0103'), ('D045', 'T0104'), ('D045', 'T0105'), ('D045', 'T0110'), ('D045', 'T0112'),
('D046', 'T0103'), ('D046', 'T0104'), ('D046', 'T0105'), ('D046', 'T0110'), ('D046', 'T0112'),
('D047', 'T0103'), ('D047', 'T0104'), ('D047', 'T0105'), ('D047', 'T0110'), ('D047', 'T0112'),
('D048', 'T0103'), ('D048', 'T0104'), ('D048', 'T0105'), ('D048', 'T0110'), ('D048', 'T0112'),
('D049', 'T0103'), ('D049', 'T0104'), ('D049', 'T0105'), ('D049', 'T0110'), ('D049', 'T0112'),
('D050', 'T0103'), ('D050', 'T0104'), ('D050', 'T0105'), ('D050', 'T0110'), ('D050', 'T0112'),
('D051', 'T0103'), ('D051', 'T0104'), ('D051', 'T0105'), ('D051', 'T0110'), ('D051', 'T0112'),
('D052', 'T0201'), ('D052', 'T0203'), ('D052', 'T0205'), ('D052', 'T0206'), ('D052', 'T0208'), ('D052', 'T0210'),
('D053', 'T0201'), ('D053', 'T0203'), ('D053', 'T0205'), ('D053', 'T0206'), ('D053', 'T0208'), ('D053', 'T0210'),
('D054', 'T0201'), ('D054', 'T0203'), ('D054', 'T0205'), ('D054', 'T0206'), ('D054', 'T0208'), ('D054', 'T0210'),
('D055', 'T0201'), ('D055', 'T0203'), ('D055', 'T0205'), ('D055', 'T0206'), ('D055', 'T0208'), ('D055', 'T0210'),
('D056', 'T0201'), ('D056', 'T0203'), ('D056', 'T0205'), ('D056', 'T0206'), ('D056', 'T0208'), ('D056', 'T0210'),
('D057', 'T0201'), ('D057', 'T0203'), ('D057', 'T0205'), ('D057', 'T0206'), ('D057', 'T0208'), ('D057', 'T0210'),
('D058', 'T0201'), ('D058', 'T0203'), ('D058', 'T0205'), ('D058', 'T0206'), ('D058', 'T0208'), ('D058', 'T0210'),
('D059', 'T0201'), ('D059', 'T0203'), ('D059', 'T0205'), ('D059', 'T0206'), ('D059', 'T0208'), ('D059', 'T0210'),
('D060', 'T0201'), ('D060', 'T0203'), ('D060', 'T0205'), ('D060', 'T0206'), ('D060', 'T0208'), ('D060', 'T0210'),
('D061', 'T0201'), ('D061', 'T0203'), ('D061', 'T0205'), ('D061', 'T0206'), ('D061', 'T0208'), ('D061', 'T0210'),
('D062', 'T0201'), ('D062', 'T0203'), ('D062', 'T0205'), ('D062', 'T0206'), ('D062', 'T0208'), ('D062', 'T0210'),
('D063', 'T0201'), ('D063', 'T0203'), ('D063', 'T0205'), ('D063', 'T0206'), ('D063', 'T0208'), ('D063', 'T0210'),
('D064', 'T0201'), ('D064', 'T0203'), ('D064', 'T0205'), ('D064', 'T0206'), ('D064', 'T0208'), ('D064', 'T0210'),
('D065', 'T0201'), ('D065', 'T0203'), ('D065', 'T0205'), ('D065', 'T0206'), ('D065', 'T0208'), ('D065', 'T0210'),
('D066', 'T0201'), ('D066', 'T0203'), ('D066', 'T0205'), ('D066', 'T0206'), ('D066', 'T0208'), ('D066', 'T0210'),
('D067', 'T0201'), ('D067', 'T0203'), ('D067', 'T0205'), ('D067', 'T0206'), ('D067', 'T0208'), ('D067', 'T0210'),
('D068', 'T0201'), ('D068', 'T0203'), ('D068', 'T0205'), ('D068', 'T0206'), ('D068', 'T0208'), ('D068', 'T0210'),
('D069', 'T0201'), ('D069', 'T0203'), ('D069', 'T0205'), ('D069', 'T0206'), ('D069', 'T0208'), ('D069', 'T0210'),
('D070', 'T0201'), ('D070', 'T0203'), ('D070', 'T0205'), ('D070', 'T0206'), ('D070', 'T0208'), ('D070', 'T0210'),
('D071', 'T0201'), ('D071', 'T0203'), ('D071', 'T0205'), ('D071', 'T0206'), ('D071', 'T0208'), ('D071', 'T0210'),
('D072', 'T0201'), ('D072', 'T0203'), ('D072', 'T0205'), ('D072', 'T0206'), ('D072', 'T0208'), ('D072', 'T0210'),
('D073', 'T0201'), ('D073', 'T0203'), ('D073', 'T0205'), ('D073', 'T0206'), ('D073', 'T0208'), ('D073', 'T0210'),
('D074', 'T0201'), ('D074', 'T0203'), ('D074', 'T0205'), ('D074', 'T0206'), ('D074', 'T0208'), ('D074', 'T0210'),
('D075', 'T0201'), ('D075', 'T0203'), ('D075', 'T0205'), ('D075', 'T0206'), ('D075', 'T0208'), ('D075', 'T0210'),
('D076', 'T0201'), ('D076', 'T0203'), ('D076', 'T0205'), ('D076', 'T0206'), ('D076', 'T0208'), ('D076', 'T0210'),
('D077', 'T0201'), ('D077', 'T0203'), ('D077', 'T0205'), ('D077', 'T0206'), ('D077', 'T0208'), ('D077', 'T0210'),
('D078', 'T0201'), ('D078', 'T0203'), ('D078', 'T0205'), ('D078', 'T0206'), ('D078', 'T0208'), ('D078', 'T0210'),
('D079', 'T0201'), ('D079', 'T0203'), ('D079', 'T0205'), ('D079', 'T0206'), ('D079', 'T0208'), ('D079', 'T0210'),
('D080', 'T0201'), ('D080', 'T0203'), ('D080', 'T0205'), ('D080', 'T0206'), ('D080', 'T0208'), ('D080', 'T0210'),
('D081', 'T0201'), ('D081', 'T0203'), ('D081', 'T0205'), ('D081', 'T0206'), ('D081', 'T0208'), ('D081', 'T0210'),
('D082', 'T0201'), ('D082', 'T0203'), ('D082', 'T0205'), ('D082', 'T0206'), ('D082', 'T0208'), ('D082', 'T0210'),
('D083', 'T0201'), ('D083', 'T0203'), ('D083', 'T0205'), ('D083', 'T0206'), ('D083', 'T0208'), ('D083', 'T0210'),
('D084', 'T0201'), ('D084', 'T0203'), ('D084', 'T0205'), ('D084', 'T0206'), ('D084', 'T0208'), ('D084', 'T0210'),
('D085', 'T0201'), ('D085', 'T0203'), ('D085', 'T0205'), ('D085', 'T0206'), ('D085', 'T0208'), ('D085', 'T0210'),
('D086', 'T0201'), ('D086', 'T0203'), ('D086', 'T0205'), ('D086', 'T0206'), ('D086', 'T0208'), ('D086', 'T0210'),
('D087', 'T0201'), ('D087', 'T0203'), ('D087', 'T0205'), ('D087', 'T0206'), ('D087', 'T0208'), ('D087', 'T0210'),
('D088', 'T0201'), ('D088', 'T0203'), ('D088', 'T0205'), ('D088', 'T0206'), ('D088', 'T0208'), ('D088', 'T0210'),
('D089', 'T0301'), ('D089', 'T0303'), ('D089', 'T0305'), ('D089', 'T0308'), ('D089', 'T0310'),
('D090', 'T0301'), ('D090', 'T0303'), ('D090', 'T0305'), ('D090', 'T0308'), ('D090', 'T0310'),
('D091', 'T0301'), ('D091', 'T0303'), ('D091', 'T0305'), ('D091', 'T0308'), ('D091', 'T0310'),
('D092', 'T0301'), ('D092', 'T0303'), ('D092', 'T0305'), ('D092', 'T0308'), ('D092', 'T0310'),
('D093', 'T0301'), ('D093', 'T0303'), ('D093', 'T0305'), ('D093', 'T0308'), ('D093', 'T0310'),
('D094', 'T0301'), ('D094', 'T0303'), ('D094', 'T0305'), ('D094', 'T0308'), ('D094', 'T0310'),
('D095', 'T0301'), ('D095', 'T0303'), ('D095', 'T0305'), ('D095', 'T0308'), ('D095', 'T0310'),
('D096', 'T0301'), ('D096', 'T0303'), ('D096', 'T0305'), ('D096', 'T0308'), ('D096', 'T0310'),
('D097', 'T0301'), ('D097', 'T0303'), ('D097', 'T0305'), ('D097', 'T0308'), ('D097', 'T0310'),
('D098', 'T0301'), ('D098', 'T0303'), ('D098', 'T0305'), ('D098', 'T0308'), ('D098', 'T0310'),
('D099', 'T0301'), ('D099', 'T0303'), ('D099', 'T0305'), ('D099', 'T0308'), ('D099', 'T0310'),
('D100', 'T0301'), ('D100', 'T0303'), ('D100', 'T0305'), ('D100', 'T0308'), ('D100', 'T0310'),
('D101', 'T0301'), ('D101', 'T0303'), ('D101', 'T0305'), ('D101', 'T0308'), ('D101', 'T0310'),
('D102', 'T0301'), ('D102', 'T0303'), ('D102', 'T0305'), ('D102', 'T0308'), ('D102', 'T0310'),
('D103', 'T0301'), ('D103', 'T0303'), ('D103', 'T0305'), ('D103', 'T0308'), ('D103', 'T0310'),
('D104', 'T0301'), ('D104', 'T0303'), ('D104', 'T0305'), ('D104', 'T0308'), ('D104', 'T0310'),
('D105', 'T0301'), ('D105', 'T0303'), ('D105', 'T0305'), ('D105', 'T0308'), ('D105', 'T0310'),
('D106', 'T0301'), ('D106', 'T0303'), ('D106', 'T0305'), ('D106', 'T0308'), ('D106', 'T0310'),
('D107', 'T0301'), ('D107', 'T0303'), ('D107', 'T0305'), ('D107', 'T0308'), ('D107', 'T0310'),
('D108', 'T0301'), ('D108', 'T0303'), ('D108', 'T0305'), ('D108', 'T0308'), ('D108', 'T0310'),
('D109', 'T0301'), ('D109', 'T0303'), ('D109', 'T0305'), ('D109', 'T0308'), ('D109', 'T0310'),
('D110', 'T0301'), ('D110', 'T0303'), ('D110', 'T0305'), ('D110', 'T0308'), ('D110', 'T0310'),
('D111', 'T0301'), ('D111', 'T0303'), ('D111', 'T0305'), ('D111', 'T0308'), ('D111', 'T0310'),
('D112', 'T0301'), ('D112', 'T0303'), ('D112', 'T0305'), ('D112', 'T0308'), ('D112', 'T0310'),
('D113', 'T0301'), ('D113', 'T0303'), ('D113', 'T0305'), ('D113', 'T0308'), ('D113', 'T0310'),
('D114', 'T0301'), ('D114', 'T0303'), ('D114', 'T0305'), ('D114', 'T0308'), ('D114', 'T0310'),
('D115', 'T0301'), ('D115', 'T0303'), ('D115', 'T0305'), ('D115', 'T0308'), ('D115', 'T0310'),
('D116', 'T0301'), ('D116', 'T0303'), ('D116', 'T0305'), ('D116', 'T0308'), ('D116', 'T0310'),
('D117', 'T0301'), ('D117', 'T0303'), ('D117', 'T0305'), ('D117', 'T0308'), ('D117', 'T0310'),
('D118', 'T0301'), ('D118', 'T0303'), ('D118', 'T0305'), ('D118', 'T0308'), ('D118', 'T0310'),
('D119', 'T0301'), ('D119', 'T0303'), ('D119', 'T0305'), ('D119', 'T0308'), ('D119', 'T0310'),
('D120', 'T0301'), ('D120', 'T0303'), ('D120', 'T0305'), ('D120', 'T0308'), ('D120', 'T0310'),
('D121', 'T0301'), ('D121', 'T0303'), ('D121', 'T0305'), ('D121', 'T0308'), ('D121', 'T0310'),
('D122', 'T0301'), ('D122', 'T0303'), ('D122', 'T0305'), ('D122', 'T0308'), ('D122', 'T0310'),
('D123', 'T0301'), ('D123', 'T0303'), ('D123', 'T0305'), ('D123', 'T0308'), ('D123', 'T0310'),
('D124', 'T0301'), ('D124', 'T0303'), ('D124', 'T0305'), ('D124', 'T0308'), ('D124', 'T0310'),
('D125', 'T0301'), ('D125', 'T0303'), ('D125', 'T0305'), ('D125', 'T0308'), ('D125', 'T0310'),
('D126', 'T0301'), ('D126', 'T0303'), ('D126', 'T0305'), ('D126', 'T0308'), ('D126', 'T0310'),
('D127', 'T0301'), ('D127', 'T0303'), ('D127', 'T0305'), ('D127', 'T0308'), ('D127', 'T0310'),
('D128', 'T0301'), ('D128', 'T0303'), ('D128', 'T0305'), ('D128', 'T0308'), ('D128', 'T0310'),
('D129', 'T0301'), ('D129', 'T0303'), ('D129', 'T0305'), ('D129', 'T0308'), ('D129', 'T0310'),
('D130', 'T0301'), ('D130', 'T0303'), ('D130', 'T0305'), ('D130', 'T0308'), ('D130', 'T0310'),
('D131', 'T0401'), ('D131', 'T0405'), ('D131', 'T0407'), ('D131', 'T0408'), ('D131', 'T0409'),
('D132', 'T0401'), ('D132', 'T0405'), ('D132', 'T0407'), ('D132', 'T0408'), ('D132', 'T0409'),
('D133', 'T0401'), ('D133', 'T0405'), ('D133', 'T0407'), ('D133', 'T0408'), ('D133', 'T0409'),
('D134', 'T0401'), ('D134', 'T0405'), ('D134', 'T0407'), ('D134', 'T0408'), ('D134', 'T0409'),
('D135', 'T0401'), ('D135', 'T0405'), ('D135', 'T0407'), ('D135', 'T0408'), ('D135', 'T0409'),
('D136', 'T0401'), ('D136', 'T0405'), ('D136', 'T0407'), ('D136', 'T0408'), ('D136', 'T0409'),
('D137', 'T0401'), ('D137', 'T0405'), ('D137', 'T0407'), ('D137', 'T0408'), ('D137', 'T0409'),
('D138', 'T0401'), ('D138', 'T0405'), ('D138', 'T0407'), ('D138', 'T0408'), ('D138', 'T0409'),
('D139', 'T0401'), ('D139', 'T0405'), ('D139', 'T0407'), ('D139', 'T0408'), ('D139', 'T0409'),
('D140', 'T0401'), ('D140', 'T0405'), ('D140', 'T0407'), ('D140', 'T0408'), ('D140', 'T0409'),
('D141', 'T0401'), ('D141', 'T0405'), ('D141', 'T0407'), ('D141', 'T0408'), ('D141', 'T0409'),
('D142', 'T0401'), ('D142', 'T0405'), ('D142', 'T0407'), ('D142', 'T0408'), ('D142', 'T0409'),
('D143', 'T0401'), ('D143', 'T0405'), ('D143', 'T0407'), ('D143', 'T0408'), ('D143', 'T0409'),
('D144', 'T0401'), ('D144', 'T0405'), ('D144', 'T0407'), ('D144', 'T0408'), ('D144', 'T0409'),
('D145', 'T0401'), ('D145', 'T0405'), ('D145', 'T0407'), ('D145', 'T0408'), ('D145', 'T0409'),
('D146', 'T0401'), ('D146', 'T0405'), ('D146', 'T0407'), ('D146', 'T0408'), ('D146', 'T0409'),
('D147', 'T0401'), ('D147', 'T0405'), ('D147', 'T0407'), ('D147', 'T0408'), ('D147', 'T0409'),
('D148', 'T0401'), ('D148', 'T0405'), ('D148', 'T0407'), ('D148', 'T0408'), ('D148', 'T0409'),
('D149', 'T0401'), ('D149', 'T0405'), ('D149', 'T0407'), ('D149', 'T0408'), ('D149', 'T0409'),
('D150', 'T0401'), ('D150', 'T0405'), ('D150', 'T0407'), ('D150', 'T0408'), ('D150', 'T0409'),
('D151', 'T0401'), ('D151', 'T0405'), ('D151', 'T0407'), ('D151', 'T0408'), ('D151', 'T0409'),
('D152', 'T0401'), ('D152', 'T0405'), ('D152', 'T0407'), ('D152', 'T0408'), ('D152', 'T0409'),
('D153', 'T0401'), ('D153', 'T0405'), ('D153', 'T0407'), ('D153', 'T0408'), ('D153', 'T0409'),
('D154', 'T0401'), ('D154', 'T0405'), ('D154', 'T0407'), ('D154', 'T0408'), ('D154', 'T0409'),
('D155', 'T0401'), ('D155', 'T0405'), ('D155', 'T0407'), ('D155', 'T0408'), ('D155', 'T0409'),
('D156', 'T0401'), ('D156', 'T0405'), ('D156', 'T0407'), ('D156', 'T0408'), ('D156', 'T0409'),
('D157', 'T0401'), ('D157', 'T0405'), ('D157', 'T0407'), ('D157', 'T0408'), ('D157', 'T0409'),
('D158', 'T0401'), ('D158', 'T0405'), ('D158', 'T0407'), ('D158', 'T0408'), ('D158', 'T0409'),
('D159', 'T0401'), ('D159', 'T0405'), ('D159', 'T0407'), ('D159', 'T0408'), ('D159', 'T0409'),
('D160', 'T0401'), ('D160', 'T0405'), ('D160', 'T0407'), ('D160', 'T0408'), ('D160', 'T0409'),
('D161', 'T0401'), ('D161', 'T0405'), ('D161', 'T0407'), ('D161', 'T0408'), ('D161', 'T0409'),
('D162', 'T0401'), ('D162', 'T0405'), ('D162', 'T0407'), ('D162', 'T0408'), ('D162', 'T0409'),
('D163', 'T0401'), ('D163', 'T0405'), ('D163', 'T0407'), ('D163', 'T0408'), ('D163', 'T0409'),
('D164', 'T0401'), ('D164', 'T0405'), ('D164', 'T0407'), ('D164', 'T0408'), ('D164', 'T0409'),
('D165', 'T0401'), ('D165', 'T0405'), ('D165', 'T0407'), ('D165', 'T0408'), ('D165', 'T0409'),
('D166', 'T0401'), ('D166', 'T0405'), ('D166', 'T0407'), ('D166', 'T0408'), ('D166', 'T0409'),
('D167', 'T0401'), ('D167', 'T0405'), ('D167', 'T0407'), ('D167', 'T0408'), ('D167', 'T0409'),
('D168', 'T0401'), ('D168', 'T0405'), ('D168', 'T0407'), ('D168', 'T0408'), ('D168', 'T0409'),
('D169', 'T0505'), ('D169', 'T0508'), ('D169', 'T0509'),
('D170', 'T0505'), ('D170', 'T0508'), ('D170', 'T0509'),
('D171', 'T0505'), ('D171', 'T0508'), ('D171', 'T0509'),
('D172', 'T0505'), ('D172', 'T0508'), ('D172', 'T0509'),
('D173', 'T0505'), ('D173', 'T0508'), ('D173', 'T0509'),
('D174', 'T0505'), ('D174', 'T0508'), ('D174', 'T0509'),
('D175', 'T0505'), ('D175', 'T0508'), ('D175', 'T0509'),
('D176', 'T0505'), ('D176', 'T0508'), ('D176', 'T0509'),
('D177', 'T0505'), ('D177', 'T0508'), ('D177', 'T0509'),
('D178', 'T0505'), ('D178', 'T0508'), ('D178', 'T0509'),
('D179', 'T0505'), ('D179', 'T0508'), ('D179', 'T0509'),
('D180', 'T0505'), ('D180', 'T0508'), ('D180', 'T0509'),
('D181', 'T0505'), ('D181', 'T0508'), ('D181', 'T0509'),
('D182', 'T0505'), ('D182', 'T0508'), ('D182', 'T0509'),
('D183', 'T0505'), ('D183', 'T0508'), ('D183', 'T0509'),
('D184', 'T0505'), ('D184', 'T0508'), ('D184', 'T0509'),
('D185', 'T0505'), ('D185', 'T0508'), ('D185', 'T0509'),
('D186', 'T0505'), ('D186', 'T0508'), ('D186', 'T0509'),
('D187', 'T0505'), ('D187', 'T0508'), ('D187', 'T0509'),
('D188', 'T0505'), ('D188', 'T0508'), ('D188', 'T0509'),
('D189', 'T0505'), ('D189', 'T0508'), ('D189', 'T0509'),
('D190', 'T0505'), ('D190', 'T0508'), ('D190', 'T0509'),
('D191', 'T0505'), ('D191', 'T0508'), ('D191', 'T0509'),
('D192', 'T0505'), ('D192', 'T0508'), ('D192', 'T0509'),
('D193', 'T0505'), ('D193', 'T0508'), ('D193', 'T0509'),
('D194', 'T0505'), ('D194', 'T0508'), ('D194', 'T0509'),
('D195', 'T0505'), ('D195', 'T0508'), ('D195', 'T0509'),
('D196', 'T0505'), ('D196', 'T0508'), ('D196', 'T0509'),
('D197', 'T0505'), ('D197', 'T0508'), ('D197', 'T0509'),
('D198', 'T0505'), ('D198', 'T0508'), ('D198', 'T0509'),
('D199', 'T0505'), ('D199', 'T0508'), ('D199', 'T0509'),
('D200', 'T0505'), ('D200', 'T0508'), ('D200', 'T0509'),
('D201', 'T0505'), ('D201', 'T0508'), ('D201', 'T0509'),
('D202', 'T0505'), ('D202', 'T0508'), ('D202', 'T0509'),
('D203', 'T0505'), ('D203', 'T0508'), ('D203', 'T0509'),
('D204', 'T0505'), ('D204', 'T0508'), ('D204', 'T0509'),
('D205', 'T0602'), ('D205', 'T0605'), ('D205', 'T0607'),
('D206', 'T0602'), ('D206', 'T0605'), ('D206', 'T0607'),
('D207', 'T0602'), ('D207', 'T0605'), ('D207', 'T0607'),
('D208', 'T0602'), ('D208', 'T0605'), ('D208', 'T0607'),
('D209', 'T0602'), ('D209', 'T0605'), ('D209', 'T0607'),
('D210', 'T0602'), ('D210', 'T0605'), ('D210', 'T0607'),
('D211', 'T0602'), ('D211', 'T0605'), ('D211', 'T0607'),
('D212', 'T0602'), ('D212', 'T0605'), ('D212', 'T0607'),
('D213', 'T0602'), ('D213', 'T0605'), ('D213', 'T0607'),
('D214', 'T0602'), ('D214', 'T0605'), ('D214', 'T0607'),
('D215', 'T0602'), ('D215', 'T0605'), ('D215', 'T0607'),
('D216', 'T0602'), ('D216', 'T0605'), ('D216', 'T0607'),
('D217', 'T0602'), ('D217', 'T0605'), ('D217', 'T0607'),
('D218', 'T0602'), ('D218', 'T0605'), ('D218', 'T0607'),
('D219', 'T0602'), ('D219', 'T0605'), ('D219', 'T0607'),
('D220', 'T0602'), ('D220', 'T0605'), ('D220', 'T0607'),
('D221', 'T0602'), ('D221', 'T0605'), ('D221', 'T0607'),
('D222', 'T0602'), ('D222', 'T0605'), ('D222', 'T0607'),
('D223', 'T0602'), ('D223', 'T0605'), ('D223', 'T0607'),
('D224', 'T0602'), ('D224', 'T0605'), ('D224', 'T0607'),
('D225', 'T0602'), ('D225', 'T0605'), ('D225', 'T0607'),
('D226', 'T0602'), ('D226', 'T0605'), ('D226', 'T0607'),
('D227', 'T0602'), ('D227', 'T0605'), ('D227', 'T0607'),
('D228', 'T0602'), ('D228', 'T0605'), ('D228', 'T0607'),
('D229', 'T0602'), ('D229', 'T0605'), ('D229', 'T0607'),
('D230', 'T0602'), ('D230', 'T0605'), ('D230', 'T0607'),
('D231', 'T0602'), ('D231', 'T0605'), ('D231', 'T0607'),
('D232', 'T0602'), ('D232', 'T0605'), ('D232', 'T0607'),
('D233', 'T0602'), ('D233', 'T0605'), ('D233', 'T0607'),
('D234', 'T0602'), ('D234', 'T0605'), ('D234', 'T0607'),
('D235', 'T0602'), ('D235', 'T0605'), ('D235', 'T0607'),
('D236', 'T0602'), ('D236', 'T0605'), ('D236', 'T0607'),
('D237', 'T0602'), ('D237', 'T0605'), ('D237', 'T0607'),
('D238', 'T0602'), ('D238', 'T0605'), ('D238', 'T0607'),
('D239', 'T0602'), ('D239', 'T0605'), ('D239', 'T0607'),
('D240', 'T0602'), ('D240', 'T0605'), ('D240', 'T0607'),
('D241', 'T0602'), ('D241', 'T0605'), ('D241', 'T0607'),
('D242', 'T0602'), ('D242', 'T0605'), ('D242', 'T0607'),
('D243', 'T0602'), ('D243', 'T0605'), ('D243', 'T0607'),
('D244', 'T0602'), ('D244', 'T0605'), ('D244', 'T0607'),
('D245', 'T0602'), ('D245', 'T0605'), ('D245', 'T0607'),
('D246', 'T0602'), ('D246', 'T0605'), ('D246', 'T0607'),
('D247', 'T0602'), ('D247', 'T0605'), ('D247', 'T0607'),
('D248', 'T0602'), ('D248', 'T0605'), ('D248', 'T0607'),
('D249', 'T0701'), ('D249', 'T0702'), ('D249', 'T0705'), ('D249', 'T0707'), ('D249', 'T0708'),
('D250', 'T0701'), ('D250', 'T0702'), ('D250', 'T0705'), ('D250', 'T0707'), ('D250', 'T0708'),
('D251', 'T0701'), ('D251', 'T0702'), ('D251', 'T0705'), ('D251', 'T0707'), ('D251', 'T0708'),
('D252', 'T0701'), ('D252', 'T0702'), ('D252', 'T0705'), ('D252', 'T0707'), ('D252', 'T0708'),
('D253', 'T0701'), ('D253', 'T0702'), ('D253', 'T0705'), ('D253', 'T0707'), ('D253', 'T0708'),
('D254', 'T0701'), ('D254', 'T0702'), ('D254', 'T0705'), ('D254', 'T0707'), ('D254', 'T0708'),
('D255', 'T0701'), ('D255', 'T0702'), ('D255', 'T0705'), ('D255', 'T0707'), ('D255', 'T0708'),
('D256', 'T0701'), ('D256', 'T0702'), ('D256', 'T0705'), ('D256', 'T0707'), ('D256', 'T0708'),
('D257', 'T0701'), ('D257', 'T0702'), ('D257', 'T0705'), ('D257', 'T0707'), ('D257', 'T0708'),
('D258', 'T0701'), ('D258', 'T0702'), ('D258', 'T0705'), ('D258', 'T0707'), ('D258', 'T0708'),
('D259', 'T0701'), ('D259', 'T0702'), ('D259', 'T0705'), ('D259', 'T0707'), ('D259', 'T0708'),
('D260', 'T0701'), ('D260', 'T0702'), ('D260', 'T0705'), ('D260', 'T0707'), ('D260', 'T0708'),
('D261', 'T0701'), ('D261', 'T0702'), ('D261', 'T0705'), ('D261', 'T0707'), ('D261', 'T0708'),
('D262', 'T0701'), ('D262', 'T0702'), ('D262', 'T0705'), ('D262', 'T0707'), ('D262', 'T0708'),
('D263', 'T0701'), ('D263', 'T0702'), ('D263', 'T0705'), ('D263', 'T0707'), ('D263', 'T0708'),
('D264', 'T0701'), ('D264', 'T0702'), ('D264', 'T0705'), ('D264', 'T0707'), ('D264', 'T0708'),
('D265', 'T0701'), ('D265', 'T0702'), ('D265', 'T0705'), ('D265', 'T0707'), ('D265', 'T0708'),
('D266', 'T0701'), ('D266', 'T0702'), ('D266', 'T0705'), ('D266', 'T0707'), ('D266', 'T0708'),
('D267', 'T0701'), ('D267', 'T0702'), ('D267', 'T0705'), ('D267', 'T0707'), ('D267', 'T0708'),
('D268', 'T0701'), ('D268', 'T0702'), ('D268', 'T0705'), ('D268', 'T0707'), ('D268', 'T0708'),
('D269', 'T0701'), ('D269', 'T0702'), ('D269', 'T0705'), ('D269', 'T0707'), ('D269', 'T0708'),
('D270', 'T0701'), ('D270', 'T0702'), ('D270', 'T0705'), ('D270', 'T0707'), ('D270', 'T0708'),
('D271', 'T0701'), ('D271', 'T0702'), ('D271', 'T0705'), ('D271', 'T0707'), ('D271', 'T0708'),
('D272', 'T0701'), ('D272', 'T0702'), ('D272', 'T0705'), ('D272', 'T0707'), ('D272', 'T0708'),
('D273', 'T0701'), ('D273', 'T0702'), ('D273', 'T0705'), ('D273', 'T0707'), ('D273', 'T0708'),
('D274', 'T0701'), ('D274', 'T0702'), ('D274', 'T0705'), ('D274', 'T0707'), ('D274', 'T0708'),
('D275', 'T0701'), ('D275', 'T0702'), ('D275', 'T0705'), ('D275', 'T0707'), ('D275', 'T0708'),
('D276', 'T0701'), ('D276', 'T0702'), ('D276', 'T0705'), ('D276', 'T0707'), ('D276', 'T0708'),
('D277', 'T0701'), ('D277', 'T0702'), ('D277', 'T0705'), ('D277', 'T0707'), ('D277', 'T0708'),
('D278', 'T0701'), ('D278', 'T0702'), ('D278', 'T0705'), ('D278', 'T0707'), ('D278', 'T0708'),
('D279', 'T0701'), ('D279', 'T0702'), ('D279', 'T0705'), ('D279', 'T0707'), ('D279', 'T0708'),
('D280', 'T0701'), ('D280', 'T0702'), ('D280', 'T0705'), ('D280', 'T0707'), ('D280', 'T0708'),
('D281', 'T0701'), ('D281', 'T0702'), ('D281', 'T0705'), ('D281', 'T0707'), ('D281', 'T0708'),
('D282', 'T0701'), ('D282', 'T0702'), ('D282', 'T0705'), ('D282', 'T0707'), ('D282', 'T0708'),
('D283', 'T0701'), ('D283', 'T0702'), ('D283', 'T0705'), ('D283', 'T0707'), ('D283', 'T0708'),
('D284', 'T0801'), ('D284', 'T0802'), ('D284', 'T0805'), ('D284', 'T0807'), ('D284', 'T0808'), ('D284', 'T0810'), ('D284', 'T0811'),
('D285', 'T0801'), ('D285', 'T0802'), ('D285', 'T0805'), ('D285', 'T0807'), ('D285', 'T0808'), ('D285', 'T0810'), ('D285', 'T0811'),
('D286', 'T0801'), ('D286', 'T0802'), ('D286', 'T0805'), ('D286', 'T0807'), ('D286', 'T0808'), ('D286', 'T0810'), ('D286', 'T0811'),
('D287', 'T0801'), ('D287', 'T0802'), ('D287', 'T0805'), ('D287', 'T0807'), ('D287', 'T0808'), ('D287', 'T0810'), ('D287', 'T0811'),
('D288', 'T0801'), ('D288', 'T0802'), ('D288', 'T0805'), ('D288', 'T0807'), ('D288', 'T0808'), ('D288', 'T0810'), ('D288', 'T0811'),
('D289', 'T0801'), ('D289', 'T0802'), ('D289', 'T0805'), ('D289', 'T0807'), ('D289', 'T0808'), ('D289', 'T0810'), ('D289', 'T0811'),
('D290', 'T0801'), ('D290', 'T0802'), ('D290', 'T0805'), ('D290', 'T0807'), ('D290', 'T0808'), ('D290', 'T0810'), ('D290', 'T0811'),
('D291', 'T0801'), ('D291', 'T0802'), ('D291', 'T0805'), ('D291', 'T0807'), ('D291', 'T0808'), ('D291', 'T0810'), ('D291', 'T0811'),
('D292', 'T0801'), ('D292', 'T0802'), ('D292', 'T0805'), ('D292', 'T0807'), ('D292', 'T0808'), ('D292', 'T0810'), ('D292', 'T0811'),
('D293', 'T0801'), ('D293', 'T0802'), ('D293', 'T0805'), ('D293', 'T0807'), ('D293', 'T0808'), ('D293', 'T0810'), ('D293', 'T0811'),
('D294', 'T0801'), ('D294', 'T0802'), ('D294', 'T0805'), ('D294', 'T0807'), ('D294', 'T0808'), ('D294', 'T0810'), ('D294', 'T0811'),
('D295', 'T0801'), ('D295', 'T0802'), ('D295', 'T0805'), ('D295', 'T0807'), ('D295', 'T0808'), ('D295', 'T0810'), ('D295', 'T0811'),
('D296', 'T0801'), ('D296', 'T0802'), ('D296', 'T0805'), ('D296', 'T0807'), ('D296', 'T0808'), ('D296', 'T0810'), ('D296', 'T0811'),
('D297', 'T0801'), ('D297', 'T0802'), ('D297', 'T0805'), ('D297', 'T0807'), ('D297', 'T0808'), ('D297', 'T0810'), ('D297', 'T0811'),
('D298', 'T0801'), ('D298', 'T0802'), ('D298', 'T0805'), ('D298', 'T0807'), ('D298', 'T0808'), ('D298', 'T0810'), ('D298', 'T0811'),
('D299', 'T0801'), ('D299', 'T0802'), ('D299', 'T0805'), ('D299', 'T0807'), ('D299', 'T0808'), ('D299', 'T0810'), ('D299', 'T0811'),
('D300', 'T0801'), ('D300', 'T0802'), ('D300', 'T0805'), ('D300', 'T0807'), ('D300', 'T0808'), ('D300', 'T0810'), ('D300', 'T0811'),
('D301', 'T0801'), ('D301', 'T0802'), ('D301', 'T0805'), ('D301', 'T0807'), ('D301', 'T0808'), ('D301', 'T0810'), ('D301', 'T0811'),
('D302', 'T0801'), ('D302', 'T0802'), ('D302', 'T0805'), ('D302', 'T0807'), ('D302', 'T0808'), ('D302', 'T0810'), ('D302', 'T0811'),
('D303', 'T0801'), ('D303', 'T0802'), ('D303', 'T0805'), ('D303', 'T0807'), ('D303', 'T0808'), ('D303', 'T0810'), ('D303', 'T0811'),
('D304', 'T0801'), ('D304', 'T0802'), ('D304', 'T0805'), ('D304', 'T0807'), ('D304', 'T0808'), ('D304', 'T0810'), ('D304', 'T0811'),
('D305', 'T0801'), ('D305', 'T0802'), ('D305', 'T0805'), ('D305', 'T0807'), ('D305', 'T0808'), ('D305', 'T0810'), ('D305', 'T0811'),
('D306', 'T0801'), ('D306', 'T0802'), ('D306', 'T0805'), ('D306', 'T0807'), ('D306', 'T0808'), ('D306', 'T0810'), ('D306', 'T0811'),
('D307', 'T0801'), ('D307', 'T0802'), ('D307', 'T0805'), ('D307', 'T0807'), ('D307', 'T0808'), ('D307', 'T0810'), ('D307', 'T0811'),
('D308', 'T0801'), ('D308', 'T0802'), ('D308', 'T0805'), ('D308', 'T0807'), ('D308', 'T0808'), ('D308', 'T0810'), ('D308', 'T0811'),
('D309', 'T0801'), ('D309', 'T0802'), ('D309', 'T0805'), ('D309', 'T0807'), ('D309', 'T0808'), ('D309', 'T0810'), ('D309', 'T0811'),
('D310', 'T0801'), ('D310', 'T0802'), ('D310', 'T0805'), ('D310', 'T0807'), ('D310', 'T0808'), ('D310', 'T0810'), ('D310', 'T0811'),
('D311', 'T0801'), ('D311', 'T0802'), ('D311', 'T0805'), ('D311', 'T0807'), ('D311', 'T0808'), ('D311', 'T0810'), ('D311', 'T0811'),
('D312', 'T0801'), ('D312', 'T0802'), ('D312', 'T0805'), ('D312', 'T0807'), ('D312', 'T0808'), ('D312', 'T0810'), ('D312', 'T0811'),
('D313', 'T0801'), ('D313', 'T0802'), ('D313', 'T0805'), ('D313', 'T0807'), ('D313', 'T0808'), ('D313', 'T0810'), ('D313', 'T0811'),
('D314', 'T0801'), ('D314', 'T0802'), ('D314', 'T0805'), ('D314', 'T0807'), ('D314', 'T0808'), ('D314', 'T0810'), ('D314', 'T0811'),
('D315', 'T0801'), ('D315', 'T0802'), ('D315', 'T0805'), ('D315', 'T0807'), ('D315', 'T0808'), ('D315', 'T0810'), ('D315', 'T0811'),
('D316', 'T0801'), ('D316', 'T0802'), ('D316', 'T0805'), ('D316', 'T0807'), ('D316', 'T0808'), ('D316', 'T0810'), ('D316', 'T0811'),
('D317', 'T0801'), ('D317', 'T0802'), ('D317', 'T0805'), ('D317', 'T0807'), ('D317', 'T0808'), ('D317', 'T0810'), ('D317', 'T0811'),
('D318', 'T0801'), ('D318', 'T0802'), ('D318', 'T0805'), ('D318', 'T0807'), ('D318', 'T0808'), ('D318', 'T0810'), ('D318', 'T0811'),
('D319', 'T0801'), ('D319', 'T0802'), ('D319', 'T0805'), ('D319', 'T0807'), ('D319', 'T0808'), ('D319', 'T0810'), ('D319', 'T0811'),
('D320', 'T0801'), ('D320', 'T0802'), ('D320', 'T0805'), ('D320', 'T0807'), ('D320', 'T0808'), ('D320', 'T0810'), ('D320', 'T0811'),
('D321', 'T0801'), ('D321', 'T0802'), ('D321', 'T0805'), ('D321', 'T0807'), ('D321', 'T0808'), ('D321', 'T0810'), ('D321', 'T0811'),
('D322', 'T0801'), ('D322', 'T0802'), ('D322', 'T0805'), ('D322', 'T0807'), ('D322', 'T0808'), ('D322', 'T0810'), ('D322', 'T0811'),
('D323', 'T0801'), ('D323', 'T0802'), ('D323', 'T0805'), ('D323', 'T0807'), ('D323', 'T0808'), ('D323', 'T0810'), ('D323', 'T0811'),
('D324', 'T0801'), ('D324', 'T0802'), ('D324', 'T0805'), ('D324', 'T0807'), ('D324', 'T0808'), ('D324', 'T0810'), ('D324', 'T0811'),
('D325', 'T0801'), ('D325', 'T0802'), ('D325', 'T0805'), ('D325', 'T0807'), ('D325', 'T0808'), ('D325', 'T0810'), ('D325', 'T0811'),
('D326', 'T0901'), ('D326', 'T0903'), ('D326', 'T0904'), ('D326', 'T0905'), ('D326', 'T0906'), ('D326', 'T0907'), ('D326', 'T0908'), ('D326', 'T0910'), ('D326', 'T0911'),
('D327', 'T0901'), ('D327', 'T0903'), ('D327', 'T0904'), ('D327', 'T0905'), ('D327', 'T0906'), ('D327', 'T0907'), ('D327', 'T0908'), ('D327', 'T0910'), ('D327', 'T0911'),
('D328', 'T0901'), ('D328', 'T0903'), ('D328', 'T0904'), ('D328', 'T0905'), ('D328', 'T0906'), ('D328', 'T0907'), ('D328', 'T0908'), ('D328', 'T0910'), ('D328', 'T0911'),
('D329', 'T0901'), ('D329', 'T0903'), ('D329', 'T0904'), ('D329', 'T0905'), ('D329', 'T0906'), ('D329', 'T0907'), ('D329', 'T0908'), ('D329', 'T0910'), ('D329', 'T0911'),
('D330', 'T0901'), ('D330', 'T0903'), ('D330', 'T0904'), ('D330', 'T0905'), ('D330', 'T0906'), ('D330', 'T0907'), ('D330', 'T0908'), ('D330', 'T0910'), ('D330', 'T0911'),
('D331', 'T0901'), ('D331', 'T0903'), ('D331', 'T0904'), ('D331', 'T0905'), ('D331', 'T0906'), ('D331', 'T0907'), ('D331', 'T0908'), ('D331', 'T0910'), ('D331', 'T0911'),
('D332', 'T0901'), ('D332', 'T0903'), ('D332', 'T0904'), ('D332', 'T0905'), ('D332', 'T0906'), ('D332', 'T0907'), ('D332', 'T0908'), ('D332', 'T0910'), ('D332', 'T0911'),
('D333', 'T0901'), ('D333', 'T0903'), ('D333', 'T0904'), ('D333', 'T0905'), ('D333', 'T0906'), ('D333', 'T0907'), ('D333', 'T0908'), ('D333', 'T0910'), ('D333', 'T0911'),
('D334', 'T0901'), ('D334', 'T0903'), ('D334', 'T0904'), ('D334', 'T0905'), ('D334', 'T0906'), ('D334', 'T0907'), ('D334', 'T0908'), ('D334', 'T0910'), ('D334', 'T0911'),
('D335', 'T0901'), ('D335', 'T0903'), ('D335', 'T0904'), ('D335', 'T0905'), ('D335', 'T0906'), ('D335', 'T0907'), ('D335', 'T0908'), ('D335', 'T0910'), ('D335', 'T0911'),
('D336', 'T0901'), ('D336', 'T0903'), ('D336', 'T0904'), ('D336', 'T0905'), ('D336', 'T0906'), ('D336', 'T0907'), ('D336', 'T0908'), ('D336', 'T0910'), ('D336', 'T0911'),
('D337', 'T0901'), ('D337', 'T0903'), ('D337', 'T0904'), ('D337', 'T0905'), ('D337', 'T0906'), ('D337', 'T0907'), ('D337', 'T0908'), ('D337', 'T0910'), ('D337', 'T0911'),
('D338', 'T0901'), ('D338', 'T0903'), ('D338', 'T0904'), ('D338', 'T0905'), ('D338', 'T0906'), ('D338', 'T0907'), ('D338', 'T0908'), ('D338', 'T0910'), ('D338', 'T0911'),
('D339', 'T0901'), ('D339', 'T0903'), ('D339', 'T0904'), ('D339', 'T0905'), ('D339', 'T0906'), ('D339', 'T0907'), ('D339', 'T0908'), ('D339', 'T0910'), ('D339', 'T0911'),
('D340', 'T0901'), ('D340', 'T0903'), ('D340', 'T0904'), ('D340', 'T0905'), ('D340', 'T0906'), ('D340', 'T0907'), ('D340', 'T0908'), ('D340', 'T0910'), ('D340', 'T0911'),
('D341', 'T0901'), ('D341', 'T0903'), ('D341', 'T0904'), ('D341', 'T0905'), ('D341', 'T0906'), ('D341', 'T0907'), ('D341', 'T0908'), ('D341', 'T0910'), ('D341', 'T0911'),
('D342', 'T0901'), ('D342', 'T0903'), ('D342', 'T0904'), ('D342', 'T0905'), ('D342', 'T0906'), ('D342', 'T0907'), ('D342', 'T0908'), ('D342', 'T0910'), ('D342', 'T0911'),
('D343', 'T0901'), ('D343', 'T0903'), ('D343', 'T0904'), ('D343', 'T0905'), ('D343', 'T0906'), ('D343', 'T0907'), ('D343', 'T0908'), ('D343', 'T0910'), ('D343', 'T0911'),
('D344', 'T0901'), ('D344', 'T0903'), ('D344', 'T0904'), ('D344', 'T0905'), ('D344', 'T0906'), ('D344', 'T0907'), ('D344', 'T0908'), ('D344', 'T0910'), ('D344', 'T0911'),
('D345', 'T0901'), ('D345', 'T0903'), ('D345', 'T0904'), ('D345', 'T0905'), ('D345', 'T0906'), ('D345', 'T0907'), ('D345', 'T0908'), ('D345', 'T0910'), ('D345', 'T0911'),
('D346', 'T0901'), ('D346', 'T0903'), ('D346', 'T0904'), ('D346', 'T0905'), ('D346', 'T0906'), ('D346', 'T0907'), ('D346', 'T0908'), ('D346', 'T0910'), ('D346', 'T0911'),
('D347', 'T0901'), ('D347', 'T0903'), ('D347', 'T0904'), ('D347', 'T0905'), ('D347', 'T0906'), ('D347', 'T0907'), ('D347', 'T0908'), ('D347', 'T0910'), ('D347', 'T0911'),
('D348', 'T0901'), ('D348', 'T0903'), ('D348', 'T0904'), ('D348', 'T0905'), ('D348', 'T0906'), ('D348', 'T0907'), ('D348', 'T0908'), ('D348', 'T0910'), ('D348', 'T0911'),
('D349', 'T0901'), ('D349', 'T0903'), ('D349', 'T0904'), ('D349', 'T0905'), ('D349', 'T0906'), ('D349', 'T0907'), ('D349', 'T0908'), ('D349', 'T0910'), ('D349', 'T0911'),
('D350', 'T0901'), ('D350', 'T0903'), ('D350', 'T0904'), ('D350', 'T0905'), ('D350', 'T0906'), ('D350', 'T0907'), ('D350', 'T0908'), ('D350', 'T0910'), ('D350', 'T0911'),
('D351', 'T0901'), ('D351', 'T0903'), ('D351', 'T0904'), ('D351', 'T0905'), ('D351', 'T0906'), ('D351', 'T0907'), ('D351', 'T0908'), ('D351', 'T0910'), ('D351', 'T0911'),
('D352', 'T0901'), ('D352', 'T0903'), ('D352', 'T0904'), ('D352', 'T0905'), ('D352', 'T0906'), ('D352', 'T0907'), ('D352', 'T0908'), ('D352', 'T0910'), ('D352', 'T0911'),
('D353', 'T0901'), ('D353', 'T0903'), ('D353', 'T0904'), ('D353', 'T0905'), ('D353', 'T0906'), ('D353', 'T0907'), ('D353', 'T0908'), ('D353', 'T0910'), ('D353', 'T0911'),
('D354', 'T0901'), ('D354', 'T0903'), ('D354', 'T0904'), ('D354', 'T0905'), ('D354', 'T0906'), ('D354', 'T0907'), ('D354', 'T0908'), ('D354', 'T0910'), ('D354', 'T0911'),
('D355', 'T0901'), ('D355', 'T0903'), ('D355', 'T0904'), ('D355', 'T0905'), ('D355', 'T0906'), ('D355', 'T0907'), ('D355', 'T0908'), ('D355', 'T0910'), ('D355', 'T0911'),
('D356', 'T0901'), ('D356', 'T0903'), ('D356', 'T0904'), ('D356', 'T0905'), ('D356', 'T0906'), ('D356', 'T0907'), ('D356', 'T0908'), ('D356', 'T0910'), ('D356', 'T0911'),
('D357', 'T0901'), ('D357', 'T0903'), ('D357', 'T0904'), ('D357', 'T0905'), ('D357', 'T0906'), ('D357', 'T0907'), ('D357', 'T0908'), ('D357', 'T0910'), ('D357', 'T0911'),
('D358', 'T0901'), ('D358', 'T0903'), ('D358', 'T0904'), ('D358', 'T0905'), ('D358', 'T0906'), ('D358', 'T0907'), ('D358', 'T0908'), ('D358', 'T0910'), ('D358', 'T0911'),
('D359', 'T0901'), ('D359', 'T0903'), ('D359', 'T0904'), ('D359', 'T0905'), ('D359', 'T0906'), ('D359', 'T0907'), ('D359', 'T0908'), ('D359', 'T0910'), ('D359', 'T0911'),
('D360', 'T0901'), ('D360', 'T0903'), ('D360', 'T0904'), ('D360', 'T0905'), ('D360', 'T0906'), ('D360', 'T0907'), ('D360', 'T0908'), ('D360', 'T0910'), ('D360', 'T0911'),
('D361', 'T0901'), ('D361', 'T0903'), ('D361', 'T0904'), ('D361', 'T0905'), ('D361', 'T0906'), ('D361', 'T0907'), ('D361', 'T0908'), ('D361', 'T0910'), ('D361', 'T0911'),
('D362', 'T0901'), ('D362', 'T0903'), ('D362', 'T0904'), ('D362', 'T0905'), ('D362', 'T0906'), ('D362', 'T0907'), ('D362', 'T0908'), ('D362', 'T0910'), ('D362', 'T0911'),
('D363', 'T0901'), ('D363', 'T0903'), ('D363', 'T0904'), ('D363', 'T0905'), ('D363', 'T0906'), ('D363', 'T0907'), ('D363', 'T0908'), ('D363', 'T0910'), ('D363', 'T0911'),
('D364', 'T0901'), ('D364', 'T0903'), ('D364', 'T0904'), ('D364', 'T0905'), ('D364', 'T0906'), ('D364', 'T0907'), ('D364', 'T0908'), ('D364', 'T0910'), ('D364', 'T0911'),
('D365', 'T0901'), ('D365', 'T0903'), ('D365', 'T0904'), ('D365', 'T0905'), ('D365', 'T0906'), ('D365', 'T0907'), ('D365', 'T0908'), ('D365', 'T0910'), ('D365', 'T0911'),
('D366', 'T0901'), ('D366', 'T0903'), ('D366', 'T0904'), ('D366', 'T0905'), ('D366', 'T0906'), ('D366', 'T0907'), ('D366', 'T0908'), ('D366', 'T0910'), ('D366', 'T0911'),
('D367', 'T0901'), ('D367', 'T0903'), ('D367', 'T0904'), ('D367', 'T0905'), ('D367', 'T0906'), ('D367', 'T0907'), ('D367', 'T0908'), ('D367', 'T0910'), ('D367', 'T0911'),
('D368', 'T0901'), ('D368', 'T0903'), ('D368', 'T0904'), ('D368', 'T0905'), ('D368', 'T0906'), ('D368', 'T0907'), ('D368', 'T0908'), ('D368', 'T0910'), ('D368', 'T0911'),
('D369', 'T0901'), ('D369', 'T0903'), ('D369', 'T0904'), ('D369', 'T0905'), ('D369', 'T0906'), ('D369', 'T0907'), ('D369', 'T0908'), ('D369', 'T0910'), ('D369', 'T0911'),
('D370', 'T0901'), ('D370', 'T0903'), ('D370', 'T0904'), ('D370', 'T0905'), ('D370', 'T0906'), ('D370', 'T0907'), ('D370', 'T0908'), ('D370', 'T0910'), ('D370', 'T0911'),
('D371', 'T0901'), ('D371', 'T0903'), ('D371', 'T0904'), ('D371', 'T0905'), ('D371', 'T0906'), ('D371', 'T0907'), ('D371', 'T0908'), ('D371', 'T0910'), ('D371', 'T0911'),
('D372', 'T0901'), ('D372', 'T0903'), ('D372', 'T0904'), ('D372', 'T0905'), ('D372', 'T0906'), ('D372', 'T0907'), ('D372', 'T0908'), ('D372', 'T0910'), ('D372', 'T0911'),
('D373', 'T0901'), ('D373', 'T0903'), ('D373', 'T0904'), ('D373', 'T0905'), ('D373', 'T0906'), ('D373', 'T0907'), ('D373', 'T0908'), ('D373', 'T0910'), ('D373', 'T0911'),
('D374', 'T0901'), ('D374', 'T0903'), ('D374', 'T0904'), ('D374', 'T0905'), ('D374', 'T0906'), ('D374', 'T0907'), ('D374', 'T0908'), ('D374', 'T0910'), ('D374', 'T0911'),
('D375', 'T0901'), ('D375', 'T0903'), ('D375', 'T0904'), ('D375', 'T0905'), ('D375', 'T0906'), ('D375', 'T0907'), ('D375', 'T0908'), ('D375', 'T0910'), ('D375', 'T0911'),
('D376', 'T0901'), ('D376', 'T0903'), ('D376', 'T0904'), ('D376', 'T0905'), ('D376', 'T0906'), ('D376', 'T0907'), ('D376', 'T0908'), ('D376', 'T0910'), ('D376', 'T0911'),
('D377', 'T0901'), ('D377', 'T0903'), ('D377', 'T0904'), ('D377', 'T0905'), ('D377', 'T0906'), ('D377', 'T0907'), ('D377', 'T0908'), ('D377', 'T0910'), ('D377', 'T0911'),
('D378', 'T0901'), ('D378', 'T0903'), ('D378', 'T0904'), ('D378', 'T0905'), ('D378', 'T0906'), ('D378', 'T0907'), ('D378', 'T0908'), ('D378', 'T0910'), ('D378', 'T0911'),
('D379', 'T0901'), ('D379', 'T0903'), ('D379', 'T0904'), ('D379', 'T0905'), ('D379', 'T0906'), ('D379', 'T0907'), ('D379', 'T0908'), ('D379', 'T0910'), ('D379', 'T0911'),
('D380', 'T0901'), ('D380', 'T0903'), ('D380', 'T0904'), ('D380', 'T0905'), ('D380', 'T0906'), ('D380', 'T0907'), ('D380', 'T0908'), ('D380', 'T0910'), ('D380', 'T0911'),
('D381', 'T0901'), ('D381', 'T0903'), ('D381', 'T0904'), ('D381', 'T0905'), ('D381', 'T0906'), ('D381', 'T0907'), ('D381', 'T0908'), ('D381', 'T0910'), ('D381', 'T0911'),
('D382', 'T0901'), ('D382', 'T0903'), ('D382', 'T0904'), ('D382', 'T0905'), ('D382', 'T0906'), ('D382', 'T0907'), ('D382', 'T0908'), ('D382', 'T0910'), ('D382', 'T0911'),
('D383', 'T0901'), ('D383', 'T0903'), ('D383', 'T0904'), ('D383', 'T0905'), ('D383', 'T0906'), ('D383', 'T0907'), ('D383', 'T0908'), ('D383', 'T0910'), ('D383', 'T0911'),
('D384', 'T1001'), ('D384', 'T1005'), ('D384', 'T1006'), ('D384', 'T1010'),
('D385', 'T1001'), ('D385', 'T1005'), ('D385', 'T1006'), ('D385', 'T1010'),
('D386', 'T1001'), ('D386', 'T1005'), ('D386', 'T1006'), ('D386', 'T1010'),
('D387', 'T1001'), ('D387', 'T1005'), ('D387', 'T1006'), ('D387', 'T1010'),
('D388', 'T1001'), ('D388', 'T1005'), ('D388', 'T1006'), ('D388', 'T1010'),
('D389', 'T1001'), ('D389', 'T1005'), ('D389', 'T1006'), ('D389', 'T1010'),
('D390', 'T1001'), ('D390', 'T1005'), ('D390', 'T1006'), ('D390', 'T1010'),
('D391', 'T1001'), ('D391', 'T1005'), ('D391', 'T1006'), ('D391', 'T1010'),
('D392', 'T1001'), ('D392', 'T1005'), ('D392', 'T1006'), ('D392', 'T1010'),
('D393', 'T1001'), ('D393', 'T1005'), ('D393', 'T1006'), ('D393', 'T1010'),
('D394', 'T1001'), ('D394', 'T1005'), ('D394', 'T1006'), ('D394', 'T1010'),
('D395', 'T1001'), ('D395', 'T1005'), ('D395', 'T1006'), ('D395', 'T1010'),
('D396', 'T1001'), ('D396', 'T1005'), ('D396', 'T1006'), ('D396', 'T1010'),
('D397', 'T1001'), ('D397', 'T1005'), ('D397', 'T1006'), ('D397', 'T1010'),
('D398', 'T1001'), ('D398', 'T1005'), ('D398', 'T1006'), ('D398', 'T1010'),
('D399', 'T1001'), ('D399', 'T1005'), ('D399', 'T1006'), ('D399', 'T1010'),
('D400', 'T1001'), ('D400', 'T1005'), ('D400', 'T1006'), ('D400', 'T1010'),
('D401', 'T1001'), ('D401', 'T1005'), ('D401', 'T1006'), ('D401', 'T1010'),
('D402', 'T1001'), ('D402', 'T1005'), ('D402', 'T1006'), ('D402', 'T1010'),
('D403', 'T1001'), ('D403', 'T1005'), ('D403', 'T1006'), ('D403', 'T1010');

-- 3. 恢復檢查
SET FOREIGN_KEY_CHECKS = 1;

-- 4. 檢查筆數
SELECT COUNT(*) AS '匯入總筆數' FROM `BRAND`;
SELECT * FROM `DRINK`;
-- . 想看哪些飲料最貴
SELECT * FROM DRINK ORDER BY price DESC LIMIT 10;
-- 想看某個品牌（例如B02)有哪些飲料
SELECT * FROM DRINK WHERE brand_id = 'B02';
DESCRIBE `STORE`;
DESCRIBE `DRINK`;
DESCRIBE `BRAND`;
DESCRIBE `CATEGORY`;
DESCRIBE `TOPPING`;
DESCRIBE `STANDARD_TOPPING`;
DESCRIBE `DRINK_TOPPING`;
-- 查詢品牌編號為 'B01' 的所有飲料名稱與價格
SELECT drink_name, price 
FROM DRINK 
WHERE brand_id = 'B01';
-- 找出所有售價小於等於 50 元的飲料，並由高到低排序
SELECT drink_name, price 
FROM DRINK 
WHERE price <= 50 
ORDER BY price DESC;
-- 查詢飲料名稱、加料名稱，並計算組合後的總金額
SELECT 
    d.drink_name AS '飲料名稱', 
    d.price AS '原價', 
    t.topping_name AS '加料名稱', 
    t.extra_price AS '加料費用', 
    (d.price + t.extra_price) AS '最終總價'
FROM DRINK d
JOIN DRINK_TOPPING dt ON d.drink_id = dt.drink_id
JOIN TOPPING t ON dt.topping_id = t.topping_id
LIMIT 10;
DESCRIBE BRAND;
SELECT * FROM DRINK_TOPPING LIMIT 15;
SELECT COUNT(*) AS '資料總筆數' FROM DRINK_TOPPING;
SELECT COUNT(*) FROM DRINK;
SELECT 
    d.drink_name AS '飲品名稱', 
    d.price AS '原價', 
    t.topping_name AS '加料名稱', 
    t.extra_price AS '加料費用', 
    (d.price + t.extra_price) AS '組合總價'
FROM DRINK d
JOIN DRINK_TOPPING dt ON d.drink_id = dt.drink_id
JOIN TOPPING t ON dt.topping_id = t.topping_id
ORDER BY d.drink_name ASC
LIMIT 10;

-- 最終數據總結統計
SELECT 
    (SELECT COUNT(*) FROM BRAND) AS '總品牌數',
    (SELECT COUNT(*) FROM DRINK) AS '總飲品數',
    (SELECT COUNT(*) FROM DRINK_TOPPING) AS '總配料組合數';