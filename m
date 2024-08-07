Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159ED3A267
	for <iommu@lists.linux.dev>; Wed,  7 Aug 2024 09:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723023067; cv=fail; b=GXoetRX7XsOSSI+vMIGvWiQKpkbbQ8tfZFaceZSjU517qo4bKPrg3N+cvvTAwGjRt+uubZi7jdpS6bS56WJ8eUiZU3DUaqfT0AIcvFPjjTkZajRniJtVP5aCUOrwVCPd7JoSywbVbKFwgZhW3iWXGw+9ote50Y3a/luepWbc3PA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723023067; c=relaxed/simple;
	bh=roWeLR4nBeLeD2c7uaiFYJKVXIslkIBfRVjhMxCgegQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lguOB+vbfKYjMBm92sW78AJA7mkiqhLR+7lCcriORsEjHUwyuIrmHo0vD9+/sWqRbkJrv28axVab5hYnhtbiclqobIRYVTBol6caA9hEkI2YYUOHZYU9B0RNl94LPyZBQtExmRRF1xJjbYFUNEqqC500rpbdoFIv2u6MSJM0JnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cR4siaRY; arc=fail smtp.client-ip=40.107.93.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cR4siaRY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PHHDUJVzx71K9CKZO9BTG0NewUSXUy221Lf++w8pfKVH9UtZlv074wL+iYaj4/pKRir4BG/nAkOdRDJp9GhN5wsfPp3Rai0HQJqkmGs5ez0YNlIX3QibumGHGXV4ZRSNhi3OtWn4D3Z8PcslfBEH5jWoDHKfQrf68bHKWpUinRUgPfbkP43D7ffI1qZPFBEk91flyOSAq6H6MXHH72tuxXalABUdSs7xGPyUn7sqYraUFo6uKuUy+Jq84jA+Ndj3GFJUQJ6YvhuMSYn6DvLjjUlktJSEZiD5CSQTfTrJ8ipntmVqReJ4k5x/02hiFuYQaiUWizsitgCA5RPLButvOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HMuNI6Qsr3w0J0AN2/eHfkBRghDomQsA6YrMKfTGJXI=;
 b=WcydzJHBeX25MPXgUuky8/liWG4de3fOBVN7erQuVTrXPTq2A7XUQzd5MJqSckaPOTZRGztfZRb7GprPRPBeq/UoV/1pLNXWnh6CO+MfmxUsLQYoUQ6MuN4MsiK5GLpX7ydzkVfC8mYt+q9gITqybHNaXxG/DCw5NbiQGlWQh7vsyACW9X7cFz/SbKAhUZwuRBVTKbkJqRnv/frcUfwXiAev8VKoe+V3sLrw0ixg2QgCdLOB29jUQrIbJLeIsEoZxqV18oDc8ncXq3Lflgjwv2LT20zaNEvUL6nE97npLMbYvYwPAHOt5iSGL1Pa5IDHiMKWZwdxCdfwrg8c51+XQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HMuNI6Qsr3w0J0AN2/eHfkBRghDomQsA6YrMKfTGJXI=;
 b=cR4siaRYcM/viyNUG1AS+Jf2OGy+CSqbd0v9zxmAU0dT9rcW40+iS6CfUwkIsVMqmq+RQMMLxiWUQWlHvAAAysiEhValZ2tJ8vgYoesyXAwsSsbgbEeEs+p+aL8EmK5us+Eg6RExu29Gcc56LXcAtjidEtfWF2hjZH0HY3q1eSk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CY5PR12MB6408.namprd12.prod.outlook.com (2603:10b6:930:3b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.13; Wed, 7 Aug 2024 09:30:59 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.7849.008; Wed, 7 Aug 2024
 09:30:59 +0000
Message-ID: <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
Date: Wed, 7 Aug 2024 15:00:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Baolu Lu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, yi.l.liu@intel.com
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240806173230.GS676757@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MAXPR01CA0104.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:5d::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CY5PR12MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: 12a59bb2-b713-4c2a-5ecf-08dcb6c3a54e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZlhSUTM2MEtETmVlOGtZNHRZZkRnUUdFWGk3cExiZEhlbHNPbjhHaHFKbUhw?=
 =?utf-8?B?QUg5MHhuM2lPU09zTnJxMnBCVFZvcmVRQzh6dklabzVIL0c0TzJUS2xEMTNX?=
 =?utf-8?B?c0F2MzVsNGFtNFZyTFMzNVdIZEwwOHVCTmZoVW5hNWlCaERPcWV3OXo5QzRE?=
 =?utf-8?B?cDdQQXV3Z2xBODVDRXA3Q1VyV3V2eGNBY1hkcVpES0x6K2lOSjlLWHRqYTVO?=
 =?utf-8?B?ZGUzZlh2OFlaaFRqZy8zR1VlUzRjaWp4Tit5ODlFb3FyODJybGNuMHdUN3ps?=
 =?utf-8?B?Z1N6eFRyMUdHZysycitDTWphNnpqVHJvQlNmcEs2OG9kR1crRUt5MW9jamVt?=
 =?utf-8?B?OFp0RHlXOTlBUW5nUUJ3dERySzc3MmE2dFpxSnVRdVphYjZ0ME9UUFlkZnY4?=
 =?utf-8?B?OVpEYkZZVEJPdUFrcnpTWW0vcXZvV3N6bWxlS1BxQjFYUlpraEJHWVk3UElS?=
 =?utf-8?B?cUpZZ2ttQWN2RW1lMVpmendIWUpOWHVMRlVEV1M0cllaMHJ3SzVWQW41dWJV?=
 =?utf-8?B?Mkc1NHhCYmlpLzdXWWJtTXUzUHBmS0txZGNWQlVpTG5RTG5kRnBFZ2lYUE0r?=
 =?utf-8?B?aTRDS05YOEM5NUdIeUNUUUs1UnZoU3g4U0d4Yml5WUlzQkZPS0FpNGlDMlEx?=
 =?utf-8?B?ZHZwd2lEajU5dGJ5SEhTWiszVjA4Tm1Jd055Mzh1YVVXYnVuVmhUU2lMR3lk?=
 =?utf-8?B?R3NISXhWYTEremxvTWFaM1UzOTdMRXp4Tnp1SmpJRSszb0h4ZUIvdHRoUTR3?=
 =?utf-8?B?WTd6NzBmWDY1VXVWRE5DU1RlQ1JYYTQrZmtybysrRXRnK0VtVlZMZUlGQVdl?=
 =?utf-8?B?M2ozdWhuRkVoNitiUGtGam9hL0tPOGtJZDZFV0JXdGVJZnhGMTNaZTd4aVpr?=
 =?utf-8?B?RHBZdWFwQW5rNHhEMmVaaXJvTGsyNXlRNlpxQjNnTW1ibUxCZ3cxVEJmZFNk?=
 =?utf-8?B?QlFaOVVOSXhwUy9PRXQwSmtVa25CNWlkUVI0OWczbUJFY244Y1NiRGNvNjVF?=
 =?utf-8?B?d2lPbkVKT3QyR1FhMXhYWjlkeGZXOGpyKytiMWhVUVBOUUNLTkg2ZlRWQWdq?=
 =?utf-8?B?WmQvWStkWFVHZWg1RmVhdmhmOHQwYVIyaG9KbmE3VWVkaDB2b0dRa1RueHRv?=
 =?utf-8?B?dk5zT2NkUTlvRndFQnphV3cwYXZ0eUEyWngrNkh4NUdsdGVKdVQrMnpicE0v?=
 =?utf-8?B?c0pQYWlmZVUwZmx5dmZBdW9HK2N2VTdwaW0vL2NqNHpQM2RZcHBrV0JORmNJ?=
 =?utf-8?B?Vm43aFF0V3RDRkxlV1pRMzFsUm5hcmJDSE1pWWFjT2FsTktMZDZNcGxxVy9t?=
 =?utf-8?B?MHR4TDFkbStuUVVsR1ZhaC9zbklCanExbklQMExIK2hPc3NleHZZSGk5S09k?=
 =?utf-8?B?WnpvalhNMUFRb0lBWkhqOWxmSEZQSVIxU0ZtRGZIK0M4UXJWZFNVWDMzeTNL?=
 =?utf-8?B?M0cxQU0vaTVqTzRSR2FrK3d1VEhhUGpEUUt0K0hpd0F1UXZ0clV4RklRN3NF?=
 =?utf-8?B?V2xKQjlQa05pZEJZRHQ3MVE0Y2lnaFVzOTdCaHErQmdkSTAwL3ZxeE1RUzFI?=
 =?utf-8?B?VVFrc1Y1RGk5NzBrdkdhQWg4SS9hc2JPQ1hPQ2g4Q25nSFdldFFmNlkvUVdG?=
 =?utf-8?B?SVdaNXoxbXpHNFFNaHloQmF0T1BlY1c0cG9rcktyZjlKUHZoMWhTdis2d1dv?=
 =?utf-8?B?RjYvaDZNN3EyR2xjQ0tONlE1QjBtdGVjUmtRaUhlZHRsRUFMcVA4SGpsVjFa?=
 =?utf-8?B?QjhIUkF3UTM2MUcrUEhlZ0NRakVwdFBIQkI0MEdRUHFoZktUMXBUWHZjRWdH?=
 =?utf-8?B?NGYzOVMrenhDVURIdU9lUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b3NLTFNsOEZiUUZtSDkwcTF2T05kT0xGbjV4ZXFURXBjd3M1cG15VFdnV3hO?=
 =?utf-8?B?anhjYnBGRFZycU9wN2M5MHRtNU8vNzRmQ1dJdUM3Q3ZLK2ErTjhqUlZ6NitW?=
 =?utf-8?B?cWQzYVJSUkdyclpmTmVEb0xxOGZuYjJ5UGNCbzhwZDB1M3VIaFlReitXQ0Uv?=
 =?utf-8?B?cERLc1QwNWhyVTEyYjFCbFBZNHBEU0dHZndRTlk0MENtT0dsVGE3UUFpSm41?=
 =?utf-8?B?RFNxV3lreUhtaDZ2bWlmUVF1QmQ1aFRzd1dVUzdzV0NVK3R5cTlYQklhR1dk?=
 =?utf-8?B?SnVEdDkzMndzalNJUldLOU9RMU0zZDBIeEVzb0U4bmxZNStzTUdJdjFja2N4?=
 =?utf-8?B?VHQ4NUhPZGZyU2RvU3FwU3lFYUs1bzVBVmFickU1TzllNW5saG1sMldaUlQw?=
 =?utf-8?B?UFN1S2dsa3NLbFNaaldVczJYalNxMUk3WlNkMjZTdE1uOGNDYXhZSVhTSVlq?=
 =?utf-8?B?SFRoZ3E2d0JWbGdxb0hhbktCbC9aaHBDR3V2enBCQWhwOXdnQ003Q3BSSEhQ?=
 =?utf-8?B?MytBdmo3SGRzQ2VxM3l0K211NFRPVDgvcGVySzMrUjg2amkydTRFUk4zcmky?=
 =?utf-8?B?RWJFWlhPUHR5VkgyREtKK3o0OE1qaWkwVlVJTTNnTGpOYlI3ZlBISG9BYnFC?=
 =?utf-8?B?NEh1ZVp5dlgrU0J2anhPWkYyS25ROGx4VjNHajZ3cmROWWhZS0lYWGZKand5?=
 =?utf-8?B?WENSa3J4eVg3SmNTUFdGRktBTVNuUHNYSURTSzJlNlZLLzR3cnNnQkMveDd5?=
 =?utf-8?B?bzBiTGl3SFh0NWRUWXExTUtTWnRYVWhQaStCdUppckoxemE3eW5jbEVveHhY?=
 =?utf-8?B?UjV1NFp5U2krS08rMWx0ODhVZlBtM0dJamFwWFZKSURvNDhhREk4d2lWVkdV?=
 =?utf-8?B?ZEZBQmI4R3ZjMHYyaGw5ejlHZDE1K2JRRDg4cHQ5WURnME5Ic1ljWWJjTHQ2?=
 =?utf-8?B?OGZlMFpJTXZieUh0RW0rNlZUVXdIWEtlSG95MGNhV0Zac3BvL0FtdXVoSnRw?=
 =?utf-8?B?Tjhkc0p2RVMwanBaK0FCOGhGalBXUU4wSDdsS0p6dmJVbllXcmtwZGN3NGcy?=
 =?utf-8?B?ZFNCVXQ1SWNmeVhtS1NoYmN0OTRXMFFNbERWM0ZWT0ZwazdWV1o3clFabStq?=
 =?utf-8?B?VEJkS1plVUdhMUF1aHBZSGFMR0huS2FQdHJjVHQwaUVuM1UyNmRLYUszV3Ax?=
 =?utf-8?B?Ymo2c2dhRlJEb0p3U3hkYWRFSDJSeVJ5MTFqZ1hMYkpsSjcxYzRLWlErL1Zk?=
 =?utf-8?B?WEFhT0JOTGo2UTRCV2I1Y01xdEZsclZ3ai9DSGxDV2xodG1adHArVkp6bGVW?=
 =?utf-8?B?NW1jZm1qeG1EVVFqOWNZNytIQkQzS3h3VitnQVVSNEhHcWkyZFFlWlVEOUV3?=
 =?utf-8?B?cXVtVlVJWEJEVmFPck1BUFFzbEVnWFZGaEkxcXZoZ05Kc21RY3Fkcmtma2FS?=
 =?utf-8?B?djVnNGlJSHlIWHlURE9vOTRNT3lKMHlZYmxKQS9ITDZGYkNBTEZMRG1LMTl0?=
 =?utf-8?B?SUlwVVRPU2VJMXRBZXNEUVAxZnlkREJBNkVTaGxqa3pzQWtIYllYVzYvSnRm?=
 =?utf-8?B?VWNHemQ5S1h6bGpQbmxLWVhibjBIZnNRUFhnSjNWYnBhVnlVSVltczdpck1z?=
 =?utf-8?B?b1dBam5jb2J3Mi9mYW1pOGNORmhoMzFWR1hvZm0vd3J1MWJjMnM2OU1Vcm5p?=
 =?utf-8?B?eTJwSEFwZks4OENlVmc0WlJyYUZ4Q21iQW92SHFrbDVTeFpwam9ja1NNNGNw?=
 =?utf-8?B?c3g5V3hicGNoR2xwaFFjVWVnSTZEWjExVVlpenFYWlB0TjdYTzgwYUREV1Fs?=
 =?utf-8?B?RHdJKzN5dEJIL2M3VFJVcFkyeGxnNVdqLysxOHlMNFJZOUorVWVnbVBLeXBt?=
 =?utf-8?B?dUUrdmgxWEI0S21aWE90d2QrSkcva0tRTU9KZFFHekx2QXFGQml1TTR0Z0cr?=
 =?utf-8?B?N2ZlT0daZy9tWlA0OGRCcXMzZnJqU3VHT0F6cjVsMXRUN2RVZTVSNDhENU9w?=
 =?utf-8?B?eSszWDA4WGlGSTNENW14Z2V3RGRsemlTNjdwcE9TSkczK3ZnRXFQelVSQTBN?=
 =?utf-8?B?RHI5dEZxRWppTldFb3FoeENLRk5hRTRjVldqQ0FIN0g5TjRPUEx3bUN3MGQ0?=
 =?utf-8?Q?djNVh1sjOAOXPj4jhiRkmwDz8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12a59bb2-b713-4c2a-5ecf-08dcb6c3a54e
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:30:59.1263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R5UQdPx9f0aaG07GtPL17TC96XS9D9enFxdzCnwjjNwtpivIX++r2DunrpFx84M3E6VtuZc7+p1Warqez0jGEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6408

Jason,


On 8/6/2024 11:02 PM, Jason Gunthorpe wrote:
> On Tue, Aug 06, 2024 at 08:11:19PM +0530, Vasant Hegde wrote:
> 
>> I only have issue with allocating right page table for UNMANAGED domain. In this
>> case just 'dev' param is not sufficient. Ops should send some sort of indication
>> that its UNMANAGED domain (like its non DMA API domain). Otherwise AMD driver
>> cannot allocate right page table.
> 
> Be specific, you mean when VFIO allocates it because VFIO is almost
> the exclusive user of UNMANAGED domains on x86 hardware.
> 
>> My understanding is we essentially have two modes for device passthrough.
>>   1 - Existing interface where vfio driver manages page table (call
>> iommu_paging_domain_alloc()). No PASID support in this mode.
> 
>>   With this RFC I am trying to solve this scenario.
> 
> Honestly I'd prefer you change VFIO type 1 to call domain_alloc_user()
> instead of hacking domain_alloc_paging().
> 
> This is a lot more explicit than trying to push new meaning onto
> UNMANAGED which is trying to get itself removed.

Sure. If that works for all driver then we can change that. How about something
like below patch?

> 
>>   2 - via iommufd - It will use domain_alloc_user() ops. This is the interface
>> where we want to support PASID w/ passthrough device.
>>
>>    This is where you/Yi suggested to start discussing with Alex on Yi's PASID
>> support series. I am running behind. I will start looking into Yi's thread soon.
>>
>> Is my understanding correct?
> 
> Broadly, but I'd rather VFIO exclusively use domain_alloc_user() and
> it can accomodate both cases. So add a flag to indicate if PASID
> should be enabled.
> 
> It makes sense to me that type 1 would just always disable PASID
> support, it should just be done explicitly without the word
> "UNMANAGED".

Sure.

> 
> Jason


-------

commit 312c2a99897937834f6a679b6f9956288e8c93de
Author: Vasant Hegde <vasant.hegde@amd.com>
Date:   Wed Aug 7 14:42:24 2024 +0530

    vfio: User iommu_ops->domain_alloc_user() to allocate IOMMU domain

    - Include uapi/linux/iommufd.h in vfio_iommu_type1.c so that we can use
      HWPT flags.
    - Move dev_iommu_ops() from iommu-priv.h to linux/iommu.h

    Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>

diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
index de5b54eaa8bf..2a052cf4b000 100644
--- a/drivers/iommu/iommu-priv.h
+++ b/drivers/iommu/iommu-priv.h
@@ -6,17 +6,6 @@

 #include <linux/iommu.h>

-static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
-{
-	/*
-	 * Assume that valid ops must be installed if iommu_probe_device()
-	 * has succeeded. The device ops are essentially for internal use
-	 * within the IOMMU subsystem itself, so we should be able to trust
-	 * ourselves not to misuse the helper.
-	 */
-	return dev->iommu->iommu_dev->ops;
-}
-
 const struct iommu_ops *iommu_ops_from_fwnode(const struct fwnode_handle *fwnode);

 static inline const struct iommu_ops *iommu_fwspec_ops(struct iommu_fwspec *fwspec)
diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
index 0960699e7554..56cb1b6312aa 100644
--- a/drivers/vfio/vfio_iommu_type1.c
+++ b/drivers/vfio/vfio_iommu_type1.c
@@ -37,6 +37,7 @@
 #include <linux/vfio.h>
 #include <linux/workqueue.h>
 #include <linux/notifier.h>
+#include <uapi/linux/iommufd.h>
 #include "vfio.h"

 #define DRIVER_VERSION  "0.2"
@@ -2134,8 +2135,14 @@ static void vfio_iommu_iova_insert_copy(struct vfio_iommu
*iommu,
 static int vfio_iommu_domain_alloc(struct device *dev, void *data)
 {
 	struct iommu_domain **domain = data;
+	const struct iommu_ops *ops = dev_iommu_ops(dev);
+	u32 flags = 0;
+
+	if (ops->domain_alloc_user)
+		*domain = ops->domain_alloc_user(dev, flags, NULL, NULL);
+	else
+		*domain = iommu_paging_domain_alloc(dev);

-	*domain = iommu_paging_domain_alloc(dev);
 	return 1; /* Don't iterate */
 }

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 72383f6bdd9f..f911c112eead 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -1048,6 +1048,17 @@ static inline void *dev_iommu_priv_get(struct device *dev)
 		return NULL;
 }

+static inline const struct iommu_ops *dev_iommu_ops(struct device *dev)
+{
+	/*
+	 * Assume that valid ops must be installed if iommu_probe_device()
+	 * has succeeded. The device ops are essentially for internal use
+	 * within the IOMMU subsystem itself, so we should be able to trust
+	 * ourselves not to misuse the helper.
+	 */
+	return dev->iommu->iommu_dev->ops;
+}
+
 void dev_iommu_priv_set(struct device *dev, void *priv);

 extern struct mutex iommu_probe_device_lock;
diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 4dde745cfb7e..6f622eece1f5 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -359,11 +359,14 @@ struct iommu_vfio_ioas {
  *                                   enforced on device attachment
  * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
  *                             valid.
+ * @IOMMU_HWPT_ALLOC_PASID : If set, allocate a HWPT that support PASID
+ *
  */
 enum iommufd_hwpt_alloc_flags {
 	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
 	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
 	IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
+	IOMMU_HWPT_ALLOC_PASID = 1 << 3,
 };

 /**
