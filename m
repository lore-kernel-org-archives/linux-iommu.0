Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012038.outbound.protection.outlook.com [40.107.200.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590F73A5E94
	for <iommu@lists.linux.dev>; Mon, 20 Jul 2026 10:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541727; cv=fail; b=DHz/vThHxlR2PIFl7XmWXLoEnd+j5TfetXGoejfS/Yf3RZEq5tOHlU15Pk85sQjQQcg19W4RMt2Rm1ewU9y0s8Nr3SYTIF3QvKue3l1t4u8g/WzUWiahcTN+Oq8fthkQmBYJkYDwMl0ZGgaQMPSwEOQuJatCZuC5/CKZgjgfLwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541727; c=relaxed/simple;
	bh=6ImDvTYIMcKPEZb/JJla2SbctNpjKgqHNIdxtzUThvQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gKRBO/2+J9r+2gJr6+vGgdIKTrK+E7ZY3CJTubcdxwHZ1UDdOKrP9sgIPICEbD2yU/iGPhzSGsbwuS/xbzvNN68Rm4Q5B/ozIfeM+ZpGTlhlHThOEIuTBHZEbtGnZKcyODHCSgcCSDrdjDoMuGz25YCyyuzsOUEhqUPpCWvYyZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3A2cgZTl; arc=fail smtp.client-ip=40.107.200.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3A2cgZTl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQ1BOJz99KNlpLf+Jb1nWw3viMNdduKDfXgCH6Sf6FNkLMAJIlTzBRteOddYNV1YCRIiqAez3WxDD/cNGS+kY4TOUIsrQLYNcUsDgpnp73FtpBSFrhFuRMHLTF+QxYA0vt9uzuXab1xPTlxYEmI8FVPRalK+qh1qgvgSxVz0iZ8l9/q9q1ws7jl6bHXhkAn0e8p8Q0UM5jJXEGt/D0bIA8SjK+jkB7+f1+I1R+82vvAM/N9hO1H9YNL0C0Aa8Q9AwLo2s6AQAX0Ioc53/iq2ABxGmyM6YDbnpmA2KO6ZMFb4PJkSces4LHlAUOonulmPolzfxjoopu2B7h/tgkkoBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ce235iqiOzRP+e1mLFN5sDiupdnKtv5ZJNipZBl3CJM=;
 b=RhN90/A44nbynIxUPS+53n7yAIy3cOAhW/OpasnnCpD22gKrvJHZp5/YXPekWFJdnBMpzQaTox7Xzq16h6iWYF5rmIZsiCckTX4seh/c87Xt7RtqicdXLSynVzEceIOsfGNwM1NCg1oxJLihHIxvw9qS+qNSh0/rnPk1dZbRu2LmGFZwJ0pqWuyYOSL1hC92xB/SrryoS/u2iHS5NH2dyQmUQJUoX0WwDr0VIz3dTQ0e7EeZk6NrOaOFl26so+xLMMK4KVluksad1wXXGaZjK1NfMJspRHYsvG/FZ4+BoiVKIgJSx6Yr6+iZZp7ydKikp2fknOqceTZasLv6qC0AzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ce235iqiOzRP+e1mLFN5sDiupdnKtv5ZJNipZBl3CJM=;
 b=3A2cgZTlZ7S4fZDBpDMVd+5ofNSbNTaoEneshX/gxtv0wHDuVnF9kRUkmFrrT//iURlkUj4WYFegoCQzBwssvU3TPW7i9zGrCDX4s3ET0rOUTzRqT8QKnf2X6lL8IP1g3Zxf5qFw4pNNK/R3xa8TyYNvCUkB/lxz2dBtauK+veQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by DM4PR12MB7575.namprd12.prod.outlook.com (2603:10b6:8:10d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 10:02:02 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0223.013; Mon, 20 Jul 2026
 10:02:02 +0000
Message-ID: <dad0efa4-1422-4178-ad57-82a6ff91db79@amd.com>
Date: Mon, 20 Jul 2026 17:01:56 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] iommu/amd: IVMD handling cleanup and ivmd= boot
 override
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 vasant.hegde@amd.com
Cc: jon.grimm@amd.com, frank.gorishek@amd.com, thomas.lendacky@amd.com,
 santosh.shukla@amd.com
References: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260424092213.16976-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR01CA0014.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::10) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|DM4PR12MB7575:EE_
X-MS-Office365-Filtering-Correlation-Id: 198dd457-e2a8-4ac7-4784-08dee645f206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|18002099003|22082099003|3023799007|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	X+zPBHRRPbWuFE3+Y8usiZEbWNGVRZtERqhgcqtKt24HDHIIpCXbg/oLflhjTLOdmnkbKyiiPDvGhKsalyK7Bzs9vNOQ2FUdc/3OnWgLbLsidrlG8GyT3U8geMuBVfkxsR73ArUsjsXwC38rOn4nYh/3KqKuAfY+fBy/sSeitZT7qRpFBNmI1BHFICiSHAw27fPYBCD2SHv2tpdIyBGJU7KdLHjkt2sW0gW4iSCC2lPG2lrE0HNpgex+aQPIUwkyEjbcx5CB6dlcCcdPxADT8XGP26slneFYa2tNCJYLrKRwii5dF/V3Z9DRYkAE5Ib7YT7fTBp7n4YYEZQAptM9vnIn9Ygk8+3sybQ06LfiOQUb3W3M4XhGOP27WeqSykOKPIpoyd8JJv44MJkQ4XJkYFJakgBjNAjuL/Ut+7WQyjhWVRWAdv4Px7g+YhCTjEqgTl/6CSeNYGa6P7aXTU/jbkAGMWBJbcl6xEwYc44upEzYWRp9LbDWOztkN1qWus5P/bsMY+Ee1RwnCeGeoiz32wRbgJ7lZoIZOhCgDAlD8QaxD1Ys2nSxQR2fsvwPD6mbCJ6c6v4zGUenEg62nYGOSor8YnkF6Wz8GqChcAR+Hz37GC5NdM9OEnM+T71UCnOsgeGBD7/FtpOmhqSKm6o/z/V48JbaeM5VvVcLBV3dGWk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkFRbVlYTVBETXdCUEdIbUVUbkloYmZ5Y25NUTZYNnpHVytucWo3NW1BM0p3?=
 =?utf-8?B?ZmxES0Era3liUi9qUkIzZTkrN1JtNitsSjZYcGZ3VWRsLzdYbVlEZnR0blFt?=
 =?utf-8?B?dER1QTE4NHY4ZGs5MXhoSzZKYUE4bGI2cHpBYVdwT01ZNk9tdU1TK2pXd3Bx?=
 =?utf-8?B?TCtzRzNtekxqTHlnMnBnb0k5SXlSM1hNUHhDR3ptZDFYMnJFNWVYMENBaXIw?=
 =?utf-8?B?dGJiMmY5aFc4aXdFTVZ1bUY2cUxKOVByY1MwcEplQlVnNVV2MG5NaEV3b1V1?=
 =?utf-8?B?aEgvU0dwZFZsWHFHMExqcFQ1ZU1aa0diS0lEUnluTzllM1NCN1BDUnYxMTEz?=
 =?utf-8?B?RWk1R3VwT2E0SW91eGpqazkrY3FkM3V4Umx4VmxycTg2K2krSURFaGNQTEcz?=
 =?utf-8?B?WHNCVVVMVzFaaFA5ZEt6TTNEVy9pUzczMEc2Y3cwWFNJSWduNnNOTkF6SkF6?=
 =?utf-8?B?NlJhcGNrYjdDUVZGT1hFc3RLUlgxRVhUYnc1RGVXZHYzRkFJWjhZM1ZLRU95?=
 =?utf-8?B?TThZOEJaVjk3MFJBbVc3SFVWUVc4a3VSVzVWMWZkekxjZnQ2RUpEWlRyTFpW?=
 =?utf-8?B?V0lHT3h0Ym11Z21IWWQrVTd2eUw5RzBFek5PRWRmRUcwWmtmMjZsOUtoaUNE?=
 =?utf-8?B?MkdQbWNwdHpPdkdhMkRSQ3dFeDZtM1hwb1doVm1IamF6Y0cwRjRtckJlbERK?=
 =?utf-8?B?LzcyWHBYZnhQTlRsQ1lCVDhtYnZyamdDb0RlcEFnOEphanBjV2RuQTZmOHlE?=
 =?utf-8?B?WTNRNUJxQVJCN0Yyd3hjSEFqS1ZYT1lxWUJWMElWNit3MmpTS093MURxejk1?=
 =?utf-8?B?Q2w0OFNiTlBwRVcrcjU4YjV6UWpoVk9sZjczRG1CSnZVUWIxY1AvL0Q2R1Zm?=
 =?utf-8?B?L2FoQWs5VE9WREY3TXlBdnJiMExmcTJISXRZNnZ6MS9EeWEySk5NTUlSSTIw?=
 =?utf-8?B?aC9ObnlzcjBRalEzQVBmZ3hndkpzZ3htYXM3QXRDZDh3N3E3MmRnVWM1RHNI?=
 =?utf-8?B?d3hqRllrTUZpZVZoNFp4czBQTGxmWU5yRElTdnN3TGtNYUgwUFpWYmN4R3FL?=
 =?utf-8?B?MUJWRTZxSEUzU0F4MVR5UTc0bm1KTmZtM1hUM2RGTVgwWjRyaUt4TE1qOFA4?=
 =?utf-8?B?ZXBFU2hsMUU3NlJHRjZTd1FuYlBSV2VJY3ZDbjZETjFTemZGK2E3d0pGVDIv?=
 =?utf-8?B?ajNZQ0d5RkFaeElpU1FrOGM5WnQwRC9SeEVYS1MweHM2S1RvRHpWYTkxK3FO?=
 =?utf-8?B?QUJLKys2QjdPNnltbWpwTTkySWlrZTRXZ25UL3BQMEF4UkYwUGpNZ29uYVkv?=
 =?utf-8?B?TElXMExqaHppazlOc1hrR2Rua1Z2MDJuZzJZQTRaT3hWUGxYRFNFWkJ1UE5x?=
 =?utf-8?B?YnUyUmpmYkQ2RUwrcHBmUitObm0wSzFhSENCTmltREJGc3dkZjRaOVJlZmNq?=
 =?utf-8?B?RzFkVjFqN3lhQlpmZWhsY1hSUFdGZUxtZUc3a082NUcyTXhTd3RERW9iSVkx?=
 =?utf-8?B?UDdCdmZPbFIvQ2VhTWZ5ejRVelBrOXJJSVd5YzVvSkNaOVFrOUJRYVZic0Zy?=
 =?utf-8?B?eURKQXo4S3FuOURzUXhjVTFUdGUybjdaR21pajM5MGtJN3RBMlpNTUxYa0lV?=
 =?utf-8?B?RkQ5bmEraXk3VGd2blBpZjU2Qkd5Um5vWmdBUUx0aDlJaW1ITmNRa0VYZFBE?=
 =?utf-8?B?T1RNS212MkZlaWEreGJVZGRBc21Wblg1VU5jY0dzUlgycW9KMWN3TUpXbUg0?=
 =?utf-8?B?WFozeGRzcGtYQ3E2aTRRVGIvK2lhNFo2WkFiOUtvTmpkZ0x1N0pKOHNqMFFI?=
 =?utf-8?B?M2UxOUUwZEZIYlRmUUw4NnEwc0pVOTIvU3Z4S0VlTTgzWEtid24zK0V6SlZj?=
 =?utf-8?B?TnVSMmJrR3JIdVVKV2xGYmZBZnJiZ1pMQlIyRTNjZnA3MmVWY3Y1OW53TlR2?=
 =?utf-8?B?dEV2VzdSWUg5M2VXRmYwalZzdlJxQjJ1OTVrS0FSUG8yTEYzOW1ETWg3Q2No?=
 =?utf-8?B?a3RkNmlGOVBvUjRmVWIycXpycjBxTWczaU5sb1JIYkU5U1NBdVl2aUhKNjZi?=
 =?utf-8?B?NlFUNENFMDlBVDh3NGhUUmRqaWpFT2NJYWFVRTBQRWl0NGpGT3llQThPbVdx?=
 =?utf-8?B?WE5KMFhkTHlCRG15dUJuSVNYUDYzSCtKdU51SGRJWko0UzhxVmlZcHMxTmlu?=
 =?utf-8?B?MVdIcnVPQTVYZm94ZXFkRUErcDVRaDd5ZjBwRElOUUUzU3BDNVRKU2diaDRs?=
 =?utf-8?B?RHIyTVU4WHllMCtRT1NvQVpFaThtWWEzWnQrUzVENW5HcWNzMTNLYVhuUWl1?=
 =?utf-8?Q?Mspa+SNta6/fhY3DhB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198dd457-e2a8-4ac7-4784-08dee645f206
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 10:02:02.1916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ni/NO8WNZNQ8UinH3NOk2a4tDnPdV58BATONEj30VdLIQGOEZytbkjTcdnSlElZqJm6jVanG0FheDlHAI5l2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7575

Hi All,

Are there any other concerns on this series?

Thanks
Suravee

On 4/24/2026 4:22 PM, Suravee Suthikulpanit wrote:
> This series refreshes how the AMD IOMMU driver models IVRS IVMD entries
> after the hardware exclusion range registers were repurposed.
> 
> The first patch renames the associated MMIO offsets to reflect completion-wait
> store base/limit.
> 
> The second patch drops the workaround that forced IVMD exclusion ranges to
> r/w unity mappings; the driver no longer programs exclusion range
> registers, so that the workaround is obsolete.
> 
> The third patch centralizes IVMD flag definitions, renames the unity-map
> structures to ivmd_entry, stores the raw IVMD flags byte from ACPI, and
> derives IOMMU reserved regions (including exclusion as IOMMU_RESV_RESERVED)
> from those flags.
> 
> The fourth patch adds an ivmd= kernel parameter so up to four per-device
> IVMD-style ranges can be supplied from the command line when the IVRS
> table is wrong or incomplete, documented in kernel-parameters.txt.
> 
> Change from v1:
> (https://lore.kernel.org/linux-iommu/20260420170033.6780-1-suravee.suthikulpanit@amd.com/)
> 
> * Rebase on top of patch "[PATCH] iommu/amd: Remove dead code for exclusion ranges in IVMD"
>    that was submitted by Yu Zhang <zhangyu1@linux.microsoft.com>.
>    (https://lore.kernel.org/all/20260331152550.479841-1-zhangyu1@linux.microsoft.com/)
> 
> * Patch 1: Modified to only rename the marco.
> 
> * Patch 3: Reintroduce logic to parse IVMD exclusion flag to allow
>    reserve region of type IOMMU_RESV_RESERVED.
> 
> * Patch 4:
>    - Update the sscan function to scan start, length, flags in hex format only.
>    - Fix apply_ivmd_cmdline_entries() to not free the cmd, which points to
>      the early_ivmd_cmdline_map[]  on failure path.
> 
> Thanks,
> Suravee
> 
> Suravee Suthikulpanit (4):
>    iommu/amd: Drop unused global exclusion range fields and init
>    iommu/amd: Do not convert IVMD exclusion range to unity range
>    iommu/amd: Clean up and simplify IVMD entry handling
>    iommu/amd: Introduce boot option ivmd=seg:bus:dev.fun,start,size,flags
> 
>   .../admin-guide/kernel-parameters.txt         |  16 ++
>   drivers/iommu/amd/amd_iommu_types.h           |  36 ++--
>   drivers/iommu/amd/init.c                      | 159 ++++++++++++++----
>   drivers/iommu/amd/iommu.c                     |  27 ++-
>   4 files changed, 187 insertions(+), 51 deletions(-)
> 

