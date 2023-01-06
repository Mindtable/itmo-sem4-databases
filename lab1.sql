-- Найти и вывести на экран названия продуктов, их цвет и размер. --
select p.Name, p.Color, p.Size
from Production.Product as p

-- Найти и вывести на экран названия, цвет и размер таких продуктов, у которых цена более 100. --
select p.Name, p.Color, p.Size
from Production.Product as p
where p.ListPrice > 100

-- Найти и вывести на экран название, цвет и размер таких продуктов, у которых цена менее 100 и цвет Black. --
select p.Name, p.Color, p.Size
from Production.Product as p
where p.ListPrice < 100
  and p.Color = 'Black'

-- Найти и вывести на экран название, цвет и размер таких продуктов, --
-- у которых цена менее 100 и цвет Black, упорядочив вывод по возрастанию стоимости продуктов. --
select p.Name, p.Color, p.Size
from Production.Product as p
where p.ListPrice < 100
  and p.Color = 'Black'
order by p.ListPrice

-- Найти и вывести на экран название и размер первых трех самых дорогих товаров с цветом Black.
select top 3 with ties p.Name, p.Color, p.Size
from Production.Product as p
where p.Color = 'Black'
order by p.ListPrice desc

-- Найти и вывести на экран название и цвет таких продуктов, для которых определен и цвет, и размер.
select p.Name, p.Color, p.Size
from Production.Product as p
where p.Color is not null
  and p.Size is not null

-- Найти и вывести на экран не повторяющиеся цвета продуктов,
-- у которых цена находится в диапазоне от 10 до 50 включительно.
select distinct p.Color
from Production.Product as p
where p.ListPrice between 10 and 50
  and p.Color is not null

-- Найти и вывести на экран все цвета таких продуктов, у которых в имени первая буква ‘L’ и третья ‘N’.
select distinct p.Color
from Production.Product as p
where p.Name like 'L_N%'

-- Найти и вывести на экран названия таких продуктов,
-- которых начинаются либо на букву ‘D’, либо на букву ‘M’, и при этом длина имени – более трех символов.
select p.Name
from Production.Product as p
where p.Name like '___%'
  and (p.Name like 'D%' or p.Name like 'M%')

-- Вывести на экран названия продуктов, у которых дата начала продаж – не позднее 2012 года.
select p.Name
from Production.Product as p
where p.SellStartDate < '2013-01-01'

select p.Name
from Production.Product as p
where datepart(year, p.SellStartDate) <= 2012

-- Найти и вывести на экран названия всех подкатегорий товаров.
select subcat.Name
from Production.ProductSubcategory as subcat

-- Найти и вывести на экран названия всех категорий товаров
select cat.Name
from Production.ProductCategory as cat

-- Найти и вывести на экран имена всех клиентов из таблицы Person,
-- у которых обращение (Title) указано как «Mr.».
select p.FirstName
from Person.Person as p
where p.Title = 'Mr.'

-- Найти и вывести на экран имена всех клиентов из таблицы Person,
-- для которых не определено обращение (Title).
select p.FirstName
from Person.Person as p
where p.Title is null