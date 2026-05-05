import React from 'react';

function PriceFilter({ maxPrice, onPriceChange }) {
  return (
    <div className="filter-container" style={{ marginTop: '10px' }}>
      <label htmlFor="price-range">預算上限： ${maxPrice}</label>
      <input 
        type="range" 
        id="price-range" 
        min="0" 
        max="100" 
        step="5" 
        value={maxPrice} 
        onChange={(e) => onPriceChange(Number(e.target.value))}
        style={{ marginLeft: '10px', verticalAlign: 'middle' }}
      />
    </div>
  );
}

export default PriceFilter;