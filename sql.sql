USE [Store]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 15/11/2017 9:21:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Customer](
	[Cusname] [nvarchar](50) NOT NULL,
	[cusAddress] [nvarchar](50) NULL,
	[Product_code] [varchar](50) NULL,
	[cusphone] [varchar](50) NULL,
	[Product_Name] [varchar](50) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Cusname] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Import]    Script Date: 15/11/2017 9:21:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import](
	[ID] [int] NOT NULL,
	[DateImport] [datetime] NOT NULL,
 CONSTRAINT [PK_Import] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Import_Product]    Script Date: 15/11/2017 9:21:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Import_Product](
	[ImportId] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_Import_Product] PRIMARY KEY CLUSTERED 
(
	[ImportId] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[OrderDetails]    Script Date: 15/11/2017 9:21:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OrderDetails](
	[OrderDetailID] [int] IDENTITY(1,1) NOT NULL,
	[ProductID] [int] NOT NULL,
	[OrderID] [int] NOT NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_OrderDetails] PRIMARY KEY CLUSTERED 
(
	[OrderDetailID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Orders]    Script Date: 15/11/2017 9:21:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Orders](
	[OrderID] [int] IDENTITY(1,1) NOT NULL,
	[OrderShipAddress] [varchar](50) NOT NULL,
	[OrderDate] [date] NOT NULL,
	[Orderstatus] [varchar](50) NOT NULL,
	[UserID] [int] NOT NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[OrderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 15/11/2017 9:21:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Product](
	[ProductID] [int] IDENTITY(1,1) NOT NULL,
	[ProductName] [varchar](50) NULL,
	[Price] [varchar](50) NULL,
	[Image] [varchar](max) NULL,
	[Description] [varchar](500) NULL,
	[Quantity] [varchar](50) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 15/11/2017 9:21:15 SA ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[UserName] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[Firstname] [varchar](50) NULL,
	[Lastname] [varchar](50) NULL,
	[UserDOB] [varchar](50) NULL,
	[UserEmail] [varchar](50) NULL,
	[UserGender] [varchar](50) NULL,
	[UserPhone] [varchar](50) NULL,
	[UserAddress] [varchar](500) NULL,
	[UserRole] [varchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[Import_Product]  WITH CHECK ADD  CONSTRAINT [FK_Import_Product_Import] FOREIGN KEY([ImportId])
REFERENCES [dbo].[Import] ([ID])
GO
ALTER TABLE [dbo].[Import_Product] CHECK CONSTRAINT [FK_Import_Product_Import]
GO
ALTER TABLE [dbo].[Import_Product]  WITH CHECK ADD  CONSTRAINT [FK_Import_Product_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[Import_Product] CHECK CONSTRAINT [FK_Import_Product_Product]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Orders] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Orders] ([OrderID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Orders]
GO
ALTER TABLE [dbo].[OrderDetails]  WITH CHECK ADD  CONSTRAINT [FK_OrderDetails_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ProductID])
GO
ALTER TABLE [dbo].[OrderDetails] CHECK CONSTRAINT [FK_OrderDetails_Product]
GO
ALTER TABLE [dbo].[Orders]  WITH CHECK ADD  CONSTRAINT [FK_Orders_User] FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Orders] CHECK CONSTRAINT [FK_Orders_User]
GO
