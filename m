Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F16C13E02D
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 04:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725944203; cv=fail; b=HVt343fqVTJQL2C9CVjehDdUaHBs/cwgunnanCSELDV+nYefE/hOLaE71QIOdlxgLFT5SPz3GKbe2a0gnKNX762cGxHUOFwNUXScEtPa28bKtY3P1h2TfBpwtOeljFKAyS7WTIjH1zIgroL3HIyF7lzoqHUGzwEClor/wLw8kCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725944203; c=relaxed/simple;
	bh=dCFJnHpbpy8GcKL+bU9zrW/9WHQudW8iTj+tcwQy4e4=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RsreqySAOIcjQMW95wPqjjLk79JzV4O+hJY0ww7XkZq1HWEwygD3QpfzuMRYu5j14Ss4bH8AAgiIbek19LqCXViks65E1sU8+Q6yEmt7eQh8Ii+P+o0khFFukG6uyAT0dZguzafDGRzRPRRf+mBv642+ctYp6Q6jtun9JaDguTg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NabagzOv; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NabagzOv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q47GqikH9eugxAFVz9B7XHKluZWm/2Jkm5lfddQAyxjNfVrTtqcQExPXEeWpNexkmSn6XE4CHlLOCg+FRWHwsW2ncg8pJmxocARsv8VKK47MDLrZEnbeWiNnzoZvZIhuAkl9ZCmn7BHzeBcYFYhcX/TWWkZ2VTg4yLs5UXrwuTSwFt4CIVMYPxHDsfXT+6UTgCoQj4gVjekopY8rAlc1rfwTrqOjX62A63eL7xuGwDsKCTyDRuwxQv4p00AaEVy3adKntydovUj0qY2bGcr8JN9wXAWLXnrOzodplxdkB7XkGiAeAgmW6UhXenEwdZNuFd0dtiKu7bG1KfqQ5AYUjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KNwkIqDS6icRo5jqboNmYOJuwj4wlo3yc4fK9QGFDfc=;
 b=qQnhhO0X1vxpmALGDsoI4kEfaKrGrO2HYbQqEkizUh6bi52mp0rUfl0D3QQt6fsIQ2cYFVrC20Fk8bpsf1MG9l6o5G0oorhCGXwOz3Sak15Q4lmwZw570TgCVruaV7x3tG3ePhUOwKth5zUklJB2aIum0+VJbh3YSBTg/Pi/0zt7YpkGn3klfRFB+gO/TUY70e99rf/QiOM7ECwgUVkooic+fE2p8ZkVBZVNCNSXXGNfkfaIUQdfonop6uLVTzNRIzpUcNFaOnusLphiPIkUYAHZVtmCI7TuYIAFb67ddx3/6LdfqdURDxhWh2m7vQFerJz6aCZFdMiHYWWqI6zUUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNwkIqDS6icRo5jqboNmYOJuwj4wlo3yc4fK9QGFDfc=;
 b=NabagzOvUJZ+5hJwgGVQ10gakksMLpZDJknpuOdCwQHa1iIUGDGySZisHKldQwI/r213t6coA/r8AIoEozQFsSVFUg97vjM1wTfFPi1Mw0Pa+AUOUJ4uHMwgn5u96IBIW/mGA12yyyxNeoZJmKNY2Zbw6ZoqFDR+Sq4u20KS/qU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB9274.namprd12.prod.outlook.com (2603:10b6:8:1a9::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7897.27; Tue, 10 Sep 2024 04:56:36 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.7918.024; Tue, 10 Sep 2024
 04:56:36 +0000
Message-ID: <23a7c339-a7ba-447e-a4fa-935250f771eb@amd.com>
Date: Tue, 10 Sep 2024 10:26:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] iommu/amd: Remove conditions from domain free
 paths
From: Vasant Hegde <vasant.hegde@amd.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Joerg Roedel <jroedel@suse.de>
Cc: iommu@lists.linux.dev, Joerg Roedel <joro@8bytes.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 Joao Martins <joao.m.martins@oracle.com>
References: <20240904165537.GP3915968@nvidia.com>
 <5b6131cc-cc9f-4dd8-a2be-696e1b4e574a@amd.com>
Content-Language: en-US
In-Reply-To: <5b6131cc-cc9f-4dd8-a2be-696e1b4e574a@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0099.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB9274:EE_
X-MS-Office365-Filtering-Correlation-Id: 304e238f-8303-445d-605a-08dcd154f300
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WnlIdVl6UWNzYUVRVVBDQW1GakNHOGI5YjNqR2tPZDNrVVpZWWo2N2NZaUxo?=
 =?utf-8?B?OHlxMkNRWVJGUUtEQWZFZG1DaVdmL2FrTHliREE0RlNqQkM0VFcxUDN6UjNH?=
 =?utf-8?B?VmM2dXV6d0VtUU9Ra2xtWk8xQ29DTEY3MkUyY3Bjb0FXKzV5V0Z1TjJiUUlQ?=
 =?utf-8?B?Q1JxYVVzZ2xWYVovbmhhY0s0WlR6Smc3QlhKbWxsRTI4RlVqZmlFWXVsVkRk?=
 =?utf-8?B?Y2Y0MFY5Q2dyeDFGd1JhOWJmNmZUWDVROTBnWVA5TzZMaXcxZlpjR1d1Y2Zv?=
 =?utf-8?B?VGw1RGRyK1ptaVNMYnFHSDJBTjg4Zmg5bFJTWjFBV0MraUxjT0tZN1BlUHN0?=
 =?utf-8?B?aXdibjd5NDJpaGM2aUo3SFcySlVHL0JwOXRFL2lLeHlOcGlWRnI0eDRZNlVm?=
 =?utf-8?B?UldwbnFRenNtYmJ0bDhsamQ0ci9aQURRcUgzbUdITVloM1pOVFlUVER5Ky9M?=
 =?utf-8?B?cUdwSnNZa3ArbUthZkozM3E1K3p0b3g5eUpYQ0U2cDRZaGhLQlNtUDdmd2V5?=
 =?utf-8?B?bi8vQ24vMDFTN0h2bzBLYXNuVFhId0hJbndnYkZaOHVTV2MrVFY0S1lSeldo?=
 =?utf-8?B?UHNxY1o1U0pEZFRHOGVxKzJtY0dOZGFqLzdJUTN2NDR6akFVOXR0dDR2ZzlU?=
 =?utf-8?B?UWVNclVtZzAzTDcxNXlucTVDQklaRjk5SmZ3bE4zYnBlcEtPRlBHcEpQS1FS?=
 =?utf-8?B?dmFuTXZ1eFA3L1l5VVNjaE04RzFicEdYa0NaNW40UFZ6QkRqWDhid3lGakZV?=
 =?utf-8?B?YWNMazlyNHBEeFFjeUpYWnZPREhoUW43VWtpWWd5QTM1RG1RenlRZ2Fla0ZL?=
 =?utf-8?B?cUcxQkYvUUVJV0ZQZ1EvdmFxcTdjSnJIWGtHOHVHaXlrelZ1N1Y5WjhrZkRX?=
 =?utf-8?B?OXZaa1k5R1ZzR2NGK29Idy8yTDhKbkZJYVg2M3JDVEhVamltZ2o2MzJ0NUpx?=
 =?utf-8?B?dktzR1dzSlkxTlRvcW5wTEdtOVhOZk1XV3dEWCsxMU5vNko0WWFGMC9vcy90?=
 =?utf-8?B?dmM1aFF0dDlaemxnYWRJa09kc2xuckM0T3hVUnJpQTBBUzVXeXBBWTMza0Q2?=
 =?utf-8?B?TU9jZHBuTDNhQURMSjllRUNZWW1kKzVNOG5yNlFTYmQ2WDgyTEIxMGxReHBO?=
 =?utf-8?B?YjdLT2J4ZlEvMEF6OUhkY2MxTWcxcmNPMWgydFRaSXdWL1F4RTRnbkpuWlJN?=
 =?utf-8?B?RmdxRjhBMkpyVFJwSVRFSlpQRldMcGlTRDVzWllCWi9iOGFTcjdTSW9zRFlw?=
 =?utf-8?B?aERhMFlNUjM4VUJyRm15bkNhbTVtVkRieC9zci9jd1dldk5ITkNvZnljRzh0?=
 =?utf-8?B?eTBZZllqaGpDNmpWV3BQOG0vM1hLZnJobXh1RTh2Q0tDSm1VK3FnM3JpbHFn?=
 =?utf-8?B?ZytNcVpxMUs4aVVBbTVmSGRmZ3V4amc3c3BRNFlHcis4eWl5bGRleFhHN0My?=
 =?utf-8?B?NG83eHdaQzJTUE55MXVVZU9PakgzU2FwWlVBVW5SYXA5NXdhZnFPRTVEb3Bn?=
 =?utf-8?B?ZWJORndwTWZNUXB1Wm50TkIwQ2VRMGZhSE1NWHNKUGpHUHgybjZYa3FaeHZ3?=
 =?utf-8?B?dGs4ejQrM2g3bmJoSXJMOTA1QVZ4YmsvNzVnTkU0ZkNJS0svY0tSTVgrUlFy?=
 =?utf-8?B?aWhWTEpqQmluTFNOWE5hWUhmdGRpbFM3eVRsQ0EzYjdKOWJGbmo4OSs5Rmts?=
 =?utf-8?B?VXpCZmJ5dUs3UG05VnluTFVXZjViUUhKMW5OZ1pPOFcxdmc4MlRsS3Zad2JY?=
 =?utf-8?B?dTU3UlVFVWNRVFN2K3JBdkowc1dUNUJMYjlKZSs4UzJhR28xREllbEVlTWp6?=
 =?utf-8?B?ZGVrK0ZQWVNCZFFGUTBBUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGpjb2E0Z3NXVzlCKzZJZXQ1L1BxUnpRaVZjeGM0TnVYZ2pLbWFOOVd0NmdN?=
 =?utf-8?B?KytuOE4zOHo2WXdiRmwya2VEVlc4Qm14T25NYndGZkRBT2ZOd3RhajZyQkQ2?=
 =?utf-8?B?dnNEdE1yT2p5eHB4cEgrUU9RRFlxK0hnbjIyam4vU1g1TWI2NHpramxVSUNl?=
 =?utf-8?B?U1h6S2dVeWp6UHUvYXYvb1ZpSnEwb21JTFYreTkwVGVIZHRLeWJXNCtXbDJp?=
 =?utf-8?B?ZzRmLzZ3Q29McVBiUEJ2SVRndDBUUGlPcGpldDlxbWpiWURCa0x0L3RQSmc4?=
 =?utf-8?B?WTZEVXY2eDJnaHA4UUZ6anJ0elJDbVpPRlphS0ZReEZOR3JZVllOVFJFRVYx?=
 =?utf-8?B?ZEZCTGlHWFZScmEwbmZRdWJMMFljYUoxTHpmWm82alFwR29FSHhsdTlCWHhI?=
 =?utf-8?B?aHF0SXN1TmhML0VoYTFoN3V2WGFFcit4UC9PSW83djRtU00yMW1XaWZDcG5O?=
 =?utf-8?B?ZWIySi91MlNCbGZBVXFLcnM1Zm1VMm51ek9RRGhQU0VKUUp1a0FsdFNQNytB?=
 =?utf-8?B?WFB2dXZzR2pGd3R2N0NNTG5vRklGQm03YVRjMHlxZjVnT2t6TnBhU0x6VWl1?=
 =?utf-8?B?bzZSdDZvb0NvODdPRjJtYitpazJveUlmUVhlcjBwRWV3eHVyTzBKeVAxUUpK?=
 =?utf-8?B?OWZaWTJ4UGplZittQzJHdDRWQjZsLzBHNVpKbVQ1bmowVDBHNVNKVVJUR2Yy?=
 =?utf-8?B?OG9YbTFZUUc0R0xKUmdvdEtudUhrMlQ3ajVpK2Fidkt0MHprRzdlemgzZ1RO?=
 =?utf-8?B?MzN3SGlBNU54VWlPeGIvUFcyUC9sdFVxcFpIMk00YUhBSWJLNEhMc01KT0Ux?=
 =?utf-8?B?dGNjWXBRdkE0ZGpCVllZcFc2R3BTWW56V2R1OVp6dW5nRzRSVzlQWWZtSUU0?=
 =?utf-8?B?R0syV1pFYTJyVEV4d3FEN0c5elZQcTlIUm1yYkNJZ1ZxUDl6ejBzeksvdDRh?=
 =?utf-8?B?YTdxSFk2RnJodDVWcEVyTGlkS21DSXpFN3hLRUcxTy9JYTFTNjVhWWNEanVW?=
 =?utf-8?B?RDE2R0dmV01zMlFSNkV6ZUh4TXdCMmRBMEl4WEJhZUgxdWMvbTJQbVhQZk84?=
 =?utf-8?B?NEx1S2Q0cHFheTQ1VmV4TVZiM2FqOW1OaVQ2dFhPMHZOLzJXekM5amVlWGlV?=
 =?utf-8?B?eThlQnEyME00Ums2dVhvY3RHVlR5MlRzaHkxVzYxeWxZaWdaUVVLUU1xNWNs?=
 =?utf-8?B?WUpjZ2wvUEUyeE1IT0ZVOElhVE5MMUpieXhMdjRreGhCMGp3a2NZVjQ1UjlU?=
 =?utf-8?B?Sm91N3lzUFBVYTI4YlovMEZTUjdocGRMZ1VXVEd3UVdVNjN2d3cxdVpFV29Z?=
 =?utf-8?B?eHZzTkpCUFRrQldUbEd2UVlpUzRwNXlHZ3VtSkpxMkhrbTcrVFRLYU9YbFdJ?=
 =?utf-8?B?eGpOcUtQRXUrVGdqM0xPZlNIeWg5b2NDdTlwUlM1RlQxUzdKRVJaN2pBQkJi?=
 =?utf-8?B?OUwzcURWTi9kTVhnQ2ZjRDR6YjE4aXR2VjNwVGJMQ21uc0x5MnVYQysrSG5F?=
 =?utf-8?B?T2IwUVF1d3Nqb1Bnb3I3cmp3WjZ4QjNSMzJhVGVyQkw2cUdDdmtsZGdYNTJJ?=
 =?utf-8?B?TnAvaXIzNVVNZkFUNEpsUjJycWROcVlKaVVwNk90dEV2emVYK0lXODAzS1pq?=
 =?utf-8?B?NnVEZmdoUmw0ai9VVXhJbEdnaW5hZktmejIxMEFpQUltQlU3em1WQnJraytX?=
 =?utf-8?B?bk1TOXF4Ni9Gb3lLNHp0UHoxRmdwYXhTTXc5T3FKZzZoQXY5U0hJNU0ydXZG?=
 =?utf-8?B?MVF5dDNkeUNFK0YydnZGZDEyWmVkeWgyUG5Za3lsUjhWL3FqaGcwcEVaYis1?=
 =?utf-8?B?ektTQW9Iak9PTlIreGFRVjI5MUdRNmlxaWpoenBLQ3o0Sy9LMGM5SHNVZmhE?=
 =?utf-8?B?Vlhza1ExeU9aOWg1T3UyM1hpRjdxR0paTDdmRW1qZVJpSlNXYVBBajhYOU53?=
 =?utf-8?B?V1NVM3BYRXpJOWhLL2lwNmIvejdsbHlkaUFzaWc4NHdXNlZMak0zQU9acFlV?=
 =?utf-8?B?Z0dwb1pHc2YwaUg5VW9ZcGU1QUtYdGc1eUtjUEw0ZzBrT09LWTF3YndHNGw0?=
 =?utf-8?B?RXByQi9rUUIxWk5lRWNVVEV2MEFVang2Z3VLS1ZHakRPeUZ1MGtVWmtHWE1k?=
 =?utf-8?Q?59EdvSTPLr05rkIfeks0uyoDe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 304e238f-8303-445d-605a-08dcd154f300
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 04:56:36.7564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NdioxdD9mka1a9OAf1fdCqze6rkACOF9BcEjObRs/JMexMq1HLZVrZjnP9Nam8zSvzGjAxiNxruz0tE6w7B1QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9274

Hi Joerg,

On 9/4/2024 10:34 PM, Vasant Hegde wrote:
> Jason,
> 
> 
> On 9/4/2024 10:25 PM, Jason Gunthorpe wrote:
>> On Mon, Sep 02, 2024 at 05:33:50PM +0530, Vasant Hegde wrote:
>>>>  void protection_domain_free(struct protection_domain *domain)
>>>>  {
>>>> -	if (!domain)
>>>> -		return;
>>>> -
>>>>  	WARN_ON(!list_empty(&domain->dev_list));
>>>> -
>>>> -	if (domain->iop.pgtbl.cfg.tlb)
>>>> -		free_io_pgtable_ops(&domain->iop.pgtbl.ops);
>>>> -
>>>> -	if (domain->id)
>>>> -		domain_id_free(domain->id);
>>>> -
>>>> +	free_io_pgtable_ops(&domain->iop.pgtbl.ops);
>>>
>>> This is common path gets for all domain type including passthrough, SVA.
>>> Hence its not yet ready for unconditional call.
>>
>> Oh, I see, and ops isn't a pointer so it doesn't become NULL like
>> other drivers..
>>
>>> This is causing NULL pointer dereference when I try to change domain
>>> type.
>>
>> Yes
>>
>>> For now, can you keep abvoe check -OR- add PAGING_DOMAIN check? I will revisit
>>> after implementing global static identity domain and fixing SVA code.
>>
>> tlb is always NULL now that is why I had to do this.
>>
>> @@ -2259,7 +2259,8 @@ static void cleanup_domain(struct protection_domain *domain)
>>  void protection_domain_free(struct protection_domain *domain)
>>  {
>>         WARN_ON(!list_empty(&domain->dev_list));
>> -       free_io_pgtable_ops(&domain->iop.pgtbl.ops);
>> +       if (domain->domain.type & __IOMMU_DOMAIN_PAGING)
>> +               free_io_pgtable_ops(&domain->iop.pgtbl.ops);
>>         domain_id_free(domain->id);
>>         kfree(domain);
>>  }
>>
>> Is that OK?
> 
> I have exact fix locally! It work fine.
> 
> -Vasant
> 
>>
>> Joerg can you squish it?



Can you squish this change -OR- do you want separate fix patch?

-Vasant
