Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2040.outbound.protection.outlook.com [40.107.212.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1296CDBA
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 06:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729751945; cv=fail; b=B1uZLbOsmTTS009Kr7/X5EoOv1SH88Z2lGH0lHZacfXg52nzcTKKRBJDawQiXREVAwJNUuZKokYle7dajKCvRph9p2qd917ORdssJSn9MAqUzCh1Eve4/CE7fnq4KtTtHMq75ceRT88WpqSUtXylbHLqMIxkmHsjs+94NJXlRGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729751945; c=relaxed/simple;
	bh=2VV7ymHZZ+m2OEreWlREqovN1/IHPUrtU6Wl7vKm+vU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HBbwgVHwllsfLSA9fvWj5ybpPEl2vGx/ke5mDbgRPPD4hqrqG05FTDhHf5NQjUE1t2wr0CsC5+nTbgPhZsAffMM9w6WwsB1te/tYyqkwQZZ8dzukqZhqNKsaeutqHb6AZwqRsw6LketKYAUqGR+TmBrIIf9bzW0G/7L0x42wvSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vlr1zHkc; arc=fail smtp.client-ip=40.107.212.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vlr1zHkc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GqcBi2peW5M8p2DUCNzEIcOwOuw3Kbox63x6SitkcnuQfmogM3shQcOiiCgr0UQzf/oV0K2c88tzD8/QCKX82JqdEw3ERT0BpEsVLfvx+tIHz0YsxTYn/aVQhXlLF7K63aTDtoiKTRbtD1gpyATgi5Qf8my6WM6OKWxzr/VQwLdCXBuuwXAkDDYUX4pd3rdfWeQRzvyuYYDLzDO3UIRnQHv0kfvX/fkbXRXFPX8ZqHAg/5eEtbNRsNtGLZTY7aF1hsZEbm+O3QfmxHJ1d8AwRcAWJUKyrOXpZCcvMC3AkChVbYyI8SlrVwIO9AFX4hoENwDrGl2z8okT1Sb0t5jwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gO7v4l9IqS4J7sLeoDwVi10zBpnRzfWh3JZD7jyiRW8=;
 b=ZhBYcra5VVM4kDUfjrcbiG94pANkiQmtsGQBOY9/YZOTdB8f0/eEdVXFOiaE1fnwcwIHPqgEdXoV851A7LDtchCA20Tl89dkFZN88tnjsorGfiU0XpQ1OWBE40cXk2ogOLPDWBQ9Jrx4SvTPu0Q3vKH8ws454YjoTH072Rb5Qrtz+EutufDMXdl/0OIb5wIDfHsKO9PCx55pXS2hnfedWad0XZEATFOMF/+5FcQNsBaNMfTRW/bj/SbMslXd/Tfjo2DYlE2AO+Av1ko0TVAnh3CbLXfWybgZNm3M+yeLli/0q6L7Kzsz9MFdr+pWvToQCxx2//+r7LgrvgIdU5c1uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gO7v4l9IqS4J7sLeoDwVi10zBpnRzfWh3JZD7jyiRW8=;
 b=Vlr1zHkcAvVzNBWXJh5Xgl1K067I2xJbRifRhGrGtxafXkcRKhiC4zunkyjv2Zeu3qYFWg4bzb5bsZL5hTOPAJvD8Dami6nw+5bRyA0Liy2jfqYemzAE1a0B5hF0Qr4Yj/cUEkUksKij0/1U+3iXh5fDsrIoLkb3GmUkSLkWUYk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SJ2PR12MB9088.namprd12.prod.outlook.com (2603:10b6:a03:565::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.19; Thu, 24 Oct
 2024 06:38:58 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 06:38:58 +0000
Message-ID: <f5fb2b8c-2f8d-4dff-85cb-39247e71db7e@amd.com>
Date: Thu, 24 Oct 2024 12:08:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 09/12] iommu/amd: Enhance amd_iommu_domain_alloc_user()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20241023104207.5894-1-vasant.hegde@amd.com>
 <20241023104207.5894-10-vasant.hegde@amd.com>
 <20241023124603.GC13306@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241023124603.GC13306@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0209.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SJ2PR12MB9088:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f5764b-558a-46f2-9285-08dcf3f68a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dk5tUkxCcnpkSHNERE1oVGlIYXR0dC92V0wrQVM2UitJM211QS9OZ3o1UnNJ?=
 =?utf-8?B?SHdoSnJwSEk5QW1BT210T1krNmlFM3RQUXNEcm9KcHZTZHdENVBPbFUzSE91?=
 =?utf-8?B?bUV5dXh4L29rWmtFVXlUbjl6ZzU3TzV0cyt6TitTdGEyZ2YreVNJT0JxbTFr?=
 =?utf-8?B?S2tMNXFxNVcxeEM5YnQ3VFJoSU5EU0pmVHFZQzgrZ25zb3hRcEFtbkgwSnZV?=
 =?utf-8?B?Zm01UTBWbE1HYlFhT05ybGNFd3dPbW9WbzJpaGlEajJqN2tHc2RqVm1Cb1lh?=
 =?utf-8?B?STZSeGE3VzNRbmhoWFl5Unp0UzBVZkpkKzJxSmpCam9KTGljQWNLZzdsS20w?=
 =?utf-8?B?ajhMRGlhc2NnOTZIRHFXSFlvRVErWHRWM1VTVXMwRU1ISGJLblo2SzRFMnMv?=
 =?utf-8?B?RjVHTytwZ3draVBFd2laY1BJZkc0dWR4dVZBWC91dFE0a3VHQXp2UVdDakZw?=
 =?utf-8?B?dld3dGlFeTc5cWgwbnZyNERIT3YrUDdtWGI3REpacTAyWUhoU051aERTUkhV?=
 =?utf-8?B?THMzSWdzeFBnRmI4MSt6MmhVLzZ0Q3RZZUg1Q01UdDl1dkYrc3krK3VNcGRu?=
 =?utf-8?B?cXhUUFFFbDJMVGRSaFFFZUZKc1pnYUE5Q3NHbmJheUF4SWtGZUU3VkxaS2k0?=
 =?utf-8?B?emJuSXIrNll6YU1BaFE1d3dsbFNCbmc0NDBkOXZCdElRdHhSR0daaFVsa1BQ?=
 =?utf-8?B?V1lmcnhIbm5jOUt5bWVQRDhBdmpXMisyQ0JUMjgraGZLRVp6RXcyU3N0VU9X?=
 =?utf-8?B?Y2tiUjloS09qOUw4QXBEa2xyNkg0YkdkcER3emdSeWZwNDNOUXNMU0J1b3ZJ?=
 =?utf-8?B?YVBmOFZKOGIwQXI2WHRmVXhXcDdDOHVCcElsK05BeUc0Zm93M3VkS1dtb25F?=
 =?utf-8?B?TmdqTXR3MEVNV0ZMZFpJMGZqclVORVFSb1A1SHFteE9SUUJYYjVOOVFzUXpN?=
 =?utf-8?B?Q1pkQW5HYSsyR1E5L2hETXM1YWhPR2hDeXZmOU5CZGtOeW5MRXpoWGxQWGU3?=
 =?utf-8?B?RlJRaVBjdWRNcW5pNnpheDB4ckdoWnZqYlgzdklRQkJJdm9jSTRWNFhmc3NP?=
 =?utf-8?B?NGNqdG5vb0VFcHVpbXI5VWo5eDg4dWx0OHJJS3IwdzNPQ3BzWVFRQkJBNzZ3?=
 =?utf-8?B?WDFzZllSeTJ0NkRmYlgvc1RnNWgyRXpRRGxKQTE0Q3BOWTFDdUZ5ek8vck5R?=
 =?utf-8?B?MmZJR2hKWWNoc3lPbEdEeXJzWnFyRzIrcEl3Vk9OWjZxYmpaY2hzTkNscTVy?=
 =?utf-8?B?ZGw2ZFE2ajNzV1JQeW9SbENXYzhkQm1vYm04ZXZIdFlzZ2tZSEFTRTBvNXFQ?=
 =?utf-8?B?UHkvUlFVOFpJSXZhVW9YVTJFb0h3c0pKODRYRnhFNDBHb2lKdCsvZUJLUUZz?=
 =?utf-8?B?c0pQWUw3TmN0Qzhwa0NWS2Qrc1laMWUzT3NFY2RKcnVtbFl4VGhtbzBaNEhY?=
 =?utf-8?B?NVRxMEQ4cHdTWVlQOG9qSDNIYU5YMW1sa1gyTmNzaFVMMW9HdEpBUzY0ZHdy?=
 =?utf-8?B?bVlrdWRYalNzSjdRODN5NUJEVDFaTW1Kc3NqMFF5ejhlTVhtNHlxaTRnNHJC?=
 =?utf-8?B?eVNPdStGNzZ5bkRoUFZkUi9IVUN6WTU4VmZqdEhqcVl2VjJxaC82a1lGUElV?=
 =?utf-8?B?cGpqcVRleFJSWUptSzFzTnphbUxzQUdSNFlvb1FKY0NBZDRudDBKUG9mejFU?=
 =?utf-8?B?MTlUeDE3V2szVEwrOTk2Z3RZTzc3STdBWEFFTXF3ZlpGZzJ3aFVkVGRmZXM5?=
 =?utf-8?Q?jQKf3vmViFwzjrxt2hrwB2/+M5xDDiOf5aKdF6N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnJVaDRINFFzRnFvNkxIaUJZdkRVSVhBWHRXRjd3RnV2cnBDUThHSGRzOGZ0?=
 =?utf-8?B?SGkxeGluWW1GeFdlVE1aOEU0SkJZTlIwaGZMUkNqRFBNTkQxQVdmcFNuemZO?=
 =?utf-8?B?dytHNEVNS3FSZTlTOFVwTklQUTVLQlRYaDh1eFVNODQxaEZCTndYZEhlOWc1?=
 =?utf-8?B?Uk5OdXlJQ3FMbTIxREhKY1lDSVJsZU1BYWc5OUU4U0JmRTNuN3FaOU5mTVI5?=
 =?utf-8?B?WGxlQmJXZktKTk1CZ25ONVdqVHcxL01wMzdpcXYyMjE0UDVaRFdaT280TExR?=
 =?utf-8?B?aXVTbVowZFMraFVsSldubEdXNFpmTjRoTHQ0VFlqVTczcUFrcEhKUERnSDUx?=
 =?utf-8?B?Z1JHU2lqMVNBWVlBamh2MStPSjZZanQrREVkQ2hvMjBLM0ZRQUdmY0ZMc3Ev?=
 =?utf-8?B?WSt4RVdrR0t6VXhGUTlLUnVaVUV6L0VwVHNGOERBV1dlN3pXNGoxTG04SVgw?=
 =?utf-8?B?Nk9MWjZ6cUFoR1BrQzdSMW9NRzVsYkc4bEpEZmJLMHE4Zy9sRlpDL1FYaVRX?=
 =?utf-8?B?Vk5VVUlRRmxDK3ZpU3FjNHFoVk9LNFNsRlgxMzZ0cGFsQXhNNk1QZVM2NlFa?=
 =?utf-8?B?YUg2OVVBTExmaFpPL2NTK253V3Jlb1BZd3V5NXFyRGZESTJtcHJYaytScGY4?=
 =?utf-8?B?MVFId2FqUHUyVnp2dEc5UCtaejBqSGwzblgyRDBucndFcFAxbnBJdzlXT3VB?=
 =?utf-8?B?VTlRZlQwRFN5WTVwMWJRU0xQcUtPRHgxRzJoa1lBemZXMHk4RVVKaEVRZS94?=
 =?utf-8?B?OUNiTTFheVZKMlF0NnczNzVLaXhZblhVdTNOV1EzSjR0NkYwcmlzNG5LMjhq?=
 =?utf-8?B?K3c3NVdSVktkdWV0QmtpVWJ2NTNrYlBKUFlpbGYwQnVwZzIwKzMzREd2VS9h?=
 =?utf-8?B?cUtnUDIyK1FqZ2FWbncyWEtBdDE0cGE4Wi9GYTluR1UzYm9XY2VCbklpUEw2?=
 =?utf-8?B?Umx2M0k0a1RiZ1ZyWWtQQzhGS3RDQlN2QTNmMWpNZkVuV3hDa3ZCNzM1QXZ0?=
 =?utf-8?B?MTZ4QjhnSkNNanVPaXhxNHhJOXlJTWZGMW9rK3ZqVVIxRjhXOGo2cnF6eGF1?=
 =?utf-8?B?M1VJbjFrUm5Ec3NMZHhlY0xIRWIyZjcyVmhZZWN2ejM2UzZkUWRZaXcwQi9Q?=
 =?utf-8?B?TFJOOXhPT292c2tpUENtM3AvQllxVlI2eERzbXFJSkNPUFdUWUE4TUJ6NnhP?=
 =?utf-8?B?dHc5QmF6U1lSNnovMjBaMXRsMG5FS1k2aU12cGkvMzlvT0JQUEVLdUlxeVEv?=
 =?utf-8?B?bkdpdE44ZWh3cWhTWGRPMm9HeStsVXZTRHpLRGVlS1ppWkRnZllPakhNWFM5?=
 =?utf-8?B?V0pUcWg4cThFcVdMZTl5MjBUODhPV2lrRnl2OGQrYlpXQjRoMGRydzExcm1C?=
 =?utf-8?B?RmpZWUQ3Y05hWkZvOEZMcVFORFB6SEgwZVQwMTNQNSthUWFQdjdtVlMxQ0d6?=
 =?utf-8?B?bldod05McEpTcjV3L3dERFZUaVlHZ3dlOE1IeUVvdlRPbm9QaUtaRlBjQTVC?=
 =?utf-8?B?ZjZzUmU3ZW5meUhyTFRJVnVJdTJxZTNwcjk4S0pXTWV0aGpBTStCNlovK3BH?=
 =?utf-8?B?Q3QwektiQVdGMUpHcmdDcHdtbFBUbUhJZ2FEcTErd0xFWGI2Z0RBQmlZM1M2?=
 =?utf-8?B?dFR0aXFNbWUxdTk5dnpTUmh3OGdKVEFGR25xVWtvV2dPUk9sOXA5QlFIYlo1?=
 =?utf-8?B?cVB2aVJBYWIra2tDZGs2cVJPZnpXYlJ6SVF6K0RvcWs4dksxWjk4dkl3L3hi?=
 =?utf-8?B?ZCtIRzJ1QlNYanQ0TlphWG0xYWlTY09UUFIvWVZRa3AzWDlONXNUWVpOYUhw?=
 =?utf-8?B?RUFpM0lHVzJZYWJiZWplNU9rWmhFZFBxaW16TWpUbnB3YzJDRFgzZEFCUGVV?=
 =?utf-8?B?eXJudXEvREI1UkV3WXc2RjZhTVk5blF2VWgwVVh1aWlZOEJpVjRucVozMW90?=
 =?utf-8?B?alJjWUdIVDZHQXBGOFg3OEVCV1ZNT2k2SFJ1L2FURGppNXBwMWlLK0RnOWNE?=
 =?utf-8?B?cDBNdGNiYXNKc1hzdDVtR24xVFBEZGZLRzFjL3hPdE5TZGMvaUV1cDZYOC9L?=
 =?utf-8?B?UmtDeVBZUnZnMGdISmQ5TVBMRHRTRXUrVWFBeHVteEhWcVVrcnY2dTY1cWEx?=
 =?utf-8?Q?7d+cxmCAEu3vuOL4DbTfIyvJC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f5764b-558a-46f2-9285-08dcf3f68a22
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 06:38:58.8258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iNP6KaUeyYF35YYpKadTFAT7ySwifY0iJd9asP+Zs2JSoRv5O4uujFuve8FZN43yBnwznoApNE0nH49T0LPtxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9088

Jason,


On 10/23/2024 6:16 PM, Jason Gunthorpe wrote:
> On Wed, Oct 23, 2024 at 10:42:04AM +0000, Vasant Hegde wrote:
>> Previous patch enhanced core layer to check device PASID capability and
>> pass right flags to ops->domain_alloc_user().
>>
>> Enhance amd_iommu_domain_alloc_user() to allocate domain with
>> appropriate page table based on flags parameter.
>>   - If flags is empty then allocate domain with default page table type.
>>     This will eventually replace ops->domain_alloc().
>>     For UNMANAGED domain, core will call this interface with flags=0. So
>>     AMD driver will continue to allocate V1 page table.
>>
>>   - If IOMMU_HWPT_ALLOC_PASID flags is passed then allocate domain with v2
>>     page table.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 18 +++++++++++++++++-
>>  1 file changed, 17 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index cb6a72564c23..cdc93c794eff 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2403,10 +2403,26 @@ amd_iommu_domain_alloc_user(struct device *dev, u32 flags,
>>  
>>  {
>>  	unsigned int type = IOMMU_DOMAIN_UNMANAGED;
>> +	const u32 supported_flags = IOMMU_HWPT_ALLOC_DIRTY_TRACKING |
>> +						IOMMU_HWPT_ALLOC_PASID;
>>  
>> -	if ((flags & ~IOMMU_HWPT_ALLOC_DIRTY_TRACKING) || parent || user_data)
>> +	if ((flags & ~supported_flags) || parent || user_data)
>>  		return ERR_PTR(-EOPNOTSUPP);
>>  
>> +	/* Allocate domain with default page table */
>> +	if (!flags) {
>> +		return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
>> +					     dev, 0, amd_iommu_pgtable);
>> +	}
>> +
>> +	/* Allocate domain with v2 page table if IOMMU supports PASID. */
>> +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
>> +		if (!amd_iommu_pasid_supported())
>> +			return ERR_PTR(-EOPNOTSUPP);
>> +
>> +		return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V2);
>> +	}
>> +
>>  	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
> 
> This should be more specific about what the dirty_tracking
> configuration needs:

Sure. Fixed it.

-Vasant

> 
> 	if (flags & IOMMU_HWPT_ALLOC_DIRTY_TRACKING) {
> 		if (!amd_iommu_hd_support(iommu) ||
> 		    (flags & IOMMU_HWPT_ALLOC_PASID))
> 			return ERR_PTR(-EOPNOTSUPP);
> 		return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
> 	}
> 
> 	if (flags & IOMMU_HWPT_ALLOC_PASID) {
> 		if (!amd_iommu_pasid_supported())
> 			return ERR_PTR(-EOPNOTSUPP);
> 		return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V2);
> 	}
> 
> 	/* If nothing specific is required use the kernel commandline default */
> 	return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA, dev, 0,
> 				     amd_iommu_pgtable);
> 
> Jason
