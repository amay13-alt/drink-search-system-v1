import React from 'react';

function DrinkCard({ drink }) {
  // 將星星渲染邏輯封裝在元件內
    const renderStars = (rating) => {
        const stars = [];
        for (let i = 1; i <= 5; i++) {
            if (i <= Math.floor(rating)) {
            // 實心星
            stars.push(<span key={i} style={{ color: '#FFD700' }}>★</span>);
            } else if (i === Math.ceil(rating) && rating % 1 >= 0.5) {
            // 半心星 (利用 Unicode 的半星或用 CSS 遮罩)
            // 這裡先用簡單的符號代替，若要完美建議用 FontAwesome
            stars.push(<span key={i} style={{ color: '#FFD700' }}>⯪</span>); 
            } else {
            // 空心星
            stars.push(<span key={i} style={{ color: '#ccc' }}>☆</span>);
            }
        }
        return stars;
    };

  return (
    <div 
      className="drink-card" 
      style={{ borderLeft: `10px solid ${drink.color}` }}
    >
      <div className="card-header">
        <img src={drink.logo} alt={drink.store} className="brand-logo" />
        <div>
          <h3>{drink.name}</h3>
          <p className="store-name">{drink.store}</p>
        </div>
      </div>
      <div className="rating">
        {renderStars(drink.rating)} ({drink.rating})
      </div>
      <p className="price-tag">價格：${drink.price}</p>
      {drink.toppings.length > 0 && (
        <p className="topping-info">推薦加料：{drink.toppings.join(', ')}</p>
      )}
    </div>
  );
}

export default DrinkCard;