Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D12225D4
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715518639; cv=fail; b=K/gJVboqKgbmgyBhRaOGe00cGmYDxQOun7cWH/iw5h9AhD/LoJFhDHq2z2qLRcEiUUWj+UYrkuHaUz+P/7Jc8EZ7h7eKEbVPSDi5seU1au84Rr0gI5teoZHnu1mZ89UwDStIA68Hz6tnYdaafh2dJcQTVK6FjHnE6VKahFQ2A8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715518639; c=relaxed/simple;
	bh=GeVUJan9jajV+aRD/EL8Iolq00NGZqF5pKXu/OYOEf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HBzRkhwoDcixYDJQbThuCs2KY9vuQBEL+5riDmIdmllq+skU7iwxiF4VuQvxsBXH0ulpGgNnQD1eW3Nz9tu6x1NnQfomYtbS72nr1nadOxgzNVKMbXYJ1YCr4ZwiIhsefc03i3S3VMR5PxedfM5XiTc4jh295mMo8u6x2w2aMXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nyDqs7lH; arc=fail smtp.client-ip=40.107.236.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nyDqs7lH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j/YJ4DShtovfD8bCc3J1/EAG1SqWXq7M3XThLMR0+GjR6293UMm8TzhfD3bW1KJPbjKKqgY0ZvYctSq0J13m8d/PRHy0UYFv0Iop9cXQ/zbWzh5zz2Xf9tXtECDgSLSlaVPpCTIrqTh0uI/9wuajga1vhMIU82R3zQKSm5SqypTT4v8kKnLVM1+YswI7ika+8XmwdMJyg65HbvsAaCxo8Ki+mQlZSHVdWRAy0swvn9P822FkZUlYI9+jkCXlpk06UYww8AQE+ngdRa1K7BCrzqBB7L5Uh9ICPHLhyEMF8b1dQNZhvxrimbFBCxN6o87WfcPI15Jr2hJFEEZcMDH0JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ArmhbtPshUixBbkWICiHaibofQ+TDXNAyPU55Ny8hs=;
 b=KosW32ae40AwQfSU5CsIZW1QVtjMIJKL/PM6ArP0ycHCFw658wyr/D7g+U3hkDkNaiqsa14mykH6wWTs4+9Etyjg6BxNDowMLmhwsaxew1uS5fJrPrKEjUZJlb3A/l94cPnJkhkAdgJnZuuCQZXDGhHrVpXzLB6Gw3w+BnScWHKz7UnXvGAj2uL4t7H+tZHx9rS7eZ4pYdHSkUSN85J9f52zhGO5+X2vwGwObNFNmkFzjI2eqYyexp9BEHd531uf6eiYPVjasTlcVMMONZY9Lo5wFv5Mk16feCndi4BbgbYJtn1MJLXnDVt3ubyT+UbFJKVRnPH0+76En/dAgxgL9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ArmhbtPshUixBbkWICiHaibofQ+TDXNAyPU55Ny8hs=;
 b=nyDqs7lHvG1zbnlRbINMAHTtmMNrspGwDMc6YFd0w99UpmFKXSj0vjQ2NzIMU3M2kBtAh9ByrLj4QKXwTe1r/be1w8e0sCJHWL5DAveuutAsx0lp6G9nl9LjxflDtmTA1fepUdrhNgLTQjckeKacMoFKLoU9BI7wBLCNNxD5+LBE7bocBfN+lH9SF1/AadCcr5rnhGALg44J0y8EVXVr2yclbXt6+n2o7Ke1GmxTojRvhcxQmCKDIjysMWdWLiIYIzDA9OU5ExfVvRlC+G1d+jBxBvgHikAWkoTHFz/yeH4AuNr1d4TeicIfsLfKyAp4mguo7TPPWsGvYSyiTjnFqw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 12:57:14 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 12:57:14 +0000
Date: Sun, 12 May 2024 09:57:06 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	ryan.roberts@arm.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, eric.auger@redhat.com,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v3 3/4] iommu/arm-smmu-v3: Add support for dirty tracking
 in domain alloc
Message-ID: <ZkC8oiSZsS5WbsKd@nvidia.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430134308.1604-4-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0107.namprd05.prod.outlook.com
 (2603:10b6:a03:334::22) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a6cd7ac-cafc-4a62-350a-08dc72830be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hqBu+Ba1TBiHH4EYc/Dy16c3W18creF22D08D9ZwQsEDr6ZtQWC8PDcTa7br?=
 =?us-ascii?Q?UMcvayQOBMe0JBh7/BUhYOEWqjiyz7Tk7wqzPMhUuonWy4n6Klkoq+uC0t87?=
 =?us-ascii?Q?kJBduF+UE9WCLbTtfBoWTE+MXrNlGsUdzb0J+3wvz18VsR/1WFECvOvAEamU?=
 =?us-ascii?Q?MEVotU+ctGQAIo/ZpV0r2x8WCkMuaazl560F6eZ3oOoo7yQrgTiAcJY3sjJu?=
 =?us-ascii?Q?k9bNV5mOALnKTpdwu+G0EllqDyuYkOikffeJczpOLEviQbIF8cvLOIvK4SUC?=
 =?us-ascii?Q?0sZbXGdbn6C2EedgFKUxyKgrVEo/k66iU5zpATp6co1Ok+6DvOhlcXpmljuz?=
 =?us-ascii?Q?3uLnTjb/v+TC7GYhxWmDBev9sT15YHFR1XK1bUWntAazlWjFxM0PQ9G/OdLB?=
 =?us-ascii?Q?QzBeKcoIIM7flJGElPxDjKbKz7fHa0fAARgsaFphN/pGdz5Ycz7qNF7iOKtK?=
 =?us-ascii?Q?LcbvauOQuXcc1+7q3IDNepAvCKCxoXfXEoqaKvOEOCH+sy85tJUNGjMOKRBT?=
 =?us-ascii?Q?vSmKY6ZEGxPQjCMu9CO7b0RRYW1MqAbCMs0DIPJJNIFQ6C2s5b34TgtPf6mj?=
 =?us-ascii?Q?/N2A943H0JMBJNmjNXjlGTKqn0/dFRJSUh5oRhevYh3tYchAm0WyP/6SZclC?=
 =?us-ascii?Q?F3EB6JpuU219cUdQXP4np8NL9Uh+Z5mAgCcXIIF2uqjyLcg8gSuetvHEK70p?=
 =?us-ascii?Q?eJd+WTtpIz0ytN+vbg8q33LJY3Jyi+nWKUEULSB8SHCtbg5jTkbkNTZk/6bW?=
 =?us-ascii?Q?M2V7hCsIWH2TT9sn2ccUewg4/xjezTLiWwpsLE9yIxMCUEQ1wR6zKQuGPuNl?=
 =?us-ascii?Q?zl8usPXwLgIG/bGgvXSQ3DiTScNBupv9p8lOykDmnejHNKQ+j5LOsNK+NPZ4?=
 =?us-ascii?Q?13a86amvPdEtSKKD/KNzgu+NgNXognqPOWnuokkTwm/L284YesuuSvEh+6SV?=
 =?us-ascii?Q?DjuxKigs+K+Phc+22egPASU7gcKeDQyvHZ+UmSbkB0YUgr9WwRDe5YHvHeLT?=
 =?us-ascii?Q?A7QkqIh3PSgBsv9EF3yf48X9YaAELvb4ejqlLFUMVmIzvw+0aRlK0FqSou6K?=
 =?us-ascii?Q?bRT4ZxIJZknrd0aVgvLdJwsu/Xub2130OKiN90t0oaAD4P/yaRFH4JfPOSuA?=
 =?us-ascii?Q?DjtlgNbkVSDYofSZBwsV+jq5eePtbJJH9PcRibDeRvwkC0KvJ58jDwY+UKus?=
 =?us-ascii?Q?eb2m0tjX4v+tgq6c/sXfc20QG6dDaD9iK0xWkVRRR2FrbgulvUNEftYuKzLA?=
 =?us-ascii?Q?5m9wUsj6GwnrN19wrmp6uTKawvrLE4Ljb81dWYG1SA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I84Zv7Giw4FU8NwoxYJqMoYFsSvWGEi6/g3+2ah6qVG+HYwDt91qjxlmdp8P?=
 =?us-ascii?Q?GwEZ7HcZnEHDq4lu+TCpNs/WPn08KShpk3tRVpmGQB5F0Z6U/oLhB5cWp961?=
 =?us-ascii?Q?MKl7b8w9ggllbLjhZLuDnWI/X0HZMdua6Tdnymzl+FD8qQjXiohGrp4BZlpJ?=
 =?us-ascii?Q?n2/CD2MIJ3QFyjQHr7RsKEqokvvN+TIIVJvg0Esq5G4Kax+6Rh8ivJe4tQ9U?=
 =?us-ascii?Q?VLBQAZctbmpXiwVhgldqMdXgYcAH68aHZJ4aC/Gd7bFTpUmgq6O8mOW3rqSn?=
 =?us-ascii?Q?8xoimldmLki1GSw24LK6qSGoNtcmg9RJerW3cyLsOIAbuoOMlXlp//lt0a0C?=
 =?us-ascii?Q?1QEliDGaMmbKyAT8HzsafO/ROkpryaDPf3wGeuD3OWHEbTpcy/rwxHXTiThJ?=
 =?us-ascii?Q?rm0OK6F9b9EWTg6LDpOY8B5gzu3ilSSslo6wyaKZELwJsjILxWfokhtq9cge?=
 =?us-ascii?Q?M/QW1w5Eg8RpOoIwAZZ6ads4HyowvmwsBgx0/uzZn9HZvpCuI1CABeALX8CZ?=
 =?us-ascii?Q?UDEJoWoENJ7nRFc8vTE40zgrB/CjLMlPJ//rktEfn/i8nb1luU+KrSXc1ju+?=
 =?us-ascii?Q?I+SYVvfpTSAztJpRK2Hwk4o8KKET6PH/1FuO1/oOUxrxgRULj1AqJp/ozFDZ?=
 =?us-ascii?Q?0k4KgIdfYAziUU1zBaB3Zlws0QUO663QKzqskuPpGCO+pM4Fu9skuvH9ZPjg?=
 =?us-ascii?Q?5NjCj9DJxhOVirksyoQx0dDMD9tc9PpbhLCc9vzCovKygVaLEs5CGzvhG/aI?=
 =?us-ascii?Q?tuW+ZlU5z/wFOIUP4z8xdmdtwaxIEQWwOHpHYILpQGD7buQ+qpW3AYh7n2PI?=
 =?us-ascii?Q?5k6nR0HwbuHG45ULLSlsr78w29xa6u6j/w6DYd1pwlxFuHiLi8ZgAYXxPLzd?=
 =?us-ascii?Q?mz8InBfsTLA8zy/o+l0zKqUMLqdf4qtUlxSZMq/JWSOTuP7scQHuy0lQrv4+?=
 =?us-ascii?Q?jlYPeD02sIeJIvYRM+WvUjITUMLmTjedqT+2bJiSSuCSjTYvGqYRHu48cp8C?=
 =?us-ascii?Q?GlRFMLiywLhifRE1k1GhDuq1nxBS9lODr3SXFIPP04a7h0Q+kIaYU2axOUtp?=
 =?us-ascii?Q?gr8p6DytoSE+0MADkeOMdBGKsaFSoxodRz8/6L/li4AOYVikwwnvmq3U3mdM?=
 =?us-ascii?Q?d0olNY9Q8OEJtn43w+sAzr5XhRXGEQp4bvWx5RTCORTLJXXZLibOZKKEmAr1?=
 =?us-ascii?Q?/7sujVf4do8JCHwjoeQF2c8AhMQJ6o6G41zyHoiLo9wf2+ItowP9mtcPyKIE?=
 =?us-ascii?Q?aw9vtYT5vNCNKMmGWFmBfBGDucDwjD3mMW4fLv+OaJNN59jw2Xw3t2BgyLkL?=
 =?us-ascii?Q?yyHADJFSf1MWWi/UrSDvVnoRgskFY1VIxe7SNZvyGPFRqeLuz3Q1/mON7ffM?=
 =?us-ascii?Q?/JG0pVYICA6cM+oX6QgpYxlNs1VVFKWsLxwMQ7yHq9miJh8HccJ4Q9rswcDu?=
 =?us-ascii?Q?E+u5bncrqZplHG9BWhkmtZ2AslP4Sdxgmtxf43x7hA+UcpkFqJJyqscCI7vY?=
 =?us-ascii?Q?jE1R7wws8x4UBu9yrJxpslvnANC0cen523Tf/lFCbHQpQpFv1X19T4hxmt0W?=
 =?us-ascii?Q?gyBAYSQyBdHYlZnvzV9qaWDPFVyitH0cWOsIidD7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a6cd7ac-cafc-4a62-350a-08dc72830be9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 12:57:14.6944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BdmMGvteA/AXvdvF8NUnJK2scD1oe72Yj18iiJXV3VEDbNnklN7SX4XkrFCx15Z1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140

On Tue, Apr 30, 2024 at 02:43:07PM +0100, Shameer Kolothum wrote:
> @@ -2408,13 +2410,14 @@ static void arm_smmu_domain_free_paging(struct iommu_domain *domain)
>  }
>  
>  static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
> -				    struct arm_smmu_device *smmu)
> +				    struct arm_smmu_device *smmu,
> +				    u32 flags)
>  {
>  	int ret;
> -	unsigned long ias, oas;
>  	enum io_pgtable_fmt fmt;
>  	struct io_pgtable_cfg pgtbl_cfg;
>  	struct io_pgtable_ops *pgtbl_ops;
> +	bool enable_dirty = flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING;
>  
>  	/* Restrict the stage to what we can actually support */
>  	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S1))
> @@ -2422,31 +2425,32 @@ static int arm_smmu_domain_finalise(struct arm_smmu_domain *smmu_domain,
>  	if (!(smmu->features & ARM_SMMU_FEAT_TRANS_S2))
>  		smmu_domain->stage = ARM_SMMU_DOMAIN_S1;
>  
> +	pgtbl_cfg = (struct io_pgtable_cfg) {
> +		.pgsize_bitmap	= smmu->pgsize_bitmap,
> +		.coherent_walk	= smmu->features & ARM_SMMU_FEAT_COHERENCY,
> +		.tlb		= &arm_smmu_flush_ops,
> +		.iommu_dev	= smmu->dev,
> +	};
> +
>  	switch (smmu_domain->stage) {
>  	case ARM_SMMU_DOMAIN_S1:
> -		ias = (smmu->features & ARM_SMMU_FEAT_VAX) ? 52 : 48;
> -		ias = min_t(unsigned long, ias, VA_BITS);
> -		oas = smmu->ias;
> +		unsigned long ias = (smmu->features &
> +				     ARM_SMMU_FEAT_VAX) ? 52 : 48;

It is a good idea to wrap this in a {} scope starting at the case when
declaring varaibles

> @@ -3188,6 +3194,10 @@ arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
>  	if (user_data)
>  		return ERR_PTR(-EINVAL);
>  
> +	if ((flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) &&
> +	    !device_iommu_capable(dev, IOMMU_CAP_DIRTY_TRACKING))
> +		return ERR_PTR(-EOPNOTSUPP);

Let's put this device_iommu_capable hunk in the iommufd core code
instead of in drivers

> +
>  	smmu_domain = arm_smmu_domain_alloc();
>  	if (!smmu_domain)
>  		return ERR_PTR(-ENOMEM);

This needs the alloc_user function... Can you cherry pick it from my
series? Just remove all the nesting parts. I'd like to see this be
self-contained on top of v6.10-rc1. I think it is in good shape, lets
see it go early enough in that cycle

The arm_smmu_domain_alloc() will need to be picked as well.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
