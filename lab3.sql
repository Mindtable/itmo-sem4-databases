-- Найти и вывести на экран название продуктов и название категорий товаров,
-- к которым относится этот продукт,
-- с учетом того, что в выборку попадут только товары с цветом Red и ценой не менее 100.
select p.Name, pc.Name
from Production.Product as p
    join Production.ProductSubcategory as psc
        on p.ProductSubcategoryID = psc.ProductSubcategoryID
    join Production.ProductCategory as pc
        on psc.ProductCategoryID = pc.ProductCategoryID
where p.Color = 'Red'
  and p.ListPrice >= 100

-- Вывести на экран названия подкатегорий с совпадающими именами.
select *
from Production.ProductSubcategory as psc1
    join Production.ProductSubcategory as psc2
        on psc1.Name = psc2.Name
where psc1.ProductSubcategoryID != psc2.ProductSubcategoryID

select psc.Name
from Production.ProductSubcategory as psc
group by psc.Name
having count(*) > 1

-- Вывести на экран название категорий и количество товаров в данной категории.
select pc.Name, count(*)
from Production.ProductCategory as pc
    join Production.ProductSubcategory as psc
        on pc.ProductCategoryID = psc.ProductCategoryID
    join Production.Product as p
        on psc.ProductSubcategoryID = p.ProductSubcategoryID
group by pc.Name

-- Вывести на экран название подкатегории,
-- а также количество товаров в данной подкатегории с учетом ситуации,
-- что могут существовать подкатегории с одинаковыми именами.
select psc.Name, count(distinct p.ProductID)
from Production.ProductSubcategory as psc
    join Production.Product as p
        on psc.ProductSubcategoryID = p.ProductSubcategoryID
group by psc.Name

-- Вывести на экран название первых трех подкатегорий
-- с наибольшим количеством товаров.
select top 3 with ties psc.Name, count(distinct p.ProductID) as ProductCount
from Production.ProductSubcategory as psc
    join Production.Product as p
        on psc.ProductSubcategoryID = p.ProductSubcategoryID
group by psc.Name
order by ProductCount desc

-- Вывести на экран название подкатегории и
-- максимальную цену продукта с цветом Red в этой подкатегории.
select psc.Name, max(p.ListPrice)
from Production.ProductSubcategory as psc
    join Production.Product as p
        on psc.ProductSubcategoryID = p.ProductSubcategoryID
where p.Color = 'Red'
group by psc.Name

-- Вывести на экран название поставщика и количество товаров, которые он поставляет.
select v.Name, count(distinct ProductID)
from Purchasing.ProductVendor as pv
    join Purchasing.Vendor as v
        on v.BusinessEntityID = pv.BusinessEntityID
group by v.Name

-- Вывести на экран название товаров, которые поставляются более чем одним поставщиком.
select p.Name
from Purchasing.ProductVendor as pv
    join Production.Product as p
        on pv.ProductID = p.ProductID
group by pv.ProductID, p.Name
having count(distinct pv.BusinessEntityID) > 1

-- Вывести на экран название самого продаваемого товара.
-- Если смотреть по общему количеству
select top 1 with ties p.Name, sum(sod.OrderQty) as TotalSold
from Sales.SalesOrderDetail as sod
    join Production.Product as p
        on p.ProductID = sod.ProductID
group by sod.ProductID, p.Name
order by TotalSold desc

-- Если смотреть по количеству вендоров
select top 1 with ties p.Name, count(distinct pv.BusinessEntityID) as VendorCount
from Purchasing.ProductVendor as pv
    join Production.Product as p
        on pv.ProductID = p.ProductID
group by p.Name
order by VendorCount desc

-- Вывести на экран название категории, товары из которой продаются наиболее активно.
select top 1 with ties pc.Name, sum(sod.OrderQty) as TotalSold
from Production.ProductCategory as pc
    join Production.ProductSubcategory as psc
        on pc.ProductCategoryID = psc.ProductCategoryID
    join Production.Product as p
        on psc.ProductSubcategoryID = p.ProductSubcategoryID
    join Sales.SalesOrderDetail as sod
        on p.ProductID = sod.ProductID
group by pc.Name
order by TotalSold desc

-- Вывести на экран названия категорий, количество подкатегорий и количество товаров в них.
select
    pc.Name,
    count(distinct psc.ProductSubcategoryID) as SubcategoryCount,
    count(distinct p.ProductID) as ProductCount
from Production.ProductCategory as pc
    join Production.ProductSubcategory as psc
        on pc.ProductCategoryID = psc.ProductCategoryID
    join Production.Product as p
        on psc.ProductSubcategoryID = p.ProductSubcategoryID
group by pc.Name

-- Вывести на экран номер кредитного рейтинга и количество товаров,
-- поставляемых компаниями, имеющими этот кредитный рейтинг.
select v.CreditRating, count( p.ProductID)
from Purchasing.Vendor as v
    join Purchasing.ProductVendor as pv
        on v.BusinessEntityID = pv.BusinessEntityID
    join Production.Product as p
        on pv.ProductID = p.ProductID
group by v.CreditRating

-- или если мы хотим считать уникальные товары
select v.CreditRating, count(distinct p.ProductID)
from Purchasing.Vendor as v
    join Purchasing.ProductVendor as pv
        on v.BusinessEntityID = pv.BusinessEntityID
    join Production.Product as p
        on pv.ProductID = p.ProductID
group by v.CreditRating