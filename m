Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE74224D7
	for <iommu@lists.linux.dev>; Tue, 15 Apr 2025 12:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744721448; cv=fail; b=U704NYFZbljMUUwObqi6qs9IRcuuRCHjRs+PGYdismaakavkjVLAFkF0JoVTcpCzYnn1aHnvML9FRFMXldQkjQJHN+YJy/5Jmc3I/GvxaESyTMfl4KIWmpUTo2ZA6Xgsi4onv7Mpg2t85Bj6fYFMWUq0ja2lnDf2VUyzkxBj7zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744721448; c=relaxed/simple;
	bh=A7JylRvLc2Z72nhtdbzIPJAv7GrI6SbBkt3I6KcXvsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ilb51xpUgFqJhGhPp6IYLg9x8wpZoTTJImROMGDDYBhXVtev+YgGsRYfB3dABUPxlJYhCYvVPgADB9ySxUMbk0uhh/kMF9oW/mLpLBURSLTv0l0ccHGQKMq77isgu61o8W0Ny9MDKmhFHW06CYjjT075Q3PL0zZZ7vKpF2PPwZM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ucRCBsj7; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ucRCBsj7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlZItQcuZbbHGig588zwQzt/oplBHtFWV3MFA79Nb0zpTf+NNNbwUzIjZZaqKBe2ZzEJAxrsjgSPZBP2RCmDePzEJ2Pexm2VnzbZmjDBhYXhqVUOAhdjs/FN3KQ4sq6fwqvjv2C7K3N+HRZ4gwGgEbRmXOjZDRiBb7QHYuTHNvY4LKF8kEd/BAT6uAKRuWpTZBzvBY7SLMZz7F96kuIXOSNYZ55Q6fChaHxT2qrU1wqFVbVHG/C4LfbIhw5XMlcD1A4rL5tN7eWON133Eufuqgrg1PKHF5QQgYvTj3yS6VezAB4uQe8Mpot6E/cml4glgV+g2+Pgz87mfHtgS/32OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eq5EPUw1eiJXHn3ymLcEJXfs8uev+O0VqMvoY+NiVCk=;
 b=pBnla0XC+eh767t3FtEKkej5o02Tg3nID13VYbYwgB9lD/suwddZLPIfl4lATlESMl7MKxE1jnki7NFzWuqtam3EwVgJpdOKh7ZvYbFpPFwd0vZ9z0U4ldnO/wvCQRnr/ahwm8Ja0oNN67DKnw86Ua5iODNVIJnVM4BMQ6B4+JSdGlfPdh3wl5vGV6inpyYV0wMngqhSXwegVTexW5eXdnZilmOMSKC/IB5l16WkWYCPJlKqyjP3WlA56w4DBjI9sut2Pp06owb2Q9H2gitYeePc/46S9/Y8UBRWt2FgiTWIteuiKKKCAHvBL7AwwRaHRL523RaC8L22HY2OOB+azA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eq5EPUw1eiJXHn3ymLcEJXfs8uev+O0VqMvoY+NiVCk=;
 b=ucRCBsj7TM7NXysXzD3JUNuICfC8GezPf3RnDiHWbdoNI7lEvoXEvhvExzt3NWHrDoSE0AIid+a9nalb9j6xtaQyJwZdoeKRlupvrvANd+2fXv6pYoWI5XlaGH6zEOUXczBq+kY2NeZrM8P4rLBeqgwvVnVUaKInNV7va+2xIkGae7tA18JyaAIIw1xwGNeyeHBAZpVzJDZFGgx++kesCuj10N68NapjL50dawpyM1qQs/03/7Ksz/AWNT+WX23gR1b4JTc3ymqXm4ZcttU55o31u7wLprj3XgC2/9k0Lq5Wnj/oTKlZI7oygd9yCGgqMYGUsuWHLhUDTewpNr/DPQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB7687.namprd12.prod.outlook.com (2603:10b6:208:421::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 12:50:43 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8632.030; Tue, 15 Apr 2025
 12:50:43 +0000
Date: Tue, 15 Apr 2025 09:50:42 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	kevin.tian@intel.com, praan@google.com, nathan@kernel.org,
	yi.l.liu@intel.com, peterz@infradead.org, mshavit@google.com,
	jsnitsel@redhat.com, smostafa@google.com,
	jeff.johnson@oss.qualcomm.com, zhangzekun11@huawei.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v2 06/11] iommu/arm-smmu-v3: Introduce
 arm_smmu_s2_parent_tlb_ invalidation helpers
Message-ID: <20250415125042.GA517881@nvidia.com>
References: <cover.1744692494.git.nicolinc@nvidia.com>
 <61fef9052b2034e5b4ffa1fa6ce481667d8ea6b1.1744692494.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61fef9052b2034e5b4ffa1fa6ce481667d8ea6b1.1744692494.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN1PR12CA0028.namprd12.prod.outlook.com
 (2603:10b6:408:e1::33) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB7687:EE_
X-MS-Office365-Filtering-Correlation-Id: b551d226-821b-4486-4b25-08dd7c1c2269
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ex4kgmdwqsk06AR0kyKLp6tGbRPIvSJ54nfQTX9Vbnal4TpINULSR4Ltb+8a?=
 =?us-ascii?Q?rNsSQgehYOgjNIUtiw0uN6Uo0+HfeMBsVuyNZ4tWEG/Ie6Qu1i43rfpzoqcV?=
 =?us-ascii?Q?ggjj197b50J6dqm5cuiuG9YwS+mfyf2L0e9a6hRtzXyTeh8Ls5bwBZIsoU0P?=
 =?us-ascii?Q?EvRM44uheesx6kLauz2Geo3rGGwr2yu63xwmd2Y1FebL2EldSqxndDWe5Xac?=
 =?us-ascii?Q?gsoKIxIjQQBckqzjcxBI5XvbPOqU6dBZi3l40F6HczYpxBdh6CV2Ih5YCxNB?=
 =?us-ascii?Q?DX5LLNxlcLSyMWaHBmbS5utCBCemwFRLLHHAoUHYIea2bXTHy3aeW7b31HYg?=
 =?us-ascii?Q?bi0oTx5ZQ1L6QX3emRbGNUl4JEslu9nZWipk5M6qirXH4hT17a+I/Bu3emXZ?=
 =?us-ascii?Q?JAz1grIOXFKob9G4yGFHq3qrwj/4u6NIMOhapdh3hIGpwoOucOmH+/Fs7A0K?=
 =?us-ascii?Q?ryVAPUaM5Rp8mbnJ2kaafxmiSYZa36JICQRmChlEjNEeddYGFk+fJitLD9rQ?=
 =?us-ascii?Q?m8AZVUkAIBKUqlCOoUzUZnyTt4Ff1ArR+vFzmnEU0r9lSNHwh4J/FPF7zn+H?=
 =?us-ascii?Q?9PaGkv1S5/zvGwOugdw3iXSEGGaZuL5W7mIJaopw0Bfy7CY17sbikfgPrgpP?=
 =?us-ascii?Q?p9xi4u3cQgY/6yZc6NpUJRF/mhGMxksXhZaMrAD0wtC68b0e3ZION+eultrX?=
 =?us-ascii?Q?ZVwbnTcOrjj+bqJQs0DWdBwZ7jhihWfgktu9yP4hH3eO1cbXyBRcnSUkG61D?=
 =?us-ascii?Q?CJU4ynvfxzDu8beALKPNYfFfVtXO6aCwzt/mrjCNEkM3DKNNKv6LUxsKmdIO?=
 =?us-ascii?Q?7bJkX5ygjsaTW4lqgPW9UsNT8e3WnmeisVMLKwpZmduiP4dxbaHNPtOAcVjX?=
 =?us-ascii?Q?6ojThFo5oqC5Ry/SQgWrfvvXz3kNo0WSW48wj808p+dwatxngeZEyoyp+gbh?=
 =?us-ascii?Q?aIJyQOnVAVGYeNNN5jMA2/crRB0PPJOQ0jGG0Oy4bRaubOpmeyPhtUwPvEzL?=
 =?us-ascii?Q?xwjQWf3T3U+kncSeA0ZMOM6ZqkvYMhuyWYgFzayNswdaZtseer1jYj6z/YUh?=
 =?us-ascii?Q?YhbilJlODaE87E0HZHcQA8JB/E2frheltHbeLMdIZE7qfi9b92FeuIOk3xHc?=
 =?us-ascii?Q?ae0sTn0zQMo+aoooEQo5RPrVqgfOLCsRnK5Ru8Jnu3S+aeqyqHq2fKJZshkU?=
 =?us-ascii?Q?XVsvt3Cg7dPRWjQXun9ZqZVHtLcEScunEDKFLYzjHU4uzJjebxgTKm0imbTO?=
 =?us-ascii?Q?dzkZG/2rQKX0BIVosVK1Y5v/v1gLwexyNgl8xABjC148LMfYUHDMFUvkKoUB?=
 =?us-ascii?Q?tKma4e9oCsTrFepEkLyq6NADe2av7ItjZN2WciBX96Bjy8NLsZlGHI+8MbfD?=
 =?us-ascii?Q?exehwDcnPN8sb/yJugcR5TqrOa5xAJS09X4CHGp5aUO2bJNKHF8oDVCsxppc?=
 =?us-ascii?Q?zPyjvARuBlI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?FTVc9pHqpspOsoMYaxnWzFcSaJmMFwQcgn+0QqRwvRnXktY/kE8IWoPta4wB?=
 =?us-ascii?Q?TKyPCP9EWEBX4Vj5cqayA6tmra1/fXos4zK++FZ4y1/YWtEv3FbnoUQT1/Cu?=
 =?us-ascii?Q?l4EcyakMUnNyL6YhrrfkTMlIuT7+v8rdBAn4eYUI16pZTwhBdEMGjyq0YcDs?=
 =?us-ascii?Q?xWRv5DTGXqFQsE3woKlWITLv7e74jRtR8Lnav770F15rgBcq3/h2WOiE839t?=
 =?us-ascii?Q?Zs5r+ClANmMF3rkImHPGyEfL4qyqYw6Sr8g95Ug8FLwCYWo98NRIJLBMiuH9?=
 =?us-ascii?Q?C1bp4IAjlg5nB2GZuSBi9IG55z70jk/NAhz0hcw9keI//0tJggDMccvldOC5?=
 =?us-ascii?Q?9l7zV1EG0tD3hRlMhbsSyG9c/HM2T9vhrY2mJbgF2WTbEyHzQw74RIZ2n6fN?=
 =?us-ascii?Q?SLwAkIPxH6Ijt9qMT11K+YK1iFh8KZLenPcrpqFcIbKQX1vVyAZyDvoavfA7?=
 =?us-ascii?Q?Y4s6WlkfZSWBvdJy21vb3nGbsFmkw0bQMyDn0KLYHx4ObqBFwFW1jMmVAlsN?=
 =?us-ascii?Q?AIlV/Rwq5SKAjGiBOgE0/B2Oc0opFWt2LBQrvyI69m3XQOQnDUAogEA270lc?=
 =?us-ascii?Q?u6Afr1h9LzPy6Y52Cr2jaOnD/2KYyb7sTGTe+J4KCK6kjbgR9CnmCU0jxPpV?=
 =?us-ascii?Q?f1Gp48ZR7fIeLw8C95WRtBDzRKwYV27tTJmANBMRSEQ5S998A4HkPwFGPkIo?=
 =?us-ascii?Q?WQyw4ZZG0aAa1Vyq26gzFJCRe+M4VTqt2U3MMLTii4PXVv3Tv0GYA2MYUyHB?=
 =?us-ascii?Q?mdtN+RpCbozT51B0CngHMc7XzvHAIiRZja/pfaPgP9tF0X4QJunkK2NVQUKt?=
 =?us-ascii?Q?n09sSEFt8IHpY+PQry7PneRRvPyktKIbZmTqZKL74ahLR+69F3tFAUl1TyGm?=
 =?us-ascii?Q?nnph90DSlwaZouL03FUD/HX+lwqljzcjBBkmJ1Z+GbxYm3GVeiM6wtE5oLll?=
 =?us-ascii?Q?9aoG6YRWLMby8iS9s23cNUFf42DlqjF4mDtGqo35jz3fUl5mecTQxO9LhbN0?=
 =?us-ascii?Q?QDQOV/Pvf3Grritl8Wj05SqWebDVe7dBiiLTLXcI2Fp+1w2q6DQRo4nV9Eb0?=
 =?us-ascii?Q?XWZ/yMGJ5xk51yvC3HgEl+w5TIz88FGBjoCih02Tg3Nnen3OAOFASQ4xtOhn?=
 =?us-ascii?Q?CR7rfpbtRaqb3cFunyVHKxAlmv8xKnlxqdXCYrD7NIHOq5G76GUWLd0F9leW?=
 =?us-ascii?Q?H/xTcqt3QrJsKUW8HWqsvFLj8aIZupT/kRk86fVOZcoPuyzMLKhtmumHowOW?=
 =?us-ascii?Q?Y5bxBTyV27Cdp+tD0HefbGx6eG86L6rkxGj7uOw8q+xaqKCD5sWF76Eo0GYr?=
 =?us-ascii?Q?feisCbrIhhPobzbpOMob+9JsipUgRbhQy1/U/74UMX6DbUPJpqGrqffTjmWV?=
 =?us-ascii?Q?youumLeAA9WojsIX1BZMRzfF5Jbxn01xJZBAKp0Vc4i0UaNiRG4/hbsQZPg3?=
 =?us-ascii?Q?ZKpNX4tVwy4/YTzeHo2Hs+InnaUZzCkV7tE6Zwej3Vz0Y+SA3ckX++VjGsMN?=
 =?us-ascii?Q?KAuNS67ELs5zqALY8TgMwpidgct0qpBzqeehoKzozjRJGb0avhQ8gDIGG7ia?=
 =?us-ascii?Q?umUwzYAzlf0SK3yzyzwuscW0TrTkwZYMkZWTt8Ss?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b551d226-821b-4486-4b25-08dd7c1c2269
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 12:50:43.6696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U2SP4ZbQY1WNcw+G0B9VsJ0K47bDjfWs9h2Npbq+wRpvVjhEthVPF1eWLL1158Y+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7687

On Mon, Apr 14, 2025 at 09:57:41PM -0700, Nicolin Chen wrote:
> An S2 nest_parent domain can be shared across vSMMUs in the same VM, since
> the S2 domain is basically the IPA mappings for the entire RAM of the VM.
> 
> Meanwhile, each vSMMU can have its own VMID, so the VMID allocation should
> be done per vSMMU instance v.s. per S2 nest_parent domain.
> 
> However, an S2 domain can be also allocated when a physical SMMU instance
> doesn't support S1. So, the structure has to retain the s2_cfg and vmid.
> 
> Add a per-domain "vsmmus" list pairing with a spinlock, maintaining a list
> of vSMMUs in the S2 parent domain.
> 
> Provide two arm_smmu_s2_parent_tlb_ helpers that will be used for nesting
> cases to invalidate S2 cache using vsmmu->vmid by iterating this "vsmmus"
> list.

I was rather hoping to fix the normal S2 case as well, the nested case
is really not so different.

The challenge with that is to rework the list of invalidation
instructions stored in the smmu_domain to be more general and have
more information, how to invalidate for vsmmu is just another special
case.

> @@ -859,6 +859,10 @@ struct arm_smmu_domain {
>  		struct arm_smmu_ctx_desc	cd;
>  		struct arm_smmu_s2_cfg		s2_cfg;
>  	};
> +	struct {
> +		struct list_head list;
> +		spinlock_t lock;
> +	} vsmmus;

So this approach of just adding more lists is functional, but it isn't
very general :\

This is why it is a tough project, because carefully generalizing the
invalidation data without degrading the performance is certainly
somewhat tricky.

But what I was broadly thinking is to have an allocated array attached
to each domain with something like:

struct invalidation_op {
    struct arm_smmu_device *smmu;
    enum {ATS,S2_VMDIA_IPA,S2_VMID,S1_ASID} invalidation_op;
    union {
        u16 vmid;
        u32 asid;
    	u32 ats_id;
    };
    refcount_t users;
};

Then invalidation would just iterate over this list following each
instruction. 

When things are attached the list is mutated:
 - Normal S1/S2 attach would reuse an ASID for the same instance or
   allocate a new list entry, users keeps track of ID sharing
 - VMID attach would use the VMID of the vSMMU
 - ATS enabled would add entries for each PCI device instead of the
   seperate ATS list

To do this without locking on the invalidation side would require
using RCU to manage the list, which suggests it is probably an array
that is re-allocated each time it is changed.

That means some fancy algorithms to copy and mutate the array, deal
with error cases and sort it (ATS must follow ID, want things grouped
by instance).

There is some tricky memory barriers needed and RCU would require that
SMMU unplug do a synchronize_rcu(). IIRC riscv did this in their
driver.

But the end result is we fully disconnect the domain from the smmu
instance and all domain types can be shared across all instances if
they support the pagetable layout. The invalidation also becomes
somewhat simpler as it just sweeps the list and does what it is
told. The special ATS list, counter and locking is removed too.

Jason
