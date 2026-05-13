const express = require('express');
const mysql = require('mysql2');
const cors = require('cors');
require('dotenv').config();

const app = express();
app.use(cors()); 
app.use(express.json());

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10
});
const db = pool.promise();

app.get('/api/drinks', async (req, res) => {
  try {
    // 💡 升級 SQL：同時抓取店內配料原名(t.topping_name) 與 標準化分類(st.standard_name)
    const [rows] = await db.query(`
      SELECT 
        d.drink_id AS id,
        d.drink_name AS name,
        c.category_name AS category,
        d.price AS price,
        b.brand_name AS store,
        b.logo_path AS logo,
        b.brand_color AS color,
        b.lat AS lat,
        b.lng AS lng,
        b.rating AS rating,
        GROUP_CONCAT(DISTINCT t.topping_name) AS custom_toppings,
        GROUP_CONCAT(DISTINCT st.standard_name) AS standard_toppings
      FROM DRINK d
      JOIN BRAND b ON d.brand_id = b.brand_id
      JOIN CATEGORY c ON d.category_id = c.category_id
      LEFT JOIN DRINK_TOPPING dt ON d.drink_id = dt.drink_id
      LEFT JOIN TOPPING t ON dt.topping_id = t.topping_id
      LEFT JOIN STANDARD_TOPPING st ON t.standard_id = st.standard_id
      GROUP BY d.drink_id
      ORDER BY d.drink_id ASC
    `);

    const formattedDrinks = rows.map(drink => ({
      id: drink.id,
      name: drink.name,
      category: drink.category,
      price: Number(drink.price),
      store: drink.store,
      lat: Number(drink.lat),
      lng: Number(drink.lng),
      rating: Number(drink.rating),
      logo: drink.logo,
      color: drink.color,
      // 💡 店內真實名稱（如：["水玉"]），用來給前端卡片顯示、打字搜尋
      toppings: drink.custom_toppings ? drink.custom_toppings.split(',') : [],
      // 💡 標準分類名稱（如：["寒天晶球"]），專門用來對接下拉選單
      standardToppings: drink.standard_toppings ? drink.standard_toppings.split(',') : []
    }));

    res.json(formattedDrinks); 
  } catch (err) {
    console.error("資料庫查詢失敗：", err);
    res.status(500).json({ error: '資料庫連線或進階聚合查詢失敗' });
  }
});

const PORT = process.env.PORT || 3000;
app.use((req, res) => res.status(404).send("Cannot GET " + req.url));
app.listen(PORT, () => {
  console.log(`🚀 雙軌配料真 API 已成功啟動：http://localhost:${PORT}`);
});