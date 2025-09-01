Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04892566F7
	for <iommu@lists.linux.dev>; Mon,  1 Sep 2025 07:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756710622; cv=fail; b=gh15m7VBh+B0m9jWvbwRC49OQPfyuZYQ3v9o86aFNX3m+9XfcuVad8iGhCtZiDrqUMwL5PWG/kc9f3yGtUvF3bivlXDWvv98RRwUGpCU7Wu0iXBd3iUBVhqNKysIsYZisQ6a+7yAIOby7tGoV0UevbFlvjVMDSI3tfZIa7SG5/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756710622; c=relaxed/simple;
	bh=sso9lYFjMVk+yvX13zety71tG5QfnkgTXHr/A8kIkM8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XgshCS2GX5lIob8oculDtCt0dgtBTcZ+PQgJ6BS4+QzosQD/8iz5m+KVdtxk9+jPUfuPAMpBXNAf+/IYA2iJZr9oqwu1qX9jvX6IM5EufZ3sGidbEkeRmxqL3PpOsfmsRqG+6y7J9EUYqgf5NyS/T/ky9LTTghA/IYZydWab5rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WJNP6Ddp; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WJNP6Ddp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mg98McZ5h1SwvAqTABYpTEF+YxPKPlR/oXC0mOMVMl8WCotmzXbooBvgkB6t2mM1mueiuWFm5yroDfu1IrE3JzAcaIAdzPxpH4xtTAJ9cWICOGK4KepeHGliP9ajWe1se+pwmrNtgyZyf+zvdPKTfxj9sEpZis33jd0jGGkU45Y+oKYG4o/lQ55ArwqpiMzZ0C7QD+0naC5IKOI4BVf2XZbLrvovWZd81zqMRyd/PQ49e1UQbVVAlG9UEQ9abdC0t0C32JjJsCIkW0wJ3Uw34CSMmsV/SrvzhCO1ab6Dz8uGSpXNr213odtadNGFCxthXAWVLxyjegpv3eoN6GA77Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfQitdZa8QtoiKcyhItKQi3sZjb5F6PQFXy84T5rF7E=;
 b=jDV/ZqXA9ZZpeKoS14TSjuwuZovX+3oU/tzhOvlIPeGgQ+3uWRB/sNV+QJHaVhSGKrf/PzM6P+HvT8BVZOke8u8B+FKMPgwvuBTvs7xAoUmwfE8il8cQFt01Y9eLrlbRRV0u7xjbiitzJKw8XryGtqg2dy+hhRPNsUsTdetiXck6EsHTXKBK7Oe/SpuHGuRLFypxzTNz7De0wWerP+ZTkMRlv1887DWQl/aq+jlDgJwh2P5d3SDLh8OVu11gJ/gKjYo9jsbKiPIGgbrEmFeU60czI1PSq6lQWtFe9xPnrvpKVMWuNQS/TtRINOWBPshpFcJBr5iZWw2JBABIP6Aj5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfQitdZa8QtoiKcyhItKQi3sZjb5F6PQFXy84T5rF7E=;
 b=WJNP6Ddp3laS1sLhomW0AFBDz9yVS8RbDgyJrwY+cWPWexC8uNZgIPuR4C5MVE67DssKHvAScOqIn1qOr9Kp5RsxCa3lX1szYVvseiHtq5UuDE/ObVgdwXtclXhsY1TRJ9brwBQLmoyKK+a0tzHYXkyVdwSf+zOYiHVhkponr9A=
Received: from SJ0PR05CA0163.namprd05.prod.outlook.com (2603:10b6:a03:339::18)
 by BN7PPFED9549B84.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 07:10:14 +0000
Received: from SJ1PEPF00002323.namprd03.prod.outlook.com
 (2603:10b6:a03:339:cafe::8a) by SJ0PR05CA0163.outlook.office365.com
 (2603:10b6:a03:339::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.12 via Frontend Transport; Mon,
 1 Sep 2025 07:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002323.mail.protection.outlook.com (10.167.242.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Mon, 1 Sep 2025 07:10:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 02:10:09 -0500
Received: from [172.31.35.81] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 1 Sep
 2025 00:10:03 -0700
Message-ID: <d949f151-ff90-4e83-a85c-f22ef6b477f1@amd.com>
Date: Mon, 1 Sep 2025 12:39:56 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] iommu/amd: Add support for nested domain allocation
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>,
	<nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-8-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250820113009.5233-8-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002323:EE_|BN7PPFED9549B84:EE_
X-MS-Office365-Filtering-Correlation-Id: e97bba5f-718a-48b6-d67f-08dde926990c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnowS1RXbzdVbloxOVAzMkxZd0pxV211cGoveHZISFhjNkZqYnlWdEJFQnB4?=
 =?utf-8?B?eDdQQ3JRUnE0SG9URWFqRTNVSHFqQjF4QUZvY2VJZXZxOHdMWjVMYjliRVZu?=
 =?utf-8?B?cnYwekROVHl3eEJBYVZrYU8ydWd0SUViTlhGNGY5dUxYSC8zejhWRUlJdyts?=
 =?utf-8?B?aDBmTk81WkthNDJvaVY5MHBtaHJWRHBoRnZGSGwzUWd2MkpUZ0k1anVRMHZL?=
 =?utf-8?B?OWU1cENaN3EvSzZRWElwaFJVOG8zc0d4dGorZVluc2NmVDZzNVVZbldsazlS?=
 =?utf-8?B?Q25YSjVqcE1FM1d5US8wVGdqV0wwZ3ZWUXB5Qkxad1pkTGo4bDROWCtqUlVR?=
 =?utf-8?B?cE8wUlVHVG5hV1Q1RG9tV25DMW94NXJxdzJnaEh3Y0tZWjhDVHJEMmFnLzQ2?=
 =?utf-8?B?YVRaY2ovNVN0TTVFZldCMU91M1g2OXN2UnZSa0hlN2c5M1BsaGJIcjcrMlBz?=
 =?utf-8?B?cUJtbkk2d0tVL1N2WWg0UlpuR09LbFNzV1BrNjVSbTE2Ukp0NVQ2K3h0K1pp?=
 =?utf-8?B?c3RYaHdqQ0RGOFppMnEzMnhEOUhZaVAxdSt3emRpQ1F3Zng1QkRQZVE1NHBQ?=
 =?utf-8?B?bXp3VWJkTFBqMW5HTXVPdDZtVzhUK25qM3RqNDc4NktuMklSejlGRXk4MHh2?=
 =?utf-8?B?VGQ1NE4xRTlpR29INWRhb1haYVhvSm1EdmZVMldSUDBJaTd2bDcvYzNySFA5?=
 =?utf-8?B?YUp3OEVDQlhwQWwyN0s3S0lXOUkwR1Ivc0RoRjROMUtjNVlxZS85T28rUk9l?=
 =?utf-8?B?dDRkT3VkRmlSWXdVU0pON2hjZVUxVWl4NGdvUnIyenQ1d2ZZcS8vUEl1TDAw?=
 =?utf-8?B?VFRycXY3RGs5L3lKVFJ4YXNaS0tQNDhIcmJNeVRZdElPSWFNYSsyME9oVG4y?=
 =?utf-8?B?NjR1SDVHZ0lkNW9MejZZZkNNWVIwd1UxTGNSazZlVGFtNVQwSnJUb3RTZWdu?=
 =?utf-8?B?NlhBVHEyeW1NbTBrVjFoQ3dNOTNhTHhUVTZXQmFPNWlRNU9vZG5YUFpBdFhT?=
 =?utf-8?B?Z1J5U2R5ZmFOMHJvS0pnZHpYRzRaaStFZEdHOTVjanFUQ3cycklNQVp6MExv?=
 =?utf-8?B?QXo2OFBISGFxTFJSUENMQnZ4VU9HUk5ueUQzRzBVNmxWZGZGU2Z1VlJWcmJL?=
 =?utf-8?B?VDIwVkNqeGREY2Y2bUdhZ2lyUi85UWxSNFMvL2htNjlNOWY3NXZDbkFyd0th?=
 =?utf-8?B?YSt4dzUyeEFHUGRvREJRSkdQU2FCTytURkVrSjQzV0QxTzVlTTNLQ0d2TkUx?=
 =?utf-8?B?RGVWMjVqQnZXdmlnY1BMZ0dMbkNVTFpJS2FuTWJ1SFJXU3NpZDNBV2toQWdF?=
 =?utf-8?B?YXE1cFd2OGVCUFMzcStLS0V3TktoNTlJdXdjZHhWR1gvamljWk9RME0rT0xU?=
 =?utf-8?B?cTNoRElQZXRUaFhHSUliN2lCUG16ZjVGK2wwT2hYMXQ2V1ZZNHgvNksyMVBo?=
 =?utf-8?B?bGdWdEpmQ2Irbm5sc1l1MWsvMVJ2bUV4ajBRMlVya2ZKWFFuakZwNWdFcHBH?=
 =?utf-8?B?TGwvbzZMeTBLck8zUTN0Y3JPU1Zya0srdXcxbkN2SG1scVVLODluUmxIQlBx?=
 =?utf-8?B?dnRjdXBzWEdEL1NFeGpoVExkTHdTM1JjNnNxRU02MUJwQ0VJZTkwbnV4RUJa?=
 =?utf-8?B?eXU5ZUllOTM4MjJaajgwYUFhQytibkg5TU9QcmpKelg1OEcwYm13Qkp1UjR1?=
 =?utf-8?B?dU9PdmwwYy84STNlQ3FXZm11YU4vT3NjS3Q1d3lXZ2l0WWtUdzZzOXRhSkdS?=
 =?utf-8?B?N0xyQWV1YmJLME5VREs3bUN3N2drVnN0VzBzaDdTb2c4eTB0emw0a3p3RzJG?=
 =?utf-8?B?NDU5MXFEeWVkdVpraytaZ1ZRNGpLdUg3aHVHZk9TQXN6clhrVjRHTHRMdjRB?=
 =?utf-8?B?d1E5QThaRThiN1pHcExqa2dBc0NMdlZFOWE3OEw3WnZacEZ3UkpRalYxQWhJ?=
 =?utf-8?B?NkF4TjF3bG5ScjY4clRFZEJyYjlaU3lWSjE4ckVYbjRLaVpWVHVxbEVQVEtD?=
 =?utf-8?B?UHdrelF4ODBwN1lJaWdvb1hTUVpkOENnMmlibUdVc2l1R2x4djdZS0lUbEFq?=
 =?utf-8?Q?XnzplG?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 07:10:14.1393
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97bba5f-718a-48b6-d67f-08dde926990c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002323.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFED9549B84



On 8/20/2025 5:00 PM, Suravee Suthikulpanit wrote:
> The child domain is allocated with IOMMU_DOMAIN_NESTED type to store
> stage-1 translation (i.e. GVA->GPA). This includes the GCR3 root pointer
> table along with guest (v2) page tables. The struct iommu_hwpt_amd_v2
> contains this information, and is passed from user-space as a parameter
> of the struct iommu_ops.domain_alloc_nested().
> 
> The parent domain is tracked using the struct protection_domain.parent.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/Makefile          |  2 +-
>   drivers/iommu/amd/amd_iommu.h       |  5 ++
>   drivers/iommu/amd/amd_iommu_types.h |  5 ++
>   drivers/iommu/amd/iommu.c           | 22 ++++----
>   drivers/iommu/amd/nested.c          | 79 +++++++++++++++++++++++++++++
>   5 files changed, 103 insertions(+), 10 deletions(-)
>   create mode 100644 drivers/iommu/amd/nested.c
> 
> diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
> index 59c04a67f398..9ccf9d61810c 100644
> --- a/drivers/iommu/amd/Makefile
> +++ b/drivers/iommu/amd/Makefile
> @@ -1,3 +1,3 @@
>   # SPDX-License-Identifier: GPL-2.0-only
> -obj-y += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o
> +obj-y += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o nested.o
>   obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 3ff380afb9f4..8e86d5b1d915 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -8,6 +8,7 @@
>   #define AMD_IOMMU_H
>   
>   #include <linux/iommu.h>
> +#include <uapi/linux/iommufd.h>
>   
>   #include "amd_iommu_types.h"
>   
> @@ -190,4 +191,8 @@ void amd_iommu_domain_set_pgtable(struct protection_domain *domain,
>   struct dev_table_entry *get_dev_table(struct amd_iommu *iommu);
>   struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
>   
> +/* NESTED */
> +struct iommu_domain *
> +amd_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
> +			      u32 flags, const struct iommu_user_data *user_data);
>   #endif /* AMD_IOMMU_H */
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 5343b99913e4..94f51a09b364 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -20,6 +20,8 @@
>   #include <linux/irqreturn.h>
>   #include <linux/io-pgtable.h>
>   
> +#include <uapi/linux/iommufd.h>
> +
>   /*
>    * Maximum number of IOMMUs supported
>    */
> @@ -605,6 +607,9 @@ struct protection_domain {
>   
>   	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
>   	struct list_head dev_data_list; /* List of pdom_dev_data */
> +
> +	struct protection_domain *parent; /* Nested parent domain */
> +	struct iommu_hwpt_amd_v2 guest_hwpt;
>   };
>   
>   /*
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 46682c8ba28d..ea790a8997ee 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2616,6 +2616,7 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>   				    const struct iommu_user_data *user_data)
>   
>   {
> +	struct iommu_domain *dom = ERR_PTR(-EOPNOTSUPP);
>   	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>   	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>   	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
> @@ -2626,29 +2627,31 @@ amd_iommu_domain_alloc_paging_flags(struct device *dev, u32 flags,
>   	if ((flags & ~supported_flags) || user_data || !is_nest_parent_supported(flags))
>   		return ERR_PTR(-EOPNOTSUPP);
>   
> -	pr_debug("%s: IOMMU devid=%#x, flags=%#x\n", __func__, dev_data->devid, flags);
> +	pr_debug("%s: IOMMU devid=%#x, flags=%#x, supported_flags=%#x\n", __func__, dev_data->devid, flags, supported_flags);
>   
>   	switch (flags & supported_flags) {
>   	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING:
>   	case IOMMU_HWPT_ALLOC_DIRTY_TRACKING | IOMMU_HWPT_ALLOC_NEST_PARENT:
>   	case IOMMU_HWPT_ALLOC_NEST_PARENT:
>   		/* Allocate domain with v1 page table for dirty tracking */
> -		if (!amd_iommu_hd_support(iommu))
> -			break;
> -		return do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
> +		if (amd_iommu_hd_support(iommu))
> +			dom = do_iommu_domain_alloc(dev, flags, PD_MODE_V1);
> +		break;
>   	case IOMMU_HWPT_ALLOC_PASID:
>   		/* Allocate domain with v2 page table if IOMMU supports PASID. */
> -		if (!amd_iommu_pasid_supported())
> -			break;
> -		return do_iommu_domain_alloc(dev, flags, PD_MODE_V2);
> +		if (amd_iommu_pasid_supported())
> +			dom = do_iommu_domain_alloc(dev, flags, PD_MODE_V2);
> +		break;
>   	case 0:
>   		/* If nothing specific is required use the kernel commandline default */
> -		return do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
> +		dom = do_iommu_domain_alloc(dev, 0, amd_iommu_pgtable);
> +		break;
>   	default:
>   		pr_err("%s: Unhandled flag : 0x%x\n", __func__, flags);
>   		break;
>   	}
> -	return ERR_PTR(-EOPNOTSUPP);
> +
> +	return dom;
>   }
>   
>   void amd_iommu_domain_free(struct iommu_domain *dom)
> @@ -3113,6 +3116,7 @@ const struct iommu_ops amd_iommu_ops = {
>   	.release_domain = &release_domain,
>   	.identity_domain = &identity_domain.domain,
>   	.domain_alloc_paging_flags = amd_iommu_domain_alloc_paging_flags,
> +	.domain_alloc_nested = amd_iommu_domain_alloc_nested,
>   	.domain_alloc_sva = amd_iommu_domain_alloc_sva,
>   	.probe_device = amd_iommu_probe_device,
>   	.release_device = amd_iommu_release_device,
> diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
> new file mode 100644
> index 000000000000..09f2a455af33
> --- /dev/null
> +++ b/drivers/iommu/amd/nested.c
> @@ -0,0 +1,79 @@
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
> +
> +const struct iommu_domain_ops nested_domain_ops = {
> +	.free = amd_iommu_domain_free,
> +};
> +
> +static int udata_to_iommu_hwpt_amd_v2(const struct iommu_user_data *user_data,
> +				       struct iommu_hwpt_amd_v2 *hwpt)
> +{
> +	if (!user_data)
> +		return -EINVAL;
> +
> +	if (user_data->type != IOMMU_HWPT_DATA_AMD_V2)
> +		return -EOPNOTSUPP;
> +
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

Hi Suravee,
You are assigning a unintialized pdom->iop.pgtbl.cfg.pgsize_bitmap to
pdom->domain.pgsize_bitmap. In non-nested domain attach 
pdom_setup_pgtable() takes care of initializing pgsize_bitmap.

Thanks
Sairaj

> +	memcpy(&pdom->guest_hwpt, &hwpt, sizeof(struct iommu_hwpt_amd_v2));
> +
> +	return &pdom->domain;
> +out_err:
> +	kfree(pdom);
> +	return ERR_PTR(-EINVAL);
> +}

