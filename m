Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010001.outbound.protection.outlook.com [52.101.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5745137DEAB
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761098; cv=fail; b=GJKa+ZF5k4nM9nuODgGDO0eRQUYoscckq71AZYixfWrEjLj2+szlufW6Y+Ah32lN+exFv4OFiNpR5fp7ESQvGVvgrU+qMWiql6IGNlfzxVm9HZooK/1bK58ORr7DTbnRCvy4GrwdUCKsqgHDptDvL3bS1OuhUf8pW3K1Smu1lcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761098; c=relaxed/simple;
	bh=ORD02rTRb8JmsMpXnzqz7958hxjmlSg/zlL7zZa/Cv4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=T77aIlB1ViYvnfQ4870weDhIVMkNbMF8UQM0G8Ol1BcPudxvBL5olKm7nOy+KMVjUeevV2/cA26Ky7RP53hhQXwM5OUNe8wpgN8+uNJxU2Nl1xGsDRSzwPbFMKROoE161FCSynxqD1b/mZ9cYY5o437B9tnvPtWK1PQa6RBCeGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ztQ7pkG9; arc=fail smtp.client-ip=52.101.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ztQ7pkG9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+U/craXMqdWiyaDIGN1vPx9HuyXoeRBnLIdHTxS8O6gRNm+LMbILPxgxMY98jciyC8aN0OAcZUl0P85M6abqSkIrTvxjihGOH4g63iSldUJjLgfa1ozWyF4cy2SaftnBIp5mzv5zd3vCiSEurcSw+GlN1Kh65YITTGbJR8SSZOZs99pbWj8VXYJHa6UBBId08a6K/1lypPe3ZI4UhYUs8ISCdWsUFvM6OrRLKLH++fd5Yl3cG5mCFs9hUnf/w79aV8v8amuJyW+kJbU0OAJ8j1RcdE2xwuhwQ4xkY8DC2E7zuEPir48gQDqmCS1RIAAx507Haz7QMXgiE+vbLl87A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/YN6ZpXqLSolNwOLDMxvKQZriE7gCR1/PS0gnJcPCU=;
 b=IQHYbPGW1qiSDzSZYre5o1Ds6Rszw+olHNcNS09v6riibLq/04IY4J9RspQBvvIQhpA233anfP5RntZgCEpP/W//FZik3IUdf0AMwPfLKZ9M5hzBMVRzPqaAqLFCRJBEEOluAyytw2o7w/9QsJtbt4baAXaCcyDSwXR0LnnDnA3dYOc+F0JpOLfnDnHgJAI0tgTYol7fh3YaVmlShMlj9Tf01gwD1EiHWTB8gaH2JV4eZGfqTmPW/z4wC6bYvLY7klCHEQj4PNm8zofOFL7+5GzgcyWP0KLQDBJ7LO3FYy0CRcZ4V/HBDqieZTZBVLgBsPEv4IuGfmMP57NEycjIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/YN6ZpXqLSolNwOLDMxvKQZriE7gCR1/PS0gnJcPCU=;
 b=ztQ7pkG9x36znkmrXtYyx+93UAR9oz0Y6+AUdJtgDgkPGJFwJGhhWIsn1qlKrj+jYs54vCaD4F/7XQhKKdo1WNUjueiv4+Yow31yqQZBjdJkqoOqbww/4ziXWB/FUktfP2uGGewomCk68CQnq6dVxMknxkZkLkJrk+jp7800ImQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by PH8PR12MB7133.namprd12.prod.outlook.com (2603:10b6:510:22e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 09:38:14 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 09:38:13 +0000
Message-ID: <bd707bac-26c1-4330-9e29-a8eaec07745b@amd.com>
Date: Wed, 30 Sep 2026 15:08:07 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/amd: Make PerfOpt compulsory
To: "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alex Deucher <alexander.deucher@amd.com>, Joerg Roedel <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux.dev>
References: <20260929013423.2313648-1-superm1@kernel.org>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260929013423.2313648-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ad::13) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|PH8PR12MB7133:EE_
X-MS-Office365-Filtering-Correlation-Id: cfc4d5cc-855d-4a97-8b2d-08df1ed68c67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	11ZdgBEASt+ToYrFAczj6sZIe48K7PGvfCawAmZYeQDNS+k6vMWKw0FYD3Gsk9kEIMrTBR/QoIXat08OpNcTIAuY5AxATtwK8J6EJ2VtcL72DEZMCW4EqVtzZ7BkGgLLujnJpz3LMEgMuj4rRpUiXfXwAful/+80N9uQOeCrrfczbQZWiJgd2oRJ+504q/ng/7PXnBZQO3WYiSYW/8TnyWr11rPrCtURiQynmqpyhQb6UXWKj1YpFEX1Wjifxsmwisk7g52fvbeWiVSX37RTIZoQJLcsh4C3oPzFqU2hayi2LrDCKlwGG4D34SrO6/qGZHPRGGV24/H/QzHOWdwHPifviFut6S8AZJy+P69E/zq63t2X1K7WAOIJAQRDD4hJaGdKYGawjpHnqCi4M+DEA+wk85MoVgmgoVXABQv7kjA6ASrcj2wJRl1bj9mjQJpdoeMspkO58uvayXcN4o26GEw+rDFZf1fUbGlfsAvB3oqPRkL0N4Ld1G0Qocug1tjeVal2UL+busQ2r5TMaHkP23WaXX2S1mGBJIHQCAt96tTMTIS1g6wyXfnhn2P+vn4BAZUTUeaj2wjbw4nJQq9zyhoF1eA7Jo8LHe6lyTOTrOtOFT7FsNXhJhb390ZnJecosTUIUQdbi99UZo1WuR5kaZn0Xj6myf5DF0FWIvPLWNY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEJFK0kya0RzYnVITFIzbGdBMkgzMkUvNW5aOEM0SGxXWXo0VUxKVmtBb2dm?=
 =?utf-8?B?K0tlYkZKNFZ3UkF5ZzJORVhZS3Z1K2JDekRPS3BtRFQ1Wk9YQ2Q2R2tOVU1M?=
 =?utf-8?B?OGJxSTgzWllnTnVndVhqUVQzMHVucFU4VXFyNjNXRFF4N05sSHI2cTFTaU0w?=
 =?utf-8?B?WFJyMmN2Y09hLzhNM2hnRDg5OGkvSnNsdG8xUUdyK3pWdVgvczBZdE53M3Uw?=
 =?utf-8?B?dFFtQVhDTkVUMFVQczlrTytnRVRtOVhKd25ydVcwOFl0TTJJQXU2QkJrc0JK?=
 =?utf-8?B?M1JVWWZ3SGYwNTFscUZ3NjZrRG5lTDc5UE44R3Q1NUlkSVBzMGM5OXljdS9B?=
 =?utf-8?B?Q0hhSU1leGg0K1VRNHgwd0pJRG1vVktIVmRTNktFQjYvV2g4Ym5HdERGcXJv?=
 =?utf-8?B?OGVvMUJ3MUFVNU1xQWlaSCt0S3l1RXpXUy9CbEFUb0Q4M2liYjh1SDl6MDZa?=
 =?utf-8?B?NzdXSndsNWgyMU53ZVlaOUJXekI0bWtqSXkrN25xVUplNDZNblg3N2Qva2RV?=
 =?utf-8?B?eXN2bDQwOWtnU25nL3ZIRnhKWUYrOEVaN2I4MUxDbnFWQnZ4TWNtc3daNTRI?=
 =?utf-8?B?OU5iRlVqdEc5YTdjbkRFQ2RPbTBUR1llYTZERG5TUjVTSzV1T0ZMMDdwSkQ2?=
 =?utf-8?B?QlZSMEZWOWt4ZGZOSEtYd0lhUEI5cEFlL3pzSWttSkdVcjgvMklZYU9wbEVz?=
 =?utf-8?B?YzVhSmU2dS9IV2VKYTFaMWt2TnVnc0lQeVdxRm83bW9oUmlwVk1YNmtjQUFE?=
 =?utf-8?B?UFkxM1puNVpodjY2VWwxWXM1RDdyd0hzclo0ZnZYSGs0Q1pVRG1FbFJtbXNx?=
 =?utf-8?B?dEkyWHpZZFBQbW1oYk9iSFk5QnExR3VTR0wrK1RJQktXVFpOV1NEdTVMU1Qy?=
 =?utf-8?B?V3FUTGo2emFaSG5JdFYrNjY0NHR2cm1WMFBCdVQra2FJc2xYTUowcHk4TkJy?=
 =?utf-8?B?UU1ZT04rcjhTU1QzR3hacFZSWnU0WWxtNnNRV2VLOUliN0YzRHJMYUlzTFIr?=
 =?utf-8?B?NUhFU3BuWE9RRDRkMnBBeDhJNEhLOFhOMmhmNWlJQXlla2ZZeTNJYm9QYVBH?=
 =?utf-8?B?eDJWSHVJRHBCMFBiaytrZlhuOVVDNE45VlA4Y0RzNEFwaDMxMW5CMU83WG1n?=
 =?utf-8?B?Qy9QSnFhTzh1eUx3bE5JM1gvR28ra01QOVo0ZTIyVGwySmxWSWtQVndxeEVL?=
 =?utf-8?B?WWFvODhWcWI2ZXlaY3h3OFk0YUZ6RnB3UTM3NWFpVStFVjJFbExQUjZQWGNz?=
 =?utf-8?B?aU5qeHI0aUZxdmxTaW03U29yQm1zNjNGRlpQbGtXeCs1N041cG00TkRHTlpG?=
 =?utf-8?B?RWlLMW5zc3NmOVVyL1dxdnd0ZHBTNVViVnZYeG5JODRkYWhkSDQvb1BHVlRM?=
 =?utf-8?B?cHFQa092b0F5SWdteWRBcXFJNU5PdjZDVjUvc2NGTkY2eUZnN0VRUVZPZzVS?=
 =?utf-8?B?K0VGNUl2azlUclZtN0NmT3ozSWhYM000Yk15TWhHUmJxb3FkZXIvd3pNWnN6?=
 =?utf-8?B?SVFKYU1IVTVvT3YyM0thbFlSSnlIeXZYWHNBcmJTNTE5U3RvZVJ4ZDdiWkVm?=
 =?utf-8?B?dzhXZzdrNmZYeHQ4RDBkd1ZZbENFVHd6Y0VjWU1FVzg3RkNkcnc2ODVQOFJu?=
 =?utf-8?B?cExCc0VJb1N4eTRvSDlrMmhWSEJZVHYzWjlqWjNrYWpEUGF6VDhxUmJRODdG?=
 =?utf-8?B?emlKY3NrQnhISUtDajRMaTI3Z2Z2NUM5QnB4Vm1VaEtRYVVYMzltUHdLSEVj?=
 =?utf-8?B?Ky9QUGI5czc1dFAvaERMd1d4MmpUZDdyVjRESWtPRVdtUHUwVU9BTjE5REZ1?=
 =?utf-8?B?aXZzOWVSV3BGM2FVLzNNcC9BbndILzd2aTU1R21XMmNvOTFIOUdqU1o4TUdC?=
 =?utf-8?B?azV4NlErVndiTEIxVDl4Mit4VG5jeFZhT2sxd0F2WmdDT2dkeHZ0M09WWXNa?=
 =?utf-8?B?N2pXUjJrVGlqMVZtOUtDb2Myelh5WVhBb1ROc29jQ0VrRktGT29kQld3bTdQ?=
 =?utf-8?B?ODM5MkZpaVhPY0VEZ203d29KcEoxU0FtcEFaa3JYYm5FWFdNQWN0YXUvQjdt?=
 =?utf-8?B?dzU2UWViOGZJOFRXME5mNTNrRWxqeVFLOXU2QXF4cEpzVGtZcC9OT1ZlSktQ?=
 =?utf-8?B?bmlQVFhyU1JGaFRvdVFPV3VJdm5uTC9rdGE2aTNTTXE1bzV6cmdEVHh4NGJ2?=
 =?utf-8?B?UlcxQTFWcFVLSnNZZ3Ivd2J1ZnE2Mk4vR25aRmFHejJPSDBCbUpzeTJha1hO?=
 =?utf-8?B?NFNBTVdDZktteXRwWG1HcGlqN0VXcUlraVRpTklYalROakxQUGZTRHVtc1ZC?=
 =?utf-8?Q?SlDBo2XwPnxtG431s8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc4d5cc-855d-4a97-8b2d-08df1ed68c67
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:38:13.8520
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tez7SxbcemiVxprKoOeYJsdGARvXjO4bWNSXV/hm4DqZdpQI25iTfLe+gMoFBcYKmwiTRVnlP75t8qjAHYMvgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7133

Mario,

On 9/29/2026 7:04 AM, Mario Limonciello (AMD) wrote:
> PerfOpt is only a feature usable by integrated GPUs and only in identity
> mode.  Instead of leaving a policy knob in amdgpu, just turn it on when
> an integrated GPU is in identity.
> 
> This drops quite a bit of compatibility glue.  There was a refcounting
> system, exported symbols, and device attach/detach logic.  By just setting
> it immediately it's a lot more straightforward.
> 
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
> ---
> v2:
>  * Move WARN_ON to amd_iommu_perfopt_clear()
>  * Make amd_iommu_perfopt_clear() void
>  * Drop unnecessary cleanup/create paths that unset feature
>  * Enable the feature in IOMMU if supported (per guidance in IVRS spec)
>  * Use existing check_feature() helper instead
> ---


.../...

> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index c9b28e5e582ea..a1adb40d5b79d 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2345,6 +2345,35 @@ static void pdom_detach_iommu(struct amd_iommu *iommu,
>  	spin_unlock_irqrestore(&pdom->lock, flags);
>  }
>  
> +/*
> + * Program or clear the per-IOMMU PerfOpt enable bit
> + * This allows a privileged internal GPU to be able to bypass IOMMU when
> + * in identity mode.
> + */
> +int amd_iommu_perfopt_set(struct amd_iommu *iommu, bool enable)

Please move this to init.c file

> +{
> +	u32 old, val, readback;
> +
> +	if (!check_feature(FEATURE_PERF_OPT))
> +		return enable ? -ENODEV : 0;
> +
> +	old = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
> +	if (old == U32_MAX)
> +		return -EIO;
> +
> +	val = enable ? old | PERF_OPT_EN : old & ~PERF_OPT_EN;
> +	if (val != old)
> +		writel(val, iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
> +	readback = readl(iommu->mmio_base + MMIO_PERF_OPT_OFFSET);
> +	if (readback == U32_MAX ||
> +	    (readback & PERF_OPT_EN) != (val & PERF_OPT_EN)) {
> +		dev_err(iommu->iommu.dev, "Failed to set PerfOpt to %d\n", enable);
> +		return -EIO;
> +	}
> +

May be check return value before enabling dev_data->perfopt?

-Vasant
