-- Відобразіть всі можливі комбінації товарів та виробників
SELECT goods.name AS goods_name, manufacturers.name AS manufacturer_name
FROM goods CROSS JOIN manufacturers;

-- Відобразіть пари колег – працівників, що мають одного й того ж начальника
SELECT w1.first_name || ' ' || w1.last_name AS worker1, 
       w2.first_name || ' ' || w2.last_name AS worker2, 
       w1.chief AS common_chief
FROM workers w1 
JOIN workers w2 ON w1.chief = w2.chief AND w1.passport_no < w2.passport_no
WHERE w1.chief IS NOT NULL;

-- Відобразіть дані про виробника кожного з товарів
SELECT goods.name AS goods_name, manufacturers.name AS manufacturer_name, manufacturers.address
FROM goods 
JOIN manufacturers ON goods.manufacturer_code = manufacturers.code;

-- Відобразіть інформацію про подружні пари серед працівників
SELECT h.first_name || ' ' || h.last_name AS husband, 
       w.first_name || ' ' || w.last_name AS wife
FROM marriage 
JOIN workers h ON marriage.husband_passport_no = h.passport_no
JOIN workers w ON marriage.wife_passport_no = w.passport_no;

-- Відобразіть дані про те, які товари на яких складах зберігаються
SELECT warehouses.name AS warehouse_name, goods.name AS goods_name, holds.amount
FROM holds 
JOIN warehouses ON holds.warehouse_code = warehouses.code
JOIN goods ON holds.goods_code = goods.code;

-- Для кожного складу відобразіть ПІБ його керівника
SELECT warehouses.name AS warehouse_name, 
       workers.first_name || ' ' || workers.last_name AS chief_name
FROM warehouses 
JOIN workers ON warehouses.chief_passport_no = workers.passport_no;

-- Відобразіть дані про товари, що наявні в кількості принаймні 15 одиниць хоча б на одному зі складів
SELECT DISTINCT goods.name, holds.amount
FROM holds 
JOIN goods ON holds.goods_code = goods.code
WHERE holds.amount >= 15;

-- Відобразіть всю інформацію про товари, які зберігаються на складах мережі супермаркетів
SELECT goods.*
FROM goods
WHERE code IN (SELECT DISTINCT goods_code FROM delivered);

-- Відобразіть всю інформацію про товари, які НЕ зберігаються на складах мережі супермаркетів
SELECT goods.*
FROM goods
WHERE code NOT IN (SELECT DISTINCT goods_code FROM delivered);

-- Відобразіть всю інформацію про неодружених працівників
SELECT * FROM workers
WHERE passport_no NOT IN (SELECT husband_passport_no FROM marriage)
  AND passport_no NOT IN (SELECT wife_passport_no FROM marriage);

-- Відобразіть всю інформацію про працівників, які НЕ керують складами
SELECT * FROM workers
WHERE passport_no NOT IN (SELECT chief_passport_no FROM warehouses);
