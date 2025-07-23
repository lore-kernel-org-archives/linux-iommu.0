Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DC5C2E0
	for <iommu@lists.linux.dev>; Wed, 23 Jul 2025 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753293955; cv=fail; b=bBihysgpolCwgRKhhpDkQNcWeGHJNq27c3HXz3GIfiVHvfAJ31dUcOa9BnAbG6yI13qVsne8IyMEUIQoIVqC1AU9tnEKsITdGA5vrA1kdAe2HGO6XRnOHo5CTomVxgSXchTWPYVAcX+ls9ckAZLSOzRzPtgLYWX8DBUFTSyoumA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753293955; c=relaxed/simple;
	bh=Tb/5Qixzajy5Exk/59d5+cpYiJYmqqMDjwF9fIDfRhM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=glzpmk1qIKQ1NPDmE0c/jL11kPUnZYhv3wveRV8eBOz2VCBG898tFRUP+BKjaVZKWxtWPUyavckuGcZbSuLnOsp01MhKP9ETAuSgutHLEr6KAfZhoCnPoA3wxEPF5Qwyw80mJ77eYCF47GiQz/8qVctVK05lCC4ZcXCftAz+kok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y7Sy+2NR; arc=fail smtp.client-ip=40.107.236.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y7Sy+2NR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3RPAEoKs9Mx53ajDe46En/S2OBIWKhfpyJkUmWV4GyQSd/WERXS6xzJV0bf6yeGGOeNhMe5IsPqEm0xAHfpDOhJOqLlWrBFE9yrFaGyYes3DcRQoZuh7ORRbGCnwkkw5JjieC8nTMq6yaYlNZGgFY9c5D/UNDWX5lqqhfGxoJSL1TGxQdwwj4ZJpOVOqwykwzzkdsyTvHycDopHIkFM4pQBL/g42cS2R79HR5A2ODUEsr4mZfwV6o3pfBTA+3jrV+l5ssOJQK5dAZOxh/H4NdvK5u624hq13Bmx9H7Quk6Ubescm4ctUwl3zmrf0qkUKdItZvnFeAtK1xvUA6qaTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoujWxgHwiTQaGaaJLZ+B18hOTaPRaC4LK5Ejbdp9UE=;
 b=lp9HSMquP3mtX3CeRJcztSqz2CCZ6I4Xxcye0jO+63FbNGCJXYhamaPN6Ez4BIva+T6KOeLAIXl0FZ8Sqijn+4nDLpkJTwxfthjG3JURCqyoRTOMYhrjliwMSC6qNfOP7sqnA/oCeOfNYos+6QBYSFyRsDrCa7M9RkB+SHTrkKnDC4ViO/CNdC5hroaIuk64l0kOEDk8cWuO1J1GcuG2k57LC/UqxMbkS85Oku3tJ2HcN8RrHuaeHBQ7+q9enVDv/tzMpJfXvBs+tDVxvZoJLrAr8AXreCZSre74mMtmWlCbCLrPkDcv4u3iBSjQTuxLSYGCG9HsVikedQYOQ3fe7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoujWxgHwiTQaGaaJLZ+B18hOTaPRaC4LK5Ejbdp9UE=;
 b=Y7Sy+2NRPAo7LAY60CY8XkmuEnOnT12V9TLDH5hSCSVBxKCjxY/gc0RzUIyltGAPnxvn8SZN1GRqHJV5AbSY9Ya8tnRCwJSzGv52p+zi8EUQkJMCEv/fBcn3SaBs5OmTOuDWOypwPl94z0eWTNrvptQbI/IYu4S4axQ4cf14JX6dt04GDjmWM9GT8gAh7p8kq5I+NklTcEmJB8W+erlGtqwdUgdTOVIGrfJLFIHbuJGQKaDBZv5M5rADj+3/SMFE2iKdjisMomKsM9dJZNCF/FgpyDb2Jzm2DdD1t8BYReSxgjPkvzXJSd/a8DQpRKUeVOvanzzkxh0n47nTMxVCyg==
Received: from BYAPR07CA0030.namprd07.prod.outlook.com (2603:10b6:a02:bc::43)
 by LV8PR12MB9263.namprd12.prod.outlook.com (2603:10b6:408:1e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 18:05:49 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::76) by BYAPR07CA0030.outlook.office365.com
 (2603:10b6:a02:bc::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 18:05:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 18:05:48 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Jul
 2025 11:05:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Jul
 2025 11:05:27 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 23 Jul 2025 11:05:27 -0700
Date: Wed, 23 Jul 2025 11:05:26 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <joro@8bytes.org>,
	<robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aIDlsUvF2Xbdelvx@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|LV8PR12MB9263:EE_
X-MS-Office365-Filtering-Correlation-Id: aa1fb73d-a8d6-4592-bb3e-08ddca138d8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Crk56w/cjTpY5MYue3xKYyPH2yHZaL6Jt/jmq5Dp4qSjL2YSwPTVnvJArv8?=
 =?us-ascii?Q?jh9Jk/74WSEoePNMadhWY00U6gW2eOtLAyXTWyjjjAJXE71f/yHChTONwmJK?=
 =?us-ascii?Q?/ShkWRYph0fgz0rPHOZ5R5mmZ5KGfiSqDhvKiqmiQUB9xQMBA9Q5/x7urges?=
 =?us-ascii?Q?QUxnQ9uDUHFnVnoc1jCXVntOwsOCUGS5cIN0dA0uW5EESqtfRMWSHSmbRtpF?=
 =?us-ascii?Q?HCsJrXweWCzxEuc5n+Hd/llTCwwz5X+efj7EGGfExRZr84aqaX3CCdWbiWX2?=
 =?us-ascii?Q?78+B0OmL5SQ9YUdAsC74EyCns+evyE1Z0uG+xwazoc/LYifMG7nmAuU3WUwM?=
 =?us-ascii?Q?ksv9MsNiTUgY6yZfdbkN0dusXjxFJkFQYi7ubtHu5PXmOjdBKTHCfGObr7b7?=
 =?us-ascii?Q?Bl9FlWq+DnpYRZnl1WJTrGL/Y94KfqZfTWy24OJneunbkyTLztjz7inM6sR7?=
 =?us-ascii?Q?yjNNErwiL9nuUZEObksOIbALBytoj9yJsDAal0ZoD+ARluauO7kLb6HGU2TH?=
 =?us-ascii?Q?TROADObuE9zbMOsOV7HH/IFB9FQ1f8V44TCW5rjTtVCM62DghZQHqbhe1OPN?=
 =?us-ascii?Q?Z4c/NTHDGOmZq8pksXZYs2F97Abb/QZseMyqHILAOrvIuYGWuxqyjKUgj6U7?=
 =?us-ascii?Q?wJ0rYpSfkBxr6vdI6WWnOvxDb8FP+yem5MW+SCR7w3/hj34ZqNMhCroHIf6d?=
 =?us-ascii?Q?qY1pXUd8xExygqBBWGBPrwninYqrUA4hI23uzlIuY1ivh/JJhQRBXw495h0U?=
 =?us-ascii?Q?w55Jm49smYTxgG1v0/zAxrJWoc4h37sgecOQjASAXnZItKjHRqU7XaWMa9HH?=
 =?us-ascii?Q?KxwEiboK4Y0wqn9wh2gvVQ8XnK4m5lEQsRm3IRi40HZTyoSTp/P8l3g78OFh?=
 =?us-ascii?Q?bLfMo3uMx0akKESJKukhlSInd2MOd+cypf7hfT5HgoBToXdpC+LBMiILnfbC?=
 =?us-ascii?Q?NJ6K4ZyD9D4imZIhITSoaD4NTiZ6zOZXWju+GyxURNMqRErh/c3GZJw9zoyd?=
 =?us-ascii?Q?8dpoCxUvbnI3uOszk2XeJRebsmaMpEQa6xKh/YSkdM32Nlk7YFJa1AerguIa?=
 =?us-ascii?Q?RrYlrtJDxEcXDFVfQCn5dDEsxn5HypkR99JLnU1bhAgpIZwxxTs9ZDrZ5Hcp?=
 =?us-ascii?Q?035XdjperptQIAAkyFkMB8gsWh/OpMDqx2+5waezbfVkY5GXd6COcqW5kUbJ?=
 =?us-ascii?Q?SAkt/JJSFNMkfB/y/U/J9K+49tF7udORLYWiVZ3g9mFduYCpfWsrtgj5IEjW?=
 =?us-ascii?Q?mV4sHZNYc5VxJmWdSWUko/eqHhRtmxbu6BLfQsVjpZBQWgoPD1Dn/3CCdxE4?=
 =?us-ascii?Q?R1V9yL+DMrgicXpGJ6mXRvBdgFV1ETwuB673lpzyYBPYK65m37diARZbv0xs?=
 =?us-ascii?Q?vuKkaKF370p9hnW3Zbac4yYRWVC7hE1U7Wi769xz5W4N+BA+ha/FczH3ddKo?=
 =?us-ascii?Q?ED8FCn/j5KRAHCXQ3fphBmVge5KJCIdvQg68FZuAvbBj3/8MqtZd9kaOS2Xl?=
 =?us-ascii?Q?M6ESOCxAV0s57XeJJJuFwqEPPXDVU0uKuHTll2w+oDfJeZhG65M+zeUYvQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 18:05:48.3272
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa1fb73d-a8d6-4592-bb3e-08ddca138d8a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9263

On Wed, Jul 23, 2025 at 01:37:53PM +0000, Pranjal Shrivastava wrote:
> On Mon, Jul 21, 2025 at 01:04:44PM -0700, Nicolin Chen wrote:
> > @@ -1273,6 +1279,10 @@ tegra241_cmdqv_init_vintf_user(struct arm_vsmmu *vsmmu,
> >  	phys_addr_t page0_base;
> >  	int ret;
> >  
> > +	/* Unsupported type was rejected in tegra241_cmdqv_get_vintf_size() */
> > +	if (WARN_ON(vsmmu->core.type != IOMMU_VIOMMU_TYPE_TEGRA241_CMDQV))
> > +		return -EOPNOTSUPP;
> > +
> 
> Nit: I don't think we'd expect a call to this if the vintf_size returned
> 0? I see that in iommufd_viommu_alloc_ioctl, we already have a check:

It's added in the previous patch where I explained that this is
to detect data corruption. When something like that happens, it
would be often illogical.

> And call ops->viommu_init only when the above isn't met. Thus,
> if we still end up calling ops->viommu_init, shouldn't we BUG_ON() it?
> I'd rather have the core code handle such things (since the driver is
> simply implementing the ops) and BUG_ON() something that's terribly
> wrong..

BUG_ON is discouraged following the coding style:
https://docs.kernel.org/process/coding-style.html#use-warn-rather-than-bug

> I can't see any ops->viommu_init being called elsewhere atm, let me
> know if there's a different path that I missed..

I see it as a precaution that should never get triggered. But in
case that it happens, I don't want it to proceed further wasting
precious HW resource given that this function allocates a VINTF.

Nicolin
