Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013025.outbound.protection.outlook.com [40.107.201.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF853F5BD4
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 10:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787653719; cv=fail; b=JjZjswvsriOvz+5m3aeMIIxvI2N/zZmBs9JXyZmPnsAKLAJKSYnM5zy6ugIwK2vjavlHohqE+bDPf9Lg2vaz0qEZzIg/incKknjunG/v4PvIvmJOCRzDTfsnwDn/0AZIXcO9sqOtz7UpRsCuG/NDNrxw+Bf+QeyJIF6UslHfMDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787653719; c=relaxed/simple;
	bh=4V9V5DNuYq2IC+49bqmA+GS1dnEIOA43iqq1y4vO+RY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XbzghP4EjGjuiLGEt+KKsTxlZqjB0BeTqTR+ei0ACRIEV+iZsGwg/YGYMdmQeOQJGbkgthkgWQqm5eIZeVslfFxm49lB2f9WN301rTD/4vlgddJX/iGFik7VZfJ2NfW9t047v0jptSgu4wZeoqKzz+ERVlLVYqZsV0Z5vSMFFLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J7vTqz/r; arc=fail smtp.client-ip=40.107.201.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J7vTqz/r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IqjGbh/P54KcqHjJwQnFpdKJw6bbeXM+r/QPGWTKKSpTEzcW/0V6Sz4JgjCl57gPfnOR64baydTAAsaukOzFqsEhgQGwlq8wTrYpeAXM2uPtVUu/P4EEmo+NxhB3AED4BxfwP7WUZhFi3CgYXcWM4ycPmaeWSQ7J4Mqgo/d/rAH/re/+wPCUNmOEUdfCxVnz479bIxlgn8Z09uaoi6qZ5Eux/fDyY7HVU9i8ixWP1ko6BOlqtP7TAHk271SW+b2KeBnK9zYEDS+80D83QpvzcDM8W6TOM0uDVobo1lrjnHT/j4xofxG4CRN2Md5robQ/kIqBKAqboEPAAb+i8yLB5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3WNiAP6mOoXdwxqTFisYT2Z+0wee04aSh0TYaW0ht00=;
 b=Cu8H+j1ay/zHyrPjRMH/lBNfvt5BptUnnqqM507fUudnCXzM4c4U0cOVwM5Im4/GcseAvG4OLbxfPL1Px5/zpV/TpVOGUA9LQGWTeTBkYImZER6NfTMO1DbOnYWPgSVRJ4v9HR4kyH3i7b/vqos25Fh3JEJqVG3GFWyfet2AkJdnFDrmrqNDtFkAB1E8h+nWjQR0ZOpbhB+XhlmkARWgQvRXirte3uFBaBMXifCERPSIy5nmbMmQsp91MPVgkbRrY3/LJBStr1YtN1currKmkohwrBUNzHvlMcgaEwpAp673YAIhtY1uSHr36tKsUwt+lP6e/n6FOW5RQLO4EKhT7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3WNiAP6mOoXdwxqTFisYT2Z+0wee04aSh0TYaW0ht00=;
 b=J7vTqz/rJOuxFfpvooHOOTO26U8Thx5AIJJipdxMde1lN0oOI6e1jLW9vOqJ9r/uWisx7PlFHo39d3RZgfOoI5W0kz3ESLhNRuEiTDbIDw0SEYo3eQZKnfRi2Bh1ag+MdLsljRvKo5bulOV5yE4lkOvi9jHH6vdWusP4hVZvPF8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 10:28:34 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 10:28:34 +0000
Message-ID: <3fcdf5ea-37c6-430e-b1c6-1277008148fa@amd.com>
Date: Tue, 25 Aug 2026 15:58:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Do not reallocate GA log buffers on resume
To: Karl Mehltretter <kmehltretter@gmail.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260819032349.20354-1-kmehltretter@gmail.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260819032349.20354-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26e::10) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad90481-164c-46ad-3a8c-08df02939e23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	chCS9UNrQ+rJhpqQWd43qQHqUfWKXgxl0tya7s2S5x745v3onvsfajFvqJ5QaamDs7jEw++8GEm78x4xtP+bzf9Np9BSEMIaNqVp4E0LyKslE6H/6ZyHF94HFaDE18oO1uSOr9c0ECxfg6y5fkioN2j9VLJ9e22GckrnJJIUM06GLBCkM5YPJnvw5/LGjIAycEbQLqtsWVJ0sipjMHTHLxUdqwsYu7UOw7vShD+/4OxGJIDpn3pJBCpvWj0MJ5rupM4xeBDcBzW5TYIaCySw90twp1tXl7GXF0YBMPMTtVva6ISX3QzDBnSVumSwcfQcfXO+k2nWdRWvASUE3l0ErPNSq3zgFO1Iv7guoEevy3NTYipeUnWqx50pCGKDbJ7iTtWyFK0l5YPRHHZB1PNwDRQrsvqOnKw4nMv+E2o/RQd0+DU6tciZsgyP+YfFOh1TuTmH5W6WGUiWeFDU4BQVkb3ehAs1ZhDPjolcy40cs7df5Z60F6uz167/4GUihHqaA3S9gbme9xGt8LxGS3GscU3OzWQWuUbOqvJLlo/HcvQEMcTMXZyB/4bqSfwbOi/Dq+qmP/392A5Klnwc3sAwUZKVMENKN1CFTT6aBkVidVzxaSFqq0svhQ6H3oTQP5EZGyutjr/aMQE3xXN50Tv/47uTxgCl8bo1ck8A/gFp1fY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?di9Zb1ZDUGRmN3k2N1Buand0Y2JwdExhb0RqMEtLNHE5azduZUtyYmc2dS9D?=
 =?utf-8?B?VDMzeU44QnJZMFAzbUhncGw3bnNqZklTUnIwdVMyWWprOXNvdW5aelAxUVhC?=
 =?utf-8?B?dzFKVmRqUU1qRDlScjErTGpvd0psaVI2bytHRTVyZ2ZsUVlGZnkrZFZEQkVZ?=
 =?utf-8?B?SUZQV1hPWTNQbUdyOW0ycFRDeEdWUnpySGw3VHp0WlBTZ0VKQm1IVis3NGha?=
 =?utf-8?B?VUwrYWtzdlVXQm1vWE1Jb0tneHRWQ2wyY0Q3MWlFRGt6QkU2aFRpZ1ZrS3NU?=
 =?utf-8?B?WG5zZlhPUVN4MVQ4d0Qwakg5UUVTUHdFYVhRanFqaDU1SUt3OUhIT3oybFBa?=
 =?utf-8?B?Z0pzYUdEOUpnb0VQU3VaTVFNc0VjSzEyeXZSRFhib1YwajRsYmVsb1c3L1U0?=
 =?utf-8?B?QVcwcnZtYWhxZTk3bVkvTi9DWG1GcnlSVC93UkR2YzBRNjFHclN6REI3anor?=
 =?utf-8?B?Rjl5ZFFGSi9rdEZxL1JEaENoblp6VTNjVmZuSUdUbS9GeEYvdEdnN2xCUG5Y?=
 =?utf-8?B?N05tc0hseEw2clNvN1kyMkllZzYwT3dYd25TZ0F0azRyOTZiSklXdk1lN1FS?=
 =?utf-8?B?STFlRUF2U21jNDNlS3NYdW94TFJaOGZZRlBQZEtXUlI3bGhHY2NuVk4vaHJV?=
 =?utf-8?B?NUFsdHFlakJ2NDZKQTVZam1nd1hDd0hGUU55Y0R2VGhIYXdZclN0YjZqYXFE?=
 =?utf-8?B?c08xR1NJOTZvMHZYTlFhVUd6TmNDalVyTnArSEY0WDVoeVFxTEIzMUNETGZk?=
 =?utf-8?B?UkRrMzRTTDRnNzc0OWxHOUlxZDc1d1hVYVJxV2hxczFhOTVMbDJwdEk4T0hX?=
 =?utf-8?B?NmJncDlNbUFlbytJbXM0YnovQ0dGdWk1WldQZThhUzFEcVVsc0orLzZYSjBr?=
 =?utf-8?B?K0R2Ly83NWowMXZpVy9sa1R1cXhlUUtoVzRKdWFPREd2RThvV2k5OG4vd1Vq?=
 =?utf-8?B?SHdyTExWbXY3YlptU25Md1poTDVVRG0wY0pBTnArdlVrdVNkT2tnanQxeitn?=
 =?utf-8?B?bHcvdmpoRnU5ZlBjZEpwMnBDK3lXSFdINXFhQzJlZ1N6aFY3azAvaTYyYkJl?=
 =?utf-8?B?Rit6WXJUdlhCTGRHckY3aElxMENleVgyWGt6VVVvR2RXSllCTU03ZWlJUEJa?=
 =?utf-8?B?TS9zemxhZXh0bS96REVHWEQyV01LMTYzbW1CcUpRKzlPNGJXbmtuU3p3NW01?=
 =?utf-8?B?ekl4YnczVHZoOHdtZzZ0Qm5BMWlKQ3FHSWE1ek1VWUdjNmQ4ZWMvRE5wTEJN?=
 =?utf-8?B?VlFadkJwcEFyQSs2by9vUzZVMVpDODVBMlBEd0hlZVlGbXFOdWpqKy9GQzZs?=
 =?utf-8?B?REp6QlVkQmlPNmpXUE9wYnhRZ0ExcVVIVktjR21YSGRzOXBlellJeTlBV1NM?=
 =?utf-8?B?bUYwRFFjTitSUGY5VFA1Tzk0Rkg5TDZlbDdkNXlaaHRWWkQxRWJTMGNPWDNY?=
 =?utf-8?B?ZzhuNVpVNTVqM3VFdGltZ1hwd21vRStDclFlaE9MWVV0RDZEMzIyL1RCY2Y2?=
 =?utf-8?B?YlhoTHg3MTg2NTllU2NCd3draUliK0xHUkNUQWppL1VrbFh6OEx6clVOdXhK?=
 =?utf-8?B?bTUxWnhyZHBEZUVYaC9Pa0FWbFZyZlZxVWF6VkFnNjFJaVVFdjF0MWRYWjUy?=
 =?utf-8?B?MWJXWGpoZS9JUkdDc2VpTmRkcFFrc1FaeHgrRFpuNnc1VmpFM0d0dVhXNUsv?=
 =?utf-8?B?NDdGSWdjNTdrQlRWbHZKNmNFVFYyQ1BWM1FFUFBxTW9TNk5NVm1jQTd2NzdF?=
 =?utf-8?B?VlNFcEQrd0RGY1R6RUw3NGl6OWYzVkhBWmxuanp3RTJiTVRDOStkZ1dXK1BV?=
 =?utf-8?B?WnA1aXlGVlhtQmJpYU5KTmUzdzNQUHZiVjlrUVJTNWFXMFVucEo5blUvNVdy?=
 =?utf-8?B?MTJVNUJrUVJGZmsvTUxsMnZSbVlaeGFVcE9vWmdZZHdKWnNheU4wc2VCblZm?=
 =?utf-8?B?Ynh4eUZWTVFxRkgzbzNiV040cVVGR0R6d0hmeGxJWHU5c1RyK1dOa1BZb20r?=
 =?utf-8?B?bHhzVkpDelRZYW1kREVxK1UwUmx0OW5icWRVRjkrWk5WZHZwRnAxOFp2eXpk?=
 =?utf-8?B?RWl3bFRPU2cwR2xFQzJIanIvak1rVCtiSUtIWnBkUExhNGthYXM2QXc5WjlM?=
 =?utf-8?B?WjUxRnp0TVg3aWNXaEl1eEI0RWpIOGRkMWhldVpId01IN0hZa1V4ZFI2VGpD?=
 =?utf-8?B?djBkL0l4dmNnT0NUcUxIUE1mS0RJNWVWdmhwNHVueHMwNkFVdEt5YWJYc2VP?=
 =?utf-8?B?Yy8wVFY5NER1Z0lrUklTYmtFMnpuYTFFSFM1Z0dWNktMOGpSL05QUFhPRTJu?=
 =?utf-8?B?UXFSRVlZQmlxek55Y0ZVSWJmZExLY1dWcmJqVXhTM0pFWFpCeVR3QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad90481-164c-46ad-3a8c-08df02939e23
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 10:28:34.7428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x9K5vykeLQSryp4NQrBUHvv37lcchnwO5EjAFj7f164E++GtDrjBk3Hfwa/vU1iArd0GedMl7hlm2FfrTMdF6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082



On 8/19/2026 8:53 AM, Karl Mehltretter wrote:
> [You don't often get email from kmehltretter@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Commit c5e1a1eb9279 ("iommu/amd: Simplify and Consolidate Virtual APIC
> (AVIC) Enablement") moved the GA log allocation from iommu_init_pci()
> to enable_iommus_vapic(), which is called on every resume.
> 
> iommu_init_ga_log() assigns iommu->ga_log and iommu->ga_log_tail
> unconditionally. Each resume therefore replaces the boot-time pointers
> and leaks both old allocations. The function also uses GFP_KERNEL from a
> syscore resume callback, where interrupts are disabled and the non-boot
> CPUs are offline.
> 
> Return early if both buffers are already allocated. Clear the pointers
> in free_ga_log() so a partial allocation failure cannot leave ga_log
> dangling.
> 
> Fixes: c5e1a1eb9279 ("iommu/amd: Simplify and Consolidate Virtual APIC (AVIC) Enablement")
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>

@Joerg, I think we should pick this for -rc.

-Vasant

