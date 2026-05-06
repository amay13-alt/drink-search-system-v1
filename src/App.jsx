import { useState } from 'react';
import { mockDrinks } from './data/drinks.js'; // 引入抽離後的資料
import DropdownFilter from './Components/DropdownFilter.jsx';
import PriceFilter from './Components/PriceFilter.jsx';
import MapComponent from './Components/MapComponent.jsx';
import DrinkCard from './Components/DrinkCard.jsx'; // 引入封裝後的卡片元件
import './App.css';

function App() {
  const [selectedCategory, setSelectedCategory] = useState('全部');
  const [selectedStore, setSelectedStore] = useState('全部');
  const [selectedTopping, setSelectedTopping] = useState('全部');
  const [maxPrice, setMaxPrice] = useState(100);
  const [searchTerm, setSearchTerm] = useState('');

  // 自動提取所有加料選項
  const allToppings = [ ...new Set(mockDrinks.flatMap(d => d.toppings))];

  const filteredDrinks = mockDrinks.filter(drink => {
    const matchCat = selectedCategory === '全部' || drink.category === selectedCategory;
    const matchStore = selectedStore === '全部' || drink.store === selectedStore;
    const matchTopping = selectedTopping === '全部' || drink.toppings.includes(selectedTopping);
    const matchPrice = drink.price <= maxPrice;
    const matchSearch = drink.name.toLowerCase().includes(searchTerm.toLowerCase()) || 
                        drink.store.toLowerCase().includes(searchTerm.toLowerCase());
    
    // 關鍵修正：確保 matchTopping 有被包含在 return 中
    return matchCat && matchStore && matchTopping && matchPrice && matchSearch;
  });

  return (
    <div className="app-container">
      <h1>🥤 飲料店搜尋系統 (新竹食品路)</h1>
      
      <div className="filter-section">
        <input 
          type="text" 
          placeholder="搜尋飲品或店家..." 
          className="search-bar"
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
        />
        <div className="dropdown-group">
          <DropdownFilter 
            label="飲品類別" 
            options={['紅茶', '綠茶', '青茶', '鮮果', '咖啡']}
            onSelectChange={setSelectedCategory} 
            value={selectedCategory} 
          />

          <DropdownFilter 
            label="選擇店家" 
            options={['50嵐', '迷客夏', '麻古茶坊', '可不可', '路易莎']}
            onSelectChange={setSelectedStore} 
            value={selectedStore} 
          />

          <DropdownFilter 
            label="選擇加料" 
            options={allToppings} // 這邊傳進去的就是乾淨的配料清單
            onSelectChange={setSelectedTopping} 
            value={selectedTopping} 
          />
        </div>
        <PriceFilter maxPrice={maxPrice} onPriceChange={setMaxPrice} />
      </div>

      <div className="main-content">
        <div className="drink-list">
          {filteredDrinks.length > 0 ? (
            filteredDrinks.map(drink => (
              <DrinkCard key={drink.id} drink={drink} />
            ))
          ) : (
            <p className="no-result">😭 找不到符合條件的飲料，換個條件試試？</p>
          )}
        </div>

        <div className="map-container">
          <MapComponent drinks={filteredDrinks} />
        </div>
      </div>
    </div>
  );
}

export default App;