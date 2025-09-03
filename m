Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2049.outbound.protection.outlook.com [40.107.212.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7C82EA46B
	for <iommu@lists.linux.dev>; Wed,  3 Sep 2025 08:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756888080; cv=fail; b=cVSIg24DKHWnKu5gvDk1Nql0Vr2df3VzbuafcLEx9bp/sRriEXu78e773hx0e6lih1f3RI1nnfACQ8cTInE67FmMbAorpbxxdYqlOY07XzwD1nTsKkfUJ9RyOleGBJI/lMNK3iJoNb01lRS1BPaF0KgtkC4AwMTVAwUdnIapyao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756888080; c=relaxed/simple;
	bh=mU9/POE8jW1KR4qW2AQv2zEtShfegdWmd4DLc0nPOwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XzDi4boH+KIgWNASphrQStNLUvMvShpx+UEvpcsj9V0iDUoFBZtx8Oz9r+kB7F3BmY9ioi146C3tZvWXon18/Oef3gQQUMvwwYy+OJrFvZci5/cvU6n9a+OXHuDGmACwbyYPAlO5cz2a0YKOXVYjfE871Wwjv9gx6rmZmIrzE9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VHPfOe6F; arc=fail smtp.client-ip=40.107.212.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VHPfOe6F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ChO4JIEJgclBA2WST+EiiK8qidoa3g1kKFw9vOmZp1xi225ttntWCe1bYIubnf5jVyNkltLr1TUTvn0G/byntTWWI4vQzV0h5Em42PR45IGlvYTeQKHvjNTOdfCVb140aZJzkSAcYXlOX/FKVVVlbDZHyhArKBTPZFMcvUsBBry17YSXTbbPbxIbBxabXpt06l9oIGDOtpDl6LAZSELJjtGXoSV1m4Vive9s8d757tW0msN7n0TVfHjM78H0vEXC3yXSglAQtrEHeu0GcnZaM1mXyTQJ7EDaDeHaOkf35+0cvSt0hLpUBdMDJWmXtVHW6s7a8BkexZJYFFdcy2i7sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xR5mQNsaTN8K7oXgh5MLh8GQtai7p93+PQsYfmeRVuU=;
 b=MGX5ai8vH/foEHw6aR9DG5V6Xodvmh0QufJ5wsbhGUE7BQVH8O+NdDk2Gnu16NeYaa9R+kJV7ERoM1zAhGWp5ChRfQX5HWCXqdt4DYTO0dLPqhig1AJBSR+qtMQ8pIzOeQst9VgnQoCecPXFYwYVqMSzrQYtaxLkH6I2f5qWzMMpdFq4xVzRcWTGGFkocPNeiF3JBxziGgiFqqW7Q9XnMU0krMnldR3G2IgTAulS8BeXFYsY81F6aqHvq9YyIli+/Rpkw+WI+rJY3KLfEPBAhcV09AG+PGAbd9umeuFCB6mTyXRtUV3By8zUarGSOi9pt5nCEMnBctXF6lEF1s354A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xR5mQNsaTN8K7oXgh5MLh8GQtai7p93+PQsYfmeRVuU=;
 b=VHPfOe6FKKtPcTPfrfcojtx1orMmgEgpHPmeaTE5qg4noGt99Ctxyx4NB45m9pmGPGc1y9RWTJgO/Ri2u5DIiYGJ8tPbGi6pR7t8O4mn3wmvEadErmB4o0JryGxB84Sd29reYtSj7F4EsTjysV2bC/icnZLPo/GNsl5WncqckdE=
Received: from CY5PR18CA0026.namprd18.prod.outlook.com (2603:10b6:930:5::35)
 by MW6PR12MB8868.namprd12.prod.outlook.com (2603:10b6:303:242::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 08:27:54 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:5:cafe::21) by CY5PR18CA0026.outlook.office365.com
 (2603:10b6:930:5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.17 via Frontend Transport; Wed,
 3 Sep 2025 08:27:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Wed, 3 Sep 2025 08:27:53 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Sep
 2025 03:27:53 -0500
Received: from [172.31.177.92] (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Wed, 3 Sep
 2025 01:27:48 -0700
Message-ID: <5fc2a32e-2603-4565-89f8-a2904fc52513@amd.com>
Date: Wed, 3 Sep 2025 13:57:40 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] iommu/amd: Add support for nested domain
 attach/detach
Content-Language: en-US
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>,
	<nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-9-suravee.suthikulpanit@amd.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <20250820113009.5233-9-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|MW6PR12MB8868:EE_
X-MS-Office365-Filtering-Correlation-Id: 64cdb9f7-317e-4e94-458b-08ddeac3c74c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVRxZ0NZNEJzWkZQdG5OaTFYZko1SlRPVDBqTDJXYThnbU9KT3Y5eW95ZVh3?=
 =?utf-8?B?QzNnbUJiZHlxZEdtMWlWQ1ZHZ1dMMUg5SElXRFRUbFkrWE92VVRyRzJTMlY3?=
 =?utf-8?B?SmsrNk5ZSi9lUUNYM2FFS2hObXBIOFl2djlSZkNUbEw1ZjJ4SDlCMkpVUjVF?=
 =?utf-8?B?WWV3SWF4cHdReTR0MTRLOEp3eVpEOXRuMThMSzMxaDZPblVRR0E1Ym1IWHUr?=
 =?utf-8?B?dVlDbWFZQmdKWndkVHNXc0FMWHFLeHhTb3RiUVEyeEs2cEVHOHF3aDVZbXY1?=
 =?utf-8?B?Rml3VFZUV2h3YmJWTElURmFZYUxNdm1FWHdzaG05SlFJdkVvczc4ZWVydzJN?=
 =?utf-8?B?M3dDZjByWldseEpDNU1rRzNUMXUzTnZ1TTFSdVNLRnhOT0J6UWQyYUpCcXZX?=
 =?utf-8?B?ODhaWlpQT1VQNjlCVDhtWHpsTUNRK2JtRHMxMitkUGRSK2o2djFjNUhhSXc0?=
 =?utf-8?B?K3M4UVZySVYvdGVheG9SVmg2QmQvUWk2NmFSVnVqeGpmeVcwM1dvMlhKOTE3?=
 =?utf-8?B?QTA4M0ltcytoV1pZcFN0UTFTOXVYbU5kbVdhZDBkc3ZRQythZ1lJb1o5Y2Zx?=
 =?utf-8?B?cnp1bUxTSC8zVWNXZWZyYVdBcEtEbGt6OUxialJiSXhSc2UrQ0lWSTZBZUFX?=
 =?utf-8?B?Z0hqWnNrRHUxUndSa09ub21uUTd5Q1l2OTByZmlIZ3NwVUZzbnJ3SjlDdnNp?=
 =?utf-8?B?ODhPTVJjbFJYZFJtY0cvQnRqeU1FK0UwOTAzWGY4V1FVTTdrZkg4U0xwSHNZ?=
 =?utf-8?B?MXAyWVZ3Z1hDRnlwWnRhcFl4Rm8xMWdWTFYyRVdIaGd0dk9MZ29XQktwTThs?=
 =?utf-8?B?SllCYmIxeG53U2hhR3ZSREpEQjMwS2lHWFlyQkpuRVZpbjlpVm9YK1FoajR0?=
 =?utf-8?B?bG1LNC9UYmJPNHJ1a1JYRVFLWXNYRGl4SXZqcnNPaUNCdWMyQWlnSXUwYVM4?=
 =?utf-8?B?K2tWOUprVGJpb3Q1T2gvL2ZwRjZUYVpzSEVVc3pZRFBxWE1kV1pkYjNKNnhK?=
 =?utf-8?B?ZnZCVlI3K2lRcW9TZ2Z0S2x2YkdjR3lvWXVPNDJmaW1kekZRZnVIZmUxSisr?=
 =?utf-8?B?VDFyZEhvZG1tMFcxQ290RkpzY2JkZ2JoWUM4Qm5rbERBeEtrdGpsOTJPbkxQ?=
 =?utf-8?B?Qlp1ZFlKdTBWd0VFOHppQXVwQTZObUwzNWV4aWlkbXJMWHN3d3pxNDMwQWsx?=
 =?utf-8?B?b1BoVXVJR3R6Y0ZqazdtZUYvZkxiWS9EUWtnMzVMQStMRlRuQmw0eGxDK3pL?=
 =?utf-8?B?TGoyTGtmaWE0Z3ZRbkZIOUxPTk1uWXNZRDY2cmJYT3NiTThYRFpVT3JTYWQy?=
 =?utf-8?B?bmZyYmFZNHVHellONkU5TmplV01ZV1pZT2dMT1lLL1RsNWM3VC9meStLZDF3?=
 =?utf-8?B?T1dCcWUrSDd1UTRHNmtVNk9JTkd3ZjNQNmF1aGdWYmJZY3BpUUU5aWExTy91?=
 =?utf-8?B?S2o5eXdHWWhsb3RxWFZ4NldnbUtjMVhoZTErbFl0by80aVV2VlBNeDdHdWlL?=
 =?utf-8?B?VkNUY0dzZEZlRGtRaStILzY1TmVlK3lsUlkzdjVqYjA4cGtsOUl0WWdremJh?=
 =?utf-8?B?SThVYmVIdUFybW9meGxhczRwamxaU1dBNDBNQWptVFhrbmlDaHB6VXNReWtD?=
 =?utf-8?B?bVVqdUFFLzVWS05aMnJCVEVPcWdqRG1UZ25ablNOcGwzMmZVWTFXMHRWai9H?=
 =?utf-8?B?ajhUZWl4RUFVODJUb0dRNVhsWUVHYnZsMVhYWU5rUGx1aFVEamQ4QW9MKzlt?=
 =?utf-8?B?K0ROYWFQYk1ZQW9Gdnp4UVEwNzVVSUhUbDFjemxadE9IWEt1dmxzSXdFMUZu?=
 =?utf-8?B?c2tBVkg1RmErcG9pUTlGcVpNWFhXdTBQODBJTDZyTWR5WERYWm5qaHh6eVZm?=
 =?utf-8?B?NGpHbWcrWWszeWJ5ZXRraTRqQUJyQ0FNd1d6RG5La0F2MHdjRGsvZUYvZUsr?=
 =?utf-8?B?TjR2N1A4YkZEenBjUWhiVW5vTXFmNTBLQmNITkluUkx4N0w1bHlFVFg0Qnhx?=
 =?utf-8?B?TlM0ejd2VUZiQ2o3R2k2b3hqdmhEVkdyd2ZRQlZRVWJ5c3l1bTZzT2JwMFp1?=
 =?utf-8?Q?1TAFy6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 08:27:53.8790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64cdb9f7-317e-4e94-458b-08ddeac3c74c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8868



On 8/20/2025 5:00 PM, Suravee Suthikulpanit wrote:
> Programs guest translation settings in the host DTE when attaches the
> nested domain to a device.
>
> Also, enable the GCR3TRPMode feature when supported.
>
> Note that nested translation is only supported with the GCR3TRP mode.
> When it is enabled, the AMD IOMMU driver programs the GCR3 Table Root
> Pointer field of the device table entry with the GPA provided by the guest.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>   drivers/iommu/amd/amd_iommu_types.h |  5 ++
>   drivers/iommu/amd/init.c            |  3 ++
>   drivers/iommu/amd/iommu.c           | 49 +++++++++++++++---
>   drivers/iommu/amd/nested.c          | 80 +++++++++++++++++++++++++++--
>   4 files changed, 127 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 94f51a09b364..f8c392aadeb1 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -191,6 +191,7 @@
>   #define CONTROL_EPH_EN		45
>   #define CONTROL_XT_EN		50
>   #define CONTROL_INTCAPXT_EN	51
> +#define CONTROL_GCR3TRPMODE	58
>   #define CONTROL_IRTCACHEDIS	59
>   #define CONTROL_SNPAVIC_EN	61
>   
> @@ -420,6 +421,8 @@
>   #define DTE_FLAG_V	BIT_ULL(0)
>   #define DTE_FLAG_TV	BIT_ULL(1)
>   #define DTE_FLAG_HAD	(3ULL << 7)
> +#define DTE_FLAG_PPR	BIT_ULL(52)
> +#define DTE_FLAG_GLX	BIT_ULL(53)
>   #define DTE_FLAG_GIOV	BIT_ULL(54)
>   #define DTE_FLAG_GV	BIT_ULL(55)
>   #define DTE_GLX		GENMASK_ULL(57, 56)
> @@ -555,6 +558,7 @@ struct amd_irte_ops;
>   
>   struct gcr3_tbl_info {
>   	u64	*gcr3_tbl;	/* Guest CR3 table */
> +	u64	trp_gpa;	/* Guest CR3 TRP GPA for nested domain */
>   	int	glx;		/* Number of levels for GCR3 table */
>   	u32	pasid_cnt;	/* Track attached PASIDs */
>   	u16	domid;		/* Per device domain ID */
> @@ -610,6 +614,7 @@ struct protection_domain {
>   
>   	struct protection_domain *parent; /* Nested parent domain */
>   	struct iommu_hwpt_amd_v2 guest_hwpt;
> +	u16 guest_paging_mode;	/* Guest paging mode */
>   };
>   
>   /*
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 8de689b2c5ed..b340afd6901f 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -971,6 +971,9 @@ static void iommu_enable_gt(struct amd_iommu *iommu)
>   		return;
>   
>   	iommu_feature_enable(iommu, CONTROL_GT_EN);
> +
> +	if (check_feature2(FEATURE_GCR3TRPMODE))
> +		iommu_feature_enable(iommu, CONTROL_GCR3TRPMODE);
>   }
>   
>   /* sets a specific bit in the device table entry. */
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index ea790a8997ee..935eaffb6814 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -1856,6 +1856,18 @@ static void free_gcr3_tbl_level2(u64 *tbl)
>   	}
>   }
>   
> +static inline bool amd_iommu_domain_is_nested(struct protection_domain *pdom)
> +{
> +	return (pdom && (pdom->domain.type == IOMMU_DOMAIN_NESTED));
> +}
> +
> +static inline bool has_gcr3_table(struct gcr3_tbl_info *gcr3_info)
> +{
> +	if (!gcr3_info || (!gcr3_info->gcr3_tbl && !gcr3_info->trp_gpa))
> +		return false;
> +	return true;
> +}
> +
>   static void free_gcr3_table(struct gcr3_tbl_info *gcr3_info)
>   {
>   	if (gcr3_info->glx == 2)
> @@ -1901,7 +1913,7 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
>   	if (levels > amd_iommu_max_glx_val)
>   		return -EINVAL;
>   
> -	if (gcr3_info->gcr3_tbl)
> +	if (has_gcr3_table(gcr3_info))
>   		return -EBUSY;
>   
>   	/* Allocate per device domain ID */
> @@ -2023,17 +2035,31 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
>   			       struct dev_table_entry *target)
>   {
>   	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
> +	struct protection_domain *pdom = dev_data->domain;
>   	u64 gcr3;
>   
> -	if (!gcr3_info->gcr3_tbl)
> +	if (!has_gcr3_table(gcr3_info))
>   		return;
>   
> -	pr_debug("%s: devid=%#x, glx=%#x, giov=%#x, gcr3_tbl=%#llx\n",
> +	/* We need to check host capability before setting the mode.  */
> +	if ((pdom->guest_paging_mode == PAGE_MODE_5_LEVEL) &&
> +	    (amd_iommu_gpt_level < PAGE_MODE_5_LEVEL)) {
> +		pr_err("Cannot support Guest paging mode=%#x (dom_id=%#x).\n",
> +		       pdom->guest_paging_mode, pdom->id);
> +		return;
> +	}
> +
> +	pr_debug("%s: devid=%#x, glx=%#x, giov=%#x, gcr3_tbl=%#llx, trp_gpa=%#llx, type=%#x\n",
>   		 __func__, dev_data->devid, gcr3_info->glx, gcr3_info->giov,
> -		 (unsigned long long)gcr3_info->gcr3_tbl);
> +		 (unsigned long long)gcr3_info->gcr3_tbl, gcr3_info->trp_gpa,
> +		 pdom->domain.type);
>   
>   	gcr3 = iommu_virt_to_phys(gcr3_info->gcr3_tbl);
>   
> +	/* For nested domain, use GCR3 GPA provided */
> +	if (gcr3_info->trp_gpa)
> +		gcr3 = gcr3_info->trp_gpa;
> +
>   	target->data[0] |= DTE_FLAG_GV |
>   			   FIELD_PREP(DTE_GLX, gcr3_info->glx) |
>   			   FIELD_PREP(DTE_GCR3_14_12, gcr3 >> 12);
> @@ -2044,7 +2070,7 @@ static void set_dte_gcr3_table(struct amd_iommu *iommu,
>   			   FIELD_PREP(DTE_GCR3_51_31, gcr3 >> 31);
>   
>   	/* Guest page table can only support 4 and 5 levels  */
> -	if (amd_iommu_gpt_level == PAGE_MODE_5_LEVEL)
> +	if (pdom->guest_paging_mode == PAGE_MODE_5_LEVEL)
>   		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_5_LEVEL);
>   	else
>   		target->data[2] |= FIELD_PREP(DTE_GPT_LEVEL_MASK, GUEST_PGTABLE_4_LEVEL);
> @@ -2061,7 +2087,14 @@ static void set_dte_entry(struct amd_iommu *iommu,
>   	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
>   	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
>   
> -	if (gcr3_info && gcr3_info->gcr3_tbl)
> +	/*
> +	 * For nested domain, use parent domain to setup v1 table
> +	 * information and domain id.
> +	 */
> +	if (amd_iommu_domain_is_nested(domain))
> +		domain = domain->parent;
> +
> +	if (has_gcr3_table(gcr3_info))
>   		domid = dev_data->gcr3_info.domid;
>   	else
>   		domid = domain->id;
> @@ -2293,7 +2326,8 @@ int __amd_iommu_attach_device(struct device *dev, struct protection_domain *doma
>   		goto out;
>   
>   	/* Setup GCR3 table */
> -	if (pdom_is_sva_capable(domain)) {
> +	if (!amd_iommu_domain_is_nested(domain) && pdom_is_sva_capable(domain)) {
> +		pr_warn("%s: Allocating guest page table\n", __func__);
>   		ret = init_gcr3_table(dev_data, domain);
>   		if (ret) {
>   			pdom_detach_iommu(iommu, domain);
> @@ -2519,6 +2553,7 @@ static int pdom_setup_pgtable(struct protection_domain *domain,
>   		fmt = AMD_IOMMU_V1;
>   		break;
>   	case PD_MODE_V2:
> +		domain->guest_paging_mode = amd_iommu_gpt_level;
>   		fmt = AMD_IOMMU_V2;
>   		break;
>   	case PD_MODE_NONE:
> diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
> index 09f2a455af33..c9bf44e6298d 100644
> --- a/drivers/iommu/amd/nested.c
> +++ b/drivers/iommu/amd/nested.c
> @@ -12,9 +12,7 @@
>   #include "amd_iommu.h"
>   #include "amd_iommu_types.h"
>   
> -const struct iommu_domain_ops nested_domain_ops = {
> -	.free = amd_iommu_domain_free,
> -};
> +const struct iommu_domain_ops nested_domain_ops;
>   
>   static int udata_to_iommu_hwpt_amd_v2(const struct iommu_user_data *user_data,
>   				       struct iommu_hwpt_amd_v2 *hwpt)
> @@ -77,3 +75,79 @@ amd_iommu_domain_alloc_nested(struct device *dev, struct iommu_domain *parent,
>   	kfree(pdom);
>   	return ERR_PTR(-EINVAL);
>   }
> +
> +static inline u64 hwpt_to_gcr3_trp(u64 *dte)
> +{
> +	u64 gcr3;
> +
> +	gcr3  = (FIELD_GET(DTE_GCR3_14_12, dte[0]) << 12);
> +	gcr3 |= (FIELD_GET(DTE_GCR3_30_15, dte[1]) << 15);
> +	gcr3 |= (FIELD_GET(DTE_GCR3_51_31, dte[1]) << 31);
> +	return gcr3;
> +}
> +
> +static int nested_gcr3_update(struct protection_domain *pdom, struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct iommu_hwpt_amd_v2 *hwpt = &pdom->guest_hwpt;
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +
> +	if (!pdev || !hwpt)
> +		return -EINVAL;
> +
> +	/* Note: Currently only support GCR3TRPMode with nested translation */
> +	if (!check_feature2(FEATURE_GCR3TRPMODE))
> +		return -EOPNOTSUPP;
> +
> +	if (FIELD_GET(DTE_GPT_LEVEL_MASK, hwpt->dte[2]) == GUEST_PGTABLE_5_LEVEL)
> +		pdom->guest_paging_mode = PAGE_MODE_5_LEVEL;
> +	else
> +		pdom->guest_paging_mode = PAGE_MODE_4_LEVEL;
> +
> +	dev_data->ppr = FIELD_GET(DTE_FLAG_PPR, hwpt->dte[0]);
> +	dev_data->gcr3_info.glx = FIELD_GET(DTE_FLAG_GLX, hwpt->dte[0]);
> +	dev_data->gcr3_info.giov = FIELD_GET(DTE_FLAG_GIOV, hwpt->dte[0]);
> +	dev_data->gcr3_info.trp_gpa = hwpt_to_gcr3_trp(hwpt->dte);
> +	/* Due to possible aliasing issue use nested domain ID */
> +	dev_data->gcr3_info.domid = pdom->id;
> +	pr_debug("%s: devid=%#x, domid=%#x, trp_gpa=%#llx, glx=%#x\n", __func__,
> +		 pci_dev_id(pdev),
> +		 dev_data->gcr3_info.domid,
> +		 dev_data->gcr3_info.trp_gpa,
> +		 dev_data->gcr3_info.glx);
> +
> +	return 0;
> +}
> +
> +static int amd_iommu_nested_attach_device(struct iommu_domain *dom, struct device *dev)
> +{
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct protection_domain *pdom = to_pdomain(dom);
> +	struct pci_dev *pdev;
> +	int ret;
> +
> +	if (dev_data->domain == pdom)
> +		return 0;
> +
> +	ret = nested_gcr3_update(pdom, dev);
> +	if (ret)
> +		return ret;
> +
> +	if (dev_data->domain)
> +		amd_iommu_detach_device(dev);
> +
> +	ret = __amd_iommu_attach_device(dev, pdom);
> +	if (ret)
> +		return ret;
> +
> +	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
> +	if (pdev)
> +		amd_iommu_pdev_enable_cap_ats(pdev);
> +
Hi Suravee,
You dont need to enable ATS capability here. The function
__amd_iommu_attach_device() takes care of it.

> +	return ret;
> +}
> +
> +const struct iommu_domain_ops nested_domain_ops = {
> +	.attach_dev = amd_iommu_nested_attach_device,
> +	.free = amd_iommu_domain_free,
> +};

