Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2079.outbound.protection.outlook.com [40.107.236.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F922D5C9B
	for <iommu@lists.linux.dev>; Fri, 22 Aug 2025 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755892296; cv=fail; b=h7lllVUdrIqcn5CboCBDaOiawfeI7eXiVkUOMa4qkgmonD53UXz6ZobciNfxuisODZo1yxtN2dOfIrdoN6TYuEnPG/nS9ZsrdpuJxhnsvLs/N1bPhttPKgNKU92SbOn04l9ztGpEqteRzCgID+LBSoZX/i9+JLPFgRU4ufGjigo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755892296; c=relaxed/simple;
	bh=A4GqukvcfCxIKEncldft5pMSR4auZ0LNRBxV0VqAUO0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVkismeJYg7ASKa/BkmZ+D660Hr5JGtfa7Js3qZB4PUS/vbfG+EdemHfG65oOcyAdPe8Vs77ZENLZDJ+5mDWrH879Pu08oXJ38bnqDQpYwUCPwdHU0f3aU4rEnyHwRKPH4m78DKzJBbrvPTFjE22Ydt95Obf9R0TAs0MyYIdxJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a8bRa4Iw; arc=fail smtp.client-ip=40.107.236.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a8bRa4Iw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u/2sUg3BZDpFwMbBPSJ1KA+PRexrcqtdx3gDQ8NgJIqmmAMrSm7I6si7WBPAtJRNfjLnw9g7UNZ2R2OfYbFQXObprZyBIGLbIvOxHXxKXYKF6cabXJBm8bkv5R1Joqdu1wtB+nBmczwIWKvxEGe9Vd3nM7SOoSA58XqevogU0akVcsuRH4yDmXbFbQZt+lWJI2IfFKEhFKuHiO3K6/LCtwRmSbY7UD3clSWFgH0fUHqMrXlY3C7QkUmttwafZrcTOqUPec6EdmuwwgH66woxSUXYNhguhsWoTMGwy6hDLl6LiMqtuYLO/I22ujpNFpYFLWpiGLwReacl/Xet3xl5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFh4xTY6sK5nmuSajX4lMMqG11jvhI4OFbO8p5C1dvA=;
 b=mC8FvN1gwriMdo3I5D0nKh7ItrXvZsynbtywZujf9HPqY68TOVYo0778AWm5D0c/VMpzG3WUWv7tJwZyU1t8745dVuavBoUAhdbSNoxzEoKiqjnBAezKrnteZsoSEMDnVTpScNmozuDZpN33CDNmAg70C5FVFUAgr2UFUGmO3gx7PBDbrRWTzNeU3kgvC8Nbr59FLHmgo3ro8W7UaHpVjL9Bok1SOHu+n2mua8pj0ncSAwNlAlaS7Bob25KK3EcGwU+1/Bb4GQHTVVf2e7QJnJ4K+VSzYDjxUVZopDmUTKE8O/ncYidPHyAX9NGupfj6vIcfQuSESu/+mhaKmIpN5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFh4xTY6sK5nmuSajX4lMMqG11jvhI4OFbO8p5C1dvA=;
 b=a8bRa4Iw0gnAPcIOi8knwWbX0Oooa3qmM5hoQ8WiNTd4aAiLnl+dsgvnZqfDXq9lIG5HCRg1AFoasjddoDncR8Jyi9GrKOrgZRzWt8ub5je+dXSaisyKYd4xV/5gY9gbYAzTrLqwV6Rix/NL89VR34O0IfkDsFymfIBIQUIKnliduEhM4X0IreMfSIsNMxcY5cN4Z73r4Kh7/utI9sFpXFwxDm51d1jYJPeHI/p/x+GbXC/V/mECH2nuQnRiurqjqkZZb8CuKOqX8GEqhcXfpjlbetRDCrhIuaj0H1Azt1gMs0u3rlZz+daFubvqtqOsAOULY2n0Z/Ao3JOwx3l6pQ==
Received: from SJ0PR03CA0218.namprd03.prod.outlook.com (2603:10b6:a03:39f::13)
 by IA0PR12MB8088.namprd12.prod.outlook.com (2603:10b6:208:409::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 19:51:28 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::ff) by SJ0PR03CA0218.outlook.office365.com
 (2603:10b6:a03:39f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 19:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 19:51:27 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 22 Aug
 2025 12:51:05 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 22 Aug 2025 12:51:05 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 22 Aug 2025 12:51:04 -0700
Date: Fri, 22 Aug 2025 12:51:02 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>
Subject: Re: [PATCH 7/8] iommu/amd: Add support for nested domain allocation
Message-ID: <aKjKJhblxtnlrrPG@Asurada-Nvidia>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-8-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250820113009.5233-8-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|IA0PR12MB8088:EE_
X-MS-Office365-Filtering-Correlation-Id: cce52715-1fab-4690-88d6-08dde1b5486c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yi0/zmMQyErGm8h4gK4o4cYf0fMesJY9kEp5mNaCsAk0PkX7Nk7mwRKU6BaL?=
 =?us-ascii?Q?I9KYqUsKA9O4OXpC6Mn1JLGQOvqoopQnJWjnK0tC4pTaODyepa/lbGmeQd+O?=
 =?us-ascii?Q?GkPFuXP6DbxmUixHvurgtonvE4lUOuFs7iMEi1XB6Va6uHiak8oZG2S0CxE0?=
 =?us-ascii?Q?XPut0+D5IAVZQtTiFRfFpJgos6sRAEmpvr7At7oRx01eotugb5U1aK4AvUkA?=
 =?us-ascii?Q?0slO2PMSx17n9Ca79/zLjEOfDXldHiKhJJb+mHlfq7e5emYiM2wso28OGXb3?=
 =?us-ascii?Q?1iLIRSkP1d+c4gmmCDtowy8n2FBOUDggdKh8sacxHTH9PlDukt5hAyReiU8K?=
 =?us-ascii?Q?XyHL7jTC6q2JzedCKBBNfkj1yqsuzq/xmUB8g+ItBmBKEqgniZFSv+hxgp2y?=
 =?us-ascii?Q?PxM50hpPwUXzZ0BGcZ0TpUD/NGuj9xBftHgTg/4rj5cFM/w+QdGZMUvHvmVR?=
 =?us-ascii?Q?IPDC7lOGDnEo8nrzBuKtwVKkvdXZq87qYb9TtndR2WAkvF68ByzcMZI/yj+1?=
 =?us-ascii?Q?TI0xgtAvanNSzYDdakGsMCLoiarx0JPxbzZa5fVhE4ACAPwin94EnQKRN3R4?=
 =?us-ascii?Q?BfNfe9oZ3phNdnk5hJKzq5BvsFjLoF1LZ7L2iOtbUBj04OFT9hF57armSbeG?=
 =?us-ascii?Q?ux5EbW/RwrOF6qfMdu7erajND+PQ6Jhtfti0x+GespChJfKcbiQ92+fhISqK?=
 =?us-ascii?Q?Kxb7OdYmNNfHvG+RbkJq3RCXItF7eYKdOjZMT6Vlsc2boXD9Mtid4145Qbjh?=
 =?us-ascii?Q?I8PowFQq8r3PsjDWDrB/rZUjGeOfVKm7jEuVLl6dR/9kg+ZSE/NS7OhrxswJ?=
 =?us-ascii?Q?pKvhv2jcWefMbd0UvWi7Guo94jTMxkBYUkDZJy7PcFgU8cj2c4ZS8WZTy1sY?=
 =?us-ascii?Q?6U6wHwVsg3Rw6RV/MEYWx6zhUcCNQFSP1pBhIync8pt+zHwbeyknMxz1Pk3R?=
 =?us-ascii?Q?JCneCP4Y3GWlbEVIhnSqkpzulnxgKp4GQjzmWldnuoxWn29g54iqAn1r/jNb?=
 =?us-ascii?Q?DC/IQtHWUHb93EF6pCE+cySbxHQsYj5X5f4gRzcuifhtB8rkkNNOKFj9QPhy?=
 =?us-ascii?Q?TKVdvhx0tD52e6KdT41fQrXLGeBKkcHdpELEpAo+xqIJz4+AFdC8YM6bnDhj?=
 =?us-ascii?Q?8jQ4IrsssomM4mxgJg1BVxtleFlTcQMQYJmRu69mwM/XNxVKk3bPsbJQXcvS?=
 =?us-ascii?Q?ZCuTE+gJzxGjIo7guasTVuLuNjHbByTMlEv/dvol97RAsT+70WMXjxffY5B6?=
 =?us-ascii?Q?aX8kVPcooUsZZRq5D8oUVMMpTEu8NkrVhaQllMaIJa0dQB4+MN51SH8KBSCE?=
 =?us-ascii?Q?Tuw/q2/NI5oXNI/PNv1Q/4KMz0mtA0sewTxHS20wAqTP2cEfx0hds6YEuDam?=
 =?us-ascii?Q?ZDljlcu7BFWEIc1temjCOVK+Q+FtiuCz3vmCwu7aQWbFC0jhhXmQ8Xm0nara?=
 =?us-ascii?Q?WI/yNXmuDpMpWr9TqTLCubB1JTS6XZndtga6aDcGRtsTHRJjnUf14pmImay/?=
 =?us-ascii?Q?4hNm/aUMV4U0sABLq+UcLm/Pdjb0+ZNxLGEB?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 19:51:27.5946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce52715-1fab-4690-88d6-08dde1b5486c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8088

On Wed, Aug 20, 2025 at 11:30:08AM +0000, Suravee Suthikulpanit wrote:
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 46682c8ba28d..ea790a8997ee 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2616,6 +2616,7 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>  				    const struct iommu_user_data *user_data)
>  
>  {
> +	struct iommu_domain *dom = ERR_PTR(-EOPNOTSUPP);
>  	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>  	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>  	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> @@ -2626,29 +2627,31 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>  	if ((flags & ~supported_flags) || user_data || !is_nest_parent_supported(flags))
>  		return ERR_PTR(-EOPNOTSUPP);
>  
> -	pr_debug("%s: IOMMU devid=%#x, flags=%#x\n", __func__, dev_data->devid, flags);
> +	pr_debug("%s: IOMMU devid=%#x, flags=%#x, supported_flags=%#x\n", __func__, dev_data->devid, flags, supported_flags);
>  
>  	switch (flags & supported_flags) {
>  	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
>  	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
>  	case IOMMU_HWPT_ALLOC_NEST_PARENT:
>  		/* Allocate domain with v1 page table for dirty tracking */
> -		if (!amd_iommu_hd_support(iommu))
> -			break;
> -		return do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
> +		if (amd_iommu_hd_support(iommu))
> +			dom = do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
> +		break;
>  	case IOMMU_HWPT_ALLOC_PASID:
>  		/* Allocate domain with v2 page table if IOMMU supports PASID. */
> -		if (!amd_iommu_pasid_supported())
> -			break;
> -		return do_iommu_domain_alloc(dev, flags, PD_MODE_V2);
> +		if (amd_iommu_pasid_supported())
> +			dom = do_iommu_domain_alloc(dev, flags, PD_MODE_V2);
> +		break;
>  	case 0:
>  		/* If nothing specific is required use the kernel commandline default */
> -		return do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
> +		dom = do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
> +		break;
>  	default:
>  		pr_err("%s: Unhandled flag : 0x%x\n", __func__, flags);
>  		break;
>  	}
> -	return ERR_PTR(-EOPNOTSUPP);
> +
> +	return dom;

These seem better to be a preparatory patch.

> @@ -3113,6 +3116,7 @@ const struct iommu_ops amd_iommu_ops = {
>  	.release_domain = &release_domain,
>  	.identity_domain = &identity_domain.domain,
>  	.domain_alloc_paging_flags = amd_iommu_domain_alloc_paging_flags,
> +	.domain_alloc_nested = amd_iommu_domain_alloc_nested,
>  	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
>  	.probe_device = amd_iommu_probe_device,
>  	.release_device = amd_iommu_release_device,

This will be an HWPT-based nesting support, v.s. vIOMMU-based.

If AMD wants to enable its Command/Event Buffers, I think this
should follow the vIOMMU model instead.

> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Advanced Micro Devices, Inc.
> + */
> +
> +#define pr_fmt(fmt)     "AMD-Vi: " fmt
> +#define dev_fmt(fmt)    pr_fmt(fmt)
> +
> +#include <linux/iommu.h>
> +#include <uapi/linux/iommufd.h>
> +
> +#include "amd_iommu.h"
> +#include "amd_iommu_types.h"

It seems that you already included the uapi header in "amd_iommu.h".

> +static int udata_to_iommu_hwpt_amd_v2(const struct iommu_user_data *user_data,
> +				       struct iommu_hwpt_amd_v2 *hwpt)
> +{
> +	if (!user_data)
> +		return -EINVAL;
> +
> +	if (user_data->type != IOMMU_HWPT_DATA_AMD_V2)
> +		return -EOPNOTSUPP;
> +

iommu_copy_struct_from_user() internally checks these two already.

> +	return iommu_copy_struct_from_user(hwpt, user_data,
> +					   IOMMU_HWPT_DATA_AMD_V2,
> +					   dte);
> +}
> +
> +struct iommu_domain *
> +amd_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
> +			      u32 flags, const struct iommu_user_data *user_data)
> +{
> +	int ret;
> +	struct iommu_hwpt_amd_v2 hwpt;
> +	struct protection_domain *pdom;
> +
> +	if (parent->ops != amd_iommu_ops.default_domain_ops)
> +		return ERR_PTR(-EINVAL);
> +
> +	ret = udata_to_iommu_hwpt_amd_v2(user_data, &hwpt);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	pdom = kzalloc(sizeof(*pdom), GFP_KERNEL);
> +	if (IS_ERR(pdom))
> +		return ERR_PTR(-ENOMEM);
> +
> +	pdom->id = amd_iommu_pdom_id_alloc();
> +	if (!pdom->id)
> +		goto out_err;

This seems incorrect. amd_iommu_pdom_id_alloc() is a wrapper of the
ida_alloc_range() that would return -ENOMEM or -ENOSPC on failure.

Also, -EINVAL in out_err isn't nice to replace either of them.

So, I think this should be:

	if (pdom->id <= 0) {
		ret = pdom->id;
		goto out_err;
	}

> +
> +	pr_debug("%s: Allocating nested domain with parent domid=%#x\n",
> +		 __func__, to_pdomain(parent)->id);
> +
> +	spin_lock_init(&pdom->lock);
> +	INIT_LIST_HEAD(&pdom->dev_list);
> +	INIT_LIST_HEAD(&pdom->dev_data_list);
> +	xa_init(&pdom->iommu_array);
> +
> +	pdom->pd_mode = PD_MODE_V2;
> +	pdom->iop.pgtbl.cfg.amd.nid = NUMA_NO_NODE;
> +	pdom->parent = to_pdomain(parent);
> +	pdom->domain.ops = &nested_domain_ops;
> +	pdom->domain.type = IOMMU_DOMAIN_NESTED;
> +	pdom->domain.geometry.aperture_start = 0;
> +	pdom->domain.geometry.aperture_end = ((1ULL << PM_LEVEL_SHIFT(amd_iommu_gpt_level)) - 1);
> +	pdom->domain.geometry.force_aperture = true;
> +	pdom->domain.pgsize_bitmap = pdom->iop.pgtbl.cfg.pgsize_bitmap;
> +	memcpy(&pdom->guest_hwpt, &hwpt, sizeof(struct iommu_hwpt_amd_v2));

How about just hold a "struct dev_table_entry guest_dte" in the
pdom, instead of holding a uAPI structure?

Nicolin
