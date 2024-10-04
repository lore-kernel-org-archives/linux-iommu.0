Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE5F15C130
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052236; cv=fail; b=is6YeD6FYyUAZDEc1AcMUMscpj4SBhcYxsSzN44vrWeb96kYEieZWSqpz2Cfwym2oxtRnshBrMSw0kjK/w3RwlO5J8XvezYvR0U1Px8ooBAb3qO8SydMBqub6FwY5CCaAx/4+FjpHHX4inlAegRpfSTEJYYH4wbeTcdFC1lAUbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052236; c=relaxed/simple;
	bh=B5ZEGWDGJMVTa3Hdz3xIs4ERBqx0A+5SIzI9cF3oNBQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YY8T6bBp4YunlAlk6rONeNo/PalxmDpzEc/9vWKYTpC3phDT347zyd/+zlcYZ1YHcVYIvUCHvAhUiXzU9JGAU7Lsj9ApoTvR/2vfGE0o/dbAM+4Bi5/JHYQlHTjUU9tBVjrQCpuZNSaM/hAkcMY+4ZjIiaYmJjCnoZyED+DP5xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2zK4HeaH; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2zK4HeaH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LFf05atDXw8VM6+2JBpnfz2ZmgXOf4OYq1a8kKIYpImUv9t862ZWbrcZqYmULz4ryOqQp3HmLlQUQPi+LhKAGHH1BcEf6Ill3Ozxh3/q4lB91po5FxZyzqD3dbflInxMFRcG+2/RV9tGhC+SyAGsJBlmUfpK7K+4k7wLsjodC85vVblMbr0eYz+BmSlK0Ic90BT9CkTX+/HSQTKnINGLiIJls+d0Rqyq+TKQpIpDmLQX3mjNDjCVjynl8f5NjlV2w2S7eDc5FIy4MRXVSbmzqopPT2k48AzXrtNSdK8EOJLTBvxzXPIprGu03lN63V/z1wNL0/++oNzW1kT6Y+mn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=euWQ6hgP90WRcUgpNtp6cOhNcF567mvSBZAKDHO7cqM=;
 b=x3UVOvmhQcz7OFggOgI5npEC1K3X6OaL57bkrW96xdOpWks5cOIYSZXddmJ0SD+PxgSs1EuSey37SX1ofOk+Ig3or2PubAQVF2KUgtdX1n1y2aUcSwoxy3OtpuzEt/tNzAGCP/CjwGJ3HngfU6EFFHRIu4NzriluV9K2VQWy+EETgWXIGMgtZ9EqH+UA0wNnZXFmGH3fVZ92g27ptZE9w8ehDCdhq8o+pIx/64RV/KwmF8Kglu52D7raK2nG58YgdXnyrVo43H1rqsjrNve9G2+3T//2vv9N3ZZ3qdsVo9kRv0oX+vZfb2/h+gAo4au1bT9kWz3X64C3ztuOqEceZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=euWQ6hgP90WRcUgpNtp6cOhNcF567mvSBZAKDHO7cqM=;
 b=2zK4HeaH9W/QNTp7rZAtWJxefFgVFo8boO4aWNlIBLvCTjW95GHR1EfoYVrufOoJsFh2xEeK3QjLzE1WPFbmljY+cl9tOPdMYWSI64nTMGIzQFxOev7okmmKllYTTahlcHm74FRaSLzMMgKfRB2mZ8NYdCYEcxtMoGjPBAv9P50=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 14:30:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 14:30:24 +0000
Message-ID: <a604541d-6de5-49f4-a8c2-190e68356acf@amd.com>
Date: Fri, 4 Oct 2024 20:00:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] iommu/amd: Add iommu_ops->domain_alloc_paging
 support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-8-vasant.hegde@amd.com>
 <20241002193345.GR1369530@ziepe.ca>
 <1f6110a2-a21d-45e9-bfcb-7d3650ff889d@amd.com>
 <20241004125606.GH2456194@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241004125606.GH2456194@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 79aa0dde-6735-46ef-4736-08dce48115b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXg0ZUNYN2JQTWY4bEVFbGpwUFh4RkVndXk5Sk5oVVJOUjdlZDZxbXg2UHps?=
 =?utf-8?B?K2hiZURZeHFMd2Q5WG91cFVjS1ZrTjRSaEhCQzdQR0VGUThpMmJrTmphbkRV?=
 =?utf-8?B?bmVucHRaMEVraStkM1ZTNVpWMTRHMnIrKzJ4Rk4vNTdxb2VaZ2lGS2RmU01n?=
 =?utf-8?B?dW82dFhuWUQ5dHg4SG9YZXR6YkVnZ2VkVHBCNjd6ZVR1a1dacm1rYXBkYURo?=
 =?utf-8?B?N3JYV0o3TEp0UjIwRDNGNmo3VzlieUtwRmdweUdMd1djK0FvQnVDMkRraEZn?=
 =?utf-8?B?Y2UyeDhiR1EwclBFN0xqd3Bpd0ZPRUxnMC9LZWpNRkdUTmZkZUlxVzRUYjZs?=
 =?utf-8?B?bUhOeXZXTE5kM1N1NVBraVNuYloyVnc2SzRNVXVxQnRzMVN6bUZFNGhBcGlk?=
 =?utf-8?B?bEdMeEZQWkVCSVJJeG5oUVRNRXU0ZElWSVlOcEhIYzhpR3N5RDRnekllcEhV?=
 =?utf-8?B?aGMrWjN4YnlRbDBkcWlGM3g4K2kyY21XYWMyTVVrRTErNFR2djB6RUVnVytq?=
 =?utf-8?B?cDhjWFd6ck1GME53SksrTTVBTWkxVVFXQnM1S2d4aGl2TS9KTmNGOGxzU3Qv?=
 =?utf-8?B?ZXZJZEZYQmxhdWlCNlNDN21adElxaCtpWUlXQklMZHhuVGlnSlRPLzF6ZC9a?=
 =?utf-8?B?UTBGZFRPcHdUN2Y3ZU5HQkZWamlpV3R6WnBRdmFJSmNHcWlaODhqNElEc0xM?=
 =?utf-8?B?ZU14UEp3eGVYK1lOdk5HclpSdUg3M2tCenRtb0NwMXRtOTlKc2d0TlVjdHlV?=
 =?utf-8?B?SVc0NXJJSnQ0blpqU1ExRkhQWW40ekVzRjlIdlJjWFJqRmdGU3V0akg3RC80?=
 =?utf-8?B?b2pLUVFhWE9EMnR2cGNxTGZRSnVPUWdaSTRoZGowMG1kczZVRlV2cVcrQzRS?=
 =?utf-8?B?Mm5qSkFpc1p3WldnOTlDQTZxUWhyTEVZQVUrTHdNTHduSkRCbmZ6Kytubjk3?=
 =?utf-8?B?akRNR2YxSlRoS2hwZERKcUQzUGc5T1NLOEJrNFZGNnh1Y3BqbGlBZmRuUytH?=
 =?utf-8?B?ajlpVHgvZXU2TFFGMVpCdHZaRS81dGNLNXJ1NG05RmJzK3VEa3g5M3h2ZXRj?=
 =?utf-8?B?OTZHdVNQdVBiK2pDTVVWdVgyVE9pVTByNDc1dVRlekJqTkxsUkozTzB1c3k5?=
 =?utf-8?B?NEM4MC9QZ0lLcDVMWGdjaEZ5bzhNNExtUWxzbVhURjV3L3l5L0x4QXM5V1RZ?=
 =?utf-8?B?eHVRSzZUeU8wenBsUktYNXd5NTM4ajZTYzRUdDVGVzZCQkFtNk1ZdWpoNUFv?=
 =?utf-8?B?bE5aODZ6dWdlM3FmeWdYTk5UTkdjZ2thWTdrRGFJTFJ5akx1dzc4M3d5cDJj?=
 =?utf-8?B?RHB2YWswMnhjZEJDRytMelVWUWx6bitaeE5Ic281NFN6dm1uaXJPWGl4VnV2?=
 =?utf-8?B?SmVzVzc4aVpUNUIzd1QrWXBqVFE2b1ZHM0xEMSt6V0xvQjY3alg3Mnd1N1pJ?=
 =?utf-8?B?RzhKMFZTUGZhcU0xQjM1Nk1EV3hYWW5tTW5oaDlIM2EwYWhhQkRzbGJLSEZi?=
 =?utf-8?B?SGZ2cFBLL29nbkl3RjlVbHF2dEZGMFFmZnZlc21uRDlMTzBpREJFSXh5ZDE4?=
 =?utf-8?B?MVgvWStyd2k5NWdOVDR3K1ZZSFpCYld2enBib3M3Z3ZqVnRhTHNNREw1N0xF?=
 =?utf-8?B?UE9lb1hLOXRHRlc0Yk5FSTlZSU8zeE1vWUp3V1VSUWgwTy9YV3VYMURZMStm?=
 =?utf-8?B?RDY0TEd6Tk84VE9XWGdHMy9uUFFrdzlETXo0N3dxVkJtbktEVU8yMzVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmdsZmJSR2VEdUFkK3FtOHIyRmtNZ0toZDkzOWM0V2V0SXJrS01LZzVoKys2?=
 =?utf-8?B?NUFwaEdPYmpVblRlS0NlVU5qcTVEMzlGTXFEcDQ3ZThPL0ExT2h0dncxRVBQ?=
 =?utf-8?B?aGtrUm5xZ2FFVytMU1JUSVl0TkdQMXd5a0pIbnBSaWxxcHB3OFFKNzQzOXhk?=
 =?utf-8?B?cEhxUG4yTjNNOWdJQzlpaE5yVUd2WWx5VkZSeUdJb2MwQ3Fqcit2dVpCa2N1?=
 =?utf-8?B?aktWZVpzYW5GNE1CeU1qNzZSZ2FRUVQvd05rbUY4ckdmN3ZlOW00cnc3b3dP?=
 =?utf-8?B?ak81Y2NsNUI3TC9OYmNtSjVhZjNZK2hienhCWm1yWndUaDRxUzdTd1lucXpj?=
 =?utf-8?B?OWdZQnh1QURLVG5xYzQ3M1JWMzZCSWJKdSttYW5pZzZGbXhRdFVpT3JtaTNL?=
 =?utf-8?B?aVliOFBteFdvR0pMa0o5RCtoY3hkS2JuZXVxQzR0dnZRS3NaMUtTL3R6QmpJ?=
 =?utf-8?B?aE5wcDY1VWd0b0pBaEUyN3Y5Yy9RdkxOTHc4M0oreDFLLzNWWXhvZzZUTDdw?=
 =?utf-8?B?QjZrcDd0UHBubjlOS282bmFnZ2Juc3V1TjNzWWh4UHpia3lGbWo1YTdtYXhK?=
 =?utf-8?B?bHIvZXNDZmc4cFZYelZFUjBIVzV3QUVzNCtVck5pelRjSnhKOVJxVVRFMmZh?=
 =?utf-8?B?NlRsTTNXanVlR1NwOWFRa2ljOThyNS9LRlNvc2h1NVJ6QkNsUHBJTEhiY1Uw?=
 =?utf-8?B?MW9SR3BDQVZqaWs0MGFCMGUyTURsNmxJZkxQQXZSL0V1Q053NFVUU2h1UGFF?=
 =?utf-8?B?cDlLYnVGZmF5U0hzWTRKWWN3anRMeEI1Z3VmcVZqSnQ0TUVOYnIvZ2pOZnMz?=
 =?utf-8?B?Q2RmMkdrT3BUblVxSHFRS0xzOXNKdHRWUHNjVGtsRlhzb3JnQ0FJd2FtSFdY?=
 =?utf-8?B?NjlXT090dUpQZkt6LzBSTy9jWE50Q2huZVpqS05lYTVhc1RPNnNyZ3lPeDB1?=
 =?utf-8?B?RGJRZ2pSekx6L040ZWlTSWIwT0JXczhiMXZpOEVGb2hoKzBESzZjQWlpUXk4?=
 =?utf-8?B?eUZEdWU0aUFOZXR4dHFNd2FaM3BzUkdxUVY2N0xrbzVQU2MzZWFNYlR1bStE?=
 =?utf-8?B?U21YVFRJQUVBQTlraWdrVW9oWFpycVB3bkw3L1hia085K0ltUDFLR1hxM2JC?=
 =?utf-8?B?amd5ZnFGUXBET0EwWHVzbjB0Ykdvc3JDdTRoenpqY0l5bFYvQ2xTNXFZeDQ2?=
 =?utf-8?B?ZEV4dHBCMm1MQmZaOEVFL3pUVlR0TThQYStOa0x3ZmJXREZRbXhzeGVLb005?=
 =?utf-8?B?aERYNnhvc0d4MThpc1RkTXpIMUx5a1F3QktaUEw3MWprV0FtajJncEUybjhp?=
 =?utf-8?B?VkN5YnowbjI1ME9TdGpiekpBRDB6UXZlRUFDMzlzZkllZTJsdDBEYjVmNE8w?=
 =?utf-8?B?ZFBkTzd2T00yZTVJMWNYdGlLeTR5RVA5Sk96eWM1b1NXVHdVN3RpanBYNENl?=
 =?utf-8?B?ekg0L1FXcm9MTWh5YTU5NHZhNlRHVzgrcFY1REJYRm1SRFJhcStHUzhEdW9C?=
 =?utf-8?B?cURzeTRoeDlnSCtwRDJCNXFkbGRyUjhMSG52UE9QaW9DR09EUDhNTGF6NGwv?=
 =?utf-8?B?ck9KUmFSa2dZMVUzNDdFYjJjWmc0TUVWSysycHM3UCsrVUQ2bk5JOVllejlo?=
 =?utf-8?B?VUN4dEduTHFlZnpZRGU5WnRIOUlPQ3JKYjRHRG5JL2ZHUUlzRjhWUjduNGRY?=
 =?utf-8?B?SHFPcmZZV2lEdzJDWUh3dlJKMXp3K0lRQTR6UDFGTElzUkFmTENUYjA4QVRu?=
 =?utf-8?B?azBFVGRob1lHVSswbGFvZ2xQWElXb09IZ0FycEE1a2JIT1h1NXF2VUxMRzQ0?=
 =?utf-8?B?S2gxcTA1bWh1eVBvS1U4dFVoVk1oZCtiUGwvYnV3M1hvb25tV1BYS3IzdDc4?=
 =?utf-8?B?MXNHdFRrZk8zbVY2dFdoTEdGeFNrWEszQkIrVXpHempNc2dEUFRwbWRFWHg4?=
 =?utf-8?B?V2ZGaXZXNUh1Ym1xZnBDeERLbWFtc1RnU2ZpRGV2N1ZGNWlPNHdWdE1OMFZD?=
 =?utf-8?B?VloraXViZ2VUSnMzVUpwNWtLa1YyR1dIaHduVitjV011QmRQakFSRlhGVlRP?=
 =?utf-8?B?emtoOThWRHRiSGdyTXJEWFRNODM2a0tReDh6c3FMNlRtUHlPRFRZdXNKa2FK?=
 =?utf-8?Q?JQnkuUl+d488ofu8jdIn6Bnai?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79aa0dde-6735-46ef-4736-08dce48115b1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 14:30:24.9237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hahE9BTavRfS1SVNvg+xGbQhQgwrkIdw5vI/2pbXIGNiUZpsfUXX9xKL/uMjytEF2ASy0hzlHNuRzxihmuawqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427

Jason,


On 10/4/2024 6:26 PM, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 05:25:20PM +0530, Vasant Hegde wrote:
> 
>>>> +/*
>>>> + * Allocate domain with default (amd_iommu_pgtable) page table type. Core will
>>>> + * call domain_alloc_user() interface to allocate PASID capable domain.
>>>> + */
>>>> +static struct iommu_domain *amd_iommu_domain_alloc_paging(struct device *dev)
>>>> +{
>>>> +	return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
>>>> +				     dev, 0, amd_iommu_pgtable);
>>>> +}
>>>
>>> I think you should avoid this. The _user one (aka extended) should
>>> handle everthing. It doesn't really make sense anyhow, as the legacy
>>> VFIO path is going to take this branch as it will have 0 flags.
>>
>> I should have been bit more clear in cover letter.
>>
>> I thought eventually we want to remove ops->domain_alloc() interface. Hence I
>> introduced domain_alloc_paging(). I didn't remove amd_iommu_domain_alloc() in
>> this series. I was planning to do it in later.
> 
> We do want to remove domain_alloc
> 
>> If we are fine to keep ops->domain_alloc() then I can just drop this patch.
> 
> But why not just remove it and not add amd_iommu_domain_alloc_paging ?

Because we have __iommu_domain_alloc() which calls domain_alloc_paging /
domain_alloc().

> 
> Your prior patch does this:
> 
> +	if (ops->domain_alloc_paging && !flags)
> +		domain = ops->domain_alloc_paging(dev);
> +	else if (ops->domain_alloc_user)
> +		domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
> +	else if (ops->domain_alloc && !flags)
> +		domain = ops->domain_alloc(IOMMU_DOMAIN_UNMANAGED);
> +	else
> +		return ERR_PTR(-EOPNOTSUPP);
> 
> So if !ops->domain_alloc_paging && ops->domain_alloc_user it calls
> ops->domain_alloc_user()
> 
> You just need ops->domain_alloc_user(flags == 0) to allocate the
> fasted/best page table with no-PASID support (ie v1 in most cases) and
> everything is fine.

This is fine. I can add it.

> 
> Don't add amd_iommu_domain_alloc_paging(), just add the above
> paragraph of logic to ops->domain_alloc_user()
> 
> The point of all this fixing was to stop using IOMMU_DOMAIN_DMA to
> select a page table format and instead rely on IOMMU_HWPT_ALLOC_PASID
> to make the selection. The core code and VFIO will set
> IOMMU_HWPT_ALLOC_PASID properly for what it wants to do. I expect the
> driver to rely on IOMMU_HWPT_ALLOC_PASID exclusively.

Sure. Will fix it. But as said above, we still need domain_alloc_paging() or
domain_alloc() interface.


-Vasant
