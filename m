Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=192.198.163.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793271126;
	b=KVtwGA3L28tuk+v3gG8jNKnY/vIBeu06vMR4wffD/RKsd73uUpQmf3hRA1iMzGGCky7A
	 a7B19M4Z435mIjBEXL8TJxj849nTQ/jisJguAeXcxWbtgix+AHvjca+0ONHPNnp4ISggw
	 rvRPHpshilJMVGytG5j6LqokBoG9V4ZIxSP0BfY+5XnMV70ZD8g8U5+ij3YoNOOkDBVP+
	 +fsU/FQZlIghu9HKF52xCWN2gVjzDLTU5B7USnr764DX2mThbcogDycysp5dFnhC8BzB/
	 47U64R3p8p3sJHwqffoKqKwZ/hbUkRSPxIM99MqM50gb6f3JOJYdsZIAMIMk416bW6w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793271126;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Received:
	 Received:Received:Received:Message-ID:Date:User-Agent:Subject:To:CC:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
	bh=q4JG4kw7XHM3KDYS2LAz7++DRNNfk2eTqlQ4YIUrMo0=;
	b=yfVYoi8tqaCE2jQ1HmuqyBV5Q2L1r8SL5SwT3KyJlmH0tczlCMDIpAFWKfWib4Hoi5aE
	 uzN9Pbvnss2DuOAr8VnMRh73IG1YJY2VOIJJb+R5kdhJ3yPRcdCcXssR1Hk0khRatoruc
	 DQuqmgXJec2fJRRZ803MndpJiLuPrF1VtYB3Qq/dKc+hOjzqVMdcSUiPH5uvecJ5VMf36
	 qZfQ2bVqynq2EqiHo6vhfCdu2Rar3LxRnchf4M2oqh/MnRKU6yoUt53eJcy5VQTsZWynY
	 JhFkX6VnEdPYsj/xqLeO7rIwYIFm0dUkff6RGR33ZGGAUTHNI9O2Dqw/Ebw0C2LqaBQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RpPJ98jY;
	arc=fail smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5F606A335
	for <iommu@lists.linux.dev>; Thu, 29 Oct 2026 10:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3FF5F606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RpPJ98jY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793271126; x=1824807126;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iSxDpdC98OgP2/ba8Bpy7S5rg3l1VFuYlWrrqZYdREY=;
  b=RpPJ98jY9jLJbBjR+OXNCK4tdeaVYwBDTU1WS+TLeIvbM8n2DEHMxglR
   CVXWpf80ueVFAkMB3BT3JZT9tSkD29VsyWEUGdeIPMVM0pIQLRd8KMOey
   Zq1HI/ldt3fVynN87Gl/4OU2qu+lxUfmNa22Etnw3IrD/e6b+mYsnU47d
   jLxXaD3DiFjBUWKGApL/Dh93KNa+488z7/XEcEkJdydxslDNtLmu6eCJ2
   fkJ1SC8mw7E4rRoWthwx7ytRbBbmy/ibiPPPa0pvT/2x285r5wR2LHT5u
   zJgCUf1g6gpU96wdasmwr7VAjqtZWQxkpTJE6PUslKxIWL+0FN0Dqc7hA
   w==;
X-CSE-ConnectionGUID: o1N+kU1BRHKKoujVe+QccA==
X-CSE-MsgGUID: JgB/1qS7QpuihlH8TYwyCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11949"; a="1905948"
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="1905948"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 03:52:05 -0700
X-CSE-ConnectionGUID: zb+TN9mwQVaI/QDp/rPp6A==
X-CSE-MsgGUID: NC3VYNhtQhyLhAyDANXxCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,184,1787036400"; 
   d="scan'208";a="5448989"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2026 03:52:04 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 03:52:04 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 03:52:04 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.4) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 03:52:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g16v7Ds8HXAUKSvkhFsEz/AYYI/KSQh8qE6pPnSU/2YPOnL6aOfmcpdxK6ES+lTB/wtDTkPsyDhDESMfIAm8FsigwR28d3fXQ6CacqiuoF6F3o+HEgQlRZ5qss++ikWVBf6TmD0mkXwUOVKMi0t8dAq2YaqNkrUrQFUAu8nrSbQYpEeS26LdODkmfG7+rgH+e9P4mGFQQEZIgvTcgPvKJVATNhvtv3yME8cdABTlE4/zJImaHY2Ze+Ke64ByF07TrKJnvvmnSLqQiyXKz5VJ+WgPhSi6rmq2fL+wMCoy3ATnpzFTZDI914nri6W/cEdpEyVEW7SOYRiG0CYnYItDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q4JG4kw7XHM3KDYS2LAz7++DRNNfk2eTqlQ4YIUrMo0=;
 b=vNsw1uNeQs6COQovmlMqvCIdtguGnG8A9I5csg3UuV5h9YGXSIF+frTKRZgIUmndkrWGXFwkb4m5OlXieD6cXm78H5ayr1V9Skv568DkAdOp0ZO8cahRoc3/xxWcLpz2a3Ru/cIDR75RbDtOmP2p3GAW5HahPGBNTSgiXj+23JB3nU4ifdbL4ZQJZQw8tn57B6fDQnDtCVb18CB5vw4n96Wcm7AxUUcBB+ax1paNJeT+RwlISJAalBpOuhoPEjyn3qw7/wypYuNQeCzl3AYa0wdN+8WDuGvbTWDSgMii0i1GZueHrWGLlgJ6YWf2FjBzkXkLFxdkfKohll3NNihfag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17)
 by DM4PR11MB5279.namprd11.prod.outlook.com (2603:10b6:5:38a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Thu, 29 Oct
 2026 10:51:59 +0000
Received: from SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe]) by SA0PR11MB4527.namprd11.prod.outlook.com
 ([fe80::1058:e1d:9694:c2fe%6]) with mapi id 15.21.0569.008; Thu, 29 Oct 2026
 10:51:59 +0000
Message-ID: <361137b5-a84b-43d8-a173-8df57fac8b61@intel.com>
Date: Thu, 29 Oct 2026 19:00:23 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/4] iommu: Fix attach handle publication ordering
To: Nicolin Chen <nicolinc@nvidia.com>, <joro@8bytes.org>, Lu Baolu
	<baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Jean-Philippe Brucker <jpb@kernel.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
References: <cover.1790718296.git.nicolinc@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <cover.1790718296.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::16) To SA0PR11MB4527.namprd11.prod.outlook.com
 (2603:10b6:806:72::17)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR11MB4527:EE_|DM4PR11MB5279:EE_
X-MS-Office365-Filtering-Correlation-Id: 373cb122-d0df-4777-a8a4-08df35aaa815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|42112799006|366016|1800799024|23010399003|18002099003|22082099003|11063799006|56012099006|261021121427099003|261021123027099003|261021135927099003|261026121527099003|261026140227099003|10067099003|261009223027099003|261022105027099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: yTd8FEp3Jtl7QmFJ06Enwl+ezJ9Ly7DF8+mVjGGtx53AmerS0ECRNuGkOhQtMgywpa2clkSumP3s+v7NIU56IhOltTswSRz7kjT9X5vWQtM5u8Pun74Xd6C4PNCeqPuCh1k8qp7dLxBs4ucEbV0IKeA6IaLCdSpr2/0Knp2Qr5S+Z7kIR2Z6eqY1kczw+BrJw3iQCHJA0HwaydzPWPo0p6D6nlUptXR+StNZCE/GaD0qlAXWsGKVzIH9hAHzRwTdJaitMb1G0fPQZBwJCC405N9UQPjwxaDUHduxTiLVyCvtRiWjTIkrUQuKlcSZ0gMBi+JBrdd/DiJC9j0oH9nJtvml3h7p2x7V8H904GV1/71C8MfZvHdXysOZNd+DFXEQgsMVE4kxbfH9Sgfx2qnBXNqbFTZT/V/nZ7uGYpV7f3i8l27jo+HdjK3nYU2LcdQLLJhsUgLLNoeLG6gqWiNq+diYWmmAenRH+A2YODhE0V121FwnYrSXxjvhUv8LSUpnVUXzAmJW0l7iO9DYV3p9VTWFEvw88AwE7w/sQUB+giYXrGaKt+tszO5nvAH8GRG+Ra8HG9nEB4/i852iCFO/QJPrpaNaQ0+fjgLCuZzv196yQH4Lj40/5CjjAiBL6E9P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4527.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(42112799006)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261021135927099003)(261026121527099003)(261026140227099003)(10067099003)(261009223027099003)(261022105027099003)(261028144727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TmtiWlN1S1RBNTcyU0tBTy9BRmVhVVNNOVN0SnRzVzRsMk1tMmJlaDUwNnNu?=
 =?utf-8?B?Z0xoMGc1RXJQMXorN0N0V1l2Y1dqRHlTNWxzajQ5bGpBQXBnamJYTTdMY0kv?=
 =?utf-8?B?eHJVYzJJVG00R29EMEtMcHF0ZnJ4UFRhVFFzR3hYSFluWTdJalBnbFh1U3pn?=
 =?utf-8?B?Y2lBTnpwSmpuU21QL2MyemlWTzd0aWl6U1N3bWxlRHhBRm5WZ0IwUnkyRTh5?=
 =?utf-8?B?ODRQclZxK2hiTUNwOXRWbUt5Zk5tY3llZGZUZ0pGcm1uUUpPRDVvTmhlZzNY?=
 =?utf-8?B?RS83NGRBVnlaS0dQYUpzT0VNL1VIOGRRVStDUzF2UnBpVk5xT2FLU24remZS?=
 =?utf-8?B?enMxM3BkU0hYVTZsL2EramNYT09XUFJoV0xFckd4RGJaeUNUSS9hN3NDZFFN?=
 =?utf-8?B?b2pwaXRjVTRuU3VxYzk3OG1WRStCWDUzNFhqeFNuZ3JxVlIxWnp0SEdIRC9a?=
 =?utf-8?B?V25qRVZyVGxRRjV6NExnQ3BiV25wYXZsZkh6MnZIY0haRStZNkZLdFJYY2Nt?=
 =?utf-8?B?T3BlUk8zUVhtcEp3cGpJTGY3a0c3RDBubWQrbnlCaXQrSDY2eTc2aXBtdUZy?=
 =?utf-8?B?bEtQaXVnSy9vZzRPeENmdVo0MHRyR21EbHVOWE1EWnhjMEg0YnNLWC9GRkMz?=
 =?utf-8?B?dXJBa3pKOVpMK1gvaGlHRElJOW41bzZxV0YwV201L2MvVmZtam90ek9nMVY0?=
 =?utf-8?B?T0FGVTRadjhKK2gzQVVRSzduNjZmaUtTTWVRNjdzTlR1amZnMjIwV21ONnRI?=
 =?utf-8?B?amsvNXk1Wk5QamRqSExjMzNRYllPcFlvNEwyNzJacytxaUlzRUZaOEMvL0V6?=
 =?utf-8?B?bkFBdXAxVW4vb0VZeWprVmN3MTlBNTZEV1YydEx0WjRCa0dRdW4zZGlXYXR6?=
 =?utf-8?B?Qnc1MmpQNnRFcHVVTm8wUHdUcHpOMUJ5TGVuL3E1UGVuNy8rNm1nR29ndGRM?=
 =?utf-8?B?MzNjNjJtMVRJR1FwVnR3UFZFZFdsM1ZqWFdlSDY2QmM4algyTEhkSHBnL1dj?=
 =?utf-8?B?SFNhNmkvWDA1bEg4NTlDMGFFZ0FLdmplOGliOWZMU01uR1g0MEJOTzRHS1Zz?=
 =?utf-8?B?Qll1SGFzRFhZcWVZWloxY0RPWm5NWDFWeGs2d3ZFcGthRm9Ia01scU1TbjVo?=
 =?utf-8?B?TUxpblRmMnIwNEFZQUdCVFgxZVdwOEtEMm4rUktGOXpndS9KSk1EVWhldnlZ?=
 =?utf-8?B?SGk5UDdrbzNpclREZlpwUVphUW5WOHZtUUZWdDErbGpwek5iU3N2a3NoRk56?=
 =?utf-8?B?eUlOVWQxWFlWM2NVVGVORlRoWVVsOXFheXQ3M2JqZlNmRjJRTnYzdzd3ZVFm?=
 =?utf-8?B?b3I1d3B2L2FyTnFmMjkvVUQ4NUp6ZG4zUUlHT0FsQzJtWjFPUXVyN0xsL0ly?=
 =?utf-8?B?bUczQTN6RGhkdlRPQWE3UW1IYnJkUWd0UVhmajQ1RG45U3FrWVRseXgwczZE?=
 =?utf-8?B?N05ZMWl1NTgwUExnM2pxZ3E3WFp0bXZnRFlvSVNkWnhGSlE3T3RqTmpwRkhy?=
 =?utf-8?B?MmFMYjRYcklrM1RXaWQ1cWJJTFBiZzgrTkE4cmpGVFV1Q21PY0NlK3J6ZVFB?=
 =?utf-8?B?OGhVUkxVZ2FZVHlidUZXcDRWdmVnT3VLSHg1eFZFSEdERlNyUzlBZThsekkr?=
 =?utf-8?B?dDZGK3FhWWFnc3FhWkh2NUUreHdqejkwMnJvU2p2WjN0bFp2U3VQWTV1QzB0?=
 =?utf-8?B?NWcwTDlxKzQzY1RPcXZyVzRMUzR1bklVcnl1NTBjdUNGcFhVbE4wK3FiWVJ6?=
 =?utf-8?B?d0t5Sk1yWU5SaHl1VTFDWXNVcE5GYkdZZ3pnbnByZGpSdUdRS1RoazU1elJj?=
 =?utf-8?B?WnFvRkdLdnR6OHY0MTBCUTJRL1NpZDBYR0pGT0hLT3EzTXRRK0pSeUwydi8z?=
 =?utf-8?B?ODBIQ0xRZFY5SkMwVWFqd2RlaUZ5RVl5Qk4yRmJQNk10Mm9QSUtUR2ozUDIw?=
 =?utf-8?B?bVZhMFV3Vk1YRXVhY3oySkVkNnFiY2NpVnhacUJIWnFhNFZtV1VvVmhwTVhD?=
 =?utf-8?B?OHdWTzZlZm1laEZlN1hFZWFVMlhKODdSUWlndW9jcjhjK2Q3RVlubkVscW4w?=
 =?utf-8?B?T2dUYytqUzE4QTBWU0VKRHhpSzBmY3FNY21kYnkwKzgweUdTMDg1WXRhOHRu?=
 =?utf-8?B?SmcrK3VRNGxVTmxkaGNiTy9WdnpWU2M1dUpVMVlzbzNsNk83RTlkTU4vOTF5?=
 =?utf-8?B?ZjEyM09XeDJlRk9KdjBjTWEwT0NwbXZJZ1VCYmd1RE5wRzhlektlREdjVnBO?=
 =?utf-8?B?MnhSMEdRc09TbzlJYW5QbUtDd1dJODNBV0lmazI0eW8wMktKTVF6ZTFOcDh4?=
 =?utf-8?B?M3JWcm4vWEVwZXVPOUhWK0krUkdsRFl1TnoraDhNQkQwbHdOaG04Zz09?=
X-Exchange-RoutingPolicyChecked: NUOQHtteckiXllHcnkdtgk2ESJZMCwfgF8sNtYfyqeY5eCNsXk2GHZ9QgOgGaIIww7M/0NRXU7U92Tbteht5KaMpPNCEl7Z4Uhk0/Ds9bP4GdILE/w3aTwv8K7lqgWWk8vpbS2Jso1g+N4rV6MhMngxNgBHezONXTil32+pxLe5yDpts+rskGrEYxOw5AFg+wCUAXlOH0ySaUx37mvDEBh3ukMmALTDgNShN3srMWA6WALQuAPXYSIc2WOV7HTtVQGXYNvbtwezfIQrMPAhDUdeKm2NzfAMGyg37R6D8g+94RYmH5apJLmyOdp0HW3pnmOOUtMg1Kd9zCeqS39Dq7g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 373cb122-d0df-4777-a8a4-08df35aaa815
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4527.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2026 10:51:59.3837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mCJtq+ZfeMEbe4d7joe5stGt6xL6oMxd4ZpXsGaLmiPt64ydt5EjE7X0UQNlaqdmadLWjghHk51BShKCYwVmyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5279
X-OriginatorOrg: intel.com

On 9/30/26 05:51, Nicolin Chen wrote:
> Jason pointed out an issue in the attach handle replacing path:
> https://lore.kernel.org/linux-iommu/20260923233920.GJ2545495@nvidia.com/
> 
> When an attachment is detached or replaced, the IOMMU core can still leave
> the outgoing attach handle published while calling into the driver. A fault
> report looks up the handle without the group mutex, so it can find the old
> handle after the driver's fault flush and just before the caller frees it.
> 
> These four patches unpublish the outgoing handle before a driver callback
> for both group and PASID detach and replace operations. Both replace paths
> store XA_ZERO_ENTRY to reserve the slot and restore the old entry on error.
> 
> This blocks new lookups, but does not retire a fault that already obtained
> the old handle. The driver must still synchronize those readers before the
> handle is freed. A same-domain replacement skips the driver callback, so it
> still needs a separate lifetime mechanism or fence.
> 
> This is on GitHub:
> https://github.com/nicolinc/iommufd/commits/fix_iommu_attach_handle-v1

this series LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

> Nicolin Chen (4):
>    iommu: Unpublish the attach handle before the group detach callback
>    iommu: Unpublish the attach handle before the PASID detach callback
>    iommu: Unpublish the old attach handle before the group replace
>      callback
>    iommu: Unpublish the old attach handle before the PASID replace
>      callback
> 
>   drivers/iommu/iommu.c | 54 ++++++++++++++++++++++++++++---------------
>   1 file changed, 35 insertions(+), 19 deletions(-)
> 
> 
> base-commit: cee9395acd8043be0644b25c34bfa86623f2b935

