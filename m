Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012022.outbound.protection.outlook.com [52.101.48.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A979B34D4DF
	for <iommu@lists.linux.dev>; Fri,  6 Mar 2026 09:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772791014; cv=fail; b=pDvIz4ZKK4leJoZP56s5VYd39jbM62U/UJqEOVm5IXQLAUX3vPFvzpGPJKwPBKGc3CY2A/TWApRp0kSyOgXL497XdLnbDGxTjUDtATKIecMtP/mOIYUv9YYiwWIQHxbo93494n9ehyELTzsGmj3fqsSCAlgVgFMd+mNyUK6LWZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772791014; c=relaxed/simple;
	bh=SGB5dG3w5NrOucStOsZLnZMErJVPdlNJ9a4CD/IRwiA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QMT7EP5CsQv8DRNnI7dLkpzlvGdNhPl30ItzI/49EblyyG3Oqx2YaAn+M25XIVf1WiLlonqf+n+s3seeYBqeVxfHjp+fSt4SzIpFB0E5cXIUswZQ1IgfoCl+5bH8HRqzO57fu680P1OW1D+zFF53aEUpPXcvw3ja2KXz5lYrPyw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pSioFGB6; arc=fail smtp.client-ip=52.101.48.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pSioFGB6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZsKoquHag2J0VP8XjMW0ZVY6ySbxZZoIC9b9tzBnUeLsht98OYvoKQK2yGOUpCvl+RQuhnzR27+vIiwUxsJLpLyXePDvS17037ebqghYT+ol6tksSC2jY8Isla5yURop2di7ml09qbUUqu1pJZSAIvgI6YGEj/lKoTUgeuMDcwRxKc8uw7L1MatizUJTcy9Haw16l+vQk6Y2rxPJ/Sp5EuGOCNrBGS5zD1cfwezhGPn6RFBzUr/HCwDNfT0rNEDA8039CpVGvsrmiNMSOhI4d+AUpmPtUQzkWgUW4XHB8udzGPtOj4akRqXUrTj4TmvgAgTj/FoTIWHb+LFOpZ8EvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ib/bANpdNwbeBSDsRExbePXnuaMHC3hjRHaUVK+/UWw=;
 b=gt5EvkqJej57P/6lsre6rINME9srfKH97XKcwtr1zB6CyGw+GCDMowYehFzO0lXQAvTdhr//2a5kVuUevTaOu6sfAan+t2WsFfldELbgB22rFMmrNb5Njz2lAC/fvd3OxUUvu8+/YXIb0J8YxkRd/O2LVdAszQKX08ONgLfujkNuIelOgCRVeWif9IQHoo7mMFpprifGa1XkfHGQSYm/G9eX/ZnT5HJrwLLrYIw7/tgMFTuKKUbGyhrNarrzmOFleMZQdXJ2CXGToEQCX00yRI/GSjtB03xyEoM4q9aMwEE/BFeShv7uZxMmdjRd4bXVPf33q73M9EdJd9fLZOgL6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ib/bANpdNwbeBSDsRExbePXnuaMHC3hjRHaUVK+/UWw=;
 b=pSioFGB6ygMhprgmsD9ncrefvP4zIJHh+XebLerg9ws5DAuIeutOw3pPAP07WMhYSVpD22t1Mz8nUBSbMguGYBc+hOnsWBjIp1otMwxbwi2/spYcXfoy7a7j16PwWah8JgHvElpTvfQvc6WdIgGb1lDA9lzJxS4KpzLmjdO+wW4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6)
 by PH7PR12MB7916.namprd12.prod.outlook.com (2603:10b6:510:26a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.18; Fri, 6 Mar
 2026 09:56:47 +0000
Received: from MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288]) by MN0PR12MB5761.namprd12.prod.outlook.com
 ([fe80::b0f2:27be:4ba6:3288%4]) with mapi id 15.20.9654.015; Fri, 6 Mar 2026
 09:56:47 +0000
Message-ID: <6ba98524-e7c8-46d3-9ff9-7b57250b9b38@amd.com>
Date: Fri, 6 Mar 2026 15:26:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iommu: Fix mapping check for 0x0 to avoid re-mapping
 it
To: Antheas Kapenekakis <lkml@antheas.dev>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, dnaim@cachyos.org,
 Mario.Limonciello@amd.com
References: <20260227080638.208693-1-lkml@antheas.dev>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260227080638.208693-1-lkml@antheas.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0003.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::8) To MN0PR12MB5761.namprd12.prod.outlook.com
 (2603:10b6:208:374::6)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB5761:EE_|PH7PR12MB7916:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f497d5d-9406-41d4-8e3f-08de7b66ae08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	FoNpB67l2sQ2hIezNbG4lGnxx93LLIytwHHGyytfPXlbNxh2AsTT3wWshkIowGRgwesU/Sk4k4BsOg4eWa3oykOazK+lJTA/IcIz2QZ3nCysjI/oRdI5loi7bAbkTjw/3DA0jwvpKawU11utgfJysxfUFsMmVuVntGeZBGRiaP9TrDeghfhZHNjky+tnF72fELWYGu00O0I7Ob/Kt+iZNUtvQkNCUvig1cwwOf2ZVx/+YyNlKcHuIlrxhAHdfnc0hhXUvzd0J3lL4KDvokXSZoKYCAdeWNGnl7a83R3jn1zNAxrw2QqKhYSGA4e9aWw3xofEf7ePwkglTCIqzPeima0WjbC271LnKHoGyQaMPrrMVueZ/qgVL10HgK3wIq22fzFWlZw80J4kb9UJYuyVMD3zRCcrCILsXV2LXBhpAp3kYOmda+oNZrBPylCUhuyXZh4LwHVT/sGad/OqDf+7TD8H3YmTn1zDSo5jgKXGcj9rcDCRvbj5v5it88jSd/oJ+Y/6thNM9Ini4jUuGArwXjGMIG8XTbJFkXxPop5rpIluVDudQujrd/VBOQ4OKsgqi9iFpX2BajdvQsczTHROEx5SOY4HPeEaPqiFZIBZ6qTpTaxTfw8kHNKFXlMBoXyS3VSZL1ksZrqO7mgXMwxs42CxD682imTNO+qL7Ue9YqogBKOpuRKWrL0UvZOB07LqNCkDqX6Guk9ZLRfzcGlKJUnlnWALzfwgZcM7ngi9Hx8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5761.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2F4RWpjNGpGQloycTZ5dU53blliU1gzQ01FYnBLM0lxakUyMlFkSkE0QlNv?=
 =?utf-8?B?R0VSTnh5WUtYdzhqRU5XLzJuQUE5VGpaYmpmVUJEeVhNcEpXUE84S1dZUjNV?=
 =?utf-8?B?VVpVTk83YXd6VkhROVYwTUxIMUlNYmFoMGQyZTd1T01NdG5Qcm9CNE40N0xY?=
 =?utf-8?B?RjZmOFhOQWI3Q2M1YXdPNlNZMWE0S3BwMWlOL3A0Q3owbCtVd1I1WUN5ZURI?=
 =?utf-8?B?VkZxcll2NWozamtMQVM1d2lCL2Y3YTUyL25aT01hckdyNURBV09icVc1Ulcx?=
 =?utf-8?B?a3FpTzRiK2t3ckwvM2VxNjRlMFhOOXpmOFZTYlRIMGxpM2NaMHJjWnlVMEIy?=
 =?utf-8?B?Nzg0RHgyU2hFb0ZTdThSZUk4NkprL0pxem9qSCtpRzFsWGdSV014d0ozU3p0?=
 =?utf-8?B?eTZteDNaMElQZy95SnVZWXJma2trdC9HQkNGZHJQUENnVFJyb0JNWXRPMWdr?=
 =?utf-8?B?Nm0xcVk5dm5WSWF4cHp2dWhoK2N1M1g5M1FHdUxrN29RcHV1MERKanc5Tnhl?=
 =?utf-8?B?bVF0M0MvZlV2Mm0ya3JEWUd3MHFJT3VSZ2lZQ0pqdVc2eUxyRXlwNFR4Vnls?=
 =?utf-8?B?cHNPQW82bHZmVnlTck5kWEN1VWo1d1UrSGJEYkRFV2JUSEpoaEZobHo3ZU9H?=
 =?utf-8?B?UXh3VTArakZ2MnN3djNsN2FWWm1iRzRjRkdxSGcxOGk2MGtvaVc2SDlnd2VZ?=
 =?utf-8?B?bVdHejNiR3oycEg1bDVmaUk3cGxIcEtxaGgvVmxGajNnS3g0T3E3WkM4amtQ?=
 =?utf-8?B?elNROW1QSFhlVlNoenhIejBuaXoxR3FwMmFPeFdRSkduRUNCa1B0MVFhR3lu?=
 =?utf-8?B?OFlYalkzUFEyTWZlVlVFQ2RpSlR1bDdBbU92Vnd1ZmdWK0RTZVFhZHltQ3hu?=
 =?utf-8?B?S05TTklqMGhxZkRKbDZpZEVJUit6NzJkZkRzVE5LRVhiY2x0RUt2Q0MrOXMr?=
 =?utf-8?B?SnBuWWRwVjE3RUQvWXZ3VzBzVVRXZWFHVEJhODFnL2p1NjM0bjJ2bGZEU1RE?=
 =?utf-8?B?QVRHYmJEaWExaUQrMTZZZmdOaktVb3JvaTB5cFNQcmRGWjZJVWF4R3Z1VnAw?=
 =?utf-8?B?Y3JhU2FYa0M3N3BpV042R3R4TkZoUkZqMUwyaUVNZnZDWjJOZUZyczdoWldy?=
 =?utf-8?B?YjdYQm04bjFycnhDcWpid1FlQTIyUTBNZXUxdC9XYkpHVTJEbUhEeFcrWWx1?=
 =?utf-8?B?VG5YdXp0d0JFN1pKdnB0R3RISHhxWDVWdGM1L1RTZW9MMWIva3o5L1JXNEdQ?=
 =?utf-8?B?MnlPUStCQ1FYTmY1QWVIWGNGVVc1Sm5iTkNpdE94S2hFdHczVHRDWGJ1STFk?=
 =?utf-8?B?MG1WOTljdExPU3N5cmdmTENwS1NwMDNCbTFwdXdnbzB5M2JTTGcrcGFLMzFl?=
 =?utf-8?B?OVFrcGFaZmxjQmE0TlZQWGY3bmVRU1BxNjJ1bURwUVMyYXFEV3lrcTZ5Zmlv?=
 =?utf-8?B?cjJnVUpEb3FNb2xNWUZNeUI4djhYUVlHZjJoT3VBeDdWNFhzSHVqTTE3Tnk3?=
 =?utf-8?B?eXBIc2FSblUxcTZaSWtHOVIvbWNkYitqc2ZBOVRrTWVYdWpsNlNmalJQSld1?=
 =?utf-8?B?YjVjY2lrdXEwR0FTMy92cjh3RXQxYkpGZTIvQ1BJdGQ2SjBVVWJTUTJCT28x?=
 =?utf-8?B?aVZlYWo4dlBtUWdHNEpYYVlGK2hFMnFDVDJNUWNJODNIVHdmaHFGZklFQjZa?=
 =?utf-8?B?cERXbGFLV3VUWlE3MGlaMmI2NG03cy9JZUw1OHQvL0FIWjJ0WjhhOVQ2c3JC?=
 =?utf-8?B?N3ZqdXJCV1VsdTNLOCs4VFZ5NDNWblpMd0RwZGszTWFwY1ZIR25Uek1vdjRM?=
 =?utf-8?B?RzlZbi9lR1ZLOVB1V2J6MnY2bWNybXFaOEI3UVluWlU2M09NbDluRFBHTEs1?=
 =?utf-8?B?Tm5ZSkRLQThYQkhVakdmKzlHckVMb2F2NW5UNnF5VkFleVVsUERwSTlLZVYr?=
 =?utf-8?B?d3ZxSElwS0ZydEtlNlFoYlRJZS9Kb0V4Z1M0ZCtSUE5FczhkSVNGWlBVMGFN?=
 =?utf-8?B?Mjc5czZBZE9JWkNzRWo5UTVWMjVBd1pQN2U1ejU3VmMycE1WbjNuOVpuWWlR?=
 =?utf-8?B?bWtjSEhEYlFyNUxIY0ZvbHJHSkxFelozeWZHd3hZZXpuMUlNVWRCSk1RZ2g2?=
 =?utf-8?B?RnI3RW14S0pEVXJqb3BSVjFDdTdiU3Ara2QvbDRpekJmRXptenI2VjgzZFVC?=
 =?utf-8?B?bnVMUUpmWjJGbURJenhHYWFCbjN1R3N1SlhRUjZXNkZZUUFvT3pEaGNyVHhS?=
 =?utf-8?B?ajNJM2V1elJDS3lLU1l4MGQ5M2g4YlVmV1dMaU05MmlQODIwT2R0T3hraXJI?=
 =?utf-8?B?SEEyRkp4QjBDMWVIRzlBa1hmTklsT2NZTjdEMDB0T3RIWUdieVVZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f497d5d-9406-41d4-8e3f-08de7b66ae08
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5761.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 09:56:47.0825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZzpgjuHaQmscjpySiyzJReO686JSSttjGO9w+9t6CgWkAuBDpPVMVO8za/oN+QKbGiy6utWmhkZxn8dHsT8hA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7916



On 2/27/2026 1:36 PM, Antheas Kapenekakis wrote:
> Commit 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> introduces the shared iommu page table for AMD IOMMU. Some bioses
> contain an identity mapping for address 0x0, which is not parsed
> properly (e.g., certain Strix Halo devices). This causes the DMA
> components of the device to fail to initialize (e.g., the NVMe SSD
> controller), leading to a failed post.
> 
> Specifically, on the GPD Win 5, the NVME and SSD GPU fail to mount,
> making collecting errors difficult. While debugging, it was found that
> a -EADDRINUSE error was emitted and its source was traced to
> iommu_iova_to_phys(). After adding some debug prints, it was found that
> phys_addr becomes 0, which causes the code to try to re-map the 0
> address and fail, causing a cascade leading to a failed post. This is
> because the GPD Win 5 contains a 0x0-0x1 identity mapping for DMA
> devices, causing it to be repeated for each device.
> 
> The cause of this failure is the following check in
> iommu_create_device_direct_mappings(), where address aliasing is handled
> via the following check:
> 
> ```
> phys_addr = iommu_iova_to_phys(domain, addr);
> if (!phys_addr) {
>         map_size += pg_size;
>         continue;
> }
> ````
> 
> Obviously, the iommu_iova_to_phys() signature is faulty and aliases
> unmapped and 0 together, causing the allocation code to try to
> re-allocate the 0 address per device. However, it has too many
> instantiations to fix. Therefore, use a ternary so that when addr
> is 0, the check is done for address 1 instead.
> 
> Suggested-by: Robin Murphy <robin.murphy@arm.com>
> Fixes: 789a5913b29c ("iommu/amd: Use the generic iommu page table")
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

-Vasant

