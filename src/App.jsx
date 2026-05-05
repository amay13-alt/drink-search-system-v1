import { useState } from 'react'
import DropdownFilter from './Components/DropdownFilter.jsx' // 記得建立這個元件
import PriceFilter from './Components/PriceFilter.jsx'
import MapComponent from './Components/MapComponent.jsx'
import './App.css'

// 1. 專業級 Mock Data
const mockDrinks = [
  { id: 1, name: '珍珠紅茶', category: '紅茶', price: 40, store: '50嵐', lat: 24.7971508936953, lng: 120.975997364986,toppings: ['珍珠'],rating: 4.2 },
  { id: 2, name: '翡翠綠茶', category: '綠茶', price: 35, store: '迷客夏', lat: 24.7967686130477, lng: 120.975986636149, toppings: ['椰果'],rating: 4.0 },
  { id: 3, name: '烏龍青茶', category: '青茶', price: 30, store: '可不可', lat: 24.79657625482, lng: 120.975710368617, toppings: ['粉粿'],rating: 4.5 },
  { id: 4, name: '拿鐵咖啡', category: '咖啡', price: 70, store: '可不可', lat: 24.79657625482, lng: 120.975710368617, toppings: [],rating: 4.3 },
  { id: 5, name: '厚奶茶', category: '奶茶', price: 60, store: '50嵐', lat: 24.7971508936953, lng: 120.975997364986, toppings: ['布丁'],rating: 4.1 },
  { id: 6, name: '柳橙綠', category: '鮮果', price: 55, store: '麻古茶坊', lat: 24.7979519748133, lng: 120.977153397072, toppings: [],rating: 4.4 },
  { id: 7, name: '草莓冰沙', category: '鮮果', price: 65, store: '麻古茶坊', lat: 24.7979519748133, lng: 120.977153397072, toppings: [],rating: 4.5 },
  { id: 8, name: '炭燒青茶', category: '青茶', price: 60, store: '大茗本位', lat: 24.7969171426064, lng: 120.976155615334, toppings: ['奶蓋'],rating: 4.2 },
  { id: 9, name: '舞鶴紅茶', category: '紅茶', price: 60, store: 'MOREiN沫飲', lat: 24.7971874172624, lng: 120.976257539268, toppings: ['仙草'],rating: 4.6 },
];

function App() {
  const [selectedCategory, setSelectedCategory] = useState('全部');
  const [selectedStore, setSelectedStore] = useState('全部');
  const [maxPrice, setMaxPrice] = useState(100);

  // 2. 星星渲染函式
  const renderStars = (rating) => "⭐".repeat(Math.floor(rating)) + (rating % 1 >= 0.5 ? "⭐️" : "");

  // 3. 多重過濾邏輯
  const filteredDrinks = mockDrinks.filter(drink => {
    const matchCat = selectedCategory === '全部' || drink.category === selectedCategory;
    const matchStore = selectedStore === '全部' || drink.store === selectedStore;
    const matchPrice = drink.price <= maxPrice;
    return matchCat && matchStore && matchPrice;
  });

  return (
    <div className="app-container">
      <h1>🥤 飲料店搜尋系統 (新竹食品路)</h1>
      
      <div className="filter-section">
        <DropdownFilter label="飲品類別" options={['紅茶', '綠茶', '青茶', '鮮果']} onSelectChange={setSelectedCategory} value={selectedCategory} />
        <DropdownFilter label="選擇店家" options={['50嵐', '迷客夏', '麻古茶坊', '大茗本位', 'MOREiN沫飲']} onSelectChange={setSelectedStore} value={selectedStore} />
        <PriceFilter maxPrice={maxPrice} onPriceChange={setMaxPrice} />
      </div>

      <div className="main-content">
        <div className="drink-list">
          {filteredDrinks.map(drink => (
            <div key={drink.id} className="drink-card">
              <h3>{drink.name}</h3>
              <p className="store-name">{drink.store}</p>
              <div className="rating">{renderStars(drink.rating)} ({drink.rating})</div>
              <p className="price-tag">價格：${drink.price}</p>
            </div>
          ))}
        </div>

        <div className="map-container">
          <MapComponent drinks={filteredDrinks} />
        </div>
      </div>
    </div>
  )
}

export default App