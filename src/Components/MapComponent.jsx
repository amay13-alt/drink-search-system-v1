import React from 'react';
import { MapContainer, TileLayer, Marker, Popup } from 'react-leaflet';
import L from 'leaflet';
import 'leaflet/dist/leaflet.css';

// 💡 關鍵修正：直接用網址連結圖片，避免 Vite 報錯
const defaultIcon = L.icon({
  iconUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-icon.png',
  shadowUrl: 'https://unpkg.com/leaflet@1.9.4/dist/images/marker-shadow.png',
  iconSize: [25, 41],
  iconAnchor: [12, 41],
});

function MapComponent({ drinks }) {
  // 新竹食品路中心點座標
  const position = [24.796378, 120.975088]; 

  return (
    <MapContainer 
      center={position} 
      zoom={16} 
      style={{ height: '400px', width: '100%', borderRadius: '15px' }}
    >
      <TileLayer
        url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
        attribution='&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
      />
      
      {/* 遍歷過濾後的飲料店顯示標記 */}
      {drinks.map(drink => (
        drink.lat && drink.lng && (
          <Marker 
            key={drink.id} 
            position={[drink.lat, drink.lng]} 
            icon={defaultIcon} // 使用上面定義的修正圖標
          >
            <Popup>
              <strong>{drink.store}</strong><br />
              {drink.name} - ${drink.price}
            </Popup>
          </Marker>
        )
      ))}
    </MapContainer>
  );
}

export default MapComponent;