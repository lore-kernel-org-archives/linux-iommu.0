Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013028.outbound.protection.outlook.com [40.107.201.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBD6342528
	for <iommu@lists.linux.dev>; Fri, 16 Jan 2026 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768543340; cv=fail; b=GIR+h/PtJ+FYOYSEJJDApq68C4+tsUDGD0ljrrN3eZ/QN/NdsW1xbj2ql/7DV+A1sGTSpN1M37hGBGrNGxNxmxHZqJFq+HkvRG6LmyG1Xt75X2bY3God7fd5xKeiIJ1r75zABXd54VZrSxysPatHYQw2thYKlH/sCQe1y6bMgmg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768543340; c=relaxed/simple;
	bh=HbIiSuk/Hhs61lSeIq6zs65fPx/HnJecL60a1OeBbFQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mR9MdgJ7VT2gVP15lqsoPUVTkQWbbzMfLJVhbtYQchbWmx6pswnP8uSbbRNjzDrh4TbmmUIaP75K2C89BqYFaVUHOFl4XM8YySb1MRjibDo6yytK9s0CR8yz68xA1Yq9J0gBYlKNhx26yhg3dxy+92pAzY/FWEBuDulN804A8Uc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OCk6nzj2; arc=fail smtp.client-ip=40.107.201.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OCk6nzj2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcBLx/Yg/wc0t5445N9R5fWyTlYyynGidUJrqhu6Szpd2b+347qFqgLDR5DsxoG1/s+YJtzCEC54MeaGhY706DqLRVkzhfpP3zVf5208/q0f096ILfVx17REQ7MA8WmhOKssdNvySgbS+XV56/bV3hQq4vTek2KYhkW4G9VBvSXmpOfPKtwmV0USE0ycT5BfWIAgAt8eWM0yyj0HCUDSOrQGWi82AoKEKYXHRimxdiP1/MNBSMX2eoewKIFJiF82gplt/sLxXS4K7mDylbORduqaHaQv9qVH/CV132vcbJN3B9Ih1bFWLZetRLXL2hTJdZL2ONZP5nsh259HTM5Vjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pO8obfchTHp6iBxLTZ5mh09RlwhmMyOue/TvjbdnJ1Q=;
 b=jxbvbT83QdTeqN4cTFnwCCY6kPilgm8NX/zoO9knFP6mdiKQ7kkscLp7C9trQJaLeyD1g+YrYRWuDxCbV4PU+eOeWqj3CRbIVARsb4gryPApr0+5fGlHA0D3K8KL7c1Hx0d+TITZVfRZhj2IwCHSO5F5gPYi+5/DamZ4w8V+fpIK2wFnN636NEFsNa58z/dMJL3oOzeBZVbwEPj5MaUHaBLynySxtc5wz+dIB6cGREWT7pDlVe5yAfaA/kxzAm6O4J8TaJ/GpHU7ctHx5604oT9zUwbALZWOCgEDoHIZUbXJOdyMz6ZevzvEP2HHbz6Mc+mA2bVcrmIxgnX8ZMVCqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pO8obfchTHp6iBxLTZ5mh09RlwhmMyOue/TvjbdnJ1Q=;
 b=OCk6nzj2SX93+myOoetuvu0TppuF+XTqBr4lEOZZ8pNbaVRuvIGjHUzeB3/5PCxvJps9CaYdn/eshAeMrwYmpGlF8BTMF/M4iTGTYfGGZupdKKdN8UVeGKyw9ykwiGInh+0aZrXoo9Q5wssyoMADYCC4pmIbng5dMTAWIo9YH6g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5754.namprd12.prod.outlook.com (2603:10b6:208:391::20)
 by MN2PR12MB4472.namprd12.prod.outlook.com (2603:10b6:208:267::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 06:02:17 +0000
Received: from BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564]) by BL1PR12MB5754.namprd12.prod.outlook.com
 ([fe80::b080:4c1a:f6e5:4564%7]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 06:02:17 +0000
Message-ID: <e4d13f5d-e4ea-492e-8209-59c3b6a0425e@amd.com>
Date: Fri, 16 Jan 2026 11:32:09 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: amd: Fix uninitialized dev_data on probe failure
To: Rakuram Eswaran <rakuram.e96@gmail.com>
Cc: dan.carpenter@linaro.org, iommu@lists.linux.dev, joro@8bytes.org,
 linux-kernel@vger.kernel.org, lkp@intel.com, robin.murphy@arm.com,
 suravee.suthikulpanit@amd.com, will@kernel.org
References: <561ab88a-ba97-41d8-ad6a-8656a2e2b1d5@amd.com>
 <20260112165139.7120-1-rakuram.e96@gmail.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260112165139.7120-1-rakuram.e96@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN4PR01CA0040.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:277::10) To BL1PR12MB5754.namprd12.prod.outlook.com
 (2603:10b6:208:391::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5754:EE_|MN2PR12MB4472:EE_
X-MS-Office365-Filtering-Correlation-Id: 5516e489-32b8-4caa-71e2-08de54c4cd46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TXRJd0cwUTY2VmpBUjBCN3RqQUh0N1ZqbWZhRjFHYXpJV01vUVNJaklKbGpz?=
 =?utf-8?B?MnpPZFVsVjN4RnYxQ3paaTF5OEw2ai8zenJQY0MyTkpibTFJM3ZsdUduYktp?=
 =?utf-8?B?Q0UzWE9tM0tmemhQb3M3OGx4L2F4Y3QvdXJmcHQ4cnhwbElHbURaLzB0VU1n?=
 =?utf-8?B?eUFYY0JBVUJONStXU2JUaVFZQVo2VURIMHJCUWM3YjdUVUlJcmdsaDJFTm1T?=
 =?utf-8?B?VHNaNXl2V3d3MDRhK0hHdzNBRkhhZEM4Q0xBd3dyTGFqdm5PbWcxSnBRZXZ0?=
 =?utf-8?B?cHV1V0dvQ1NCb0crZWxRUTNWTTV5SnhNTjZBRGZNUmlVdzlub3YrVWJpK3pq?=
 =?utf-8?B?TDlQc2d3dmdTSHUxV0tSZTlsQ0FnajFYek10RElCa0xKNmdlc2J1dlJBUzhv?=
 =?utf-8?B?V2dyUmZEMTljUVg4cXVaWlJoaFU5ZHdNTkYzSDU4OWFMcUJqWU9oTGlzN2pU?=
 =?utf-8?B?NW9JU3BsM0g4RHVVd3F3bUpFRGd5am91amF5TkxaejFqK2pQZ2hobUMyNlUz?=
 =?utf-8?B?dnEzekJvbWdYUUdOMFFjUVdSM3JSNk5sNEtUK1BwdldSN3lOQW56WjR6TTJ5?=
 =?utf-8?B?MDhZMUM1Zk42bGRQOEtJOHcwZ2RhZkJJbkNxRXFRQ1NqQWNIM3lZVnRHdThr?=
 =?utf-8?B?MDR6NFF5WDVKVmZ2dDExR1N2TkF1QlJXWWVYT3FnVHBtdkRWTXc4bHowS3d5?=
 =?utf-8?B?TVlseWdneXRpMlBONDJqcElZSWVKMFBWUGZYM1dSZDFpVkR0a28wODl0SXlW?=
 =?utf-8?B?c3pSZU9EUm13UUxnL3ZwNytEdWlSYzJnb25kNWtWSEV5WWxwcnllZ1RObFZI?=
 =?utf-8?B?YTh6Zjh1NTFKcWV3WlVyZDVaR0NLS2lxMWJ4VDBoNWZpSDlncjU1bWtTNnNB?=
 =?utf-8?B?YnFjVmhIYjYyRGZ1bDYyYm92ZUt6SW1FR3lXa0pQR29sd1BGRjF3ekd3bjdY?=
 =?utf-8?B?Rys2blpRUTZMV21VWi91MGJ4Zm1tVzltaHluNStYaSt4OS9GbVFTSERUZThY?=
 =?utf-8?B?N3dzTjlpRXJTVTZEaTNBUThqV2FTT2w2SnoySmtJVjdWRU1INTFpYVVoVEZF?=
 =?utf-8?B?WFBGTVhqUlFjR2pMbEVYUkZEdDhaeFJwQ0dBeWVvUGFScXlaaG9RNlNPM0RF?=
 =?utf-8?B?WEQ5bGpwRUdJU2FGVytjbHplaFpmSG96RUNCbWVoSlRjdjdnek43MSsxR0p0?=
 =?utf-8?B?SFRDYlc1YkdoelRhMUpUSExibGRmTGE4OUpxbXN2dFlCb2lNWXFCYThId0My?=
 =?utf-8?B?K2d0MEwrdEp3Yi93TTRBT0JVWlNwaGIrKzZTeGZlckRFMDFJUmxLR0xzakQ3?=
 =?utf-8?B?Vm5XczhYaldnaHlSWmNaeFhuUXJlZUhUN3pFc3FvVmFMZklpc1FpaVE2Tkpj?=
 =?utf-8?B?QVY0SGFWNmdhVEp2OEk0OEJsbU5UOE85WHE3VDlpN0NSZzBuNTYwVEx4dTNW?=
 =?utf-8?B?R1dxN1N4QWVVSURsUWowbFBFTkM0bEp6U0t6Q1B0MExFMzBwTmdWM1dFZlBP?=
 =?utf-8?B?R2lDdmNGOWZmY3MzcTY5R2t0azlXUEZjUS8ycE8xZElTQ2pvbUtQR0Fra3ZB?=
 =?utf-8?B?dGRZRGk4YmpkWDlxVDJob0xnSXp0OU1UU2oyelU5amUwR2N2a0VkK2ZqSkpx?=
 =?utf-8?B?bzRweFUyd0R3c1VTUTZrU056c29HdUYrZ0hQeCs4YXZuUjUzSm5xdTZ5cDFr?=
 =?utf-8?B?ZWRIUm9WRHZCOGoySjBuRUlUOWluVzFrWHI0Z0lOUUFORGVNdklhdHl5TUFW?=
 =?utf-8?B?eEVrTXdCVW9pUmVJYlB5SmVJLytjQk0rNHdWVE5rSXFtekZZY0VBRENvdEhr?=
 =?utf-8?B?dytTV2YvQ056blRvTGNlVEhSQ1QrYXVkREtZMklhbFZ3a3VIY2I5dmNURGtK?=
 =?utf-8?B?b0JmUTVJYnFlM0E1STM2bnVoWGxwcnBOM3JiRWh1cmJubldYaFRlYmcvQWFP?=
 =?utf-8?B?T1dSNVA4NElmZ2kyL1hGTEc2RGIwdG83eXMvVWVta2x6QVgyKzBubmc3OTEw?=
 =?utf-8?B?VXJMS0JMbEg0WEZVTmtaUkwzWmdZWVZienhHb0J1Wk1GcjhLcHVLT1RmNW54?=
 =?utf-8?B?eWJYUWd1S2hqeVdNamhmMUdVclVFRlRXMDMvVXVUWjVJVEJFRzRkbkkrcHBB?=
 =?utf-8?Q?nArw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5754.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEY2VWQraVhmaFpMcC9TenhleW96aHh1WUR1c1BmU0dCdnByenhyQ2ZlWWZB?=
 =?utf-8?B?VkVYRmcwVGIvdWE3WUdoVXBLWXRvMXFEK2pVNlRrdG1xYnl6dDlRMmZMdHRo?=
 =?utf-8?B?dFhSOG1VODBZVzloYzU1dXBzS0tMVzNXQXJmTy9LRnhPNXliR1d4clRaOHBH?=
 =?utf-8?B?UjFpY25nOUh4OHJrQ25LbW5kMGJ5bVdFRUdxdCt4TXN3Umc1WmNYVFRVb2t1?=
 =?utf-8?B?dlpwaVZWbU1ualV3U0J3aWxqL2JPamN0NExkNnNaMXFDRWVWazNQZlBtT0J6?=
 =?utf-8?B?ZzBIRk82alIveW9RSUdtelkxdmo2dDhtS0lYaDFKcmpqVzB2MlRBemJCYm9V?=
 =?utf-8?B?UlhmVGthVHljWnVuNDZ4VnpWYSsrV3ltL05IaWJiUDJYSjYrbFRxTkE4ZUM4?=
 =?utf-8?B?RTlKYzNaR2ZYOXNYODFZcmJ4aW1FMkJoZFhSKzBCMFliQkROa3dwb3JyZGlq?=
 =?utf-8?B?VW5xK1Jyc293SlRzQlNhd3oyV2huNSt4RTRiRGhqemRjVkd3U1BKb2J4OWFp?=
 =?utf-8?B?QVBTbE0xelBwQkxhVzJ0U2N5eWZpcUJlbHFSdVB6U2wvNStsVFM0dXlZdE84?=
 =?utf-8?B?MFM5VDA2bUFsbzFsbVpqSDFwN0NGdjRVdnltTlJValZoUTBvMksxaEtiMm9a?=
 =?utf-8?B?eDR5Tng1VDN6NkgvN29DZ0RxQ09uZ3RBaDNhaFRHYlZhUlRKTFBMeCsrTHlM?=
 =?utf-8?B?WStXSFFIMnpkNkFzRWt4YjJHK0UzS0JwOWV6WUJ0ak8zWllFVmpxNkgxTm8y?=
 =?utf-8?B?VWc3RTNnRUpkRGJyeWFLVHJVczg4Ly8wMlZ3MUFuZlplZE5VRDVtWXljTW5N?=
 =?utf-8?B?WnZ6Q1dhVTZPdEFmRTF3cGxzUlhLWENHWUdLUHRBTDF0OUIyL0s4N1RkVVNm?=
 =?utf-8?B?TXEzWjNhTm5hck5VK0Q3akE3WHh1UmppZitOVkZDTmkrcnRGbHJrNzFSZ05G?=
 =?utf-8?B?V3FrZVNuOEZJUHcrTzJhQ2JyMkJwZVRzMVEvUittais5WUVhaGFvVEt2OHVj?=
 =?utf-8?B?TktDVzlwOXp5aTZaRDUvZmNGdTd4R1JRQzVQQU1yaHVZcDdZNWhVVDQ0MlA3?=
 =?utf-8?B?bzNnU3BkaTZxWlp6MEpDaUFNV0QrbGtRNlFsdW1scWVLeFVqcXI0UFN3K0RG?=
 =?utf-8?B?UlJuaWx0K2pWei9DcGs3a0JqWEZTZUhNZEUwR3hnQjNWcVo1V2xpYnY3MkNL?=
 =?utf-8?B?V09kRkhweTJwZ1ZINXNSbm40eVd5eHVwTVV1d1A1Qjg5TGVFM0NKazY5RzRj?=
 =?utf-8?B?d05jaitHUlhnMHRmbjZYRmpldHk5cm56TmpLSiszcG9LZnF5YUlnYjhTNDQz?=
 =?utf-8?B?c0p6MTNQR3VRdUs5eDg2UXBWUUY1WEd6UHA3MU5RTTF1RWg5RWN4WE4wTmJV?=
 =?utf-8?B?cGNsUFp4SW9lRkNUcjlBd25VbnRBUHRHbTdWWlB6SlB5aTRtYzQyVEVTOWh4?=
 =?utf-8?B?MXNrdFZnWTFhM3dVYkhQVTBheU1aWWZBaHdLRk1JK2ZkSDZSeHBUTGtXb056?=
 =?utf-8?B?K3dGVGdiaURZTTlxQUZtUlMvaHJkNlNwRzlXVjdmcmcrS2lNUGxiWmo5SEY4?=
 =?utf-8?B?U0kzMnR6SVRBNnVKdjNZckFra0wrUU16RnNQNE9WbjBQbHNCc1pIb2dpc0dQ?=
 =?utf-8?B?NWJSQjYrL2RyTWJITGc1d2sxY3RVNk8zR0lmOXlhVUNzUUJFVUl1bGU2SHVW?=
 =?utf-8?B?Y2RLVWorNUpDQUREcnJpWFFBZU5jbmlaVWkyZzVFY2Q0d29YZ3d6Q2NGK05G?=
 =?utf-8?B?NjY1OGEvY2RDbGk3bGZpQmdHam43ckVMWHdTSHBYRXZtdE5xaERNcC9nN2dE?=
 =?utf-8?B?OGcwT0lPaVhYSWt0NklIVThHeUFENTVkcUo3am1zaTA1cE1UbTd4cnV6c3Nz?=
 =?utf-8?B?VHB2ZUtrZUVQcStoTVNmMk1GQVFsNVlhKyszVXUvQjB6V2VxZkFTTGFzeXRj?=
 =?utf-8?B?MzNCbVU5bEdyQlVpWUUrOXBlNUhzMzlFeWFQQTEwRWNVU1o0aFdLd2U0RlNu?=
 =?utf-8?B?eWE5S2V1aWUvR0RGTUZ2dmRNV3VtS0lUQUNIdmc2TW4wNm5CVzQwQ00rbGs1?=
 =?utf-8?B?T2N1M0xORW83YUZQU3ZyK2dYenJZcTM4dlBIUjdaWjFMY3p2Ky9TRFE2SlBL?=
 =?utf-8?B?eFZ0dGJ0ZDVkeVZ3QTJPZFVuVDBWZGUvdjJZRUVoTi8zSy8yL1VDM1FaMmhy?=
 =?utf-8?B?VnVtcE5oa2Mxa3ByWmJOdno5YnhsNUhOc1oxeFVlbTRxN0F2dTBzdE95eU1i?=
 =?utf-8?B?cHArV1I5RnVvSzlEREpHb3pEU1JteC9rbXk2OTgrVjdXNmR5bUI4Z0puTnNx?=
 =?utf-8?B?aFlsOTVNMWdndkdnOE5zS0pzV1lCcHFOazNFdzNKQy9lK0pvVHVSZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5516e489-32b8-4caa-71e2-08de54c4cd46
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5754.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 06:02:16.9927
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NTiI8t2JOZGzED4IBVc5qPivcGm754UEi+T+ld496+02txgmSfjXDIVbTlz/X1Ct+ahKc466MzlkSA6dmS2m3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4472

Hi Rakuram,


On 1/12/2026 10:21 PM, Rakuram Eswaran wrote:
> Hi Vasant, 
> 
> On Mon, 12 Jan 2026 at 10:42, Vasant Hegde <vasant.hegde@amd.com> wrote:
>>
>> On 1/10/2026 3:39 PM, JÃ¶rg RÃ¶del wrote:
>>> On Sun, Dec 21, 2025 at 11:04:16PM +0530, Rakuram Eswaran wrote:
>>>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>>>> index 5d45795c367a..075125f0f52b 100644
>>>> --- a/drivers/iommu/amd/iommu.c
>>>> +++ b/drivers/iommu/amd/iommu.c
>>>> @@ -2426,7 +2426,7 @@ static struct iommu_device *amd_iommu_probe_device(struct device *dev)
>>>>              dev_err(dev, "Failed to initialize - trying to proceed anyway\n");
>>>>              iommu_dev = ERR_PTR(ret);
>>>>              iommu_ignore_device(iommu, dev);
>>>> -            goto out_err;
>>>> +            return iommu_dev;
>>>>      }
>>>
>>> This is not the right fix. It makes the function omit further initialization
>>> steps which are needed event when iommu_init_device() fails (which it only does
>>> on out-of-memory).
>>>
>>> The right fix is to initialize dev_data to NULL and check for that value before
>>> dereferencing it further down to keep the current logic.
>>
>> Ack. I think this function needs rewrite. PCIe device capability
>> check/enablement is scattered between this one and iommu_init_device(). I will
>> fix it as part of other PASID related fixes/cleanups.
>>
>> I think for now below fix is good enough.
>>
>> @Rakuram, @Joerg, let me know if you want me to send proper patch?
>>
> 
> Ok. 

Done. Thanks.

-Vasant

