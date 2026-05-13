# 🥤 新竹食品路 · 飲品快搜系統 (Full-Stack)

本系統為資料庫期末專案，採用 React (Vite) + Node.js (Express) + MySQL 雙軌關聯式資料庫架構開發。

---

## 🛠️ 開發人員與助教本機運行指南

假設您的電腦已安裝好 **VS Code** 與 **MySQL Workbench**。
安裝必要依賴套件(在終端機輸入)：
   ```bash
   npm install
💡 檢查 .env 檔案，確保裡面的 DB_PASSWORD 與您的 MySQL root 密碼一致。

### 🗄️ 第一步：還原 MySQL 資料庫
1. 打開 **MySQL Workbench**，點擊進入 `Local instance MySQL80`。
2. 點擊左側選單的 **Data Import/Restore**。
3. 選擇 **Import from Self-Contained File**，並選取專案目錄底下的 `DBA.sql`。
4. 在 *Default Schema to Import To* 點擊 **New**，新增一個名為 `beverage_db` 的 Schema。
5. 點擊右下角 **Start Import**。看到成功字樣後，即完成 403 筆飲品與多表 3NF 數據還原！

### 🚀 第二步：啟動 Application Layer (後端)
1. 用 VS Code 打開本專案，並開啟終端機。
2. 切換至後端目錄：
   ```bash
   cd backend
3. 啟動後端 API 伺服器：
   ```bash
   node server.js
當畫面顯示 🚀 雙軌配料真 API 已成功啟動：http://localhost:3000 即代表與 MySQL 連線成功。

### 💻 第三步：啟動 Presentation Layer (前端)
1. 在 VS Code 中點擊 + 號開一個「新的終端機視窗」（保留後端執行）。
2. 切換至前端目錄：
   ```bash
   cd frontend
3. 安裝前端網頁套件：
   ```bash
   npm install
4. 啟動 React 本機伺服器：
   ```bash
   npm run dev
5. 按住 Ctrl 點擊終端機顯示的 http://localhost:5173 網址，即可看見完整系統！
