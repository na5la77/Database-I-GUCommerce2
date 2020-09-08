
CREATE PROC customerRegister
@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50)
AS
IF((@username NOT IN (SELECT username FROM Users )) and @username IS NOT NULL and @first_name IS NOT NULL and @last_name IS NOT NULL and @password IS NOT NULL and @email IS NOT NULL )
BEGIN
INSERT INTO Users VALUES(@username,@password,@first_name,@last_name,@email);
INSERT INTO Customer VALUES (@username,0)
PRINT('Successfully created')
END
ELSE
PRINT('This username is already taken');
GO
-----------------------------------------------------------

CREATE PROC vendorRegister
@username VARCHAR(20),
@first_name VARCHAR(20),
@last_name VARCHAR(20),
@password VARCHAR(20),
@email VARCHAR(50),
@company_name VARCHAR(20),
@bank_acc_no VARCHAR(20)
AS
IF((@username NOT IN (SELECT username FROM Users )) and @username IS NOT NULL and @first_name IS NOT NULL and @last_name IS NOT NULL and @password IS NOT NULL and @email IS NOT NULL and @company_name IS NOT NULL and @bank_acc_no IS NOT NULL )
BEGIN
INSERT INTO Users VALUES(@username,@password,@first_name,@last_name,@email);
INSERT INTO Vendor VALUES(@username,0,@company_name,@bank_acc_no,NULL);
PRINT('Successfully created')
END
ELSE
PRINT('Username already taken');
GO
-----------------------------------------------------------

CREATE PROC userLogin
@username VARCHAR(20),
@password VARCHAR(20),
@success BIT OUTPUT,
@type INT OUTPUT
AS
IF( EXISTS(SELECT * FROM Users WHERE username=@username and password=@password) )
BEGIN
SET @success=1;
IF(@username IN (SELECT username FROM Customer))
SET @type=0

ELSE IF (@username IN (SELECT username FROM Admins))
SET @type=2
ELSE IF(@username IN (SELECT username FROM Delivery_Person))
SET @type=3
ELSE IF (@username IN (SELECT username FROM Vendor WHERE activated='1'))
SET @type=1
ELSE IF (@username IN (SELECT username FROM Vendor WHERE activated='0'))
BEGIN
PRINT('Vendor not activated')
END
END
ELSE
BEGIN
SET @success=0
SET @type=-1
PRINT('INCORRECT USERNAME OR PASSWORD')
END
GO
-----------------------------------------------------------

CREATE PROC addMobile
@username VARCHAR(20),
@mobile_number VARCHAR(20)
AS
IF (@mobile_number='')
Begin
PRINT('Please enter a number')
END
ELSE IF(@username IN (SELECT username FROM Users) and not exists ( select * from User_mobile_numbers where username =@username and mobile_number = @mobile_number))
BEGIN
INSERT INTO User_mobile_numbers(mobile_number,username) VALUES(@mobile_number,@username)
print('added successfully')
END
else 
print('You have already added this number')
GO
-----------------------------------------------------------
CREATE PROC addAddress
@username VARCHAR(20),
@address VARCHAR(100)
AS
IF(@username IN (SELECT username FROM Users))
BEGIN
INSERT INTO User_Addresses VALUES(@address, @username)
END
GO
---------------------------------------------------------

CREATE PROC showProducts
AS
SELECT product_name,product_description, price, final_price, color  FROM Product
GO
---------------------------------------------------------

CREATE PROC ShowProductsbyPrice
AS
SELECT serial_no,product_name,product_description, price, final_price, color 
FROM Product 
ORDER BY final_price
GO
-----------------------------------------

CREATE PROC searchbyname
@text VARCHAR(20)
AS
SELECT product_name,product_description, price, final_price, color 
FROM Product 
where product_name LIKE '%' +@text+ '%'
GO
-----------------------------------------

CREATE PROC AddQuestion
@serial INT,
@customer VARCHAR(20),
@question VARCHAR(50)
AS
IF(@customer IN (SELECT username FROM Customer))
BEGIN
INSERT INTO Customer_Question_Product VALUES(@serial,@customer,@question,NULL);
END
GO
-----------------------------------------

CREATE PROC addToCart
@customername VARCHAR(20),
@serial INT
AS
IF EXISTS(SELECT * FROM Product WHERE serial_no=@serial and available='1')
BEGIN
	IF((@customername IN (SELECT username FROM Customer)))
	BEGIN
		IF NOT EXISTS(SELECT * FROM CustomerAddstoCartProduct WHERE customer_name = @customername AND serial_no=@serial)
		BEGIN
		INSERT INTO CustomerAddstoCartProduct VALUES (@serial,@customername)
		PRINT ('Added to cart succefully')
		END
		ELSE 
		PRINT('You have this product in your cart')	
		END

		
END
ELSE
PRINT('Product Unavailable or Wrong serial number')
GO
-----------------------------------------

CREATE PROC removefromCart
@customername VARCHAR(20),
@serial INT
AS
IF NOT EXISTS(SELECT * FROM Product WHERE serial_no=@serial)
BEGIN
PRINT('Product Unavailable or Wrong serial number')
END
ELSE IF EXISTS(SELECT * FROM CustomerAddstoCartProduct WHERE customer_name = @customername AND serial_no=@serial)
		BEGIN
		Delete from CustomerAddstoCartProduct where (serial_no = @serial AND customer_name=@customername)
		PRINT ('Removed Successfully')
		END
		ELSE 
		PRINT('You do not have this product in your cart')
GO
-----------------------------------------

CREATE PROC createWishlist
@customername VARCHAR(20),
@name VARCHAR(20)
AS
IF (@name = '')
BEGIN
print ('Please choose wishlist name')
end

else IF(@customername IN (SELECT username FROM Customer))
BEGIN
	IF NOT EXISTS (SELECT username,name FROM Wishlist WHERE username = @customername AND name = @name )
	BEGIN
	INSERT INTO Wishlist VALUES(@customername,@name)
	PRINT ('Created Succefully')
	END
	ELSE
	PRINT ('You already have a wishlist with the same name')
END
ELSE
PRINT('YOU ARE NOT A REGISTERED CUSTOMER')
GO
-----------------------------------------

CREATE PROC AddtoWishlist
@customername VARCHAR(20),
@wishlistname VARCHAR(20),
@serial INT
AS
IF (@serial IN (SELECT serial_no FROM Product))
BEGIN
	IF(@customername IN (SELECT username FROM Customer))
	BEGIN
		IF((@customername IN (SELECT username FROM Wishlist)) AND @wishlistname IN (SELECT name FROM Wishlist) )
		BEGIN
			IF NOT EXISTS (SELECT serial_no FROM Wishlist_Product WHERE username = @customername AND wish_name=@wishlistname AND serial_no = @serial)
			BEGIN
			INSERT INTO Wishlist_Product VALUES(@customername,@wishlistname,@serial);
			Print('Added Succefully')
			END
			ELSE 
			PRINT ('You already have this product in this wishlist')
		END
		ELSE
		PRINT('WISHLIST DOES NOT EXIST');
	END
	ELSE
	PRINT('YOU ARE NOT A REGISTERED CUSTOMER')
END
ELSE
PRINT ('This Product does not exist')
GO
-----------------------------------------

CREATE PROC removefromWishlist
@customername VARCHAR(20),
@wishlistname VARCHAR(20),
@serial INT
AS
IF (@serial IN (SELECT serial_no FROM Product))
BEGIN
	IF(@customername IN (SELECT username FROM Customer))
	BEGIN
		IF((@customername IN (SELECT username FROM Wishlist)) AND @wishlistname IN (SELECT name FROM Wishlist) )
		BEGIN
			IF EXISTS (SELECT serial_no FROM Wishlist_Product WHERE username = @customername AND wish_name=@wishlistname AND serial_no = @serial)
			BEGIN
			DELETE FROM Wishlist_Product WHERE (serial_no = @serial AND username=@customername AND wish_name=@wishlistname);
			Print('Removed Succefully')
			END
			ELSE 
			PRINT ('You do not have this product in this wishlist')
		END
		ELSE
		PRINT('WISHLIST DOES NOT EXIST');
	END
	ELSE
	PRINT('YOU ARE NOT A REGISTERED CUSTOMER')
END
ELSE
PRINT ('This Product does not exist')
GO
-----------------------------------------

CREATE PROC showWishlistProduct
@customername VARCHAR(20),
@wishlistname VARCHAR(20)

AS
IF(@customername IN (SELECT username FROM Customer))
BEGIN
	IF(EXISTS (SELECT username FROM Wishlist WHERE username=@customername and name=@wishlistname ))
	
	SELECT product_name,product_description, price, final_price, color
	FROM Wishlist_Product W
	INNER JOIN Product P ON P.serial_no=W.serial_no
	WHERE W.username=@customername and @wishlistname= W.wish_name;

	ELSE
	PRINT('WISHLIST DOES NOT EXIST');
END
ELSE
PRINT('YOU ARE NOT A REGISTERED CUSTOMER')
GO
-----------------------------------------

CREATE PROC viewMyCart
@customer VARCHAR(20)

AS
IF(@customer IN (SELECT username FROM Customer))
BEGIN
	SELECT P.serial_no,P.product_name,P.product_description, P.price, P.final_price, P.color 
	FROM CustomerAddstoCartProduct C
	INNER JOIN Product P ON C.serial_no=P.serial_no
	WHERE C.customer_name=@customer
END
ELSE
PRINT('YOU ARE NOT A REGISTERED CUSTOMER')
GO
-----------------------------------------

CREATE PROC calculatepriceOrder
@customername VARCHAR(20),
@sum decimal(10,2) OUTPUT

AS
IF(@customername IN (SELECT username FROM Customer))
BEGIN
	SELECT @sum=SUM(P.final_price) 
	FROM CustomerAddstoCartProduct C
	INNER JOIN Product P ON C.serial_no=P.serial_no
	WHERE C.customer_name=@customername
END
ELSE
PRINT('YOU ARE NOT A REGISTERED CUSTOMER')
GO
-----------------------------------------
CREATE PROC productsinorder
@customername VARCHAR(20),
@orderID INT
AS



Update Product
SET customer_order_id=@orderID, available='0', customer_username=@customername
WHERE serial_no  IN (SELECT serial_no
FROM CustomerAddstoCartProduct
Where customer_name=@customername)

SELECT * FROM Product WHERE customer_username=@customername and customer_order_id=@orderID;


DELETE FROM CustomerAddstoCartProduct
WHERE customer_name<>@customername and serial_no IN (SELECT serial_no
FROM CustomerAddstoCartProduct
WHERE customer_name=@customername)
GO
-----------------------------------------

CREATE PROC emptyCart
@customername VARCHAR(20)

AS
IF(@customername IN (SELECT username FROM Customer))
BEGIN
	DELETE FROM CustomerAddstoCartProduct 
	WHERE @customername= customer_name
END
ELSE
PRINT('YOU ARE NOT A REGISTERED CUSTOMER')
GO
-----------------------------------------
CREATE PROC makeOrder
@customername VARCHAR(20)
AS
DECLARE @id INT;

IF(EXISTS(SELECT * FROM CustomerAddstoCartProduct WHERE customer_name=@customername))
BEGIN
DECLARE @price DECIMAL(10,2);
EXEC calculatepriceOrder @customername, @price OUTPUT;

INSERT INTO Orders(order_date,total_amount,customer_name) VALUES(CURRENT_TIMESTAMP,@price,@customername);

SELECT @id=max(order_no) FROM Orders

EXEC productsinorder @customername, @id;

EXEC emptyCart @customername;

END
ELSE
BEGIN
PRINT('Please add items to your cart before ordering');
END
GO
-----------------------------------------

CREATE PROC cancelOrder
@orderid INT
AS
IF EXISTS(SELECT * FROM Orders WHERE order_no=@orderid and (order_status = 'not processed' or order_status = 'in process') )
BEGIN
UPDATE Product
SET customer_order_id=NULL, available='1',customer_username=NULL
WHERE customer_order_id=@orderid

DECLARE @giftcode VARCHAR(50);

DECLARE @paidPoints DECIMAL(10,2);
DECLARE @paidCash DECIMAL(10,2);
DECLARE @paidCredit DECIMAL(10,2);
DECLARE @paidTotal DECIMAL(10,2);

DECLARE @customerUsername VARCHAR(50);

SELECT @customerUsername=customer_name,@giftcode=gift_card_code_used, @paidCash=cash_amount, @paidCredit=credit_amount, @paidTotal=total_amount
FROM Orders 
WHERE order_no=@orderid

if(EXISTS(SELECT * FROM Giftcard WHERE code=@giftcode AND (expiry_date>= CURRENT_TIMESTAMP)))
BEGIN

SET @paidPoints= @paidTotal -(@paidCash+@paidCredit);

UPDATE Customer
SET points=points+@paidPoints
WHERE username=@customerUsername


UPDATE Admin_Customer_Giftcard
SET remaining_points =remaining_points+ @paidPoints
WHERE code=@giftcode

END

DELETE FROM Orders 
WHERE order_no=@orderid and (order_status = 'not processed' or order_status = 'in process');
PRINT('You have successfully canceled your order');
END
ELSE
PRINT('You can only cancel orders that are not processed or in process');
GO
-----------------------------------------

CREATE PROC returnProduct
@serialno int,
@orderid int
AS

DECLARE @giftcode VARCHAR(50);

DECLARE @paidPoints DECIMAL(10,2);
DECLARE @paidCash DECIMAL(10,2);
DECLARE @paidCredit DECIMAL(10,2);
DECLARE @paidTotal DECIMAL(10,2);

DECLARE @customerUsername VARCHAR(50);

SELECT @customerUsername=customer_name,@giftcode=gift_card_code_used, @paidCash=cash_amount, @paidCredit=credit_amount, @paidTotal=total_amount
FROM Orders 
WHERE order_no=@orderid

if(EXISTS(SELECT * FROM Product WHERE serial_no=@serialno and customer_order_id=@orderid ))
BEGIN
if(EXISTS(SELECT * FROM Giftcard WHERE code=@giftcode AND (expiry_date>= CURRENT_TIMESTAMP)))
BEGIN

SET @paidPoints= @paidTotal -(@paidCash+@paidCredit);

DECLARE @price DECIMAL(10,2);

SELECT @price=final_price
FROM Product
WHERE serial_no=@serialno

if @paidPoints >= @price 
BEGIN
UPDATE Customer
SET points=points+@price
WHERE username=@customerUsername

UPDATE Admin_Customer_Giftcard
SET remaining_points = remaining_points+@price
WHERE code=@giftcode

Update Orders
SET total_amount = total_amount-@price
WHERE order_no=@orderid

END

ELSE
BEGIN

UPDATE Customer
SET points=points+@paidPoints
WHERE username=@customerUsername

UPDATE Admin_Customer_Giftcard
SET remaining_points = remaining_points+@paidPoints
WHERE code=@giftcode

Update Orders
SET total_amount = total_amount-@price
WHERE order_no=@orderid

END

END

UPDATE Product
SET customer_order_id=NULL, available='1', customer_username=null
WHERE customer_order_id=@orderid and serial_no=@serialno
END
ELSE
PRINT('ERROR')
GO
-----------------------------------------

CREATE PROC ShowproductsIbought
@customername VARCHAR(20)
AS
SELECT  P.product_name,P.product_description, P.price, P.final_price, P.color  FROM Product P WHERE customer_username=@customername
GO
-----------------------------------------

CREATE PROC rate
@serialno int,
@rate int ,
@customername VARCHAR(20)
AS
IF EXISTS(SELECT * FROM Product WHERE serial_no=@serialno and customer_username=@customername)
BEGIN
UPDATE Product
SET rate=@rate
WHERE serial_no=@serialno and customer_username=@customername
END
ELSE
PRINT 'ERROR'
GO
-----------------------------------------
CREATE PROC SpecifyAmount
@customername VARCHAR(20), @orderID int, @cash decimal(10,2), @credit decimal(10,2)
AS

DECLARE @pointsToPay DECIMAL(10,2);
DECLARE @totalAmount DECIMAL(10,2);
DECLARE @giftcode VARCHAR(50);

SELECT @giftcode=code
FROM Admin_Customer_Giftcard
WHERE customer_name=@customername

SELECT @totalAmount=total_amount 
FROM Orders
WHERE order_no=@orderID



DECLARE @pointsHave DECIMAL(10,2);

SELECT @pointsHave =points
FROM Customer
WHERE username=@customername


IF ((@cash)>=@totalAmount and @credit=0)
begin
UPDATE Orders
SET cash_amount=@totalAmount,
payment_type='cash',
credit_amount=0
WHERE order_no=@orderID

PRINT('You have successfully chosen the amount to be paid');

end
else if (@cash = 0 and @credit=0 and @pointsHave >= @totalAmount and EXISTS(SELECT * FROM Giftcard WHERE @giftcode=code and expiry_date>=CURRENT_TIMESTAMP ) )
begin
SET @pointsToPay= @totalAmount
UPDATE Orders
SET cash_amount=@cash,
gift_card_code_used=@giftcode,
payment_type='points',
credit_amount=0
WHERE order_no=@orderID



UPDATE Customer
SET points=points-@pointsToPay
WHERE username=@customername


UPDATE Admin_Customer_Giftcard
SET remaining_points =remaining_points- @pointsToPay
WHERE code=@giftcode

PRINT('You have successfully chosen the amount to be paid');
end

else IF ((@cash+@pointsHave)>=@totalAmount and @credit=0 and EXISTS(SELECT * FROM Giftcard WHERE @giftcode=code and expiry_date>=CURRENT_TIMESTAMP ))
BEGIN
SET @pointsToPay= @totalAmount-@cash;
UPDATE Orders
SET cash_amount=@cash,
gift_card_code_used=@giftcode,
payment_type='cash',
credit_amount=0
WHERE order_no=@orderID


UPDATE Customer
SET points=points-@pointsToPay
WHERE username=@customername


UPDATE Admin_Customer_Giftcard
SET remaining_points =remaining_points- @pointsToPay
WHERE code=@giftcode

PRINT('You have successfully chosen the amount to be paid');
END

else if ((@cash+@pointsHave)< @totalAmount and @credit=0)
begin
print('cash plus points less than amount')
END


ELSE 
IF ((@credit)>=@totalAmount and @cash=0)
begin
UPDATE Orders
SET credit_amount=@totalAmount,
payment_type='credit',
cash_amount=0
WHERE order_no=@orderID

PRINT('You have successfully chosen the amount to be paid');
end


else IF ((@credit+@pointsHave)>=@totalAmount and @cash=0 and EXISTS(SELECT * FROM Giftcard WHERE @giftcode=code and expiry_date>=CURRENT_TIMESTAMP ))
BEGIN
SET @pointsToPay= @totalAmount-@credit;
UPDATE Orders
SET credit_amount=@credit,
gift_card_code_used=@giftcode,
payment_type='credit',
cash_amount=0
WHERE order_no=@orderID


UPDATE Customer
SET points=points-@pointsToPay
WHERE username=@customername


UPDATE Admin_Customer_Giftcard
SET remaining_points =remaining_points- @pointsToPay
WHERE code=@giftcode

PRINT('You have successfully chosen the amount to be paid');
END

else if ((@credit+@pointsHave)< @totalAmount and @cash=0)
begin
print('credit plus points less than amount')
END

ELSE
Print('error')
GO
-----------------------------------------

CREATE PROC AddCreditCard
@creditcardnumber VARCHAR(20),
@expirydate DATE,
@cvv VARCHAR(4),
@customername VARCHAR(20)
AS
IF (@creditcardnumber = '')
BEGIN
print ('Please insert your card number')
end
ELSE IF (@cvv = '')
BEGIN
print ('Please insert your cvv')
end
ELSE IF (@expirydate = '')
BEGIN
print ('Please insert your card expiry date')
end

Else IF (@expirydate>=CURRENT_TIMESTAMP)
BEGIN
	IF NOT EXISTS(SELECT * FROM Customer_CreditCard WHERE customer_name= @customername AND cc_number = @creditcardnumber)
	BEGIN
	INSERT INTO Credit_Card VALUES(@creditcardnumber,@expirydate,@cvv);
	INSERT INTO Customer_CreditCard VALUES(@customername,@creditcardnumber);
	PRINT ('Added successfully')
	END
	ELSE
	PRINT('You have added this credit previously')
END
ELSE 
PRINT ('This credit card has already expired')
GO
-----------------------------------------

CREATE PROC ChooseCreditCard
@creditcard VARCHAR(20), 
@orderid int
AS
IF(EXISTS(SELECT * 
FROM Customer_CreditCard CC
INNER JOIN Credit_Card C ON CC.cc_number=C.number
INNER JOIN Orders O ON O.customer_name=CC.customer_name
WHERE (C.expiry_date>=CURRENT_TIMESTAMP) AND O.customer_name=CC.customer_name ))
BEGIN
Update Orders
SET creditCard_number=@creditcard
WHERE order_no=@orderid

PRINT('The transaction was successful')
END
GO
-----------------------------------------

CREATE PROC viewDeliveryTypes
AS
SELECT * FROM Delivery
GO
-----------------------------------------

CREATE PROC specifydeliverytype
@orderID int,
@deliveryID int
AS
DECLARE @remainingdays int;

SELECT @remainingdays=time_duration
FROM Delivery
WHERE id=@deliveryID


UPDATE Orders
SET delivery_id=@deliveryID,
remaining_days=@remainingdays,
time_limit=@remainingdays+ CURRENT_TIMESTAMP
WHERE order_no=@orderID
GO
-----------------------------------------

CREATE PROC trackRemainingDays
@orderid int, 
@customername VARCHAR(20),
@days int OUTPUT
AS
UPDATE Orders
SET remaining_days=day(time_limit-CURRENT_TIMESTAMP)
WHERE order_no=@orderid and customer_name=@customername

SELECT @days=remaining_days
FROM Orders
WHERE order_no=@orderid and customer_name=@customername
GO
-----------------------------------------

--------------------------------------------------------------K
CREATE proc recommmend
@customername VARCHAR(20)
AS

DECLARE @topthreecategories TABLE
(
  categorey VARCHAR(30) ,
  countcategory int 
)
INSERT INTO @topthreecategories (categorey , countcategory)
select top(3) f.category , COUNT (f.category)
                     from Product f inner join CustomerAddstoCartProduct c on f.serial_no = c.serial_no
                     where c.customer_name = @customername
                     group by f.category
                     order by count (f.category)  desc 
--select* from @topthreecategories
-------------------------------------------------------------------------------------------------------------first part
declare @customerproducts table
(
 serial int 
 )
insert into @customerproducts (serial)
select serial_no
from CustomerAddstoCartProduct
where customer_name = @customername

--select* from @customerproducts

DECLARE @similaruser TABLE
(
 customer_name VARCHAR(30)  ,
  countsimilar int 
)

insert into @similaruser (customer_name , countsimilar)
select top (3) customer_name , count(customer_name)
                      from CustomerAddstoCartProduct 
                      where (customer_name <> @customername) and (serial_no  in (select serial from @customerproducts))
				      group by customer_name 
                      order by count (customer_name ) desc

declare @wishedbysimilarusers table
( 
 serial_no int,
 g int
 )
 insert into  @wishedbysimilarusers (serial_no,g)
 select top (3) serial_no , count(serial_no) c
 from Wishlist_Product
 where username in (select customer_name from @similaruser) 
 group by serial_no
 order by c desc 


  --select* from @wishedbysimilarusers
-----------------------------------------------------------------------------------------------------------------second part					  
DECLARE @products1 TABLE
(
serial_no VARCHAR (50) ,
count1 int
)
insert into @products1(serial_no , count1)
select top(3) p.serial_no, COUNT(p.serial_no)
from Product p inner join Wishlist_Product w on w.serial_no = p.serial_no
where p.category in (select categorey from @topthreecategories)
group by p.serial_no
order by count(p.serial_no) desc

--select* from @products1

 DECLARE @products TABLE
(
    [serial_no]           INT              ,
    [product_name]        VARCHAR (50)   ,
    [category]            VARCHAR (50)   ,
    [product_description] VARCHAR (50)   ,
	[price]                decimal(10,2) ,
    [final_price]         DECIMAL (10, 2) ,
    [color]               VARCHAR (50)    ,
    [available]           BIT            ,
    [rate]                INT            ,
    [vendor_username]     VARCHAR (50)    ,
    [customer_username]   VARCHAR (50)    ,
    [customer_order_id]   INT             
)




insert into @products (serial_no,product_name,category,product_description,price,final_price,color,available,rate,vendor_username,customer_username,customer_order_id)
select  p.serial_no,p.product_name,p.category,p.product_description,p.price,p.final_price,color,p.available,p.rate,p.vendor_username,p.customer_username,p.customer_order_id
from Product p inner join  @wishedbysimilarusers w on p.serial_no = w.serial_no 

--select*from @products



insert into @products (serial_no,product_name,category,product_description,price,final_price,color,available,rate,vendor_username,customer_username,customer_order_id)
select p.serial_no,p.product_name,p.category,p.product_description,p.price,p.final_price,color,p.available,p.rate,p.vendor_username,p.customer_username,p.customer_order_id
from Product p inner join @products1 pp on p.serial_no = pp.serial_no


select * from @products
GO
-----------------------------------------
--VENDOR
--Vendors
--a
CREATE PROC postProduct
@vendorUsername VARCHAR(20),
@product_name VARCHAR(20),
@category VARCHAR(20), 
@product_description text, 
@price decimal(10,2), 
@color VARCHAR(20)
AS
IF (@vendorUsername IN (select username from vendor where activated = 1) ) and (@vendorUsername IS NOT NULL and @product_name IS NOT NULL AND @category IS NOT NULL AND
@product_description IS NOT NULL AND @price IS NOT NULL AND @color IS NOT NULL)

BEGIN

INSERT INTO Product (vendor_username , product_name , category , product_description , price,final_price , color, available )
VALUES(@vendorUsername, @product_name, @category, @product_description, @price,@price, @color, '1') ;
print('added successfully');
END

ELSE
print ('ERROR') ;
GO
-----------------------------------------

--------------------------------------b
CREATE PROC vendorviewProducts 
@vendorname VARCHAR(20) 
AS 

IF (@vendorname IN (select username from vendor where activated = 1) ) 

BEGIN

select  *
from product 
where vendor_username = @vendorname 

END 

ELSE 
print ('ERROR')
GO
-----------------------------------------


---------------------------------------c
CREATE PROC  EditProduct
 @vendorname VARCHAR(20), 
 @serialnumber int, 
 @product_name VARCHAR(20),
 @category VARCHAR(20),
 @product_description text, 
 @price decimal(10,2), 
 @color VARCHAR(20) 

 AS
 IF ( @serialnumber IN (select serial_no from Product ) and (@vendorname IN (select username from vendor where activated = 1) ) and EXISTS(
 SELECT * FROM Vendor V INNER JOIN Product P ON V.username=P.vendor_username
 WHERE V.username=@vendorname and P.serial_no=@serialnumber) ) 

 BEGIN 

 UPDATE PRODUCT 
 set vendor_username = @vendorname , product_name = @product_name , category = @category , product_description = @product_description , price = @price , color = @color
 WHERE serial_no =  @serialnumber 
 print('updated successfully');

 END 

 ELSE 
 PRINT ('Wrong serial number');
GO
-----------------------------------------
------------------------------------------d
CREATE PROC deleteProduct 
@vendorname VARCHAR(20), 
@serialnumber int

AS 

IF (@vendorname IN (select username from Vendor where activated = 1) ) and  (@serialnumber IN (select serial_no from Product) and EXISTS(
 SELECT * FROM Vendor V INNER JOIN Product P ON V.username=P.vendor_username
 WHERE V.username=@vendorname and P.serial_no=@serialnumber) )

BEGIN 

DELETE FROM Product WHERE serial_no = @serialnumber 

END 

ELSE 
PRINT('ERROR') ;
GO
-----------------------------------------

------------------------------------------e
CREATE PROC viewQuestions
@vendorname VARCHAR(20)

AS 

IF (@vendorname IN (select username from vendor where activated = 1) ) 

BEGIN 

select cq.question
from Customer_Question_Product cq
inner join Product p on cq.serial_no = p.serial_no 
where vendor_username = @vendorname 

END 

ELSE
PRINT('ERROR')
GO
-----------------------------------------

----------------------------------------------f
CREATE PROC answerQuestions 
@vendorname VARCHAR(20), 
@serialno int, 
@customername VARCHAR(20), 
@answer text

AS

IF ((@vendorname IN (select username from vendor where activated = 1)) and (@customername in (select username from Customer )) and @serialno in (select serial_no from Product )and EXISTS(
 SELECT * FROM Vendor V INNER JOIN Product P ON V.username=P.vendor_username
 WHERE V.username=@vendorname and P.serial_no=@serialno) and (@serialno in ( select serial_no from Customer_Question_Product where serial_no = @serialno) )) 

BEGIN 

UPDATE Customer_Question_Product 
SET answer = @answer 
where (serial_no = @serialno) and (customer_name = @customername )

END 

ELSE 
PRINT ('ERROR')
GO
-----------------------------------------

--------------------------------------------------g
CREATE PROC addOffer
@offeramount int, 
@expiry_date datetime 

AS 
INSERT INTO offer ( offer_amount , expiry_date)
VALUES ( @offeramount , @expiry_date ) ;
print('added successfully')
GO
-----------------------------------------

---------------------------------------------------h
CREATE PROC checkOfferonProduct
@serial int,
@active BIT OUTPUT 

AS 

DECLARE @activeoffer int

IF ( @serial in ( select serial_no from Product ))

begin

select @activeoffer = count(offer_id)
from offersOnProduct 
where serial_no = @serial 

if (@activeoffer > 0)
begin
set @active = 1 
--print(@active)
end
if (@activeoffer = 0)
begin
set @active = 0
--print(@active)
end

end 

else 

print('ERROR')

return @active
GO
-----------------------------------------


----------------------------------------------i
CREATE PROC checkandremoveExpiredoffer
@offerid int

AS 

IF ( @offerid in (select offer_id from offer))

begin 

declare @offerdate datetime

select @offerdate = expiry_date
from offer 
where offer_id = @offerid 

IF  @offerdate < CURRENT_TIMESTAMP 

BEGIN 

update product
set final_price = price 
where serial_no in ( select c.serial_no from product c inner join offersOnProduct p on c.serial_no = p.serial_no where p.offer_id = @offerid )

DELETE FROM offer WHERE offer_id = @offerid ;
DELETE FROM offersOnProduct WHERE offer_id = @offerid ;
print('removed successfully')

END 

ELSE 

PRINT('offer not expired');
end 
else 

print ('offer id does not exist') ;
GO
-----------------------------------------

----------------------------------------------------j
CREATE PROC applyOffer
@vendorname VARCHAR(20), 
@offerid int, 
@serial int

AS

declare @active bit 
if(@serial in (select serial_no from Product))
begin
exec checkOfferonProduct @serial , @active output
end
declare @offeramount int 
select @offeramount = offer_amount
from offer 
where offer_id = @offerid 



IF ((@vendorname not IN (select username from Vendor where activated = 1)) or (@offerid not in (select offer_id from offer )) )
begin 
print ('offer id does not exist')
end
else if(not EXISTS(SELECT * FROM Vendor V INNER JOIN Product P ON V.username=P.vendor_username
 WHERE V.username=@vendorname and P.serial_no=@serial))
 begin
print('wrong serial number')
end
else if( EXISTS (select expiry_date from offer where offer_id = @offerid and expiry_date < CURRENT_TIMESTAMP)   ) 
begin
print ('offer expeired')
end

ELSE if ( @serial in (select serial_no from offersOnProduct))
begin

print ('already has an active offer')
end

ELSE 
begin

update Product 
set final_price = (price-(@offeramount*0.01)*price)
where serial_no = @serial  
insert into offersOnProduct (offer_id , serial_no) 
values (@offerid , @serial) 
print('applied succesfully');
end
GO
-----------------------------------------
--SHADI BEGIN
--ADMINS
--A):

CREATE PROCEDURE activateVendors @admin_username VARCHAR(20),@vendor_username VARCHAR(20)
AS
if exists(SELECT username from Admins where username = @admin_username)
begin
IF EXISTS(SELECT username FROM Vendor WHERE username = @vendor_username)
BEGIN
UPDATE Vendor 
SET admin_username = @admin_username, activated = 1
WHERE username = @vendor_username
END
ELSE 
PRINT ('This vendor does not exist')
end
else
PRINT ('This admin does not exist')
GO
-----------------------------------------

--B):
CREATE PROCEDURE inviteDeliveryPerson @delivery_username VARCHAR(20), @delivery_email VARCHAR(20)
AS
INSERT INTO Users (username, email)
VALUES(@delivery_username,  @delivery_email)
INSERT INTO Delivery_Person (username) 
VALUES (@delivery_username)
GO
-----------------------------------------

--C):
CREATE PROCEDURE reviewOrders
AS
SELECT * FROM Orders
GO
-----------------------------------------

--D):
CREATE PROCEDURE updateOrderStatusInProcess @Order_no INT
AS
IF EXISTS(SELECT order_no FROM Orders WHERE order_no = @order_no)
BEGIN
UPDATE Orders
SET order_status = 'in process'
WHERE order_no = @Order_no
END
ELSE
PRINT('Wrong Order Number')
GO
-----------------------------------------

--E):
CREATE PROCEDURE addDelivery @delivery_type VARCHAR(20),@time_duration int,@fees decimal(5,3),@admin_username VARCHAR(20)
AS
if exists (select username from Admins where username = @admin_username)
BEGIN
INSERT INTO Delivery
VALUES(@delivery_type, @time_duration, @fees, @admin_username)
END
ELSE 
print('wrong admin username')
GO
-----------------------------------------

--F): 
CREATE PROCEDURE assignOrdertoDelivery @delivery_username VARCHAR(20), @order_no int, @admin_username VARCHAR(20)
AS
IF EXISTS (SELECT username FROM Admins WHERE username=@admin_username)
BEGIN
	IF EXISTS (SELECT order_no FROM Orders WHERE order_no=@order_no)
	BEGIN
		IF EXISTS (SELECT username FROM Delivery_Person WHERE username=@delivery_username)
		BEGIN
			IF ((SELECT is_activated  FROM Delivery_Person WHERE username = @delivery_username) = 1)
			BEGIN
			INSERT INTO Admin_Delivery_Order (delivery_username, order_no, admin_username)
			VALUES (@delivery_username, @order_no, @admin_username)
			END
			ELSE
			PRINT 'This Delivery person is not activated'
		END
		ELSE 
		PRINT ('Wrong delivery person name')
	END
	ELSE
	PRINT('Wrong Order Number')
END
ELSE
PRINT ('Wrong admin name')
GO
-----------------------------------------

--G):
CREATE PROCEDURE createTodaysDeal @deal_amount int,@admin_username VARCHAR(20),@expiry_date datetime
AS
if (@expiry_date>=CURRENT_TIMESTAMP)
begin
if exists (select username from Admins where username = @admin_username)
begin
INSERT INTO Todays_Deals 
VALUES(@deal_amount, @expiry_date, @admin_username)
end
else print('Wrong admin')
end
else
print('the deal is already expired')
GO
-----------------------------------------
CREATE PROCEDURE checkTodaysDealOnProduct @serial_no INT, @activeDeal BIT OUTPUT
AS
IF EXISTS(SELECT serial_no FROM Product WHERE serial_no = @serial_no)
BEGIN
	IF EXISTS (SELECT * FROM Todays_Deals_Product WHERE serial_no = @serial_no)
	BEGIN
	SET @activeDeal = 1
	PRINT ('This product has a deal active on it')
	END
	ELSE
	BEGIN
	SET @activeDeal = 0
	PRINT ('This product does not have a deal active on it')
	END
END
ELSE
PRINT('This product does not exist')
GO
-----------------------------------------

CREATE PROCEDURE addTodaysDealOnProduct @deal_id INT, @serial_no INT --CHECK
AS
if NOT exists(select serial_no from Todays_Deals_Product where serial_no=@serial_no)
begin
if exists (select expiry_date from Todays_Deals where deal_id=@deal_id and expiry_date>=CURRENT_TIMESTAMP)
begin
IF EXISTS(SELECT deal_id FROM Todays_Deals WHERE deal_id=@deal_id) AND EXISTS(SELECT serial_no FROM Product WHERE serial_no=@serial_no)
BEGIN
INSERT INTO Todays_Deals_Product 
VALUES(@deal_id, @serial_no)
DECLARE @deal_amount INT
SET @deal_amount = (SELECT deal_amount
FROM Todays_Deals
WHERE deal_id = @deal_id)
UPDATE Product
SET final_price = price * (1-(@deal_amount*0.01))
WHERE serial_no = @serial_no
END
ELSE
PRINT('Wrong input')
end
else 
print ('This deal is expired')
end
else print('this product has a todays deal already')
GO
-----------------------------------------
CREATE PROCEDURE removeExpiredDeal @deal_id INT
AS
IF EXISTS ( SELECT deal_id FROM Todays_Deals WHERE deal_id=@deal_id  )
BEGIN

DECLARE @serial INT
DECLARE @date DATETIME
SELECT @serial = serial_no FROM Todays_Deals_Product WHERE deal_id = @deal_id
SELECT @date = expiry_date FROM Todays_Deals WHERE deal_id = @deal_id 


IF( @date < CURRENT_TIMESTAMP)
BEGIN
UPDATE Product 
SET final_price = price
WHERE serial_no = @serial
DELETE FROM Todays_Deals WHERE deal_id = @deal_id 
END
ELSE 
PRINT 'This deal is not expired yet'

END 
ELSE 
PRINT 'This deal is incorrect'
GO
-----------------------------------------

--H):
CREATE PROCEDURE createGiftCard @code VARCHAR(10),@expiry_date datetime,@amount int,@admin_username VARCHAR(20)
AS
if (@expiry_date>=CURRENT_TIMESTAMP)
begin
if exists(select username from Admins where username=@admin_username)
begin
INSERT INTO Giftcard
VALUES (@code, @expiry_date, @amount, @admin_username)
end
else print ('wrong admin')
end 
else 
print('the expiry date has already past')
GO
-----------------------------------------

--I)
CREATE PROCEDURE removeExpiredGiftCard @code VARCHAR(10)
AS
IF EXISTS ( SELECT code FROM Giftcard WHERE code=@code  )
BEGIN
	DECLARE @amount DECIMAL (10,2)
	DECLARE @date DATETIME
	DECLARE @user VARCHAR(50)
	SET @date = (SELECT expiry_date FROM Giftcard WHERE code = @code)
	SET @amount = (SELECT amount FROM Giftcard WHERE code = @code)
	SET @user = (SELECT customer_name FROM Admin_Customer_Giftcard WHERE code = @code)
		IF (@date < CURRENT_TIMESTAMP)
		BEGIN
		UPDATE Customer
		SET points = points - @amount
		WHERE username = @user
		DELETE FROM Giftcard
		WHERE code = @code
		END
		ELSE
		PRINT ('This giftcard is not expired yet')
		END
ELSE
PRINT ('Wrong giftcard code')
GO
-----------------------------------------

CREATE PROCEDURE checkGiftCardOnCustomer @code VARCHAR(10), @activeGiftCard BIT OUTPUT
AS
IF EXISTS (SELECT code FROM Giftcard WHERE code= @code)
BEGIN
	IF EXISTS (
	SELECT * FROM Admin_Customer_Giftcard
	WHERE code = @code )
	BEGIN 
	SET @activeGiftCard = 1
	END
	ELSE 
	SET @activeGiftCard = 0
if @activeGiftCard = 1
begin
PRINT ('This giftcard is assigned to a customer')
end 
else
PRINT ('Giftcard is not assigned to any customer')

END
ELSE 
PRINT ('Code does not exist')
GO
-----------------------------------------
CREATE PROCEDURE giveGiftCardtoCustomer @code VARCHAR(10),@customer_name VARCHAR(20),@admin_username VARCHAR(20)  
AS
if exists (select expiry_date from Giftcard where code=@code and expiry_date>=CURRENT_TIMESTAMP)
begin
DECLARE @amount DECIMAL (10,2)
SELECT @amount = amount FROM Giftcard WHERE code = @code
	IF EXISTS(SELECT code FROM Giftcard WHERE code=@code)
	BEGIN
		IF EXISTS(SELECT username FROM Customer WHERE username=@customer_name)
		BEGIN
			IF EXISTS(SELECT username FROM Admins WHERE username=@admin_username)
			BEGIN
			INSERT INTO Admin_Customer_Giftcard
			VALUES (@code, @customer_name, @admin_username, @amount)
			UPDATE Customer
			SET points = @amount + points
			WHERE username = @customer_name
			END
			ELSE 
			PRINT ('Wrong Admin username')
		END
		ELSE
		PRINT ('Wrong Customer username')
	END
	ELSE 
	PRINT('Wrong Giftcard Code')
end
else
print ('this giftcard is expired')
GO
-----------------------------------------
--DELIVERY_PERSON
--A): 
CREATE PROCEDURE acceptAdminInvitation @delivery_username VARCHAR(20)
AS
IF EXISTS (SELECT username FROM Delivery_Person WHERE username = @delivery_username)
BEGIN
UPDATE Delivery_Person
SET is_activated = 1
WHERE username = @delivery_username
END
ELSE
PRINT ('The username entered is incorrect')
GO
-----------------------------------------

--B):
CREATE PROCEDURE deliveryPersonUpdateInfo @username VARCHAR(20),@first_name VARCHAR(20),@last_name VARCHAR(20),@password VARCHAR(20),
@email VARCHAR(50)
AS
IF EXISTS(SELECT username FROM Users WHERE username=@username)
BEGIN
UPDATE Users
SET first_name = @first_name, last_name = @last_name, password = @password, email = @email
WHERE username = @username
END
ELSE
PRINT('Wrong username')
GO
-----------------------------------------

--C): 
CREATE PROCEDURE viewMyOrders @deliveryperson VARCHAR (20)
AS
IF EXISTS (SELECT username FROM Delivery_Person WHERE username = @deliveryperson)
BEGIN
SELECT * FROM Orders WHERE order_no IN (SELECT order_no FROM Admin_Delivery_Order WHERE delivery_username = @deliveryperson)
END
ELSE
PRINT('Wrong Deliery Person Username')
GO
-----------------------------------------

--D):
CREATE PROCEDURE specifyDeliveryWindow @delivery_username VARCHAR(20),@order_no int,@delivery_window VARCHAR(50)
AS
IF EXISTS(SELECT order_no FROM Orders WHERE order_no = @order_no)
BEGIN
	IF EXISTS(SELECT username FROM Delivery_Person WHERE username = @delivery_username)
	BEGIN
		UPDATE Admin_Delivery_Order 
		SET delivery_window = @delivery_window
		WHERE delivery_username = @delivery_username AND order_no = @order_no
		END
	ELSE
	PRINT('Wrong Delivery Person Username')
END
ELSE
PRINT('Wrong Order Number')
GO
-----------------------------------------

--E):
CREATE PROCEDURE updateOrderStatusOutforDelivery @order_no INT
AS
IF EXISTS(SELECT order_no FROM Orders WHERE order_no = @order_no)
BEGIN
UPDATE Orders
SET order_status = 'out for delivery'
WHERE order_no = @order_no
END
ELSE
PRINT('Wrong Order Number')
GO
-----------------------------------------
--F):
CREATE PROCEDURE updateOrderStatusDelivered @order_no INT
AS
IF EXISTS(SELECT order_no FROM Orders WHERE order_no = @order_no)
BEGIN
UPDATE Orders
SET order_status = 'delivered'
WHERE order_no = @order_no
END
ELSE
PRINT('Wrong Order Number')
GO
-----------------------------------------











































