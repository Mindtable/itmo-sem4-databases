-- Найти и вывести на экран количество товаров каждого цвета,
-- исключив из поиска товары, цена которых меньше 30.
select p.Color, count(*)
from Production.Product as p
where p.ListPrice >= 30
  and p.Color is not null
group by p.Color

-- Найти и вывести на экран список,
-- состоящий из цветов товаров, таких,
-- что минимальная цена товара данного цвета более 100.
select p.Color, min(p.ListPrice) as minPrice
from Production.Product as p
where p.Color is not null
group by p.Color
having min(ListPrice) > 100

-- Найти и вывести на экран номера подкатегорий товаров
-- и количество товаров в каждой категории.
select p.ProductSubcategoryID as number, count(*) as count
from Production.Product as p
where p.ProductSubcategoryID is not null
group by p.ProductSubcategoryID
order by p.ProductSubcategoryID

-- Найти и вывести на экран номера товаров
-- и количество фактов продаж данного товара
-- (используется таблица SalesORDERDetail).
select sod.ProductID, count(*) as SalesCount
from Sales.SalesOrderDetail as sod
group by sod.ProductID
order by sod.ProductID

-- Найти и вывести на экран номера товаров,
-- которые были куплены более пяти раз.
select sod.ProductID, count(*) as SalesCount
from Sales.SalesOrderDetail as sod
group by sod.ProductID
having count(*) > 5
order by sod.ProductID

-- Найти и вывести на экран номера покупателей, CustomerID,
-- у которых существует более одного чека,
-- SalesORDERID, с одинаковой датой
select soh.CustomerID
from Sales.SalesOrderHeader as soh
group by soh.CustomerID, soh.OrderDate
having count(*) > 1
order by soh.CustomerID

-- Найти и вывести на экран все номера чеков,
-- на которые приходится более трех продуктов.
select sod.SalesOrderID
from Sales.SalesOrderDetail as sod
group by sod.SalesOrderID
having count(*) > 3
order by sod.SalesOrderID

-- Общее количество таких рядов
select count(*)
from (
    select sod.SalesOrderID
    from Sales.SalesOrderDetail as sod
    group by sod.SalesOrderID
    having count(*) > 3
) as sSOI

-- Найти и вывести на экран все номера продуктов,
-- которые были куплены более трех раз.
select sod.ProductID, count(distinct sod.SalesOrderID) as count
from Sales.SalesOrderDetail as sod
group by sod.ProductID
having count(distinct sod.SalesOrderID) > 3

-- Найти и вывести на экран все номера продуктов,
-- которые были куплены или три или пять раз.
select sod.ProductID, count(distinct sod.SalesOrderID) as count
from Sales.SalesOrderDetail as sod
group by sod.ProductID
having count(distinct sod.SalesOrderID) = 3
    or count(distinct sod.SalesOrderID) = 5

-- Найти и вывести на экран все номера подкатегорий,
-- в которым относится более десяти товаров.
select p.ProductSubcategoryID, count(*) as count
from Production.Product as p
where p.ProductSubcategoryID is not null
group by p.ProductSubcategoryID
having count(*) > 10

-- Найти и вывести на экран номера товаров,
-- которые всегда покупались в одном экземпляре за одну покупку.
select sod.ProductID
from Sales.SalesOrderDetail as sod
group by sod.ProductID
having max(sod.OrderQty) = 1
order by sod.ProductID

-- Найти и вывести на экран номер чека, SalesORDERID,
-- на который приходится с наибольшим разнообразием товаров купленных на этот чек.
select top 1 sod.SalesOrderID, count(distinct sod.ProductID) as count
from Sales.SalesOrderDetail as sod
group by sod.SalesOrderID
order by count(distinct sod.ProductID) desc

-- Найти и вывести на экран номер чека, SalesORDERID с наибольшей суммой покупки,
-- исходя из того, что цена товара – это UnitPrice,
-- а количество конкретного товара в чеке – это ORDERQty.
select top 1 sod.SalesOrderID
from Sales.SalesOrderDetail as sod
group by sod.SalesOrderID
order by sum(sod.UnitPrice * sod.OrderQty) desc

-- Определить количество товаров в каждой подкатегории,
-- исключая товары,
-- для которых подкатегория не определена, и товары, у которых не определен цвет.
select p.ProductSubcategoryID, count(*) as count
from Production.Product as p
where p.ProductSubcategoryID is not null
  and p.Color is not null
group by p.ProductSubcategoryID

-- Получить список цветов товаров в порядке убывания количества товаров данного цвета
select p.Color, count(*) as ProductCount
from Production.Product as p
where p.Color is not null
group by p.Color
order by ProductCount desc

-- Вывести на экран ProductID тех товаров,
-- что всегда покупались в количестве более 1 единицы на один чек,
-- при этом таких покупок было более двух.
select sod.ProductID
from Sales.SalesOrderDetail as sod
group by sod.ProductID
having count(*) > 2
   and min(sod.OrderQty) = 2