Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013061.outbound.protection.outlook.com [40.107.201.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F4B1E9B37
	for <iommu@lists.linux.dev>; Mon,  1 Jun 2026 13:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319155; cv=fail; b=IQGS3g3ZMhLv1FzkToV6jEEYzYr8jMv5RBL3Wss0/GlOLYYjWZWwxOivWMS1q3VMJJXaFGrSpfMYia6wx9FpudDfCr2M8ICNPjYcHuxFmhHB3LlYZNzCu2OQ7ltxDsLF+YjNjEoiquK/WKFeaiN3QjVSMiaqsJFlYSPclQh8eSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319155; c=relaxed/simple;
	bh=ls3A1kjevu9gj/IaNvddwY40nDPJ27gWHw+WqwXzEMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=j/QRndtpZkaj4P1VBr1S+sMMk7l0/yaHeoCN5Ul1xbIxDbfHBT5w/+UzwqvG6M7Gvlh5FKZWnocDD9+HEm5N0tHj2R+iPsQ6guWxs18tokmb6E+48e8SGaf36p3CQoSUO4qKOdM+8u+hhdN4mhw91glJN0B4mKAav3ZA5Gpheis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uGUrXEt9; arc=fail smtp.client-ip=40.107.201.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uGUrXEt9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A6cdVqTZQ0Bmu6WZQIAzdupUMi/1eWmXWbhB+W3WLpMol8DBHeTsLpoxZCd0Efh03Ny38qG2S6035q+XTWZBMP39KCoWmpFZtSIEEoSSmi1MrO1LBDhA3fUegG4KznHNJ4zCNFc8y4N0224fWArWGycZRcBsF4uhF3/XXGhjdMTXXfe4+VLwEKB5Zaa2axVCz3kVJZtXPauLoWp5jv33+/gYENuJJ/H0CbL9oL1OgOE91ZvRxE0mURdONHtF4YtjMCck1yHbltn0dw2amlwzueI6mUbE1BF76mpIuD0p6z7BGoyOylo+KQGIU0UjWU9XXSOEBDQUjhoCh1wiIgzl4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VeVt4VBskNb6KGU5xFPT4xA1Z8MFBkEY0FtvjVa/BvY=;
 b=gffTca2++CEPj1AJXmjGeKaQvO+EwKllgHE1JIK1i5yqdn3MqCjMXzxT4cTXJpqBjiL41K6XXbFI/PVVAVqI60h0qd9aX7TemPESUs4bdhZEQxuDes3VqUFu7D5gqfNyhAybvdL0ldHLGKWFtA9HEiB8iW5Z8zEoTnE41y24Px2bPmFU9W0zzKXOZpDJp1T9nySy8UGSwtlZcUtjfffyKpXT3+Y+kEKK+J0qH3QslCYijxRF/kjH6J2eu6u1S5f2WO2qLwGyCZ17oLSv3qD2qb01veNsV2FvJJPNvgO8+3PqKRjqeUzwPVNbJMGOh7a3C/fXXlNsVgXiYuevrt8V+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VeVt4VBskNb6KGU5xFPT4xA1Z8MFBkEY0FtvjVa/BvY=;
 b=uGUrXEt9GYXWBfdA+wTt5onQoY3nebuhxcGgwVtFoB7vKFLasOO9++kGS9LouDOdGvO0EswRThlS7dtO2xGrbbJabOflHO8cHsokxz+S/5MGv7Yuxm6EpPB4c606y4zQ8S/L0mYc3gFYBUt65DWs7TlTZFs3oF7KZuzncjYPd7qLhK4Okmpt5tx7AAUTrTv2l+e3DbgYqpJpgrvI1lKiKqR6WAS4SY54V5F6q2DhYbgaZafQp2nkN94ubhqTDDfHN4YgkxbL2x8e+i1AYBCX6gNjz2rERUt53p9t5E4zs5sENxU8mgNJmgTC9lkx0lLf6tPNj4BAviujh/pqmCu7yw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM4PR12MB5723.namprd12.prod.outlook.com (2603:10b6:8:5e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.16; Mon, 1 Jun 2026 13:05:42 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0071.011; Mon, 1 Jun 2026
 13:05:42 +0000
Date: Mon, 1 Jun 2026 10:05:41 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v2 11/26] iommu/amd: Allocate and map vIOMMU private
 regions
Message-ID: <20260601130541.GL3195266@nvidia.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-12-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528051738.596013-12-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BN9P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::25) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM4PR12MB5723:EE_
X-MS-Office365-Filtering-Correlation-Id: b6fec932-576e-4531-7f88-08debfde7c4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	Wx41WeFzBl/pP7J3+yZuC4hlA10pY6JRbLbVlZR1UGLN4fUdHRGQO3MthyGOk44kNG0knzWYu66OorIFRAddtzDEsmYGTagiAxE5UkwqLTNZw4pJKVX/a8zjxZN6PJnX/9h2znwo1hHVM/aMiWS92HCM6K6iE98z3ceVFSZsZYVgmJoF6yCHpIxspS1brXhvcafh10K5M6sZoZizBMBrF+Vs+Fl2Yot+51i/fKYpUTMTKJ3q6jCRJIKvoaDClkYAfgJYc3ddCDN6qsnkJjv/cXsEeOSNijqPxHN4tzHoK52jgun5jsGJ1TqDhGZw52vmZPyF/txELbVhFULNrQ23cGBgWo5OUoE+tQb+qA76uh2QIkaQllAAZC4PMNuH+e8TxLp55DCmcIYI+jFcSPzpkEiswaLCkoRPeGGJP2lFLw2XhWioJF44mXkS1L5zOZZ/8qV9TSFmMgvenaC2qqVXHgQBhBHyxf6zC9Br/ae8rmZ/qKINNIUByquoQL3nhiMNmS6ayYYfyixYGoYcmqQHGAltpvMnw2waf2J3QZOJLHkNSbEJXMMlljrXKu5cW4faNH4SgirNeyUY6z7QzEF8u4zbSDIJ1tqZsGSQjCABTD9jHaDIkukUCc6MsjfNFX9rQQTKrVy4YD6PJ3snMX3Nn9TlLK0rBy1MojtDIYlWnnFaf1xuImZiVzLU4SY1jWCf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S6jdw/9rrNDSpNQhwOgi1x/4z6C0N7YHhgZmBpsapVePqIeUU+4br5DZe1fv?=
 =?us-ascii?Q?cbfb9a+mQDgnjeLEmUvSwHvqfegOT4nN2khs2Z6wUrRzwd+7FrAGRuP2j0lK?=
 =?us-ascii?Q?46dL+zVUCN7wFhFVPkFj4httsgNh9PmQ9BL84lp6XdwZd9ex7poFANWps1yn?=
 =?us-ascii?Q?XW21jvJ30c86r+5MD3xI9qq5WKU+t/lf/M7maXmfOM6O3Ltvfu4ArXpWT+ek?=
 =?us-ascii?Q?H6hOr8mNXgJXeYCdMU5G5MDqJYQrlu3sNZER8Tla2cwgAsmXAhMEG+EiO1iU?=
 =?us-ascii?Q?R94e3nSyGxlFlbbcxWY/PL1+jM+ktxkKGkaavamoB70xq0C0Bvpoff/NIhZQ?=
 =?us-ascii?Q?wDq28iQqa18cAxnR9SgE3FMhtMrVNOXRlydL/Gu6BXpyhhqR0rIEYGi1QG3M?=
 =?us-ascii?Q?8iQJgiPKKSi/c2IAdnPxrnvUxuAXj8U1J3WMtuXUgpy3Azw2Fm6GZ+2O4uGj?=
 =?us-ascii?Q?wFdmlhMQt2Yq4yTykWfEFp52BgyRYB4elFDFqK9ndne2dY4PNzmEeubGtdBp?=
 =?us-ascii?Q?MrAfDO0pM/2U2h6HoYTSdqTo3MpOpU5TXepo99ZwbRxicX72nrzsUyJKCSWF?=
 =?us-ascii?Q?WDJxr6bg5djK+RJCHP90lwnwlBOovzu7iOw3gW8Iezq7NJcZLYsMpyVUWVD0?=
 =?us-ascii?Q?zRTwXycpn/48B/2t0hG5Kn5Joo0L1Wa4R/XI+HEKOt55caP0D4UkdXnR836/?=
 =?us-ascii?Q?cZ2e4HDYkn4vM//mC8dcMtQNGuWaeSNXcGcta2k4k6d76zfsId58VMpDHUTv?=
 =?us-ascii?Q?rGET442U+Lfy6HjEQOSTzxr9DJDyVpsWOWeCEuHwlhEBUBZyGxgnUzjTXF9D?=
 =?us-ascii?Q?UUKusXRwHY5qqwjofgVbAx3jBNkHbQYdu40L13E9BQvAhSNKCgI4qmRpVCzs?=
 =?us-ascii?Q?vKdX8iy6T1CDMWK9A2CtgYn/0qTlQ1AfvETR2EUuNoGCrPo7QrIfR9Er3iOD?=
 =?us-ascii?Q?LmQrjF9oTIEmVcRo5U5tSE8xzdpddzu3Dd1/6dY4RSDubuTINKNOJRgX4IPD?=
 =?us-ascii?Q?aHN/jgWGw0Z/KNIBsCeAjp+TFqbkRuAXBkrjItkwGEplHwjxu2tZNjBl1RLY?=
 =?us-ascii?Q?8fWC/DDqWu6y/BoHeMEQOY4nJ9SEtI3Eu9oTdlzX0OzxDEFtZ3XifoB6/ck6?=
 =?us-ascii?Q?Yj2Zo+QBiRrn89hhC78R62whez7JvHPJl4NB7yVaN8DYp17hwE6KcrXByNYC?=
 =?us-ascii?Q?b9O1+FZ2oIOtRMAVhJRACj0lefFlJQvxQbsCAeR+5tiuR5gCDT6kt0DdSX39?=
 =?us-ascii?Q?V4y1U3bUpegOv1LALaIf7P3RvznSTXuhnnI5GskHZtoFMZYsvz6HgmnQSJlB?=
 =?us-ascii?Q?AlBzozs7DllFIAQltZe0E1rOHy5DRThs4oSX/zliu/4fLjtq6tTkitK84dp4?=
 =?us-ascii?Q?wuw9KL3MNRlxvtv2+0LHRZLY4j7YWXxa76+sFqd/hsrlGJ526lMre1x0DJLf?=
 =?us-ascii?Q?/DksL7mHPbRVE/EU9ZPuxF+LpKMQ+DtEH29IdgW2K73rYZjvGUqzd3kZITzZ?=
 =?us-ascii?Q?rRmhG1BLFL7NSoe0ucuDQxTszgJPINXLZhBECU54h2ek6Xd1A/bTQDF8CW7b?=
 =?us-ascii?Q?mAMny28+XOgPqf3YfNS1k1CsihCeM9PmH2iAXUqapxZGKNK5Bscrp0pUt4EQ?=
 =?us-ascii?Q?IrEutI+ZGhC6pevlclY+t8eaplSAv+kkrVsS3HDnAxuyzocng8sgaPjt/Nry?=
 =?us-ascii?Q?1wWn9IF9x6iQlOEk/40gRNoDV/KXbiDhFLxiJUy9NNtER4Rc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6fec932-576e-4531-7f88-08debfde7c4d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 13:05:42.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vh4Qe2dos1U6A7baz0yx6jL78AK39GmsdMPFhF0cIrjiM8d+eiloTxW1v8fihC2q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5723

On Thu, May 28, 2026 at 05:17:23AM +0000, Suravee Suthikulpanit wrote:

> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -131,8 +131,66 @@ static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
>  	return -ENOMEM;
>  }
>  
> +static void *alloc_private_subregion(struct amd_iommu *iommu, u64 base, size_t size)
> +{
> +	int ret;
> +	void *region;
> +	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
> +
> +	region = (void *)iommu_alloc_pages_node_sz(nid, GFP_KERNEL | __GFP_ZERO, size);
> +	if (!region)
> +		return NULL;
> +
> +	ret = set_memory_uc((unsigned long)region, size >> PAGE_SHIFT);
> +	if (ret)
> +		goto err_out;

Why?

> +	ret = iommu_map(&iommu->viommu_pdom->domain, base,
> +			iommu_virt_to_phys(region), size,
> +			IOMMU_PROT_IR | IOMMU_PROT_IW, GFP_KERNEL);
> +
> +	if (ret)
> +		goto cleanup_mem_attr;
> +
> +	pr_debug("%s: base=%#llx, size=%#lx, subregion=%#llx(%#llx)\n",
> +		 __func__, base, size, (unsigned long long)region, iommu_virt_to_phys(region));
> +
> +	amd_iommu_flush_private_vm_region(iommu, iommu->viommu_pdom, base, size);

Why? Is there suddenly negative caching for this mode?

> +	return region;
> +cleanup_mem_attr:
> +	set_memory_wb((unsigned long)region, size >> PAGE_SHIFT);
> +err_out:
> +	iommu_free_pages(region);
> +	return NULL;
> +}
> +
> +static void viommu_private_space_uninit(struct amd_iommu *iommu)
> +{
> +	int i;
> +	struct iommu_domain *dom;
> +
> +	if (!iommu->viommu_pdom)
> +		return;
> +
> +	for (i = 0; i < VIOMMU_PRIV_SUBREGION_CNT; i++) {
> +		if (!iommu->viommu_priv_region[i])
> +			continue;
> +		set_memory_wb((unsigned long)iommu->viommu_priv_region[i],
> +			      VIOMMU_PRIV_SUBREGION_SIZE >> PAGE_SHIFT);
> +		iommu_free_pages(iommu->viommu_priv_region[i]);
> +		iommu->viommu_priv_region[i] = NULL;
> +	}
> +
> +	dom = &iommu->viommu_pdom->domain;
> +	amd_iommu_domain_free(dom);
> +	iommu->viommu_pdom = NULL;
> +}

Shouldn't something flush the DID before freeing the domain?

>  static int viommu_private_space_init(struct amd_iommu *iommu)
>  {
> +	int i;
> +	u64 base;
>  	struct iommu_domain *dom;
>  	struct protection_domain *pdom;
>  	struct pt_iommu_amdv1_hw_info pt_info;
> @@ -144,22 +202,33 @@ static int viommu_private_space_init(struct amd_iommu *iommu)
>  	dom = amd_iommu_domain_alloc_paging_v1(&iommu->dev->dev, 0);
>  	if (!dom) {
>  		pr_err("%s: Failed to initialize private space\n", __func__);
> -		goto err_out;
> +		return -ENOMEM;
>  	}
>  
>  	pdom = to_pdomain(dom);
>  	iommu->viommu_pdom = pdom;
>  
> +	/*
> +	 * Each private region requires to 8MB of memory to be allocated
> +	 * and mapped. Split the region into 4 x 2MB-subregion.
> +	 */
> +	for (i = 0; i < VIOMMU_PRIV_SUBREGION_CNT; i++) {
> +		base = VIOMMU_PRIV_REGION_BASE + (i * VIOMMU_PRIV_SUBREGION_SIZE);
> +		iommu->viommu_priv_region[i] = alloc_private_subregion(iommu, base,
> +								       VIOMMU_PRIV_SUBREGION_SIZE);
> +		if (!iommu->viommu_priv_region[i]) {
> +			pr_err("%s: Failed to allocate vIOMMU private subregion %d\n", __func__, i);
> +			viommu_private_space_uninit(iommu);
> +			return -ENOMEM;
> +		}
> +	}
> +
>  	pt_iommu_amdv1_hw_info(&pdom->amdv1, &pt_info);
>  	pr_debug("%s: devid=%#x, pte_root=%#llx\n",
>  		 __func__, iommu->devid,
>  		 (unsigned long long)pt_info.host_pt_root);
>  
>  	return 0;
> -err_out:
> -	if (dom)
> -		amd_iommu_domain_free(dom);
> -	return -ENOMEM;

Why is the error handling being deleted now? You should organize your
patches to avoid churn like this.

Jason
