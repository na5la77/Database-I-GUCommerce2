CREATE TABLE [dbo].[Users] (
    [username]   VARCHAR (50) NOT NULL,
    [password]   VARCHAR (50) NULL,
    [first_name] VARCHAR (50) NULL,
    [last_name]  VARCHAR (50) NULL,
    [email]      VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([username] ASC)
);

------------------------------------------------------

CREATE TABLE [dbo].[User_mobile_numbers] (
    [mobile_number] VARCHAR (50) NOT NULL,
    [username]      VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([mobile_number] ASC, [username] ASC),
    FOREIGN KEY ([username]) REFERENCES [dbo].[Users] ([username]) ON DELETE CASCADE ON UPDATE CASCADE
);


------------------------------------------------------------------------
CREATE TABLE [dbo].[User_Addresses] (
    [address]  VARCHAR (50) NOT NULL,
    [username] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([address] ASC, [username] ASC),
    FOREIGN KEY ([username]) REFERENCES [dbo].[Users] ([username]) ON DELETE CASCADE ON UPDATE CASCADE
);

--------------------------------------------------------------------------
CREATE TABLE [dbo].[Customer] (
    [username] VARCHAR (50)    NOT NULL,
    [points]   DECIMAL (10, 2) DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([username] ASC),
    FOREIGN KEY ([username]) REFERENCES [dbo].[Users] ([username]) ON DELETE CASCADE ON UPDATE CASCADE
);

-------------------------------------------------
CREATE TABLE [dbo].[Admins] (
    [username] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([username] ASC),
    FOREIGN KEY ([username]) REFERENCES [dbo].[Users] ([username]) ON DELETE CASCADE ON UPDATE CASCADE
);


------------------------------------------------------------

CREATE TABLE [dbo].[Vendor] (
    [username]       VARCHAR (50) NOT NULL,
    [activated]      BIT          DEFAULT ((0)) NOT NULL,
    [company_name]   VARCHAR (50) NULL,
    [bank_acc_no]    VARCHAR (50) NULL,
    [admin_username] VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([username] ASC),
    FOREIGN KEY ([username]) REFERENCES [dbo].[Users] ([username]) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ([admin_username]) REFERENCES [dbo].[Admins] ([username])
);


------------------------------------------------------------------------

CREATE TABLE [dbo].[Delivery_Person] (
    [username]     VARCHAR (50) NOT NULL,
    [is_activated] BIT          DEFAULT ((0)) NOT NULL,
    PRIMARY KEY CLUSTERED ([username] ASC),
    FOREIGN KEY ([username]) REFERENCES [dbo].[Users] ([username]) ON DELETE CASCADE ON UPDATE CASCADE
);

--------------------------------------------------------------------------------

CREATE TABLE [dbo].[Credit_Card] (
    [number]      VARCHAR (50) NOT NULL,
    [expiry_date] DATE         NULL,
    [cvv_code]    VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([number] ASC)
);

--------------------------------------------------------------------------------

CREATE TABLE [dbo].[Delivery] (
    [id]            INT             IDENTITY (1, 1) NOT NULL,
    [type]          VARCHAR (50)    NULL,
    [time_duration] INT             NULL,
    [fees]          DECIMAL (10, 2) NULL,
    [username]      VARCHAR (50)    NULL,
    PRIMARY KEY CLUSTERED ([id] ASC),
    FOREIGN KEY ([username]) REFERENCES [dbo].[Admins] ([username]) ON UPDATE CASCADE
);


---------------------------------------------------------------------------------
CREATE TABLE [dbo].[Giftcard] (
    [code]        VARCHAR (50) NOT NULL,
    [expiry_date] DATETIME     NULL,
    [amount]      INT          NULL,
    [username]    VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([code] ASC),
    FOREIGN KEY ([username]) REFERENCES [dbo].[Admins] ([username]) ON UPDATE CASCADE
);

------------------------------------------------------------------------------

CREATE TABLE [dbo].[Orders] (
    [order_no]            INT             IDENTITY (1, 1) NOT NULL,
    [order_date]          DATETIME        NULL,
    [total_amount]        DECIMAL (10, 2) NULL,
    [cash_amount]         DECIMAL (10, 2) NULL,
    [credit_amount]       DECIMAL (10, 2) NULL,
    [payment_type]        VARCHAR (50)    NULL,
    [order_status]        VARCHAR (50)    DEFAULT ('not processed') NULL,
    [remaining_days]      INT             NULL,
    [time_limit]          DATETIME        NULL,
    [gift_card_code_used] VARCHAR (50)    NULL,
    [customer_name]       VARCHAR (50)    NULL,
    [delivery_id]         INT             NULL,
    [creditCard_number]   VARCHAR (50)    NULL,
    PRIMARY KEY CLUSTERED ([order_no] ASC),
    FOREIGN KEY ([delivery_id]) REFERENCES [dbo].[Delivery] ([id]),
    FOREIGN KEY ([customer_name]) REFERENCES [dbo].[Customer] ([username]) ON UPDATE CASCADE,
    FOREIGN KEY ([creditCard_number]) REFERENCES [dbo].[Credit_Card] ([number]) ON UPDATE CASCADE,
    FOREIGN KEY ([gift_card_code_used]) REFERENCES [dbo].[Giftcard] ([code]),
    CHECK ([payment_type]='points' OR [payment_type]='credit' OR [payment_type]='cash'),
    CHECK ([order_status]='delivered' OR [order_status]='out for delivery' OR [order_status]='in process' OR [order_status]='not processed')
);

---------------------------------------------------------------------------------------

CREATE TABLE [dbo].[Product] (
    [serial_no]           INT             IDENTITY (1, 1) NOT NULL,
    [product_name]        VARCHAR (50)    NULL,
    [category]            VARCHAR (50)    NULL,
    [product_description] VARCHAR (50)    NULL,
    [price]               DECIMAL (10, 2) NULL,
    [final_price]         DECIMAL (10, 2) NULL,
    [color]               VARCHAR (50)    NULL,
    [available]           BIT             NULL,
    [rate]                INT             NULL,
    [vendor_username]     VARCHAR (50)    NULL,
    [customer_username]   VARCHAR (50)    NULL,
    [customer_order_id]   INT             NULL,
    PRIMARY KEY CLUSTERED ([serial_no] ASC),
    FOREIGN KEY ([vendor_username]) REFERENCES [dbo].[Vendor] ([username]) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ([customer_username]) REFERENCES [dbo].[Customer] ([username]),
    FOREIGN KEY ([customer_order_id]) REFERENCES [dbo].[Orders] ([order_no])
);

---------------------------------------------------------------------------------------------------

CREATE TABLE [dbo].[CustomerAddstoCartProduct] (
    [serial_no]     INT          NOT NULL,
    [customer_name] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([serial_no] ASC, [customer_name] ASC),
    FOREIGN KEY ([customer_name]) REFERENCES [dbo].[Customer] ([username]),
    FOREIGN KEY ([serial_no]) REFERENCES [dbo].[Product] ([serial_no]) ON DELETE CASCADE ON UPDATE CASCADE
);

--------------------------------------------------------------------------------
CREATE TABLE [dbo].[Todays_Deals] (
    [deal_id]        INT          IDENTITY (1, 1) NOT NULL,
    [deal_amount]    INT          NULL,
    [expiry_date]    DATETIME     NULL,
    [admin_username] VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([deal_id] ASC),
    FOREIGN KEY ([admin_username]) REFERENCES [dbo].[Admins] ([username]) ON UPDATE CASCADE
);

----------------------------------------------------------------------------------

CREATE TABLE [dbo].[Todays_Deals_Product] (
    [deal_id]   INT NOT NULL,
    [serial_no] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([deal_id] ASC, [serial_no] ASC),
    FOREIGN KEY ([deal_id]) REFERENCES [dbo].[Todays_Deals] ([deal_id]) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ([serial_no]) REFERENCES [dbo].[Product] ([serial_no])
);

----

CREATE TABLE [dbo].[offer] (
    [offer_id]     INT      IDENTITY (1, 1) NOT NULL,
    [offer_amount] INT      NULL,
    [expiry_date]  DATETIME NULL,
    PRIMARY KEY CLUSTERED ([offer_id] ASC)
);


----
CREATE TABLE [dbo].[offersOnProduct] (
    [offer_id]  INT NOT NULL,
    [serial_no] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([offer_id] ASC, [serial_no] ASC),
    FOREIGN KEY ([offer_id]) REFERENCES [dbo].[offer] ([offer_id]) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ([serial_no]) REFERENCES [dbo].[Product] ([serial_no]) ON DELETE CASCADE ON UPDATE CASCADE
);

-----

CREATE TABLE [dbo].[Customer_Question_Product] (
    [serial_no]     INT          NOT NULL,
    [customer_name] VARCHAR (50) NOT NULL,
    [question]      VARCHAR (50) NULL,
    [answer]        TEXT         NULL,
    PRIMARY KEY CLUSTERED ([serial_no] ASC, [customer_name] ASC),
    FOREIGN KEY ([customer_name]) REFERENCES [dbo].[Customer] ([username]),
    FOREIGN KEY ([serial_no]) REFERENCES [dbo].[Product] ([serial_no]) ON DELETE CASCADE ON UPDATE CASCADE
);


---------
CREATE TABLE [dbo].[Wishlist] (
    [username] VARCHAR (50) NOT NULL,
    [name]     VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([username] ASC, [name] ASC),
    FOREIGN KEY ([username]) REFERENCES [dbo].[Customer] ([username]) ON DELETE CASCADE ON UPDATE CASCADE
);


----------

CREATE TABLE [dbo].[Wishlist_Product] (
    [username]  VARCHAR (50) NOT NULL,
    [wish_name] VARCHAR (50) NOT NULL,
    [serial_no] INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([username] ASC, [wish_name] ASC, [serial_no] ASC),
    FOREIGN KEY ([username], [wish_name]) REFERENCES [dbo].[Wishlist] ([username], [name]) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ([serial_no]) REFERENCES [dbo].[Product] ([serial_no])
);


----------
CREATE TABLE [dbo].[Admin_Customer_Giftcard] (
    [code]             VARCHAR (50)    NOT NULL,
    [customer_name]    VARCHAR (50)    NOT NULL,
    [admin_username]   VARCHAR (50)    NOT NULL,
    [remaining_points] DECIMAL (10, 2) NULL,
    PRIMARY KEY CLUSTERED ([code] ASC, [customer_name] ASC, [admin_username] ASC),
    FOREIGN KEY ([code]) REFERENCES [dbo].[Giftcard] ([code]) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ([customer_name]) REFERENCES [dbo].[Customer] ([username]),
    FOREIGN KEY ([admin_username]) REFERENCES [dbo].[Admins] ([username])
);


------------
CREATE TABLE [dbo].[Admin_Delivery_Order] (
    [delivery_username] VARCHAR (50) NOT NULL,
    [order_no]          INT          NOT NULL,
    [admin_username]    VARCHAR (50) NULL,
    [delivery_window]   VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([delivery_username] ASC, [order_no] ASC),
    FOREIGN KEY ([delivery_username]) REFERENCES [dbo].[Delivery_Person] ([username]) ON UPDATE CASCADE,
    FOREIGN KEY ([admin_username]) REFERENCES [dbo].[Admins] ([username]),
    FOREIGN KEY ([order_no]) REFERENCES [dbo].[Orders] ([order_no])
);

--------------
CREATE TABLE [dbo].[Customer_CreditCard] (
    [customer_name] VARCHAR (50) NOT NULL,
    [cc_number]     VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([customer_name] ASC, [cc_number] ASC),
    FOREIGN KEY ([customer_name]) REFERENCES [dbo].[Customer] ([username]) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY ([cc_number]) REFERENCES [dbo].[Credit_Card] ([number]) ON DELETE CASCADE ON UPDATE CASCADE
);



