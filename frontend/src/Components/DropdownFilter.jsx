import React from 'react';

function DropdownFilter({ label, options, onSelectChange, value }) {
  return (
    <div className="filter-item" style={{ marginBottom: '10px' }}>
      <label style={{ fontWeight: 'bold', marginRight: '8px' }}>{label}：</label>
      <select 
        value={value} 
        onChange={(e) => onSelectChange(e.target.value)}
        style={{ padding: '5px', borderRadius: '5px', border: '1px solid #ccc' }}
      >
        <option value="全部">全部</option>
        {options.map((opt, index) => (
          <option key={index} value={opt}>{opt}</option>
        ))}
      </select>
    </div>
  );
}

export default DropdownFilter;