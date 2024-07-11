Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF3139AC9
	for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 10:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720692956; cv=fail; b=YatSU7o4grgDvVphy2AqqAl/Htk5+tI05f9k5/54npPSiQIfQH2KmactXLNeERVPso5QOMqVbRFTL0LBLxaT+59NP2z0fnF+9vLoQRXcd5ttNaPj4ahEhypT8ytUOz+iEcGc0/GqDV+pBSh2bodhE1xuwzCe5fwBVtI8cXKnp4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720692956; c=relaxed/simple;
	bh=jrtYgF7nKdCMbvjSTwNcuWeqKvr2Th/fY2P/IlSZ1yw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=O5BM2AKM1tMCMLoE7SRy1yzlT9ookGjC2Q9iRm8S/94HDlcmACZVJItnTY9+C1IJw0MmyrOB8xxhLHC3lGHGCrsvjs3G+ISrlTh20Hz7wMHRB+bw4UDnucRV1PM05ATi1qSB4Vq1tIfJmtCyJRd6n8qOVD3dF+47TPz+JRCzeEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=k6+igiDC; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="k6+igiDC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oSbGEgzG239WPrLsDlvSOEDBJpbid7duZr7rLSYlsRIc1+z1s2KK6omStrzOd28A03C54xMAh8WOXYfgaiRgJAT3FzNoKzwYY93mUy/Zal/FJQjPHzziGqRvPlNv9ls2RWZZJnZAc+fXW0Y79RJaUv5bBbCIwTWtFvkFhbkYWSanXe03hSX5Q4R2JDVSsjYz3kPTd7hTdL9TQG+tqB/ubsOAX4u0ssQSUBPKLoizp6qjmXbSMBa/S8dZklVs6+qBmuxOtsedIbWwAXOyamo/OsYhxK266l42qLPdgNEEz2PsV1WKFVhpc+HLy6xTqTPRRYS5YmR4tZ4rasDokhJSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHUZrUuPC5acRkLdNlKbZ7ETr1fynH0qGV02m6Mignk=;
 b=iFrcM8/QK/8bRZiyTO92ITO/6Us9Amp1cWPhD/bRvd1DSWS6UzdvIRoDe3Wcs6dmvnS/7C4OnpUwJC1Iua+o6tSifNeXgp6WSSp0PLSRNgTmFz6O8bRCsxypWTdGReOfdLwZVGsnyEEW+R09YcHROIX3fNqlFX0xWPKXg0nJI0CEJqkvq0R5XNeYFEX1H1YNYg+hB6uvNKrPoTiy1T+Etfe02IuegAGhFlkW5a7TIkXaUgIqYQlfM/RvxjpHAcMEGQmIUR50t5rcmCoPWB10lMWzqrbGIPWdV8zXOhpuVytp0XK/JuGi3ItSYmu6aYhcdKqIKXeRlfz8INpc/VzRaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHUZrUuPC5acRkLdNlKbZ7ETr1fynH0qGV02m6Mignk=;
 b=k6+igiDCadsKuWYfS2nmluKctEYzBlidvpzVcBh6ZgbjseyJSXSTWuqMAjOaKzhtCXCMV9NObeTuE8bEYY8s50W8vYEP5g42XOQ28cj/VAd5QThLO8yQ145cKxwkZlwJna7GPTPW2HYlU8H4Jij1cbqScGQn7sMs+ikoN+VjSZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB7777.namprd12.prod.outlook.com (2603:10b6:8:153::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.30; Thu, 11 Jul 2024 10:15:51 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%7]) with mapi id 15.20.7741.033; Thu, 11 Jul 2024
 10:15:51 +0000
Message-ID: <4ffc953f-4968-46c7-b6a0-b7b2fc454564@amd.com>
Date: Thu, 11 Jul 2024 15:45:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] iommu_ops->domain_alloc_paging() enhancement to support AMD
 IOMMU driver
To: Yi Liu <yi.l.liu@intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joerg Roedel <joro@8bytes.org>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Baolu Lu <baolu.lu@linux.intel.com>
References: <7e249bc6-c578-40f0-aca7-835149a0ad39@amd.com>
 <20240628130330.GY791043@ziepe.ca>
 <26524622-971f-47f5-936e-d0173d342288@amd.com> <Zn77FbsQWmByf16t@ziepe.ca>
 <1f8f04e5-3b70-45de-bd93-e3c96fb0a555@amd.com> <ZoLmyOzOVYGLKjmn@ziepe.ca>
 <68d300af-4d3d-497e-9338-d99dbf88dd21@amd.com>
 <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <8bfc6cb7-d2d7-4d4c-9970-f4f207fb54b4@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0251.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:21a::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB7777:EE_
X-MS-Office365-Filtering-Correlation-Id: cca95037-f885-4009-a5b1-08dca19270dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmlsenNkcHhUNEQvZENEem1hcUtmWkU0dUM3d3lvY2dicDJQT2pNNGw5ZThp?=
 =?utf-8?B?LzZCUVlUOFROeWZZbWhna2FrK3BtSCtZR3hPOGJtNGdLSEt4WW5hWGp4Y3FX?=
 =?utf-8?B?aUlmVWhTSTQ4Znl3VmZuTFRMNy95a0RldjVBdk94M1JUSSswYkkvcXJoSlJT?=
 =?utf-8?B?NktqM29HaktxQVpFWFNxMXIvbGxUbFQ4WG5EYmJDcFVnN1cxRDJGL25mTHoz?=
 =?utf-8?B?RVhmR1RHTzhrZlY1ekl3RWFjUXVETG9hZzk3cHNBMzZPai9JSkt4dkdtM0I0?=
 =?utf-8?B?V1A5WXVoNjl0dFQ2bVZwaHp6SndvMDMwQTVvQStoSFRqUG1nOGRZQ1JJK3JG?=
 =?utf-8?B?V2o1dXczVkFaRjFjMS8zYkdnNHoyd25JVnA0RVdrUXNRSFRaTm1IS01MVzVW?=
 =?utf-8?B?SW5kdjBYamx5UnhKckxkenVoWDdCUDJ6U3VJeFNSaWVjSS9TeTdnK09sdHlq?=
 =?utf-8?B?cWZXak8vaER2dmx1ZlE1MmQ1aWM2ZUNDYy82cmRNNXVJdHp5aFhyZ2FxbHFD?=
 =?utf-8?B?WnZFWGNYWjd2a2p3bjl0Qy9rbmVLMnd2TWVZNUFGRkFhdS9uU09XcmdKSWJx?=
 =?utf-8?B?NmhOQ2ZJeXFualFSTTlKeHp1VndNaTRNOWlURXZmMktMK2hDazNNRUZWWjNh?=
 =?utf-8?B?UVRYaWExb2VvbEczNUJSWjNrOE1rTXl6Q0h4RHpGbUl4UTdXNTVCVi91R2dp?=
 =?utf-8?B?RThuVU1VdmV1cnc0MzFuRWU5d3Ayd2FmVXdvL0Z3TEZEa3dIa2hhTVdobEFt?=
 =?utf-8?B?ek9QdUVBYkZWc3BJRHpnaDlROEF5YVl4K1Z6QXZLTnlkaXpZOHdTdzlNYzlK?=
 =?utf-8?B?WDRpUEpzMFFxREtON29DczBiNFJueFN4eC9QejNIcEc1V2dwaHRIcWx1bG02?=
 =?utf-8?B?NTEzVzNYYUgvM1phSElEcVBtRlBoTXlwUDc1dUkxblpRRVhRUEY5NVFYNlJv?=
 =?utf-8?B?QXRvUHhENkQ4OGlnOHpoVDVLam9HUVgvQlR0RTBZWGhmeGpDd09aWnpidmhs?=
 =?utf-8?B?c2ZQTXkwcG5lL0d6b0hhMStUY0FqcEJnVHZOTEFHaWg2TERmdFE5T2w5ZmNp?=
 =?utf-8?B?dnRnNEtQWEZMcnJYa2k1TDdiMkJ0ZEU1U3JUdHhVTlBVK08rVnQvMDI2UEpX?=
 =?utf-8?B?dWI3OFdoSXUyMERPVUhveXcxMFVOaCtCS3FJN1pxK2xkQzNWc2xwS0svV0I4?=
 =?utf-8?B?Y0sxck12TG40T1hrKzJqNnFtZE1rZS9LZk51RFZheVJTT2Z4R2x2VTA3bFo2?=
 =?utf-8?B?M1FEcEw1YzJqVGxFUlZkb1ZRN1FNcjFpMUxVMHB5SEpDb3N2WERJTFNNaWdi?=
 =?utf-8?B?aGtremZ6NDFXWG9KOXYxOHY4MU1kUDd2dk9sTEt2OTZpUjV2MllQOVpwSXlY?=
 =?utf-8?B?bU5aSFNSd29XYTJUVis1SFNQNFFtd1EwSDRhb0hncUlWNE0xWEowK3pQSlFr?=
 =?utf-8?B?QU56bmJ2YlUvOFJ5M0NYSGJGNWpCSzlIK0dOS0lWK1lOS0tIbU1zNGNMY0hv?=
 =?utf-8?B?VWxPR2xyWjdSOG9xYnQwNlRiM3Y0MU5Mb0czRDhvRDhiajNhMEZTdGs5aTJN?=
 =?utf-8?B?YzRkK29YWkRPTmdNWVJySmZVQ0VrNE5zLzNRcDhIRU5qQi9FS1JDN0tBYTlK?=
 =?utf-8?B?dG96dWpBM2FpOXNBa3pXSXcxZkJUUkVTZGI2MGZFeFRwVHhLL1lHS0F2K01D?=
 =?utf-8?B?NkJoOFF2Y2VOaFBMUDZOT1FOc2dvUkI5ZDdtMEQ3bnF2MldIeVJhL21DbE01?=
 =?utf-8?Q?44vy1Vk6Q5U1rqKcAe5lnEp6K+oqTiR4cY3ASXB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGMwSEFiZzVhTXZRZVkzS3FrVjZYTlQyY044aWZ4M2F0OEszVkFyTnFLSnRD?=
 =?utf-8?B?TnZVNlRVaW4zSkwxdDJQQUVSNkdyZDE2MkhHS1ZtYVBzdXRXNmY4M0s5MXFw?=
 =?utf-8?B?UlhNb2d3VXRtaVFxaTlUQW1QTFJTWTJ5RVVyTWJQODF1bUdPeldaZ3pkQnY4?=
 =?utf-8?B?VTlScmJmdG1GeitQRTNNQnRDdDd2dVZxcHQ5V0ZaRjJFRi9JU2tLYUNTL3dN?=
 =?utf-8?B?STByUkVkeFVDK2FvTVNFeG5HMkVPVnFrVWZoZElkZk9EcEx0bi9wN1ByQVN6?=
 =?utf-8?B?eHM5NnRZWGxpWW5WVWdDNmNZYjV3amtBSjVwbUdEbS9hN2xIL0NqQ1A5dmUv?=
 =?utf-8?B?T1VZRWJ3NUoxSzdwSEhVcW1iQXBMVFY0RE5PeVduMVRBaHEreFZycCs2WE9V?=
 =?utf-8?B?ZHRTWHUyZUR3eDkwekdLcW95ZDI2T1VBUDB5Zy9KSnNWU3RPbUFuUU43ek5Z?=
 =?utf-8?B?bzMzd1NZaGJ6VjFoeTdZNkY0eFJlZEVqbHlBczVLeHVKL0YxSlFxSG9PaEhP?=
 =?utf-8?B?aUFweWtVVmdYSUJLL2dEaUU2ZGplK0NiOUdXOUN6T0FrYUJkRFpveDVycXB4?=
 =?utf-8?B?Mk41TmZnT0llSm5MNUs4ZW84UkU5aURXZ1FqN2U3L2RpYlNxUkxIUHExd3hm?=
 =?utf-8?B?Q00zMzFnaXhIQTU4dzNlL0syTlZVL0ZlSzNnVFVXQVE3dGFUVTh1c1N6dnFs?=
 =?utf-8?B?L0ViUU5SaUovOTBjMy9QTFJwWHRmVmc4VzVsN2I1cXpMT3VGMTl2dGZKN0ZU?=
 =?utf-8?B?K0Zpc21ZTXI4NkdiZW1iSHBBY25NMDc5RXJoNmtBQ1JrMm8rcVBpbUtwdVhU?=
 =?utf-8?B?OHR4bmQ2WStYeDRkU3NUTGd1bi8zN3FBWWdsdUdZNGNGYzNWZ2hYVGovM0VP?=
 =?utf-8?B?eGcxVXp0ZDlQeStTY2MzcnJlY3RZZDUyeHZHRkR0V21LTDVYVUVyNzhoaWd6?=
 =?utf-8?B?SUc2akxTTjBLVTBLUmdoVW14ZEJhekJmbFJLL0JmWGRxSThod1huRGs0dmJi?=
 =?utf-8?B?QVU2WjVOQWJSUkk1TGhleWppNzV5R2FTZ3NUenppTXhqZm1DUzdnOTdxcVht?=
 =?utf-8?B?b3ViNjdQN0tpdk43Z3VNNXlXYVdOamtIZVprY0t2TnJxNWYxbm5pR21DNGxl?=
 =?utf-8?B?WnBaY25kNUFiM0E3S0xGQUN3WmJkYWJmc0x4dkZKcUFCam9GQVZHQ1ZpWGd4?=
 =?utf-8?B?MGlCR1pjSUZweGk3emw5ODNZTk9kbW1SWWdEcTFyT0xicTVTNWxXM0d4ZHhR?=
 =?utf-8?B?bjVUd2s2dldYSTg4QWJQclpOOFVTNEFBSFhrU2VhWGhIYVlHKzVPd1BML1Vs?=
 =?utf-8?B?Z1VEMUo1c0pkS2ZmQXdiVU1OSTJTSmtvWVpDeXRib0dMeEhNLzZNNnhZeHJT?=
 =?utf-8?B?Qk1UNHQwWlFRREpVOVpOekMzQ0p3MlRLQ1hKcDJQZGdLUW5zd2FrWW1kcThF?=
 =?utf-8?B?R2dlN0JacG9MT1NxSlhMVjVaV0kyNzhBSU4yV2FkTUFyWUxPMVZVTWhMRHEx?=
 =?utf-8?B?NDIwbFNpZ3ZzQVBETlpQS05UTDZQdVp6UjZ5NjdGVGRaVE5ET000eFYwUHpn?=
 =?utf-8?B?bHZVNzJ4WnhVNkNQNENBRHphZHpJZDNDUS9UVXEzQkFGUHorQUFWdkgxMnZS?=
 =?utf-8?B?REdIU044N3FZdEd5NTcwNUtqaUphTkNWOElveERlQ09zNUU4NkZsQUx0cDBj?=
 =?utf-8?B?UG9lc2tpcW5iaTZjMEd6YlJSb3FTYVYxSmtZK3d5Qzhnd3F1cDA5Y2RkdlVS?=
 =?utf-8?B?ZEZoOTJaTWJiWk1KYlhndmFTaS9ZcC8wV1hUWEMyNElsSktBUDRUTGZzVUFQ?=
 =?utf-8?B?em5LWGcvVkZGZFhhS1BabkFDWFVDOWpFL2ZFZXVGZUxjWHgwM2dvcjdjNkJF?=
 =?utf-8?B?cXV2NDRQN0dmY0M5M0VTVXdZUHpuMGl4QjE4T2FCcmhWYm1JV091NDd1TFVm?=
 =?utf-8?B?VHdqd1AzSXZWWmpVTVIwRnkzQWVUVUxKNXV4K01HR3M5VjJYMzE4OG5xUVhW?=
 =?utf-8?B?VnJkN1RzYkpXd0U3QzhtMmZhV2hoV1ZQYjBTM3kvdnF3QjdBNnoyUFdsd0wr?=
 =?utf-8?B?aFJ2QlZaNjdFUHRSek9vR2ZkaE9EcHFFdHZZaTgvVHQ4eUg5cDIrY1BLbVlO?=
 =?utf-8?Q?xSGEfOGN+wz8CglQWYIOM6P6a?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca95037-f885-4009-a5b1-08dca19270dc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 10:15:51.3736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzvELYgpAPBxs+aD7pfmdeyGg4RAkOVsan1LRaN9b1iDAi0T0IEC/fbbo0bYLoi1lRrcWCQDyJ7Qy99iM3fg0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7777

Hi Yi,


On 7/3/2024 12:27 PM, Yi Liu wrote:
> On 2024/7/3 13:42, Vasant Hegde wrote:
>> Jason,
>>
>>
>> On 7/1/2024 10:56 PM, Jason Gunthorpe wrote:
>>> On Mon, Jul 01, 2024 at 04:18:01PM +0530, Vasant Hegde wrote:
>>>
>>>>> Then VFIO will just request the V2 domain anyhow and you are right
>>>>> back to the starting problem again.
>>>>
>>>> Let me see if I can put together here.
>>>>
>>>>
>>>> - Basically we want domain_alloc_paging() to explicitly tell domain requirement
>>>> (ex: allocate PASID capable UNMANAGED domain)
>>>>    If we do that then we will fix ordering issue I described earlier.
>>>> - Fix attach device path so that for 'PASID capable UNMANAGED domain' :
>>>>    non-PASID capable device will use AMD V2 page table with GCR3[0]
>>>>    PASID capable device will setup its GCR3 table as well and it should work
>>>> fine.
>>>>
>>>> Net we need a enhancement to domain_alloc_paging(). Otherwise I don't see a way
>>>> to reliable implement things.
>>>
>>> Yes, some flag at domain allocation time is clearly needed
>>
>> Right. I will try to get this going and then we can fine tune with Robin's
>> suggestion.
>>
>>>
>>> But you need the whole story, including when will VFIO set the flag,
>>> which requires a uAPI someplace.
>>>
>>>> But these two can go independently?
>>>
>>> If PASID goes with a default-on uAPI then you loose what you are
>>> asking for as VFIO will always request PASID.
>>>
>>> So the overall plan has to be sorted out now..
>>
>> Is this the Yi's thread you were referring ?
>>
>> https://lore.kernel.org/linux-iommu/20240628090557.50898-1-yi.l.liu@intel.com/
> 
> This is part of the whole work. What Jason refers may be the below one.
> It includes how VFIO report the PASID capability to userspace. There is
> an open to be closed though. I'll loop you in the next version. :)

Thank you Yi. I will start looking into this series.


> 
> https://lore.kernel.org/kvm/20240412082121.33382-1-yi.l.liu@intel.com/
> 
> BTW. For AMD, can a single device be attached to multiple V1 page table?
> IIRC. looks like AMD has only one V1 page table pointer per BDF. But there
> is a PASID table which has multiple cr3 page table pointers.

Jason covered this part in his response. Basically AMD has two page table :
  V1 which doesn't support PASID.
  V2 which support PASID

By default when host is booted it will be in V1 page table. What we are planning
is we will implement domain_alloc_paging() interface in AMD driver. As part of that:
  - PASID capable device will be placed in V2 page table, rest will be in V1
page table

For UNMANAGED domain (like vfio-pci), we would need a indication from core layer
saying whether we want to allocate PASID capable domain or not. So that
internally we can allocate appropriate page table type.

That means from VFIO layer we need to pass this detail to IOMMU layer.
For this part, I will start watching your patch. May be we can start discussion
in that thread itself.

-Vasant


