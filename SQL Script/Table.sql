--认购人表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'Subscriber' AND [type] = 'U')
BEGIN
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

END
GO

--INSERT INTO Subscriber VALUES (N'蒋天淳', N'110111199001010001','15051439296',N'北京市东城区中南海','100001',N'已婚',N'东城区',N'东城区',GETDATE(),GETDATE())

--认购人家庭成员
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'SubscriberFamilyMember' AND [type] = 'U')
BEGIN
	CREATE TABLE SubscriberFamilyMember
	(
		ID INT IDENTITY(1,1) NOT NULL,
		SubscriberID INT NOT NULL,
		Name NVARCHAR(50) NOT NULL,
		IdentityNumber VARCHAR(20) NOT NULL,
		Relationship NVARCHAR(10) NOT NULL,
		Area NVARCHAR(50) NOT NULL,
		CreateTime DATETIME NOT NULL,
		LastUpdate DATETIME NULL,
	 CONSTRAINT [PK_SubscriberFamilyMember] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE SubscriberFamilyMember ADD CONSTRAINT FK_SubscriberFamilyMember_Subscriber_ID FOREIGN KEY(SubscriberID) REFERENCES Subscriber(ID)

END
GO



--项目表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'Project' AND [type] = 'U')
BEGIN
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

END
GO

--认购人参与项目关系表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'SubscriberProjectMapping' AND [type] = 'U')
BEGIN
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

END
GO

--居室表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'RoomType' AND [type] = 'U')
BEGIN
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

END
GO


--房源信息表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'House' AND [type] = 'U')
BEGIN
CREATE TABLE House
(
ID INT IDENTITY(1,1) NOT NULL,
ProjectID INT NOT NULL,
SerialNumber INT NOT NULL,
[Group] NVARCHAR(20) NOT NULL,
[Block] NVARCHAR(20) NULL,
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

END
GO

--项目分组表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'ProjectGroup' AND [type] = 'U')
BEGIN
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


END
GO

--摇号结果表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'ShakingNumberResult' AND [type] = 'U')
	BEGIN
	CREATE TABLE ShakingNumberResult
	(
		ID INT IDENTITY(1,1) NOT NULL,
		ProjectGroupID INT NOT NULL,
		SubscriberProjectMappingID INT NOT NULL,
		ShakingNumberSequance INT NOT NULL,
		ShakingNumber VARCHAR(50) NOT NULL,
		NoticeTime INT NOT NULL,
		IsError BIT NOT NULL,
		IsContacted BIT NOT NULL,
		IsCallBack BIT NOT NULL,
		IsMessageSend BIT NOT NULL,
		CreateTime DATETIME NOT NULL,
		LastUpdate DATETIME NULL,
	 CONSTRAINT [PK_ShakingNumberResult] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE ShakingNumberResult ADD CONSTRAINT FK_ShakingNumberResult_ProjectGroup_ID FOREIGN KEY(ProjectGroupID) REFERENCES ProjectGroup(ID)
	ALTER TABLE ShakingNumberResult ADD CONSTRAINT FK_ShakingNumberResult_SubscriberProjectMapping_ID FOREIGN KEY(SubscriberProjectMappingID) REFERENCES SubscriberProjectMapping(ID)

END
GO

--后台账号表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'BackEndAccount' AND [type] = 'U')
BEGIN
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

END
GO

--INSERT INTO BackEndAccount VALUES ('administrator','200CEB26807D6BF99FD6F4F0D1CA54D4',GETDATE(),GETDATE())



--后台账号登陆记录表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'BackEndAccountLoginRecord' AND [type] = 'U')
BEGIN
	CREATE TABLE BackEndAccountLoginRecord
	(
		ID INT IDENTITY(1,1) NOT NULL,
		BackEndAccountID INT NOT NULL,
		LoginTime DATETIME NOT NULL,
		LoginIP VARCHAR(20) NULL,
	 CONSTRAINT [PK_BackEndAccountLoginRecord] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE BackEndAccountLoginRecord ADD CONSTRAINT FK_BackEndAccountLoginRecord_BackEndAccount_ID FOREIGN KEY(BackEndAccountID) REFERENCES BackEndAccount(ID)


END
GO


--应用账号表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'ApplicationAccount' AND [type] = 'U')
BEGIN
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

END
GO
--INSERT INTO ApplicationAccount VALUES ('SYY','0B2223C37F54864403847E762E1F87F3',GETDATE(),GETDATE())


--城市区表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'Area' AND [type] = 'U')
BEGIN
	CREATE TABLE Area
	(
		ID INT IDENTITY(1,1) NOT NULL,
		Name NVARCHAR(10) NOT NULL,
		CityName NVARCHAR(10) NOT NULL,
	 CONSTRAINT [PK_Area] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

END
GO

--INSERT INTO Area VALUES (N'东城区',N'北京市')
--INSERT INTO Area VALUES (N'西城区',N'北京市')
--INSERT INTO Area VALUES (N'朝阳区',N'北京市')
--INSERT INTO Area VALUES (N'海淀区',N'北京市')
--INSERT INTO Area VALUES (N'丰台区',N'北京市')
--INSERT INTO Area VALUES (N'石景山区',N'北京市')
--INSERT INTO Area VALUES (N'顺义区',N'北京市')
--INSERT INTO Area VALUES (N'通州区',N'北京市')
--INSERT INTO Area VALUES (N'大兴区',N'北京市')
--INSERT INTO Area VALUES (N'房山区',N'北京市')
--INSERT INTO Area VALUES (N'门头沟区',N'北京市')
--INSERT INTO Area VALUES (N'昌平区',N'北京市')
--INSERT INTO Area VALUES (N'平谷区',N'北京市')
--INSERT INTO Area VALUES (N'密云区',N'北京市')
--INSERT INTO Area VALUES (N'怀柔区',N'北京市')
--INSERT INTO Area VALUES (N'延庆区',N'北京市')

--项目所属城市区
IF NOT EXISTS (SELECT 1 FROM sys.all_columns WHERE name = N'AreaID' AND object_id = OBJECT_ID(N'Project'))
BEGIN
	ALTER TABLE Project ADD AreaID INT NOT NULL
	ALTER TABLE Project ADD CONSTRAINT FK_Project_AreaID_ID FOREIGN KEY(AreaID) REFERENCES Area(ID)
END
GO


--房源分组表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'HouseGroup' AND [type] = 'U')
BEGIN
	CREATE TABLE HouseGroup
	(
		ID INT IDENTITY(1,1) NOT NULL,
		ProjectID INT NOT NULL,
		Name NVARCHAR(10) NOT NULL,
		CreateTime DATETIME NOT NULL,
		LastUpdate DATETIME NULL,
	 CONSTRAINT [PK_HouseGroup] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

ALTER TABLE HouseGroup ADD CONSTRAINT FK_HouseGroup_ProjectID_ID FOREIGN KEY(ProjectID) REFERENCES Project(ID)

END
GO

IF EXISTS (SELECT 1 FROM sys.columns WHERE [name] = N'Group' AND object_id = OBJECT_ID(N'House'))
BEGIN
	EXEC sp_rename 'House.Group','GroupID','column';
	ALTER TABLE House ALTER COLUMN GroupID INT NOT NULL
	ALTER TABLE House ADD CONSTRAINT FK_House_GroupID_ID FOREIGN KEY(GroupID) REFERENCES HouseGroup(ID)
END
GO


--楼盘表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'HouseEstate' AND [type] = 'U')
BEGIN
	CREATE TABLE HouseEstate
	(
		ID INT IDENTITY(1,1) NOT NULL,
		ProjectID INT NOT NULL,
		Name NVARCHAR(200) NOT NULL,
		CreateTime DATETIME NOT NULL,
		LastUpdate DATETIME NULL,
	 CONSTRAINT [PK_HouseEstate] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE HouseEstate ADD CONSTRAINT FK_HouseEstate_ProjectID_ID FOREIGN KEY(ProjectID) REFERENCES Project(ID)

END
GO

--房源所属楼盘表
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [name] = N'HouseEstateID' AND object_id = OBJECT_ID(N'House'))
BEGIN
	ALTER TABLE House ADD HouseEstateID INT NOT NULL
	ALTER TABLE House ADD CONSTRAINT FK_House_HouseEstateID_ID FOREIGN KEY(HouseEstateID) REFERENCES HouseEstate(ID)
END
GO



--房源所属认购人
IF NOT EXISTS (SELECT 1 FROM sys.all_columns WHERE name = N'SubscriberID' AND object_id = OBJECT_ID(N'House'))
BEGIN
	ALTER TABLE House ADD SubscriberID INT NULL
	ALTER TABLE House ADD CONSTRAINT FK_House_SubscriberID_ID FOREIGN KEY(SubscriberID) REFERENCES Subscriber(ID)
END
GO


--选房与弃选记录表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'HouseSelectionRecord' AND [type] = 'U')
BEGIN
	CREATE TABLE HouseSelectionRecord
	(
		ID INT IDENTITY(1,1) NOT NULL,
		ProjectID INT NOT NULL,
		HouseID INT NOT NULL,
		SubscriberID INT NOT NULL,
		SelectTime DATETIME NOT NULL,
		SelectImageUrl1 NVARCHAR(200) NULL,
		SelectImageUrl2 NVARCHAR(200) NULL,
		SelectImageUrl3 NVARCHAR(200) NULL,
		IsConfirm BIT NOT NULL,
		IsAbandon BIT NOT NULL,
		AbandonTime DATETIME NULL,
		AbandonImageUrl1 NVARCHAR(200) NULL,
		AbandonImageUrl2 NVARCHAR(200) NULL,
		AbandonImageUrl3 NVARCHAR(200) NULL,
		CreateTime DATETIME NOT NULL,
		LastUpdate DATETIME NULL,
	 CONSTRAINT [PK_HouseSelectionRecord] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE HouseSelectionRecord ADD CONSTRAINT FK_HouseSelectionRecord_ProjectID_ID FOREIGN KEY(ProjectID) REFERENCES Project(ID)
	ALTER TABLE HouseSelectionRecord ADD CONSTRAINT FK_HouseSelectionRecord_HouseID_ID FOREIGN KEY(HouseID) REFERENCES House(ID)
	ALTER TABLE HouseSelectionRecord ADD CONSTRAINT FK_HouseSelectionRecord_SubscriberID_ID FOREIGN KEY(SubscriberID) REFERENCES Subscriber(ID)

END
GO

--选房时间段表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'HouseSelectPeriod' AND [type] = 'U')
BEGIN
	CREATE TABLE HouseSelectPeriod
	(
		ID INT IDENTITY(1,1) NOT NULL,
		ShakingNumberResultID INT NOT NULL,
		StartTime DATETIME NOT NULL,
		EndTime DATETIME NOT NULL,
		CreateTime DATETIME NOT NULL,
		LastUpdate DATETIME NULL,
	 CONSTRAINT [PK_HouseSelectPeriod] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE HouseSelectPeriod ADD CONSTRAINT FK_HouseSelectPeriod_ShakingNumberResult_ID FOREIGN KEY(ShakingNumberResultID) REFERENCES ShakingNumberResult(ID)

END
GO


--电话通知记录表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'TelephoneNoticeRecord' AND [type] = 'U')
BEGIN
	CREATE TABLE TelephoneNoticeRecord
	(
		ID INT IDENTITY(1,1) NOT NULL,
		ShakingNumberResultID INT NOT NULL,
		NoticeTime DATETIME NULL,
		ResultType INT NOT NULL,
		CreateTime DATETIME NOT NULL,
		LastUpdate DATETIME NULL,
	 CONSTRAINT [PK_TelephoneNoticeRecord] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE TelephoneNoticeRecord ADD CONSTRAINT FK_TelephoneNoticeRecord_ShakingNumberResult_ID FOREIGN KEY(ShakingNumberResultID) REFERENCES ShakingNumberResult(ID)

END
GO


--前台账号表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'FrontEndAccount' AND [type] = 'U')
BEGIN
	CREATE TABLE FrontEndAccount
	(
		ID INT IDENTITY(1,1) NOT NULL,
		ProjectID INT NOT NULL,
		Account NVARCHAR(100) NOT NULL,
		Password NVARCHAR(50) NOT NULL,
		CreateTime DATETIME NOT NULL,
		LastUpdate DATETIME NULL,
	 CONSTRAINT [PK_FrontEndAccount] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE FrontEndAccount ADD CONSTRAINT FK_FrontEndAccount_Project_ID FOREIGN KEY(ProjectID) REFERENCES Project(ID)

END
GO


--前台账号登陆记录表
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'FrontEndAccountLoginRecord' AND [type] = 'U')
BEGIN
	CREATE TABLE FrontEndAccountLoginRecord
	(
		ID INT IDENTITY(1,1) NOT NULL,
		FrontEndAccountID INT NOT NULL,
		LoginTime DATETIME NOT NULL,
		LoginIP VARCHAR(20) NULL,
	 CONSTRAINT [PK_FrontEndAccountLoginRecord] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE FrontEndAccountLoginRecord ADD CONSTRAINT FK_FrontEndAccountLoginRecord_FrontEndAccount_ID FOREIGN KEY(FrontEndAccountID) REFERENCES FrontEndAccount(ID)


END
GO


--是否认证
IF NOT EXISTS (SELECT 1 FROM sys.all_columns WHERE name = N'IsAuthorized' AND object_id = OBJECT_ID(N'ShakingNumberResult'))
BEGIN
	ALTER TABLE ShakingNumberResult ADD IsAuthorized BIT NOT NULL DEFAULT 0
END
GO




--项目分组与户型规则
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'RoleProjectGroupAndRoomType' AND [type] = 'U')
BEGIN
	CREATE TABLE RoleProjectGroupAndRoomType
	(
		ID INT IDENTITY(1,1) NOT NULL,
		ProjectGroupID INT NOT NULL,
		RoomTypeID INT NOT NULL,
		CreateTime DATETIME NOT NULL,
		LastUpdate DATETIME NULL,
	 CONSTRAINT [PK_RoleProjectGroupAndRoomType] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE RoleProjectGroupAndRoomType ADD CONSTRAINT FK_RoleProjectGroupAndRoomType_ProjectGroup_ID FOREIGN KEY(ProjectGroupID) REFERENCES ProjectGroup(ID)
	ALTER TABLE RoleProjectGroupAndRoomType ADD CONSTRAINT FK_RoleProjectGroupAndRoomType_RoomType_ID FOREIGN KEY(RoomTypeID) REFERENCES RoomType(ID)
END
GO

--项目家庭人数与户型规则
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'RoleFamilyNumberAndRoomType' AND [type] = 'U')
BEGIN
	CREATE TABLE RoleFamilyNumberAndRoomType
	(
		ID INT IDENTITY(1,1) NOT NULL,
		ProjectID INT NOT NULL,
		FamilyNumber INT NOT NULL,
		RoomTypeID INT NOT NULL,
		CreateTime DATETIME NOT NULL,
		LastUpdate DATETIME NULL,
	 CONSTRAINT [PK_RoleFamilyNumberAndRoomType] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE RoleFamilyNumberAndRoomType ADD CONSTRAINT FK_RoleFamilyNumberAndRoomType_Project_ID FOREIGN KEY(ProjectID) REFERENCES Project(ID)
	ALTER TABLE RoleFamilyNumberAndRoomType ADD CONSTRAINT FK_RoleFamilyNumberAndRoomType_RoomType_ID FOREIGN KEY(RoomTypeID) REFERENCES RoomType(ID)

END
GO

--项目分组与房源分组规则
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = N'RoleProjectGroupAndHouseGroup' AND [type] = 'U')
BEGIN
	CREATE TABLE RoleProjectGroupAndHouseGroup
	(

		ID INT IDENTITY(1,1) NOT NULL,
		ProjectGroupID INT NOT NULL,
		HouseGroupID INT NOT NULL,
		CreateTime DATETIME NOT NULL,
		LastUpdate DATETIME NULL,
	 CONSTRAINT [PK_RoleProjectGroupAndHouseGroup] PRIMARY KEY CLUSTERED 
	(
		[ID] ASC
	)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
	) ON [PRIMARY]

	ALTER TABLE RoleProjectGroupAndHouseGroup ADD CONSTRAINT FK_RoleProjectGroupAndHouseGroup_ProjectGroup_ID FOREIGN KEY(ProjectGroupID) REFERENCES ProjectGroup(ID)
	ALTER TABLE RoleProjectGroupAndHouseGroup ADD CONSTRAINT FK_RoleProjectGroupAndHouseGroup_HouseGroup_ID FOREIGN KEY(HouseGroupID) REFERENCES HouseGroup(ID)

END
GO

--认购人表添加家庭人数
IF NOT EXISTS (SELECT 1 FROM sys.columns WHERE [name] = N'FamilyMemberNumber' AND object_id = OBJECT_ID(N'Subscriber'))
BEGIN
	ALTER TABLE Subscriber ADD FamilyMemberNumber INT NOT NULL
END
GO