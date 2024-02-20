-- Hangi ülkeden kaç adet sipariş aldım?
SELECT c.country, COUNT(o.order_id) as total_orders  FROM customers c 
INNER JOIN orders o ON c.customer_id = o.customer_id 
GROUP BY c.country
-- Ürün kategorilerinin ortalama ürün fiyatı nedir?
select  category_name, avg(unit_price) as "Ortalama" from products p
inner join categories c on c.category_id = p.category_id 
GROUP by category_name
-- Her müşteri için toplam kaç adet sipariş verilmiş?
select contact_name , count(order_id) as "sipariş adedi" from customers c
inner join orders o on o.customer_id = c.customer_id
group by contact_name

-- Her yıl için kaç adet sipariş aldım?
Select extract(YEAR from order_date), COUNT(*) from orders
group by extract(YEAR from order_date) 
order by extract(YEAR from order_date)
-- Hangi çalışanım kaç adet sipariş aldı?
select first_name, count(o.order_id) as "Alınan Sipariş" from orders o
inner join employees e on e.employee_id = o.employee_id
group by first_name
-- Supplier'ları en az sipariş alandan en çok sipariş alana doğru sıralayan query nedir?
select contact_name, count(o.order_id) from suppliers s 
inner join products p on p.supplier_id = s.supplier_id
inner join order_details od on od.product_id = p.product_id
inner join orders o on o.order_id = od.order_id
group by contact_name 
order by count(o.order_id) 
-- Tek bir query içerisinde  sipariş, detay, kullanıcı, çalışan, kargolayacı bilgilerini içeren query'i yazınız.
select * from customers c
inner join orders o on o.customer_id = c.customer_id
inner join order_details od on od.order_id = o.order_id
inner join products p on p.product_id = od.product_id
inner join employees e on e.employee_id = o.employee_id
inner join shippers sh on sh.shipper_id = o.ship_via
-- En kârlı satış yapan çalışanım hangisi?
select first_name ,sum(od.unit_price * od.quantity) from employees e
inner join orders o on o.employee_id = e.employee_id
inner join order_details od on od.order_id = o.order_id
group by first_name
order by sum(od.unit_price * od.quantity) desc limit(1)
-- En çok sipariş veren (adet) müşterim hangisi?
select contact_name, count(o.order_id) from customers c
inner join orders o on c.customer_id = o.customer_id
group by contact_name
order by count(o.order_id) desc limit(1)
-- Siparişleri en geç teslim edilenden en erken teslim edilene doğru sıralayınız (OrderDate ve ShippedDate alanları)
select *, order_date-shipped_date as teslim_süresi from orders
where shipped_date is not NULL
order by teslim_süresi desc













