Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7773B433BC
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 15:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463054; cv=fail; b=dnbU5c3/5Kkm8Cp8pctPRluToYeUpIrtdAtNU8Sch1QzmD/qE1MZnhu7pcp25HOrQjVhirIjLnV/gYsjxsChq0qSz5K/fCvpbw6kdBmykEyEiiWwsWvK7DnAx2qTAUrk3sVqKTqMej5Sj8W0H0wrocLcHpihx5mazVltNgBdBak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463054; c=relaxed/simple;
	bh=9UW7kDE3FK2W24De24b2q3qCS8ETxmZhuyAPQkJx1a8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q2uTnCcLgAYJm6NF2qmaYuLT95WKf6Vs3kBQBKQvoqYi60VjGVelHfz21Ep47LsG+Ux0Krhw/kOO23yDOzVgT7IH4/os7wpNYjlSdjqE9+XfbnXz7hrZvL4AgIVRfFzeDwClgOerI/vxsCMu7Bexcna++MnmzzYEoDTfEjkXLAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Kr/OegcY; arc=fail smtp.client-ip=40.107.237.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Kr/OegcY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RmS3c08Pk4RBVtcf6/Upfn+sMjTIfUoe36PdXLo4JuDR7GQPjYKhmxvah1t2bcAfp8FxW+qnPYr40ogBmaZEYTaYF6516Ck6SVyNqvoGgyhQfvDPNQVs32zPYYALV5+TxviPgHTKS+yIBND4eqzk1/SyrmvIVy1/1mux+UHxOGkyv/V0qTPiOgIm36ciZo0hYq0RpC/ADV0cszYjHZyOHgXu1cDG8HM/3CPREOKry6+Swv2TbrA9Py50MTBZmD8KwX2BbdiD2AHm8Sox6twYebAs7CKaSHRXk6atoz26/fMBvUsYvExgM3gTIOFORVS4f17DwFKntfQBdwBucLHABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBX1uvhmKJndRLB9tJk8hVTIWwLIIfnXVh1imhUgURw=;
 b=KUmYtjyCDdVWKN65KM6iPjqWBlAMLk23pWJef6hAvGr519JZfc/PAElVYVnlyXPAGqDPcjmjmq2gVtMCWRk/qju5/HNqU8s8ZRKDrgntV5BNNW8OafXlEwXeBhr7850xLSap94TSfHIfyF866MhrN7EU/N3GYH5+f1yxtHM8VpQR2t3mO8WvfN5/atzF+tyUhkDlEECMIRWHhIow5ENrEAPZVm7OdiQDcaL5aqi8XmR3+D5ufxusPYbBYSb4RPfjfLPU8NufTwrQxI2yhrD7Z4WMRP+gjrMk9wbOBM3/XD5ZEfVLvkjo7HT8PpxTyGfyd81ZPdC7KbaRvi6tt5UstQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=linaro.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBX1uvhmKJndRLB9tJk8hVTIWwLIIfnXVh1imhUgURw=;
 b=Kr/OegcYYYIp05ayo2xgD7+5KPTBO2rPdYYLBeIHmcSwJd4nkRJMrtKbr//qks99P4OeSFH06SkqnMpLJebeuotkNQmvdocQxptgbsTp4Aoow1EvhvbtxKHOflbiGeCX9HXDX9wQp6e7jRWXlxS+Kd99f9RXd6lvzzcBi9gb91aQ5hD4B0JJ/rmZTv9WwlKQxIF/P5ueH+onyhXZb4QRNBiaK2LAawMal/B6hJb/UFm34IDOQCW/itgsZ3dVlXVcRTMddRYVlzjotpGcLGE2OdCgVQyfGNa+Ma26OYgqbQu4Wmpit6tfiOAKisBwddaehNuNzB6R5I9jSVhc/s2KxQ==
Received: from BN0PR10CA0015.namprd10.prod.outlook.com (2603:10b6:408:143::33)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 15:17:29 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:143:cafe::1c) by BN0PR10CA0015.outlook.office365.com
 (2603:10b6:408:143::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Wed, 4 Sep 2024 15:17:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 15:17:29 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 08:17:14 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 08:17:13 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 08:17:13 -0700
Date: Wed, 4 Sep 2024 08:17:11 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <thierry.reding@gmail.com>, <vdumpa@nvidia.com>,
	<jonathanh@nvidia.com>, <linux-kernel@vger.kernel.org>,
	<iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v14 08/10] iommu/arm-smmu-v3: Add in-kernel support for
 NVIDIA Tegra241 (Grace) CMDQV
Message-ID: <Zth59xLYZ4skc4yb@Asurada-Nvidia>
References: <cover.1724970714.git.nicolinc@nvidia.com>
 <dce50490b2c10b7254fb36aa73ed7ffd812b283a.1724970714.git.nicolinc@nvidia.com>
 <38b6ed33-886f-4ec7-9196-1728f1d8c1b3@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <38b6ed33-886f-4ec7-9196-1728f1d8c1b3@stanley.mountain>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: d32c3242-dd1b-4f94-5789-08dcccf4b0fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Yb7sxhdNRvHFKq9v5ty95hwtFcEyC4xKRekmF6rhKj2mpI/PFacCPs2er73a?=
 =?us-ascii?Q?BFBma8xxhPfslacNxUFbY+yOPDUyik/VFp81zEuD9E+/5CuuqC0F1mjNLlT2?=
 =?us-ascii?Q?Jet8qTq7BTl2/mnShmllhY3oBPEDV2gawQdgtpWFdEql7GRFEJM+gm8Pfpsh?=
 =?us-ascii?Q?EhF9B5XCderXjE1fRAgEPu1W9kT8xuZGJ7QWtczdcZlbfg22h3eaV/05soKk?=
 =?us-ascii?Q?rns80vdbgD4hR/wVM2RqPAIZ+wQ3RNhMzvC+7lJ7o5wW/dSlv8a1HNGVe2Kg?=
 =?us-ascii?Q?Qxj3fPgxgnd8QBhdmtEBVVfGnACgWs70WILTM7BVygdrprAJcZnY5X+AltdU?=
 =?us-ascii?Q?LSNgbyeaT4uoRLLUS0gocNAX+Yb6h51baXaXXjahuX3wg8x9N4ujzuTyMfdy?=
 =?us-ascii?Q?3iMOn7LJdeoPvi+fp1/Y+lW0QU9R+egh64dF7VHx34iUx01tR9x6F2me6j0u?=
 =?us-ascii?Q?00Y34DulLY7cVGaAND369nvMNBYr5yngPWrZMeYfcPnUdpQ5QZ5FnrDqg+y6?=
 =?us-ascii?Q?1V5+It3M9D7qg49PmxtBgBiSWALtViT2nou2EsRq6L7EeKvCkgCg75SrYjTr?=
 =?us-ascii?Q?veldD6n7rLnV59HAl4KYLmirl2a3EHXDZ5wjHOKEwTDXMnuhRtSdyS4eow7v?=
 =?us-ascii?Q?kzkjv6xjCHkVb1G0V/TOiQruK9v+u1kYFLltR9UaPAQqt4lezUTuZrOmUrXp?=
 =?us-ascii?Q?JpifT4uHvyMSS8Cfg1qK7G7sWLjsE5ZoaHXE3oGQtWa8tgnk02WhIjBa77KO?=
 =?us-ascii?Q?JCu0U18SfwkAKk+ZQu7wGRnRjD/FUzi9c5sjOCWVBlsD7xFr2+5/n2xOJEuG?=
 =?us-ascii?Q?5BFRcZRO/rUPZLEr9cPsrlSOVwwd7R/9Imz92YX7pxiSllXtK7qJjAe82RBn?=
 =?us-ascii?Q?26FGm9E8UFyhPW9F29HJUufzT82baTdGZOf9azm8SV2VMrKIUbWCIE+8/60Z?=
 =?us-ascii?Q?x2pN4QwGIQ2xvdz2DcMbRDjJvR2ukuEjMHtS5tRjMBPg/fy99kgXpjZ+DBTS?=
 =?us-ascii?Q?IKSv9gUy5apqcctB360UrvLRuZJUoIvakuRX2nZJHFncU/+g2DmyfrVyA/UG?=
 =?us-ascii?Q?e2lFN+qegP2gsh8CfETZoapNIoMZQRXYo8s8mMHTec4JRwzxzoVH8y8zL4a0?=
 =?us-ascii?Q?WeaN7njLTWRZSVo2XHsYpQrA3cJUOXUdD0elASLuhYGT5s7W+bC5oXgTbcVm?=
 =?us-ascii?Q?9TZgIuwJfQ/tTpL71r/QR/R3Vhw6FoCE84SB3rf8LfXuPR2QQdXFDCUCIyYd?=
 =?us-ascii?Q?MFnrDxNS7uXPxtNMFceJ/Ar4zDWD3gFr35e3+OwPdk4EJ9ZbmJyG3Fv699Yk?=
 =?us-ascii?Q?z7dSXEzZ3LuUfblvIR7gu8twmYSRRVTTCrVxkx1f8UKq16W/KmYdEMAgI2RA?=
 =?us-ascii?Q?IOKzZEC6mQXy43IYUrUqSXXrLQwySnBWMuVNLQ0tC4F4gqHqhnXm3h/+4zh3?=
 =?us-ascii?Q?eF/p0/AuceG36pg7pvkYwZnxGulSyFrj?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:17:29.1216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d32c3242-dd1b-4f94-5789-08dcccf4b0fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852

Hi Dan,

On Wed, Sep 04, 2024 at 10:29:26AM +0300, Dan Carpenter wrote:
 
> I was reviewing Smatch warnings:
> 
>     drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c:616 tegra241_cmdqv_init_vintf()
>     error: Calling ida_alloc_max() with a 'max' argument which is a power of 2. -1 missing?
> 
> The problem is that we're calling ida_alloc_max() where max is always zero.
> 
> > +static int tegra241_cmdqv_init_vintf(struct tegra241_cmdqv *cmdqv, u16 max_idx,
> > +                                  struct tegra241_vintf *vintf)
> > +{
> > +
> > +     u16 idx;
> > +     int ret;
> > +
> > +     ret = ida_alloc_max(&cmdqv->vintf_ids, max_idx, GFP_KERNEL);
> > +     if (ret < 0)
> > +             return ret;
> > +     idx = ret;
> 
> max_idx is always zero so idx is always zero.

There is a followup series adding support for max[1, max_vintf].
And I guess that would make Smatch happy. I'd personally prefer
keep this by ignoring the Smatch warning. But if you think the
common practice is to drop it and add back, I'd be okay with it.

> > +
> > +     vintf->idx = idx;
> > +     vintf->cmdqv = cmdqv;
> > +     vintf->base = cmdqv->base + TEGRA241_VINTF(idx);
> > +
> > +     vintf->lvcmdqs = kcalloc(cmdqv->num_lvcmdqs_per_vintf,
> > +                              sizeof(*vintf->lvcmdqs), GFP_KERNEL);
> > +     if (!vintf->lvcmdqs) {
> > +             ida_free(&cmdqv->vintf_ids, idx);
> > +             return -ENOMEM;
> > +     }
> > +
> > +     cmdqv->vintfs[idx] = vintf;
> 
> We only use the first element of this array.
> 
> > +     return ret;
> > +}
> 
> We could get rid of the ida_ stuff and change the cmdqv->vintfs[] array to a
> pointer.  It would simplify the code.

As mentioned above, a following series is adding other vintfs.
There is no warning/error to this array, I'd prefer we keep it
as is.

Thanks
Nicolin
