Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C8A1D12F0
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497201; cv=fail; b=Cnt64iXf62IK7INW5xkceaFtjlqbKoF41dS+5F9j+ALDIh+rtzzrrczC/HO8GY2aMIvrvgGi0yvnYKWHJ1VdaN+FkYP5hnkQBnWqlAFwei2Vp4OIIvVAwIyN8bHy18cC9b+vWKkBQt3pAW7kEUePmXOaZtKcOTB/dIZdhBxWQ1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497201; c=relaxed/simple;
	bh=xIHjEMjlaxFK+pYs+hwgdoTDtPKpmO9A8fdD2b88FPk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ALn9oGHWRwTC3OPiwa+BMtixtXT0KjGTDHK7NCWPGQcNvvh/I7dV1UD6Z9iZXQQowJsB6M+tdHtTgGW/YF8GNYcecdysGLVBNIKPGbIc0wdXkKWmC8pVAzhOfG8PkAx05Xp7oLBqNqX/i5p6MQXslbwLhotWNJRqbxjP2C48mr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVolwoH5; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVolwoH5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729497200; x=1761033200;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xIHjEMjlaxFK+pYs+hwgdoTDtPKpmO9A8fdD2b88FPk=;
  b=gVolwoH5NtgiM+e/SpJDV0Uh2s6FoAkqBMqoYU8fNhSap8mchg41to4Q
   xIQE+pR8gnW8VW2w/ViqfJBx92Zq5qOaCD3wcNCisPzEd5ztcruto9C40
   tJ4FmOgegN2EC4+8DplgS8O827TPYfCJSBK4NkMTZDeyXBAn51U8UTr0C
   VRsXDomPOQKTIZMM/S0rXoAIa56Pl4X0oYHDaxwfx4ZVr5e7ZRmApyJpY
   ydaEMJXe6/30Pxr8/Yw6YfIvEiAe0cShEcU7jXmIAaa7ttt5dbAhTLrbQ
   tk2nPQx64V5CLdgEiiO/0x2Im4paloH272jVYrbXBmR3R5GGINjhKE3Io
   w==;
X-CSE-ConnectionGUID: 8EVrSC1rQuSojZXqm25uMA==
X-CSE-MsgGUID: OU7ayZzAQVaYI0I5LMWYsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29083750"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29083750"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 00:53:19 -0700
X-CSE-ConnectionGUID: UGV34xmOSb2DqPsNJlMcHA==
X-CSE-MsgGUID: OLtMrrUvTQSZjZ24v6xvGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,220,1725346800"; 
   d="scan'208";a="110210180"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Oct 2024 00:53:18 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 21 Oct 2024 00:53:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 21 Oct 2024 00:53:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Oct 2024 00:53:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YgGhQFmReLK3Ithr2OhaggxD21nHXJZyQuD5mOPJf8bDCB0hO9qx5LznX4L1opDmj8g2ghAqOEEtSFq+8Gfaa3s9eII460B4m8qyf8WuJh3LEnL36Y9tBQ196O7urwv+zy9jioHG6nfJmaD8/XT0Re7nPHmbJcMwwue5zokT3F1lGWmzy63gury9KTimVLTJjH0r7BWgasInY8JIlggsXOiely/EXmJTudp15/eAHr63pZLNL75VyzIbtE0uTeouNuX117HPMWVZz73X5RwMaRknt3ZJNot6FzJ01X016SQqmSwGgRyDxNL7OVG4+HXLSpkncKY2U8W0r2HnJ2eV3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZLivR5Z7FrBeVN+4e5qZgIVY3dgV3pYLUvEHxynKlc4=;
 b=JNIFKN9coMLn5kcCyg9Kj2pjoNPTw1kmH8Nq5reQcK1aluGKjbkutJPGdtjJ3xZOYaR3w8dGBk/fbTJlJybGNgKV4dkmfjJ7/VTyvCl/GahnSpx0hOyhxrrnVRjyD4vq3OD6oRq2ZU+08cHMgbYP+ariOFBwQB92328trnYM3xfB3wzSQrt7lZC31CYwQ1rqak0czEIKyRdd3g/EGrgKFJmnBDRrKhdMkKU9rPlZgTAekQfWLsSLyV1AOsr+OHnFYk5wVPiX7z8ylOHeVCukKGl1PCQ4J99NCNnluBreG3R2dBE2JuBBb5AtAh1EiCKzXhFt/vzSqNVwKpV+Xw/+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH8PR11MB7069.namprd11.prod.outlook.com (2603:10b6:510:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 07:53:15 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 07:53:15 +0000
Message-ID: <f2871fed-3d69-4f68-9d82-53b619a5fced@intel.com>
Date: Mon, 21 Oct 2024 15:57:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] iommu: Add new flag to explictly request PASID
 capable domain
To: Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <baolu.lu@linux.intel.com>,
	<kevin.tian@intel.com>, <jacob.pan@linux.microsoft.com>, Jason Gunthorpe
	<jgg@nvidia.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-4-vasant.hegde@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241017140137.6028-4-vasant.hegde@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0097.apcprd01.prod.exchangelabs.com
 (2603:1096:820:3::13) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH8PR11MB7069:EE_
X-MS-Office365-Filtering-Correlation-Id: a704571f-f0bd-4d7f-3526-08dcf1a56b70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cE1ZU0V4eFY2cUZLMDhmWk0xaEhXY051Tm5sMERmbDU2aVl5S3ZpWVRjV0My?=
 =?utf-8?B?c3F0SWFkVTZNeEFzd3Z5ODlzUTFDWlNORlRFSy80MUhkYmNoRnM5bU9xcFVY?=
 =?utf-8?B?YmRyL0FlLzcxaXBTN1VuZmpaYXRBblhuL3RWQzVSV0RybzRoZWxWeVZPbXJP?=
 =?utf-8?B?cEJITjh6MGRqK3Fhc0dCVGxyTGpVNlRIVnNScjBRQ094Sk55QVdXR3NwQkV4?=
 =?utf-8?B?YjJzZ1AzM2dLak13TGdTa216ZGd3NHBTSVI2SFRmM3hENGVlNXg2MzJWODBr?=
 =?utf-8?B?NDBLR0hLTDIyaFFRNld4Skx3S0EyQ2FtdWYvbjZzaFZmSnVXZUxlNUp0ZTJK?=
 =?utf-8?B?TkFzNlBkTjhULzBxeXJIOHFUcTg5dGIva0Q2ZCtBdW5kRnZXdWU0MDAyMFcy?=
 =?utf-8?B?ejA4NU41MGlPY2Y2RThaWEFRay85cmgrMGFCZmhpdHRaZ002MW4xN0toTW5D?=
 =?utf-8?B?eUcybitzSnVvM0l0UjRUN3RnODl2MW15eUtoaGhpeGgvcTZLenVQMlpCNnFG?=
 =?utf-8?B?enVQdDJYbE84c3lqdDg0NzUyZ28yTTZkeWVEczc3b3BJUlZpSlRTNEt1SHQ1?=
 =?utf-8?B?dVBBdDdFdFd0N3RUdk5FKzR2ZnZ1czNkMnhpWkpSbTBJSTU4N0N0dU94Q05v?=
 =?utf-8?B?UkFFWXNaU1pkbVZhd0JPMDh2bzdNNUZNa0FBZ1hMVVpKeTF2MlBsVlIwNGpD?=
 =?utf-8?B?NmF1S0phMkZEcElLTzUxNzVyTWN4MDc5Y2xQRmtxSWc3VHBEdnNIVGxRb3JG?=
 =?utf-8?B?dEI4SFkvR2dVN21tVW9GaVBJQTNwNlgxMzBnRzd4V1h2NlM2bGw0RXh0bCtY?=
 =?utf-8?B?QXJqVUhuNGUrSzYyUElVVlRFL3BmY1Bpb0tqNEZwTy90dE1rdGtOV3BmMFBj?=
 =?utf-8?B?UmF1aUdQZlRXdlZCcnoxRE81Yy95aU9WRmFEMjZKOGVZbTZOMkx2VnFZNmN2?=
 =?utf-8?B?WnBhLzNXelJaamxEV0dHRm96T3pXZ280UmprZkdjbzlMSnc4NVlyMTlybFF0?=
 =?utf-8?B?ZkcyeWxpRFM5NXc3ZnpiMTRSUGNjZ0NqNyt3UkgzSnhhVmNaOENnczd2c2Fs?=
 =?utf-8?B?VEh4dkZDbnlZV1lRTXFwUWo0dVZBMDdac2l6ODBQMjQ4aFIxbGNZSHBTMjkz?=
 =?utf-8?B?dWtmb01JazJXNGc1Znc1eHRwdnI4eDQzRU55Y3RRckwrdm5xekNtcVZIVkVI?=
 =?utf-8?B?Sks0S1E4K2dET1pLcEdpbDBKY2pnYlFwd3FKMzBqb0lFbnN1NjhqTW15VytY?=
 =?utf-8?B?dk9xQzZ6SzNBK2ZEejdyYXoxVnJLQUd5c3lyeGcxUXN4UXc3aTJ6OVBXMDdQ?=
 =?utf-8?B?LzhHRVRFcWo3REEwbnpRTklQaEVpZXpPaDFoWVNDallMTjdUTk16Z3lneHhl?=
 =?utf-8?B?ZUI3K1kvd0hvaWZZMnVmVG13L0FqSGxnYXpWNERDNUw2L29XcWJxUUFRWktr?=
 =?utf-8?B?VWFmd1JkSldpZGo0bnNuSmIySkZMRnZ4SitTTEdvTFlQbytVRlJXdzFTM3ls?=
 =?utf-8?B?bjF5amRRaGhSWlpFaUwzVkI4eXdmV2p5OWx0WHVzeUVCOTExNlBVSUcvTXlP?=
 =?utf-8?B?VDg4WXd6NlVSSXFvZW1QQUJZWGdaRFFBNXB0dXFYNmpvcU1mUEo2bVRlUGVY?=
 =?utf-8?B?MDN5RXF0cXM4QThrUWY1ekZVNmZiQnViZFhNd3AzbnRQbW05QVZLMlVGUDBp?=
 =?utf-8?B?L0pVYURnQzBXdmJ6MWVEQVNXOGRoTTVJUktuTzFkakkxT2RYTUVQZUZaOSt0?=
 =?utf-8?Q?G1YFwapN54pr11fYII8X3v5mqpCo8/y3KP9A9ER?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K0VUdjJacmg4cm9iNkFuZ0U2TXdmZ0dIVnNjeStuL2Ixc21YaWU5QTU1dmJL?=
 =?utf-8?B?d0tHLzd1ZkE2djZrTmtxTGJ2MnRJbmNLZS81Y1QzZFBEbTJRdWlmcnBtN3c4?=
 =?utf-8?B?clF2UmJkRXF1RVZrRkFBMjNxQnFzcnN1QkVxVGl4bHh6SmhUOWU2NjV1US8w?=
 =?utf-8?B?ZXhhY05nckNPUTdBdUNGMlRVMWVaMm8rWU9aTnorVythL2srK0YvR3R1R3BE?=
 =?utf-8?B?K052MTIzSUYyNmk2RDVuWXZQL2dIWGNXNDB5QkJjdnpJa3gyd1VMZXBYbHlh?=
 =?utf-8?B?aS8wNXA3V1k5RHVjZ29aUVQyK0FjV1NOQzAyWk4wRWcvUVRpa2NNM09OZk9K?=
 =?utf-8?B?MGdSVm9hYnh6Q2tuNTkxU0RLQSs5MlRmcHI0SG9hVk1FTTBydThYUVNTUUZR?=
 =?utf-8?B?elZHT3lKQ2lDbHd1VVo4ZXBTdlE1RzZuVVBxZ3pVK085a25ETzM4S1B3QVpJ?=
 =?utf-8?B?VFZUSS9Zd0h3Ukcyd21HMmtRdlpQSkVWdWZNMUJYeGlDaEJkR1Z4SnVSdk9W?=
 =?utf-8?B?YWxSSW9lTGcvcm5qUUdFK2tJUU9ibUpWNVdyQVU5RU1YelBKYTVYdUkrSnJ3?=
 =?utf-8?B?L25NZXVoNWZFdmw1QVFQQzlUd3dRTVBSTEhMWkhWa0QrODNUUjlKU0JPNFBK?=
 =?utf-8?B?WE5LUXVKSDRUb2tIM3ZmdnZNOXZjZDg1NDllWHN6NkVybzQwd0RGY2M5SlVy?=
 =?utf-8?B?UWx6clVwenJHckY3TXB5bnpqcHRqUDNhaS8zZE9QWXBRK0NZMmRreXJTRFJS?=
 =?utf-8?B?UEE5RHlYSTJlajdwam9MVkhXckk1ZVBTOWNUVyt6aFFYM0ZBbEYzUDcyRmdu?=
 =?utf-8?B?ZFNqWHorTDRybEFWS1dqMmtzdGttdG9zTTZaaVNYTUtLVjhpZ3ZqWEpRWFVY?=
 =?utf-8?B?aUFtbjV3cjV5WjlDSlFKZTdSNk5jRzBYOFRoMXA1dmVTWlhqdmFWcGEwM3NX?=
 =?utf-8?B?ODZMQ3AycW9BV0NKb3dNb2tndnVXWWlyU1ZOT3ZyMlpyYmR6alN4NDJoeEow?=
 =?utf-8?B?TVNZZzhkcFNEU2YzTnB6QjNUUEJ1RkFDc3FkbzRML1lKMUlMbEpGMHVyVUQ5?=
 =?utf-8?B?QkJRQnNzMmloOTZ1aDZnbE5uOUlvdUNjWklzZkVsWGFuMFVsZCtGNUM5blA4?=
 =?utf-8?B?dVVxRm5KaFZBdXJmTVFYSWxEVXNRb3hFUXRqQ0NUZE9HK3F1VU1xenlrd1Jo?=
 =?utf-8?B?emRpem5Id0UrMzZDUEphQ0NFb2hJc1ZKSnpFcVNxUVpmSnp5WVFjd0FEUUlK?=
 =?utf-8?B?VzJjUXlpdWJtM0JlanY2Vm1JbWM4R3NlZStCdi9uUmhseG1JK0dTRVNFL0ZE?=
 =?utf-8?B?REhYcDBuMHoxWUJlS09MclBUVmdBZzFubDNsLzZ3dmkraHhld01kdzE5Vnhn?=
 =?utf-8?B?b001OVprcGMvdER5K3RnRGtzTEJuNjlVSmVBYXpGNEdzZ0cvbmF2dFh3ejVp?=
 =?utf-8?B?NWtZZTUrR0NUMndmMElFazl0eDMxNVZCY2lzTkxBQVNMdHpPRXYwUVgvL0w5?=
 =?utf-8?B?SVRMZ2xjaDhYRU5KbU5XdHJENGw5cTBRTFRzR3J4WjlVclVZWTl5THRjcnRJ?=
 =?utf-8?B?OGdGMGw2Qm9DeUZzQ3gxUndvOHdaaVV3Yk1USEZhSFZEVHJaeXRianVsRk5D?=
 =?utf-8?B?ZkUzM2VLTnpFM3ZIdzA3SUh4MmxNclBmN2RVaGt6N0FVeGdQdS9XVnRSRVlv?=
 =?utf-8?B?UEw3a3hRN1F0ZDdKb0NaUFlxK1pGZjlPdnNuS1dVKzNGMEV2dG81ZXk5VEc1?=
 =?utf-8?B?OWZ1Y3htNk1Qb015M0Y3di9IQTE3a3YvNWNOZUQwcmFTSGJhb25EVXRkeHEw?=
 =?utf-8?B?SDRYeG1ORFp0WXIwd0FOZnI5ZWQxVkttejF2UlpUTUlVS0pQWTV6ZWp4azhP?=
 =?utf-8?B?Y003TU9VeGRtbW5UUm9ZU0xGQXdLL2V3TEJhbTBWNTJEeFNzd1VieHNkbThy?=
 =?utf-8?B?TC9RU0dNK3pSVkU5V0U4OTNvQjIxbkFVRGxLWDZ6OGZRc3RHMERqcm84Y2NT?=
 =?utf-8?B?RGhlU04vbkJTM2dCY0g1UnR4cEZrQitRVmVwSEY0QWxzSDlULytPeTEwS09X?=
 =?utf-8?B?R0swcER1MVBnekZhWTBHUklWMDhPTDZRd2dFWDZHa2dTMTNyV0JhaXBtUlQ4?=
 =?utf-8?Q?+g9Q/FGiqkMhQE9ypUMkS6THx?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a704571f-f0bd-4d7f-3526-08dcf1a56b70
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 07:53:15.7242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ygBg57N5IXIprX8YGNrfo8YRPRpxOy2obUmcetVDsLONHwC4jXsjNi/ZM29IU5ux+/SZfpXJZ5isf8oW7brwJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7069
X-OriginatorOrg: intel.com

On 2024/10/17 22:01, Vasant Hegde wrote:
> From: Jason Gunthorpe <jgg@ziepe.ca>
> 
> Introduce new flag (IOMMU_HWPT_ALLOC_PASID) to domain_alloc_users() ops.
> If both IOMMU and device supports PASID it will allocate domain.
> Otherwise return error.

I think my iommufd pasid series depends on the flag added here. As Jason
suggested[1], I would add a check in iommufd to ensure all the domains that
used in the pasid path are allocated with the IOMMU_HWPT_ALLOC_PASID flag.

[1] 
https://lore.kernel.org/linux-iommu/5a6c2676-256a-4fa5-b9a0-e433d4e933c9@intel.com/

> 
> Also modify __iommu_group_alloc_default_domain() to call
> iommu_paging_domain_alloc_flags() with appropriate flag when allocating
> paging domain.
> 
> Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
> [Added __iommu_paging_domain_alloc_flags() and description - Vasant]
> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> ---
>   drivers/iommu/iommu.c        | 45 +++++++++++++++++++++++++++---------
>   include/uapi/linux/iommufd.h |  6 +++++
>   2 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e13d64ffd14f..107016b3ba3d 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -32,6 +32,7 @@
>   #include <trace/events/iommu.h>
>   #include <linux/sched/mm.h>
>   #include <linux/msi.h>
> +#include <uapi/linux/iommufd.h>
>   
>   #include "dma-iommu.h"
>   #include "iommu-priv.h"
> @@ -99,6 +100,9 @@ static int __iommu_attach_device(struct iommu_domain *domain,
>   				 struct device *dev);
>   static int __iommu_attach_group(struct iommu_domain *domain,
>   				struct iommu_group *group);
> +static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev,
> +						       unsigned int type,
> +						       unsigned int flags);
>   
>   enum {
>   	IOMMU_SET_DOMAIN_MUST_SUCCEED = 1 << 0,
> @@ -1589,8 +1593,19 @@ EXPORT_SYMBOL_GPL(fsl_mc_device_group);
>   static struct iommu_domain *
>   __iommu_group_alloc_default_domain(struct iommu_group *group, int req_type)
>   {
> +	struct device *dev = iommu_group_first_dev(group);
> +
>   	if (group->default_domain && group->default_domain->type == req_type)
>   		return group->default_domain;
> +
> +	/*
> +	 * When allocating the DMA API domain assume that the driver is going to
> +	 * use PASID and make sure the RID's domain is PASID compatible.
> +	 */
> +	if (req_type & __IOMMU_DOMAIN_PAGING)
> +		return __iommu_paging_domain_alloc_flags(dev, req_type,
> +				dev->iommu->max_pasids ? IOMMU_HWPT_ALLOC_PASID : 0);
> +
>   	return __iommu_group_domain_alloc(group, req_type);
>   }
>   
> @@ -2026,16 +2041,9 @@ struct iommu_domain *iommu_domain_alloc(const struct bus_type *bus)
>   }
>   EXPORT_SYMBOL_GPL(iommu_domain_alloc);
>   
> -/**
> - * iommu_paging_domain_alloc_flags() - Allocate a paging domain
> - * @dev: device for which the domain is allocated
> - * @flags: Bitmap of iommufd_hwpt_alloc_flags
> - *
> - * Allocate a paging domain which will be managed by a kernel driver. Return
> - * allocated domain if successful, or a ERR pointer for failure.
> - */
> -struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
> -						     unsigned int flags)
> +static struct iommu_domain *__iommu_paging_domain_alloc_flags(struct device *dev,
> +						       unsigned int type,
> +						       unsigned int flags)
>   {
>   	const struct iommu_ops *ops;
>   	struct iommu_domain *domain;
> @@ -2059,9 +2067,24 @@ struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
>   	if (!domain)
>   		return ERR_PTR(-ENOMEM);
>   
> -	iommu_domain_init(domain, IOMMU_DOMAIN_UNMANAGED, ops);
> +	iommu_domain_init(domain, type, ops);
>   	return domain;
>   }
> +
> +/**
> + * iommu_paging_domain_alloc_flags() - Allocate a paging domain
> + * @dev: device for which the domain is allocated
> + * @flags: Bitmap of iommufd_hwpt_alloc_flags
> + *
> + * Allocate a paging domain which will be managed by a kernel driver. Return
> + * allocated domain if successful, or a ERR pointer for failure.
> + */
> +struct iommu_domain *iommu_paging_domain_alloc_flags(struct device *dev,
> +						     unsigned int flags)
> +{
> +	return __iommu_paging_domain_alloc_flags(dev,
> +					 IOMMU_DOMAIN_UNMANAGED, flags);
> +}
>   EXPORT_SYMBOL_GPL(iommu_paging_domain_alloc_flags);
>   
>   void iommu_domain_free(struct iommu_domain *domain)
> diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
> index 72010f71c5e4..d1b07f4d9d32 100644
> --- a/include/uapi/linux/iommufd.h
> +++ b/include/uapi/linux/iommufd.h
> @@ -359,11 +359,17 @@ struct iommu_vfio_ioas {
>    *                                   enforced on device attachment
>    * @IOMMU_HWPT_FAULT_ID_VALID: The fault_id field of hwpt allocation data is
>    *                             valid.
> + * @IOMMU_HWPT_ALLOC_PASID: Requests a domain that can be used with PASID. The
> + *                          domain can be attached to any PASID on the device.
> + *                          Any domain attached to the non-PASID part of the
> + *                          device must also be flaged, otherwise attaching a
> + *                          PASID will blocked.

Just a double check.

Can I interpret this as "all the domains used by a pasid-capable device
(both the RID and the PASIDs) should be allocated with this flag set"?

>    */
>   enum iommufd_hwpt_alloc_flags {
>   	IOMMU_HWPT_ALLOC_NEST_PARENT = 1 << 0,
>   	IOMMU_HWPT_ALLOC_DIRTY_TRACKING = 1 << 1,
>   	IOMMU_HWPT_FAULT_ID_VALID = 1 << 2,
> +	IOMMU_HWPT_ALLOC_PASID = 1 << 3,
>   };
>   
>   /**

-- 
Regards,
Yi Liu
