import React from 'react';

// 我們把選單標籤先定義在這裡，這就是你說的「測試資料」可以放的地方
const categories = ['全部', '紅茶', '綠茶', '青茶', '咖啡', '奶茶', '鮮果'];

function CategoryFilter({ onCategoryChange }) {
  // 當使用者切換選單時，觸發這個函式
  const handleChange = (event) => {
    const selectedValue = event.target.value;
    // 把選中的值傳回給父元件 (App.jsx)
    onCategoryChange(selectedValue);
  };

  return (
    <div className="filter-container">
      <label htmlFor="category-select">選擇飲品類別：</label>
      <select id="category-select" onChange={handleChange}>
        {categories.map((cat, index) => (
          <option key={index} value={cat}>
            {cat}
          </option>
        ))}
      </select>
    </div>
  );
}

export default CategoryFilter;