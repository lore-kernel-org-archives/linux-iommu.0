Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2083.outbound.protection.outlook.com [40.107.101.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F90259C
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 11:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729163028; cv=fail; b=iZoeduhjyfks6KmtR/E6RiZf1vEJInAktSox2T92aQhqxGpHMRGVtOvbMksH/da/UAk2ElqgWrf6Gn3C+am1Zv3TIScMB2yRB9d0th4kyOcP8NnUDesc8iIX+MqQnX0DMY1Ha3BsTNQE4GY87C9ptyKvR7HRq4uQWriuvtPxUog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729163028; c=relaxed/simple;
	bh=012ZUfnDAFug/bdVi2YnmW+zVEl0jxW6sazZaG93erY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F7qLCYsiXGYx793eC+aYh8WqFauXj8r3+Ozg5Av8rZnu9D4NbUBodyF1XEPHyAm87AztF+0kZ/VfC4UFeaqfc//imexEmQMEskS15tbaCJueIpf6UibC3encYyVaiFHwptwYobrO7+LmjDGlUCOz7lIKLMa1X670GCLUc2BquFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qa7jKKny; arc=fail smtp.client-ip=40.107.101.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qa7jKKny"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ooZFelhoSfl2BFgixsMi8sLwlAHwUBMrJHJ+oP3pqnDaomkJagMPX3kvIm29nw8cdsMsCoYNxkKWjTfauVvfipmuZG6Suibjfo/zC5aY2EFRkYbX0XxbshB2lzkEB28WipuCpmG2uFu9xya8krOswO+VNtq2ghB6L7u5k8yrEtxrlNU9BfgGo4cqekbRz4lTD32Ak5EAoOH6eXyo5IwrZiTblQxuFZLQTyAWEfyHZY8zpErRoblaxHgilaSV8/LarZPWw8W14Z3+cNXe5uUiAd2kRuB3oxft6md6OmkMPCoJMVstwPBkPIDKxAnSabnaaOjDIyJQacbmWflKQz3ImQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gQqoWaswTTy9V22/y+xLGvI2ratpMHYLEIlSBQSJc8=;
 b=aECEwYyOHSJmKyxZzpKOA6P6Jy5tn35ROn+IoOpRgntbvCApp00jxbh5py3UNy0WGjBH6svOSVt7It0lvw7kXWHhSQ6y5I0M3COG4EAbfQ5iWMfNm3hd+KcN7IoC1IKNrQlbEu6lOd23ic+xWmG5hSarmdAAiuoK21G8SumPQU5wDZiXAcfeDj6DnwA5cWQD7uN4E4LyazxsqOaT4m4JtZwNvkFC27xZ4bUJERvSdhwm1wvjCfBO1NBICmlQv5SAd4ETibj2fT1xMJR4EtQ+GAiEDCK8wc5WUoQHznfO/hszln3vB88WgcHYeoQg/hyi/HGFO9a92r5guvDrhOb0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gQqoWaswTTy9V22/y+xLGvI2ratpMHYLEIlSBQSJc8=;
 b=Qa7jKKnyamJJRzlq7By8TyA1w57if9KjxPFzDZWH68S9YREvJLYf7b/GZZramQyuY2XJA85lhVr2sAGENV9qCWyZY3g2G0E6CLKbgt+WaEC6LR1sGcIU/yfwH4SE7UzV5oV/bo2J4OUD7bpWu0Y+szS8tIe/Ks0VN/YElbiLxC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Thu, 17 Oct
 2024 11:03:42 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8048.020; Thu, 17 Oct 2024
 11:03:42 +0000
Message-ID: <b5284a48-9d40-45c2-8aa0-7a85627feb7a@amd.com>
Date: Thu, 17 Oct 2024 16:33:33 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/8] iommu/amd: Enhance domain_alloc_user() to allocate
 PASID capable domain
To: "Tian, Kevin" <kevin.tian@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>,
 "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
 "Liu, Yi L" <yi.l.liu@intel.com>,
 "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
 "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-7-vasant.hegde@amd.com>
 <BN9PR11MB5276124F430867613D7117E88C452@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241015124018.GG1825128@ziepe.ca>
 <BN9PR11MB52769DE1B3AED678713550D18C462@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241016152846.GC4020792@ziepe.ca>
 <BN9PR11MB5276A8F6DFDB1DDBAFD9A0AA8C472@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BN9PR11MB5276A8F6DFDB1DDBAFD9A0AA8C472@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0152.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|BY5PR12MB4162:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a408435-3cbc-4ce7-e623-08dcee9b5cab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vk1rS05TZGU5R21DMWx0azJBYXdxbVd4aVdzT3JXTk5sb2wxaEczVUxNUTA3?=
 =?utf-8?B?RFBoOUlXeSsybzcwUGREUWlVN0Z0Q2kzWnVIYlJKTm0yVjh0ZGsvT0Rac0dF?=
 =?utf-8?B?NUdlcitEcHZMN1V1Q2tvdXJuYXFFNy9zVTdrNGxLU1Bpb3BkdnExVEh5dUdH?=
 =?utf-8?B?ajI0Vmx4dWRnSlJBS2JFS1ExbCtMN3JpcWRWNW5sUkhLUmltR1J1QTRpVFZ5?=
 =?utf-8?B?dXpXL1U1Q0hZMDQ0VkJrTzZMWGpvSTdkT3VmaHRSSExWZGtpMWl2MEI0Yk5G?=
 =?utf-8?B?N3JUM2lVclhneDE1NWZWRy91bUJLaGZOdENMMHB3Qnk2VlZKNkd0RHBQSFYx?=
 =?utf-8?B?WUtvNUVZWHBIWHd4eHdSTUhKNnF6M0RyeTFsNTNpTTI5RXQ5T1NoZnAzLzNu?=
 =?utf-8?B?ZGxlNEE4Ui9uSHhjUE5ZdklTVFArem1ZTUp1T0MycWVRVkZwdXkyV3BwVUM0?=
 =?utf-8?B?MFlFRGtrL2hybVIxYkJlb05BY3NTd3k3cUxmTEZOa2FNaUROdHlPdXJLUUNN?=
 =?utf-8?B?OU9QM2RlN042NUY3REp2M21mbS96UW5QdVhUSndWR29XWGxwRGowVUQxRWJz?=
 =?utf-8?B?YldIT0dSVnlxZGNSbEpVZ1Y4eHFSMTBKNGZpZFVvZ2JMQm1aTit1UzJOREtu?=
 =?utf-8?B?VXlIYm5JeE1zeEcxM2ZWSG9FaWJnZTJuMUN0ZGlwWXBRK3VaZVRzM0ZtMTFB?=
 =?utf-8?B?YmlUWkpxZkJYcVN3VWN2ajk4MXlLR2NoM3dweEdvaU4xaUNjTVNpSWhKYUpk?=
 =?utf-8?B?ZUhEZitlNFNkaWlRV0dRaVZJbXFXY3NrNjRtUlloem04WGRjZGRrSU9tMWNR?=
 =?utf-8?B?M0psWHhLU255V2c0a24vdFVaV2JQVHdmQVBoUEZ5WTl6VGxtcDdyQlNUc0tl?=
 =?utf-8?B?cnY5aUd6SUNNWFZTZDZaZjZrZHNTQmU0d1Z5QVBJSXNEeDhJWkV2aGhaRC9N?=
 =?utf-8?B?UnF3S2EybnBiUmpSVVlxWDdqZGhOWFpqNnRpTXpSWEdaWXh0c3VmU3IzL1NQ?=
 =?utf-8?B?dThKdmhwNk5JdXNFQ0F3QVcxK0dsN1QvL2FrSTlGOUtPMkcrcERIWWRicUlo?=
 =?utf-8?B?bFp3My90Z3UyenY2dVpuYTAyMnlUT2hINk9QZFJJSTNVT0VvblNCNW5RU2xC?=
 =?utf-8?B?YXlpRkdZWWFMZ1pPcW9md3Y3cmV6ZGUrbzhsd3c4R2hoaWdKcUVGWU9tMkwr?=
 =?utf-8?B?SlJxYmlrSXZaL25lTnZYb2E3cmhKM3A1VnVnZWxEdGNKMnVpTVB3NDNsN1JC?=
 =?utf-8?B?U3VIZEYyajVSWWg3RGdVcHY5T3JVTGh3c1NuNmRFSDNSTzZDeEdjME1qUXUv?=
 =?utf-8?B?QkliNm92eXhZZWRxSnVrYU12VSs2MjJ4ek5NSHhYRVJaVTJPdFYvczMvMjFH?=
 =?utf-8?B?aCtSbGgzWG8vdVFaT0RxWWcwNC9KMW85RjA3MU40bTZHWjFleXc0ZFJsRHhN?=
 =?utf-8?B?aTVWemlabHFtZnV4YWR5TENnTklCSHp5NGVWemd4R2RGMkc2OEthN1I4d1VK?=
 =?utf-8?B?anFNWjBYV1g0cDVML2ZRRHZha2gzS0d6Q2E2eU9remg3c0VSaVY2cWFOanI4?=
 =?utf-8?B?dW5HdmttZk4rQnhNWGtadi9XcXU3WHdVWXFzYkgzVmVqSmZVREtWWVhCRmQ2?=
 =?utf-8?B?MlNyQUtpbzkxc1hWV3hURFRHVC9tQTRtL0lNSDBkT3lBaXBQV3BCU3pnbmNu?=
 =?utf-8?B?WDErRVdiMzZoa2xhY05kTURTcU1JVy9nY1kvajdFSUZZVXZiVS8vUFA0VG9V?=
 =?utf-8?Q?EiJJ63c8mllVMPMEZkY+Np6BpSjbc+4Pa4mGSae?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTk1WkFwdkVNUTRudnhLNjVyMEw0bmJrM0p3N1FINUp0S1VnTERtaE5mbjY0?=
 =?utf-8?B?QjRsSnZxd1EyTWl5MHk0SnRmcmxROW9aMWhPWE5Wd01XanAxNnNXejUxR2lW?=
 =?utf-8?B?UlJFdlRhZ1BWK0lMd21WYlZ0ZkxoK0ZUQWhXRTFLWWxQSjJqbG1HN1Vsdzdq?=
 =?utf-8?B?MzBYRGFWU0NQTHpLR0JPL2tadUc4YlFDd1dtZWpOSTQ2US91ejhWWXRib256?=
 =?utf-8?B?aTdHRFJiZnIvdGxuaGhNalIrdXpDbm1SYmUzSTJjM3h0eTREZFZXQWkvcHZm?=
 =?utf-8?B?NDIyRXpCODZ3c3JtZFZqalNaUkdKNE1hUE1yRk9qWWhpdE9KOFI2V2tVNVZ6?=
 =?utf-8?B?NzkwYUpOblJCVS90S09aZ3hWL0VDUGJBLzlNY1pxM3Y4UVkvUk5lbGoreEV0?=
 =?utf-8?B?MGYvbWwrcktUMXBBc0FoeGZoZklmM0tTQ2RtcWRJdmtOeE40clFGQ1ZwWE5D?=
 =?utf-8?B?TmxDd041Y3c0VXhFWkFmT2hBd2wxZHh2UjVyY0ZSblllU1NXQ1hKU2M2ZlBi?=
 =?utf-8?B?eTdNZkdiRGFOZVIraUcrTHZxZGEvSDNTdS9sank4VlRZWUp3VVVyM0RQejhS?=
 =?utf-8?B?aGxWdmtYVEIxYnQxbDJJanpMcXZSMjRXK0o4QWZXRWlGdE5YWExlNUM1UHBh?=
 =?utf-8?B?YmNZZjRJL2lickJsMmZ4Nmx4c0Z3MGNwbVg0aEJBTXhDVjNXRlpEWGxCTk1L?=
 =?utf-8?B?U1dwcTlMbUhDVlNuM0QxU1hVeWFBMTUyYkVoZjJoMXZram9lK2FmbmhLUTdw?=
 =?utf-8?B?NFhTamppZmR6aDlrUFF5Q0M0NTRkRHJ6SFFEVFhsNzlYSFIybE9vMTNwTitW?=
 =?utf-8?B?dG5GY3NTWHpCRUpOZVJrZnZjeWQ3TS94ak9nTmQyU3VlcStjQTljSTFLdVdt?=
 =?utf-8?B?MWRsMzBLckh1V1BlMW5aZ3NoLzJhUUtsSTZ6TGhTY2FUbkhsSzRlSkhzRTY5?=
 =?utf-8?B?UVZtbGtRR3FsUTJaWkNWY3BJczk4SVprdW40VTFhOXBib0dKb1hTZ0VjQWx6?=
 =?utf-8?B?Uy92VlBBVVFFVDlMU005RHZUbGtsQzVMb2tZYVZIU3JISEFjc244RXMxank1?=
 =?utf-8?B?Z0w4d1hnTjB1Ly9GbUlFNllteGtZOXdoVm53NTZtR3dWenNVSVJaQVcwRXAv?=
 =?utf-8?B?S003YWtvKzRHQXJCTnQ2anRBYkdHVWZJTjUvcjVKNndaSWFGSStLVXRzbmpS?=
 =?utf-8?B?Wm5ycEg3NTN3MExNcHFLVkViRXh3MGlkdlJmNUdyNnhwR2ZlRTBIeU5OU0pH?=
 =?utf-8?B?YzRjdVhCTEorS3JLZEZWa2ZlMXoweHNnbUxaSjNJNWFEaldBQnRUK0hYU0Vt?=
 =?utf-8?B?SGJpUWlnbDl6MDRFckVsRU0rK281aEtzcFNGZDl6Y0R3aVNBMkpBMStYWnIy?=
 =?utf-8?B?Qkp2WWh0VGRJaUNiMnJ3YWpBRzZzSVNHSndBRkM2dlhMekw3UXlyTUFJdzNt?=
 =?utf-8?B?ZDNuUHV5USsyQmFKSFBqdUcvR2NrQkFLdm83QXRIUjcvazhUODJoSE51dUtj?=
 =?utf-8?B?M2tCbkxyODVyY0lnVU8xelZ5K3c1RExZdit1ZEU0QkVJc3JnQ1FzL2xZN0FK?=
 =?utf-8?B?Q2I4QVJ0Z2JmSVRjRnNxdSt2Y3JBbDVUbWR6RU5qMnFsdFQ4ZzlOZ2xIampP?=
 =?utf-8?B?dVRkYXA1eHRPN0dWelJ0UEIvc0FqUnJObHZobU85SU5vYXg0MUtYWnB5TG5s?=
 =?utf-8?B?MWEwMzVVZUhWUm5za3R3Y0dpZHhFR3MxbUFETzlNRHVvZnZvb29zVjVtZ1px?=
 =?utf-8?B?bS8rR2ZQTkxJUC9FVkJTeVJackl6TjVmb1hNUUNXbHprb0Vqa3NUNm9aNnFr?=
 =?utf-8?B?MUczRnFhYmJhRVJxUVhQWFM1dG5TZ0JnZkgrSlh4KzR4VzBhMVFnRWhyZFQ2?=
 =?utf-8?B?bk4zWC9sUTI2MHAxOWR3SXF6aXE3TTNiUlg1aXU1UjVTSWwrSElLMWtnR1Zo?=
 =?utf-8?B?azZLTjNzYXRETTc4dEt3MTZYcThUbTJpbmgzcmk0S0QwZmh0VGNqOW5wYUU0?=
 =?utf-8?B?eDF3V0hqRWpLc0N3OUl6cVA5dUlDY1ljdmFsUlJLODRGOVJpZmt2RGVkV01a?=
 =?utf-8?B?MTc4VlJnVElRVmFRMU9zajlNeXgvNThvdURRYzhncVZSRGlPWWp4Njc0SDJW?=
 =?utf-8?Q?l3st7WXKRcEZNDZPifigbxIrP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a408435-3cbc-4ce7-e623-08dcee9b5cab
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 11:03:42.5074
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14j0kcLsKKM+pnAplUie1322MAyDErJWp0iNurKxg4Z73YXyeG7LJEYPqoij2qmBVahXhffp3WNWGqNlz4VAbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162

Hi Kevin,


On 10/17/2024 11:41 AM, Tian, Kevin wrote:
>> From: Jason Gunthorpe <jgg@ziepe.ca>
>> Sent: Wednesday, October 16, 2024 11:29 PM
>>
>> On Wed, Oct 16, 2024 at 02:48:04AM +0000, Tian, Kevin wrote:
>>>> From: Jason Gunthorpe <jgg@ziepe.ca>
>>>> Sent: Tuesday, October 15, 2024 8:40 PM
>>>>
>>>> On Tue, Oct 15, 2024 at 08:41:48AM +0000, Tian, Kevin wrote:
>>>>
>>>>>> -	return do_iommu_domain_alloc(type, dev, flags,
>> AMD_IOMMU_V1);
>>>>>> +	/* Allocate v2 page table if IOMMU and device supports
>> PASID. */
>>>>>> +	if (flags & IOMMU_HWPT_ALLOC_PASID) {
>>>>>> +		if (!amd_iommu_pasid_supported() ||
>>>>>> +		    !pdev_pasid_supported(dev_data))
>>>>>> +			return ERR_PTR(-EINVAL);
>>>>>
>>>>> Just check the iommu capability here? IMHO it's a sane case to first
>>>>> create a PASID-compatible domain for a device which doesn't support
>>>>> PASID and then attach the domain to a PASID-capable device later.
>>>>
>>>> The point of this series is to allow AMD to select the v1 format as
>>>> often as possible because v1 has better performance than v2
>>>
>>> If the user wants better performance then it should not set the flag.
>>
>> Well, I do tend to agree with that, you mean remove the
>> pdev_pasid_supported() ?
>>
> 
> yes

Yeah. That should be fine I guess.  Will fix it.

-Vasant

