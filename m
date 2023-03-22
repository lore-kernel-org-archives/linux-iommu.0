Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6D02F21
	for <iommu@lists.linux.dev>; Wed, 22 Mar 2023 13:41:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMdkkI2ixiwp2L2iyWANhqN7/pA+6aEtl1E0poBKKEbvoBYUz6TZPJwXfiL8H4LlgYPEl6MaDVeosQf4PdZXCGg7p3GNyJm3ihsavU4FrG+lTTYxNNMgQIhfm/BW9ssQEi4Kj1kjYJLNDP5iUcFRqLjc7Q4H5kpHoehtYRpehkGOctATOD5HlTVJ2EPOS99ISP7u2BZjLT4tq5DLmA/3nAzWMye8i9IluSIL3XNDPJxeHHlZaebmjQy39QlqY/1yL80toq5/9/kSRhHqdiMo2IK/L/3uQ98GzKUp6qzs8LXDvmrQMoQvG9m2Ia8bowx41DzMpJ5y4ObBvs8YO31fTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6mXqaen97RTYPyqXLu8oPiw2uv7u4b4yhwS27D4u5k=;
 b=hrCcPX16DfcdTC2tspZ43dCpU2bnYbVHI8Tup0J6gyIqRHUpvXjEcJafPxfpfCniXZX3oYRy3pzDGkZyh3xPXXhzb/BqlLEUuSSzIhruqxyGHL1GmauxzEEi1vQESjp5gHwuw6Pxf+25MEcBKe39SXeEEjtyWD1/d7ffrLH4pjanFNOParL5GbqmIEIBuRsmtcPmSs0C5czRga1cnzjIV6vy0EwWAdYyM49zVhb1Pq80kXow0PMME9JvcjUFtfA6cAhYui//8zi1XP60VIspFADBS1/zwIrl0GsbjPunTfnuP5kXFEf01iiUmy8lfu88YcIq6Tc69LQDleGvJOTBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6mXqaen97RTYPyqXLu8oPiw2uv7u4b4yhwS27D4u5k=;
 b=ea+S6zsGh+tlehuCZaO+WoqmhIfM4IpWVpdexhEZ5herjiW50+JfcwD1r580ld2Rdorq87+cjB2vtwaLGD78ZxoF0v8G2f5O7VBbmS8BkURP9EoOuht57xquFZiSiuvhnqIg7QQoQLeRCf8hY3Kc3vuQ4Inaa85Zt75RNtuxOFzeb2l08LLX5AUJagemt4kta9OiQktzvgmC0bhQoHgahhiFZ+LsE8zRt1ppT8GlO9szglmbT0JBsUwWbQZRRr3SCiTzD1KIyYrsYbim73uH0PyTM054GY5feZyBPYiCh3IRQQUKAnkbsoqVoEPf7/usTaaN4q4VYBjPL3y/IMi4aw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH2PR12MB4183.namprd12.prod.outlook.com (2603:10b6:610:7a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Wed, 22 Mar
 2023 13:41:08 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::ef6d:fdf6:352f:efd1%3]) with mapi id 15.20.6178.037; Wed, 22 Mar 2023
 13:41:08 +0000
Date: Wed, 22 Mar 2023 10:41:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 9/9] iommu: Remove __iommu_group_for_each_dev()
Message-ID: <ZBsFcz3/rTGTmfn/@nvidia.com>
References: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <9-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <ZBr9skYtbsX42UNo@8bytes.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBr9skYtbsX42UNo@8bytes.org>
X-ClientProxiedBy: BL1PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH2PR12MB4183:EE_
X-MS-Office365-Filtering-Correlation-Id: c04b0199-05bc-46df-7aff-08db2adb1772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HvBsgykYtUR/9dMuXs1Muyqfs1XF0LuWSXqGxFNfLMk8cnyrKrvgB0R0/hEo4MhxM6DpNL/KulTJtx2wGlTNeoBl8shPpY4oV15Ipo6fnx4Z2mcbBP4Cb3ONUfFM/BJPB4np4/wpXqoPHo7ixeKpedm9RusUsr0zQR5odZbWLZbQzyVjYYHTt+nTBL+jGP0QvDk9jEc+GgW66OGlExjOQAa2qD2mDYdqPhAdJ5W3MFqkBTnvs8WkzfzsMa9U8ldwy0B3VujkIWQXXicbk/2RoLqwhBInVaGUz548MIr7LbWGEqqGfZgAS5dHNABzw6exkZKv7BLfttmoEa9ZBiHhuh1ev7PpibBZ6x5dDX3byjDdsIkyDQXa9xVgPZETpbv7+JI0WfA885KJN2CT+XDCEvKzgHaXMYcLBpX4x7gGfXk0slFDorStTUAoESBeocACx1fvPHu0rRHoh1oOrAexrt0DWybMDp6zgANXiL2xakzWUHUDI1NHvOnZ/civJBxaZVQpLLyAfA5cwmNpDT5Mi4cKBhsxoSJ8YDydA+Ev9tLLsUD74bCuMNp7M8EunzmudiktKuJQbQlXe5pfVWHl1upcquka2v4CUQp4netpM056rxulrtGGNIRYc4fbAQYInJfxfpz3iXDfCDYhoLcPiw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(39860400002)(136003)(366004)(376002)(396003)(451199018)(2616005)(478600001)(6512007)(316002)(4326008)(107886003)(6506007)(186003)(66476007)(2906002)(54906003)(6486002)(26005)(86362001)(38100700002)(66946007)(66556008)(5660300002)(4744005)(6916009)(41300700001)(36756003)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NwgNScB/7GMLy+/Rf1efLo9j785DGuF4vNBawUXP7+YjofRVyMFnixftH6fQ?=
 =?us-ascii?Q?GhL3uM5VSDJ1ZMl5vtdMTH7S+BXWTjyq2O2x/DHEtCdHc2Z5pE6u1Lp8DSrR?=
 =?us-ascii?Q?KX2ZUCc67MvSF562T/wzSI8jOl7zOyoTzJ73z/4N8QFrSz7yKLibXrvb111s?=
 =?us-ascii?Q?OZQNiv91BwmCa96HGkT9yUyQ5Z4qrn4fTZo1YOnHrljt0a4LqwsfR2OOYRmt?=
 =?us-ascii?Q?/VY7VF1HcNBRKbTp5uKjGWx9+mlp4f52uHHWr06ZOaP/ashtv+XXul6S3IFC?=
 =?us-ascii?Q?uSJbQj4Kgxa4ompK25x21Cu1CyW51z+N3bRGvMgECyhzNKGqGZ/v42Qtr/8W?=
 =?us-ascii?Q?5EOEf28jT1xVm210/cFBJsp1YlWRhOjI+yJLSADYeVe2c9bSLqdYyzt7BOVb?=
 =?us-ascii?Q?cEcIo7R0hxpRUY0kCKobItkKc1ufZ5HJa2Yyk7ZhmVYYWRwFgLHHvnSVvriJ?=
 =?us-ascii?Q?bf/C65P/dReCRC0prB3JvUUnUB4Dmw9Rcnf3mTEhl+nma0t9hwAxkAxqUM+C?=
 =?us-ascii?Q?oJBTQHTO5HcDsl10kHqmgvrqB3pgNtktfGtky+y62yvTKv+GdWK+p1z+mXop?=
 =?us-ascii?Q?A1/HbQb6OFbLEscbX5jalfgtqO+Q2GgAgw960xxssR/3MAdelehjI8GdpKwQ?=
 =?us-ascii?Q?Yq6S5JCRWkQpSMv1CAtb2H6O0islbsQ0YQi4vChSkuhiH6eBwj38uhX6auFM?=
 =?us-ascii?Q?SAsGSlsRyJP2DHRZCt+kxVdscXcipx1AlyY8eKU2l2RhLcSV1qZvDqDpdRMf?=
 =?us-ascii?Q?GxoX4tyyP/xzb3AQPCCw1hpUpybw8S0ezrw8VGlKcq5D6zXlP9X9qlfEPUYN?=
 =?us-ascii?Q?8TEk9xWMA+Wn3yqTu2cpKfYqPdN6T5rDyCtY/Wrkl5GpB6/6x9Z3dlOZjTWF?=
 =?us-ascii?Q?CmC+3hqg3s8nMy6gSmu/E70L+N53p6wIecP7TnAfO52Q2ep6ZeObeA0UFqro?=
 =?us-ascii?Q?CaD0IsEvS9VlcKp01KMwHuyNX1eWxHEnB2nPw6+eVwPce3izd/h+bVIPRFl8?=
 =?us-ascii?Q?Mk8qyjdJ0E8Btm6SdWVVbgGZxsQxKGuaimqnO4VsP6bwj0T0nL+LgYZdjFO9?=
 =?us-ascii?Q?vz7QMVWY/aifmf7lETgWBBqyAMxuylJ6tX6wPF5TNC3nRRwx5+tAF+MdO0jO?=
 =?us-ascii?Q?+De7hXZrRzQ6i4YZo/3XGsdnN0ZvFsl+GZSLIze9lSLAM8Y6f0fYdve9FQSI?=
 =?us-ascii?Q?C8aUqs2/x/pYSS2UPss9o8jR9ScRHlvA/dmuTzZN/VbbXincyg7RnyWUBG3W?=
 =?us-ascii?Q?881dHADX7ECQonkIxWptaEgCU074xrbNN/kCQreOkIz5yz8mm7ACt/lV2yhp?=
 =?us-ascii?Q?cqopSN19Lf8UBVmyrYgqCI+KnyeM+3QLb65pulme5NCGqWtAFICNR+1Dr9qy?=
 =?us-ascii?Q?Eyzi+VWYVmT/vXJvf7Z7meI5KhyeDxkO6JZ/gpRJVFM5SxhP7FnI029h/CVI?=
 =?us-ascii?Q?EPkrYJe574cnfWD2vbzOnRplvmi5SnICaonOt5wDXuPlolati0p4Z9eKsgnN?=
 =?us-ascii?Q?Tcto8U6HcUSv0yB1UAa9F0wLEoytiECouBrG/mAYNpkapiKu6GVBsujU4yq/?=
 =?us-ascii?Q?buOgXoMkiKc7s7To1aYLKqNhCSmyJc0MWDlyB5sL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c04b0199-05bc-46df-7aff-08db2adb1772
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2023 13:41:08.4045
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CfHsyeiJ8c+LvYOPVsgp6tq5VWdchS9jXpIFGpE9BRGHxmVm8wAlfTZNo4Hx9jI0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4183

On Wed, Mar 22, 2023 at 02:08:02PM +0100, Joerg Roedel wrote:
> Hi Jason,
> 
> I like the general direction of this. Just a cosmetic nit below:

Great, it would be good to get Lu's default domain series merged as
this needs to be rebased on top of it

> On Tue, Mar 21, 2023 at 04:53:21PM -0300, Jason Gunthorpe wrote:
> > -	__iommu_group_for_each_dev(group, &gtype,
> > -				   probe_get_default_domain_type);
> > +	list_for_each_entry(gdev, &group->devices, list)
> > +		probe_get_default_domain_type(gdev->dev, &gtype);
> 
> Can you introduce a macro instead? Something like for_each_group_dev()
> or similar. This makes it easier to read in the future.

Yeah, that is a good idea, I'll fold it into the v2

Jason
