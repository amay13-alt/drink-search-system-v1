const mockDrinks = [
  {
    id: 1, name: '波霸紅茶拿鐵', category: '拿鐵', price: 65, store: '50嵐',
    lat: 24.79612, lng: 120.9758, rating: 4.5, color: '#FFD700',
    logo: '/logos/50lan.png', // 💡 修正：改為與 MySQL 一致的相對路徑
    toppings: ['波霸'], standardToppings: ['波霸']
  },
  {
    id: 2, name: '椰果奶茶', category: '奶茶', price: 50, store: 'CoCo都可',
    lat: 24.7965, lng: 120.9762, rating: 4.1, color: '#ff6600',
    logo: '/logos/coco.png',
    toppings: ['椰果'], standardToppings: ['椰果']
  },
  {
    id: 3, name: '燕麥鮮奶茶', category: '拿鐵', price: 70, store: '迷客夏',
    lat: 24.7968, lng: 120.9759, rating: 4.6, color: '#83A731',
    logo: '/logos/milksha.png',
    toppings: ['大甲燕麥'], standardToppings: ['燕麥']
  },
  {
    id: 4, name: '冰淇淋紅茶', category: '特調', price: 55, store: '清心福全',
    lat: 24.7955, lng: 120.9752, rating: 3.9, color: '#00a0e9',
    logo: '/logos/chingshin.png',
    toppings: ['香草冰淇淋'], standardToppings: ['冰淇淋']
  },
  {
    id: 5, name: '布丁奶茶', category: '奶茶', price: 65, store: 'MOREiN沫飲',
    lat: 24.7972, lng: 120.9765, rating: 4.3, color: '#7c3aed',
    logo: '/logos/morein.png',
    toppings: ['統一布丁'], standardToppings: ['布丁']
  },
  {
    id: 6, name: '仙草凍奶茶', category: '奶茶', price: 50, store: '清原芋圓',
    lat: 24.7948, lng: 120.9748, rating: 4.2, color: '#4b5563',
    logo: '/logos/chingyuan.png',
    toppings: ['嫩仙草凍'], standardToppings: ['仙草凍']
  },
  {
    id: 7, name: '烤糖蕎麥奶蓋茶', category: '奶蓋茶', price: 60, store: '大茗本位',
    lat: 24.7975, lng: 120.9755, rating: 4.7, color: '#047857',
    logo: '/logos/daming.png',
    toppings: ['芝士奶蓋'], standardToppings: ['奶蓋']
  },
  {
    id: 8, name: '翡翠綠茶', category: '原味茶', price: 35, store: '麻古茶坊',
    lat: 24.7960, lng: 120.9745, rating: 4.4, color: '#dc2626',
    logo: '/logos/macu.png',
    toppings: [], standardToppings: []
  },
  {
    id: 9, name: '水玉烏龍青', category: '原味茶', price: 45, store: '可不可',
    lat: 24.7963, lng: 120.9751, rating: 4.3, color: '#1e3a8a',
    logo: '/logos/kebuke.png',
    toppings: ['水玉'], standardToppings: ['寒天晶球']
  },
  {
    id: 10, name: '粉角手工鮮奶茶', category: '拿鐵', price: 65, store: '上宇林',
    lat: 24.7958, lng: 120.9769, rating: 4.4, color: '#b45309',
    logo: '/logos/shangyulin.png',
    toppings: ['手工粉角'], standardToppings: ['粉角']
  },
  {
    id: 11, name: '柳橙養樂多綠茶', category: '鮮果', price: 60, store: '50嵐',
    lat: 24.79612, lng: 120.9758, rating: 4.2, color: '#FFD700',
    logo: '/logos/50lan.png',
    toppings: ['養樂多'], standardToppings: ['養樂多']
  },
  {
    id: 12, name: '黑糖粉粿鮮奶', category: '特調', price: 70, store: '迷客夏',
    lat: 24.7968, lng: 120.9759, rating: 4.5, color: '#83A731',
    logo: '/logos/milksha.png',
    toppings: ['黑糖粉粿'], standardToppings: ['粉粿']
  },
  {
    id: 13, name: '翡翠茶凍檸檬', category: '鮮果', price: 55, store: '麻古茶坊',
    lat: 24.7960, lng: 120.9745, rating: 4.3, color: '#dc2626',
    logo: '/logos/macu.png',
    toppings: ['綠茶凍'], standardToppings: ['茶凍']
  }
];

export default mockDrinks;