Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FBF2E413
	for <iommu@lists.linux.dev>; Fri, 22 Aug 2025 21:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897385; cv=fail; b=DCN6xYyNTAF0rEb5EtTRdUr8sPA9NWVJ29/Vb7tTeUmw5IR+0IziGfpaphnAGds3ya/cP9+I6+faa7zPPqDgeUlkO8aFJFba/4jK+7lGfREoYogDV15H/hB01ZaR3KT8LEvs8rxh0f77PktxPZJA5wHpXbW6zGYc2PoE9nQJttg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897385; c=relaxed/simple;
	bh=NZIq/2dYVRZkbnBqK6GqNpDdTIqkLlDOD1uVaGWclK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z6uAlu7ctYoQ84HnqzpJQCkXBdxNDFAZpbRAvSzf9yUvvVfOR0qECTIAzkfC8if20q5H7Ynr/yIamX9KVnjQU1IWwyVvqCEzBPrHOgHayNKWuDQgOvtgN5H+fDBM619W5gWp49/i45xP+Rqu6IyOgFoViFEh6GUnANMdx8qqPtY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cTLkB089; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cTLkB089"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTrsi0E/EaviG/Va3y8dfaEJmRckfnNRnWpy/YFUmwltl/jiGRy2QjVXoVuxa6C2M2bJkP2449xFzOUU2RSMei2BrtBvx8TO6CDhtVKbsAKPTzrMKn1U7jP1zeHkgtH53/QNZaeVC7XsbJE/KE3j2PeBgIwAgIhi8Jrwsfgq42b0haP1e2+SbQFmULfftjDH8zaO9wnMmDWOT0H7uBkZ3jLBfI0JGhOXuvgIWcPjwVtAFigfnwsHphV+J4a5zj7ZqWsG9FDdwkHJ4YbIX8enr+gv9kkLqUYC9hCWbNdHAWqJD9phKetjedF5A+zs0yiKWih0Dg6VYUTwkSb5Km2BIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5tmWuBfe7pmVFT1a8qhKhjIoZmv+Fx2dPJFE1dWWaA=;
 b=Q3TsIHs9+vjec2cL2tuYBj9ivJRxmITJkphAPI1RC6c0VKNrEqpVnJAjyepryWT7jCMDgVVEXZl31g4VgDpvq7dByPWIBLuc0iT2XxS9xKtY13DByaVTxusjK8imAmQFFxFVjXF8uxhJRFaDdgtrIz/ISRUcr9Qo5OLAMWhSYzY+6FQ/8mOoGW4of93rkBnqo8gR1OuXpR4+nTWqmg6n5izp4Fs2MBekyBe2DbXLMeoPzU9FMswh83iAg8SnRGQ8rB0K432hMZaLXlbhHMnBVNraOfQJTSRjgDzAq5sHH2JsxJrcHyJwYi90Oop/MrOt6wZnmErV+w/R6MdJEB7Kcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5tmWuBfe7pmVFT1a8qhKhjIoZmv+Fx2dPJFE1dWWaA=;
 b=cTLkB089XwdxJ7eBlDuh/Pln2BGAwnzD129/CDZsVsQs7JoSsTvlpxP4k1oAbVxdTGEazm9CUttOthQe575xV3rt4l2kqZJQ/5fagruWaAvKx9nDrPHazbD9OQixOI3woHKc8NEDvdZ73TeCfmQ71k4L4+U8uEYW3S8tDD8itqKxJ3DVjKSgLFtIwWwkClb4B4/iWyFvqE/OjGF7OS292nNvbD+2XRE0zWNZT/w6+tN+juzRpSnzuvkE8tFsGpDjuzDLJlRO0nYevl/PFWELCINKpKr+W5BgqYtYWmWNBLr2T91vi9ELrnDRcXdmjWoLGWTVDtKHbunZ1x4KkJcBuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA0PR12MB4494.namprd12.prod.outlook.com (2603:10b6:806:94::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 21:16:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 21:16:20 +0000
Date: Fri, 22 Aug 2025 18:16:18 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org,
	joro@8bytes.org, kevin.tian@intel.com, jsnitsel@redhat.com,
	vasant.hegde@amd.com, iommu@lists.linux.dev, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jon.grimm@amd.com,
	prashanthpra@google.com, wvw@google.com, wnliu@google.com,
	gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH 7/8] iommu/amd: Add support for nested domain allocation
Message-ID: <20250822211618.GF1405994@nvidia.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-8-suravee.suthikulpanit@amd.com>
 <aKjKJhblxtnlrrPG@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKjKJhblxtnlrrPG@Asurada-Nvidia>
X-ClientProxiedBy: MN0PR04CA0021.namprd04.prod.outlook.com
 (2603:10b6:208:52d::32) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA0PR12MB4494:EE_
X-MS-Office365-Filtering-Correlation-Id: 32326f2f-2dac-4626-f806-08dde1c123d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rN1Rgjid42zy9cHkFSSY/5awUwg8nOO3/7q3B0hoV+n7Qzrk1O1PPVuYEsNM?=
 =?us-ascii?Q?5Uvug+d7trnuAs75+FLF+27kU6MlY2oJhT+MN+6aCipkS1EDtE5l/UU9G42/?=
 =?us-ascii?Q?4zKH8fRyRnUyyeOlx0SxjaHbHabFa03YWfMPj8aNJQv02hPXWNIuWeo4DDFh?=
 =?us-ascii?Q?im/Cd3zVn4w5fWo6WITgOUI1wgo5ki9sSu5JO3F/KCCtJOsBWz49R8hy+y3Y?=
 =?us-ascii?Q?Dxzui/BaMYaOF9rJSp/+qTUC+eFiQa2fMCTDr0bvfMpbQK69UJJTj+gDMsb2?=
 =?us-ascii?Q?Iua2dkt+77ZnfJZEp9nUaZ2pgaKyflNUm+6IKbfm/0GL1BEH3rWibr1sqcj3?=
 =?us-ascii?Q?lJ5IYajbUqf4CybWh3dz7UipDFVn9Opzgbh+krBdlBy3MNzuz/rrD/AGJqZc?=
 =?us-ascii?Q?Ma9IsR3OBex1rMZ1pdYCMWY3EgfrTKYkX1CUKAI3XTIlGIGiALMGKotkZSNA?=
 =?us-ascii?Q?JVaPXy0ekDf8z4FnJfY0p4KdvtrdAIZyAqI3Mu0HdjE0p92t10GYPFZYdMdW?=
 =?us-ascii?Q?6r3hg0Ta2GCqDnd6Xxz/A1zr4SOtGIZLOAfqY2xj5D5BV5GtoXCnXhmQ/2dc?=
 =?us-ascii?Q?uAn8KllncJ/A4X/XhX22lY1p7Hr+RaWT++3JLCNhhHuQW1qTqVgaNhisI30K?=
 =?us-ascii?Q?o/DUpO/8HLePqKZB77c8DQin/fAM2mdTYFsX+eeUmvgUUalyV8Trx2xLeIP0?=
 =?us-ascii?Q?RXzPNsRRj/AdgL3ks0YLCi7yYC1gEcJaEi4W5QffqiMHnPo5YM3s949FyNvG?=
 =?us-ascii?Q?mwzzlDURBPts9xt1bE9JVEnDRYwP06be6A0kGQAv35+tTJDml4/6papw0rPo?=
 =?us-ascii?Q?Vdmi1fhYQvOIBCrk4XIjn8jiXcDtcW8ICyVivEmPY/nu38EVP9lQpUUbuwoU?=
 =?us-ascii?Q?lWouaGcgEZuaNnz5OaCKTfvPOvo8W3MFmQdgSqbXwt4AJ4O9D+2ejN/ybwdD?=
 =?us-ascii?Q?y9rSREDlWEitvgNjmP4035Tq16g80/SYhMl8wtbT2vPKxw+cxviF7aKFjAmO?=
 =?us-ascii?Q?EFj2FOt81JPjyDA4cyGBxDmdYMXEf9U1BctLgg0cUf5YGeocmb6M4xaPbsFm?=
 =?us-ascii?Q?vwDD3hDES4lXQHpIeAR5UhkWMUtKGlpbNc9mokJUJXYB4XeKMRxD3Bbq9uXj?=
 =?us-ascii?Q?B5+6Rl0oIU8h5js6Ms697D7JTcxxPz3UoX+ldJkaqbTV1Vy8KXeCuLJhpF+A?=
 =?us-ascii?Q?S/SE2xpsn+RBxsU1567hcM9ShTscDAZgb6FMLCQXqGMd0edmAFM4G4nsgbYR?=
 =?us-ascii?Q?4HBBJdRYv5BGjRRrNPTA89cFjioAbh9geYSaFVUPCgeuA3GxC2B+3hNfU1VZ?=
 =?us-ascii?Q?m2Prg91WJ17Mq+vnybc76FsPGMDUwGnMPowXA3RxMdxI5791X1gvaHQhk2sn?=
 =?us-ascii?Q?PvT5s85EcFuoXzHTxxICeaZDbEmB0AdDP8W+A1sifIU8uNZb5J4Em8ptbslD?=
 =?us-ascii?Q?7bJz1jR8i6E=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Q+9mEJBK0AY9inLXE1FmYICrOpEm59DafrmCGwCy94F/OLT4omYdsW1i0MY?=
 =?us-ascii?Q?MI2mThRX95AUVGLDfL9NcO/ZfStutrGMeOZ/RdDyBBM+In2l0dZgmnsnunsf?=
 =?us-ascii?Q?o3Ns0rD9IzFRzfIGS1ekQLBhCoZYeOBmqg5ZkGI1w0kxIVN1xHwxXh1jT6Qa?=
 =?us-ascii?Q?+txOnk7/l206WScLMP0ifVBO9jmBJkeEWbzPsAkCpf4RUJFUWHfnip+g0p2Y?=
 =?us-ascii?Q?okEYwmeD85zBZbOl+MCKX1MNv+0n00Ku/NOJ30xCFIUwc2QVwJFDGsZ395dO?=
 =?us-ascii?Q?reht4Ks5gBMCM396DcaZnu2E+I/TfL+lHrcKdUGc2pY/MV2vhBon5VUp1Jjh?=
 =?us-ascii?Q?xJGFhD2kFgMikGpSqGXFru4TJtBW+NvVtg7pmUAj7wnn0T9Si5ziESVZhb6U?=
 =?us-ascii?Q?0ob1jc1OBT7HC24wYcqBvLlCfHMBMMbL8reyJemB9BnE7VudkeneNtd8HNkM?=
 =?us-ascii?Q?9thA9f73BAch83GlVgRUiWh67sfp0oyPXqCYL+BnSzsKqkiEOtJsXjSi1z3A?=
 =?us-ascii?Q?ZpPE1HEtGLZ7bto67hLBjMEmmhd/PuKRSUXTTfDbNpmHCueXj0z4R+WmCUaj?=
 =?us-ascii?Q?y63am+gRnmvNPajkfUlq7pRZUNLKe2yDDD+DMom5Sb6N1hgLlO4775c3DAgu?=
 =?us-ascii?Q?VzKasRKhkFU51ysi120k+d8FbKJ9jwAOfme260h5hTkf4bF4UCIQftTpLtgT?=
 =?us-ascii?Q?URaJX7IbDQ5vjvNy0+CYx+rZLSFb5VRB4Xm6YldQ0/R8l6T20PA1EhpYGy+r?=
 =?us-ascii?Q?//6uTYyeTJWIYsLAralqGpULV/cQJ/oInFo7w4bPTrJRUUAFU0KG1iSOzMA2?=
 =?us-ascii?Q?3Dc+sWVdD4UI3GLQvcapQwRg4VkHLuT06AYagWO54ODRYwkDJR6F+ExZL0sy?=
 =?us-ascii?Q?x0yu7bhpebUPp+sZKbrdCBKJjoTRNu21xyKo98tRG6YqwS9D4F2FqdfJ70tN?=
 =?us-ascii?Q?L4VLkNy0EQ4XWcMrRwtThm+ps0QdnDmIZK4ULhpK/G9XLfmiYrbh8pBdidv8?=
 =?us-ascii?Q?3vsNZg/hT1na9LtxDtFiPp8rpQPShZdPSpIPtcJVwjtV/VXlk+j1rJXgWOFs?=
 =?us-ascii?Q?roAFVLYhcDHQg7WxltA8LOMq7dRYhQkJp+Mpzci5LMPzyXSak9TH+bbcwDVv?=
 =?us-ascii?Q?ZJqZ/PcL5pxisTH5TRlhEfyxGByMq1DvBvRaqQD2ZtzaExQdyBqm3luNpDYf?=
 =?us-ascii?Q?wpiTBU1wBWPhArUfWkbb+cmxIq4cgPfOsWg1FhzJRw6rJsYH8EyP5AOXBU2w?=
 =?us-ascii?Q?s4hGhKBrcyJavw0leTYNevk6ZdYK/9wXgNk7RMSYwc/ui0XgyVjbqnhM8xj3?=
 =?us-ascii?Q?U1C1eLK2bcs/BAlMMLigwKFA5GWDBTdXjmNySgBpAxwlwI3XZn+ArLsTDYJr?=
 =?us-ascii?Q?N73o3hzNdynWfBpTvILmU+zZL26JUDprCp3aHX5Z24MkRtSbsUt59KnBgeb6?=
 =?us-ascii?Q?zKVRo2v5KRhz7HY4Ca+4i8JzF1IDHqR4QphwDNVHFJY6o4kKcHg3KnzSJOp0?=
 =?us-ascii?Q?QTWsQype6VsN+DrkJ3+LuK+zd9u0BVaWNX7kh4kfW5d9S+G4jX6p8kjpVuha?=
 =?us-ascii?Q?nJo0NArerYbfXDA49J464tDcODhXntdUaUoJv3Nd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32326f2f-2dac-4626-f806-08dde1c123d3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 21:16:20.4397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VoekkYy/WmylXJlLL+WeqtZtZ4XNNg+/8wzzodpc+sk8Wqq+QQobnU/Pbdarfm+d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4494

On Fri, Aug 22, 2025 at 12:51:02PM -0700, Nicolin Chen wrote:
> > @@ -3113,6 +3116,7 @@ const struct iommu_ops amd_iommu_ops = {
> >  	.release_domain = &release_domain,
> >  	.identity_domain = &identity_domain.domain,
> >  	.domain_alloc_paging_flags = amd_iommu_domain_alloc_paging_flags,
> > +	.domain_alloc_nested = amd_iommu_domain_alloc_nested,
> >  	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
> >  	.probe_device = amd_iommu_probe_device,
> >  	.release_device = amd_iommu_release_device,
> 
> This will be an HWPT-based nesting support, v.s. vIOMMU-based.
> 
> If AMD wants to enable its Command/Event Buffers, I think this
> should follow the vIOMMU model instead.

I've been expecting drivers to do both, like ARM.. Nested is the basic
infrastructure and then the viommu changes what domain id nested will
use similar to how ARM constrains the VMID based on the viommu.

Suravee is this how you see AMD evolving as well?

Jason
