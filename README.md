![marketplace_for_the_sale_of_advertising_erd](https://github.com/kuistal/marketplace_for_the_sale_of_advertising/assets/73898978/daf4a64f-d2da-4559-95a9-8886ad81aa4c)
- [x] Минимум пять связанных таблиц
- [x] минимум две отдельные роли (хотя бы одну кроме роли администратора)
- [x] минимум пять типовых запросов к БД
- [x] минимум одну транзакцию
- [x] минимум три локальных переменных с заданным типом данных
- [x] минимум одно условие
- [x] минимум одну хранимую процедуру
- [x] минимум одно представление
- [x] минимум один триггер
- [x] минимум одну пользовательскую функцию
- [x] минимум один обработчик исключений
> [!NOTE]
> Спасибо Жукову Кириллу
> **Типовые запросы**
> 1. Запрос на получение всех доступных рекламных площадок
```sql
SELECT * FROM AdSpaces WHERE Status = 'available';
```
2. Запрос на создание нового заказа
```sql
INSERT INTO Orders (BuyerID, AdSpaceID, OrderDate, Amount, Status) VALUES (5, 19, NOW(), 80.00, 'pending');
```
3. Запрос на обновление статуса заказа после оплаты
```sql
UPDATE Orders SET Status = 'completed' WHERE OrderID = 1 AND BuyerID = 9;
```
4. Запрос на добавление отзыва о рекламной площадке
```sql
INSERT INTO Reviews (AdSpaceID, SellerID, Rating, Comment, CreateDate) VALUES (16, 5, 4, 'Very engaging ad format.', NOW());
```
5. Запрос на подсчёт общего количества продаж по каждому продавцу
```sql
SELECT SellerID, COUNT(*) as TotalSales FROM Orders GROUP BY SellerID;
```
