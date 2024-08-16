Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2054.outbound.protection.outlook.com [40.107.220.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 660621C2316
	for <iommu@lists.linux.dev>; Fri, 16 Aug 2024 20:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723840833; cv=fail; b=QpVOV+2iNTa96KLAHlN+BsJ0++S9cyKGN8+2ZYoVVbJ4VOWB9x3ZFIkr1Pev2t7fJyn5TfFAoiJQUqKCrOMjap8xvymnl3cRSsi1YvcBPqcgbtRoB4jWCxjPYxNN3VI4zsCq1B/wX1zT4hJTLOdQuqVkUHonhcB0EdoOQ9oYqBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723840833; c=relaxed/simple;
	bh=r/sssly5sa1L++TOIsicUI8klUmBzkvITt1l05wHqT0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S+bT+wbWvLQrK9AQh54aB1VQEwG6+KF5HftHUBBe2dl+2o007jcULrCZK+xOnV/OzNpYp4utpHORv8XviiQydM5eI7/KzC5GVd9+2Myq3wCsV0AjY/h6zVlT3RqfXkqmchLNEChza2mRKOhrqBL9oe99K9PfFSKX/W7c0EaFWBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wCVCeTPg; arc=fail smtp.client-ip=40.107.220.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wCVCeTPg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CjqaTOWOjkt6wULwCvXIIn5tTFUF9Gilkvg2JRVHOfegKioPCD60T0N0gfqfPcdYGJ16a5CSVdJyclGa5nGV3K9iFpm1MtljgF2MN6tVSpIUyDle/j4B0agG4uxyflOmYsojJiJJqXc7lIe6LeSYNTHcudCjCD0tAdABAdIGS75Afo52CxOFjsTWPg60nvAfxoGMYmyLsd9IVaFPDQe7+qL96fkgsed6qjEd22NSHHx4Enx7NJLrqoMfFJYbzekqqDeWm/Le7fD9FQBYjl+dFeXCU3/i7OZ9CkUaPamdqyR9duzMAHv4e4qzj7gkflTvO7+Hlr9vNL/wx14tYeUopA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ywk5NTMKE8LEtyqap5hvI8kBWJ/whDbFXqDv4uyBrFs=;
 b=NpjEOKmDnaka26X/6dEI3hwgsInOPOSOp4vlTM2eOUyTdAMAp0QOCTQk4okh4B+MmRg9w/y5eMlxBFvWsH659512FYjnkc3xNV94Sr+dCpuy47pXethfJt8YA/l6P5CLZwi0FaK1yw2B+sdM85nSkbetOEbh9sHlHxP6179owOEL7aD59F0eC2AVHhgMyHxUpriEbO6OH8+UNxUEG7vSJvbAfTGsNhIq0Nu/HR43WYEut4av0x1RTy0BMbtt3ekqS589aGFCu16QcwKvX8tP/KK77zbgydNFIQTAkApbbpyzZ9NjpQIAb0ibni7YnwUX/U73m3dlz09TosPNL/dfRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ywk5NTMKE8LEtyqap5hvI8kBWJ/whDbFXqDv4uyBrFs=;
 b=wCVCeTPgNrnyt/RfR1B3JdA99ecuBQCn9zwjTQBcRcllTOoHrcw1h95z9czxodYT+eMcdUtsVfrKAwKt1qm6Bi5v/jhzJee9IRHWmHmr6UjVvLTfEse0p2gWyHVSJmzKIHjdMS1qT8x1OImhkmErcNAHc23uq3pl1WGizIOkodA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM6PR12MB4297.namprd12.prod.outlook.com (2603:10b6:5:211::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.20; Fri, 16 Aug 2024 20:40:29 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%4]) with mapi id 15.20.7875.018; Fri, 16 Aug 2024
 20:40:28 +0000
Message-ID: <1d835a25-d148-4cf9-ba00-d8557b0d7649@amd.com>
Date: Sat, 17 Aug 2024 03:40:21 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Update PASID, GATS, and GLX feature related
 macros
Content-Language: en-US
To: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Cc: joro@8bytes.org, robin.murphy@arm.com, vasant.hegde@amd.com,
 jon.grimm@amd.com, santosh.shukla@amd.com
References: <20240816160020.5525-1-suravee.suthikulpanit@amd.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20240816160020.5525-1-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DM6PR12MB4297:EE_
X-MS-Office365-Filtering-Correlation-Id: db626027-e179-4d8f-ed05-08dcbe33a9e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RElGZFphTWRrQTZoclFRUTUyRU9CMURteFlNbFNJdUppSGEyakZhQk9zOVhV?=
 =?utf-8?B?dHlGQWpyY2lmOWYzNzM3SGJRUGhJYkJlZkNDVVJGc2VkWDFDVFpSL3FqTlda?=
 =?utf-8?B?dTN5QW5SaGRiN1VEREhYcy8zUGZoZXpwRFlvdW9UZ2RNQnlyaEsyZ0Q1QXA2?=
 =?utf-8?B?dUFnbzVRYmc0b2VYbTBkem5DcmVTSFBjT2ErSzB3VXU5QXdtZmtMVjdEdlRt?=
 =?utf-8?B?SUVRMENOa2FuQUhOWkRoWTRBaGpkMnlQTDR2TUtmOXJ1TDNVR2hpU0JqWGdu?=
 =?utf-8?B?eThhbk80QzN6T3JualNROXFHRS9VQ0trbjM3R1UwcUZzdU93OFpubEdMbEsx?=
 =?utf-8?B?NXdZRVJGOVNacmFFd0lYSzJZYWdtSkw4UDVmWS9QWENYSnFtc2xhdml3OXlE?=
 =?utf-8?B?dkU4TTFNWU5TUUk0Nk1kL0t4UVlUOFQrK0lyYUt2Zlk4QnhtZDEyczJ5L20y?=
 =?utf-8?B?T3VKOUYrcnpkWEk1N3V6Y1pGRS92N29jM2lURUxyQUM3NmdFdFBrT2NSbWE2?=
 =?utf-8?B?QmpBZjFmSXlLN08zZVM3dEtCUkJmNkpPUlcrN1FlLzFMOG5ybm1EVzYzT2Iv?=
 =?utf-8?B?VkhzTFRFMjRmaytPemNoWTVTRFpobk5NWnJreXB2d0FyL1FyN2JCbEQ2Nk5u?=
 =?utf-8?B?YTY3V1p4eUFvSTBvNDBCVHNTaHhtVytCa3dnOTFTYzJXSXFscFFEYXlFL2x5?=
 =?utf-8?B?NGNMU1pxVkF4MHZCOUFBQ1VSanlTQmdoNGpUS0ZqdEhvTkRIYU9ua3lWOWZY?=
 =?utf-8?B?b0dSOEZRalQ0WjVGVkVTaWF2ME40RjFDOTBURkpjRk9vYlB0UEI1aGw2ZmE5?=
 =?utf-8?B?M2VyMmd0c1FMRVBONXFKbEFDRHlRVHpteG5iZTJxb0s2bld1cHpaNExlUTBF?=
 =?utf-8?B?aVZCaVQvZk41YmIxVzFKWXM4T3lST1I1TEcvQ3FkQ05EY2k4bjBNY1VldGNt?=
 =?utf-8?B?cEF2MWNhZDNkRDdCOUJLZlIvdnlrejdhRjJJVzIxYUlzVUg3MjFPZERKSStn?=
 =?utf-8?B?MXpJVysrNml4eVNJVFMyMWJyTlNZYVYvZHhoaG5QMVBKbldZajE3SEdHZUZh?=
 =?utf-8?B?QVFTS2lJdmRzOEdISThvaFMrVkc5RG5aQ0RyanhaZkRtTG5wNC9Xc2RyNElk?=
 =?utf-8?B?R2I0R1d6V3pzc0ljRUhZMFJ4ZjZiTEhSMHhRWldvVU4wRUxsbzNVRUdvaFB1?=
 =?utf-8?B?L1ZJelczeHhGbHVBTHFFWkFEWXlEeGZKN0k1U1JSNVFXNEFyb2NBY0Qwcjhy?=
 =?utf-8?B?Y1dKYVBQU1FHTlcwYzUrcnlTKzVUbXM3ZEsxRFc4ditNWTUxZFU1WXByZzg2?=
 =?utf-8?B?Y0FaYUFOWUJvQzN4WVVnOXAvVXlMTkhEWXJJMXpwOER5eDNaVUtXeXczMHlB?=
 =?utf-8?B?a09qWWNYN0RDZlJPdVAzMUQ3VlA0YTNkbnVzd0QzZURXdUxFQ1NnbjhqVDFU?=
 =?utf-8?B?VXdub1BEbHNodm5wR00rYTRhR3RwZllWcGMvWDRCYWVxUTgrSmNzdjBZeGFL?=
 =?utf-8?B?YnB4c21TejVuc0I0dFJkSlhqa2srbUJFbEtIOWU0dFcxeXRvcmxMZjBPVUFF?=
 =?utf-8?B?RTErajlST05BMEZtdUVSaWNOczE3Uk15MjlXbGRVK1I3ak1JSUJ6ZmEvOHQ4?=
 =?utf-8?B?M1RvQ2REVUxSVGw2T3VhV3lOUW83VTF4VmZFWFNHanJJN3NnU2NITEd0cmI5?=
 =?utf-8?B?dUZXelMzdUg4THZGUUxLcU5uTkJOczhoS0c0ZHFPaW80SlZKa3lzZGdrUXZi?=
 =?utf-8?B?dHZUR1VGZ3dKYW5JRXhqRkRnanpFREQ5UDlEQkF0aklTUDEyYmZiVFE5Vms1?=
 =?utf-8?B?WGg3bVErUVZUQ3dSNHY0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S3RwbXhUd2xyc2dxdHcrbitENGpKMzBPT09kNWVtSVNRQ1hTa2NaWFdvVEZs?=
 =?utf-8?B?TExNZXovZk82Mk5UdHdwRDExaVBRMFlHb01MUkVXcGQxSjJIWmwxQVhDenVH?=
 =?utf-8?B?NldTdU0yb1JvQXAxQ1dKTkI3b2xWUEx0NHVjbHAzaDN4aVNtQUVwYkxHQlB4?=
 =?utf-8?B?Q0JRQlp3R0hyMlFUYmRMT3B3a3EzVk5hdDhKWUxiQ1l3eUdQMDlmNElVcWVU?=
 =?utf-8?B?OWF4UVlLL1RmTW5FMGNITkxQcEhRb3llK3BMYTYwVkZGNkJhZHkvL1djMllq?=
 =?utf-8?B?dDFXR0E0S3ZLeVRMNGpPa09LRHBNWjZKTXBjWCtuekgxd04wWmJzMFd2YmRB?=
 =?utf-8?B?WElUV2RWd3hvWjRISjFxYzRnQWVWd1d0ckt2V0tNMHp5QjFMWXJ0dDc5dTlx?=
 =?utf-8?B?RWdCVGJYUWRwN2VqUmhPbTh4ZnVSYW1BRTlsZ20vRnlQOUFYdmpsYWd5UGsv?=
 =?utf-8?B?MkRzUmM2SEdjTW9KRG5PdUFZdldtNksyaUtkcGlmRzZhei9KUGVrSTlXVzhO?=
 =?utf-8?B?QVVUTVFReWd4TXdMbTg0QXk0eFJOd1JSN2JXa3Q4RlovNmZvL1pZdlB6Z0dw?=
 =?utf-8?B?Vlg0ZS9EYWgraDYwUXU2c2VKa3JFZWg0UGs1dUpmSk0wWUNOVEszdUdKa2RB?=
 =?utf-8?B?WG4yODdPdFRLT3I1bGR6ZlJmSkVaR3Jia3NTMUNia2MzVlFVQjhaenZib29E?=
 =?utf-8?B?MmFiY203REFpL013Ym13YlI5KzAxVmlNVy9nQzV2ekE4aHUzUFdDQzRlOHh6?=
 =?utf-8?B?OFQvUTljNWJRWmdkRW5jS2xoV3FnVm1hWStPZjJENTJYNmRXd3VGdUZMWThj?=
 =?utf-8?B?ZGdsTWdkMTJhZjNlVjNSV1dZOWZYUjdubzZXZ21WUHdSbUZ3SjBsWFg1UTBw?=
 =?utf-8?B?RDIrUnRMYkxqbkJJUGVmajFWUElPeDJvRXNoUm52MkdNMnVMeHVhZmZxUERw?=
 =?utf-8?B?NXRmVW9nMXFCMWMrdE1UcHpmQ3pHZXp3WUVzT2RSOUF5QW9jb3NNeVZZRjNl?=
 =?utf-8?B?cEdCZGt1b0ZESG1BTlcrb1ZpaXdpaGdmclV1U3hzRWlOWVRMUDkvWHczOFJX?=
 =?utf-8?B?NXh5TUlFNi9xajVsV2tjcUowZCtDNStUTkZ2aXowYVJ4OUpBaUVraE0rYkxS?=
 =?utf-8?B?MmtRYnd0aDdybWxkTWs3d1dnOTRwc2IvOS9Hb2c4VldNN0gwMVpkWXIrUlBw?=
 =?utf-8?B?ejdmM2xJZmRIWTluemNFaWhpVURYKzhxK1ZKaUQxS2hHZEV5TThCblpMd0t3?=
 =?utf-8?B?SjNTWmo3azZVM1ZyTW1lUGlBbE9hWWY3NXFNSEtzckI5ZExjSEVLUjcwdnB4?=
 =?utf-8?B?aFhKTWhvZ20rZWdNMU5HVUV6NFlpTDM0enR0VWl6UThwTmg2dGRmSkxYTjlT?=
 =?utf-8?B?NHBNNWc0SFJyWjh3ZTU0ajF6WUZmZmhaZTY1TmdTQUxNZG5pMEswdGZHVjZn?=
 =?utf-8?B?YzVqcFJPOERNQXkzMzA0SVFlcFgySFVaV1Z0dTdsWXp1UXJ3QkdJU2JCL2dG?=
 =?utf-8?B?YXVCSkRjUWsxSlRXQ0lxQ1FXakdQQ3VFL1FHREhhZ0VxZW9SVFlIN3lNdUs4?=
 =?utf-8?B?SVl1bzlMNmV5aDYzL1NXanh2RUk4a1Fqak5seFB1clFIb21vN29lNEJKbVhN?=
 =?utf-8?B?WmFKVlhvZEs3bkVqSnZyN3NPeEsvc2ZmK1ZKektIZS9TazBZSGdweUl5cS9R?=
 =?utf-8?B?TnBVc0o0ODJjZXlEdGRNemIxUGt5VUxjRk9VMEpEQ2wwTmFyTEI3c0xjYjBW?=
 =?utf-8?B?Vldwd2dIYTRnb0RHYnh3S2JjM295WWUxMHVTYy91TUNQT0NhSGU2RFdSY2Fa?=
 =?utf-8?B?S2hYSzVuSEhXcnpUeHlwcWo5S0lMQncvOTRHZUhhb0RvRlVzeWlDT043ZXg1?=
 =?utf-8?B?MWpoeld3TDAvSDBRWXV0SlBPc0UyNmpEdGN4Kyt4RVd1NTNaeUZkRlZ4bzFV?=
 =?utf-8?B?eG5oRXo4MjBNaGVyM0tqVHF4MnJockY1L1ZhRWNuTGJsM1hNazhJQ1FabHJz?=
 =?utf-8?B?cmp0Z25RYkFaM0ljbDRQVjZXc05VWVMxNG1qdElUb2lMNDBQNSt1MXQxUkhl?=
 =?utf-8?B?SEhaY3VURVdXMkRKa1F3cmRjS0NJMUdxbnorZ0NRdjRwayswK1JoejBrSXdx?=
 =?utf-8?Q?8zUyu6oHgAjj1zvDLh5dy9MvI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db626027-e179-4d8f-ed05-08dcbe33a9e3
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 20:40:28.6522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1m7rkcPworSNaHb6cJm5dySCsWGGchf+MNABMymEI/WehJyxcslLOzCNRDg9PoBWqmeIZKwVje60XWECtqTs6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4297



On 8/16/2024 11:00 PM, Suravee Suthikulpanit wrote:
> Clean up and reorder them according to the bit index. There is no
> functional change.
> 
> Signed-off-by: Suravee Suthikulpanit<suravee.suthikulpanit@amd.com>
> ---

I am doing more clean up and sending out v2 for this.

Suravee
