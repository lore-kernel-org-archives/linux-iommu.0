Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C133275AE4
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759429791; cv=fail; b=BUKsbnpJysSWoUXZBIOJPEOJZ4iQ3aM5NOcaThJWR+WicxZKIN8/yOgbqeKOIdU1y5DgLej4oQNXnEEjFL8Ez2iuz0++WG/0OQzi4fJp5WmItI9VU82wlVCt2SJh+0/DE3I4nPhbjmIisOC6WJA0zJFGDS2csucaWAXSmDeNIAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759429791; c=relaxed/simple;
	bh=t04yyqZk2Iq4aXEkjGAJ47/GiqqHUPeOgG5f1knMLn8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gq5GGJbzCrApLyzawrlWtpRY4LBSQcOp8zSv0oNXLx9XfGqGLsftSsFdbQZYw0KmtQDAtKj2bhsio//aUlbtYclzgIYcXqAl38+ZQgMmtQgNtUiL4eIipiGCJu3TkCn/VCDr35dahkTdarCuoGcjPGr0biolH8j5p9fwthzm8Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mCucMDmv; arc=fail smtp.client-ip=40.107.209.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mCucMDmv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M0+5BrT8ylW3ET545DFEJkrd619IuKsiwmPfOD2sZ9NxxmMod4vM+2okJw56VlvR+tvIEpYCJ9sfhLdcEgeX78J9Km+5X+gCioYUs15uZKwhV0P61J7g9ZZ/HssaOlEtLLd8YwGty3KTkFi+tZRBrU7VY3tHQgBb7JO/WjluOkU8r5VSAktF/iD+00vY2ns3+wEAZlcPpVHbXken5j2+p7eOmprED8eJiTCJok34ssXVmvWf3XkN9B0REX7ZkOdXEFmWfa131PLJtP6TO7RSc11PQn5jt/7AkPOtoFJVEKiSphunkRibtERgpjf++E2/X29YHOLKivgH+TjJ6D5ngA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJyOnfFCVr9aZPsikL9viQzUXZLCy5dFZHH50bJG/Xw=;
 b=Qaqh6G3YxvbCsM0vkoPFTNCMC6768EzWr9Se/DLsEd5c9szubzcjXv8mrvvME7bOK07Q8TsTNQqS3QkooaaDHfLA60dxOM2e5qxcq0SN2TkGRvayDxdygXxUG/I70H1tKjbUpN3w5nyyVY/TLACFQag9tfIsAkqhlQ1kHtmqCz79kKcOs3eC91wx7Evv+nzgGDdI6abLVurWctU8iR5Ks8m5mPMC+h+h5xV3QnK3TDKTYFjswxUocNQzcJ5Emty/k8cxxvJVJZWCW0Xcv+zYXX89uupxfs1inwc9uwMdRXODQJzDrtSTpLqrwn5cB3OA7/OyocnBgCzwCiynD4rRMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJyOnfFCVr9aZPsikL9viQzUXZLCy5dFZHH50bJG/Xw=;
 b=mCucMDmvD1Jvo/IZ3ZB29MnWSH58SSVHiNetPL0XP9HOCivxSyuM58ofWOIEWzkE2pthyoOQpnRNI0omhT7NkkDTD9AwIMsTYtP+VLh0HBpCK8F+T2TYgJK5EcLb5UVPkCMMEOP8fdRbMpg6413MJnlglESb19/NFW6a6JM2UtSFQLwOSGEpWtwf457lttN2GLBU9KKcHIbq8c8AaSMXvq7aglJD8ABSaOkDK5SjFTV07LuDCxChFggI9qcg08UN9QMQ0OZpYZT1uG8Gv8M4kNH2cyCkO6IhI3o1I+2GnoBBxNWibtLWUfN5eFYfazUxWV3Hne2n4RBcX7gcmFKE8Q==
Received: from SN7P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:124::29)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Thu, 2 Oct
 2025 18:29:45 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:806:124:cafe::ad) by SN7P222CA0015.outlook.office365.com
 (2603:10b6:806:124::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Thu,
 2 Oct 2025 18:29:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 18:29:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 2 Oct
 2025 11:29:33 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 2 Oct
 2025 11:29:32 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Oct 2025 11:29:31 -0700
Date: Thu, 2 Oct 2025 11:29:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v2 10/12] iommu/amd: Add support for nested domain
 allocation
Message-ID: <aN7Eie0PtZnp3jVl@Asurada-Nvidia>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-11-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-11-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7f41b6-ddb0-42e0-26a7-08de01e1a933
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|82310400026|376014|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iNLD4nnWAudrIkVI3FSDP+ufVgIRCo1fzgbKQHOrEc6tfyhN6cVJfRZrR2/6?=
 =?us-ascii?Q?vzWlc/N8uoeRbtUHOuvvHoo0qCws/vLGVLYJsHWD8fCGYQAwnkpm4p65VV17?=
 =?us-ascii?Q?LOIeUj4oZFy/ZDBBRgpHETAz5grHzJQgy+Qwn4QbGHHJn56oUpAYsG6pKe2e?=
 =?us-ascii?Q?f3oWowixfa7xfO5KZz6iZNb//E80SQLJcZP7z4Prvj7gJMX8Sz2CgrTomd4d?=
 =?us-ascii?Q?+6K00sjRLuve6k+y0RjD1LvOdfMsQMIWLhmGJlb7Vf8QaZpjU2q7vTbzq+v5?=
 =?us-ascii?Q?V0E2KtZtJIBsfLMOjuPXKQ1K8lO7rESjNVZtkhQ2NzJvI+Oa5p0b4BKKU+4o?=
 =?us-ascii?Q?m1JfotaMY/09QgPl9fo2ptOFz4LtgK1EKgn5g5bH9LlWlrKtO7LsTFzmA9aR?=
 =?us-ascii?Q?rTX31iJIc1mkdbhHdGz1ozkiLTGVfS3LAxW2AyVnpSu1F5Qg1t10viBMfAd/?=
 =?us-ascii?Q?bHIT9gMnC35aUotyZOhyYih1tiBvqCEXY9UMz+AeUwyIPDBmeGxngwHpa2VI?=
 =?us-ascii?Q?/z2cYTQiPQqfu/KdI+p4xxjm65O/dmcYkhpeNehQhO5m4L6Qgq0vd4EFmqEC?=
 =?us-ascii?Q?hD+Yio3aIvRZ3siD8c0xW/jcTY2NZcoCl1R2s8VjNzPU3ASvdX4tBnD/8KQh?=
 =?us-ascii?Q?GT0Njr5Pgrt748L2tPjzRwQk9m+60Ft9IjG4RVG2AKMWifECmvOXdw6G0uk/?=
 =?us-ascii?Q?T6Wi0mQQpT/FCKMh0xGX+wsEPfH3+OZBueiPuMGfu1pPM+FSqq6fLnsm/RSt?=
 =?us-ascii?Q?Z69/grue95nmsvDWnHq0p2oJkY4U6x7w+1kPD8DukXW38unxiFF1Zpsxdqic?=
 =?us-ascii?Q?4WsAjMEKfxqOX0WKUxJHgeFMpZLqoinflSi9nBHZU8/FZwOCL9IfH11F9eCW?=
 =?us-ascii?Q?PV9VDJi4VMXCPs437YsV6HDv7Mivdg+huVB4IeiyShab+9bTO/TmMHlperBR?=
 =?us-ascii?Q?x6z4UVOZbjEMqK4STvNKiYJQyERVALhq+xp7CIiAyqehnpMOtTqB5XA7zoB9?=
 =?us-ascii?Q?XnXeaMoQtlWjipLDcyyU09P5itFI6qbr2LmGPTTgCjj8UJ1JFokc4dNZNxSD?=
 =?us-ascii?Q?SRAJ3ssti2gvC6rw5KkTFPyWCjxHWz1yXgfTB732g0loWl55dYO8RNVGaOF2?=
 =?us-ascii?Q?msAYGdSm8iH9R5iytlgLDdM3Va2NatEQKOCZaxcBL0P/dscEeDXjkkZYrNZ/?=
 =?us-ascii?Q?jWR5wHAtyqpIhtxY+S8FnQbwJgtNmAuM/U6MrylVjDF0+LwNizKx/D7l/Cri?=
 =?us-ascii?Q?xFXvf3UvWuM28c5JoLnglvOrJnrPIxYedPYpAhEsiQxTZvHHQL6y7YtEsE+o?=
 =?us-ascii?Q?XuQFpfNiFvjh8bt2KamhWPxqQwIYo7olAsosCIMIvWWI+K+QWNOt9doMmC+T?=
 =?us-ascii?Q?751cOWRrBn4eNaSifpwwrDs5sDKSvl/ZnftZqKLlPtWt4mvDqzlQyw+TZbsf?=
 =?us-ascii?Q?NLS83aU7vlySwt8fkupGDI2q94E746sTRwWXVKklWOMxFvYreEFR0POxc3Jy?=
 =?us-ascii?Q?rfS02oWmcaD5NpRNDJSXzuOFvY7GpUWC9W0F1anbfq/2+Rjg/GTBQhr3vfqv?=
 =?us-ascii?Q?/SzSs+lBFXJAQPLUmMY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(82310400026)(376014)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 18:29:45.0037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7f41b6-ddb0-42e0-26a7-08de01e1a933
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658

On Wed, Oct 01, 2025 at 06:09:52AM +0000, Suravee Suthikulpanit wrote:
> The nested domain is allocated with IOMMU_DOMAIN_NESTED type to store
> stage-1 translation (i.e. GVA->GPA). This includes the GCR3 root pointer
> table along with guest page tables. The struct iommu_hwpt_amd_guest
> contains this information, and is passed from user-space as a parameter
> of the struct iommu_ops.domain_alloc_nested().
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index d533bb8851ea..cc1f14899dfe 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -8,6 +8,7 @@
>  #define AMD_IOMMU_H
>  
>  #include <linux/iommu.h>
> +#include <uapi/linux/iommufd.h>
>  
>  #include "amd_iommu_types.h"

amd_iommu_types.h is adding the uAPI header in this patch too. So,
this new "include" here is redundant.

> +++ b/drivers/iommu/amd/nested.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2025 Advanced Micro Devices, Inc.
> + */
> +
> +#define pr_fmt(fmt)     "AMD-Vi: " fmt
> +#define dev_fmt(fmt)    pr_fmt(fmt)

#define pr_fmt(fmt)     "AMD-Vi: " fmt
#define dev_fmt		pr_fmt

> +
> +#include <linux/iommu.h>
> +
> +#include "amd_iommu.h"
> +#include "amd_iommu_types.h"

amd_iommu.h covers both linux/iommu.h and amd_iommu_types.h.

> +struct iommu_domain *
> +amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
> +			      const struct iommu_user_data *user_data)
> +{
> +	int ret;
> +	struct iommu_hwpt_amd_guest gdte;
> +	struct nested_domain *ndom;
> +
> +	if (user_data->type != IOMMU_HWPT_DATA_AMD_GUEST)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	/*
> +	 * Need to make sure size of struct iommu_hwpt_amd_guest and
> +	 * struct dev_table_entry are the same since it will be copied
> +	 * from one to the other later on.
> +	 */
> +	if (WARN_ON(sizeof(struct dev_table_entry) != sizeof(gdte)))
> +		return ERR_PTR(-EINVAL);

	static_assert(sizeof(struct dev_table_entry) == sizeof(gdte));

> +
> +	ret = iommu_copy_struct_from_user(&gdte, user_data,
> +					  IOMMU_HWPT_DATA_AMD_GUEST,
> +					  dte);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	ndom = kzalloc(sizeof(*ndom), GFP_KERNEL);
> +	if (IS_ERR(ndom))
> +		return ERR_PTR(-ENOMEM);

	if (!ndom)
		return ERR_PTR(-ENOMEM);

> +
> +	ndom->domain.ops = &nested_domain_ops;
> +	ndom->domain.type = IOMMU_DOMAIN_NESTED;
> +	memcpy(&ndom->guest_dte, &gdte, sizeof(struct dev_table_entry));
> +
> +	/* Due to possible aliasing issue use per-device nested domain ID */
> +	ndom->id = amd_iommu_pdom_id_alloc();
> +	if (ndom->id <= 0) {
> +		ret = ndom->id;
> +		goto out_err;

if ndom->id = 0, ret = 0, meaning this function does not fail..

Given that ida_alloc_range has the range [1, MAX_DOMAIN_ID - 1],
0 should never be returned. So just check if (ndom->id < 0) will
be enough.

Or you could override the "ret" entirely like other places do:

	if (ndom->id <= 0) {
		ret = -ENOSPC;
		goto out_err;
	}

With all these fixed,

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
