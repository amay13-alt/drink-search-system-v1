import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';

// 建立一個函式，根據顏色代碼生成 SVG 圖標
const createColoredIcon = (color) => {
  return L.divIcon({
    html: `
      <svg width="30" height="42" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
        <path d="M12 0C7.58 0 4 3.58 4 8C4 13.5 12 22 12 22C12 22 20 13.5 20 8C20 3.58 16.42 0 12 0ZM12 11C10.34 11 9 9.66 9 8C9 6.34 10.34 5 12 5C13.66 5 15 6.34 15 8C15 9.66 13.66 11 12 11Z" 
          fill="${color}" 
          stroke="white" 
          stroke-width="1"/>
      </svg>`,
    className: 'custom-marker', // 這是為了清除 Leaflet 預設的白框背景
    iconSize: [30, 42],
    iconAnchor: [15, 42], // 讓圖標的尖端精確對準座標點
    popupAnchor: [0, -40], // 讓彈出視窗顯示在圖標上方
  });
};

function MapComponent({ drinks }) {
  const center = [24.796, 120.976]; // 新竹食品路中心點

  return (
    <MapContainer center={center} zoom={16} style={{ height: '100%', width: '100%' }}>
      <TileLayer url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png" />
      
      {drinks.map(drink => (
        <Marker 
          key={drink.id} 
          position={[drink.lat, drink.lng]} 
          // 關鍵：將 drink.color 傳入函式生成對應顏色的圖標
          icon={createColoredIcon(drink.color)}
        >
          <Popup>
            <div className="popup-content">
              <strong>{drink.store}</strong><br />
              {drink.name} - ${drink.price}
            </div>
          </Popup>
        </Marker>
      ))}
    </MapContainer>
  );
}

export default MapComponent;