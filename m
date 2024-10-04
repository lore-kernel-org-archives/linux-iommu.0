Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210D3215F6C
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728052365; cv=fail; b=JSsUoh4ZQ/21Ry2nDizerIrf9XR12snIo9NL2eTcluf+Uj5KCFO6aDIiwLMP4S3SPBu3XmFHqoUSCyixXRT0NFqtmZbxNJRM2+99MwjK3i00jia+0jpwTqLxq02cMS9JlioAmlUdv0LQWGYl4km8huwzJLt3i5L5UZ/87p09Zz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728052365; c=relaxed/simple;
	bh=ORROBDc4KtbOBblq60ivfYHJQjiC+X+H1PY2PBcFe2c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YcXT4AY9zIYfxJXjPoS4g6BJGOiubdrdnhOzWBoZRQzv4TQXs+aMFxmbV1q7ByPTEBNqhjXVYNErDlx8A7ezYsJGRFXc2OpxJjge0N5UalNR8X6ov4I4x7YkGzWFGvz7K2Ru5a5/0FebxQYINvqtC4rHLi6hvmvv3tVMjVHlvA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sE1QG1WQ; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sE1QG1WQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcDoJLqQniMVHO8B9aurxhxhTb2DnM5Ajqi+pyiZQQ+y7WHXpLBqmkjOrS3TtSaJf6x7hf8yi/9o/3OuAd3QqHG9XA0WVfTHltiKOxzLePAtFla+tjXXiceo7IdFK73fp9N3W/UCPudqAQceMb1k/SQhq0dUpsPA4ececAPSaEvoG3dJfxM32E/Q9Yk/j2JR05KQVSCuLLnkqVSEE1rE5FRWwj9z+b6x1BZjebY4RULoJrp5TyoqKefBn/78CL6VfJGGZ8LS5SWWWVfVZUy3MgbgNjq5+DGOzicSw7Uni3UNuxA2FxkDmuhaD3qIpK7MVEuhI6ZNPiKq6Znf/OmdGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIcgh/dpJ+jgZj3naU8SE7EYjwcptou3lqCE8l1baUM=;
 b=kzuKGeCWnZzjUnHYwcZR3Siz8bEybqz24v4SpsKjmGeQzx55pGWc4B2Iwo0h6OcfgCssqMH7eka5gM5SCB7rOOSrYZIMrQKstXEKW15aIu77L8qOm+zJabS4vFmwn4JhBXewK8c5DDqjHk4jUw0D6ibh70eXRwiCZ3GD9LZDImUAIShGHgXGtDow8eKNQ+CncCQehP0eyK2byFEW1ef3Az3B7Ea4OPZd+v/bXkHL6q0UPpcRcqmcN4QYtjkuR7pVVg0pX32Zz6+NOWQjpSmx6F2z4FDVRrefXBl2MeK87eTkmWWiz4vSSEbE7Z5WbZxVD+MXKJhu/wW0tYvinn2M9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIcgh/dpJ+jgZj3naU8SE7EYjwcptou3lqCE8l1baUM=;
 b=sE1QG1WQMvpHOinsUZaFvSUCHoowxEgYLQEZR/3JOB0mDXcVT1LExWbz3O9yMephaj0ax8Uqg0upskSfT9Hla/2BJjni4eH8M8NGU5IyqZZYPWaWv3t7XPdBqugB9DSLjJHEX9gbZwdk+g8yHN/sbecuv0kyqrrGJrO61Hboksc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB7427.namprd12.prod.outlook.com (2603:10b6:510:202::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 14:32:41 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 14:32:41 +0000
Message-ID: <8ea642b2-096e-402d-8303-4f60d2686813@amd.com>
Date: Fri, 4 Oct 2024 20:02:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] iommu/amd: Enhance domain_alloc_user() to allocate
 PASID capable domain
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-7-vasant.hegde@amd.com>
 <20241002193116.GA2428925@ziepe.ca>
 <ab325171-10b4-4bc9-978b-049f09c445a6@amd.com>
 <20241004124840.GG2456194@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241004124840.GG2456194@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:9b::15) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB7427:EE_
X-MS-Office365-Filtering-Correlation-Id: 1613a18c-2e2a-430c-2626-08dce48166d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHRRV2I3WFVFZnIxQkZSYXJ4VTRSd2xlR2luZ2tKVG9oRWpzdUhBTXdhcENC?=
 =?utf-8?B?Tkt0b09NV3lhR0xQVk1FRkJuOGxMNlJsa0pZdVQ2TzJLeTZMb3llSFczUUsr?=
 =?utf-8?B?REU4MHI3TFh1M2h5NForRm51b216M3lNbS9WQWRPSVhtSUl0SEpkTEd4NkZS?=
 =?utf-8?B?ZzZiU1Fpbmdka2JqeFE4OTJqQlJWb0p6aGRFTExrZ2lvSWgzK0svU0RPeDBs?=
 =?utf-8?B?Ty9jVXVDWHlOVDBlTDhpZ1VUcjlPdW9OY1ptWmJDNG0wUlNoUm8zaDRrY0lj?=
 =?utf-8?B?ZEExTzd6VHU0bnNGSlA4U2dZbkJBdUNKeUVCK3ZPUVkvVCtXNGdYWHFkVTZz?=
 =?utf-8?B?azhGUFVMUlA4T3dBMHk5RVNnTitKeWV6WmVjZWFwWGtqYTdiUURrSURQWXRL?=
 =?utf-8?B?aXV0T2R2YitpcnJzU1hpaTl1ZzEwM2Nxdm83T0kvOE5RZGJpSGw3WFdmeGND?=
 =?utf-8?B?ZldNR3pXUjYySHdGRTlkbHN4eHVVcU5jd1VmbCtxaHdxb0lRZE5UbndsSk5N?=
 =?utf-8?B?NklVSUdJS2NyeTFzaG02aE90TkJ0SUE2WkhiaWRNVHlDTzE4cGdhaTdvSkZY?=
 =?utf-8?B?QXdvc1JqMi80Y1RvZXNDUWZkdW9vM3UvcTNHTUVMSnh3QWdLZC9aWE9wK00v?=
 =?utf-8?B?UUpha2REcWxaSzJkdmVmQldtV0JnWnFTekoxOWp4V3EyTzJxZWNXWWFlZkt0?=
 =?utf-8?B?eXlyNEhGOFoxQkFqVk1acy9TZHBTNGRVZk00MTlSTEtNM241SzdkSG9FTG1G?=
 =?utf-8?B?VVRhSUdsOGZ3dVdGVGxXS2J3eUhNcmVZLzVMK3hWaWs2QWNidXVJRnBTKzRS?=
 =?utf-8?B?YnFyNnhPMFZPRFBqVTNhTDhpbUlNbmZqS1E1UFRLVXZQYUcwa2NPOE81RDRo?=
 =?utf-8?B?dllmTk5YUXZ5WmhjM2JIK2ZLN1d5RVFXc0ZQaWQvT29CNVRaaEhka3BCcXBF?=
 =?utf-8?B?TEp1RTFZT3ZJMUE4Q2I2ZDhGci9jMS9QcEZ4LzdFbWt6MFhaalpvWTZDWEpM?=
 =?utf-8?B?ZXpuc0tOblFaL01tRGQ1b0dqNGR6N01TZ2dVd3RBYmdRVElRQzV3bGk0VEd0?=
 =?utf-8?B?QzZsVVBJM013aER2NVk1NkhFVkZsczdNT056cjBCL05qcXJzSHBMVG9zb3Fm?=
 =?utf-8?B?dVN6WmhDVVA1K3QwZ09USjlwUS8rYWF3YnBkanZsY21EanczTzhCeVpXbk9O?=
 =?utf-8?B?YXJhTS9SVHlBUklWN1NUcjIzYW9qa2pnWGl5YU9hTFVJd0RNMm5qZHFBMjRz?=
 =?utf-8?B?a0ZienFXSFREQzg5RndrcXlOcktlN0lUOWFhZzdDbUdwRzBFdkgxdi9uNU1W?=
 =?utf-8?B?aUU2bm5vTVIwM1ptdm1NS1l1MkJJN2VTYzBObXJUOEtWVzVLL0ZiTEZ3Z1Vv?=
 =?utf-8?B?NldTRzArQVFNN2FvNGdiUUh1bTV0ci9ySnJiZzFSV29rQVYxZ2R4QWdtUXZm?=
 =?utf-8?B?LzNyOEFnTHZyZFVpMVhxcjBYcHdEZmRCK1JZT2lySTZrak1kK09ZdXRlOEhL?=
 =?utf-8?B?Z2puSlBwa0U0WFMyd1AwMUVmUm1BMnZqQWxyb0k1bWxzcW9ZWG9ic3hJdVBp?=
 =?utf-8?B?U08vbTNDejJwc3IvNEtaL1pnbFVveHdtTFJ0SjVNOU82bkZVb2RNMm0yaWUz?=
 =?utf-8?B?WngvUUFmRkhFdDIvbWRSdlZaSnAzN1V4RGlDK05DQXZBVW4xeTBQcFNlOVZ0?=
 =?utf-8?B?ckJHbS9BL2Y4WTloY2U4M0laYkJPMzVpbjVsVnFxVmlkdjBrc3gwYWZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTNmVkZUaVBmTGUyczU0WmtYYU9xOTF1dGJYNEI2RjZDalZUZ3hocWUvNjRy?=
 =?utf-8?B?S3JtSlRrdCtReVMrUXVDZG1RRnpSRWRaeWxFV0JadUJocytpWHM5dnpyZjk0?=
 =?utf-8?B?WW5JOGZGd0ZNOHBMekFhQkdqaGV4dFp6SzlCNmNZQkZ1K0R4N0tDTXJwRlV3?=
 =?utf-8?B?Y3Q0cUlOY3JDQ3U3WkdHWXZLMkpNdUxOcXhxM3pzTjdQWWlNUlppTCs4WW5W?=
 =?utf-8?B?R0hxOWZNY0p6ZkthTUZONHk4UTd2SFdGME5Wa2RETUVPeVZnUnZFRitZdDdS?=
 =?utf-8?B?WWo1UGVaOEhVSTdhZllaQnVhNGFSb2xhSkhNc2FXODEyc1BlTUxhd3JicVVS?=
 =?utf-8?B?MU15TEU5cDBRZUZNcEt3djZmTjgxWlR2UTh4aXNIUWx4WFZNMFFuME90TzlW?=
 =?utf-8?B?QUlQSXFJTURZa1dza3hwTUpaUFk0aTYzT1VzUTE0UWdlNVpFeXpic3RqU3Yx?=
 =?utf-8?B?N3hGeWtTNUFScmhqTVhBMXpVRmFtY3B5UytDYklmZWdjQXdrSm1lR05FM1Vv?=
 =?utf-8?B?WUd0LzRuRjJOMGpHZDBqK3ZCNnFkNURsMFpFVnZzQWlJNm83YW9xSXRMZnlw?=
 =?utf-8?B?MDdxM1ZiNnN3UmdDKzV6TkJJQXlpUldPU1ltc0lyL0w4VkNmUGV0RmxUV3Ju?=
 =?utf-8?B?VkZQeUtBdjRCYkt2MW8vbXhrYTJmVGpzTlUxcEJwdHh3MXlnYzJtd2VqSm83?=
 =?utf-8?B?Z0c5bG1tTmRHZHlYSXNzUzVxMDBUTU9qcFMzN0QvSzBkQ2tNNWNROElzVWFE?=
 =?utf-8?B?SmpsYjJ1NmlITDVpNWpRTS9UTGN4Ny9yS2drdzdRM1F6eGg0b2xydVdEQ21H?=
 =?utf-8?B?TkdHVVVJeUlpS0liK09jd25rcHBHWElVcVBDM2tPdzJiTklNdUlMRjVlYkNH?=
 =?utf-8?B?d1drRzh2YTdrUmZ6L1h6cklTMU1yQVdaYnJJa1Y0R25EbGJVZjQ0NFR2WXlO?=
 =?utf-8?B?Y1JPRS80allKanlHMmhpWndVWTc0UVdUMVFMTzF3Uk1NQ3NDdlVZZU80WmJC?=
 =?utf-8?B?R05hdDdMSTd5c2tyU1dSOGJidGdJcW4vRW1JUFpaQUM3THhNdGVyL3psem02?=
 =?utf-8?B?SCs4RzlJb28xTWVuSTZtYW1kQ0FFbjVPVy8yUnc5SDh0ak91aUN1cFdEY0c0?=
 =?utf-8?B?S0RsMnpTVWxvc05HVkVvSktBbWQxK3hwbUZod2ZNbEhkOHFEV1JhMDQ3d3hx?=
 =?utf-8?B?NnZFRUJyQTM2cWQveUF3U0w2MEF6YnY5Vm5JOE1ValROV1A3V2pPMWxQT1Er?=
 =?utf-8?B?MnAveXdhSzQ1Smhpd3V5Tkt1NHk0N1JtUm91SFgvS2dDbkdmYmVkUWNnb1pl?=
 =?utf-8?B?ck1aSWhrTXAxdDQ4ZkdzTDBENlFMd2VnamdReDN1RytuYUJnOHgxV3krK2cx?=
 =?utf-8?B?MFNGZXNIeEQxVlNlRWtZdkRZR3dxSGNaQ0hPMjlPeDNKZE1UVk8zTEtwUWxW?=
 =?utf-8?B?RGlFU2xlVG5hZHBhd2trN1QzV25PRmVvbEF2N2d4VTFBK2dmUXRKcXh5WTFu?=
 =?utf-8?B?TE5aU2ozaU9FRzdjVFRYRmZqYzZ0aEI0Vk9EMVdyREthUG5xMzRSbHcranl6?=
 =?utf-8?B?bWR4a1pQRGMvaEd6NzFDRWdCaEczWkZSNXM0cGZXckhwYldDS2JJK3k5NkdR?=
 =?utf-8?B?TStMa09uRlZDZFJRdlNUMk9WS2tsU3hadkVEQ0xHc0ZkRG54NjNkbUxZb3U2?=
 =?utf-8?B?OTAyVVQwNWtuRjFKNEc2dWV2aEFUZE1RNURxTXI3VjQ4ay9oVjlWcGRjVUZG?=
 =?utf-8?B?TjYzVzU2azBuLzZoMzR5LzM4T1U0NDBSZmxORUhMZXN2QUVnTkE3V1BSUlhq?=
 =?utf-8?B?ckJ2R3FKakMvYUxXNlFHQUE1RU5TV09xY040ZDNZeEU3bWw4aWUyOFVEUnVl?=
 =?utf-8?B?NldNTFBCc2V0bjk1Y3NaUHl1QTROTFBCeDU2cG01YmxKbyttN2tUZWxuaUlC?=
 =?utf-8?B?dU9XVnVhM1JLN3B5L3RTemdxUG02YmFIbG9pZEluNHFtOFBNb0hYRmF2V2Z3?=
 =?utf-8?B?NlZ1VXEzNFlmZTcvcVd4clRCNHBwL1pmNVZNMjdrVWlPb09acVlqUTRWTWwv?=
 =?utf-8?B?ZDN5eXhyL3NYWithTlFWK3p2c2V3cDd5ekx4T1lLbFZuSlEvREdWa25LaW1X?=
 =?utf-8?Q?+QC345KxmzwSn9wIfy+Qf2gBf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1613a18c-2e2a-430c-2626-08dce48166d0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 14:32:40.9719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WDN1ZDVqRerCG2ayXbThC83FvrqCi5SEW6u5v6gnvhT+G5WOYNKOjcsIOX3bBg/2GNqL4aOY609tGJADTjAkQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7427

Jason,


On 10/4/2024 6:18 PM, Jason Gunthorpe wrote:
> On Fri, Oct 04, 2024 at 01:48:16PM +0530, Vasant Hegde wrote:
>>>> -	return do_iommu_domain_alloc(type, dev, flags, AMD_IOMMU_V1);
>>>> +	/* Allocate v2 page table if IOMMU and device supports PASID. */
>>>> +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
>>>> +		if (!amd_iommu_pasid_supported() ||
>>>> +		    !pdev_pasid_supported(dev_data))
>>>
>>> The test to disable v2 support uses:
>>>
>>> 	if (!check_feature(FEATURE_GIOSUP) ||
>>> 	    !check_feature(FEATURE_GT)) {
>>>
>>> But this doesn't check FEATURE_GIOSUP, just GT? Is it OK?
>>
>> Ah! You are right. To support V2 page table, yes. Will fix it.
> 
> I think you should eventually define more useful feature flags:
> 
> FEATURE_AMD_PGTBL_V1
> FEATURE_AMD_PGTBL_V2
> FEATURE_AMD_PASID
> 
> etc
> 
> GIOSUP is too narrow
> 
> Then all the figuring out can be done once in the init code. There is
> also some CC stuff changing this as well :\

Right. I have few things to improve in page select stuff. I will try to cover
these things as well.

-Vasant
