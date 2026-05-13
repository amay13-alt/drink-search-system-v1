import React, { useState, useEffect } from 'react';
import './App.css';
import MapComponent from './components/MapComponent';
import mockDrinks from './data/drinks'; // 💡 確保妳把假資料獨立成一個檔案導入

function App() {
  // ---------------------------------------------------
  // 1. 核心狀態宣告 (真全端動態渲染)
  // ---------------------------------------------------
  const [drinks, setDrinks] = useState([]);          
  const [loading, setLoading] = useState(true);      
  const [visibleCount, setVisibleCount] = useState(12); 
  const [isUsingMock, setIsUsingMock] = useState(false); // 💡 新增：用來標記當前是不是備援資料

  const [searchKeyword, setSearchKeyword] = useState('');
  const [selectedCategory, setSelectedCategory] = useState('全部');
  const [selectedStore, setSelectedStore] = useState('全部');
  const [selectedTopping, setSelectedTopping] = useState('全部'); 
  const [maxPrice, setMaxPrice] = useState(100);

  // ---------------------------------------------------
  // 2. 網路 Fetch 對接本地後端 Express API
  // ---------------------------------------------------
  useEffect(() => {
      fetch('http://localhost:3000/api/drinks')
        .then(res => {
          if (!res.ok) throw new Error("後端 API 回應失敗");
          return res.json();
        })
        .then(data => {
          setDrinks(data); 
          setIsUsingMock(false);
          setLoading(false);
        })
        .catch(err => {
          // 🎯 核心精髓：後端斷線時，前端溫柔接手，絕對不當機
          console.warn("⚠️ 本地後端未啟動或資料庫斷線，系統已自動切換至「智慧前端備援機制」：", err);
          setDrinks(mockDrinks); // 直接把假資料塞給狀態
          setIsUsingMock(true);  // 點亮備援燈號
          setLoading(false);
        });
    }, []);

  // ---------------------------------------------------
  // 3. 🎯 終極防禦版：多層級即時過濾演算法（防止任何 NULL 或非陣列當機）
  // ---------------------------------------------------
  const filteredDrinks = Array.isArray(drinks) ? drinks.filter(drink => {
    // 💡 安全防禦 1：如果這筆飲品資料根本是空的，或者沒有名字、沒有品牌，直接過濾掉不處理
    if (!drink || !drink.name || !drink.store) {
      return false; 
    }

    // 安全防禦 2：確保配料欄位一定是陣列
    const currentToppings = Array.isArray(drink.toppings) ? drink.toppings : [];
    const currentStdToppings = Array.isArray(drink.standardToppings) ? drink.standardToppings : [];

    // 關鍵字比對邏輯 (加上安全字串防護)
    const matchKeyword = 
      drink.name.toLowerCase().includes(searchKeyword.toLowerCase()) ||
      drink.store.toLowerCase().includes(searchKeyword.toLowerCase()) ||
      currentToppings.some(t => t && t.toLowerCase().includes(searchKeyword.toLowerCase())) ||
      currentStdToppings.some(st => st && st.toLowerCase().includes(searchKeyword.toLowerCase()));

    // 其他下拉選單與價格比對
    const matchCategory = selectedCategory === '全部' || drink.category === selectedCategory;
    const matchStore = selectedStore === '全部' || drink.store === selectedStore;
    const matchPrice = Number(drink.price || 0) <= maxPrice;
    const matchTopping = selectedTopping === '全部' || currentStdToppings.includes(selectedTopping);
    
    return matchKeyword && matchCategory && matchStore && matchPrice && matchTopping;
  }) : []; // 💡 安全防禦 3：如果後端傳過來的根本不是陣列，直接給它空陣列，絕對不讓網頁當機！

  // 當任何篩選條件改變時，自動將列表導回前 12 筆防止卡頓
  useEffect(() => {
    setVisibleCount(12);
  }, [searchKeyword, selectedCategory, selectedStore, selectedTopping, maxPrice]);

  // ---------------------------------------------------
  // 4. 加載中骨架畫面
  // ---------------------------------------------------
  if (loading) {
    return (
      <div className="loading-screen">
        <div className="loading-spinner"></div>
        <p>🍹 正在讀取數據...</p>
      </div>
    );
  }

return (
    <div className="app-container">
      {/* 系統標題列 */}
      <header className="app-header">
        <h1 className="app-title"><b>🥤 新竹食品路 · 飲品地圖 🥤</b></h1>
        {isUsingMock ? (
          <div className="status-badge" style={{ backgroundColor: '#e67e22' }}>
            ⚠️ 模式：雲端展示 (前端靜態備援數據)
          </div>
        ) : (
          <div className="status-badge" style={{ backgroundColor: '#10b981' }}>
            🟢 模式：本機全端 (MySQL 資料庫即時連線)
          </div>
        )}
      </header>

      {/* 💡 智慧對齊版面：上方左右平分，高度自動相等 */}
      <div className="top-split-layout">
        
        {/* 左半邊：智慧篩選中樞玻璃面板 */}
        <div className="filter-card-panel">
          <input 
            type="text" 
            placeholder="🔍 搜尋飲料" 
            value={searchKeyword}
            onChange={(e) => setSearchKeyword(e.target.value)}
            className="search-bar-input"
          />
          
          <div className="selectors-row">
            <select value={selectedCategory} onChange={(e) => setSelectedCategory(e.target.value)}>
              <option value="全部">所有品項</option>
              <option value="原味茶">原味茶</option>
              <option value="奶茶">奶茶</option>
              <option value="拿鐵">拿鐵</option>
              <option value="鮮果">鮮果</option>
              <option value="特調">特調</option>
              <option value="奶蓋茶">奶蓋茶</option>
            </select>

            <select value={selectedStore} onChange={(e) => setSelectedStore(e.target.value)}>
              <option value="全部">所有品牌</option>
              <option value="50嵐">50嵐</option>
              <option value="CoCo都可">CoCo都可</option>
              <option value="清心福全">清心福全</option>
              <option value="迷客夏">迷客夏</option>
              <option value="可不可">可不可</option>
              <option value="MOREiN沫飲">MOREiN沫飲</option>
              <option value="大茗本位">大茗本位</option>
              <option value="麻古茶坊">麻古茶坊</option>
              <option value="上宇林">上宇林</option>
              <option value="清原芋圓">清原芋圓</option>
            </select>

            <select value={selectedTopping} onChange={(e) => setSelectedTopping(e.target.value)}>
              <option value="全部">所有加料</option>
              <option value="波霸">波霸</option>
              <option value="椰果">椰果</option>
              <option value="燕麥">燕麥</option>
              <option value="冰淇淋">冰淇淋</option>
              <option value="布丁">布丁</option>
              <option value="仙草凍">仙草凍</option>
              <option value="茶凍">茶凍</option>
              <option value="粉角">粉角</option>
              <option value="寒天晶球">寒天晶球</option>
              <option value="粉粿">粉粿</option>
              <option value="奶蓋">奶蓋</option>
              <option value="養樂多">養樂多</option>
            </select>
          </div>

          <div className="price-slider-box">
            <div className="slider-label">價格預算上限：<span>${maxPrice} 元</span></div>
            <input 
              type="range" 
              min="30" 
              max="100" 
              value={maxPrice} 
              onChange={(e) => setMaxPrice(Number(e.target.value))} 
              className="range-slider"
            />
          </div>
          
          <div className="results-counter">
            🎯 當前條件下找到 <strong>{filteredDrinks.length}</strong> 筆飲品
          </div>
        </div>

        {/* 右半邊：高質感大器地圖區（會自動拉伸到跟左邊控制台等高） */}
        <div className="main-map-section">
          <MapComponent drinks={filteredDrinks} /> 
        </div>

      </div>

      <hr style={{ border: '0', height: '1px', background: '#e2e8f0', margin: '32px 0' }} />

      {/* 下方區塊：一列 4 個卡牌 */}
      <h2 className="section-subtitle">🧋 推薦精選菜單</h2>
      <div className="drink-card-grid">
        {filteredDrinks.slice(0, visibleCount).map(drink => (
          <div key={drink.id} className="beverage-card" style={{ borderTop: `6px solid ${drink.color || '#cbd5e1'}` }}>
            <div className="b-card-header">
              {drink.logo && <img src={drink.logo} alt={drink.store} className="b-store-logo" />}
              <span className="b-store-name">{drink.store}</span>
              <span className="b-rating">⭐ {Number(drink.rating || 0).toFixed(1)}</span>
            </div>
            <h3 className="b-drink-name">{drink.name}</h3>
            
            {Array.isArray(drink.toppings) && drink.toppings.length > 0 && (
              <div style={{ fontSize: '0.8rem', color: '#64748b', backgroundColor: '#f8fafc', padding: '6px 10px', borderRadius: '6px', marginBottom: '10px' }}>
                ✨ 店內配料: <strong>{drink.toppings.join(' · ')}</strong>
              </div>
            )}

            <div className="b-card-footer">
              <span className="b-category-tag">🏷️ {drink.category}</span>
              <span className="b-price">${drink.price}</span>
            </div>
          </div>
        ))}
      </div>

      {/* 分批動態載入按鈕 */}
      {filteredDrinks.length > visibleCount && (
        <div className="button-center-box">
          <button onClick={() => setVisibleCount(prev => prev + 12)} className="load-more-btn">
            查看更多飲品（還有 {filteredDrinks.length - visibleCount} 筆）
          </button>
        </div>
      )}
    </div>
  );
}

export default App;