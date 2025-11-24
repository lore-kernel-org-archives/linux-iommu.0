Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BB12BD11
	for <iommu@lists.linux.dev>; Mon, 24 Nov 2025 23:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764027101; cv=fail; b=etEShM39LSzhWuCKWm3e7bHblHsvvLY+zTtHDtUG/c5yg3yWxjLUEwgbLgKbGXM6gwYzs8ZK/uwb31ipJpOTb3ubqONNqvqBKcZzoLtjmIj58W88NpJMYyd/oZOLzUEyI1g/Qqi5149qPb1k1eAKyAobLA/W1+xBxVC3Xos1NyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764027101; c=relaxed/simple;
	bh=k7+zWQRv6ZttmxgP2sSGyTqgwrSseP55SiBJlvdIHZw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BewLM5tDh1Xmz1jA+LWow4WVFRyOpAVyNE4/xzdKugvwohc+Hym0JjOcNfo5o+TgQJQAWm98Mtrc0UcMbVu//zTHY+f2+zFzwAudY8oZyG0Z+mSk4jvidEQE3vIEjf129dGGGMhN8pDlpaHfOXjqRXQ5HBkumysn9IZT/x7iIN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PUSxskSA; arc=fail smtp.client-ip=52.101.201.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PUSxskSA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VDm9fICrfUjF5BhWto/Ud63JeKW3irBuk7LWyi6s8mIZjecuSZFpEDwC8UyuFqiToRlLd9lbTDGdpV+CaQWMJggZFwnQ/fjoah6in9itNAQrP5cwDyofds6fcEGXWksjEdbDkK7zHivZ2+oKDRqo/gg9srW/i3+yui2H0nQrGYPzvOn7sjxfkZzuLGT7t063J4jkK8pbNPXf0+m2iAoccrNtTJuYRx5ms89jGdPH2G7m0DmCp9ZxXlSbNitqQUbag2y72q52izdqBl1M+aQkw7e3fJeGSayted+9sbTPu7lJbWjLU3tuGDkFmZZWpOOPXZ4N/QP0ivs/ADd455DmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szfoICBODjxByFRjXnGvBsh1wNIAD2mtqn3vuiIrZ0s=;
 b=LhCIPPe2mIT4QUl1CMHI29cT3t6u06Xmb8huYtiONtmBFMoWwEMqQCd0zWg/Oj4B6nDetVNRcJdI0DUzBbV6yvL3mea4R++K8a2eeHxpKK6Cl87qlCuHw4sqijSD3O5QcjGV1qIYdDtuvyaMX0M63D9Rt7ijZmw09Qsi0W0Z5h5cGX5MDkm9fVglPQ6eDORH5se3pZTqdTjJ52Z59hXYwW/3yyZYg41g0zajWLq6Au9NNsu8DR/HMu0RfQaC4M2JJ+RDuevLOw5JTzx7it0sw8wgwtT79JYne81coA6uGrNPRFqBHAp9nvfVUnINzPLmUgEZ3U397fvotKMH6MAxhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szfoICBODjxByFRjXnGvBsh1wNIAD2mtqn3vuiIrZ0s=;
 b=PUSxskSAcFOMt2C745m2Fere0rYRjdS5SECNWlVVJkseiUs4qDLzwfxgwmHtol3WI/iZBecfb9z5wXtKx7yQrmptP/FSPT1RUPZYYdK/cuZ+DM8JH7eWqr3Bk19DzRTCxEL5ykygmAEA8D5rRZvSDXNjVXP14y7/szvM6cHhcEO3xFgK8LGlltjEj5P3K+Qr1dIgb6DdvKL7iACzKr5mmvcbta0FJU4swxtDb+oArxyl1HBDJRE6JAv7Uu5Nwwc1Tebes48Gez7+Xy70LJ2t6kI5Yfd2zAY4lNmSCkE5ayNHusig7u5hYFfBRd6kDmSOhyDicxQJR9bRks1NXIS8Iw==
Received: from SJ0PR03CA0026.namprd03.prod.outlook.com (2603:10b6:a03:33a::31)
 by PH7PR12MB6537.namprd12.prod.outlook.com (2603:10b6:510:1f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 23:31:34 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::5c) by SJ0PR03CA0026.outlook.office365.com
 (2603:10b6:a03:33a::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 23:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 23:31:32 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 15:31:18 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 15:31:17 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 15:31:16 -0800
Date: Mon, 24 Nov 2025 15:31:15 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, <jean-philippe@linaro.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <balbirs@nvidia.com>,
	<miko.lenczewski@arm.com>, <peterz@infradead.org>, <kevin.tian@intel.com>,
	<praan@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/7] iommu/arm-smmu-v3: Pre-allocate a per-master
 invalidation array
Message-ID: <aSTqw4Doipb+0AfP@Asurada-Nvidia>
References: <cover.1762588839.git.nicolinc@nvidia.com>
 <b6e1b5d0ac0157fc06b5cd20c5cd72caec892c47.1762588839.git.nicolinc@nvidia.com>
 <aSTRX5RJJhfNU6l3@willie-the-truck>
 <aSTfrp9D7i03XhyU@Asurada-Nvidia>
 <20251124230845.GN153257@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251124230845.GN153257@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|PH7PR12MB6537:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c4140a1-0e4e-463a-abae-08de2bb19a47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NcupdWouvS0BTT8ms1PbzxebPowmQPc1w0sMSiKbQssM8urru9JL7C9AlKRe?=
 =?us-ascii?Q?CUT5FYxa4AyRfvwecTBSbC4OkByU7hPcntBZvbgFm1XnQLLAOdGIYf6aRm4M?=
 =?us-ascii?Q?c6VH1JFaFVITKpcOTUusHv8Y04tFJM9/hH+jNWYGvjcgr7SIHWJ/fE8+NtOG?=
 =?us-ascii?Q?rksYKxLrJ6w3xaJRWCNniATsXsNXtjliknHd5kw5ZsHbojuOxjijGYj5uJxa?=
 =?us-ascii?Q?cGcRBwzVLCNsrnqIa87Zi3LO2kDifGbmBHBYUcbAuzWoaGrRGT1N8HRuHDUT?=
 =?us-ascii?Q?JvgA87aVFqoJ8v76mJPn05cczRy92g3WCpcxts4w5zdqH4DT1vrduheN/rla?=
 =?us-ascii?Q?d7AJilRzn29XasHS/wZLKJwoyhPa+PTYo75QTH9AFhbr2jqqcF5xVpfQxRH7?=
 =?us-ascii?Q?4gYA78ZxwF0C1zLYfmr0+v2XTfr9JOANwqp6DptqgD8a/Oxg2abdbUum3TdM?=
 =?us-ascii?Q?wtU4/ZmpmHmnNERoW0spWbtgxWBYib7lfLjQeiFaa+SagIKXOscC8tBJ/VGa?=
 =?us-ascii?Q?6EBpXrSpHqcETdalhNxpEL+lmtBIY14insEF6gjD0XKmUqYyvzrkU+txaiGy?=
 =?us-ascii?Q?udbEHIEBDOjqRDARnzvacX95AevaNs+dfYRVHsjgVmzmdjuFuKRmfJjJprlw?=
 =?us-ascii?Q?Zd8IOwrJp718WGdVmMzNQKPPiBv9JcIiovaMlk9IFLKH2A1CLtahWL4rSqCy?=
 =?us-ascii?Q?jegKvg89jaFuQDeLo2MxKGOYkByN2aFecFvFmdPV/+WIGp+jMMLelUZ3BNdw?=
 =?us-ascii?Q?sSF/q/XWvt73t6IeosZGmk8vuZXRHrdG9doa1eFGOZB6oO1XZeJop1nEu5t3?=
 =?us-ascii?Q?Zjh8jnjvkdyc6xSNKp/X1hht+QM7TyA2WNV8SPdN2CJ7P187U8X/cAiRFLZr?=
 =?us-ascii?Q?WPu4w6lQ9yGVbLPdCP6vZ7A7UwA5VJ8IlKPDZms1Pil1Moy27h9aLdIVF2WD?=
 =?us-ascii?Q?K2leAiimPE6iTjCFPwJ1fpzJ65ESds35MK/eRpbG5TYHk3ldHBVX7bhzISsf?=
 =?us-ascii?Q?vfR9j/8V2Pu1fKLpQCAY+GnyuB1uC8LlLJHuuRkwlY0M/lgMsU1tJMBEcITt?=
 =?us-ascii?Q?fJ4E0hSletXh1HDP/hyrVzNLlAq1Yx/dMJ561PGeG8atUEatup0N214ZgbeF?=
 =?us-ascii?Q?npDfX9vU7c4asWF451oB7atNyIEkXI7j/rjXkhpMZ45jqALloVZWo/9iPjGj?=
 =?us-ascii?Q?kvbaDGGjwpQ/HUNoxwdnAlt7x1RgZzlGACyBIfio3pEz/ZDUVnEeLTVDBA09?=
 =?us-ascii?Q?SDS9fduZIR+jlIwmwptK9NHDEs+BwmAXCcML0XgN+CXfsP0rxIrwCu3PUyIH?=
 =?us-ascii?Q?AcQxb6ELUxbYb+GZLSV8+wDtLfUz1RfREff5t2lvSotvILaYfjBBXooYC8zG?=
 =?us-ascii?Q?NsG3kUGLbfxGtwSKD98ITXxZbeNzytuNT4rrkQl4WwhcAv7IF5pJ5Znt6CRs?=
 =?us-ascii?Q?dw0wgXiH4DQdaOIdtXgqSpCLQuNCvaGtTp2ryN9YpiU9fefkaHDHVmDm/zuT?=
 =?us-ascii?Q?Vq28AbwykqCHMWrtEz1mxW7KwVASuQARCj3hBprvy4DNAMaDjTHluH/uIfBy?=
 =?us-ascii?Q?szxIo2xenhwAylkYn9E=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 23:31:32.9464
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c4140a1-0e4e-463a-abae-08de2bb19a47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6537

On Mon, Nov 24, 2025 at 07:08:45PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 24, 2025 at 02:43:58PM -0800, Nicolin Chen wrote:
> > On Mon, Nov 24, 2025 at 09:42:55PM +0000, Will Deacon wrote:
> > > On Sat, Nov 08, 2025 at 12:08:05AM -0800, Nicolin Chen wrote:
> > > > +		/* Put the ids into order for sorted to_merge/to_unref arrays */
> > > > +		sort_nonatomic(fwspec->ids, fwspec->num_ids,
> > > > +			       sizeof(fwspec->ids[0]), arm_smmu_ids_cmp, NULL);
> > > > +		/* ATS case adds num_ids of entries, on top of the base case */
> > > > +		master->build_invs = arm_smmu_invs_alloc(2 + fwspec->num_ids);
> > > 
> > > Although I can't point at a specific issue here, I'm nervous about mutating
> > > the 'fwspec->ids' array from within the driver, The array isn't allocated
> > > or populated directly by the driver and so I don't think we really have any
> > > business sorting it. Could we hack iommu_fwspec_add_ids() to keep the array
> > > ordered instead?
> > 
> > Yea, I think it makes sense to do it in the core, once we have the
> > data structure provided by the core as well.
> 
> I would be more worried about sorting it everywhere for every
> driver. I feel confident SMMUv3 doesn't use it, but something really
> old and embedded focused like tegra or omap, IDK.
> 
> So I wouldn't propose to change iommu_fwspec_add_ids().

Perhaps a different helper iommu_fwspec_add_ids_sorted()? Drivers
can choose to use the sorted version, when they want to implement
the invalidation array. And SMMU can be the first only caller.

> If you want to be conservative then the thing to do is sort the
> master->streams that arm_smmu_insert_master() copies the fwspec
> into. It just has to be sorted prior to feeding it into the rbtree.
> 
> Then consistently use master->streams as the sorted list.

How about kmemdup() an local id array to bridge betwen fwspec->ids
and rbtree?

Thanks
Nicolin
