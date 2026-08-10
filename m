Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012047.outbound.protection.outlook.com [40.93.195.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19FB3B6C09
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786356021; cv=fail; b=RpN72zvRNzpZRDuoc/RuEQanVTxFgL41eYGNAwA6tulNp+ktDO3a5MaQ7KW/psizY4zYSmDyEAsKl56Qb8DCqyZ98HxwwJKGZrqOLP0fuPlHt61kCg7yxULvUClRS0CQ75qSabr+wTWfhU4kjzja6N/vogv8Z1y38n95uaP2b3g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786356021; c=relaxed/simple;
	bh=ckXFVpd07dyqP6hCO0JVMsh0WwEiUfkRe6vKm1uPAqs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rdE8V6C147cux/PXBhUlKKM5zF0EsaSdpGJqFcma+h1bHnmkqOQAeTfLhiuLZ9zHNE+qNNdF3x/k5n8rFFskIMOokO884o0ONzxyWEFZOMAd+YUY2SvWwOfRpEc/ogXMTrNh14WL6JKzHO7o0p6sHb7uWwVC+W/+aLupXt36wHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kW96wRnq; arc=fail smtp.client-ip=40.93.195.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kW96wRnq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eW9rL6UHTbLrqBTowAAsJJd9SsGZaX0LRlJS69M1iQ/6ISO4NIDmgRK6ZNjXPk5f3nNBRMIc9Q2IYufmemY3X2OkuGRypwn8yrpeVcaPBSPUx/Dbkh0Mhe1Y+0WEscJQEUWz6X7mI7EjPC4Nj3kExpP/6dUD8C+W3VYX566mk+EcTYI7zpzQPHh/BTXBK4+aZaR7TvIDxJeUYpeXa2KwjtAZGlkNQqfqQbcMAT9Y6lzKCOrLyAUUzmouVt8j9fyzVNe85Tx5c9Nxo+eNDtLvXu/2cxOgopwSmYU6nrEZI2+tNa19HL1yhXE/90zNpDbFooj1sP5YCuwTjZ9RGuMB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HePwJ7w1kyjFc3ZrMk6ltvXOXs/AsSQwkA0D7LaMPOw=;
 b=y9/PnExlNZJEAfOKNLMQTBh6WnMN8kwoYDkOuhj4DL6zyvuLCBPNJo3VzNHkPI1krBHXJY+FDvkBNkWATgHuN0Gpctnb1DoUSSW5BuqTzT2bhPMtXkjWLjDbqVYSmQ9z1LDhrWSr74F9E4XFJmzZwTFqIfclgFH0akjb5h59DSVPhlMzyT1MoECSNmNGO4qAPLGEMZ7RcoiKlcWlXGDe9sbQe732gV5Lp9zK5mV8xDQzb8AIourHZCdOKtzcH8vlyX1i3KvL5wvJBX0spuRDslxyfvNS9SyRZFyj4sDIxuoYn3/ZhSXcnIsREr3BHzAFzW2tPO6D4657uSPl5QNaqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HePwJ7w1kyjFc3ZrMk6ltvXOXs/AsSQwkA0D7LaMPOw=;
 b=kW96wRnqpWSENFoLG+eOZktDKcs1gQfEu7buzfr85vhqO1RhX3+Xw6ncbtESO7CDo5jHZ28LfInLJcHSUo2oHUmcVOwN+/Cn5RCDD+oYjFxkJfOcJtJLGU6MAuuF957TqpUTOV5ZM6NM8o56rOyPwVHIl0nIMmzlYOIlr9vWz2E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:00:15 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0292.018; Mon, 10 Aug 2026
 10:00:15 +0000
Message-ID: <4a7d6c45-0fa9-43f9-b2f5-414449ce0dfd@amd.com>
Date: Mon, 10 Aug 2026 15:30:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/24] iommu/amd: Map vIOMMU VF and VF Control MMIO BARs
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-7-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260727132913.22475-7-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN5P287CA0008.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:262::15) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: b151d344-8b33-40ec-2fdd-08def6c62d12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|4143699003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	6xR6kAJnfujvrsf1Y46G/iY7DLYaCyn73GvQz7UCR5mBTufnFIAgLcfK+hjPtzvmxz040DGi8vcll8Fe0zQybKjbqEwwggrkRxXdX/8LLEFf391Ap5Y3NFFhTVaK5esTAG+vqWKq0eUfDx92sLwi2WaugDq+SVf8ssSCoIcDyIoitrEYzGIOiW11d79xVkPl0S/hHgv3Cs/mtKTcfA19xWMk0XPxLT+iOmtSh6fUIFHa7DIpoXMeTusAcp94C071LsjLJ/dY/EPbeyyufEq0aK0Ume6o4COUyaEDULLvw/kRhiW1Fjs1gj9Yb+sv1VSTsKda5z2Wn4KoGSz0y7+rBBWWwf+39Nda2xjrFWsSGi0BZ08Y3boG8A+sBvUdmqWWSPdoAl3C5UZC4XO/AFNfDcWhOdsS+SQIfSMM6kPoBl6NjVcehyAeOqEUpMZ3b/tzYUhZGLJW4QDdpwbkqBSHprXANTFxgDp/uprQro6uucM3AXjnoAGaiHO05IbSssSrkb27cwxX5fjdYb2Ou1SYTBwixgr6Y9HWShnCpXWCV4mXcCwMUbIeqYqwy46s9HxcyivXXdheAjNBLS79szRjKngHF6ENpd3oEKFnBqA1pEoXbYuXcRGIkyHwFzGcyefYcSbHnDsjSm+kX6zc3jEhBUlO1jDTP5m0S9DBU/b/ihY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?c2NVM053UUlIM3o1WGNhdUpuR0F6UWFkRm1XQkpublEreXhoU3NweEZvTW1v?=
 =?utf-8?B?V0NpSVo0L1k5M0M5Mkk2SXJERGhjWDFMUUtBSW9Za0JBcytsenRQWXQ5WThn?=
 =?utf-8?B?WFdNUDQxOWg1T0Z1dGZuMnVjU3VHSURnS0xJTFJ2V0RrVXVIVlNqL0VPajN1?=
 =?utf-8?B?RDZUaXVVY1M1SS9PMjZqT0k2cVpUSnhQSjVkQWhvRitaVGtCQlI4cURSM1kx?=
 =?utf-8?B?UlN4ODRJRC9aMzhJc3RET24zN1hKNGVseXNmNElQd3lqYlB6d21Vc1VLZjRp?=
 =?utf-8?B?ZzhRM3BjWWg0UTV2ZHpuRWw5NGlUUGtiVytyaUl4ZUF2VWtHV0ZKQ2ZTQ2VT?=
 =?utf-8?B?OWkyM00zd0ljTmNuemtFRVo0TWcyTEZQWFo0cUlKWmZYMXFycjk0UGo3ZCs1?=
 =?utf-8?B?SUZCK3kzVGwvYzFXSDNFMnBGOFdrak15aUZKNmJOT0R2cTlNaUV2ZVk1dDU1?=
 =?utf-8?B?empvWHFENXdwMHJhWUcrNWkxRUpURmNUa2h3N1FCQ1JURGs0elRHTXo2VVlG?=
 =?utf-8?B?ek9Td1BseW4wUzMxV3QvVkh0OU5TM3lEMmpvS25mbjBuclR0SHNEL3ZHZHlY?=
 =?utf-8?B?RWhhMXRsVnlTdkdGTDlobVo4S29MaFNaWFpBbm53Y3ZnVmx4SGd0ZXVVVW9v?=
 =?utf-8?B?UkhCQVg5MFc0NGE2dGJhYnUzOU9QWlJ3TWNiZFlKWi81NWtqczVnVG5hT3pZ?=
 =?utf-8?B?dTlrWHp2bjhFQW1oVzlZc25NQUwyQ2Zyd0EvczFybUZzOXpvRjVrcnQyc0FK?=
 =?utf-8?B?SFFlN0tzQjJZNnE3M3dDT3BHN0FsZW5zcC9vTDdFSVNVU01jekxLOUN2eHZB?=
 =?utf-8?B?Z290TjN2OUFuVnBvVVZJYUhCYWxCMEI5c1dtNDRpaEZPcU5Oc1hVUDA4T0Rr?=
 =?utf-8?B?ZDNSaWxaTVBxQzN4T0FKMTY3OG1XaUo1QWVwVVhqcURNd2I1R1J2aDhGdHRu?=
 =?utf-8?B?WWVDcDhSK3FnS0xkREFhcmwzTGlNeVNsa1ZPcVllOEU5SHhLYnRvbWwxdzRW?=
 =?utf-8?B?RlN5ODNyM2xtS3BIL2lVN0FuMFlubDdGN3BWSUhEQ2k5QWYrTmZPQkg2c3Bq?=
 =?utf-8?B?R2tyL090L2JGbm43dDFzM2YwSzA3NXUrNmlWUllQaTc3eTM2LzdFV0hQWEw5?=
 =?utf-8?B?VHZwelJmd3VoelNTWkQrVitPMXNhVElGc1Nud2dnRm5ibmVBY054ZExMTUgw?=
 =?utf-8?B?WFh5Ly9TY2lLSi9DUTRCY1RLZExwQmk0dlk4NnJXeGRlYUl6eldmc2I4OTRG?=
 =?utf-8?B?NkIrMzYxTElZMmRRT0ppdnZPNHI3c0k0VVkvUjQySDZVMXBYUVg2QTIyNjlO?=
 =?utf-8?B?WFdNZ2cycmNRN1JnR3NKSXBCUXhIa0JQNW1ONnZDVnpiRTJxN1RESUY4a3pz?=
 =?utf-8?B?akRkbXFyR1dJcmFQbms2N0NoQUFUbTl1ZHg4SXlkWUpDUDJ2SmpCNmFYc0lN?=
 =?utf-8?B?ZjhhYTlENUdFWTBvZkZuMkMzWlBMNnA5Z1dqNDFaSW1OYXVmOG9Ld2xyK2Nj?=
 =?utf-8?B?UmhYSGV2R21rZTRCdko1b29HbG4wdFR2TUIwL0JXU00zRmdacnlKZ1BHKy9s?=
 =?utf-8?B?djFXOXVHSHoxdlZwQ3VhWStaVml4T1NBbEdSSzB6R2lHYThmMlJqTXdobHl2?=
 =?utf-8?B?eDJwVDJlaVovK1ZOQTM0QmMyR2hIbERwaEpOVWYyWHU4ai9LbjUrL2M2ZERs?=
 =?utf-8?B?NjhuS3k0VFJMaExoc3U5YWlaM1Y1Qzh3NVBiSEorcVRFdlFKK0lTTnlZeVQ2?=
 =?utf-8?B?bWo1M3A2UkFwaXhCT2NhSnBnaE12dGRNRDFsWlBrdVpESGtLVlJaR2kzTTlr?=
 =?utf-8?B?UFhYb1ZWTElSWlRQQ090Q0o5UG1ZU0N2czMycEtqMnBtOVB1K01QT0dkanlG?=
 =?utf-8?B?WG9hUCtTY21rR0pHdzJTMnBJU2hpWXNTMExjVVBOaEFSbWxtdjgzUG1LbUl5?=
 =?utf-8?B?MkF5aCtnVUR3d20vMnVvTFZubzZ3Wi9iMm1aVUIxeHRoYTRQMHZoanFpTVpE?=
 =?utf-8?B?Y1VzZkhwT2haUk1icCtZdkdYZFRIMlkyU1hKWE02VTlsYmQrV3lzZmFkbUF6?=
 =?utf-8?B?UE5qS3IzaG42TDJ4ZjhpZlNMOW1WOXhEbm9OT3ZJQTEzK0hNN0c2Njc5Z1or?=
 =?utf-8?B?a2VZcXhUcXFNSUI4S2NtRndHSklrYkptYjZLeVVsRnRxRjdOODczNTRwbG12?=
 =?utf-8?B?c3hKS3FCVXJVREhUaXhMVjdmUXJzNlZwQTFiRnFza0lkb2xCZFR3RHZLUzJF?=
 =?utf-8?B?NmZEUXlTeDFRVDFPNjNIN0t6ZkJObTFibkp2OTIwUlpRMWNqRGMwUENoVGkx?=
 =?utf-8?B?bnlHczU2Z2J6d2o5NGZjdWxybFgzYmE5Z3NKRHdKOXNqMG9IWmhDQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b151d344-8b33-40ec-2fdd-08def6c62d12
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:00:15.5178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ANkfCRy0BvrJcKHbzXSmwY7jRUOc3DwkHFes5ctW4k/1JT9kNHjzQ5xCOx+L9JdoMN/LqgyR5gTUCEBho7TgIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403

Hi Suravee,


On 7/27/2026 6:58 PM, Suravee Suthikulpanit wrote:
> Enable hardware vIOMMU on an IOMMU by locating its PCI vendor-specific
> capability (VSC), reading the VF and VF Control BAR addresses, and
> mapping them for host access (256MB VF, 4MB VF Control).
> 
> VF Control covers the first 4K of guest IOMMU MMIO (control registers,
> trapped by QEMU). VF MMIO covers the third 4K (virtualized by the
> IOMMU). Per-guest bases use the Guest ID from the previous patch.
> 
> Initialize the per-amd_iommu gid_ida here so amd_iommu_gid_alloc() can
> run when IOMMUFD creates a vIOMMU instance. Export MMIO map helpers and
> call amd_viommu_uninit() from IOMMU teardown.
> 
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |   2 +
>  drivers/iommu/amd/amd_iommu_types.h |  34 ++++++++
>  drivers/iommu/amd/amd_viommu.h      |   6 ++
>  drivers/iommu/amd/init.c            |   5 +-
>  drivers/iommu/amd/viommu.c          | 124 ++++++++++++++++++++++++++++
>  5 files changed, 169 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 9f2a1a8a6d3c..044bc9a634a1 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -28,6 +28,8 @@ void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
>  void iommu_feature_enable(struct amd_iommu *iommu, u8 bit);
>  void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu,
>  				  gfp_t gfp, size_t size);
> +u8 __iomem * __init iommu_map_mmio_space(u64 address, u64 end);
> +void __init iommu_unmap_mmio_space(struct amd_iommu *iommu);
>  
>  #ifdef CONFIG_AMD_IOMMU_DEBUGFS
>  void amd_iommu_debugfs_setup(void);
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 00f964d5b149..e88e0bacd1a9 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -40,6 +40,12 @@
>  #define MMIO_RANGE_OFFSET	0x0c
>  #define MMIO_MISC_OFFSET	0x10
>  
> +/* vIOMMU Capability offsets (from IOMMU Capability Header) */
> +#define MMIO_VSC_VF_BAR_LO_OFFSET	0x08
> +#define MMIO_VSC_VF_BAR_HI_OFFSET	0x0c
> +#define MMIO_VSC_VF_CNTL_BAR_LO_OFFSET	0x10
> +#define MMIO_VSC_VF_CNTL_BAR_HI_OFFSET	0x14
> +
>  /* Masks, shifts and macros to parse the device range capability */
>  #define MMIO_RANGE_LD_MASK	0xff000000
>  #define MMIO_RANGE_FD_MASK	0x00ff0000
> @@ -473,6 +479,20 @@ extern bool amdr_ivrs_remap_support;
>  #define for_each_ivhd_dte_flags(entry) \
>  	list_for_each_entry((entry), &amd_ivhd_dev_flags_list, list)
>  
> +/* VIOMMU stuff */
> +#define VIOMMU_VF_MMIO_ENTRY_SIZE		4096
> +#define VIOMMU_VFCTRL_MMIO_ENTRY_SIZE		64
> +
> +/* Host ioremap/request_mem_region sizes for VF / VF_CNTL BARs */
> +#define VIOMMU_VF_MMIO_MAP_SIZE		0x10000000UL
> +#define VIOMMU_VF_CNTL_MMIO_MAP_SIZE	0x400000UL
> +
> +#define VIOMMU_VF_MMIO_BASE(iommu, guestId) \
> +	(iommu->vf_base + (guestId * VIOMMU_VF_MMIO_ENTRY_SIZE))
> +
> +#define VIOMMU_VFCTRL_MMIO_BASE(iommu, guestId) \
> +	(iommu->vfctrl_base + (guestId * VIOMMU_VFCTRL_MMIO_ENTRY_SIZE))
> +
>  struct amd_iommu;
>  struct iommu_domain;
>  struct irq_domain;
> @@ -686,6 +706,20 @@ struct amd_iommu {
>  	 */
>  	u16 cap_ptr;
>  
> +	/* Vendor-Specific Capability (VSC) pointer. */
> +	u16 vsc_offset;

I think we can remove tracking vsc_offset (see below).

> +
> +	/*
> +	 * VF MMIO base physical address. This is needed to calculate/pass
> +	 * per guest VF MMIO address (3rd 4K of IOMMU MMIO space)
> +	 */
> +	u64 vf_base_phys;
> +	u64 vf_cntl_phys;
> +
> +	/* virtual addresses of vIOMMU VF/VF_CNTL BAR */
> +	u8 __iomem *vf_base;
> +	u8 __iomem *vfctrl_base;
> +
>  	/* pci domain of this IOMMU */
>  	struct amd_iommu_pci_seg *pci_seg;
>  
> diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
> index f08ab9ef23a9..d0c4fdd00809 100644


.../...


> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index f4b5f96d4785..014ae16bf58b 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -7,9 +7,15 @@
>  #define dev_fmt(fmt)    pr_fmt(fmt)
>  
>  #include <linux/iommu.h>
> +#include <linux/amd-iommu.h>
> +
> +#include <linux/fs.h>
> +#include <linux/cdev.h>
> +#include <linux/ioctl.h>
>  #include <linux/iommufd.h>
>  #include <linux/amd-iommu.h>
>  #include <uapi/linux/iommufd.h>
> +#include <linux/mem_encrypt.h>
>  
>  #include <asm/iommu.h>
>  #include <asm/set_memory.h>
> @@ -18,12 +24,130 @@
>  #include "amd_iommu.h"
>  #include "amd_iommu_types.h"
>  #include "amd_viommu.h"
> +#include "../iommu-pages.h"
> +
> +LIST_HEAD(viommu_devid_map);
> +
> +static int viommu_init_pci_vsc(struct amd_iommu *iommu)

May be viommu_find_pci_vsc as its not initializing, instead find the offset.

Also if we pass vsc_offset to viommu_vf_vfcntl_init() -OR- call this function
from viommu_vf_vfcntl_init() then we can skip tracking `vsc_offset` in amd_iommu
structure.


> +{
> +	iommu->vsc_offset = pci_find_capability(iommu->dev, PCI_CAP_ID_VNDR);
> +	if (!iommu->vsc_offset)
> +		return -ENODEV;
> +
> +	DUMP_printk("device:%s, vsc offset:%04x\n",
> +		    pci_name(iommu->dev), iommu->vsc_offset);
> +	return 0;
> +}
> +
> +static void amd_viommu_gid_ida_init(struct amd_iommu *iommu)
> +{
> +	ida_init(&iommu->gid_ida);
> +	iommu->gid_ida_inited = true;

Once we remove `gid_ida_inited` may be we can call `ida_init` inside
amd_viommu_init() itself.

> +}
> +
> +static void amd_viommu_gid_ida_fini(struct amd_iommu *iommu)
> +{
> +	if (!iommu->gid_ida_inited)
> +		return;
> +
> +	ida_destroy(&iommu->gid_ida);
> +	iommu->gid_ida_inited = false;
> +}
> +
> +static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
> +{
> +	if (iommu->vfctrl_base) {
> +		iounmap(iommu->vfctrl_base);
> +		iommu->vfctrl_base = NULL;
> +	}
> +	if (iommu->vf_cntl_phys)
> +		release_mem_region(iommu->vf_cntl_phys, VIOMMU_VF_CNTL_MMIO_MAP_SIZE);
> +
> +	if (iommu->vf_base) {
> +		iounmap(iommu->vf_base);
> +		iommu->vf_base = NULL;
> +	}
> +	if (iommu->vf_base_phys)
> +		release_mem_region(iommu->vf_base_phys, VIOMMU_VF_MMIO_MAP_SIZE);
> +}
> +
> +void __init amd_viommu_uninit(struct amd_iommu *iommu)
> +{
> +	amd_viommu_gid_ida_fini(iommu);
> +	amd_viommu_vf_vfcntl_unmap(iommu);
> +}
> +
> +static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
> +{
> +	u32 lo, hi;
> +	u64 vf_phys, vf_cntl_phys;
> +
> +	/* Setting up VF and VF_CNTL MMIOs */
> +	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_BAR_LO_OFFSET, &lo);
> +	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_BAR_HI_OFFSET, &hi);
> +	vf_phys = hi;
> +	vf_phys = (vf_phys << 32) | lo;
> +	if (!(vf_phys & 1)) {
> +		pr_err(FW_BUG "vf_phys disabled\n");
> +		return -EINVAL;
> +	}
> +
> +	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_CNTL_BAR_LO_OFFSET, &lo);
> +	pci_read_config_dword(iommu->dev, iommu->vsc_offset + MMIO_VSC_VF_CNTL_BAR_HI_OFFSET, &hi);
> +	vf_cntl_phys = hi;
> +	vf_cntl_phys = (vf_cntl_phys << 32) | lo;
> +	if (!(vf_cntl_phys & 1)) {
> +		pr_err(FW_BUG "vf_cntl_phys disabled\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!vf_phys || !vf_cntl_phys) {
> +		pr_err(FW_BUG "AMD-Vi: Unassigned VF resources.\n");
> +		return -ENOMEM;
> +	}

Redundant check as previous check confirms both vf_phys and vf_cntl_phys is
enabled. If we want to check non-zero address then we have to remove bit zero
and add check


> +
> +	/* Mapping 256MB of VF and 4MB of VF_CNTL BARs */
> +	vf_phys &= ~1ULL;
> +	iommu->vf_base = iommu_map_mmio_space(vf_phys, VIOMMU_VF_MMIO_MAP_SIZE);
> +	if (!iommu->vf_base) {
> +		pr_err("Can't reserve vf_base\n");
> +		return -ENOMEM;
> +	}
> +	iommu->vf_base_phys = vf_phys;
> +
> +	vf_cntl_phys &= ~1ULL;
> +	iommu->vfctrl_base = iommu_map_mmio_space(vf_cntl_phys, VIOMMU_VF_CNTL_MMIO_MAP_SIZE);
> +	if (!iommu->vfctrl_base) {
> +		pr_err("Can't reserve vfctrl_base\n");
> +		goto err_out;
> +	}
> +	iommu->vf_cntl_phys = vf_cntl_phys;
> +
> +	pr_debug("%s: IOMMU device:%s, vf_base:%#llx, vfctrl_base:%#llx\n",

better DUMP_printk ?

> +		 __func__, pci_name(iommu->dev), vf_phys, vf_cntl_phys);
> +	return 0;
> +err_out:
> +	amd_viommu_uninit(iommu);

Its odd. We shouldn't call amd_viommu_uninit from here. May be call
amd_viommu_vf_vfcntl_unmap() ?


-Vasant

