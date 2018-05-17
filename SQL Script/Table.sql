--认购人表
CREATE TABLE Subscriber
(
ID INT IDENTITY(1,1) NOT NULL,
Name NVARCHAR(50) NOT NULL,
IdentityNumber VARCHAR(20) NOT NULL,
Telephone VARCHAR(20) NOT NULL,
Address NVARCHAR(1000) NOT NULL,
ZipCode VARCHAR(10) NOT NULL,
MaritalStatus NVARCHAR(10) NOT NULL,
ResidenceArea NVARCHAR(20) NOT NULL,
WorkArea NVARCHAR(20) NOT NULL,
CreateTime DATETIME NOT NULL,
LastUpdate DATETIME NULL,
 CONSTRAINT [PK_Subscriber] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

--认购人家庭成员
CREATE TABLE SubscriberFamilyMember
(
ID INT IDENTITY(1,1) NOT NULL,
SubscriberID INT NOT NULL,
Name NVARCHAR(50) NOT NULL,
IdentityNumber VARCHAR(20) NOT NULL,
Relationship NVARCHAR(10) NOT NULL,
CreateTime DATETIME NOT NULL,
LastUpdate DATETIME NULL,
 CONSTRAINT [PK_SubscriberFamilyMember] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE SubscriberFamilyMember ADD CONSTRAINT FK_SubscriberFamilyMember_Subscriber_ID FOREIGN KEY(SubscriberID) REFERENCES Subscriber(ID)

--项目表
CREATE TABLE Project
(
ID INT IDENTITY(1,1) NOT NULL,
Number NVARCHAR(20) NOT NULL,
Name NVARCHAR(50) NOT NULL,
Address NVARCHAR(1000) NULL,
CreateTime DATETIME NOT NULL,
LastUpdate DATETIME NULL,
 CONSTRAINT [PK_Project] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

--认购人参与项目关系表
CREATE TABLE SubscriberProjectMapping
(
ID INT IDENTITY(1,1) NOT NULL,
SubscriberID INT NOT NULL,
ProjectID INT NOT NULL,
CreateTime DATETIME NOT NULL,
LastUpdate DATETIME NULL,
 CONSTRAINT [PK_SubscriberProjectMapping] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE SubscriberProjectMapping ADD CONSTRAINT FK_SubscriberProjectMapping_Subscriber_ID FOREIGN KEY(SubscriberID) REFERENCES Subscriber(ID)
ALTER TABLE SubscriberProjectMapping ADD CONSTRAINT FK_SubscriberProjectMapping_Project_ID FOREIGN KEY(ProjectID) REFERENCES Project(ID)

--居室表
CREATE TABLE RoomType
(
ID INT IDENTITY(1,1) NOT NULL,
Name NVARCHAR(10) NOT NULL,
CreateTime DATETIME NOT NULL,
LastUpdate DATETIME NULL,
 CONSTRAINT [PK_RoomType] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

--房源信息表
CREATE TABLE House
(
ID INT IDENTITY(1,1) NOT NULL,
ProjectID INT NOT NULL,
SerialNumber INT NOT NULL,
[Group] NVARCHAR(20) NOT NULL,
[Block] VARCHAR(20) NULL,
Building INT NOT NULL,
Unit INT NOT NULL,
RoomNumber VARCHAR(10) NOT NULL,
RoomTypeID INT NOT NULL,
Toward NVARCHAR(10) NOT NULL,
RoomTypeCode NVARCHAR(10) NOT NULL,
EstimateBuiltUpArea DECIMAL(10,2) NOT NULL,
EstimateLivingArea DECIMAL(10,2) NOT NULL,
AreaUnitPrice DECIMAL(10,2) NOT NULL,
TotalPrice DECIMAL(15,0) NOT NULL,
CreateTime DATETIME NOT NULL,
LastUpdate DATETIME NULL,
 CONSTRAINT [PK_House] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE House ADD CONSTRAINT FK_House_Project_ID FOREIGN KEY(ProjectID) REFERENCES Project(ID)
ALTER TABLE House ADD CONSTRAINT FK_House_RoomType_ID FOREIGN KEY(RoomTypeID) REFERENCES RoomType(ID)


--项目分组表
CREATE TABLE ProjectGroup
(
ID INT IDENTITY(1,1) NOT NULL,
ProjectID INT NOT NULL,
ProjectGroupName NVARCHAR(20) NOT NULL,
CreateTime DATETIME NOT NULL,
LastUpdate DATETIME NULL,
 CONSTRAINT [PK_ProjectGroup] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE ProjectGroup ADD CONSTRAINT FK_ProjectGroup_ProjectID_ID FOREIGN KEY(ProjectID) REFERENCES Project(ID)


--摇号结果表
CREATE TABLE ShakingNumberResult
(
ID INT IDENTITY(1,1) NOT NULL,
ProjectGroupID INT NOT NULL,
SubscriberProjectMappingID INT NOT NULL,
ShakingNumberSequance INT NOT NULL,
ShakingNumber VARCHAR(50) NOT NULL,
CreateTime DATETIME NOT NULL,
LastUpdate DATETIME NULL,
 CONSTRAINT [PK_ShakingNumberResult] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE ShakingNumberResult ADD CONSTRAINT FK_ShakingNumberResult_ProjectGroup_ID FOREIGN KEY(ProjectGroupID) REFERENCES ProjectGroup(ID)
ALTER TABLE ShakingNumberResult ADD CONSTRAINT FK_ShakingNumberResult_SubscriberProjectMapping_ID FOREIGN KEY(SubscriberProjectMappingID) REFERENCES SubscriberProjectMapping(ID)


--后台账号表
CREATE TABLE BackEndAccount
(
ID INT IDENTITY(1,1) NOT NULL,
Account NVARCHAR(100) NOT NULL,
Password NVARCHAR(50) NOT NULL,
CreateTime DATETIME NOT NULL,
LastUpdate DATETIME NULL,
 CONSTRAINT [PK_BackEndAccount] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

--后台账号登陆记录表
CREATE TABLE BackEndAccountLoginRecord
(
ID INT IDENTITY(1,1) NOT NULL,
BackEndAccountID INT NOT NULL,
LoginTime INT NOT NULL,
LoginIP VARCHAR(20) NULL,
 CONSTRAINT [PK_BackEndAccountLoginRecord] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE BackEndAccountLoginRecord ADD CONSTRAINT FK_BackEndAccountLoginRecord_BackEndAccount_ID FOREIGN KEY(BackEndAccountID) REFERENCES BackEndAccount(ID)


--应用账号表
CREATE TABLE ApplicationAccount
(
ID INT IDENTITY(1,1) NOT NULL,
APPID VARCHAR(50) NOT NULL,
APPSECRET VARCHAR(50) NOT NULL,
CreateTime DATETIME NOT NULL,
LastUpdate DATETIME NULL,
 CONSTRAINT [PK_ApplicationAccount] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

--INSERT INTO ApplicationAccount VALUES ('SYY','0B2223C37F54864403847E762E1F87F3',GETDATE(),GETDATE())