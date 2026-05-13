import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';

// 建立一個函式，根據顏色代碼生成 SVG 圖標
const createColoredIcon = (color) => {
  const finalColor = color || '#3b82f6'; // 防呆：如果資料庫沒填顏色，預設用科技藍
  return L.divIcon({
    html: `
      <svg width="30" height="42" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M12 0C7.58 0 4 3.58 4 8C4 13.5 12 22 12 22C12 22 20 13.5 20 8C20 3.58 16.42 0 12 0ZM12 11C10.34 11 9 9.66 9 8C9 6.34 10.34 5 12 5C13.66 5 15 6.34 15 8C15 9.66 13.66 11 12 11Z" 
          fill="${finalColor}" 
          stroke="white" 
          stroke-width="1.5" 
          stroke-linejoin="round"/>
      </svg>`,
    className: 'custom-leaflet-marker', // 改用自訂類別，避免與預設樣式衝突
    iconSize: [30, 42],
    iconAnchor: [15, 42], 
    popupAnchor: [0, -40], 
  });
};

function MapComponent({ drinks }) {
  // 💡 修正 1：將地圖中心點精準校正回「新竹食品路」飲料連鎖戰區 (120.975xx)
  const center = [24.7967, 120.9759]; 

  // 💡 修正 2：空間聚合演算法
  const storeGroups = {};
  drinks.forEach(drink => {
    // 安全防禦：確保經緯度存在才畫在地圖上
    if (drink.lat && drink.lng) {
      if (!storeGroups[drink.store]) {
        storeGroups[drink.store] = {
          store: drink.store,
          lat: Number(drink.lat),
          lng: Number(drink.lng),
          color: drink.color,
          logo: drink.logo,
          menuItems: []
        };
      }
      storeGroups[drink.store].menuItems.push(drink);
    }
  });

  const uniqueStores = Object.values(storeGroups);

  return (
    <div style={{ height: '100%', width: '100%', position: 'relative' }}>
      {/* 偵錯小幫手：如果前端完全拿不到座標資料，在畫面提示妳，簡報時也可以自圓其說 */}
      {drinks.length > 0 && uniqueStores.length === 0 && (
        <div style={{
          position: 'absolute', top: 10, left: 50, zIndex: 1000,
          background: 'rgba(239, 68, 68, 0.9)', color: 'white',
          padding: '8px 12px', borderRadius: '6px', fontSize: '12px'
        }}>
          ⚠️ 偵錯提示：前端收到 {drinks.length} 筆飲料，但皆無經緯度資料，請檢查後端 SQL 是否有 JOIN 門市資料表！
        </div>
      )}

      <MapContainer center={center} zoom={16} style={{ height: '100%', width: '100%' }}>
        <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
        
        {uniqueStores.map((storeData, index) => (
          <Marker 
            key={`${storeData.store}-${index}`} 
            position={[storeData.lat, storeData.lng]} 
            icon={createColoredIcon(storeData.color)}
          >
            <Popup>
              <div className="popup-content" style={{ minWidth: '180px', maxHeight: '200px', overflowY: 'auto' }}>
                <div style={{ display: 'flex', alignItems: 'center', gap: '8px', borderBottom: '1px solid #eee', paddingBottom: '6px', marginBottom: '6px' }}>
                  {storeData.logo && <img src={storeData.logo} alt={storeData.store} style={{ width: '20px', height: '20px', borderRadius: '50%' }} />}
                  <strong style={{ fontSize: '1rem', color: '#1e293b' }}>{storeData.store}</strong>
                </div>
                
                <ul style={{ listStyle: 'none', padding: 0, margin: 0, fontSize: '0.85rem' }}>
                  {storeData.menuItems.map(item => (
                    <li key={item.id} style={{ display: 'flex', justifyContent: 'space-between', padding: '3px 0', color: '#475569' }}>
                      <span>🧋 {item.name}</span>
                      <strong style={{ color: '#e67e22' }}>${item.price}</strong>
                    </li>
                  ))}
                </ul>
                <div style={{ fontSize: '11px', color: '#94a3b8', marginTop: '6px', textAlign: 'right' }}>
                  當前符合 {storeData.menuItems.length} 個品項
                </div>
              </div>
            </Popup>
          </Marker>
        ))}
      </MapContainer>
    </div>
  );
}

export default MapComponent;