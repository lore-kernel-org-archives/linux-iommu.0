Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A042F362B
	for <iommu@lists.linux.dev>; Thu, 18 Jun 2026 04:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781755594; cv=fail; b=lfiXipBAC+MhBjAP5HtXmZXmnDgPsXOOpY4us39mQ5v0g/DF90O/DXS2QXzEwP+O5jCriJaOD5dvNI+808lsl4ZR1TJ2OhJ1K16DkEM5Lpxr0giZEHiuVXJEMSeNF/iTHo3hnVRpHXTIxXUJZmCBJ0UQfxj0MMrYJfB32G/388Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781755594; c=relaxed/simple;
	bh=/yUR8bdLHOt/fOEQg0U5lTsTuCLZlUyR6oKsIGw92Kg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m45S9pCRc9m+Xrmddt7arqCiAE5nAp/XenhpBiblITqZcsjlD0XJkaNWb4An3rGV/zp7eH9sfqglM3uy8zb7Mz6cz0GwL7ShQhQNpQUwhuX+bOVatvlI5/jX2cq6F83tB/PBV6PMMO/AFRztYgKHcQ8nkE63qX1KadihpR5ssyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WgZvyzUT; arc=fail smtp.client-ip=52.101.46.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WgZvyzUT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mH7uhi1+cU1LJmAD1fwBxGx9a31gqXkQjnV6ptA6accdK1FQr9hsu10tNZrx5cZzqp/u1P+AebMeHenr1xwFQateTdbyz7V1CNGL+H2GYXQ3XTMrEndmNFsU84NtQ4tgItf/3KngzqkVykSl9uSEuPRzSHs5jNIjPOUDjkx34EoxDt/A3boX9qHhcCpLrmnK2zZTNmbcdKCG/PoYJbx4osF5MhAf+laYDpxUS2ylC6hdiAo1XYO5RQ4ran2MZKdMWA0uPMaoucEminUrZhGEU2B0Dm/HQ04OCtcoVO1T4qYawhROdafwtUAKt78Be/zTRRgFTo+jaXMH2M9Ea/wGqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZnEeLu1olOXPpULDl3ZF8FfAMjfi8kvBmQy9WGYt/Y=;
 b=Bdiz/bAvyW+D22gZfVAXeRvLV3jL5tCMN++7KviU3nBUlb7OM/mznJOBUc35Injb8bPX7smoUO1GvXo2BjNVNeWOO+m2hhxHZk+3PQh597MybxYDEUPcCtV4aYEU7S71caWjOFihe73QOoYhNH9eq1Ak0ZEc63VQrD2956KTFH4IoPoM/sZefA5N18N85uhCXaYjVzM+fgBZ15c4z3uAs1H+F6eMKM1owPve3fFYgKzjiLmP1Xbs0WEaJGPUteCY59OuOeEhGizKW++KMW5bEK2mZQZRUTP3b2hz2b17EWv//tG031ca+rwMMuuT6rh8UutaedTaJUVOzBudjXcmvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ZnEeLu1olOXPpULDl3ZF8FfAMjfi8kvBmQy9WGYt/Y=;
 b=WgZvyzUTzHT9ceZWSLgVMrd34epsv+mNdQBNvw5ngCBa0d7JbNESVAqrk+2MrY57nyvGRmJ/42qvcoF5OFnTnBK1hazA0RL0S7rhgEjY7KKW3mqSaQmuzUIYh/mZl5zdFgmXE0Gtg4Lvry8jzyZxK5etK9G1nh0bu649lsZqarM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSSPR12MB999236.namprd12.prod.outlook.com (2603:10b6:8:374::10)
 by DSVPR12MB999123.namprd12.prod.outlook.com (2603:10b6:8:388::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Thu, 18 Jun
 2026 04:06:27 +0000
Received: from DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e]) by DSSPR12MB999236.namprd12.prod.outlook.com
 ([fe80::8a48:f674:71b8:d21e%5]) with mapi id 15.21.0092.006; Thu, 18 Jun 2026
 04:06:27 +0000
Message-ID: <868d75e6-2e18-40c7-b761-bfb494ac78b0@amd.com>
Date: Thu, 18 Jun 2026 11:06:19 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/26] iommu/amd: Add per-VM private IPA alloc/map
 helpers
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
 wnliu@google.com, dantuluris@google.com, chriscli@google.com,
 kpsingh@google.com
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
 <20260528051738.596013-13-suravee.suthikulpanit@amd.com>
 <20260601131112.GN3195266@nvidia.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260601131112.GN3195266@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0022.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::16) To DSSPR12MB999236.namprd12.prod.outlook.com
 (2603:10b6:8:374::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSSPR12MB999236:EE_|DSVPR12MB999123:EE_
X-MS-Office365-Filtering-Correlation-Id: 371a3c99-2e17-4723-bda2-08decceef848
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pkBfSSn8p0J7Ya0NrHerkG9/AIcsRb29XsOvV5AmvDUrTMLezE7ufs80LCq4oEe6eTpOtZdr17l0ugFGJ7uYnqeZOm7HRMl8TNJG/9WhVHrBI54Y8CnNELZSOSUkRcbkNpPfd4mBzgdEnPGEMsWExVRA57Em/0XParR7JBdcvJXwGdTJWUtZY3EAfuIXkD/JN71zONVBAbqO6qYiXKwsivC/cjfU4DqulU93807eOXRxBGg16s+pgWZRU0ng4eBpwGq6IP0T6s9RWW64TP3t14+qV2tKkcyF440Jv9q7dL4/UQFAdCmMrWGaxUScya9XGsMz4VD0jdc/521qhuqAsycITF60rajNU/kldzg61XgwoN37YxyUqrcbtj11rMhCgUxh17mXGwYaEFMNcS8I8lzaG/u0t1y8jI/JQQ8TJkMEKxwNy8nb/lz68mrPVtxgry5p5HT8XdmOX4sm4BtigkPTa8Tx001ourRaouXyRA3dB5WM7hhFnOD8MZiZ8cegVCPFtxlloJ0aouiI8B2eatrtIE90az4BCubdRYRfO+6YPLa4eRY8NZdsOsdlW+OlKFMp24RNDotYNLpv4ULdVAy+w3a3KP1bAjX8yBfTB6jS/rGqkwy68trK359GrLsak6SXUukRGKMCuEShkp7I1+0FDBGQ6VBAoHNa6+9SJB5D7tpDXHjad6+lYw7XB1I/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSSPR12MB999236.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVhISmZHSlg1VWRjMTlkM0hIOUFzK1AraG9qQzVtTG9jOU80aXJwRXhTdXhT?=
 =?utf-8?B?NFQydEhoakJXSk13WFVvbnBiSzkwUFZWYmppcE94bXZOblFYRTNWQzFDNDFV?=
 =?utf-8?B?UTRCZ0hCSDhZU3hBS0U5NThBOVZVRGVYM0FEVjVpdjVwZW15aUpnUjRRSFZB?=
 =?utf-8?B?MExpQWVOVkZ4UDZMcVFhRG5RRGVTTVhJemJKaFN0cTdaRmxpUll3RlVnMEpj?=
 =?utf-8?B?eURoaXpiYXlOd1BIWVJyUVpHZW5hZXlLWTJSblZnbTBHQjZTbE5ra2tKeDUv?=
 =?utf-8?B?YmFyWlJtWURBYWxBQ0JOYVFkMng0VWxjY0VQdlkwY1RuVGt5OXJPNTljN3Mz?=
 =?utf-8?B?cUNNSStMWk9vTjBEWTZTNVhsNXMyMW0weTNVaHpVcnZHTUk4OVdZejFDZUUw?=
 =?utf-8?B?Vm9Sczg4YUp1cmVEMlppVExBMnNxcjZyZTFuNnlrMWVmRVBpQ0ZvdkU3U1N2?=
 =?utf-8?B?UXNvQlhvWWtOY3p4cDZCOFlkeUZPRnNUNDJrMEZqVUVsRGs5a0JSOTJsOFpy?=
 =?utf-8?B?dStVSnBQeGQ2TUxpL08ySnJvSk84WlkyYWZlRHRuWUZUcFFLRmk0ZWpRejNv?=
 =?utf-8?B?OUd5enVielcybTRmSFExRGQ3Nk4rUTZNMkQ5cmdqTUJqd3BsYVNaRHp6YjAz?=
 =?utf-8?B?UzZoQ29kRkQ2N2hxSWJ2Q1pOMC9CNmV5UiszV3VxcyszeHJYMHBNeU9ZS1E0?=
 =?utf-8?B?ZjFrQ2hHSTR5SlpFYklWMHAzMHFuNnY3YVI4NEpPTktpM0VYQUliakFjc0Z6?=
 =?utf-8?B?aXMzWnlqU0lYdm5ueVgxWUw0cXpEWEF1WjE5MisrYVpOeVE1VTFBTEdwTHFB?=
 =?utf-8?B?em5oME1WdE5za2NUSjBFSE9Bc1FSZHpINnJUc3p5bnRUd1I1RjZIUDBaVVRu?=
 =?utf-8?B?Q0QxRWRHTGpkSHB2WjVhL0lUYVd4V1piVHdrQldFWStMeHFacFYxcGlRc1JW?=
 =?utf-8?B?dEt2azQ0a2dVVTU0SlJ5WVdJSW9Ga24wcjNhNVhPUVJTVzFHQ3ZYdDFjSVJh?=
 =?utf-8?B?ZGlCaW5tK1Yxc2F4bWxyL3NsMkVzVHM0OW8yeU1pSXJneVBFMnQ4KzlCS0tz?=
 =?utf-8?B?d3BTamxxbUtLUTNUNlBnRWdBcTlLTHA2MWY0VUdKdmh1OEZHZkRkWVJCdmdp?=
 =?utf-8?B?L2ZKWkdJaG9XRzJ6d0RaOStqbXZVeG9kTXVSd2NKTG9lVWlaZi9hdjdtZjhD?=
 =?utf-8?B?d09lWExJNDlUS1Q4MGlPbGlCWFBLZVRSRld0ZWZlOWU4QWdrbzdITkZTYS9G?=
 =?utf-8?B?YWtUSFF5dVpUbStYaU9CVzNtYk9sV3I4ck8vY1owY1JDckVjSWkxaFhWL0VW?=
 =?utf-8?B?dU82c3BpTzlvK3FUOXNJVExDdGk1WDR6b0dFQ3lRQVpRNURYYzNDMDdSaEk4?=
 =?utf-8?B?MlpFaVkvaldKK2RrUSsvV2M3NG9NRVlNR3Y1RW43WW5Hbml3R0tFRFQ5RVhG?=
 =?utf-8?B?azVpc0tQTUlmWEZIdGtobTNOZXNCY0J3WEMycFN3ckRKZVlpeGhaYzZRWmNu?=
 =?utf-8?B?ZGJJemxsVHNBQXpXdGtVbjZPSmliRFVHb2pLK1VLdmhuRDRIYWdVa0ZsLzR0?=
 =?utf-8?B?Z2FNMThnRVMvckZncTV4VzFvOWRDMXN6ajVnZWhlTy9vS1NyTzhNZU1HK2pr?=
 =?utf-8?B?cm9lcWwyYmljekdqNThiV29YSzYxQXE4ZVdUM1FTdVhWd1RYazZzcElFeFFZ?=
 =?utf-8?B?SVBnLzdDVUVQRTAxcDBLeW9hem51a2d2VVlPOTdOYjBGeENWU2tJQmMwSEl5?=
 =?utf-8?B?dFd6YXZXZDAyTEEzeWVJNUxoMStFd29vRzdxVnRYRFRCa0pNUG96Mk42Nnky?=
 =?utf-8?B?RG4rSGVUWUNyR1MxWldrU0dycXNWWHFDWG4zSVFDai9MVXVPSkdDWER3cnBx?=
 =?utf-8?B?YVFGSnFSdHhybmlZWmIvL0ZUQytpNVNSQTFwNk4yQnhFTGlSTHBObjU0K3pj?=
 =?utf-8?B?TDNQTmRrVGk5SXhST1FmMUFJUDFGMjRicmk5UjJhc3BCZXFaK09MMC9vclBR?=
 =?utf-8?B?TE10RTdlbHlvZEYrUUtXTjV3d3FaRDJYRU0wOG9iQVgrc2c0NGI2UENqWUIx?=
 =?utf-8?B?d0FadWpUMVhFYUtWa254ejNvb0d1a0lOVUs3OTN4OEdrU3pKQkVqNVpXTHg0?=
 =?utf-8?B?bnV4UmtQUU44aUwxaWYyandMdkhQdEVVS0RrYWNuMGtyMTNaMkNOMmxIcGg0?=
 =?utf-8?B?QmhZb3FzYkVmR0xGbXJnaHBRNDdrY2ZzSnZVNWt6dU00TTdaZUxiS0lvTmZT?=
 =?utf-8?B?c1pwR3UwbkN6d3RMYjJJc29Kc3U1dlQybm9iREdwU3FoOC80NnJES2wzR3JL?=
 =?utf-8?B?R3ppSzlTQTNjSE5LZjFxays3VnNFUTFZTkpiRFB0Ylc2d3gxWWFmQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 371a3c99-2e17-4723-bda2-08decceef848
X-MS-Exchange-CrossTenant-AuthSource: DSSPR12MB999236.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 04:06:27.6262
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aB7yAzWspnVbrqzEyRFGFzAdaliVgPHpfDXYC4j/zSFPqP06WUlbv6NWe3Xk//Ja2q8Bzs3DrrWHuVd8zGCNtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999123



On 6/1/2026 8:11 PM, Jason Gunthorpe wrote:
> On Thu, May 28, 2026 at 05:17:24AM +0000, Suravee Suthikulpanit wrote:
>> Export amd_iommu_iotlb_sync() and use it for nested domain
>> iotlb_sync so nested attach paths can flush gathered IOTLB state.
> 
> [ ..]
> 
>> --- a/drivers/iommu/amd/nested.c
>> +++ b/drivers/iommu/amd/nested.c
>> @@ -291,4 +291,5 @@ static void nested_domain_free(struct iommu_domain *dom)
>>   static const struct iommu_domain_ops nested_domain_ops = {
>>   	.attach_dev = nested_attach_device,
>>   	.free = nested_domain_free,
>> +	.iotlb_sync = amd_iommu_iotlb_sync,
>>   };
> 
> 
> I don't get it, what is all of this for?
> 
> iotlb_sync should never be called on an IOMMU_DOMAIN_NESTED.
> 
> "nested attach paths" should never have gathered IOTLB state.
> 
> Jason

Right. I missed this. I'll fix in v3.

Thanks.
Suravee

