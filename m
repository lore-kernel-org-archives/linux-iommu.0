Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DAA2080EF
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 14:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308381; cv=fail; b=QVxYHD5zAIU5V6//Whwe8iOxk+KAzPAN5F0A2yl5V1lMZWOm5KoXrvWZgrjIe0xx1YSdOwpYRadhSyGLSCDC3MVGqIXYTQ9vHHOeChft5N3rutm+xojBdP9Y02MVg+QQkduOD0qqpCNwVusSCcKIaYyUkKe3osF7kU9OCHcRKqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308381; c=relaxed/simple;
	bh=ek3xXCmuMWF4F7G/s5nlpLGcJRhC0nj+hQ/HhRca6sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kC21XtC6+WBkjhDeNApHe4SZIsbkHdVIZCRYRykbgkkZ6LX7OqlCMQvh3RCKezd32EqZ9hzpxCjlPHsiX0OAbp4VINSjWeeWod2UWOE5xSCnKaJtO0JohLI3fKXGWP2TDyLS9xmvN6ueq1A4H5lhdws9Ze2n55EVc6MfCvoTWs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t9JDuutQ; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t9JDuutQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrWL2ofFBf07LuNtsRzagsf30zSVWDixyMwNfZVMCdkJvnsWQdwCz/phpHg23focHe+P4Ngv2t6jDAcv8np2jnuyFGrMw3PCLj46FjbfXh5VTSFK5hvjD6bZpf688CGTI30lu/wkx2E4pCpr3XEdHB+GDzanPkvqX87ORWzv3OJaMaU9I7rgPIGIpTB9a+nzZFEc0H6zohOdhl3Uw0NNv71e9Zoe+TbEjNq9Bd+5v2EvYYzBPivlxUWTBtyqworfSo6T7r1lBgADmXujcSvEXKW3yCkRnH6JqXwI3QH4k7GBEl/Rxa2jCzwxMf6pxREmw6OqT1cv33g2uRbBECz8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ek3xXCmuMWF4F7G/s5nlpLGcJRhC0nj+hQ/HhRca6sg=;
 b=x1qmW/i1P+AtuXZHtcMqZCwWpdiubKdhIjH0lGTCHJHnLglfNjgMft6amvhvQj1T/86i41RNF/AeoUknNgf0YlOOtyIwcbqSqOAqgAQse+yYEmG42kjIbb6KAg2dEYQToQolxehoTI+EqwMczuE1S5n3sUO9SILfu+LaxTpTQH4h1OuKgpX2qQ0saIN2I6UrxRoZGBVnK3QL/9iQsxsUVAJ3wQyZn1c1BT//m7de+D8OcK0NuCCwFBW1nv7hZJJo6LgETjPFgYxOI77bXG6W+qxw0SgvbK1s2MuxdjTK6iEdwF9EPQPfTVMMz9FMoGsYI7m1SLRUu6yEdxytpM/p6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ek3xXCmuMWF4F7G/s5nlpLGcJRhC0nj+hQ/HhRca6sg=;
 b=t9JDuutQ/Bef2h0rAd44wzG9fCIh/Xv3RjxtzZO2KUpsfluMYYbCVjJbiqIQ0b3TLRSX+je2wW7g2nTyEIAUFzWr6Ga19o9KcE86XFuGVUi4uHD+UrTb+NUFLenwQxQ1pg9Ga1g1VGsrJwjjnONJt+BEEqEckevIo99H/wWu6lHb2ZP+58Wg+ItY+FTrM36TpbHQANoF4NV0+IrqieZxokJi5PXQzAu9euTX+r0dHANoqPRoMZebU+rAwn+rO6RvmWEfaKf5xbw35KMrFUAN8TEHILumN1po/Z0/yubKVRAg6Z/jIy6H/eHD/1sCfT3y/6twSrGbMrejqRn5HoCAsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 14:32:53 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 14:32:52 +0000
Date: Tue, 18 Mar 2025 11:32:51 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, joro@8bytes.org, baolu.lu@linux.intel.com,
	iommu@lists.linux.dev, nicolinc@nvidia.com
Subject: Re: [PATCH v9 11/21] iommufd/device: Move attached device tracking
 to handle
Message-ID: <20250318143251.GW9311@nvidia.com>
References: <20250313123532.103522-1-yi.l.liu@intel.com>
 <20250313123532.103522-12-yi.l.liu@intel.com>
 <20250318123406.GJ9311@nvidia.com>
 <bafc2cdb-fea5-445b-a7a0-5a1fb390e3f3@intel.com>
 <20250318132652.GS9311@nvidia.com>
 <86c4cba9-5e50-4886-8253-0829e7620a85@intel.com>
 <20250318135609.GU9311@nvidia.com>
 <04b75a34-04cd-40ec-854a-c1a3f0a153c9@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04b75a34-04cd-40ec-854a-c1a3f0a153c9@intel.com>
X-ClientProxiedBy: BN9PR03CA0692.namprd03.prod.outlook.com
 (2603:10b6:408:ef::7) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MN2PR12MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: 03db3348-4781-480f-983f-08dd6629c40a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DLfmXXcx4in5c/H74f6PZ92IkiVT778eHeiDgAOS2fK/2RlhMcl8st4O9UeY?=
 =?us-ascii?Q?+DBikqUN9uipnWB5/YMKMoke1EbZfBK0eDGJ9g98k+b/IjMPy2WKbWtvCUu+?=
 =?us-ascii?Q?0Gi+i2rKHNREuJnsevqYYJw0TUpvLoNjzKXMV4AER6NFrp+/V5mpT5s+eTK4?=
 =?us-ascii?Q?bx1hJpc9LCHe62ycIVogW3NfLi75uTZ+mkkIigXPo+0xJ3K72MjVhosaVRDy?=
 =?us-ascii?Q?3kJ2jg/+RbzxNc+Dw8244RnholnFGP9zUOZ6ecjKhqJWFUu6Zti2cj/JRCJd?=
 =?us-ascii?Q?inOP4y9VAMb2pl53c4qQT/dynaOnTVeYXGyrmhK1biQUWm/qHf+0JKv59i1r?=
 =?us-ascii?Q?Ii9wyTkoqQNd/zIbTAwPo2PKxdrcnPjFqSY1cJbgQdVYWC48EQMVA2U0qlTW?=
 =?us-ascii?Q?TW6q5czB3C5PrFIweyYnRbOS0PWST1LhM0yWOv3PPt3z5B1PGaR1tUTYyPlM?=
 =?us-ascii?Q?blJRwloK4pkSnGI4zM4hebm5BmXmzgQ+2vEx4bftiBEEGlPHZ1jx+Vp9nPOP?=
 =?us-ascii?Q?Il/dGtWBY9lld3ujOcKtAOBA23G9V+lah9mIHodgOln+3q2+C5nYTqP4bkM1?=
 =?us-ascii?Q?I938cOAbwfRYS+7jAfqFw/xvEemHatE48MavVR8XHIlvdF62aWjp0qKDVxjy?=
 =?us-ascii?Q?1teDf4aVK5vcC1M0xZg1V3ZWt98wCA+oq6f3/dW1vK/Tad6z+9xIa8l3O/hu?=
 =?us-ascii?Q?0TMaG/SNkxnKd8gR0p/wnSKOqcEDIxtxhL8HA04yG3C8VQMqlixVlG2p+x+k?=
 =?us-ascii?Q?ATt71VGYQ6zfomusTrvDixeOAM+t8DQGKSef8fQAZZlBUcxib+RdrWZc0ZeH?=
 =?us-ascii?Q?mbryTJbujZ5RPZ7tuooOyhZX9lvg9GF4NsU9YpPUOdQ93LvVMsrNgPZ2cq+1?=
 =?us-ascii?Q?udVZm0M72xKcB4Ocd9hEE8JwEod49ePHC/zDqiGG6Mt+DIuJx+1lKUVWc38q?=
 =?us-ascii?Q?CjPhxq/kEl5lM14SX9dEbZU7o5qWKJuwcmKbp8rdR2dNVyk9VWV3r+yfRuKT?=
 =?us-ascii?Q?HdNKiMvkfEpJOCADZc+TetYRqTBoOsby6ALpX1eXqAlvP2Q942Wzc32meha2?=
 =?us-ascii?Q?8dbASPuJvHcCwom2zTdUbqYeGn+y0iSjqitTWRW7LJrywIcGr3sGYNyK2/l7?=
 =?us-ascii?Q?3e2VrgdYHAsL+t99XMw2nVYkbWguN7hNzuf3sZK3OhvHu+tXN4oQKy1MoPuJ?=
 =?us-ascii?Q?Jq+UrGFc2FtOJunptb8o3E7rcksM+/4GPiMgXQCOzOwJ6whphgqS4cda5nGs?=
 =?us-ascii?Q?/Rm4cNueZzAIM1Hg/fdNoZPUTmRaRD4Dk1KsWG5WBSL+1SF5cy8XOG+c3O3g?=
 =?us-ascii?Q?TgEA/KF1sj6L3c/5EYnWV7uyv2mIK0h9/TQAHD18bgqN/lO/BZDiAitftj/o?=
 =?us-ascii?Q?HHfrCVTUUcz1OCEM7sE6S4btxOqR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jrcJSqDjailW5crg+CcifU87VrJpVHGTKbspYlbSnoG/k0XfdD0D6m0bh4Ab?=
 =?us-ascii?Q?j64tUg8VyQT6/MQ2aKR7gveqqkrR8eGbf/k3jZz0EPCywKDN7mDFUR9tM3Az?=
 =?us-ascii?Q?OWQ8b/q4sOXRV9mmvW/egm0AzC9ulwKBUEfjL8X0NonVzh/S9tEFjxvPap1E?=
 =?us-ascii?Q?szsQ5kpn5moq85zi/TKrZ7MZci3iBMnHuA1qgomwbSdjfd/WI0kmynfSLW49?=
 =?us-ascii?Q?IVrUH3V5PmOLDvgD2TW9AiGDdjM/RTGXmyHGQrIfIzOGqg7nF2FUCc4C6vpD?=
 =?us-ascii?Q?DIktozIWjM1Od5lL4vyEh/3JcjR6KA//jt6wDEiVcvuGPZBRA1aWIFJc8Jw7?=
 =?us-ascii?Q?PfMMfYyrmEgMSyOLdgK/zdMJJowoI1Qjr51UNT1SxsouMI2+sOOmtu+SoTk4?=
 =?us-ascii?Q?/KVtSU9I23HmDUb2B349Vf8qnShGRPwmfaGI1FlgojV2E7jR1/X/FcohFoWn?=
 =?us-ascii?Q?lWBQn0H3wNvaSyOxXs8BDjow8waDrBTp736zro6OK7iRxNH+7Ph5FZ4sFtGs?=
 =?us-ascii?Q?KQJziNjtiqLQqIN6D3ScvxDXOI0Ap0dbZzPpIKwbocyA7Cx7s7tt0hiqRiBW?=
 =?us-ascii?Q?kXYjrvFwS+mtkDUl9SKiGdarX2UmGV5eRJzrzbbQY9n0cGBlq6ndtiohrCeX?=
 =?us-ascii?Q?2GuQnm/i+KQS6IetzAryH/12q7Lz5eusDXm/zopPiPgGcwBJEFhv13hieGq1?=
 =?us-ascii?Q?zVMjemlCqI6x9vBqTJct4YL6AvdmySMjr4iz0/uTRsXOKVhLNhykvr//m1cc?=
 =?us-ascii?Q?ajd//0UOpdS+MD4yuN46rO+WHWKa2oI9J5su29bjA7gydoCAoYOl9DSJhCvT?=
 =?us-ascii?Q?39blGuSNlsA5zq6WRrFfv4hhKNg+8e6VjXI1/xs9/3aXfDVBSKMm+Ag1X5GN?=
 =?us-ascii?Q?WGrgOsuQwCahuQ2uFKN0WseD4Z5KCabxK/GwmAgUdUV5cAswea3csjTpvzt2?=
 =?us-ascii?Q?CqoKvBuyK9q5a11wktNU6+kg6KSKDHkR3o7lJcaLB75+1IyRpE8u2BI89MGH?=
 =?us-ascii?Q?xUblb08RJIS+q5pk6L1n3j+PyV8a+KMbTB0hc0q/9Oepfnj3X1S526cIsB1M?=
 =?us-ascii?Q?TSvSGyFbSj5TFoPHTLgGGOBdbxpSQ8gbvmmL9a0pF1+S76wP9HaSsXPutoZT?=
 =?us-ascii?Q?M0mEZdU71Aq+gSkn9r/DIQ8BFOkplidET2vynFz99ZmwSNyCJkkYNxBQ4kkU?=
 =?us-ascii?Q?PDxnS3Sg1ck13JXPlWv6MsaCqiJGB0dP1/ORSz6HEPp0vNx/TMbQCa/521vN?=
 =?us-ascii?Q?sI9+Br6WrjeeQAPHxD5VJfErAGjANoNEgAXmdtBwFSVmIj7j5lLG85HxhV+Q?=
 =?us-ascii?Q?1DI+bkmbvPhRcHbybKqOJUlWCPV3rUryFNNy9rLUX0R1CGRYGaMrpEg4i5H0?=
 =?us-ascii?Q?C4OVbx5UmAKN8NjuvN6WlEMK/wTjbW9FY5E4lIUFdPSIM4eMEnPPqh0BwMcq?=
 =?us-ascii?Q?GJgssW7451mTwOb5KxCp9VqAC8Gc40SrrMwtWziYJNZX+ox3IPuqeHxhqIem?=
 =?us-ascii?Q?hJwLNzQp0xH7acpowsQwpvI29L/iJqgamQ/uIkQzTG3vjTXtSiCFDUwjIS38?=
 =?us-ascii?Q?cCV4HUFXEdlDibRhhsoj/IOZZacWQhOypoxNM751?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03db3348-4781-480f-983f-08dd6629c40a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 14:32:52.7291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vjqH9xEpQaXJ+g+2ofygMD4noscrY5rS1vFMenByDEhK1hHRqPJnbnkTuAvFG7O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301

On Tue, Mar 18, 2025 at 10:13:41PM +0800, Yi Liu wrote:

> yes. Maybe we can check the stored handle and new handle to fail the same
> handle case. I suppose the attach path is fine if reusing handle since
> the detach path should fence it.

Yes to both

Jason
