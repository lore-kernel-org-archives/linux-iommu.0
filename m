Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012041.outbound.protection.outlook.com [40.107.209.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001B12641CA
	for <iommu@lists.linux.dev>; Wed,  3 Dec 2025 04:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764737309; cv=fail; b=P3KXW6QiA+6v4nOekNos5qGcCJqq1CulUjTQHYInAcrMyM1OaiFj+CZFGe+e5XkqhfR119S39onE6RK3nEw9QueXKHLl9DtAFC/OyTsRDHiz9sHgtUljjJQqEt1HbLs78YrYXbXE+P+YWJdOGurAOeEH/1K7zl1LhJ7ltmg6JaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764737309; c=relaxed/simple;
	bh=kr6MElexmEhHvTC3aDKHXqv5Anc1jIcp6/eg7117x+w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mraGp66xT7tg3GS5hA2kOakkinV9b7ZzL79eF2VsOG4dOjAZkr8HtRG/aZFIvvllD2kwWdBUXw0GexRGSlvF6PhCtyye10efey2/affhR69NDwflotBq3aD1+SzUkU6fcGCzjGsvDPDoH2MudRySDYsGcP+BZ+x95/Sz/ocnhXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cFsnKxkk; arc=fail smtp.client-ip=40.107.209.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cFsnKxkk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rg8wHR3gwWCKrGUw7oiwaJ/WonyVWlTM9n/Iq9qOMeXoDLig1AuskDHUV69cB2gDPfOGYlwCc0wX14DDyoa3zyo1bTJ4MwZiLA6smSp+3KXy+fUwWSvaXdpv5CK+cwXPYijFQI6Ced3ZK6HxhM61Yz3ef4TtSbVYiZNMMt9xuzAvbzJbZlKfUdf6FDTKyAbfXmTMDEUiNYLnUM8gJC+UpngRiir1VlfqY2wEsshnf/Q+bpGJhvK6mC5Fwox6qw4xz9HlpYUNyRXi5DJxLV57qo610XUsOJAavhR2xlq2p+YWXHHel/qPiBj3rOCrbGSoDkYAROvQQO2U96m0p4gqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKN35IjS1J5H9uBRow18ZpazuaZxo04G8QUSJ9jl1ik=;
 b=JNeCaLlKK5lZ0WyeLldY3BvoaKomlREgzENPNb9N7gz2gT1b7UuqE2SlnGx01NXeYBeVAWfi5OX2RT5qvpnxlneuRwCS1Hi4KqqqEygZE8gS2e2A3YEipFk58B8OOW1rMaUTBXIslyaOYsvCmVn+RrykfSqCxALwZ2Ef6/plAcI2VqX1T4INzumH/tYMe1I0lTaes+ujl2bZAE+RCKm1xYqLiRJromamzP6zxSa128pVm/Wc9qcvIzJQmH6aeMrO0iSimyxlUFmail0dWXI14f7LIkH4ghsHIOERMtGaXWXHrguqxMf/wc1D+VCmOaPD3u05Jfd6WeogUtyS7Fiytw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKN35IjS1J5H9uBRow18ZpazuaZxo04G8QUSJ9jl1ik=;
 b=cFsnKxkkWa4e/Pi6mXydtrLP2kFu7hTZCBcJF+WkpQkIP/SOL4yn7j0DgO1XbtO70E6FmsDeLBvZKO3dxdfXnW7xZHH85Amw9AFU1t3f2txU6XphhcVZP5qys6tA8pyYmHYexMKRjurDL8+vuSARiFeRIZPbhbu27SHt8re029g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SN7PR12MB8145.namprd12.prod.outlook.com (2603:10b6:806:350::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Wed, 3 Dec
 2025 04:48:24 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::a5e0:9d7e:d941:c74d%7]) with mapi id 15.20.9366.012; Wed, 3 Dec 2025
 04:48:24 +0000
Message-ID: <f1919804-d949-4b1e-be9a-45008ce051c7@amd.com>
Date: Wed, 3 Dec 2025 10:18:18 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: Seeking help on AMD IOMMU unmap logic
To: =?UTF-8?B?5byg5YWD54CaIFRpbyBaaGFuZw==?= <tiozhang@didiglobal.com>
Cc: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "zyhtheonly@gmail.com" <zyhtheonly@gmail.com>
References: <BB681211-3C97-4915-87D4-42773DEC93CF@didiglobal.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <BB681211-3C97-4915-87D4-42773DEC93CF@didiglobal.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0149.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::22) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SN7PR12MB8145:EE_
X-MS-Office365-Filtering-Correlation-Id: bc7e81ac-fc52-4fa5-4e4c-08de32273120
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ak9hVTgvNzlZZmkwZU1yOG9LVnRlRDBCTmd1WFRNbjJSYXRFUmxuWm1QdGc5?=
 =?utf-8?B?MDF6a1hMKzJ2aGpqRnJhYzRSbFRUVWNyaWh5OGc2d1dZR3BDTU4zcENZb2Zr?=
 =?utf-8?B?Nlo5NGRDMzR4QzBrQktIVTRJbUhRby85bG5HQlRaTFJJbFBuRm1Rak90N3M3?=
 =?utf-8?B?VE5GTWF2UzF6U0h3aWlqRmZPeDBubkNadlplVGhtTmR0OEhUZ2hHejgzczZM?=
 =?utf-8?B?MXBVU2ZNeWt4ODRYVjQ5UGJSdW5JRHl1NzE1NUpiaTNlSHhGT0JaR0hoaitI?=
 =?utf-8?B?NDVSOXF2b1BDOEp2eHpYaDdBeGxuUEgxOW94cmEzcUVOZ0hxMms0eTA2Tk1I?=
 =?utf-8?B?R1JJYlV3cGhXY1huRG1NaXU5NmlwaVFpeS9yNUpBWU1HVGVleU1BL1lObmk4?=
 =?utf-8?B?N29jTlR0UGY4VWljUmtFTURrM3dRMFcyZ0EwODlFbHFZOFZaOXJSQU0zUDZ1?=
 =?utf-8?B?TzdRRTFpcWlGRkVZTDBrV0l5c2dRWHVwZGQxSHNYVVJKblVBYUtnL0tHa29P?=
 =?utf-8?B?N05MNHVUNzgyL3RJMlFIeERadGk1VlE1SldiL2Nhdi9BcXNyZ2VpWGUxdng0?=
 =?utf-8?B?ekNiRlJqbVk4WDkwYkhsL0grT2paL0NLbDA0QlcyL0dxb2pwcWNnRTd3YUxh?=
 =?utf-8?B?dkdaWXZ6ZnFKMVpLVFJMZXhBSFJvSlVwdlNiOFFSV2ltbTk4UUlFYloxblZz?=
 =?utf-8?B?KzFDNUlaaUtTeUt2UnU5OVo4bnZEeGNaa2VXTFhxTGVXL2wxckVxOUd1MWxK?=
 =?utf-8?B?WmM4Y01RajZBeS92TTZlb01wbGdPTElsMWdWZDF1c0IvK0NDdGxmU3ZzR3Bl?=
 =?utf-8?B?R1I2Ulhub1RLTGZ4U3ErZ3BualVGUVBEQmsyV2RLNEREZ2c5cjJZUGtmWEhw?=
 =?utf-8?B?Vm1VL1g0Qm0xT09oejkzZ3YvSHZCVlZtdjdIUGdXdDdFUnBDQkxsV2ZpNkNu?=
 =?utf-8?B?cjM5ZjhTdE5pK3hyTlU0Uk0wampJUTZPdFlXYmwzMS9oaEpBQXVIbmlpQ0pt?=
 =?utf-8?B?S0g3ZmhpWmdkUXpseU1xTEtQQmwyRzJNSFhNL3pBOE1pemRGVTdyc2JHNk1r?=
 =?utf-8?B?Y2h1dWd5czBaWDU2eDNDMkpwbWJWYVJGbkZUZWZQQTRXN01NZ1NLMGI1Skdz?=
 =?utf-8?B?NWhiNnlqOGNkaWNML1N0VVJYQ3lBdU1TRmVxNUtYdmQrbG5ndVlJWkRNQjFG?=
 =?utf-8?B?RUpZRGUxY2Y5VUVHOG9lc2V5K1FhRENIdGpNRE9tVlQzM2I5YlpwV2QzL3BS?=
 =?utf-8?B?aG10Y2tDdGZqWXlsZjlsZnpmTHRFdjBiL0Fwa1lYM3dscjdzZEo4L1ZNT2Jk?=
 =?utf-8?B?Q3h0QnhZQVVNL2NxaElZYmNHZDZtaWxpb3YrYzRRWGZ1MG5US2JZZVZHV2Rk?=
 =?utf-8?B?RVZWWVNKZXF1cGJiUjI3RFNWYktnK0lmeVh6OThzM3hTNnk2Yytja2xBSkFQ?=
 =?utf-8?B?S1JpWnFNS0dhd3ljV29WcFNlV3RCbHcycHVaUTFGR05iVERzNC9ZdXdmcHhk?=
 =?utf-8?B?YzYxZHFkRW96b0VqQi9ST3BpNTFYbG9iUC9FRFVteDJNMUFsKzBIbjRuUHJG?=
 =?utf-8?B?dHpWVWt4WitJVysrM1VkcXhyZUJrdjB1alE2dGhPeWlCcnhOM0lyaXpHRk1T?=
 =?utf-8?B?S3dCeVc2dlA1cmlBeHNBS0p6MzZMM2tMWDl0N0VIWkQ0WFRhV0ZubElyNWRP?=
 =?utf-8?B?bExXUURHWXlra2M0dmw2b1ZtVzlnYlZWeGJzakZtOGFSOEd0MUloZVprQjBa?=
 =?utf-8?B?dk5sMkg0WElUREFaMnZzNU1UYXV5TklqRXM0Tngwb3JpV3U5NG1YYXpwRitD?=
 =?utf-8?B?MmsyVFRvZGtHWVJjUGMvQWVtUGZHejVEWkMxbHBTOTZSUzJyb1RLR0FDbnd4?=
 =?utf-8?B?L1JqaTNUbDRNa0NwMjdoN2FrMm1KdElJS2IxcVRUdmtod0hsSTM5Z0wwWXNy?=
 =?utf-8?B?R08vMG00emplYnhubW42OXAvRHFzckE1M0c5dWhFaTE5QnpPRHh0SWlISFl1?=
 =?utf-8?B?YjFDcE95QWtBPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?andjSzZROFU1dHVnSGFOV1VQcXcrVHRvckFCQk9vTCtLN2JFamRuTWg1Mkd2?=
 =?utf-8?B?WmtpVldzcDYxMkM5NTdhUlk0a2xmZHdzNERuSGNMRmFZQ1ExN2VNNVlKSjRI?=
 =?utf-8?B?VktFaHFYWElUaW1TS3J1bGpCTzZtaHkyZEhpYVZoTXkzY2xWc3Z6dDh1WHB6?=
 =?utf-8?B?NXI1QkowUS9FWnZFdE12V01oS1lvTjlWV3EzOThhTVBEMjlPSjVRT0tHRGNQ?=
 =?utf-8?B?em0zdjJ5dW5uaWZGNVZrKzFzMDQ4cDNTZmN3RUlSYndlSm1tdUE2OEpGTCtS?=
 =?utf-8?B?aU9YajZrS2J2UmQ3d1FTOHdTSVI3VVN3TnNnODVySStYQnVscmg4b292dWRq?=
 =?utf-8?B?cDZVWGYvcU02OGc0ZFp1RngxYmFmaVNkdjFzMnByWmVvTkFLL0xSYW5HVDNJ?=
 =?utf-8?B?bEZnT3hJVmJRNFVsdmFXRjBPZUxYenlFWFZwRnpsVDRYNEZLUHlWUFpob3g2?=
 =?utf-8?B?cFFvSDNMdFNtTks4eTBsbjdidTdROXIycU92OHduT0JwM3ZWbVN3K2hETlpF?=
 =?utf-8?B?OHhmanhwbGlSRVdYWUxhaFRNUGlTWFN4YUVGOVNCa1g5L3ZRSk9KOW0rVldq?=
 =?utf-8?B?US9FOGRENHVWeXh3RjRZRXg3UEtUalNTRS9jSmNzZ1Rib2JJRVphMHFqbEE3?=
 =?utf-8?B?d2R6ZmZzUGs1dVFHdDV6b2lxZ2swWDZJWWE1OG4xVTQwSEM1TzIrOXFod0Vp?=
 =?utf-8?B?TXBQRWE0Wjk2N1l1U3Y0MlpBNzNaMmhUWEs2dWhkdXZlRHNJN3QrNkgvbHlT?=
 =?utf-8?B?NlJJbWU4K29CTHlGTFovV1o4ak9ralBDanM0VzdNdkVJUnlvZDd0bXc0NkNh?=
 =?utf-8?B?OU1uRlNPajhWalAvREZkRlRsMnZ6dHNUME1Ndy9UUlJkQjhBcVcrMTlEV1ZE?=
 =?utf-8?B?Z1BDd2xXSktUd2JhR01UK205dENhNWlZelFodjRuYXVjLzV4UWQzNGl3cDVl?=
 =?utf-8?B?RDAwUExqTjEwWnZFTzNnUzV5SE9LT2ZFS3RVWTlxSGxIWUFjSHRjR0xQd29S?=
 =?utf-8?B?eFFBNlJiaUxHVnc1akdXMXZOSGp1cG94cWRMNm1ERkV2TFFQbDdETDFwRU1i?=
 =?utf-8?B?M0ZiK1Q0ckttWnljN04xMjc5WkNtZ2VhRjMvWlQ4eThLVUx4Ukhva0FuRnVz?=
 =?utf-8?B?eEFpdUtjYkhaZWdVOW9lQVVOREpzaGszbGVFTDlMU2h0VWZDcnJ4aWJSOUNK?=
 =?utf-8?B?eEV1T1dZamxZUi9peDRXYVBYRWM2TUg1VmxNSC92ZU4xTjM0WkhKZXV1MGx0?=
 =?utf-8?B?eXUySnJjODlKWUFiZ2RQQWN3ZTRUWSt4UFRZQzUxenM5N3kwS0dVZGpjZzhp?=
 =?utf-8?B?d1Fvci80WEEyWW1LMGgzWCt1bmdjKzFFQzlKZ2ZNMHFKMXFDL1NSRytCOVU2?=
 =?utf-8?B?Umtjd2FoQ0NTOXFVMG9ENGRJTzE5ckg4b0h5SVBQRHdZSGhYcEdPa3NFT0hw?=
 =?utf-8?B?bWFVUms0SHZCcEsya3crdGc4ZXN6WDRMVnljNmRrKytDK0YvY0NNR2VrMWFn?=
 =?utf-8?B?U1h0Qk9CYlIzU0hSSTA0WndpU1FkamdIcGQyZzliYjV2c1czNE1ZTTVtaEtz?=
 =?utf-8?B?SUorV09wdk9HSzVFL0xETElFc0NBVVN5MEVuZzZ2ekNlaW1FSGFMRUVWSk1r?=
 =?utf-8?B?K1o2ZU1IWlJYdi83bUxaVVc1akpBOCs3VGpPd0lJV2JXbVpuSitjY040blpz?=
 =?utf-8?B?YXYxS0JpNWdYOW42WkpaWjdOMkNrSlloN3hjT3lEZmUzNithSmpzL0xaeUxC?=
 =?utf-8?B?cjI3dmdFSlFsdkdPbUpmSjhKR0J4bzhIOXZvaUhmZ3hISkE0ZnVzQlk5Tldq?=
 =?utf-8?B?YzA4OFhJM1BVZHJxd2JHcFJkQWdWU1owdFRtNXRvRHNNSFVVb0lVQXlMK1V0?=
 =?utf-8?B?ckNqeW5RRzJUSHZ6d0ZQMDAzd2VqOFFNUGlUTFF2S3EvYW1kR2NvLytKRzdh?=
 =?utf-8?B?dk5ndEZhOVVBMnljVk0xWm1ZOVM2S1l2d2M1d0h2bmNDTitYRVFva21weGRy?=
 =?utf-8?B?NnYzK0JmdG1wcVJuOTMyMmllejAzbXBCUWx6cnVPTzBuSW5nMDUvN25mRWJJ?=
 =?utf-8?B?RUdIRFFDNWl4L2hGUWJGSEJpbE5HTktXM1FJdzBwSWFUSUsrVU0xZTljSlk4?=
 =?utf-8?Q?vxlD1e5NvVGaCnoW9AVfTHPVQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc7e81ac-fc52-4fa5-4e4c-08de32273120
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2025 04:48:24.5563
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYUwE80dxWFFnw9/roPkXfw/yI3EBmfWsRutOgiGgd8FOOmAxJR/hN6qC0AGs4GAteBMBBGCkGcTlnKgvVKaSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8145

Hi,


On 12/3/2025 8:19 AM, 张元瀚 Tio Zhang wrote:
> 
> 
> ﻿> 在 12/3/25 上午10:25，“Vasant Hegde”<vasant.hegde@amd.com <mailto:vasant.hegde@amd.com>> 写入:
> 
> 
>> Hi,
> 
> 
> 
> 
>> On 12/2/2025 5:01 PM, 张元瀚 Tio Zhang wrote:
>>> Hi Vasant,
>>> Hope all is well!
>>>
>>> My machines crash at "BUG_ON(unmapped && !is_power_of_2(unmapped));" in iommu_v1_unmap_page(),
>>> from vmcore I learn that it is probably caused by adding unmapped to an unexpected value after a NULL pte found.
> 
> 
>> I am not sure which kernel version you are using. Its very hard to figureout
>> where you hit this BUG_ON etc. Providing basic details will be helpful.
> 
> OS: Ubuntu 22.04
> Kernel: 5.15.0-97-generic

Hmmm. Its quite old. Can you test with upstream kernel?

What tests you are running?


> CPU: AMD EPYC 7643 48-Core Processor
> CPU Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse
>                           sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc rep_good nopl nonstop_tsc
>                           cpuid extd_apicid aperfmperf rapl pni pclmulqdq monitor ssse3 fma cx16 pcid sse4_1 sse4_2 m
>                          ovbe popcnt aes xsave avx f16c rdrand lahf_lm cmp_legacy svm extapic cr8_legacy abm sse4a mi
>                          salignsse 3dnowprefetch osvw ibs skinit wdt tce topoext perfctr_core perfctr_nb bpext perfct
>                          r_llc mwaitx cpb cat_l3 cdp_l3 invpcid_single hw_pstate ssbd mba ibrs ibpb stibp vmmcall fsg
>                          sbase bmi1 avx2 smep bmi2 erms invpcid cqm rdt_a rdseed adx smap clflushopt clwb sha_ni xsav
>                          eopt xsavec xgetbv1 xsaves cqm_llc cqm_occup_llc cqm_mbm_total cqm_mbm_local clzero irperf x
>                          saveerptr rdpru wbnoinvd amd_ppin arat npt lbrv svm_lock nrip_save tsc_scale vmcb_clean flus
>                          hbyasid decodeassists pausefilter pfthreshold v_vmsave_vmload vgif v_spec_ctrl umip pku ospk
>                          e vaes vpclmulqdq rdpid overflow_recov succor smca fsrm
> 
> Dmesg:
> [21447.107424] kernel BUG at drivers/iommu/amd/io_pgtable.c:485!
> [21447.113876] invalid opcode: 0000 [#1] SMP NOPTI
> [21447.118960] CPU: 40 PID: 47841 Comm: kworker/u192:1 Kdump: loaded Tainted: P           OE     5.15.0-97-generic #107
> [21447.131916] Hardware name: 
> [21447.143105] Workqueue: writeback wb_workfn (flush-259:0)
> [21447.149024] RIP: 0010:iommu_v1_unmap_page+0xeb/0x120
> [21447.154535] Code: 03 f3 48 ab 48 8b 45 c8 48 89 c2 49 01 c6 48 f7 da 4c 21 fa 4c 8d 3c 10 4c 39 f3 0f 87 6a ff ff ff 49 8d 46 ff 4c 85 f0 74 02 <0f> 0b 48 8b 45 d0 65 48 2b 04 25 28 00 00 00 75 16 48 83 c4 10 4c
> [21447.174772] RSP: 0018:ffffa658c0e88b90 EFLAGS: 00010006
> [21447.180476] RAX: 000000800000bfff RBX: 0000000000040000 RCX: 000000000000001e
> [21447.188129] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff9932f8406258
> [21447.195814] RBP: ffffa658c0e88bc8 R08: ffffffffaa269f00 R09: 0000000000340000
> [21447.203466] R10: 0000000000040000 R11: 0000000000000000 R12: ffff9932f8406258
> [21447.211216] R13: e38e38e38e38e38f R14: 000000800000c000 R15: 0000008000000000
> [21447.219032] FS:  0000000000000000(0000) GS:ffff9950fd200000(0000) knlGS:0000000000000000
> [21447.227778] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [21447.234137] CR2: 00007ffc1e1f8408 CR3: 00000001cbd2e006 CR4: 0000000000770ee0
> [21447.241870] PKRU: 55555554
> [21447.245015] Call Trace:
> [21447.247936]  <IRQ>
> [21447.250482]  ? show_trace_log_lvl+0x1d6/0x2ea
> [21447.255328]  ? show_trace_log_lvl+0x1d6/0x2ea
> [21447.260120]  ? amd_iommu_unmap+0x53/0x130
> [21447.264582]  ? show_regs.part.0+0x23/0x29
> [21447.269037]  ? __die_body.cold+0x8/0xd
> [21447.273241]  ? __die+0x2b/0x37
> [21447.276733]  ? die+0x30/0x60
> [21447.280123]  ? do_trap+0xbe/0x100
> [21447.283824]  ? do_error_trap+0x6f/0xb0
> [21447.288129]  ? iommu_v1_unmap_page+0xeb/0x120
> [21447.292906]  ? exc_invalid_op+0x53/0x70
> [21447.297229]  ? iommu_v1_unmap_page+0xeb/0x120
> [21447.301995]  ? asm_exc_invalid_op+0x1b/0x20
> [21447.306632]  ? iommu_v1_iova_to_phys+0xa0/0xa0
> [21447.311520]  ? iommu_v1_unmap_page+0xeb/0x120
> [21447.316289]  amd_iommu_unmap+0x53/0x130
> [21447.320664]  __iommu_unmap+0xf9/0x1d0
> [21447.324703]  iommu_unmap_fast+0xe/0x20
> [21447.328861]  __iommu_dma_unmap+0x9b/0x140
> [21447.333266]  iommu_dma_unmap_sg+0x8e/0x110
> [21447.337746]  dma_unmap_sg_attrs+0x46/0x50
> [21447.342288]  nvme_unmap_data+0x53/0x100 [nvme]
> [21447.347096]  nvme_pci_complete_rq+0x84/0xa0 [nvme]
> [21447.352271]  nvme_process_cq+0x158/0x220 [nvme]
> [21447.357166]  nvme_irq+0x11/0x20 [nvme]
> [21447.361265]  __handle_irq_event_percpu+0x42/0x170
> [21447.366378]  ? task_tick_fair+0x82/0x820
> [21447.370661]  handle_irq_event+0x59/0xb0
> [21447.374838]  handle_edge_irq+0x8c/0x230
> [21447.378998]  __common_interrupt+0x52/0xe0
> [21447.383313]  common_interrupt+0x45/0xa0
> [21447.387474]  asm_common_interrupt+0x27/0x40
> 
> There are other crashes in different driver modules (not only "nvme"),
> backtrace same at "dma_unmap_sg_attrs" and all above.
> 
>>>
>>> 251c4db699ca7b966db7e59e8663a231c96ba454 seems fixed this, with the commit message
>>> "Also if fetch_pte() returns NULL then return from unmap_mapages()
>>> instead of trying to continue to unmap remaining pages."
>>> Could I fix the crash by only applying this part (return when fetch_pte() returns NULL) of the patch?
> 
> 
>> I wouldn't suggest to apply partial patches unless you know what you are doing
>> and why its safe to skip certain hunk.
> 
> 
> 
>>>
>>> Tracking the mail list, I find
>>> In original patchset V2, this BUG_ON remained
>>> https://lore.kernel.org/linux-iommu/20220713053034.12061-4-vasant.hegde@amd.com <mailto:20220713053034.12061-4-vasant.hegde@amd.com> <mailto:20220713053034.12061-4-vasant.hegde@amd.com <mailto:20220713053034.12061-4-vasant.hegde@amd.com>> <mailto:20220713053034.12061-4-vasant.hegde@amd.com <mailto:20220713053034.12061-4-vasant.hegde@amd.com> <mailto:20220713053034.12061-4-vasant.hegde@amd.com <mailto:20220713053034.12061-4-vasant.hegde@amd.com>>>/
>>> Then in patchset V3, this BUG_ON removed with "and minor fixes to unmap path." described on summary
>>> https://lore.kernel.org/all/20220825063939.8360-4-vasant.hegde@amd.com <mailto:20220825063939.8360-4-vasant.hegde@amd.com> <mailto:20220825063939.8360-4-vasant.hegde@amd.com <mailto:20220825063939.8360-4-vasant.hegde@amd.com>> <mailto:20220825063939.8360-4-vasant.hegde@amd.com <mailto:20220825063939.8360-4-vasant.hegde@amd.com> <mailto:20220825063939.8360-4-vasant.hegde@amd.com <mailto:20220825063939.8360-4-vasant.hegde@amd.com>>>/
>>> https://lore.kernel.org/all/20220825063939.8360-7-vasant.hegde@amd.com <mailto:20220825063939.8360-7-vasant.hegde@amd.com> <mailto:20220825063939.8360-7-vasant.hegde@amd.com <mailto:20220825063939.8360-7-vasant.hegde@amd.com>> <mailto:20220825063939.8360-7-vasant.hegde@amd.com <mailto:20220825063939.8360-7-vasant.hegde@amd.com> <mailto:20220825063939.8360-7-vasant.hegde@amd.com <mailto:20220825063939.8360-7-vasant.hegde@amd.com>>>/
>>> I'm also curious about the details of why this should be fixed? (I know little about IOMMU, from my understanding
> 
> 
>> You mean BUG_ON ?
> 
> BUG_ON and the logic of "Also if fetch_pte() returns NULL then return from unmap_mapages()
> instead of trying to continue to unmap remaining pages." :)

That's because there is no point in continuing if some unmap fails.

Wild guess, you may want to backport Commit  1e56310b40fd2e7 as well.

-Vasant

