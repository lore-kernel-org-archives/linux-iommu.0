Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096DF225795
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 17:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742491521; cv=fail; b=dawQ70jGipL/8BQUY+7iCXMy3q+q7GMi8aKauHbzDn5mh3PwGT/etuuohbWZ7MYjIZ0BrVmaI3957d3xDL5W4zz8cmGHm2xMNWIPe6PNYBNqusdR+k1ej95RWd2XCv4sHHcJW8ijDroPrHzP0neW0d+UpbRsAtx35vW3jojE3oE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742491521; c=relaxed/simple;
	bh=M5sMjnAQ+0gP075zOylJb6Al04cN89/9Ig7Ls4Gsvys=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C2NyFzmDPRscGsW3HQWWH8B6d0Uf/gJ+rmqjaqWtxrmu6w/hoOX980c31Y9txFsW3nOAvrbhkNMhCh1e+DjaaeOMUla9beF65PcVGX4x0+2WBIyLuzJG7Q+PDSAoNHZYZyx8F9gGCuqtWg4QfDqR6hz9vdlAofBQ5auKyZZ1t8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=t4Hq4its; arc=fail smtp.client-ip=40.107.212.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="t4Hq4its"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mt9gAYGmVfePn4bSb4vvrfY02gQl7pQhgDg83eAqvocOmSnR8+Ap/J0+lnbWHFzEMcjYdBrsOV1J/X7+gL+2sWa4lbjPLqdvVPKbG5cH9faY5XU5ULqjBqhzsR1bGvUwDDbFRWK6da8iyreUu0Ma3j2O1BznpLD0gHyxjppzKGBkoMm/L1Y1cks4a8LYVhZ7KkJ/NWMlyM5xIpLZ1p+3nFFj//ppPxg10h7oYETqJqvC/2fTNY7YxEvKGkhe65Z4/k89Av3Naju+WSNIDqazN5Tw9i2d9mEwgUPmAMfcA3LCe7kFxNduGgLX46iIBhFHfYSclSLVeCv5Ns6k7NNESw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHa/fqfdrAEopk9JrGTFgVNh5NI4ujXEcztZxUzsnxg=;
 b=NCMogdIdgQJ5dNgo36lkihLRlakpYbB1JIiKE3gaylGJucJGLWXAdabVIGXZ+gyTC0yR6EzkCDUrLPrnsTpNbuXJXWEg8fnpfQhUZ1jAcrytb9mxGvOC1zT5t8tAPlaIdGB1a90LO6fsY2KVyyZK44wFfimBLWBVm6Yw0G8znT62wMwjX2Lpw+vWV9rbtYBSNLc/c3ILZfa4ZvFTi4LzUndtTjnrnQ5UlPaWG91o4nTbh3YPG6Cw2fGi7Bcs7UqGTF11aWqoLyo1KUda26z660HDQX1BPQ9BtsSl/l93/nut/0yg3t8mFwJDmNzKRbvtJdSH83U9GyQ4H+Qwl+QUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHa/fqfdrAEopk9JrGTFgVNh5NI4ujXEcztZxUzsnxg=;
 b=t4Hq4itsYKXtSIisHt+PXYecYLgdtP7p0bMkHW30J+kpBDDyLkz6H3F7T/HLjt45Z2KUVCEdqrEx2H/Jh8yksE7PjJiK9SeDWSuChYlL3EMTbrTyiKTY5yLoGAF+TsEoNY7kRBoJMrFGwgENGvG4m8r1f/3F33GNtN9Z46M7aU/I1fhDCMszCwZS7BZB23iTjqdZ6WzBGN2X6fTUyXcy9jvFwzeFp7iuweBVGJ9plKcUropEZbkraxgYpZl0EGkFIWZfen/i74IgHwmVZ82tJrCikRNA5UddP3m3J44OLihy3Ffy7LqL5ld6o9X7qZUuCRMcwzkMnSMdhhjXtrsINg==
Received: from BN9P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::15)
 by DM4PR12MB5938.namprd12.prod.outlook.com (2603:10b6:8:69::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.34; Thu, 20 Mar 2025 17:25:13 +0000
Received: from MN1PEPF0000F0E4.namprd04.prod.outlook.com
 (2603:10b6:408:10c:cafe::2c) by BN9P222CA0010.outlook.office365.com
 (2603:10b6:408:10c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 17:25:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E4.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 17:25:12 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 10:24:59 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 10:24:58 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 10:24:58 -0700
Date: Thu, 20 Mar 2025 10:24:56 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 02/18] iommu: Introduce a replace API for device pasid
Message-ID: <Z9xPaGV8f7Nr1HGd@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-3-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-3-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E4:EE_|DM4PR12MB5938:EE_
X-MS-Office365-Filtering-Correlation-Id: 83b940e9-3ec4-4616-dbe1-08dd67d42c28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YL8i9OwGrASQrmaJ3ZWqSiMM4apz3R0yGlu1kAYaD7lDpPlEsyHnAfbO06tD?=
 =?us-ascii?Q?A7tnWzMgCHK15NMZDktwsfhIafuvLbdlX4PsYmR3W8RBggm0l6YGZwwBsuKb?=
 =?us-ascii?Q?vymc64Y9bxDGRDP0d6zYNhLOt4vp+X1Osb/m6h2XhIEEUfOgvXNb2lN3oLJL?=
 =?us-ascii?Q?HBJjn/tJLh9TDJY7ZHGGhdLN+ggSz2wlTWKuidST64ygWnS8fk5aJDBxG4XJ?=
 =?us-ascii?Q?555E+g/p/VmavsLcmi+RqslGciue1Ao40qCSewN2YEOnxW/vcNdzzX2ju47B?=
 =?us-ascii?Q?QLrYNHAeBk4cJYo2/AG0wHwQL+cAqYHMGvKDLvXfd7fgH5iS9ik/T9CC9/8D?=
 =?us-ascii?Q?+Jy2t8byubTP/82FSghFpv7GcHVHvZdDR1cTdGAk7yxVInEeIXmXUKlDixb7?=
 =?us-ascii?Q?j5AtLmXyMxTZhNybdOryIJnvjdpLAqKqatViZB2TZcMT8o/ibvxOBv5dZyV9?=
 =?us-ascii?Q?P6+U85Um8EhUws+pdObBq1TzSxBdF6PLzIeABLmniXRj9ZLIbekm00uPwg2L?=
 =?us-ascii?Q?RPnX5cF2BIZ2bM1F+wfbmZPyEe2ryc5j96ZKRzAGNd4pZZvlG8geEE6DAJ7W?=
 =?us-ascii?Q?D3ZVCpWwoZB9YeRkfdj3jyoiS23sbTUPEmms7luHu8/00q8/Xa8hag21JL2Q?=
 =?us-ascii?Q?4iz4Az+2uHsZcoLkigtqhospcVOwRHdaKL2OqNPg/QK6BIOjR9GIfTLeW9ZG?=
 =?us-ascii?Q?h/iIjcAaOBtUC/ygBZ0zLdvje7m6pL7Zc/rqgl//XP5tYZ1S/bp6qGM1GqLU?=
 =?us-ascii?Q?KSyFQo2qiVI0JYWQAi9uOzQj52OcVXgcNSTrj+UDV26SDm9gyx8nMYVN0dm4?=
 =?us-ascii?Q?Mog9FNSWTyaM9Qzd1wSf8JVajRsZsCpUnPu1v00YHNryGcMbWXoaQKbD1mn/?=
 =?us-ascii?Q?DafP0Nd2YE/aOx8KHZ5F1vZyEsuahkZ7HfiCS9T2CZqSuc/H2vND8DbmlGaj?=
 =?us-ascii?Q?uUqkCORD6ryeZqtCf26BQc6OE9rKZPgL+FIB1VjFcPN2JfCzPiH9Kq4qBrJY?=
 =?us-ascii?Q?baZn/rUHUDJ+mfR190W2OW53vhq6wp457Do5ta5N3spAkrRT3Zp3pT4kxfnt?=
 =?us-ascii?Q?QfTDSzMJgLoU2kYPe82hKKR1Z/TE6PQoGrJ5AGoQbklrbdYUTtUD6/2sVe7d?=
 =?us-ascii?Q?WypUKpvxT/QaDlzhZL5Y8GCwMI2P8RhHogzk+UZMwH60wGHn0bw9M00Y80Jh?=
 =?us-ascii?Q?GGA2GfKk3cIXPdPd1gANnJ2Nkcb3BADsO3b3a4NVfJlKZ0X9fXzHOLjOrfzj?=
 =?us-ascii?Q?cOZ8N2nmvDIrygVFy+MNw7eZL0bOAwOoCz0U1KDXxg3MrYXpUFNyGdW6zzzW?=
 =?us-ascii?Q?k73/9Jn2yjet+0huIppFgG3D1o0iuAKb+V5w8hjYYwbr1ACUZPvVqgQsbl4z?=
 =?us-ascii?Q?J8egAd6mWoD7hCXMHrZmW9ePTogOI6PtuAvnHfM0VVBjSMbfAHhEOwffIUwK?=
 =?us-ascii?Q?beAvuWn48rCdXHZkG3tcEwJiaCNnRklMM4Kvl/uowz7mjulDs9O9FK31CSWq?=
 =?us-ascii?Q?CKQdoQrskkqcDog=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 17:25:12.6362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83b940e9-3ec4-4616-dbe1-08dd67d42c28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5938

On Thu, Mar 20, 2025 at 06:47:28AM -0700, Yi Liu wrote:
> Provide a high-level API to allow replacements of one domain with another
> for specific pasid of a device. This is similar to
> iommu_replace_group_handle() and it is expected to be used only by IOMMUFD.
> 
> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>

Some nits:

> @@ -3420,6 +3436,99 @@ int iommu_attach_device_pasid(struct iommu_domain *domain,
>  }
>  EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
>  
> +/**
> + * iommu_replace_device_pasid - Replace the domain that a pasid
> + *                              is attached to

How about "... a specific pasid of the device is attached to"
aligning with the clearer narrative in commit log?

> +int iommu_replace_device_pasid(struct iommu_domain *domain,
> +			       struct device *dev, ioasid_t pasid,
> +			       struct iommu_attach_handle *handle)
> +{
> +	/* Caller must be a probed driver on dev */

What's "a probed driver on dev"? Mind rephrasing this?

Also should it be placed outside this function?

> +	struct iommu_group *group = dev->iommu_group;
> +	struct iommu_attach_handle *entry;
> +	struct iommu_domain *curr_domain;
> +	void *curr;
> +	int ret;
> +
> +	if (!group)
> +		return -ENODEV;
> +
> +	if (!domain->ops->set_dev_pasid)
> +		return -EOPNOTSUPP;
> +
> +	if (dev_iommu_ops(dev) != domain->owner ||
> +	    pasid == IOMMU_NO_PASID || !handle)
> +		return -EINVAL;
> +
> +	mutex_lock(&group->mutex);

How about guard(mutex)(&group->mutex)?

> +	entry = iommu_make_pasid_array_entry(domain, handle);
> +	curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
> +			  XA_ZERO_ENTRY, GFP_KERNEL);
> +	if (xa_is_err(curr)) {
> +		ret = xa_err(curr);
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * No domain (with or without handle) attached, hence not
> +	 * a replace case.
> +	 */
> +	if (!curr) {
> +		xa_release(&group->pasid_array, pasid);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	/*
> +	 * Reusing handle is problematic as there are paths that refers
> +	 * the handle without lock. To avoid race, reject the callers that
> +	 * attempt it.
> +	 */
> +	if (handle && curr == entry) {
> +		WARN_ON(1);
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}

We rejected !handle and !curr cases. So it should be enough with:
	if (curr == entry) {
?

> +
> +	curr_domain = pasid_array_entry_to_domain(curr);
> +	ret = 0;
> +
> +	if (curr_domain != domain) {
> +		ret = __iommu_set_group_pasid(domain, group,
> +					      pasid, curr_domain);
> +		if (ret)
> +			goto out_unlock;
> +	}

Oh, does this mean that we can just use this function to replace
a handle if domain isn't changed? Maybe add this in the kdoc?

> +
> +	if (curr != entry) {

Hmm, since we rejected "curr == entry" already, we don't need to
double check any more?

> +		/*
> +		 * The above xa_cmpxchg() reserved the memory, and the
> +		 * group->mutex is held, this cannot fail.
> +		 */
> +		WARN_ON(xa_is_err(xa_store(&group->pasid_array,
> +					   pasid, entry, GFP_KERNEL)));
> +	}
> +
> +out_unlock:
> +	mutex_unlock(&group->mutex);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, "IOMMUFD_INTERNAL");
> +
>  /*
>   * iommu_detach_device_pasid() - Detach the domain from pasid of device
>   * @domain: the iommu domain.
> -- 
> 2.34.1
> 
