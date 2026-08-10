Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010052.outbound.protection.outlook.com [52.101.85.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7EB344DB9
	for <iommu@lists.linux.dev>; Mon, 10 Aug 2026 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786359007; cv=fail; b=U9hhI+mruyQgsHgeR0t9fzel9uwDk7g08f7G/MknxMT1wJZrXytMisikK6fjJfg67gNmbiaSv7HrEYHS0RJ6XnY3Yvc/aRXKfyj2FHeQr2OQLZ7HUhP93NwBG/d55Rk/F75J+wkOj8D0mieAoAvrlFM9mwUDiS45PmycVDVL21g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786359007; c=relaxed/simple;
	bh=19d6n034FR/MaQMTS0BbA1yzk771QgUjE4yBXnHAqW0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fPMiT1VRjerfTnYu/nXK/ZdydIuSNkytbp+Qi2qpspFDfI9zsXObdqTjzVyEnVRWNK6WZcVmfDeF+cB01+VsMZotrWihq+Jr0nnJf3Ny+XuVL1T6ew88f0xuyS7kYCyIS0jiW58JRP+K6Sp58r/rOldxybXxtkcz5z8jU8Uk9tg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pExa8uHW; arc=fail smtp.client-ip=52.101.85.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pExa8uHW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ohgUkJkbNu/8O0oCR+dDaKzbQKoBLFXGgWTlWm4+Fzj7JfxWPpR8TgN4byJpDVlYAHlYqbPGKAEPz6nCZrp+PgQ5P+2QCeKIyOexQhxqnmIi7NNybsaM+NRNQdljrijH0zsgzj9/DTHFu0u12GlXA1kEwsbOLHCznfRpDeLclCUwy1ZEeXF5wK2DcJC1MGSRAVEIkdfMiJ38u7S5zQCawDgJxmuc8EEGX9u0+NW9zQb0pqifZFP+kyqF0Hp6x3o7UI6nxxP0VpXwmDfj1YIEFZt0vlxjjUBSTX2t7GynW5Wme07O+DrOwtCEr/ck5rhQfgw3pagzyAfXLwJYTmefRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wXFHMGohJtWVc5N9XwlXhpPjMKT5jmLH2BSYWtQ+a9c=;
 b=A20b4P/NC3fo8pnwDpkhcRNUD7xIwCsTxtUgzYS8d19ibcYGS5uFW/5BD2v3FDUbceY3WjvnJ0q3tQamjcQ3ACkIS0Tsnw3phiVoos5eBT2LPR2KII/uFtiJOanDcl6Ul97jSSDFLvIMka4h0ydc16coNXhs1qBnOstBhB2zaRLcvGEThxDHZOnYqzhh81gdy3HxrHC/MWhVn8bHVbiXvhkDCgFlqLKiA35V5munoGy1Cz6QKcErG+EsfDY1axBSPB50yLunUDYbl+Q5VxLCi5axIJ+P+gg+unH2xIAqSI13MDtitCN99Ep8x4rfbeUc9wLun44tdW/Sa7o2kfI1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wXFHMGohJtWVc5N9XwlXhpPjMKT5jmLH2BSYWtQ+a9c=;
 b=pExa8uHWrvKfbDDl/ugNo7lOARD8ByrjRXGDISyhhJE6fo3G6uPs5TVhx3CTe4gWTWrCGW6niZ/JmOkpGzhm74ymr6cB3Pp4YDFn3Xjk849q8Y8aJH77ecXLvkvxf7XXNfgAj9dRhE4cUv2D1A/5H+jrDMrClbs8WHXsWzQ9d3A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB5766.namprd12.prod.outlook.com (2603:10b6:8:75::12) by
 MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 10:50:02 +0000
Received: from DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e]) by DS7PR12MB5766.namprd12.prod.outlook.com
 ([fe80::222:966a:d65d:d08e%3]) with mapi id 15.21.0292.018; Mon, 10 Aug 2026
 10:50:01 +0000
Message-ID: <a3e6a22f-776e-4bc2-a110-d5a856560def@amd.com>
Date: Mon, 10 Aug 2026 16:19:52 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/24] iommu/amd: Add support for AMD vIOMMU VF MMIO
 region
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-8-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260727132913.22475-8-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0185.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1ac::13) To DS7PR12MB5766.namprd12.prod.outlook.com
 (2603:10b6:8:75::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB5766:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: 438000e7-6770-43bd-f5af-08def6cd20fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	R9pBuiwfmGhscvCcGSog+4qcBiAPHSOqMz+/MyER9R4KOFRmknsa+2chu5pbyRSEwtYXmv7V3UXPeitwIyqiwsYtx9t0jomd1Bibx6iG0VhmBJ9BrnnWbUiKh2ktkRFgHzxOL2RgUSI9TqI9aPRvjnGCKxEJ5cm7GzDL1faa0BJbBVUbpjDfPXrs8xQUoqfuAvVhUBZxAHDCHfnm3bxWkjd2rdIXWNw5u5TWzn8wL7zHYOXtR6uWCd/A5XSrsX3XgMrX+Vsd3jZDmhUoAuKS/8/Tr2Mp+q7GBJcTqtBEbDbZALy4Z8IDrLaZ+Ckhqf45yx6gdbktcskSpkyO2W3/wdHrqFUYx6vnk5wWIa1JalAs/EpNI/6Gwqo4Gi64xwhJ+hEVo3yh8s2FJ8RptwV4fXKGYHwITqNo1XHjx39yWuTU58GigZvxq0qWsaRhtJQQLESG/I/vSpsyigw2LqCpkis2kRMsJCHrvkBt1PJB0hYFsKhf/+wNqOVzYGyE9U0REHQPexe7pAAG9O3q0OYSSqLIXZT/q72I5jxvyVXi1fkhx7aA6TCoXNFsWN1R/aaz9iY6Sr8BS51jne/58RaxuftV79WuaebnU+YfRHq7NTxDGa1N4FpFjzxjzJcnL2ZV22TUJ8WZSL4l9ELnxF4RO3cAkZmc40IX/7Y5hIPpKoQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dUp1YUY4SnFmTVhzNktJL2FqK25RZTJaMG1tQ3VTTk9iOTF2dC9oNEIyS1ZZ?=
 =?utf-8?B?VkxnM09KM045Y2ljWFBkWk1xVjlEQzBzY2pJcnRMSEhXZFFqaXY4L2hiL1U0?=
 =?utf-8?B?TzQzV0FQckw0aDllY0djUEdpcjNwTTUrQlpiRkhpb25nSVRBVlhHWmJSQnBx?=
 =?utf-8?B?aC9yaVdvNVhJSW5XRE90Z3RHbDFoWUVDZ2VjOVNrRXlXaWhUcnBHK2tncERa?=
 =?utf-8?B?S0Z3a1RpdUZvMFlISFJ5VlVuVzZkbThYTXBuN1pvMTB0b2lRdzU3YmhKZGYz?=
 =?utf-8?B?ZjJZRXRJMW9NTm9CUld0Ty8xNDdCbFQ3NWVQdCsvaGtqakFvejZHRVZNQ3JG?=
 =?utf-8?B?NllsMUhsZFFaK0hrZHFOdVNpeHRaZXFLV0poNmpNckJrUElkYmh4ckJZS2tM?=
 =?utf-8?B?YkJic0NDMnRkTlIwbHBuMGxLZW41bS92NnAxbHM2YmhWeGNMcnNpNEl4L282?=
 =?utf-8?B?TmxLWVVYdTExa2lpbFFvRW9YMEQ4b1F6TWtYZW4xOVZQZy9kK2RPUXRCQXJK?=
 =?utf-8?B?U2N4QVNZY1ZUODV6WlJhazM4UzI5L2cvQUZTOUdBLzZQQkVBcjZTOHg1QzBZ?=
 =?utf-8?B?d0ZxeHRUeklrU2I1aWVxQVcxTmE0MUVLTkEvMWNhZ2gxdjJ6WElzSzlyQnBJ?=
 =?utf-8?B?YzJxOUZNYUFUdjBjTHFWdm1EVm1MN1gvMEcyODZZR2MvMkw3TTBNK1ZneGNm?=
 =?utf-8?B?UmI2clNOR25nT3c5dC95NW1IT2w2QnFXSlU5U2NBVXRya2dqdy9sT0tUVk9l?=
 =?utf-8?B?NDBkUGlIZEQzMC9TNFBRcnYra0ZoZjBzVWx5SVF5Tkd6dHFzdjRxVWMvSU5T?=
 =?utf-8?B?Z0FQVzE5OURlcHV5bHp5aXhHTkl3OTRwMFRQbTc2VlVWQjVEWERRNExubDY0?=
 =?utf-8?B?VjQ3WkJZd2lPQXppaUl6QWlwSzMvdmdTSHhPbE1LNWtUeEdUVE8zQkV2NEpP?=
 =?utf-8?B?d2J2WU44amt3alR1WmNLOC8rV3RlWWVDcW5BZ0dramRaZjhlWVhZS09Sa09x?=
 =?utf-8?B?ZkNNSHduaHduSGxPaGJJN2NCWm1WeDh4ZXpoMWdPRUJja0p5cUJPczl6cEIz?=
 =?utf-8?B?dXFUR00zeXJJeTlYTUtPVWVMUmdjWFZ0VksreE1VQnY4NENJa09BdVE3MGVq?=
 =?utf-8?B?R29XUC9Xekk1RmsvWlJ4bThHazU4aVdpdHVZaTYrVjY0UERXOTVrdzU4Q1du?=
 =?utf-8?B?L3dmbkdUSVFkWlNRdVZyMEwxdUc5elptRHpoVjM1ejdYR3g2aHJ4NFhPZU1x?=
 =?utf-8?B?a3NBSkxCdVBKMFZlQnRGWGU4bkN6dmI4dHBhbk9ZN09SMXJXWmR4aTlXUFBH?=
 =?utf-8?B?SlgwcURFOGxkTU96MUVXbEF3L2pmT2VLNmJRUlNwbDJ5R1c1Y2hrbXp3bE9w?=
 =?utf-8?B?bWN6bU1COGZacU9TUTloQW1raXdMeEtGNFlwOTk5aE9udGZPSXhmZGlGQ2Nw?=
 =?utf-8?B?aktaeVpOY2pkWVd2dzJ0ZGhqODFhTzVZOHBOT01NN1h1Z09EYjg0WkhITkVi?=
 =?utf-8?B?dXVrM0V2RER0dmQ5ZWI1VjI1ZksxSm5XVnhibXozbE9NT3hXaXppZ0xwQnBy?=
 =?utf-8?B?cFNPUzJEbjYxMmI2MjE0alFZcGtld2N3d1RGSkxJMGNIWnh5aWlSRGNxWU13?=
 =?utf-8?B?RlVZZUoxZmQ3VjQvZUZrMFNMR2VKcEZjU2t2Um9aeVhLVjVjVE5ZR1lNdVZm?=
 =?utf-8?B?em9YMVVuNDJGazl0dEtVSFhLeEQ0TlhJY1VOdGRyNkwzcFM0Sm1SaWtFRXVZ?=
 =?utf-8?B?Q1BsU1F6NFBsS3RjSnNHOGwrTUFzenNWVE80cUd3OWdZNitqbTdxRjE3ZERj?=
 =?utf-8?B?TTJpa1FzUDhuM2FYT2phSUVDaFVTaVZDT1BHeUc2VjkxdGZWNjFWSnh0MWo1?=
 =?utf-8?B?N3RsYnZlbnFWcDh6YTY5N2RjZUtGWDJvR1dieUowTndiRnQvNXZxRlpINUR0?=
 =?utf-8?B?UVh5ZDhPNVNHV05OKy8xRmRadmhoRytkLzU0TjhSdzZMZmUxVWVHNHE5YlhJ?=
 =?utf-8?B?UkE1dTdHMFE0djlrbHZGTGZOaWJKTU0vK0tybDdabEpOc3ZJcGN1VFg0VFdK?=
 =?utf-8?B?VjltK2xJVWdvcU03UFpuU0o0YldsUTM0RVo1K3lWTGp4MEptcXZOMmJKeG44?=
 =?utf-8?B?b0Nmd1Y3aFRiR0FsNkJHMGhjd3lZZlhob0MvalJ3d0RwTlJPWVlwUjJmSC9z?=
 =?utf-8?B?R2xFZGdsL1NpM0R4S2Y4RnRFVnJuQ1J4T2ZNWlNFSWwySEY3bDB1ZVVTZkNw?=
 =?utf-8?B?VmNuWXl4clIxcTNjbjBjNUMxcUY3N3hBRWcwSEJKbHZHZWQxOGt6WmdOdWZS?=
 =?utf-8?B?KzNZQk8wN0hjTDJRSWw4SENNdjdwRmYyZG8vSHF4d3pyTjFxZmxBdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 438000e7-6770-43bd-f5af-08def6cd20fd
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 10:50:01.6901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDWzL3H/Pvf/TAZoPVoCllQjhFHpwnjJdPgL+dE/jcwNgGFokBNKFRBBX8+Iuq+iHHv/WeD4FNNMrs4wmMxrmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197



On 7/27/2026 6:58 PM, Suravee Suthikulpanit wrote:
> The AMD vIOMMU virtualizes guest MMIO registers at the 3rd 4K region.
> This is achieved using the iommufd_viommu_alloc_mmap().
> 
> Co-developed-by: Vasant Hegde <Vasant.Hegde@amd.com>
> Signed-off-by: Vasant Hegde <Vasant.Hegde@amd.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  3 +++
>  drivers/iommu/amd/amd_viommu.h      |  7 +++++++
>  drivers/iommu/amd/iommufd.c         | 17 ++++++++++++++++-
>  drivers/iommu/amd/viommu.c          | 10 ++++++++++
>  4 files changed, 36 insertions(+), 1 deletion(-)
> 

.../...

>  
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index 014ae16bf58b..ee8c09f13035 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -131,6 +131,16 @@ static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
>  	return -ENOMEM;
>  }
>  
> +/*
> + * Returns VF MMIO BAR offset for the give guest ID which will be
> + * mapped to guest vIOMMU 3rd 4K MMIO address
> + */
> +u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
> +{
> +	/* TODO: Add check for sVIOMMU and set gid[bit 15] */

We can remove this statement. For secure vIOMMU we should be fixing GID
allocation path.

-Vasant

