Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288D2F24
	for <iommu@lists.linux.dev>; Fri, 14 Feb 2025 03:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739503148; cv=fail; b=t8K8yYLu4S3doSWNZr+lBUkAJesO4QFtp+xIb+iuribVdYsKk+05QTXnLtb76URP7jimcCXuBJ/lDmO0qP5il05lXbzmkkoWHNkvvUeGrXNXxUc7zse5RSf8Pt0lrWQj9m/HVzvV3VrL65N7hLwr+or3J95AA7YKbYLhS8hWxfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739503148; c=relaxed/simple;
	bh=JzxSZoBXlQdV5MRWRfnPw4BHuwVpsenc0VwnQ7pnvaM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=seqC2tK3Wo5vUhDr6eXpJh2DKk0rilNpkO1WqwaEYlVf260rVp1DS4qZu0ja5s4uulpwTw1hOZ3kFZ/RDsjbMun85qYlopg0EVNRJsNokbKtiaFpUQniqD+zFKluDhfRlGeD4ucn6obY2BR6z8EOBaJS+qK5LkR9+DHba3QejMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKyCiCb4; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKyCiCb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739503147; x=1771039147;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JzxSZoBXlQdV5MRWRfnPw4BHuwVpsenc0VwnQ7pnvaM=;
  b=NKyCiCb4XVz7tK2ooEk7pYJtXMbHhWnHUH5Ojl1/1IjolhtKBBgDe0a2
   31GTqL6N6ZaZsNftPSJCrcw6931gEc8QQPYYWfGoWt44Vh6QswgcJhov3
   1/Ej+1JZszM+P495N3142VmMbbUhLfVS4WLY0W6/16ezxda4AEuYnR5ae
   QYt/fS5v5j7L6TSZWKm7pqBaQJjQO1p9kHfxlFk9Twp6/dPnTiD++yzYZ
   T/pYP6gthfRR3TDEogPMDJ8U/UOKx59OchE8bugRvjfIZs4Xlz1fEmEnK
   HTY1QvkMa1vc8TYJJ8QiNvYhbQK7ZqhrgbVf+MqHOGaKJyMgbyR2+8KER
   g==;
X-CSE-ConnectionGUID: VDC3eXxiSamEkdNMDYyF4Q==
X-CSE-MsgGUID: Gtyb9hfjQ/qGYC27ydQj8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40354298"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40354298"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 19:19:06 -0800
X-CSE-ConnectionGUID: vzArjsKRQ5eJbXY7zOsFcQ==
X-CSE-MsgGUID: 64kJf6SFSS+PXc4HVH/rwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114231035"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Feb 2025 19:19:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 13 Feb 2025 19:19:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 13 Feb 2025 19:19:05 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 13 Feb 2025 19:19:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ORLMBMrgyE/8GlqrXFwF13kHpsfONcKLRh9lUfzJSjlF9mE/AdjKvKMMbEK8i4ae4G9C8E638afgagLRcqNlOl+ELjgN+yKPKDSQXYdmbrFNvYRTW2aiwFScOV/I+og1yH0pq/ttGOmX1kZx8St3MHk9IvONfzQN8icy+a1SYmBTuUO6bnqlhTjhl5BeS8wqUY/aRm3U1vE/HB+YtyXJ0ip34XMfBWR1l8ZVcPfLBUxG2DO0tRWLAsyQ31DMXo2gmcuzRkfNiEGW2+sP4/F9xvm1yWnnBFs45GeEtIEbT1PGj4VX9UqVwxFJ49sT+68pGyE91Arv+5gCBCle3SaWkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZe/+pEVKgrE2sX9PARE+ut0CquTeBEZO3zs2QXwNZ4=;
 b=o6UyHmiGuE8AmXDykydJdl9eFlFFOpk3FCiqk3hHOdar42UAFPRkCRkRRwkcaBhRsXn7l1Vg0mXAbtAGjqOKz6efjy9wUSI7YP4+H3mvjQlnJ47CX+YVrXVyDnnIQm5I6kLFar9rG4WzfFMztJ/bjeiUGuu5ma4BwKyLzMKsCRtfrKW1MaJARhFmxoWvkv65QVDXPVpNWJjy33I5v6JmkX1xpaAO6TGBZenSd6YXCtLRLGCbzjtRbmSo2KbpCN4jlR5UZFJdjBceJoBr2wN1WMhrzYq3VlmJwGq/xCoqJIfF0kpX4jICSRtHWnifMw2U7/LibQlU0G5i3OSCK3VKJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA1PR11MB6219.namprd11.prod.outlook.com (2603:10b6:208:3e9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.16; Fri, 14 Feb
 2025 03:18:47 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8422.015; Fri, 14 Feb 2025
 03:18:47 +0000
Message-ID: <6823aebc-5525-4d4f-bcb0-03e9e8ffaf65@intel.com>
Date: Fri, 14 Feb 2025 11:24:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<kevin.tian@intel.com>, <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Robin Murphy <robin.murphy@arm.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
 <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
 <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
 <5c5180cb-9bbe-4fa7-b109-5dad2ca9516a@linux.intel.com>
 <bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com>
 <20250212125930.GQ3754072@nvidia.com>
 <2399c639-b9dc-4c7c-bac8-3776cf6a88f5@intel.com>
 <20250213125618.GX3754072@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250213125618.GX3754072@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:4:186::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA1PR11MB6219:EE_
X-MS-Office365-Filtering-Correlation-Id: c8fc56fc-488a-4dda-5afb-08dd4ca64ba0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RDZET0o5R2pYV3FJY3NZSlE3R2VCUGw0YnJNRDVNSlpQWnNMWXdVenNudXIz?=
 =?utf-8?B?dlRVMXE0WjdYTVpmUDNsR0VhQzZNcThhWExMNnJxZHRRUW9nb1BlbXRQQndh?=
 =?utf-8?B?ai81MGtiTlpDVWV0TjdqV2Q3MW9hdkh6SGlLendsOCtZbC9qTTgweHdVS2xR?=
 =?utf-8?B?NEtRSklLVHFkNkdwMWdSaXZQWmg4eWdDM290UjdjN09IRk80eGdLQmpPMmpQ?=
 =?utf-8?B?QVBZK0oxSkFqL3BLdlZ2OHBGN3BrZWNwbys0YkNUc1FobGJIRUFVOGVJbVBq?=
 =?utf-8?B?c3BvOTZPNU10VStNUlo5SzZHc0xNcmNLL002eHNsNTNQMmxtTGNUSTYxZGFE?=
 =?utf-8?B?MzNoMkw4ZGFYWmhFTU45d2JnckRtRjc0V09KM2Y4N1hGa2FBd0hjS2p1bkRJ?=
 =?utf-8?B?RkpjMDc1N251OUVWaHA4WmZZU1M1ZEYyeGE4MW5wbm9jSjhBRVU4T2lOY2lu?=
 =?utf-8?B?cU53ZWxKRVNkckgra3EzSzEwSEJncmIvWlRkMmh4U3lZenU4NkpxUTJZMCtL?=
 =?utf-8?B?b0FQSnhqK0lwbTFpNGRaZStZTklyNWt4WnRucmlBcmhjaFhBRU5FNVlmeHpS?=
 =?utf-8?B?R092VGN5R1RsY0tRcHRacDJzLytwOVBCYjlOS2dPQkdicHRqT1ZSMG1UaVdK?=
 =?utf-8?B?eXpYRTJqR0RoaW5GTXFNS3V3c29nUDZwczZBdkJOWURzSnpBdFMzRXpZZWpq?=
 =?utf-8?B?MzVKSjJRUlNhdERJcW5iM3BVVnBkc25HcTFpWnNDUW5OZXBuaFdVWmd2T3pw?=
 =?utf-8?B?OWUrZFFrcHRUc2g5NnI5bE9TTlhIdW80bkVmSUtMcFppQkRuSWxtTVJ5SXE1?=
 =?utf-8?B?cnF6Umw5MS92RWx0b2NQaEVTay9hc3pqWmpkaWFEOVRFU1lrN1k2MnRxSGtU?=
 =?utf-8?B?MGJvSVJPV1JoSFliTkg3Z2s4dk5uNlJHbVFjRmZOd25nc2VtY3dQVmZZOVNB?=
 =?utf-8?B?QkVaMWpGUFlEOHdrcDMzM3NBYmxZaTNJc0wzZzV5cStKS1NVeTl2VTBUVVR2?=
 =?utf-8?B?OWltUTdQdXRtSE5naG1NQS9yQjh6eVRSYmxXYXlwN3JyNkFaS1MvKzB3TENI?=
 =?utf-8?B?VkNXak5VM1RzZWtVUFdBTDJBbXJlb1VDdDdZOERPSmhCa0F1c0p1dWlrYWYy?=
 =?utf-8?B?NGxQaTQxVUpUZEw1NjNlUDZBOWg4c3VyMmtGZGl3cnhWRjhCNFcwTk9yK3hU?=
 =?utf-8?B?UUQ0WjUwT3o0amNBMUVnN2orUmxob2hTR1dkcjYrd1NXOWtPZVRtNVFFcEtD?=
 =?utf-8?B?dXFuZWdROTFOZnlmb1Y1UklnZTViMG1RQnl3Vmt0ZWJaNUIyQUY2QldGRnox?=
 =?utf-8?B?cWVmd01aekRGWGdDeEQ1eGIrMUtuVDFGOWExMkdxRGJvek5EZDJnUlU0cnBF?=
 =?utf-8?B?ZGxsa2NadDJNblVFMkZLT3p5L3daTTFkSU93Y0lPVUl1M0FIMndOSGRwWWJY?=
 =?utf-8?B?WHAvdk02dVFrM0tNeFRDS2l1RFR6TTZ0czZ2QjFLVjBXWlZ0ZzBQaTM3TE9R?=
 =?utf-8?B?TlB5MHNZeVl3RTUyVnJZZUZDeHh6ZUtkVDRSM2NzTjlDU2luM2NLY2hnc1FF?=
 =?utf-8?B?QzVxVVpnQ0p0SzFKZ0JJcm5pdDloNTMvTWZNRXN2ZUg0UE0yMjhST2Q2NnpU?=
 =?utf-8?B?RGkzQmF3Sm05ODVjRk9KVkRDMWFsWjFtVEVubFJGOC9JTFc0aDZnTDVPN0Zi?=
 =?utf-8?B?amdpTSsvZzhtN2grTmFnRGdZUlNXR1dwcGhqcFNwVFZtSURmZEEzaTJPdWpl?=
 =?utf-8?B?VnBJTVRWMjJ0eHhIRzJmUXJzb1Rhd092WW5pWGhJOU01cmpMSjM3RHBOOGJ0?=
 =?utf-8?B?anUrZUhsV2VhRjN4THlnNUZZNjgzaUc0V3Q4TThUYTUwcXA2UXpNaG1VdUZo?=
 =?utf-8?Q?4s1X9UPGOhqAv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0ZYdFRLZGdKTUg2TVdOVEdaU20wcldEcEhYNkdFTHVoOVdRT0M0aUcwNkxy?=
 =?utf-8?B?eGlzcHlRejI3VGRjL1JvUU5RNGNXMng0L2JEcjhkaVFrK3FZV2hsM01SeERn?=
 =?utf-8?B?MWFsZTR6UUFOclhjQjV5Z0pLa3htanZrellCWFJKN2lHRmVKVHFxM1ppRnNI?=
 =?utf-8?B?azI0R1FBdmJ3TkgzaGRNb0QxOThjTFJyaThOQW1BdC9LUXZxMDV2NWhlOTl5?=
 =?utf-8?B?TFlrbGVZZEFGaVZQeUhuNERMMWVFWTl3MEgrUmx1MG9XUURlM09SdTloR1VY?=
 =?utf-8?B?aHo5c3lXbDRCSGJvUnJRbzl2TjEyM0cvR0MxejFGdVJ1L3p6RE1SbElhRmd1?=
 =?utf-8?B?NHJGS0R6aFVMY0xueUJLVmYyN0k0akxpeFdFRGhtWUoyYnN6T0RZdFpMVklD?=
 =?utf-8?B?eEE2UTl5U3BMdmNzRDhNQU1SYWR5aCs2cWc5NXU4c3c4RVNtVWlBT1pHWUxZ?=
 =?utf-8?B?T05LQ0hzV3ZNTkwwd0xBaWw5MDRCMW8veFQvWDVHRFFITW85U0tvdDJqN2pT?=
 =?utf-8?B?RDFQd1BiVk52a25qVDBreFVqQXFQMWlycVpUaWwrMDRKUWpzbk9BNE0vb2RI?=
 =?utf-8?B?NXNmTXd0bHFCTnQxVFhkSjNhS0NpeDRMcXRzaW4vdktkQUZHY080Yy9iNzgx?=
 =?utf-8?B?ZkJZR3JncGxCSW9BN28yTkZTWHVHSVFwS2xlaXBUMWpMZ1BZeW80NE11cjRx?=
 =?utf-8?B?aWsrWkNvWkNnVU02ZWExU05oNGdsVy9BVEkzT28yTStFNUl1b2h3V1dMR2Er?=
 =?utf-8?B?dDlBNmNRK2UyUDFKcTR3bUovVGVWQklOQkZDOUpzTWozZzZkNm5reXRROXVU?=
 =?utf-8?B?STdlbnhuQ1k4aDFaWUE5TzZRaWFOazRGUGVwUERMbFU1aVlHQm44aFF5WGRn?=
 =?utf-8?B?MzlXVmxOeklxdmdicDlBQmlVOWlReGo0amVGT3hZMEhDS0NqTHl4OW1uL2Nm?=
 =?utf-8?B?eEtjSUd5dmJ3eHBScXZZZ3ZrNnVDQjBBNWZPd1JIQWpLVm53dkpLOUo1UERU?=
 =?utf-8?B?b1NPN1Q4S0grdk5Qem1HVy9QODRMUkhaWHc5cFhvTFl0L1dXV2NYRWM3Y21S?=
 =?utf-8?B?TkpKSHQxZGlxWVRRaUZacXMrYkVzQi9ObnpBaERNdHBVcWJwU3Z4V2tVV0xM?=
 =?utf-8?B?WjdPOGRpUkhGNXFSWitXalVtdC9Semk5UU9LRkdJdzAvMVlhanRET3hRWmlT?=
 =?utf-8?B?YkFZTEpmRjNuQ05RWnJmcXRmRlQ0S3NSb1FRVm5yUUp6TDRPR3pGSFRkM01k?=
 =?utf-8?B?SWwrSTRPa0NRL1dLc09nNWZoZHd2d0w4cUFnWlRxNWNBZDJNaTJrNmJjS3hS?=
 =?utf-8?B?bThtemowOHRkZkhoSjM5N0NMUFdZaXQ1Q1Bpdm43YnZtd1pOQ3JIbW9Ecklo?=
 =?utf-8?B?N2Z0UkR2MGNxaEZieUtXVzhqczQ2aWJGV2x4YWtkalhDTDRac291d2V3RjI0?=
 =?utf-8?B?U1pjZ2ExMXBMd2lpSXlYWnN1YXBOWjhpY29naHlIaXR4WjZPYkhTVnFDeVlx?=
 =?utf-8?B?WlpIakNpM3hSWWlnMUNoSmJmengzc0FwZ1lpSUdPQ3h6TFg4Z2tVWkRpMzkz?=
 =?utf-8?B?MGRXbnV1eXEzN3R3bk5lMjJFbWNvb0liaDZxSUpJbW9ickp0VWhPUGhBWVUx?=
 =?utf-8?B?TFYzK2VHMjdHcko5NnAvbDRoNDFnamc5ck5PdmwzbmRDdnN1NEh0dDRVZHRU?=
 =?utf-8?B?YzNQM1ZNSWI1RU8wdW5Lc1ZTY0lnbWYray9BanNmL1RScCtmZ2pDNldJa2hr?=
 =?utf-8?B?aXc1K1FKaGpxQ0tGcnZQVWFCOXU2QTR3bEpUNVRNcVJpQ08vQWFGaHJJRjBq?=
 =?utf-8?B?emZVRXZ0T0MxTFV1YUtURjNMaitqTXFVeXpRMkZIdTU3d0h1YUhSeXlLbmZ6?=
 =?utf-8?B?RFNuakl5TUxxZGl1RC9naHVwVkxlVzlndFFObnZzWmthV2tJRlB1eHlhYU9W?=
 =?utf-8?B?Ni9YT1BKUDIva2Q2WHU3KzkrYjJsNkZVZUdJSlNiS24vZ1hZQ3cyT0p6bkFk?=
 =?utf-8?B?VElJMXRhbnRrTUw2UXpoSVNMeFhSdUFMZGFmZjk2bWhYbWhwN0FJQlo2b1Y0?=
 =?utf-8?B?b05ITXF0UzZGS3JlTEFFTUE0QXQrSDJjdlA0RzNRaUtYM2lxZFZWZ21SN3ha?=
 =?utf-8?Q?fvaNO9y+6SvgNQ0Ev+2RdFnp2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c8fc56fc-488a-4dda-5afb-08dd4ca64ba0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2025 03:18:47.6717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GsTGgdzeR9EJu1P0R/PktcaTlLrrT6TBZHBZoK8xr2WkAW4LjITs7w9mkEDNPANvP+uPzcKFNI9pTrgyTGLmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6219
X-OriginatorOrg: intel.com

On 2025/2/13 20:56, Jason Gunthorpe wrote:
> On Thu, Feb 13, 2025 at 05:34:52PM +0800, Yi Liu wrote:
>> yes, as iommufd always pin and map user pages for the paging domain, so
>> I don't think there will be any PRIs on S2 due to non-present pages.
> 
> That isn't strictly true, a misbehaving guest could deliberately setup
> a S1 that points to a non-present S2. Ideally this would cause no PRI
> into the guest and the VMM would fault the device.

yes, malicious guest can surely do it.

>> However, PRIs on S2 might occur due to insufficient permissions,
>> potentially caused by userspace. Nonetheless, I am skeptical about the
>> existence of such use cases. What do you think about it?
> 
> I suspect it is "OK", we already have to be safe against a misbehaving
> guest creating a PRI storm, if a misbehaving guest does it via
> pointing to the wrong S2 or just not updating the S1 doesn't seem to
> make much difference..

ok, given these facts, we can consider iommufd does not support valid PRI
on S2 for now. Hence adding the aforementioned enforcement is acceptable.

> IMHO it is desirable for the HW to provide a way to disambiguate the
> PRI.

yes.

Regards,
Yi Liu
