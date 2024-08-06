Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2070.outbound.protection.outlook.com [40.107.101.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42ED1C37AA
	for <iommu@lists.linux.dev>; Tue,  6 Aug 2024 14:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722955291; cv=fail; b=Vlsop17emXWUQx+A9TOq6ySRUKTn3NH939e4XDe82Y3dBWvmBsfMIe8mn2PpxrSi9rLCQCtmp7b9V+YcRsgviGSasnLRLBk1o3th0RxRAO/nFzMJZiqIvJ9sAUciENfgn4UejhVtfSqnzl2SPXpw3m4+sgruEc7q7l/SA76wHAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722955291; c=relaxed/simple;
	bh=4U2+2lZm7hE/USCsuuJ/JiZd0Re1Vsw/hNtyY9ydoc0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ghy/Wsn+1lyAkyDo6C7/fIefgQOwjOX/Ji/usGQUAG8lnB2RoCRZMXhAJx3bFZMMueehqi+cPXFex3l15G7Eoqc47ESLouwJ+TUyXsQ3PwS2bmN2HrKM93KMDdraBdodCyBuRBBY1VJmex2B68/6W7QEtyt3Uc1z0zC2nnHE44w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E4EfuItN; arc=fail smtp.client-ip=40.107.101.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E4EfuItN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aovt+8UVng2YG592R/PLbVKqfkbQgowKpgsvxrPX7IxSRzjRLJSvLnWeL1HjV4PSzknEsTovWYliHJG7PfYMG54zjHuuoIrlKdrHYcvHLmiGwnEak1YL/IrNBQaHJ0Gd6c8X8zIzWcNVaJ6tv4587x1l+2xDlzo3gUWz1QQMM+VqwOpLA+iBmcPMLEVvEF/sCQQEEYxVvHxJXEFZXK6YGjU/TKvqG8+yVMIUAsRi/h2p1xvRZxuq/Y2WQUsiX2fqs2dTWgDQKQpwJP+VeXcR4p7WzJ1QydaX06DGpqznsabahIftinyrMddZHh92Kzl7r4RHRhlL/hus1AlUsE2lLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SHplGCxtGS9CAjka2sxhbp5x6piH4WRuoRS7i3wk8k=;
 b=D1ALsNHGYOteDTCElOKYkJLWU3IAiKJz8kIzcJj+/EWtxZEF5iouQbzOIc9FJ3p1nDFny2tDJUJP7p+uo1gTytb9OcsCl5bainCFtUDM61w/h3j6mA2NFFqhlPNNgKYXIYZL45parECtIr5MK4khKWyE1VvZyx/np+sTSwfcA60b8+yBqPa2SCBy69Y+btrf/ZuHJrFafIdBFkAneWVT7wGJYEoUlaST7mcfSoa/Gc1y+IrYNVFMjxvq4KB6yOyo45/WamlyjGGUymec6tHBJTrGxmj21z1/v2OFkhJIMvi98abFxFW6hS3qkTWXB/EkWji991MDRo5wjwrNsT5Itg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SHplGCxtGS9CAjka2sxhbp5x6piH4WRuoRS7i3wk8k=;
 b=E4EfuItNB5qrpATLhyccq9gukw4O3zRCsro6ZFp0+fEk/N3rH9yO9aq7UytMsM3cXZohsrhOZ1wIiLh37X85Lrj7rGSImoAbdlKqUG+P6kzdjyPZ6U3JhON6hK4OERwICwGJ3Xlua89SV15jkKZyb2/QP+++OZIdRc8M6d5LlUk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MW4PR12MB6998.namprd12.prod.outlook.com (2603:10b6:303:20a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Tue, 6 Aug
 2024 14:41:27 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 14:41:27 +0000
Message-ID: <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
Date: Tue, 6 Aug 2024 20:11:19 +0530
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
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240806123452.GE676757@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0131.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::16) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MW4PR12MB6998:EE_
X-MS-Office365-Filtering-Correlation-Id: a16ff095-89f4-48d5-95c5-08dcb625da06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0p3bm12M2FiVVZ0QjJsanJPM0UvLzdpeFBiVWtySFdHallDWTBWd0NWK1VX?=
 =?utf-8?B?bFpwU3hPOS9FbldxSVNqbHlwb2NRZFRTWG5KdlFZMkJsOFAxcXJSci9jT2JK?=
 =?utf-8?B?UmpHc2w2KzQ1eWlQWE1LYUc3NVE4b3lac1R2bUd2akVRUUxSTWxPMVo5TXNW?=
 =?utf-8?B?SCtOVHBGeFlXT0hVWjZNV3BKMDFCNW51SHI2em1zdkJFbVRmc2ZPQUNseGZx?=
 =?utf-8?B?Q1lQZWZNdVZORWdRZ2YvVUdnQzZMNVFodlBwdC85WjUvaGE0VW5YZ0grbXpp?=
 =?utf-8?B?M2w1MStNY3prRlhaTmtIMEY4dHZ1SUdNb2dNL1ZXRjIyRjg5d01mNHdEUU55?=
 =?utf-8?B?dXhZbGV2SWg2TUlxUUthcXROdW5XNkZMVmk3TUYvdDVVRVVFTHFBK0M1TUsv?=
 =?utf-8?B?djEzWkFlZHdCbG1qVi9jVHlJVVVkYytQQ1Bxdjh3ZGsyRGZEZnY3aGRWNURa?=
 =?utf-8?B?WUpQcE9yYnh5bUFuVkNOMG92TzhrdGUxREhQNnlqMDZWWitKelZOTGxwTEls?=
 =?utf-8?B?K3BRWUVhRGMya3g2ZmtvTWcxdkRHT2o1Yy9KUGVQQ3h3WklyWHg4UDZ2N0tH?=
 =?utf-8?B?dGdqcmVDT0p3c0ZsSWttNG9CNjVCYkgrQ2VlMlZDblRZUUdRb0FreEJKNW4x?=
 =?utf-8?B?WWVjcVZjUEVmNzUyTzI1VHd1T2RUcnNEdEpoaVhXY1JnTk9tUTg0L0RRQitD?=
 =?utf-8?B?eitZTFpFRDdUU2h4RExmL2lZVXl2VWxpYTNKR2F5SnJhWmgvcFFQZ3RzSGdM?=
 =?utf-8?B?bkVENXNacVlnblBRRGlkcUNPNlYwMEFlQ1ZZOUowOVAwOFl1VVRKaldHM0wv?=
 =?utf-8?B?bUllL0pwME9GWHV6RzV3S0lXY1o3T09rL2NQRGllWXdTejNleGM0NEMvMC9Z?=
 =?utf-8?B?MStwenBpVzN3R1ZUdmxKMThnTkY1UEJPNUoxaUdpY2JpUnVSQWcxc1hyTnFh?=
 =?utf-8?B?UE1CMEg1RS9CQXBSMXp4VHNDRU12NlpNR1pmZUVxUEdwakl0SGc5allWSkU2?=
 =?utf-8?B?RXMzZDAyYk1jTy9Odm5MVU9ZTzloeFRQRHJnTnpDM0NNTXhPdlIwSnNyeC9m?=
 =?utf-8?B?TGJBcjkvYUF0WmdCaVJOVmEvamdvODJrWHd3YVJ1QWlzT0IrbDBSamRhK3Vz?=
 =?utf-8?B?VHBxdFZoVERScC9UWHNlV1hIVTBmK0NRSDZsYVpOMzdzVWlnZnpPR3ZLWXZT?=
 =?utf-8?B?RXlLMEprTjlxcndCeVJ5NEp1VjZrd2I1SHk0K1B4WHFCV2pzblFjTWRJR1lI?=
 =?utf-8?B?V2FxUFhibGJCdEFBdm9sRmJKMjhkRXBTSndWa0ZGMmFzaUdzQ3NlV3dpUXpu?=
 =?utf-8?B?OHJJN3pYbzAwQnJOendld1g5bUF6SVY1cVlvQ1Z6U3hmSy9FSzVXMlVrNVpy?=
 =?utf-8?B?ZnlVblczVTNidVhzenFYVURmODNtaWhHWGdiZS9TT3kxdDBEZ1hQRWVBRExE?=
 =?utf-8?B?cytmc01LYUxUR0plejJxVm9IUnFKMUE4NXFuN0hjSzgzTkxxbGdYOStmTXlV?=
 =?utf-8?B?THl3YnRCQnk3Uk9kcU5VR2Mrb2NyVGZnSkhZSzlIRFFqanU1b1hGdG1KUmNz?=
 =?utf-8?B?NkI5RDRuMHpack1LODJ2cWZldC9saUlia2g0RVExaHAzeWhYaXhWVGMvbldW?=
 =?utf-8?B?T3FiZUx5cFozUE4rVC9qT3hzcmlCRjFDQURoV01GRGhKUGhxamVGbDVTZFNO?=
 =?utf-8?B?QU9WazgvQ2t3RmoxVG92dTlhZ1h2bUxYU1F6d2dmSnlvRFJuZ1pORUVmMG9Z?=
 =?utf-8?B?Qllra0ZGZzFkZWUvZ01HS253QmhmTU9BcURiZFZUbXNQekhRWkVzSE5aSTBS?=
 =?utf-8?B?TWowSEdDeEVGZFN4S3diQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkorc2Foa1o3cnJNU1hZL0dGbGVMZjhGUFNKbjFLWUF1ZnBtTlp0QlRPOVNP?=
 =?utf-8?B?b1VYMCtONkpEUHZkQVpSUjdpTXJIbis3WTJkYTRsWDBLV3pLclkrbG1nei8r?=
 =?utf-8?B?c056Y2F6enFyYlpqa0pvTUhyOUJ4OWNJVVJRL1FiTW81NVc2QnFtbmttRDVD?=
 =?utf-8?B?dk5Ebkx0bXpLRXE2R2wrMllOMWVYOWI1b1FuN1FSai9rdGNrbTFxU2pVUmlC?=
 =?utf-8?B?ZHYxUUhnclZNa0gyYy8vNlBkUjU5SWNZc1lyVHppVXk1ZUZEYlg5cGVZdThY?=
 =?utf-8?B?eTdlUDBhdFAybWxxT3FXV0ppZnFkWWdFaUNZMUllU0tBeDRqSHRwS2NVS1Bx?=
 =?utf-8?B?WlVRMDUxNDhCM0dwdnpKbkR6d1Flck0xUmRFclBtTjVDVVByUUpyTXFWRVVE?=
 =?utf-8?B?RjMxOEhGejNqb3I1a1h4U3dGNXhZdEo2aTVaU0ZsY0ozVFkxbm1vaUFQSDBv?=
 =?utf-8?B?aWN4Nmx1OWJveHl0S3Q5ZFBNTHcxTkdlYWFaSHJOOU43aW1FdStMNStHWHpo?=
 =?utf-8?B?UlhKRlVndnFURWk2aWU4RUxmbGNOUWEyclNDUkxsa01LRkJQWDFjU0ZDVVh5?=
 =?utf-8?B?VHhGR0o0N0FXR1FlaktWZmtWMXdFS2RkNjIzYmdFaXJWSm16MHdJYlo5UnlK?=
 =?utf-8?B?UlVQMkNrVTBsT214ZjlvWmxHKytPMXg1SkhMdW9PWE9Ja0VYYUpPekhna3lk?=
 =?utf-8?B?eEx4Ly9GTlBsUHZQenFUN2Z6MjVwN09xN3RDdVB4bVlnQWRXS29IQ2h6NEJz?=
 =?utf-8?B?ckgwVGRaSENjdUZXdmFYRFQ4aHViMUV0REJVV3hkb0kzNUJ0RmwyRDRxczdx?=
 =?utf-8?B?MDcvTDRxWEc2U0xVNEk5VzczcWtHZ1Frb0FybW84ZTVydnYrRTQrS2swSUUz?=
 =?utf-8?B?eEhhTkpjZ0NXZ1lLMFBlQ0xZV1BhUDdhYnovaXA0aWVHYzA5WnZHbW82dExi?=
 =?utf-8?B?MXVhTFFNSkRLanlaTGVjdThBek1WMGhqSXpCT0ZISFZ1YlZuL2kyQWdUd0JJ?=
 =?utf-8?B?RDZVcER5bUlaZ1JOdDU2NlB1RUs1VTYyOFV5T21BSGM4L1pVOXphMDZlZjI3?=
 =?utf-8?B?WUgrNXorNVBhR2pOZEhtTUJMbEUzbnF0ZHRSYXdUVEhvY0lLeDZtK3dwVUVT?=
 =?utf-8?B?UXJTRmkzdTFJTkEvNCtBeXlCUzhkYjZiOUR4YlR1NS9RbjhzTEk1WlFFZDIw?=
 =?utf-8?B?SHFwMThIMW1MOWppZnN0U0hqRHFZb2pJMXpvT2RuUkVDQmR5SmVPaTVBdE4v?=
 =?utf-8?B?Y0ZWSVV6b3FPNUJsTEllbExSOEVYYWlQY1JNOWt4a2NINkVCMWNMcVBITkVw?=
 =?utf-8?B?KzVQVTROWDRzQysxaGl0VzE4VjFkcjF1WllqMXpHNHIxOE9LL2VKMFh0ZXZ3?=
 =?utf-8?B?Vmc3OEhDanNkWVc5QklDbEEyQmVqaHJRNVpIUWwvRGhyUGNHK3RUWndYQTBp?=
 =?utf-8?B?Z3ozRVFCYVl6ampNR0pQdDBTbWJpN0QwSkx5eTBMNk1PS3BLRiszZkprRWh2?=
 =?utf-8?B?VUFiVkdPSnI2dGF4Vy9sN2FsdXlUMldZSFhvU0ZaTVNINDJjZTc3dDFyZmY4?=
 =?utf-8?B?bTMyUWJabFJRMGgwV3labXpvdTFkcEtZaDVIUHFjTUd4c0hRRitmVHpTQ1U0?=
 =?utf-8?B?SGV2OFhZRXFDWG1USmQvYnF5OCtPZkppd3pzRjZjQ2dxN3EzZERjbzNsMmNm?=
 =?utf-8?B?OGx2ejNDSkVpQ05XVlp1ZmE0bTdUMDZRL09oYnN0eVpKNnU1d0t0M1RHNWRh?=
 =?utf-8?B?QzJDajJEempSUmdKQVlPZWxpbDYzb3RRRGh6Y2ZKZzNWTjZKQTg3eHRzT3NJ?=
 =?utf-8?B?c3NOQVBIQzRXK2FPeGJMUzgvWDQzQU16bmd5bkhBTFhJUHp0RnRSaklCbjRu?=
 =?utf-8?B?Zkt0Y0VmQk1EaUFvTHdUT3VucktsU2VDb3ppL0wwbjhkOGpwb21QdkdsRmVz?=
 =?utf-8?B?VXdUVjBCVjRLN2syNjFyL2g0QkMwZFhjL2hjVDlpY3Jnd2ZIaWdydFFiamVR?=
 =?utf-8?B?VTcveFhHRWN1d05xWDFHTnV2Qk1qOWRKS0p1bkJ2aUtWU0ZsdFpIaDhMcEsr?=
 =?utf-8?B?RGJpaW82ZHJnTVJqRTF1UDgrYlo3MzB4U2dreFdMcnhoaEZEc1BJSzRMYkVu?=
 =?utf-8?Q?JcUFudCjJQc7q/8wTGlWY5Hix?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16ff095-89f4-48d5-95c5-08dcb625da06
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 14:41:27.1590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHv6XsHoxCGztW1M3RqhytNMT1gQchdYuLhuqP3+Gnt2cTubqs6wnT95z5A5N/yiwH5oRXafszUQvLMMW3gBqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6998

Jason,


On 8/6/2024 6:04 PM, Jason Gunthorpe wrote:
> On Fri, Aug 02, 2024 at 11:23:52AM +0530, Vasant Hegde wrote:
> 
>>>> +    struct iommu_domain *(*domain_alloc_paging)(struct device *dev,
>>>> +                            u32 iommu_domain_type, u32 flags);
>>>
>>> I still can't see a value to pass the domain type in this callback.
>>> Different domain could have different domain allocation callback, hence
>>> the domain type has already been implied.
> 
> +1
> 
>>> For the paging domain, there should be no difference between DMA and
>>> UNMNANAGED from iommu driver's point of view.
>>
>> That's true. Its all paging domain. But we need a way to indicate the desired
>> capability like PASID.
>  
>> I thoughts we can use `type` for allocating domain and then `flag` to pass the
>> quirks. Otherwise we have to club everything in `flags` itself.
>>
>> Something like below works ?
>>
>>   - DMA-API domain : flag - DOMAIN_ALLOC_FLAG_PASID
>>     If both device and IOMMU supports PASID it will allocate PASID capable
>>     domain (Like AMD case domain with V2 page table). Else it will alloate
>>     non-pasid capable domain (In AMD case it will be domain with v1 page table).
> 
> This is a much larger problem. The DMA API domain is created way early
> before any drivers are bound. If it doesn't support PASID then no
> drivers will get to use PASID at all.
> 
> You'd need to figure out some way to switch the DMA API domain on the
> fly around when a PASID wanting driver binds. This might be reasonable
> since PASID devices tend to need single device groups to work at all
> and we could conceivably switch the group under driver control during
> early binding.
> 
> For now we expect that the DMA API domain will support PASID if the
> underyling device supports PASID, that is the only way this can work
> today. Meaning domain_alloc_paging() must always return something that
> can enable PASID.

This is the fair expectation for DMA API mode. That works for AMD driver as well.

I only have issue with allocating right page table for UNMANAGED domain. In this
case just 'dev' param is not sufficient. Ops should send some sort of indication
that its UNMANAGED domain (like its non DMA API domain). Otherwise AMD driver
cannot allocate right page table.

My understanding is we essentially have two modes for device passthrough.
  1 - Existing interface where vfio driver manages page table (call
iommu_paging_domain_alloc()). No PASID support in this mode.

  With this RFC I am trying to solve this scenario.

  2 - via iommufd - It will use domain_alloc_user() ops. This is the interface
where we want to support PASID w/ passthrough device.

   This is where you/Yi suggested to start discussing with Alex on Yi's PASID
support series. I am running behind. I will start looking into Yi's thread soon.

Is my understanding correct?


> 
>>   - UNMANAGED domain : Do not pass *_PASID support flag
>>     Since PASID flag is *not* passed, driver will decide best suitable page
>>     table (in AMD case, we will allocate V1 page table)
> 
> And here this is only VFIO. When you figure out with Alex and Yi how
> VFIO will decide to do PASID or not then pass that indication through
> the existing flag argument on domain_alloc_user(). At least this is
> pretty simple.

Sure. I believe this  is for scenario 2. I will look into that soon.


-Vasant

> 
> But as I said before, the important thing from your perspective is
> that VFIO does not default-on PASID support!
> 
> Jason
