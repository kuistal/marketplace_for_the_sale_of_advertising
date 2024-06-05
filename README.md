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



 ## ТИПОВЫЕ ЗАПРОСЫ
**1. Запрос на получение всех доступных рекламных площадок**
```sql
SELECT * FROM AdSpaces WHERE Status = 'available';
```
**2. Получение всех заказов пользователя по UserID**
```sql
SELECT * FROM Orders WHERE UserID = 1;
```
**3. Получение всех отзывов для конкретной рекламной площадки**
```sql
SELECT * FROM Reviews WHERE AdSpaceID = 1;
```
**4. Получение всех транзакций по OrderID**
```sql
SELECT * FROM Transactions WHERE OrderID = 1;
```
**Запрос 5: Получение средней оценки для рекламной площадки**
```sql
SELECT AdSpaceID, AVG(Rating) as AverageRating 
FROM Reviews 
WHERE AdSpaceID = 1 -- Замените 1 на нужный AdSpaceID
GROUP BY AdSpaceID;
```

## Транзакция

**Процедура для обработки платежей, включает проверку баланса покупателя:**

```sql
START TRANSACTION;

-- Создание заказа
INSERT INTO Orders (UserID, AdSpaceID, OrderDate, Amount, Status) 
VALUES (1, 1, NOW(), 50.00, 'pending');

-- Получение ID созданного заказа
SET @OrderID = LAST_INSERT_ID();

-- Создание транзакции
INSERT INTO Transactions (OrderID, TransactionDate, Amount, Type) 
VALUES (@OrderID, NOW(), 50.00, 'debit');

COMMIT;
```

## ТРИГЕР

**Триггер, автоматического обновления статуса рекламной площадки после создания заказа:**
```sql
CREATE TRIGGER UpdateAdSpaceStatusAfterOrder
AFTER INSERT ON Orders
FOR EACH ROW
BEGIN
    UPDATE AdSpaces
    SET Status = 'unavailable'
    WHERE AdSpaceID = NEW.AdSpaceID;
END 
```

## ПОЛЬЗОВАТЕЛЬСКАЯ ФУНКЦИЯ

**Функция длядля получения средней оценки рекламной площадки:**

```sql

CREATE FUNCTION GetAverageRating(p_AdSpaceID INT) 
RETURNS DECIMAL(3,2)
DETERMINISTIC
BEGIN
    DECLARE v_AvgRating DECIMAL(3,2);

    SELECT AVG(Rating) INTO v_AvgRating
    FROM Reviews
    WHERE AdSpaceID = p_AdSpaceID;

    RETURN v_AvgRating;
END 
```

## РОЛИ

**Все доступные ролли admin,moderator,user **

```sql
CREATE ROLE IF NOT EXISTS admin;
CREATE ROLE IF NOT EXISTS moderator;
CREATE ROLE IF NOT EXISTS user;


GRANT ALL PRIVILEGES ON *.* TO admin;

GRANT SELECT, INSERT, UPDATE, DELETE ON AdSpaces TO moderator;
GRANT SELECT, INSERT, UPDATE, DELETE ON Reviews TO moderator;


GRANT SELECT ON AdSpaces TO user;
GRANT INSERT ON Orders TO user;
GRANT INSERT ON Reviews TO user;
```
