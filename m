Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19071D04BB
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 09:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729501853; cv=fail; b=cBtfRjVFtzYljBn872rk0z428lxKXvE5AH762jtBQ1W4X8P8dV//vFli+7HRaIe/5oFmCZq8VYIKveTOcuf1JwY81pd38W8XKs9SxVAouNimHHA9Q4aM9nybmKdA5eYNbatsOOFZrDJuC9WGil3+noAwBX6pQR2vPf4s5mXmAX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729501853; c=relaxed/simple;
	bh=dy5L1XjY7dB3K3c+bhMIQ4qzMO+oS5ScJSrmPzc4jZs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kIRtuj5GfuLhExYNJRr+Kbll3oLIFPqE41Mml/+7mZilbWLVpyW9wWm0arR/eAwN7IqnWtxqQNEC5fPCEejEdJmVeflGgCWp1RoRV9OrjGo4z7tqQlaFf3vJIPy38znRSmwzhGxJ31XVI84QMRWx0vEL2inOgJx6MHknkgMNoS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R84klV3U; arc=fail smtp.client-ip=40.107.223.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R84klV3U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flRogTiVtEE5tAxPXjMvYmK6Tad30JzG5EdX2eZI1SP0BZD1I2b9BiyrnyRHRxECyeDTXPfbw3RnCSm7yjoEWmALAAD41k1RnI0D+JUM9M7bVeFIrBRXmglrfU/bAHi3KHvC1+GU2vkKEQzowxn+H+nt0WFX6Ycz7wwYdz6TqUQNqX6QklheZviqe1jDbe04+wvowuIw/zI8u2ddx4tMaBaCkEh1/yRbRUykWQ02ceZeUnZevvheaUqsQjXw3bmCUaEJqMaESdWoe9Sye3h5+jK4UGOxZZmhtoPNlieZlOA4Wnrm9/E2CnlFeH3X+2GWDu1KLeLoBX+l9/imH3QX/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkFKDH9A+kVvOVvz0Mf5bkJNae/+N0cAlUAOEskIqj8=;
 b=Gt6GOXFIDH5rB8D7asjs+dGHbSevLZ2hSUrRGTtY4i/a4wfaqGMBsXomaD0oiY2ehYSuENwKt+kwFnpkOOnrFRnd4ns24F/fhw8k56RLhC7qN9axqQ7SpRSzjTd2Hjh5CE0QwdTdgHigQSG3Ovfs4RqfS3eziGfhbgJN+gwoONIzZGlcWwcMI/Horm9MiVHtLKdUjUtU3aK4m2wsQOeRKOCHpLN0HkQkkN+ZK5+8X8ikPpvXFGAUPefL1rUuRvhAxQg6WLV4lFtNTnQ0lx4sHCzJ36jNhDArTY6C1RQlE9CI/yF20zkCgcei8M8U3DpsP5aFCWmS3Rykhrw1CeX0Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkFKDH9A+kVvOVvz0Mf5bkJNae/+N0cAlUAOEskIqj8=;
 b=R84klV3UX6jhRqB5m/SiTOFizOTy9o1ZrJB5i/3k/LE2nGshQek7wxOCu6uE1tLv74Ju6vj+6KeplIIXNGw4wuocJq9PRePejvrbDFE7DvLJ97t3G3wA3e3t9jyFQQF78gdsWaDw/5FGiXLKE/loMO3ZOoY+uJI0WfhIHIgYfZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CYYPR12MB8922.namprd12.prod.outlook.com (2603:10b6:930:b8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Mon, 21 Oct 2024 09:10:49 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 09:10:49 +0000
Message-ID: <d6084bb8-4b81-4590-94f2-4244705272b6@amd.com>
Date: Mon, 21 Oct 2024 14:40:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/12] iommu: Refactor __iommu_domain_alloc()
To: Yi Liu <yi.l.liu@intel.com>, iommu@lists.linux.dev, joro@8bytes.org
Cc: will@kernel.org, robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 jgg@ziepe.ca, baolu.lu@linux.intel.com, kevin.tian@intel.com,
 jacob.pan@linux.microsoft.com, Jason Gunthorpe <jgg@nvidia.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-2-vasant.hegde@amd.com>
 <ecf96e21-c249-417d-9c55-c6a89f8e6d13@intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ecf96e21-c249-417d-9c55-c6a89f8e6d13@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0138.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::10) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CYYPR12MB8922:EE_
X-MS-Office365-Filtering-Correlation-Id: a968d70d-329d-4648-ca9c-08dcf1b04156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dHh3cUNjZm5tcEFsVWlWMFBKaEZ6UTJYc0N5bGY1L1o0WmxLS0xYTE9aVFo0?=
 =?utf-8?B?RjlNZ1hCSklQL0p2UUFEMU9LdHVCNllnNVdmNlpMd2paWUJiZ1ZXN1VMcndS?=
 =?utf-8?B?NHF5WDlzdG5PalovK1JOWmNiR1crMDlJSWtRYTZ4RitHVW1HS2srRFdCQlNJ?=
 =?utf-8?B?Rk1VODE2M3dLRE43MzMycU52QXhLYk8xSkxYajVBWGFTVHc4QjMrZldTWDZ2?=
 =?utf-8?B?UG40bmgwUlZvK3h6RTduMVJ3TG4zQ25IMTBCa09qY2tYcW1sU013azg0dnc1?=
 =?utf-8?B?cy9Rb1lOWVR5bWVoYXpXV0JoZGtQWUxoa3NZeTZaSmVpWGErbUIzOG9TcFhh?=
 =?utf-8?B?RFFkNWxpc1U3bjB2M29sdEM1YXZpOGJIMDJOTkhueWVxZCtrdU13YnNJVmN2?=
 =?utf-8?B?S2FiYnBSY0MwLzNKak5VRjNBOVRvRFp2Rk5ZMDRDSjdZbEt2Y1hXeXdLWmE3?=
 =?utf-8?B?ZzZwaUEyTFBhZXBCNkpXb3B0ZlhlS3k5dmxpRDA0TGJ6WjErY2x2aHRaUGFJ?=
 =?utf-8?B?ZXJnZE9VUFh6NlJ1TzBUdnRvWW1FSVEvdkY3ZTdoOFl1LzNTVktJMzZtUmJs?=
 =?utf-8?B?eklkOWZLSUllL1lHbmZ5emVqaEVPaFBzRm9MVnZCWmlSOTV1QnJ2ckUrRVhJ?=
 =?utf-8?B?U2ZtdjhCcVlJQ2lhR0kzTWZoR1diL09uZStDWFFVNjY0K2dvbkh0bTE0Ymw2?=
 =?utf-8?B?T3BaRTBzd1cyaEp5ZC9iU2xEcGpRc0gwUVM2K2xBZ1pQS1ZRQ2lNWGJoR2pG?=
 =?utf-8?B?THBrQS83OWE0OEErNCtmWGxOdTBxSlhoSGFwZVN2YkU4Q25aT1QxMWp5bldF?=
 =?utf-8?B?bXg3UmxIeEtGTWtjUExlYzNTT0tPM2xnUU9GOStleDNxRzlZM2JKMUJIRGla?=
 =?utf-8?B?Smo0Q1V3ODlqT2NiMHhDZ09TblRGTURpK0t5K3hQeFNoSjlXZ2UrVlR5cE05?=
 =?utf-8?B?QW1hMUxJbmNaTlk0Uy8yTEN0Rkd6bVFrN29tKy9PR1VTSVkrNWkxeldpUHor?=
 =?utf-8?B?cHhkdDgxVHU2R3JnTXc0cnRaVVhKZ01xb1ZsRnJRVW9RbDhzS3Y2UnRzYUhX?=
 =?utf-8?B?VnQ1bDNHUlFHOFQ1SE9OcnBaUFYrOVNqZXpPUFp1clB3NXhHdzBPeG5WUnFC?=
 =?utf-8?B?Sjcxdzg4VVQ4TktQaHRraXgvUFRtYmFNM2I4WStDc2VPZDFodCtUUk5wVzdF?=
 =?utf-8?B?NDF2bHFTanRNQm1BMzUrTERCdWIzRmN4ZGwyY3ZPVThrOFhTckhBQjZ5UzVR?=
 =?utf-8?B?T2ZrWmNwOEU0QVF3bi91ZkpVNnlMQWEwVW9ta2F6em9BaWE4UE5ma3Y1U1E3?=
 =?utf-8?B?b2R4a0oyUU5pU2dLY3pkMmRoblJ6V0VHVkNuTXYxMUptWGJlaC9VSXoyWFJU?=
 =?utf-8?B?Q2ZETTRhVnUzeSsrZHZXbWNtSHMyLzFGTkE5b2RFcjl2YzU3eVhOdElqOGRF?=
 =?utf-8?B?Q2xkSVhnWlluem8xNE1PcnQ5cTNWRno0UjNNblJRUWFuWC9Lb2hwZEJmdENx?=
 =?utf-8?B?R3ZBdTJYM0lFMDZYcnJrMHdmYTI5a0tPWXYyU21FRHNsM0ZSRUNMM01MaVd0?=
 =?utf-8?B?eUlsS2FjOU04R0x1ZjR5Z2pLSWNLbi9ZMTdlWEg5aEM5Mk1uRU13QmtScjRU?=
 =?utf-8?B?a0ZuRS9CYUt3S3ZnNTNvT0wzS0Jpcm5qTCsvRXZmSGt5ZzZrcUxIZWVNVEJl?=
 =?utf-8?B?UXhydXMzbTJvVGNHUDFmVUY0VFBqMjVNYTBtbjZEbjluemVyUnUxR1ZwTjlO?=
 =?utf-8?Q?Y84kYopFBdkZPwc47HAh33vw7FBvVBhfJVD55i7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2hUdmFUbmdpZjBIdkFJWkdWWnF3S2RrRkpZWjI4anltZlJkRnBNaGVSd0tD?=
 =?utf-8?B?QncxZVdZdWhKVmo2elZYeUNuQmFCWXh3S05GZGF6QlRhOHM3TWh6K1NQRDU2?=
 =?utf-8?B?N0dOL29kSDZaYytTWWg4RkViQmt3a1lsdnRXclhBd0RkQmlza00yNWFtMW5S?=
 =?utf-8?B?N1VaeEVzUXdIQ3h1dmdScmlIeVRnbWhva1BjdjdxVVFya1YwVXRUQlJRRUJy?=
 =?utf-8?B?VXozc1dtMERtMFVTbUlUSWdhbVBMaWFqS1Bucm9ENnkxUGVtdHdIVk90WitX?=
 =?utf-8?B?T1BuWitFWWdKbWMyZjhFczZweFIrS0NDWnBCekFhUy9URWg3bE14R05DU1ZJ?=
 =?utf-8?B?bjlDSXgrWURLMGR2QVRFQjVQRXhSZXFQajRiNkpiTndzOXZmNENIZk9IOGZP?=
 =?utf-8?B?eWhFYm1QMy9iNHVFK2F5UzlQSVBpU0E5TEZQWXJGbTBmK1FZT3RzTENlVXcr?=
 =?utf-8?B?QTl2TldTOUJVT0p6aU5VUEY4T05jOUN5NU1iNHZnOGNLWCtYaG5PM3h0MWgr?=
 =?utf-8?B?NFE4TS9Ndmd4Y2FOMW5EVGEyTUcwSmFRSmdJb2VPSFNpaUszU04yT3hkcmtU?=
 =?utf-8?B?K2hDT3BqQlFhQlNtbDd0UFE4eVllVm9UUTN5TzZIVFRGeFVFeHpGRVlVcXpx?=
 =?utf-8?B?V2xVaEplbFpISnd0dnc1WmtSODBHUXk1RmNPWnplNjdmODljc1QwVWx4eWZK?=
 =?utf-8?B?eDJwV0hWeHFwSDFvWmhCTlFoM2s5RWVZQTFiaXhCZjIxa0lZT0hnVVhvQ3hw?=
 =?utf-8?B?cmVwczJlcmF1OU9VM21kSWlqNHRrY3p0citBTHd5L1R6SXFGSnk4NVRycmNq?=
 =?utf-8?B?MU5xQ2ppMThsRTZCYk9HN3V2ZldhcDJQZ2U2TnoxKzhnVXhqOCt2SVJtWGlQ?=
 =?utf-8?B?UmY4Qy9QK1paSWJuUHIrTzhWMWtadzVjcWpXbHdadFUva0grUnNJcVJDK0Ex?=
 =?utf-8?B?Und3Y0ZBamR2Nm14ak1lRmJjTm5Jcjl4SHg5c0FLcHJVaFZmRGdUeU82dUty?=
 =?utf-8?B?ZmNuV3BhaFloOTB0WmdLZ0RKU042WHYwWG0reWtWQWhFU2pHMTVGbEVnQ1lX?=
 =?utf-8?B?cGdaWUZEVVJCdWFWQ0JhK0laK1FQRGw1Szh4dFRDa2pUczFteG51eTdRNitC?=
 =?utf-8?B?clcxS1dFT0RZeUM1WkcrQ1N4eGFhRGhkQys5N0NIanN5eU50UWp1UlJkMktL?=
 =?utf-8?B?N3pGc1FLSDBzejk0M2dSZFlTb3RNS29BaXZZYzhtdi9MbUN1T2ZHUmtEc0Zn?=
 =?utf-8?B?TExYeUg4aGtLNDJBUDdkd0VzbklJWHFxQ1VrN1JQZkZWU09FUVhmQ2ZRc0dK?=
 =?utf-8?B?RXJXb0tDRXg1RUVhaHIvcU9OZVI0cUJpNlVoVklSbEkramc5OWxiMytvUzRQ?=
 =?utf-8?B?TEczZTlOL2I4OERreTl1YUJtYnVXRFl0QnZmcm4raEFGakhjVEZiQnBRdS81?=
 =?utf-8?B?Yk1CcXVMc1BQZCt6dmF5aXExa0FnYW9YK1NoZ3VqNGdrUEhLWWxDdHUwWDdz?=
 =?utf-8?B?NWNhUGltOSswWUsxenRjMGdlUW9nYTRTVzNtUlN1U04rcnB2QTVRUjdYRDJI?=
 =?utf-8?B?L0Nzdml1UTA2d0RDV0VndDRvWVJCQUE3NDlLbUJtelc0RmluZkZIajlkaFdq?=
 =?utf-8?B?dS9FVTF1d1NYUUVLaTRsbmhZQUhydjlZREE4cm1pWmhIYnRRazJ6bzhwakxu?=
 =?utf-8?B?N2V1RkphRHdDYmhUZTExVXZaY2dnSEdPSnFuVkp6RlRPRjczc3VPVUNNZUxa?=
 =?utf-8?B?QXRuZnZZMnZwUFJ1ZFJvTFRHMjdPNGJJUS8ySVNBczBRUEV5UFNnS2RkWk91?=
 =?utf-8?B?QmJ6NTdTQlNCbjlRVGdBZkF0MjFqM1lzS3R0VWJZN1RkR3JrcnNPeEdFakkw?=
 =?utf-8?B?M3Y5SmtxQnYvcGc4SGlvOFk1dEpjVVlkRDloQW9jSWxydUF4Y2ltT0x1cEkv?=
 =?utf-8?B?amdrOHVFbFVsbzFTeUIwaGcyMFU1eE95WlVUWTRPUmdMc1A2K2p0RGlBcUYw?=
 =?utf-8?B?SVl3U2IrdWJwcG5Ya2ZTcVdBYXFRcnJnbkFIcDdWUElkaStwbGxQNkZIczFB?=
 =?utf-8?B?YzNMb1hBemhXR3VUUEFyaGpvR0E4NGdncSt6TnkzRWtDV0tMQThudzA3Sk9S?=
 =?utf-8?Q?7NVp6cTx7LOhbT8GExggO/Ute?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a968d70d-329d-4648-ca9c-08dcf1b04156
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 09:10:49.5569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o7IQtLa7bEjr75etREG1u61kcxDmDZI8oom3J/OspYmceISgvSOd9D6MkVLFEWRhPXdkaZTzaknZGkJZx3247g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8922

Hi Yi,

On 10/21/2024 12:59 PM, Yi Liu wrote:
> On 2024/10/17 22:01, Vasant Hegde wrote:
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>
>> Following patch will introduce iommu_paging_domain_alloc_flags() API.
>> Hence move domain init code to separate function so that it can be
>> resued.
> 
> A nit: s/resued/reused/

Ack. Will fix it.
> 
>>
>> Also move iommu_get_dma_cookie() setup iommu_setup_default_domain() as
>> its required in DMA API mode only.
> 
> a nit: s/its/it's/
> 
> Otherwise, LGTM.
> 
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>

Thanks
-Vasant

