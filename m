Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BB520C01D
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729086758; cv=fail; b=quySBu3mSNlTf+/ZrdXjYZll8RpERs/bilzEhHMGL8NL1Yj6ucP/mA912fIfrXjACdWHMUnKXlXHtEWSOy2S+rXx8eL9rNyLzX1ogAmIkHDufCaiXrp4SYMVOlydJAx2w8uX1rTN9gOAGjF7LDQLnShkag7PCqi3pVB7dZ99HQg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729086758; c=relaxed/simple;
	bh=shVUVKfEFZuivSxVJt5mxwcjTwZyBijbMyoLaAxOxeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=in68J+hC1UAzxq1RuAWkov9KQANzS7DVcgmhHPHej14eLhODksC/S84j8nRGYGGx4UzSBNsDh/af6PAlTtrjmiLdEiCKRorn6OfI+HdpmYRe6LbGTWOaZC3vjd5MTZbDqnHjR4vQpsBiKAb5r78ej13/CSPKhlQrV90yzTIWpY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RDe8sf89; arc=fail smtp.client-ip=40.107.96.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RDe8sf89"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LeY5WL6fuP1+ii1S+f23HBuJ70EeMgqIykP5MS+EzEAD9qFpvHHsTKrLlJ673MV1zczJ7daFnVFupkJpzi1Y8Nx1S2ZSqAmXPqFWINgnhLLsRXXB/yH1O+uOScurgXTyV0103nSo+E25i/8lIOjARGNLyJFBfNTuTIjpiTjPG3o4AAaFxwnDUpryLYYv/YfarjYpI8UdSHnWtO3E9vsjCg6cv6vmTm/7hUGC5LxX6WZZVlVDLHWkbF62IYI4h+xpLoJ4WJLl/OxtrzJUGgphH/qKD83XzWXl72jAZyJ3GfdaRroL1iFO8JXBzq6IQFQEFtlXHpXb/qqfevuzw/6uaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkddZNMi3UTxddxTlp/lpOTdA/pRmgqOUvy7yqN3O+I=;
 b=Xs1gldL9OXH9F+LpsRtVvJGNkz8BQ/SgvTJrJLdp5fUnbLwkb7qXs5sBGf0flDTwtrmujOD/tA6cXxNdoJiu4sbSEH3aN86eDd3bcuIfngdUaC4UnFB6CFGWSdG8ZqCQXqjPdbAI1P88ka5dWFy5q7KZWyNKJKP1fHk4G8G+/ZgNcSGZDrUXh/jRHY098Ymx2rrxfNdOvEv7D2ljsUw15zPiPh8sbHCX1ZQ92pzrEiFwl/XsCMZ71CQ879aolKSFe7fIdv9aRGi8pOWwF627arrheCTopHgaXtHgzq6+Tb1FzbnRw1rYZLIVxcX1ztA0H1blKe/USZxLxeHR+aTr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bkddZNMi3UTxddxTlp/lpOTdA/pRmgqOUvy7yqN3O+I=;
 b=RDe8sf896i9xSv4EHaZbzYrFLnXWUpMbwtKwrJaoMKusbmUoyHzzSsro6VQetceNRNSMjhrZyRW7CtqUSrkqHhjVlF9kEYW+v2VEmwnEeQq9DEIzgxfQcEiUYHW+SL5BOJQCiALmqxKyVvSZkDoiecBZjRF8HTZEhKYbq0cf5VxTAwSg6K6S4uFFZ12Zn9had5ZjW53IPMDRSpvNgX2ytOVh/zGba7cKSR5p7NjVZlvq++q0jfVSJPLs2//Ck/fPvP1wRDeytO50z8tzmQdwtOkoI6QRToq1qbxk59+SNB5E3gB7mePv21HAq+PX5BvVAfaNgH/Dggz0kGK0cG3jNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 13:52:33 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8048.020; Wed, 16 Oct 2024
 13:52:33 +0000
Date: Wed, 16 Oct 2024 10:52:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
	kumaranand@google.com
Subject: Re: [PATCH v6 5/9] iommu/amd: Modify set_dte_entry() to use 256-bit
 DTE helpers
Message-ID: <20241016135232.GM3559746@nvidia.com>
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
 <20241016051756.4317-6-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241016051756.4317-6-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: MN0PR03CA0030.namprd03.prod.outlook.com
 (2603:10b6:208:52f::19) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SA3PR12MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: 88352b1e-5b11-4423-5922-08dcede9c8b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fPapqE8+xpKthtXSpnzXlMK3GM2xlBVpboorIDKqT+JXWRV+kAojaMqiOhYo?=
 =?us-ascii?Q?QGUOROQ9xegAF807I6uLbonjlj4caM38900fVUB6qX2J7DMe6sbyVq95RTgt?=
 =?us-ascii?Q?0uUzpscGkLCwV39fjuEWyQ5m6Av/QwXd9hte4KBueZ3KrbdprHGUiBqeLHZ5?=
 =?us-ascii?Q?t60yTWlQFfxbG1wJxbrGukmiUGwWYGWkTfhfG32AT5T3/RZINp2FuosJz+Z9?=
 =?us-ascii?Q?9kovvTNxRqSNNxN9ZfMTcp+pLjDobWp6CaTbfPfDIh/nOXW9q7Xhomc4A44j?=
 =?us-ascii?Q?purEW9X5bHKWaiqNSKssmzIe+AO97Vj8jZ6cyOwSULStOYG+L09sZNHxSqu4?=
 =?us-ascii?Q?Pk/II3mYinje61eSdZ08hH7JPhMbF6LVW67wfxaKJFLQVZPaPJkUkqcuCSy4?=
 =?us-ascii?Q?oiPkBTKugM4WkroHCLUE9HuVNNIlJWrJ4KWHSW1FALrqMF2HzHzt3UNDJC7L?=
 =?us-ascii?Q?ic413T6//Ny1P9PU0MoO+QGCjDMVz08Jqyy+bIfzBja6UrM6Gn5n20fYfPFE?=
 =?us-ascii?Q?AUum/3U4YTLL9jepGlMYQiEpBhuwCqaegBMRgGwhWr/xwxRLOKZjT98ySfGz?=
 =?us-ascii?Q?vMCbH4LtT7TmGe9+jHZ6Mxk5wk1nwm/NqWJ3f65OUvMI5w4/0Gm4ZWMKkV8T?=
 =?us-ascii?Q?+hLe9f/I2JpbUnVFWMTAUL/BuA8rWwxxcFxV7Vp1mUSum5yX10i304mlMEwk?=
 =?us-ascii?Q?UxDj1tBF4zipVZW1iVtrjGFmDAIZQafejDEbJCxyg4YKdN58WumwN4S2HbwQ?=
 =?us-ascii?Q?YpvRQdFyz1uez+dgHQieHNgcn2YG2le/mIL+3o2AeKNbVH6qqrQrf7Ffiiiv?=
 =?us-ascii?Q?rL5DBuOJEHT0G8FLE7+8dYKBOddzbI6LWJyVkcETqBMZOX+kzWi+dO3eeEPy?=
 =?us-ascii?Q?cw4/T34znUm35aU4vYxKohyhknmt438l9alDMrX59r6WzgVjdwfmmJNBV/yq?=
 =?us-ascii?Q?2qQP6/e8uaF4myHqXu+ry4cjlWdamVoxPXnvc4iIq0A6I7WBmFSktopryRSy?=
 =?us-ascii?Q?ARXMzGD0bTyDHrSD+APwBwbchuCf+Ze7jlFSIfHVlcaCZlyyfwGya1ge36h8?=
 =?us-ascii?Q?DNbU0mUvFbh8y5ONpjpce4yLgflnwkGWfJbVBNSwQJqoXYe+o2cLYQsFbbBl?=
 =?us-ascii?Q?/364uGflJVVEVvJ8XGX1gl7n1NuwFhQiV/WgC3jVedlluiLFnqel8IwP/loR?=
 =?us-ascii?Q?HJoeCQGNvAMGA+j+iKmmZVucz2jTQOlRsQHXrPbG1jQVqx8NdZBCYN8mgV2q?=
 =?us-ascii?Q?YJm+8jna2YQp32lm15YJEepALtZWSP6XUdSRe1WYgg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kvB92V/WAghF7r2JfqdAVEq/CPFf9G4bEYjygDodMLbyWk5d/aQKtQXc2mCx?=
 =?us-ascii?Q?NwIxivoY3RORv5/TdU0Amb7ULvR1CU7rQRSIo2qdkG9hpU1RS9jnCORS51kO?=
 =?us-ascii?Q?pYFwOV40LpvvE3Zl0I43esYJC+FqMZi1EPdnCap/qdeNgmwjDEOxbkPxxnj4?=
 =?us-ascii?Q?j5IkLCutmINVvsBYYUx/WkLTtKHHBisSUGgSnsKspmCg731vxhiImaWd04sO?=
 =?us-ascii?Q?cJ+bFPU+VFDfDuQdV8fgDwTodnnS/oKBMzrUSRDNGQtADHKrOMAG2dmtUKjS?=
 =?us-ascii?Q?hcGjN8PurSQzDThqCzBg17ciTISmrLe3rx8h1mCqBmchsPrbx+rUdZgc7Su5?=
 =?us-ascii?Q?YNIifuAg1+K20Md1j3JRITyJC2s0Ux328OzilnU2Mob2SuVJGN8vQpUSL6pY?=
 =?us-ascii?Q?0ZsqEA2CaX8o2YzkSH7MptSpeytDN/fHjGGAXKRN5G5d7jLEx5VifHrSiQRR?=
 =?us-ascii?Q?WgNwPbSGcUO7IyfE9TKybNCeu7alxH2ZRCqUwCb4Us/9l/YqerWHkS6a8NCv?=
 =?us-ascii?Q?chhQ2g87oGZxvzNoF0eIY7NY1ZwSsBezrg8X4CVs3ckLgX/j4L6w3xKjvQe/?=
 =?us-ascii?Q?QLvj6EGZKUSMlVIn1NukW1EECQ6wEgSrlK/ECaB50WqBGWLzXVwLcnov7aLi?=
 =?us-ascii?Q?J61Vyjg6KvLDKr8Gt9VkZiXXKLZull8z0CW5Lx11+xxebYYXJjfJfd9o6KIz?=
 =?us-ascii?Q?PvDPAUKqHxagVfZw06cX0vY+fj9IxifViNs+KUR/RE1kL8GlASfL0WGeLj9C?=
 =?us-ascii?Q?I/EEL/HxDC1wvq5srqSFrW/cd2IR0urvznpYDlyexbjqDS4pWtSCfW+mKoXj?=
 =?us-ascii?Q?5c1m2UJny4rXdz3Lvz0q0Kt7xVmmXoaxPQGF4XGF7iGmAFQsxDC73t9aC3K6?=
 =?us-ascii?Q?mP5dPEdKlpoUeqhWANQ2mnDj/RQarv7McCwfgQ6G9Yhj1HCwNGkdsr+YRcfP?=
 =?us-ascii?Q?RaQee7ULn14+l1BtHW1Y/NiREjhK2cnDn/gZSZfKLuIjg1R5N2jcvZx9xUl8?=
 =?us-ascii?Q?svSJB3PT5reWQkW3ON3qsekYaYclcE59fZtTdS6U3A6r8S76FPOmd1N77hx6?=
 =?us-ascii?Q?0QKwElAO2wX0LKT79NGc4Wo8r+U67UIydCtVS7ehRe9opEv1KRwCPJoxl2AB?=
 =?us-ascii?Q?+X45gjVjVCwLvnc2Z0jHmiuXDnpt4SwbCQcVmIgGtqz9xQG+CX3Vez86ufg0?=
 =?us-ascii?Q?HYvo/Ji6I6oEJK0kHVc2OrTeCipEwAUgytgR7ICHIPjof0Cwtf4DN5o1pbzj?=
 =?us-ascii?Q?V60K9xrGycT//RnLBH5bUoeVarhZq6V7supjPughv6mfW+qlmNTmxIgPkE+5?=
 =?us-ascii?Q?j1a0aVd2R1UlvS6K2aaz3uWSGUD+vB1z/hYQBYYoa/U9w0fMc3if7Mz5gUiB?=
 =?us-ascii?Q?IlAflC0/do0OIMYNvDAUklNmc+okR6sov+opX9k9EK6zIXa2rufl4IlD+Y60?=
 =?us-ascii?Q?sT/gRZwdvbKOy5Spx/TRbmHtKAQ8YvlGWI73EhaNnFQwCbuSs+Ys6Kf7RbQJ?=
 =?us-ascii?Q?1NQpnIYM0+3RrpQ0UjUgyjCta2MlD/g57gBHIVsqxSp/8OvkjCPk6YhwrSng?=
 =?us-ascii?Q?pDZ5l3aQ1DRV322BJyM=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88352b1e-5b11-4423-5922-08dcede9c8b5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 13:52:33.1714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2OG0f0MnzTuYkU2OkWDXQ1Nt1WqN3mdei0KEB0ATAhEXajSVRIIwr7Czv4VEJXeB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439

On Wed, Oct 16, 2024 at 05:17:52AM +0000, Suravee Suthikulpanit wrote:
> +static void set_dte_gcr3_table(struct amd_iommu *iommu,
> +			       struct iommu_dev_data *dev_data,
> +			       struct dev_table_entry *target)
> +{
> +	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> +	u64 tmp, gcr3;
> +
> +	if (!gcr3_info->gcr3_tbl)
> +		return;
> +
> +	pr_debug("%s: devid=%#x, glx=%#x, gcr3_tbl=%#llx\n",
> +		 __func__, dev_data->devid, gcr3_info->glx,
> +		 (unsigned long long)gcr3_info->gcr3_tbl);
> +
> +	tmp = gcr3_info->glx;
> +	target->data[0] |= (tmp & DTE_GLX_MASK) << DTE_GLX_SHIFT;
> +	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
> +		target->data[0] |= DTE_FLAG_GIOV;
> +	target->data[0] |= DTE_FLAG_GV;
> +
> +
> +	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
> +
> +	/* Encode GCR3 table into DTE */
> +	tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
> +	target->data[0] |= tmp;
> +	tmp = DTE_GCR3_VAL_B(gcr3) << DTE_GCR3_SHIFT_B;
> +	tmp |= DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
> +	target->data[1] |= tmp;
> +
> +	/* Guest page table can only support 4 and 5 levels  */
> +	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
> +		target->data[2] |= ((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
> +}

This looks OK but suggest to use the new macros and things, it is much
more readable:

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 53e129835b2668..fbae0803bceaa0 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -409,8 +409,7 @@
 #define DTE_FLAG_HAD	(3ULL << 7)
 #define DTE_FLAG_GIOV	BIT_ULL(54)
 #define DTE_FLAG_GV	BIT_ULL(55)
-#define DTE_GLX_SHIFT	(56)
-#define DTE_GLX_MASK	(3)
+#define DTE_GLX		GENMASK_ULL(57, 56)
 #define DTE_FLAG_IR	BIT_ULL(61)
 #define DTE_FLAG_IW	BIT_ULL(62)
 
@@ -418,15 +417,10 @@
 #define DTE_FLAG_MASK	(0x3ffULL << 32)
 #define DEV_DOMID_MASK	0xffffULL
 
-#define DTE_GCR3_VAL_A(x)	(((x) >> 12) & 0x00007ULL)
-#define DTE_GCR3_VAL_B(x)	(((x) >> 15) & 0x0ffffULL)
-#define DTE_GCR3_VAL_C(x)	(((x) >> 31) & 0x1fffffULL)
+#define DTE_GCR3_14_12	GENMASK_ULL(57, 56)
+#define DTE_GCR3_30_15	GENMASK_ULL(31, 16)
+#define DTE_GCR3_51_31	GENMASK_ULL(63, 43)
 
-#define DTE_GCR3_SHIFT_A	58
-#define DTE_GCR3_SHIFT_B	16
-#define DTE_GCR3_SHIFT_C	43
-
-#define DTE_GPT_LEVEL_SHIFT	54
 #define DTE_GPT_LEVEL_MASK	GENMASK_ULL(55, 54)
 
 #define GCR3_VALID		0x01ULL
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index caea101df7b93d..b0d2174583dbc9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2012,7 +2012,7 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 			       struct dev_table_entry *target)
 {
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
-	u64 tmp, gcr3;
+	u64 gcr3;
 
 	if (!gcr3_info->gcr3_tbl)
 		return;
@@ -2021,25 +2021,24 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
 		 __func__, dev_data->devid, gcr3_info->glx,
 		 (unsigned long long)gcr3_info->gcr3_tbl);
 
-	tmp = gcr3_info->glx;
-	target->data[0] |= (tmp & DTE_GLX_MASK) << DTE_GLX_SHIFT;
-	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
-		target->data[0] |= DTE_FLAG_GIOV;
-	target->data[0] |= DTE_FLAG_GV;
-
-
 	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
 
-	/* Encode GCR3 table into DTE */
-	tmp = DTE_GCR3_VAL_A(gcr3) << DTE_GCR3_SHIFT_A;
-	target->data[0] |= tmp;
-	tmp = DTE_GCR3_VAL_B(gcr3) << DTE_GCR3_SHIFT_B;
-	tmp |= DTE_GCR3_VAL_C(gcr3) << DTE_GCR3_SHIFT_C;
-	target->data[1] |= tmp;
+	target->data[0] |= DTE_FLAG_GV |
+			   FIELD_PREP(DTE_GLX, gcr3_info->glx) |
+			   FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12);
+	if (pdom_is_v2_pgtbl_mode(dev_data->domain))
+		target->data[0] |= DTE_FLAG_GIOV;
+
+	target->data[1] |= FIELD_PREP(DTE_GCR3_30_15, gcr3 >> 15) |
+			   FIELD_PREP(DTE_GCR3_51_31, gcr3 >> 31);
 
 	/* Guest page table can only support 4 and 5 levels  */
 	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
-		target->data[2] |= ((u64)GUEST_PGTABLE_5_LEVEL << DTE_GPT_LEVEL_SHIFT);
+		target->data[2] |=
+			FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_5_LEVEL);
+	else
+		target->data[2] |=
+			FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
 }
 
 static void set_dte_entry(struct amd_iommu *iommu,
