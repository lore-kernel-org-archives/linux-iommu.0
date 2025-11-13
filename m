Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9149D30AADA
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066202; cv=fail; b=IRyvCKzznosqIFgZnbUODbwZyFMoOU+DBZGjkntUlKExk7BRHUEevQCMIAb3pjwgKIPJvkovvg5QhIoQcVzfNLRRFRv/oBt/HoXrwPJ1ioEAJYxPfxUKbodqdArqdt2OxIXOTL/oXp4u0yKB/4B0wm/9taDpbYXQ7Gz/YE8mBNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066202; c=relaxed/simple;
	bh=WXPBuxTjCqdlxcDZIfXkH99XA50WOct9kYnT9xTEvO0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ri2cSwwzAbg2vcICdWVZY4hEL6BINQHt6FsJ8SiOzsd/1fIZklg6wx0ET491W50bhVYDy0jHp1h9WGEBzQHSumRkq0hyw0ChcWdy99Io3WXhLGhw+hyLqpcPG+U1wV6dGqdOLpAK1t68btMxW+TJy3APC44Dar93WoVnHoe9XCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jpqXAZqm; arc=fail smtp.client-ip=40.93.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jpqXAZqm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mfx8bkrbxufQo8GZLbSh9/wfzpuABp5H9B+9FBLrCjZWgBbVI/HGtrl/DuIr0cNG5N+8j07t2j7VMOem3Yh5XEOjrxF+LruvNfwG2ghpszhtSmTswrKuUJxc9eJzjg0A/5o9z5UDkpgTVJjsCLdlDAgGtyg2fX5kKVFzsl/vLcQP6oU/fAooDf3ZNNFK5eN5qKJF6StKZhth8vUy3AZrV6cRCVAN4Q8PTpckYGA6nDygu9DKCD7/RfB/7vkTMMIPbupo/1LWo9xpv0eqI9WpQ/XJqlrSYKkCtRKJe9t4tqdG+kQv+j50DOGT03El3zzvC5uMbI35UuF0/yflWM/aFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYk66kpLmRzSAuYk0qWdguW/BxyKuUBxsex0O4Re+zs=;
 b=EGNiQOcIj6h5NbxohoBadNTvMUuGfzYek7RFFi7+Cyk/j2aDdd50yER5VMzVWonQBicicRTG3nu88cgqJKB/1US/vjoUR2mSoWRnvfkoJuSe9XrxwJ7UFQrqyUnSj3o7kQ5HwHS2qGj51yBetgFglXInqz+y45XjZZYyrkNb0fAChAhdPHeHh0J20uj6V0wDdR4JYpNBEwWUsJ9D8piM9dPXv/i5s5DROf5U1Io9R/vq6O9yS/iUsF706Q7r0dfvmx21IprSF3XvxQFzOhjg7+p6Llg/jDtmlKmKhC9ju/Cyo+mTSyS+oW70zmVHvl+H7aZICMpsFtdVGMDisbUuag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYk66kpLmRzSAuYk0qWdguW/BxyKuUBxsex0O4Re+zs=;
 b=jpqXAZqm4ypQNs7gjluWGk1qVJfy/DWrgUhpMDZ7qmHMgAkcFGUe6VQdb9aT3w0lmF5a9P46CA0/zutELi3qG2VNcEW9NPgrh2hfyWjkgc8zZv6/Zp704OjEOocfc2+B2DRn5NizhKjooP4F58OYB9UnyRzXT2QJcAvZ5TRlCvhm2/uBVt1zyAJrJ63IFbW8C1Gy6K3ddP1kgz0l5KwJOAR/4sk3fGbr89rqTWTjSE1UsPs2mOE8y67iI+jkuJno9YqxQsM9AqPWoUBioNDZeMR08bt+X6fmCQLQcfoVapg2hXRFawhUih62vNoGj5xsKGZdEQ92fEMUh54u8+B5Dw==
Received: from BY3PR03CA0024.namprd03.prod.outlook.com (2603:10b6:a03:39a::29)
 by SN7PR12MB7452.namprd12.prod.outlook.com (2603:10b6:806:299::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 20:36:32 +0000
Received: from MWH0EPF000971E4.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::61) by BY3PR03CA0024.outlook.office365.com
 (2603:10b6:a03:39a::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Thu,
 13 Nov 2025 20:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E4.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 20:36:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 12:36:10 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 13 Nov
 2025 12:36:10 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 13 Nov 2025 12:36:08 -0800
Date: Thu, 13 Nov 2025 12:36:07 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v5 11/14] iommu/amd: Introduce gDomID-to-hDomID Mapping
 and handle parent domain invalidation
Message-ID: <aRZBN/nBz6lqTzmt@Asurada-Nvidia>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
 <20251112182506.7165-12-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251112182506.7165-12-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E4:EE_|SN7PR12MB7452:EE_
X-MS-Office365-Filtering-Correlation-Id: 201851a1-1f7f-4156-528b-08de22f454a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mXtMV5/UCkdOdvrMLjaFNHQZWbrXpGwXi7UgtIP3Nl/1uYh6sCTcPP7YWUgE?=
 =?us-ascii?Q?2iBtVF5wkiw+N70NewNHurdSp5jaVdI5eJ98HUV1+7yTgt8TwQi+cgBizRWj?=
 =?us-ascii?Q?m02gu1qayQtVtyGDiJ3y8jzv9tallz8KsjLTAH30KDYNBCTaStl2flnapjLd?=
 =?us-ascii?Q?lSYWNG4SSoG0ilpxRrGnLn6OXtjlbNo7KZaeJcVO3uyvAV6+Rhe1F6mW+XGB?=
 =?us-ascii?Q?pQjo8hedmvjUm/fhjAFeFY0caEjbw/4nu8TBVuOCAqKkIBKmsez1Xy9svOV5?=
 =?us-ascii?Q?PyyXTW1ZaN7d9dddzkHQGu7pj4DV2fCK1b2tKIVtR6JlgTonAM34X0ANLi0T?=
 =?us-ascii?Q?Y3HMJ39QQh14Ys9WYhRW0hSTzuB6Xz7EV/JyhG8G3BlJis545laGvDK+3Oqz?=
 =?us-ascii?Q?ccNgjqZo9L5IAwNiKB9YOOnsNIcHzsFVJEEJhbn6KxoRrIp0i2xWU69uiYbO?=
 =?us-ascii?Q?8GygGJuOVRrDTNA/hsCjJAHM3iyri6px4ByQ9+SmTya/C+rVPkc4rnCDZX34?=
 =?us-ascii?Q?ni5XwNAL2m70f2Bl2qvNEZBC5uR8Ydg78v1TOW6lQXUNeJYq+GexLRGaUCPi?=
 =?us-ascii?Q?Q0jGKCkkVdSczbjZovdJwex5lExBl4J7Jt2ph0oOfdAIuzOc+LhskQ98SzGV?=
 =?us-ascii?Q?+I4UPfQDqjZq024tcFGpa5DPebpuc2X/hLzijREMSkJ5xrEB+z77nCDp3WZl?=
 =?us-ascii?Q?RZohFJ8AkuIcuZIigdQmvW6SZ7UKMj4IGs4ZDBdYyQ55oYwAom7z8KNMttDa?=
 =?us-ascii?Q?N+DvDns07c1yzsi3mBtq/IOsvvbRiZTKgErs2KDUL2PKvAmNDGhMN0O2Y/Hc?=
 =?us-ascii?Q?6KazNwwYoYDxKITOrYISamV3Al7J/BjPzN/lgX8FZpzmGjpNfLEBN5+njCq0?=
 =?us-ascii?Q?0GAi+Ewzgfx5NbIC9DCeA/hStQyEcESI8DNyhj9Byzoowgy6gOyQ8k98TDNf?=
 =?us-ascii?Q?PJy/YlCD2gBpaOgH9O5y3ahYLXyYdcRG1xcU1g6ilPHtYYvy4JHIP7HzFav3?=
 =?us-ascii?Q?CG2rhE+wfhMsNr9AAbzlSK8YsEwGACTby2gDByYkBZrffw3ma7WQJ5AJDBRg?=
 =?us-ascii?Q?j2oC2g4ZOO9DQDGhiqAvRvRyJOR4bhFcKVxDJBmf+1XQv/RCojRJJjsgMu/j?=
 =?us-ascii?Q?c5ipbA9E/X6CAJHdQsgjtJg++9lpzHzGSdnLRw5N7cn41rTJdBcQoKlOBrvO?=
 =?us-ascii?Q?4G5eSJUcfRHW6jj+cZdS4rgDOJ9M42WYgNNdKkK2eqDWinSMwbvgh2rGQp3U?=
 =?us-ascii?Q?kSh/rREuMLIM17R3rephJ8aazMaTvmfEbK/jxYdGBKyDstJ+oq/ve1X2GzwE?=
 =?us-ascii?Q?ebXUDxxV0lb4ZDm9s3uKFhkZEa1BDeWWPbzRyiFkmp5s1clRiNq4A+qHHfdV?=
 =?us-ascii?Q?i7KPFGxNmUj8B9zcTXyuRIJke41jIX7XaY+ATEHgwlD+Nva9pTQSvlyzBqra?=
 =?us-ascii?Q?qlhVBxMSZwFfuYsW3OG5yyBybkQbtnYKmcysl1Yoc6Hrr2xt6YkHRDRP1nPJ?=
 =?us-ascii?Q?YNHTTvbgRwExmZR3/MVXI+sdi+S8AlxuiWuX5cxonTjhzBIk/pacikYhCaUt?=
 =?us-ascii?Q?fhrNmfh72UmX5RxXhdw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 20:36:31.9358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 201851a1-1f7f-4156-528b-08de22f454a7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7452

On Wed, Nov 12, 2025 at 06:25:03PM +0000, Suravee Suthikulpanit wrote:
> @@ -38,10 +40,42 @@ size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type vi
>  int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
>  			    const struct iommu_user_data *user_data)
>  {
> +	unsigned long flags;
>  	struct protection_domain *pdom = to_pdomain(parent);
>  	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
>  
> +	xa_init(&aviommu->gdomid_array);

Perhaps init with XA_FLAGS_ALLOC1 since domid can't be 0?

> +static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
> +{
> +	unsigned long flags;
> +	struct amd_iommu_viommu *entry, *next;
> +	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
> +	struct protection_domain *pdom = aviommu->parent;
> +
> +	spin_lock_irqsave(&pdom->lock, flags);
> +	list_for_each_entry_safe(entry, next, &pdom->viommu_list, pdom_list) {
> +		if (entry == aviommu)
> +			list_del(&entry->pdom_list);
> +	}

Do we really need the loop? Why not simply do list_del()?

> +	spin_unlock_irqrestore(&pdom->lock, flags);
> +
> +}

No need of the extra line at the end of the function.

> @@ -92,7 +94,60 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
>  	ndom->domain.type = IOMMU_DOMAIN_NESTED;
>  	ndom->viommu = aviommu;
>  
> +	gdom_info = kzalloc(sizeof(*gdom_info), GFP_KERNEL);
> +	if (!gdom_info)
> +		goto out_err;

Missing:
	ret = -ENOMEM;

> +
> +	/*
> +	 * Normally, when a guest has multiple pass-through devices,
> +	 * the IOMMU driver setup DTEs with the same stage-2 table and
> +	 * use the same host domain ID (hDomId). In case of nested translation,
> +	 * if the guest setup different stage-1 tables with same PASID,
> +	 * IOMMU would use the same TLB tag. This will results in TLB
> +	 * aliasing issue.
> +	 *
> +	 * The guest is assigning gDomIDs based on its own algorithm for managing
> +	 * cache tags of (DomID, PASID). Within a single viommu, the nest parent domain
> +	 * (w/ S2 table) is used by all DTEs. But we need to consistently map the gDomID
> +	 * to a single hDomID. This is done using an xarray in the vIOMMU to
> +	 * keep track of the gDomID mapping. When the S2 is changed, the INVALIDATE_IOMMU_PAGES
> +	 * command must be issued for each hDomID in the xarray.
> +	 */
> +	curr = xa_cmpxchg(&aviommu->gdomid_array,
> +			  ndom->gdom_id, NULL, gdom_info, GFP_ATOMIC);
> +	if (curr) {
> +		if (xa_err(curr)) {
> +			ret = -EINVAL;
> +			goto out_err_gdom_info;
> +		} else {
> +			/* The gDomID already exist */
> +			pr_debug("%s: Found gdom_id=%#x, hdom_id=%#x\n",
> +				 __func__, ndom->gdom_id, curr->hdom_id);
> +			refcount_inc(&curr->users);
> +			ndom->gdom_info = curr;

This looks racy..

When a gDomID is shared between two nested domains, a concurrent
nested_domain_free() could enter before refcount_inc(), and call
refcount_dec_and_test() or even free the curr and ndom.

Then, this refcount_inc() will blow up, or curr/ndom will UAF.

Actually, I don't see where amd_iommu_alloc_domain_nested() gets
used in this series.. I assume AMD will use the iommufd's vIOMMU
infrastructure directly which doesn't mutex across nested domain
allocation/free calls.

So, the entire thing here should hold xa_lock(), use xas_load()
for the existing curr and use xas_store() to store gdom_info if
!curr, and xa_unlock() after gdom_info is fully initialized.

> +			kfree(gdom_info);
> +			return &ndom->domain;
> +		}
> +	}
> +
> +	/* The gDomID does not exist. We allocate new hdom_id */
> +	gdom_info->hdom_id = amd_iommu_pdom_id_alloc();
> +	if (gdom_info->hdom_id <= 0) {
> +		xa_cmpxchg(&aviommu->gdomid_array,
> +			   ndom->gdom_id, gdom_info, NULL, GFP_ATOMIC);
> +		ret = -ENOSPC;
> +		goto out_err_gdom_info;
> +	}
> +
> +	refcount_set(&gdom_info->users, 1);

Similar risk here. gdom_info is stored to the xarray before this
line. A concurrent amd_iommu_alloc_domain_nested() could get the
stored gdom_info and blow up at refcount_inc().

Make sure the entire thing is locked and safe.

Nicolin
