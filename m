Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011055.outbound.protection.outlook.com [52.101.57.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8D49E12A
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409913; cv=fail; b=YQiy3qC5P1vV4OLTun4uAhK5jbbjKaEQkX4EtAzrflvllel6Rt9U/rmxFnA+UYyPQorR3LCQgYyqZprxIGnfLdT3E38AYx5X9Z1W+bzIO44+UgWF2jqEjxx73gPRc4gd77Qv1XRTa4FQiVXyKAqpv01P9odR0TC7aP61Pdt8ZLk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409913; c=relaxed/simple;
	bh=bXwqVR7SVtP6dapbjymO/ILjpfd/kvc9JVjEsPTnI68=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KMHwRU9e8a21Q1kWyw/qfL7Ab6wvxwocMmCtsY5uaKfAv03xIEPBDkSOBzACHwTkyhU4Xhy1Kl+JDkkLseu+5q1ZJkgQJbTRZDbgKBNgx+mAnSA9U8pPIhz/zzRsO5kSjR0qPTO0gcdJusUsduYVoyJYrHHnLhZaVSVxUy2ooe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sXdgPOBP; arc=fail smtp.client-ip=52.101.57.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sXdgPOBP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CubJuneUhqyetW4nMg/UM1s3wPRsLg/ZqI2WpxXUd3uUvpdJ8BQ7AnhUCqU28Hr5KwMrZ9VNCSrVTu47S+PJdv4cIWhtF3JjLaVKIqe7GWAK2ZRl+32GHpyGCwWuoVC9+PyE3qVaagvWgf32PgMp3rATALlfzEXyIc9Wdh/AR5wve/rRPrMjc057ACEQfHbjJEMwLesBG+bwN9o3PBD0hE5xSDbTUmH9eq8ngiZGqdqDbmhSX5+oW063iAD8P6WRYab5hhD6fiVZF2VVE1TtazOh6LKXT7RrM+Mxo8vJMjOaiU3fPZEfKpCXeBHzCZTC5ujkAHI1020UDp/WJUT0lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dw9f+1kV0ai0puE50Vr4VGdP4kML0e6Lob5+rrsU4Ug=;
 b=xceTgNQP/hiu4jQLlxLlrz3AKpst6HM1q8LnS+9NKNXu0DijyxBhwWYdvKSjZuMaf8jo+g0P3ih2xggJ1q2FBumNf3wbliK61svjbiQOwQTba4YNBRPDgcaiN0rMfgw0yiAip74AN1RJHupC5VFGRYxC7Wabo5ZWSY0mcmNOsgMnWWGhUWd0tWuVYdy/1r6Oplc4ziIlODne+3/t6tluxY715OC4g13m3Dof/WadNPjWMzoOf2b1MgJ4mTJWy0pn/1ghzvsRi1lDsGyFzJj4Vm7QeQ3d5uQ02dNc3dsLXDKU2AMNtpyx5DKzWU3eXRb3xVDo1afmNppar6DMqcUCpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dw9f+1kV0ai0puE50Vr4VGdP4kML0e6Lob5+rrsU4Ug=;
 b=sXdgPOBPx8ychHdB6uRSXGmsxdXexCb+IGfrv3Oyh+uaJRsXCYO72f3+FA7w9wxYNyMnTvQE2Pn9YkwDMJRnKrDxra/UXEfmIWqnGRekNDGfvtnJ090WUl6NCFejOkI7tK9IUag/rksJWePICQHdMJmgf3op3yBN6P9x/MYn2G0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by MW4PR12MB6732.namprd12.prod.outlook.com (2603:10b6:303:1ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 11:38:28 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 11:38:28 +0000
Message-ID: <3bb95ee3-634c-4609-8ea0-2e6a5122ea63@amd.com>
Date: Mon, 19 Oct 2026 17:08:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 07/24] iommu/amd: Add support for AMD vIOMMU VF MMIO
 region
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org,
 wvw@google.com, wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
 guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-8-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-8-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0015.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:80::7) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|MW4PR12MB6732:EE_
X-MS-Office365-Filtering-Correlation-Id: 022087dd-5437-4df8-41b1-08df2dd57e76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|23010399003|1800799024|10067099003|18002099003|22082099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	tE+ux1qkAn7gjrhhi+qDFd6vCRiiwJSgLM3PlZX9uKBCvp6EWYhofI6zy6WWlSVnrFHyFGkymzIpXajj4xlEOGaMCVSdvpXDoZ5XtUd5zSZNUUwJFVyr79ueSn192bYT07Gwe2/BdDrMibZka10ohDqCJqtPZljMYzdnEIkBeDEk0N9k0YC+o5G3LJQieoBeAvpKjDgbCYnoyi4ekv/l/+7u8uw+LRh8lXtPyDK9p8xqYHhs39Yxr8us1qpqGqNmttVwaZLBaEkIruqJiJpdgoxEHgQ1CLWfrYMuHcFUldmYsm429sm39s/BusEXvCO1bg80kZaWLfctOsQ7m2OCS9CFQZI1/GSdd3q4hUg5gJuWsutgdi8LK6Y58mnvGI/TFJjgrYgmuf1W9JaMyKQ0nGdKDAwm/zQe1WFKIb/HKX7sXAWFmaUIr14Nnhhe/UTUe6EHxFOQCNEJ10AE3fcIwh/oEr2mgD5c7ctewSZXmwoLmoAGgBJjS2od1S8w+kt18CNgAA3PgcbSY7/9VK5yoOnQBqdToZzLaC5DsAXmplNuPYlmADkkeCw95l6OI7Cfgk5mTSURupTfUrHD87PZlsFyeaxk4rjR+DsmAvED8c1Mj2pMGkM1ZLQTyswS28gYozsazjbANHANOvexqNdFpzgC092E7AHJg3Mo+oqLzH4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFFYOFc2MWRxR2FPcUhHQVd6cE83RlJXMVRCUXhpV3JnWjhRUFR5NW9FK1hL?=
 =?utf-8?B?SUltR09TQ2xWekduZlRqdW1GL0tyb1hBUDFhWUdjTWZ4SlY0azJyWTk5alYw?=
 =?utf-8?B?V2Zqa0k1SFJ3LzlTdlk4RzEwK0pQZWdFN251MUJUTzN4NXNBWXNVM1BBaEd2?=
 =?utf-8?B?Qmo5VlFVTmNvMmluOEIrZHRCczRJU2ZJWXUwNzdSVS95dW9Od3BPQVhRRHVs?=
 =?utf-8?B?L3luekJxZENTc011ZlNSUENyck4xS1c2U3FHMVBQR2hDZDZ4Q21veDhKNjAv?=
 =?utf-8?B?a0xnTVhlcHZnWjdTdHlaNXlUR1VBVmNETWV6TjQyLzVnR2ZWdlRRZUhFdmlF?=
 =?utf-8?B?QWZQcUVZSEUrZE80cmw2eExxc2RPRllQbWU2QlVDb0RSc1hzU2t3aFdkUHlF?=
 =?utf-8?B?TUsxYk96TTRDOWVYQU1INkFpZmtnZHJlWml6V0tuZnFsWVB5RmxVN0p0MThi?=
 =?utf-8?B?QkFJck9jTHJBYVFqYmJ5OU9SanFlWGFpcnYzcjhPS3lvY0I0d1lGa1h6Rklo?=
 =?utf-8?B?d0RUcVR6cEg5dTNxM09mRXpuZUtNN3oxWVppcmxLMWUzQkFLQjA3LzV5V3VM?=
 =?utf-8?B?UTlrcUZFd0NiY3EwZjBzaXR5cUFaaU9rWldSSldUU2VEa3EwL0NTdzJYWWpr?=
 =?utf-8?B?aUtrZEVsS2hhMmw2Q3hVRy9wV0JHU3BqbjhITUlaSkhSQmw5bHlkWktpbERx?=
 =?utf-8?B?NmUxcDkrMlE5aXBNL0ZTWkI5azNVdG1yUzgzeFh1NTk1Nkx0SmRqWnVsUzNn?=
 =?utf-8?B?QmluZCtDSTNkL1dlNWNUeFc4SkdHT0VWdDdlTWdSekFQY3Noc1ZWdnY2YzhK?=
 =?utf-8?B?WVkvbnNNaHpSYVAzWWpBSnZZOThkL2NMYVBpbGxlcVl2YnZzdWNzNWdoREli?=
 =?utf-8?B?V2tWWU9RMXQ2eFcrcGVGTXExcGR0dUl2R2VsdnNMZEJoUmpUNmoxeGczOXNP?=
 =?utf-8?B?UWZRZ3hSTEltanl3VXRzTFdlL0pVb24ra1h2c2xKOUFEU2NKbElkU2JiN2Z3?=
 =?utf-8?B?Q1h0YjJva3l3VUxpeGNNQnJuYWJudlptWnhVUHlzbURzV3Z1Nm00WUxsT1p0?=
 =?utf-8?B?NXBQQ0l4NENxb3NaRTUvaGw0ZE5MVEE3YXRGVUVyYWV4SUJhbEszUERZSThj?=
 =?utf-8?B?SVQ0QVNaSnlBOHJ4TE1FR1hleUxBSHIwN3g1YnpWRlllV3Y5K2tVQk9pOGFS?=
 =?utf-8?B?eEJKUkRJMUFZRGRVWS8xcEZjQ0Qyb3BFMG1Nc0E0THdMcndSakdUWFMvdFAr?=
 =?utf-8?B?UVRpQll6S0ZxWU1sUEhnTFJ1NEJJNzB0M0xqVjJOVFBBdXo1V0NLSjA2SGds?=
 =?utf-8?B?bm9MaC9Wa2FnK3FuTTIyQXR1Q0IzRUl1QTMwYm9xZklvbitTTlNYSDFjbmpk?=
 =?utf-8?B?ZmEyNklkQ04wRDZ6M205NlQ1elFiNFU2YUJPY1JTS1JBTHBqeTVoT0d2ODdD?=
 =?utf-8?B?S0g0Y1IzOFAwTmxHVUZ4a1JHUXRwYThoT0hxRTNvM1pXUmhUTFFmTUZhMzNs?=
 =?utf-8?B?YWF3K3liNnlEVjVFT2Jwb1B3OWJhUWprOXovUkJwUnc4cExKM1VnMjREUW1r?=
 =?utf-8?B?dXFidG9hUkxDZmpNZUxoeTNBQjViSXNOMmF0K29yOTd1WEVualJVb3NYTWk0?=
 =?utf-8?B?QlVWVi9Cb3RBSU1SdS9vcWlTdWR4ZmJBbDV2UTRJVjRvNi9IUmxEazF3eG5m?=
 =?utf-8?B?cWdxcnYrUkFObUZqdEdUWTFvaURJNDF6dEhXbTNmWmROdzR5VlV4eFFmd0NQ?=
 =?utf-8?B?RVNHN01kQi9zZ1JvSWY5WlZ6YnkzYVpXeWdRamJlcXBaWW52TEJsNEQ3WFlJ?=
 =?utf-8?B?NFc2WE5WKzk3enFkUW9OR05vdzBiVUZQb1E3c1Y4ckNzbkkzMDlZM3dLNE13?=
 =?utf-8?B?QzdpL3NvTzVjN0R1QVF6SFkrNmd2RXYyNWtsVzk4NktrOFVvNFNOQXl6dEZW?=
 =?utf-8?B?SjZ0K05IZ0V6R2JlVXJMNkZSUDNzbEFHKzJMOUpjbmxZNFFWblNYS1Y1VFFL?=
 =?utf-8?B?VjZja3A0eGFROXhyYi9MR1d0Mk5ubXJhVHJjYmZIbDZKRWJLaEl1dWNpNmoz?=
 =?utf-8?B?OFNjaHV1MXJzamN5QTI0dlBpeXdPYkdFRlBZblBrUGNGMG5VSlJUU2phb2ZS?=
 =?utf-8?B?Qm9ZTjJGbHZIb0M3VUs2dWowdTVYbDM1VVFTNDh5L3ZpZWQ0SVNwd1AzVTdk?=
 =?utf-8?B?QnJldzhFYndCNHV0T2FLR3piRDh5c0NSdTNLUno1WFF2aXk1Tk9Tb2hVOUtn?=
 =?utf-8?B?THJLQjNIUU9LNUM2M0gwTFRKM25xRG5pWGdYSFBUc1NQTTA1MTR0RFBKSXZk?=
 =?utf-8?Q?B7M5jwcHGzFH12uRML?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 022087dd-5437-4df8-41b1-08df2dd57e76
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 11:38:28.3895
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eLjDlpJEiIkaElR70xvaH2ByfE3VnSe5CXgTsg0BaAUzd7CHtFa94UfkrlJR8hu/PJCWNOq3Tp4ru5QGv8tV+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6732



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> The AMD vIOMMU virtualizes guest MMIO registers at the 3rd 4K region.
> This is achieved using the iommufd_viommu_alloc_mmap().
> 
> Copy struct iommu_viommu_amd from and to userspace so the VF-MMIO
> mmap offset is validated and returned on vIOMMU alloc.
> 
> Return -EINVAL if the VF-MMIO page_base is zero so mmap is not
> registered at physical address 0.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Co-developed-by: Vasant Hegde <Vasant.Hegde@amd.com>
> Signed-off-by: Vasant Hegde <Vasant.Hegde@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---


.../...

>  /*
> diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
> index e5fbea666e01..276f2126290f 100644
> --- a/drivers/iommu/amd/amd_viommu.h
> +++ b/drivers/iommu/amd/amd_viommu.h
> @@ -14,6 +14,8 @@ int amd_viommu_init(struct amd_iommu *iommu);
>  
>  void __init amd_viommu_uninit(struct amd_iommu *iommu);
>  
> +u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid);
> +
>  #else
>  
>  /*
> @@ -30,6 +32,11 @@ static inline void amd_viommu_uninit(struct amd_iommu *iommu)
>  {
>  }
>  
> +static inline u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
> +{
> +	return 0;
> +}
> +


Do we really needs this? amd_viommu_get_vfmmio_addr() will be called from vIOMMU
code path only.

-Vasant

