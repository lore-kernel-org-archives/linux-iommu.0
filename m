Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4703213BAC3
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728029556; cv=fail; b=Yw1AT4D1LtoOn3JTIySVF1fWyOe1jigdA31/crEEwNjq1U4hQ08Cd7ePkpulXIdu4K5W6CmW78Fl0KK3pHU1R7Pqrbzz36aOoESZf8EYndzrPRSLgnM6fyMos18mrO9J1TBn/E48YTrFWfvptJjUck2+biEYxPi1jZ6e/Yk+TzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728029556; c=relaxed/simple;
	bh=R6bPAF7puTZjGXTaneaSA1NFvVpnQ+UQoOz6DnyaCmg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TsgW9JruUTOePjs9D2hfOKtCE7ICFwm6VZEvuE1PDdklobbySgGJYAJeckTUsj5GtyTqFOI7bgeLFZ8J6ZFSkQZYOs7OgKgHALWG7mHosj3Yjpt0AWfdkC1EbjOqaOgLva+Qk/PvwnCz1NYATvtDH4RxVO1nXzrcbO+ZW/b6hEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lbz9WTJ5; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lbz9WTJ5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IM6jQE4g1TMK3taEBEeWqodUNHxZG70OcbUMU0phpfI8O1LGlPtlIVnZIe5r59ROiPmStj1Ot+iwI7fihc4AxjxxlMI/u9jcRZD8qkCQ2qR8OQoe8XbAirx0YUvrEt8GKEnI70RijLD3T7U0vW0Yy2DVbinHvwNyUMQAFbg0tmssmMIim46nvckHBl8SlzGVLBMB8Tpy0BFLfKUsgl8tQrXKzaUjYuUKZHZMKOAJmr4DBhvlbNgR5kIjt06n3dmD3CJALyC5RsIWPm2xWRx1okzVGcTae6D94vqHZKDR6lUSVCG+QSCTO0CJXVKM9uFcqUulLIJZOYFVxiDMHGEYQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x56mM+pb3y6OgKiNJ6T65wDAtbOMQBYNECkEi+aNYEs=;
 b=bVPvv4qZVsYCvKS7rZmDnp2nIt75kW3MTJjUP654dKtFASl5eKiRdZdbBC3RdcqmsWfm0IQB7vXb1hCcNF8C6Na3fmMvtNUovCXAxuCu1GihepsNGvNUPtwbfbxUrMxQMWH9Y/MRvhpSVVXpY7tTrg9TmzXzY+GRhYwUpntmrwLwSPr5MB8K9mWZ9aIwLkj5it6gIv43Jv5Mo/s32PEq+wwo9CtxIglLmXQRdFwdzbN83ENKlqMJuk8OjATDmpyWMrx15+RB4+mGhIaEBUQtcquBcMQ0yKSBWAWXErHgftUNJAMrcK+fQ0+P3QBlHLFaIRk49JS1E0fXlQtx7adtrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x56mM+pb3y6OgKiNJ6T65wDAtbOMQBYNECkEi+aNYEs=;
 b=Lbz9WTJ5IxV5OCpcihLKiiyEa7t2f4EcZBFmKnpZah7a8ACQZJMxpLOZewVc8dhjmmiO4ROtwVaZavB0CddJhVZEtdtVt9vzkdn4q+dWoeIqDpMYZZLdmkDZPo2kIxe7bQsHAs0oErYUWW458vR6gDL9TV2RefAz2+okjBGPHZI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA1PR12MB8117.namprd12.prod.outlook.com (2603:10b6:806:334::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 08:12:32 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 08:12:32 +0000
Message-ID: <62b1b771-fd79-4e1f-a494-4edfeac65d0a@amd.com>
Date: Fri, 4 Oct 2024 13:42:24 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/8] iommu: Add new flag to explictly request PASID
 capable domain
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-4-vasant.hegde@amd.com>
 <20241002192320.GP1369530@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241002192320.GP1369530@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PEPF000067F7.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c04::2e) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA1PR12MB8117:EE_
X-MS-Office365-Filtering-Correlation-Id: 030c1e6f-a25b-4227-b0a9-08dce44c4b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjBqU0VPNHAxVVBWOXlzR2hYd3lnSWUyZmxST1pZaFpMdFErQThNQ1g1dk5o?=
 =?utf-8?B?UEJLMGYrMk80WkYwTExzQi95TjVqcm15elk0K281U3JKNFBxeWRGY1FJSkhS?=
 =?utf-8?B?S0tLU3lIeFhiamQ4TmRETGFNcVc5ZFl5QVIwUFQzbFZrbDVNNk1rTWtpMVIw?=
 =?utf-8?B?YjdnZGFKUkljR09WUHdkQ0QyQkQzU09SNnlocWhpSXJxTDZ5K2hEVXd0Uy9w?=
 =?utf-8?B?QzhnNlZ4a2MxTlVYMTcyREtPODIvdHJsSzV6Tm1jS2FZNng0UDdRUnlrVElJ?=
 =?utf-8?B?NzRGYnUzTGQ1aktKTm5sZ21kd1F3V3dKZ0k1cEc0ampjbHNMOW9FMk1FNXZm?=
 =?utf-8?B?OUYvWlFRc3A3NzAxSXRtS01RUjl2ZVc1RnU1Nk9EeEh1QkQ3czRYVmd4RkJH?=
 =?utf-8?B?aGozVmpnNFRqTmYwb0VpSlgzR1lKRTQ0S3RuRzZJaytRU3U0QmFIdjdoM3Fw?=
 =?utf-8?B?bEJ4RVVTaGhJeVdBZzA3enVvQVdydk12WHpuWEg2YWFOUmYyTjFCS29lbUFh?=
 =?utf-8?B?NUQxeGRhRnNBbkkwemRJRVBJOGN1LzU1Y2xoRHVxVFFhd0VEUEFRaHAwaGE1?=
 =?utf-8?B?eFRlemNlNEpQeHZnckVleHdHczNwaXBnVzJZR2JoNFJIczdteU1Sbk9mNUtK?=
 =?utf-8?B?dURpSis2L3ZtREtFVjZWeVpkeDA0VkczYitXS05zWS9ZSDlrUFFIQWx2ZEc5?=
 =?utf-8?B?RU9JRTlGT09qQmxWUDhRdGRtN1d5YXlIaHJEQWwwclBCVTFWNjVKd1V2dVF2?=
 =?utf-8?B?WUVsV01Ebm4zbHhEMW5mZkh0UTJrQXY5L1RqNE81eGxuZWFnaTVBWjlJTGNI?=
 =?utf-8?B?VVRmS1RxT1FZK2dmVGVFUWh6bTlpMzE1aDlQT1hMT1plRWJLb2ZRU3M5ZzQx?=
 =?utf-8?B?TWsyaExsaENkdjZ6SldtN0lYa3RLeUpiOWRLWXRnYnVPZGdvcVpVb0ZSN1Nr?=
 =?utf-8?B?Y0pnRFVUTWhoTGZyWCtPZXJVNlVsNHR3MWswSUpWMGlvK2dUTW9PQ2NxY0hD?=
 =?utf-8?B?RWVPNHBQSkM3Mjd0dzlsRWhlVDNlSnVjTmxLZVErL0ZWK05jS2x3Qyt6cElD?=
 =?utf-8?B?VHBrWDJrbWZ0TGFsemM4R0RTME9kSFJJeFI2UHdwMDhOTnFmczBXb3U2VHVR?=
 =?utf-8?B?LzQ4REUxSXZOSGcvVERtVUdSRDRWbXlTQmxFYXZiYStHV00xS2NEVVdzOFhn?=
 =?utf-8?B?ZWpyWjhvdDE3aDhLWlF6dWxzQTBWaUxjbzN3SmJlaUxVT20wT1ZJcm5LK2t6?=
 =?utf-8?B?RFJzM0JkQ0xoTjZzODBJQlN2dWxKVWtVV29RaVVvKzZZaDBienpJWS9sVW03?=
 =?utf-8?B?OFhXZ1VlQStsVE0yN1RobCtTeWlBaE83NVZuQUF4SGF5ZCt3bWxIeHZNOWZS?=
 =?utf-8?B?b1A4ZU1XaWpyZEdxL201dEg4TjJqUXVvMkFuNWFieXpEUWlEUnNlczJYU3ZT?=
 =?utf-8?B?dWRySG5paDRkSmdyOE4yaUVFaWlrcmUveDdWVjN1cTBWeTIvUjV0bEl4N2Rh?=
 =?utf-8?B?VXh6WHFUTmNLdjdyWnZ4em5tYUppYmRRTnV6WkhhTm1nWHZKTTlRMGNJYmcy?=
 =?utf-8?B?enZzWFNsaWRETklFOVpLallDU3NoaWxSWWVkZVR3T1huMEY2c2xoRzk2R0du?=
 =?utf-8?B?YUZieVJqeDNUeFZ0VXI4a2g5OFBRRmhwS1ZmRGZJK2VIVWYrRUpoL0Q5a3Zz?=
 =?utf-8?B?aElYVzZlcVRGN09TZnl3WjFWdXhvYXpHRktGaTV4Q25ybVY3OHlSMVZnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T2lwN1hiYVBZOXhXT1ZrVDA5SWd2YlBETXBoRGlkU0hwTm1YcnlWKzRrMjI4?=
 =?utf-8?B?Y0lqSkd6dVNXeS80azRGdXhnYmdpWStVUnRRN1pOcFJQZjVvYkFPZ1Z5SDFX?=
 =?utf-8?B?RENtcThucldnVU5FZjZzREJmSk9nWkNxN2dRTm44TlRRWTd2Yk5KMEY2eWc0?=
 =?utf-8?B?VGJOd3ZaU2VEVi9haEc0SmltelpJYnZVVFpSU3kwM214L0w5emdDajYwR2t5?=
 =?utf-8?B?VEgxVG5nemJGTVBzaU1UYkYrSDBQZHVvdEFjWVZoTXJCM0xzZ3hzalNjVFdk?=
 =?utf-8?B?VmNoWjhMUFpKeEZQWXpOZUh6YU5RUW5qYzZzdDJVWkt2ckVLa2E1YnNaODRh?=
 =?utf-8?B?THRGbHZaeE9vYVYyNDU1NlRXUW9jTkRQeVg0MTBRQVE4RUt2T1VCZHlSUEVq?=
 =?utf-8?B?YnJwVmJxWVVxcnVMSVVxbDFFblBOQnprcVlqaTRwaHdtZHBpQUV1Ky9Ndmxu?=
 =?utf-8?B?SHBUUTVCQy9NZGhWTVQvb3djTWs1R1B0cnZrVjZNQS9taGZsUVhkYitHbmR0?=
 =?utf-8?B?RU40STV3Q1ZNdSs2a0hKYTRGbTBRY2pmVGh6VUxYbHB2NjlaL0ZxbzlHdnli?=
 =?utf-8?B?NWFPaWk5eUN5dFgxZTd0N3Z2RmJzWE55amdqdFBUbDF1SldEb2N6azVJbkU2?=
 =?utf-8?B?ejBrL3dhaU9PRnR4YlFiaXVjV2hMUG5qdWNWRW5zQnBFTDF1d3E1RzQza1Rp?=
 =?utf-8?B?QjBSVGgzdlkrajJBTEFqV2lTSXBrNDFwbmh5MlZwVWVmbGF0OUlWTENvM2hH?=
 =?utf-8?B?WmppQTFJU3JpQUVxVWZwMW1ocHFrWnBwRDduTHdVaVYxcHduWnpjSjB1cjZ1?=
 =?utf-8?B?MlNpa3g1aWphN2V1bEpjUG9rRHprU3hMMnllWEFoTHRjVXZ0N2QvbjZaZVpz?=
 =?utf-8?B?T0hIc3VDZ0Z5cGF4eEtScmNzcVN5NEdobXUrYkc0NGNGSkNTRFIrUGs4TlFk?=
 =?utf-8?B?VTZsL2phRlViVlpzdkJTWmJNSFVLNzJaYXVIL0tjZHNiL2hINWZFQmJ4UlhG?=
 =?utf-8?B?SFg2b2RaK21xUitWa0NiWFF0YWVCd004d3hwREFpM2pYc25ZdUxSKzMxMGJR?=
 =?utf-8?B?Yk94QVNLaXpUcHJyblJBdUY0SSs2aTVPZERNMVlUTHBWUnhLcXQyY01FcEhs?=
 =?utf-8?B?WThNV0poTkROdjl6MU5TMzhwU2VwNW4zNS9qV1hGSjNoVDZXaWpRRm5GdzFj?=
 =?utf-8?B?TzN3N3pwd1JoM2x3ZDRLanJWM3Z4dDI0eEZIN1lBQnlONWs4MHl3cEdKL3kz?=
 =?utf-8?B?b05PSytmelhGcDVyVGszQkI0RUtVQXQ2K3JrcTEvck9TN29ZWm10MWU3YVBJ?=
 =?utf-8?B?bm5WMXhBS2NzZUlSc21OWUNnMG9FcnJPbWxMS1ZFOHFGVENaTHl2SGhScHdY?=
 =?utf-8?B?WEpQaDR5c05ObisvYjl3ZkExVzFjRmt1Rkw3ZVJ2eEJSOFM3ZnVaYnRwYmdr?=
 =?utf-8?B?SjJ2Nk5QeVQwMTNsUmYrWVpyVkxRNlhEdWo5bG9zWFVMNzN0ck54Z0NUK01X?=
 =?utf-8?B?Tjh4NFlXUWZ6d0tIOXBxMGNCU2ltWEQxV2hHNzE2U3JZdVNoNjhnNmRFeUNp?=
 =?utf-8?B?RWtUNTZHc05yYnladkpaWFNEbVQySUNNRkJ1dnFkSVNqQjQyTkJpd0M3Ym05?=
 =?utf-8?B?T3h5V1dpOGVFUXVSVzRKVGRFTFVmN05QZS9yR2tGZ21CT0JUN2M0anR2bjFa?=
 =?utf-8?B?RlY4a1hhelV3VzMydnhscko0ZFpLeFBTQ0V5UDl0TitwZXR5Skl4VEpSYkta?=
 =?utf-8?B?d3NKL2c5NC9POERCek1SRWMvL0I5UkhOVmR0ZmkwcVlvZkF0YXA1ZjdJYmlq?=
 =?utf-8?B?UVNML1dpRVFZeU5ETU1RKzBMcUhpVUg3UDhabDNjN3ltSG9VN3Zsdko2Mndx?=
 =?utf-8?B?L05XOFYyTml0WlJtMEcwRmg2TDFRZ2RSa1JPY0tEbzJQWFV3OGw0RGVvTW41?=
 =?utf-8?B?cnFQTTB5YmtpbXpibDVjdDRKakkzalNyVVZtSXAyNjh1d3hjemxVSThLYm5K?=
 =?utf-8?B?ak94amF3WFNwdDhqZHBxRDFweVd6UEhNVGRpWldKQkRlRWcvS2I3M0N5ODhY?=
 =?utf-8?B?c1FDcVNXQXNROVQ5c2dEaEhYR0JsUkxjcVMyWWg1d2N4NHZSYTZpNEg2RFN1?=
 =?utf-8?Q?JazKoV7OMYw8aHWuM2+YSflW/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 030c1e6f-a25b-4227-b0a9-08dce44c4b9b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 08:12:32.0159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uXnyGbdOFIRJKBZWrkLf6ZqyOaoiAUbOMfuhiB4QTICDsdMtVKEyL7bVSPNwp4vY8SaECj/oGypn0vQWnn8wsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8117

Jason,


On 10/3/2024 12:53 AM, Jason Gunthorpe wrote:
> On Wed, Sep 11, 2024 at 10:19:06AM +0000, Vasant Hegde wrote:
>> +static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev,
>> +						       unsigned int type,
>> +						       unsigned int flags)
>>  {
>>  	const struct iommu_ops *ops;
>>  	struct iommu_domain *domain;
>> @@ -2059,9 +2067,24 @@ struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
>>  	if (!domain)
>>  		return ERR_PTR(-ENOMEM);
>>  
>> -	iommu_domain_init(domain, IOMMU_DOMAIN_UNMANAGED, ops);
>> +	iommu_domain_init(domain, type, ops);
>>  	return domain;
>>  }
>> +
>> +/**
>> + * iommu_paging_domain_alloc_flags() - Allocate a paging domain
>> + * @dev: device for which the domain is allocated
>> + * @flags: Bitmap of iommufd_hwpt_alloc_flags
>> + *
>> + * Allocate a paging domain which will be managed by a kernel driver. Return
>> + * allocated domain if successful, or a ERR pointer for failure.
>> + */
>> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
>> +						     unsigned int flags)
>> +{
>> +	return __iommu_paging_domain_alloc_flags(dev,
>> +					 IOMMU_DOMAIN_UNMANAGED, flags);
> 
> Can we get rid of the type parameter here? Like this:

This will create original problem for AMD driver. i. e. for VFIO we want to
allocate V1 page table (at least for now).


> 
>        if (req_type & __IOMMU_DOMAIN_PAGING) {
>                dom =  __iommu_paging_domain_alloc_flags(dev,
>                                dev->iommu->max_pasids ?
> 			       IOMMU_HWPT_ALLOC_PASID : 0);
> 		if (IS_ERR(dom))
> 		   return dom;
> 		dom->type = req_type;
>        }
> 
> Maybe at the end of the series, I guess you want AMD to not have a
> bisection issue?
> 
> I think this looks OK otherwise
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks

-Vasant
