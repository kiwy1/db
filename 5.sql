-- 1. Список назв товарів через кому для кожного виробника
SELECT m.name AS manufacturer, GROUP_CONCAT(g.name, ', ') AS products
FROM goods g
JOIN manufacturers m ON g.manufacturer_code = m.code
GROUP BY m.name;

-- 2. Для кожного виробника кількість товарів ціною менше 20 гривень
SELECT m.name AS manufacturer, COUNT(*) AS count_under_20
FROM goods g
JOIN manufacturers m ON g.manufacturer_code = m.code
WHERE g.price < 20
GROUP BY m.name;

-- 3. Середня ціна всіх товарів
SELECT AVG(price) AS average_price FROM goods;

-- 4. Виробники, що виготовляють більше одного товару ціною менше 20 гривень
SELECT m.name AS manufacturer
FROM goods g
JOIN manufacturers m ON g.manufacturer_code = m.code
WHERE g.price < 20
GROUP BY m.name
HAVING COUNT(*) > 1;
