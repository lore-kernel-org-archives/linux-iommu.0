Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82142558205
	for <iommu@lists.linux.dev>; Wed,  9 Sep 2026 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788972466; cv=fail; b=AiNW53/nQlF6Blcop5dVom0SDsFH5Fi5ZJaBwjfWtKrQdQYLsFFg6FnBXGk1rXtL/miAG3xMukoQw5dNwjBnrhEytZf9fnvJZ7/zn0G3cR9CkLzbiVyNdmYdyRC76GxfASTmuaJ6/SLdvXEM82C3AQmJGEI3hZZhBXi6tPw+TGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788972466; c=relaxed/simple;
	bh=Ae3Bkw4J7YjN3b9zPLUkae1pYvMGou5rhgT9LFeCtKI=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=VDfOcAsJ0s7LFFmfF1j/h9N1HcyX7niou+gbWHhcrRQilH6HeEYaAgn0ipuh1TcBWz4PgtqCMAusUABwSzASLgqRM8wPJ6EUxc1X6tJT37gh2xgH4pR8VMVZwTaaBFttfx7JP/XtwXVHfbwsLinEVn9UtVQ8C7IukZWww2xI8nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SQxEFF9W; arc=fail smtp.client-ip=52.101.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SQxEFF9W"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqV9v0vKsLWr8tX74uHyJsB6KcWaN/eDdYxFBrAF9LypT2vTKT3SAOpP2bXc+Ofb6mjQwwTDeY10ZXm2sj+prX2156N1T5QnPm3sDaMSd6c4A5dxDjTWvM8Cw7ijXz3UQLij07rU1uot0DnKHHKii2xYrLZAO/KjpMACp45jIPpui17n1hsy8G/sp9cvIGALxOGGa2ccDzRrAwvxaEaNS3dp9Wu9vrNku7vRGUOWyn4jmbI+du7x9xgOTVaoUqONWqQOWMdq1wOh1nCMGA61AH8WcQ4ICLg11g/jr40UGWzwkmH5Mfoeb0fRehYB9YQBaNTZ0R8QC4akefeXfYEs1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wTg27hJRSiJsZEIddFIHXyby3ndLLwctrrhwudCMPo=;
 b=VAudu8GHDyN1h5ZAtrGDztpSd5nGQAaseC1UNwqsEFSlCmIXmcggtTGL+pt399mJH6YahjtImT2yWyg99EzMTiFacS6/UnuOljAAgvwxe85FaUDwtdxztKyCZMC1wwaG4j5/Pk9pW6NRmsBZAkxahl2ArA12rXnS37jC1eIsCBHTR0dKnMPVpt/V6+Felie1kIZJvvqGMCj4t3dkqqX5z/cR8JpP6j/i8Yv1/15Ua+ud08NQ0ATDOT326QEb/1V6pAHtljTiLpKBUJjBPIzxkq96bUjjnNca4OsIrT9d7+JdVJVWMiw8z9XIOAGwwRlBVcIiGkwSEjv7MErq2HQhNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wTg27hJRSiJsZEIddFIHXyby3ndLLwctrrhwudCMPo=;
 b=SQxEFF9WTBsPzDlXMdeepmnXg7Lybf96OSolCRWFcyZfGphuFTfSUEASjNgTMM2FKf3jCHmwIEdPI8gM2sPmdm2LGshf+Q+ULxVxJxCdGP2EJRTIDY7tkBHKz7IbswPegEohLqQ7khexc9vLxVb5jk11uhgNQ4YzsFAYsaTnN3FbrM7xlwSTMb7c+yQAPeKtLg7mztrrWjtJVc0NjMJgyeUQZrI6WKnhql8HdotFM9EAReZHe1pdl+Udy02kINmIihvQHD2X7JJ0LXGij4+iiAN8rRSsCzJ2Pu09UIS/pz6LLCWI86t+91IrrNd+7iVmvCXnyv6F/t4BOCI8uLylxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BL4PR12MB9536.namprd12.prod.outlook.com (2603:10b6:208:590::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.8; Wed, 9 Sep 2026
 16:47:38 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0406.007; Wed, 9 Sep 2026
 16:47:38 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] iommupt/kunit: Unmap in the tests before freeing the
 domain
From: Jason Gunthorpe <jgg@nvidia.com>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: joro@8bytes.org, will@kernel.org, jgg@ziepe.ca, robin.murphy@arm.com, 
 baolu.lu@linux.intel.com, kevin.tian@intel.com, smostafa@google.com, 
 praan@google.com, skhawaja@google.com, iommu@lists.linux.dev, 
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>
In-Reply-To: <20260831064256.2233356-1-xiangzao@linux.alibaba.com>
References: <20260831064256.2233356-1-xiangzao@linux.alibaba.com>
Date: Wed, 09 Sep 2026 13:47:34 -0300
Message-Id: <178897245484.4136580.9709345085141985794.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: YT4PR01CA0268.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:109::11) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BL4PR12MB9536:EE_
X-MS-Office365-Filtering-Correlation-Id: f2021009-16e1-490f-bd3b-08df0e920e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|6133799003|18002099003|22082099003|5023799004|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	VaD3R/sAYKgYfrMLmYMKy2mC0/BAqNlgI51iCgHTHiRRytPfR6HotBJiwRH+ZwrB/tuRCXePESLIRAriAjrWvOW96PJZyJXdZKf3/a4aYB65q/OwqzIea/McaULRCkazab3Q/HmKeCXPejBoe9xAFM/b94ka+2vvX4wdQeTIXsEzORDHh6wQf9XlOBK9xkLwJ8JM8BBZWqwovXpbtjfNniGlJtG0L+nWLMrdGxVyO7QVv06ID+F8dRZPuoZCDjBaQd3kMBuNeQ/prfGiJ93eXKRiopO7t2IrZOczV7qMk2NUY0plgfBfgoMbYtlXmSxgWg+uer3rakN/+6Fc5nlfNhVxUpXSdlu+Tgrtq6tuc4OuC5chbiJj49FwatUJrL0QYjaG2Zlh9o2MwPdYM3PSBQjUCasjqB7cwzRVLV1kdr3dXXYgZca7p6fJnDrEXPbgYisNPexYhB5X/Ey5Lofsx/pm6d0h4vJ+1rrAwZJ9AceEDc0V2aw22kCL52Q2g3StOkEBXVcF2/Q5wC3R3AOFJzFpxFRuB0iH88oEaWSYyb7ED8ZsITGgvJawFiBjAyRA2gvkUrwjVzRBfGVxvlwqZ7OSK1NhejdtdNSUoyb4zT6lpNxwCk8Zcb4H6vPRsv46ON3prbomyu5Me0fBRPdhlYTH19ANAqR3h8K72BYdiuU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(6133799003)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXNHZ291dmVYdTAvYkFGRmpBSnpVWlhxOUdsTFllcDJPbWdNaGZ1SDFmZ0pk?=
 =?utf-8?B?Ylk1VWYrTmJoVzFHSXJXY0RyZzllNEFkL1FFcS9MWmlDRDVDSXduN0VFZkRV?=
 =?utf-8?B?SFhDNGk2ME5INWNDMEFMNERycGRjelIybzhLMnZWV1RaMW1LYjIyV0pYckdz?=
 =?utf-8?B?SVBlOGZ0SFV0alhNRWdZQys5QW5yVE1pcVk4TkRQalFvL2cwcXFUQWdPdFpO?=
 =?utf-8?B?dWgrdlZBWGFqWmNheW5UTjk1QnlMOXdZV2szRVY3YWlOQW8wTWdpTlpvTlFj?=
 =?utf-8?B?OHZkN2g5UUVyRFVkVktGM1JqcmY1SzkvOHBNRjg5NjZaN2ZMRld6cGI1cVMx?=
 =?utf-8?B?ZXpXMkxSeTAyMHQ5cXBlR2ZjZHZveS9sanVRWGF0TWg5TU5iV3dQKzRSalFz?=
 =?utf-8?B?RGNoeFErM0pqOXNEWUFjM2VsZlBSVDFreXhybFVtamxQeXozSkNCdVNvOUJm?=
 =?utf-8?B?RG9UUUpzeXNwWWNjeGd3UDM1MzVsaXNaUGtTWFZZSWE1T2hhQ0RrTk0xbE01?=
 =?utf-8?B?a2RxTEp2SEo4bEtacGRSdWsyMGI5M1IyUkIrZ2JpRDUzZWRmRmw3V0o3OE9F?=
 =?utf-8?B?UFBMS3BkWUgvUTNzYU1IMEdkS3dOSkpUWE5JUWl3ZjFXaEZyYzlWMzR4Sjd3?=
 =?utf-8?B?d1BDQ2l1ZStNNFhtODg5NjBOdmlvTVphbEM0TlZWallaZlhMMERpTndsblkz?=
 =?utf-8?B?eUpzaFlxd1o4aGs1dnJVS3RpMldkZ3FsWXVvNGVpU3BuOXhTNnR0SnROL3cv?=
 =?utf-8?B?TzRYZ25VVXpDNUtNUFBleTU4ZElCaUpxMWRHK2VBQWh0dm9ad1hPSUdrc0N4?=
 =?utf-8?B?M1pBMFpqdWUyVkZQb2VkNVZURllFNHdEcEpuUDlrL0NseDBSZ3o4TzV0MHVY?=
 =?utf-8?B?eWNrT0xTU2JaWE9FU0RnUTlKZWVHQUFVaytLelZxNVpoMklNSFZPN0pVUGtG?=
 =?utf-8?B?UmQ2K0JIRVUvR25YVU1HTGZWWUFNdWVMUG9idERKYmwzT1lKbmF5TDRaV3ZZ?=
 =?utf-8?B?WlJjSUJDa3VFdWpGSHlLQ3hMNG9YeTlTZnk3ajBkVWZ3bktQSjZ0N2Rjb3NF?=
 =?utf-8?B?c1U4cEVvM0RPV1VIRWVQbGwvQnRsdzVYQTluZ2JHRUkxQkptaGVna2NrZUFY?=
 =?utf-8?B?NnhNbDl6aithbXl0U0F3RnR5WFVnRnd6MGxUYkJRL0ZCSU9qK1BsajZnaGpU?=
 =?utf-8?B?YkVpcG9RM1FVR0dYcTdSUVhwbzdoWEVidGtVV05PQ1MwQk0yMXZmQTdKV2ov?=
 =?utf-8?B?ZUVKNW5VM0NwODdLbkhEcE51Wm5ZMk1PQzRGL1dFVnprS2tpUnBMWEVOZ0VG?=
 =?utf-8?B?WlA5YkU1VTZqQVdTVW1lTmNFYWU0b3BUWnhyWkxEa01aQlk3UUtjYVZNQlZR?=
 =?utf-8?B?WWtmNEt3bU1Xb2FqUFFGWUEvUjY5VTJDNGgrekxjbVR3cG91WWpuTWx1a3I0?=
 =?utf-8?B?V3dRYzgzc3A0cHN1b2xmOHZlaWprTmdhMGJJWXFkeUhOblI4cXphU01DbmJp?=
 =?utf-8?B?d3lkbWl2bTkyeVRnNDFBdlRaMEFhL3JLL2hOc0MzSnJEQkxuTXhSbTR2ajBO?=
 =?utf-8?B?SmhOVHdEaWlIdkN5T3duTEZSbG9Fc091ZVVieUgxUHJ3dDhqNU80MWwrNng0?=
 =?utf-8?B?NGNlUUFCbmtOOHlLbkVQQ3NLZUVYRDdhcUY0OWkrWUY4NlluZzllMlN0Z296?=
 =?utf-8?B?Z3RQVmR5S1RKdUVkd2dST1BOeWxveTRQWFJRMTJYVlAwZUlSWTlHSk9TYjIz?=
 =?utf-8?B?Mk9zM0hSdysyeWNqRElaeUFNci9WUS8xdU1xOUpKY0EyWVZMZk9OVFdOb1Vy?=
 =?utf-8?B?bVgxYk9RQ0g5NDkrZTdaeUwwNVJTOTc3QW43bDM4bDNseFhhbll0ekZhMGRW?=
 =?utf-8?B?Y2FLVCtCbnZsa0N6eFgwT3B3OUh5WHRqOXRIWmdIcGhKQkdqc0EvMThaWlkr?=
 =?utf-8?B?RW1xcmU3cGZjSzRGZE5xM29kWFU4MThGU0JCbEZwUXlTOUY5RGs2RXROYVpG?=
 =?utf-8?B?RG1VZUlMRTZ2am5kaDJOeUJnMlYyajNVemZJWWt0S01Sd2dqTVJsWjA0UzNa?=
 =?utf-8?B?enppZjhwTHRGTTBoZlI1eWVNNEVvbmVDeXpCVzk2Umx4aVZkQUJUVGpueGRF?=
 =?utf-8?B?dXhvWHVBNHZwV242Zmw0Qkd1WXhHWUR0UjJoRmNJWFdWZ2tQbk9yM3IvM1Jy?=
 =?utf-8?B?NVQ3SVNiY2hkV09nbzRxaWtKczBhdHlJNnVjTmFVTlJpODM0c0lHcXp3bFlU?=
 =?utf-8?B?MU5Ka1EvS0lla0JTOG9iNHRubXhEN2Y1UmpQN3c3bXFKbDQrMW5VR2V6Z05y?=
 =?utf-8?Q?7hh1P4qwK8+k5zls+r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2021009-16e1-490f-bd3b-08df0e920e88
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 16:47:38.3547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /gPLC6jkLSxYhZijv+qjH1bWYo2VgniCRx8SSZM31P7b2dBvDxNjyhRwwpLAPgay
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9536

On Mon, 31 Aug 2026 14:42:56 +0800, Yuanhe Shu <xiangzao@linux.alibaba.com> wrote:
> test_increase_level(), test_pgsize_boundary() and test_mixed() leave
> their mappings installed and let pt_kunit_iommu_exit() free the whole
> table, while the other cases unmap and then check that the table is
> empty.
> 
> Besides being inconsistent, the mappings which survive into
> pt_iommu_deinit() keep the IOMMU_DEBUG_PAGEALLOC references that
> iommu_map() took on the mapped pages.  Nothing drops them, so with
> iommu.debug_pagealloc=1 the pages behind the hard-coded test OAs stay
> counted as IOMMU-mapped and every later allocation or free of one of
> them reports:
> 
> [...]

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
