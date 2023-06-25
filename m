Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2078.outbound.protection.outlook.com [40.107.212.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB00B8BE2
	for <iommu@lists.linux.dev>; Sun, 25 Jun 2023 18:55:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lP0mdKtJE26Hg47gJoAR8sHI4wXvQ7cvKpVJeNzdtmyi1t4iEPKYlw9BDhlVqg7BgvoHzGoJyRDSWc/UzbmNo80vMbxkeRUeucIjL6Ulen8wWRjlOEU8RLBTYf4KzYUrSAqqTuI4nw0ceiG6/2F7ac80QWQUnY8VFZQFbk0BjRnMpJ+6l9GZCCgPR02teuixV87fN27eiGUkvZ3pP0IKOd1c6Zcjdl8l5AqXQW+OOLA9NIja2xffyk18zpBrYXWwDWqTkDTUVGSo9g+wx43rGkD698/fmrJLFYp/55Bdb18BY4Yx8bF3UVuBbXyVhkBZ1D1gnVbnmjCmPj0HxEyiUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70tIDc4mjIeNsNvlV0xYxj3mdmNMv7iMhAf3V4rpLoU=;
 b=PmsFmY70SfoB2boHnyMyIaq5Xb7i7+OIy3T4L2HUq1B5UkPl2sp/UnWGoZuMjIFdmGUl1lzzyxQPGbyEWoJdTK12UELtq4waerZCJ4bmnZXF+3cfOL+WcI041D46WVQfB0vr7JjmF+FMyCIq/IhOoLjzloXwhspi1OmfHR5XgCIhAAOZezx0Tq2zjFN4RNha6FyORgU5FDMEdn/LfCvY1bqhPADDkE1EF+hCADbXJfG7oYm3jdlRUdYcA7YgkMvltBuLqD/5CbFEk94hk5dIw6uB6N6CqT0lriZoA5px3WDfgcXjyHINfqGgAquvhMS2OZ8ywWa8rHsCKgoFChzM+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70tIDc4mjIeNsNvlV0xYxj3mdmNMv7iMhAf3V4rpLoU=;
 b=ptQ89MqKtTmINQW/Fkbk1EXEALDOjTMG7AdLIvjpFE2TePoJitDreAMlmUBUs6LGS91ZuXbiq2ryJbPeiZiEFdFFuFvKjQq8YBW/0gg0GZ+CgsQGDW4m2dS7FQCd7LrCo+nysQwvhZh3zCJuhV27HCDotqeZr6u2nEwvV/atI7EBHtRV0NFgqJuP8weN7bNtypWGlVGjItchrXlFi0gMSAdvhnJUGehz68WPoZRboDCAqOxCUn7HwLQiazIklCFTm9SOPIlYY1hab42qC2vpifUi5ZP6SDS/z6j8a/v54+WV9ljW7OCr+NCQL1JsCCcpoD9STdUDr5upGZSHyq+hIQ==
Received: from MW4PR03CA0097.namprd03.prod.outlook.com (2603:10b6:303:b7::12)
 by BL0PR12MB5507.namprd12.prod.outlook.com (2603:10b6:208:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Sun, 25 Jun
 2023 18:55:10 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::d3) by MW4PR03CA0097.outlook.office365.com
 (2603:10b6:303:b7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Sun, 25 Jun 2023 18:55:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.47 via Frontend Transport; Sun, 25 Jun 2023 18:55:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Sun, 25 Jun 2023
 11:55:04 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Sun, 25 Jun 2023 11:55:04 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Sun, 25 Jun 2023 11:55:03 -0700
Date: Sun, 25 Jun 2023 11:55:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pengfei Xu <pengfei.xu@intel.com>
CC: <jgg@nvidia.com>, <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
	<iommu@lists.linux.dev>, <heng.su@intel.com>, <lkp@intel.com>
Subject: Re: [Syzkaller & bisect] There is WARNING in iopt_remove_access in
 upstream patch "iommufd/selftest: Add IOMMU_TEST_OP_ACCESS_REPLACE_IOAS
 coverage"
Message-ID: <ZJiNhhve1qxOfKtV@Asurada-Nvidia>
References: <ZIp2DZQp/xLMarGi@xpf.sh.intel.com>
 <ZJYYWz2wy/86FapK@Asurada-Nvidia>
 <ZJgJOClwU+d78rji@xpf.sh.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZJgJOClwU+d78rji@xpf.sh.intel.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|BL0PR12MB5507:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b48c2d1-220e-426a-f1aa-08db75adb2ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uu2mHToQvR6UFo/D3odgTgDlCU8RvzsS3+QiE4ouQlfMYy/xTCiJgzpkk3LvmdymAby+NTac8dcLVqkIZwe00U+6iJBiYr887dziXZBROqL6iKbWKjLYSmAHVApMOOfbOQ1sQYwR+V2L5Fjj9Ge4gBb4/wAMGWAj/P5g7lEIp7J1GPf1nKvcRHigLX2qf5FQIlkjkAKfG+UYIfJPGfzruehNhSitmnqAloiukJu5UKwwEIhyVinm4mvh/ZtlTAZ40bUb7p7iUnuqn4Ti9ODYwfREbPpZNDYMxsGlZeEC6jRL7mCteFMRmP89dVTBp7R4h272V5koU6IaH9FdmMHkpKLG6LWNMjFOt4FyPvgjr5ZBU6HuLXyYElPIY0DM9A0Xi18LUAE4t55+Zk4/rIXviwDb3cM4uTTJNGBWVmN7i2emCZGfYGVrCxj+YzvnLPZ539ct8hT+kxrDhzaCh71jen3KRLijgQYa0ZPuuW9JB1Y5p44ZD+/2qxpclEYAUOEeIfJUrn4gACh3Nd9CsFP6PJjR5vsbBBdOyUxMRtgcDFERvlE81w48uNLVJ/2aNZapbm/i8a31+6LxiczlgvVNN25e+mORDcc5PYOM4SzwoFyn2y+mEzroXNxv047bkIS8qhesckSImBMK+tG/kaYgCUQf3qSYpEeu1zm48OXWM86gm0F20/O04C1mu1f9x04YLrtJTBlrOiB9cfwQosvoZfz3mYrm8g3jQr8buIs4tALZrq+mRh2HE/iYYj1jH/hU
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(39850400004)(396003)(376002)(346002)(136003)(451199021)(36840700001)(46966006)(82310400005)(36860700001)(70206006)(356005)(5660300002)(33716001)(6916009)(86362001)(8936002)(8676002)(41300700001)(4326008)(55016003)(40480700001)(316002)(7636003)(70586007)(82740400003)(966005)(47076005)(9686003)(26005)(2906002)(4744005)(186003)(478600001)(54906003)(426003)(83380400001)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2023 18:55:09.3981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b48c2d1-220e-426a-f1aa-08db75adb2ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5507

On Sun, Jun 25, 2023 at 05:30:32PM +0800, Pengfei Xu wrote:

> > It turns out to be a bug in the new iommufd_access_change_pt()
> > that does iopt_add_access() prior to __iommufd_access_detach().
> > However, iopt_add_access() overrides access->iopt_access_list_id
> > being read by the following __iommufd_access_detach(). Thus, it
> > triggers the WARNING.
> 
> Thanks a lot for your analysis and fixed patch!
> I have installed your below patch on top of previous reproduced kernel.
> And ran the reproduced binary in previous VM more than 1 hour, this issue
> could not be reproduced, result show that it's fixed.
> The bzImage with below patch is in link:
> https://github.com/xupengfe/syzkaller_logs/blob/main/230614_070652_iopt_remove_access/bzImage_fix.gz

Thanks for retesting!

I've squashed this into the new version of my replace() series.

Nicolin
