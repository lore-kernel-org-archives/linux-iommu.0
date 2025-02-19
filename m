Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9911DF75A
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739967312; cv=fail; b=ItCtcKZ7tVtRzLgnMei9fD2nwr7qnbOgGrSbkAnOmqkLp6uHoP9/P9j/xz/a/XEl8+kLafhf2Tm+I6ZWiRJDO1vkT6uvNm4Gt6kRq7wZWoSLoVDioLw1nRxfWr431y7gL6InfOTJICfAr3ZnJwDl2okQttV8srCnMEN6L+ICkRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739967312; c=relaxed/simple;
	bh=YnaUWpIDBgFdc8+MgajWJpd3pbLOGNnfg6JV/F+EBmw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qjF/SBURJnSjimZPn6ODncJ/tsSFMV0oeEpak/3GJxTAOmnqhwH7c42NGzRH/9qIErTrsyeTGUO8lvFhCx5lL9Qqk39kg2yXigjvALjwHyp53/BP3iAX0eC29dTO3OP+KmFN8Xn/loisBs4SuoAmVu4HBbmq7g8WSrozqGfHjEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJpmH9oE; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJpmH9oE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739967310; x=1771503310;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YnaUWpIDBgFdc8+MgajWJpd3pbLOGNnfg6JV/F+EBmw=;
  b=RJpmH9oEY0B2F2x2sTRsH2psVqICt6w0py7LcCQZdZHWgT/7KaFBt4Sv
   YMe1BL0Zjfaal8vCDPTn2lcOTusl57tp1zAG14drh3Cm5NOnCGOh1Q02K
   N1WrKer6OO9rG2pGwLbb7+ADr4vmo0cd9xdlEUAFaLNOCXgQ3spRO7Bbg
   UYooj1FTpfwriH1f75FuQZRZ5wZk589ZR7NyUaLJha0YuVFc8K7iKMhxU
   2L7lJ93y7oaZgm4tYpbVIwdhsL7MqMjz2qOgD/oJvpz6A5bN6joXxxG4u
   Aky9NPXRC3yz4pJaGg3dNe3m+79DTfHaeqGR7idxvs5hIIxfD8YuHAgXF
   w==;
X-CSE-ConnectionGUID: 9I4umpnQSo2ExE4unBukHg==
X-CSE-MsgGUID: oxwIKCITQ9CsHVqmv4AJ5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="40824711"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="40824711"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 04:15:08 -0800
X-CSE-ConnectionGUID: SU4YirZ8TxOrI2IjMcMM4A==
X-CSE-MsgGUID: LxwYAevtSXe7wKbIsyLG0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118833489"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 04:15:08 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Wed, 19 Feb 2025 04:15:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 19 Feb 2025 04:15:07 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 04:15:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fVbrlZsQbGsdaLX7GTT94M5mzmB3iAMRHtK9foAGE3bsHp+j0f+GQ4W4MfxiiemYU2pvSy6n+CQhOTk4QwQCa2JD8pRSaC5c+rMfNeZFdlqm4WTQ7LoVo3zzQH4M8imzl0Dz6n7rCnEXgINTG1v/lWteKlS/JMgFabt+If1jXWj5IaJADYHSEH/2ZnCFo3fKnAkSz52L6PlWm7nA7Nhw+a88EFaTj0QTsPeg034otwXv/KigGDrzI/SHLkBCZuGFb6SfvoDb7qfRRTggIc5bG36vDxnvbFnWDiLaWlQufjORCeiC4UZ218JDDYot8kVoQN0JF8/UBtrJ9FgQ91GpBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbBClZ5+TMEu8BdqEA6soj0CZuUX09XjopYYNXTRE3I=;
 b=GGyMgUkNT2TLB9MrEmTBSR/MoMEdHAb3a7JT/1p/aVSQyyYIkUUShL6wHMMw5EblYewQF4Ghpv7qLTXDAM6hRR8G2hsZk2pmGVG59atkLRuiKCjoFwHxser46TC58ltE9OMVIKD1agnKM7j8NgnK9/NjnfgGNbRApeIFvXGxk/6z5c/GwV0/JCWERwPONNiLHEkMMOzoeoDgBOwEBrUtokRDwUZjGLkFMZWelXddt4PH/M4rEPpHR67hZ7igzR7nNn5gEk+vTYImqWzARsAC7lR3iL0RgLcZhmHkx4FfAVp0pfyMrmEASEsHFr/gz09IEBdfh7HswJ6ChTKexfD32Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 12:15:05 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8445.013; Wed, 19 Feb 2025
 12:15:05 +0000
Message-ID: <679dd1fb-a68b-43b7-b721-bbb6dce2d06b@intel.com>
Date: Wed, 19 Feb 2025 20:20:27 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] iommu: Retire group->domain
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <joro@8bytes.org>, <kevin.tian@intel.com>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <robin.murphy@arm.com>, <nicolinc@nvidia.com>,
	<will@kernel.org>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-6-yi.l.liu@intel.com>
 <20250218195756.GG4183890@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250218195756.GG4183890@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0213.apcprd04.prod.outlook.com
 (2603:1096:4:187::11) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY5PR11MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: ac1c0b96-b827-47a6-bdb5-08dd50df0ae9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?d0p5ZEdrbWNSam04UTVZT2VIdUY1Z2VaWGU5a2hGYUt2TU9hMW1LcDQwYi85?=
 =?utf-8?B?UHZyWFJDTXpLTTJlaEJjaUtGclNFeHFWSkJxV004bzVwcWorWFNJQ21YL2tR?=
 =?utf-8?B?WG52aFduMFZKVFFrSUJBeUdrK0FqdEtsQk5wRDhQdFhJbnFqRG1mYWowVGFT?=
 =?utf-8?B?RkhUVUp6U3RTM0RrY0ViV3JETjlybHpGLzRKdXM2U0xoaWFsUWtDOTRCOHBB?=
 =?utf-8?B?cGZqTlBnUG9rRGNZYzlsL092alNSL0RxcVkxVU9hb0dKL2xhYzdZU0NBV0Vi?=
 =?utf-8?B?aXUzd1F2clA5aXFqZ2FNd1JZU1V6Z3BvbmcvS2tTeVVmQ0h6eWd2Y3pyT0VF?=
 =?utf-8?B?dTB4RjFtNEg0TzgzVy9ya0xFQXh4V0NNbUxadkFSRlR0Qy9jZXhtWmxrNzZ1?=
 =?utf-8?B?ZzRWRy9LdEFaeitHWHV5SExJcnIrNXFuajRkaDd4OVBRRitYMDhGSHQxYk4z?=
 =?utf-8?B?Vm1vTG1tNnZiRU5mYzUwd0NOOVRkZVNYMnhvQmExYmUvb1N3RmxnR0RTS29N?=
 =?utf-8?B?N1o0S0g1VkZDV1JkbnBaQm5BR1RYOU01NEEveTBMNHcxOGEzNmJEWnQxY1Zq?=
 =?utf-8?B?UGYwTDZ1d0JCQ1FkaUhFUlB2dGpBbmVRWms5UVdkRnk3aGpyNlN3L2srVXFX?=
 =?utf-8?B?cnpINEp3UmFrbFJmMlZkdDhiVCtJak9oeTdNLzdVOTlYeUFsdkJ0YmdzNXc2?=
 =?utf-8?B?TFNvdUFoV0lWc0xaMWl4YUlxOUw4NkhtSmZhQlBCNUJaeVRNa0xNZWxCVTEv?=
 =?utf-8?B?YVErQ2NBM1BYTWdVbnJ5WWFCcGowQ1BUbzJrSUtCUVh0RE51ZkhIUzRkTE9m?=
 =?utf-8?B?QlBVeTRxUjgwdktGRElZc1g4Y0VlWkVERVhTa3pHd1JYeGwyK2FDQ2ErVGti?=
 =?utf-8?B?NTJnbmtTVHZtMDNPRUJzZnA5bzhJTkhCclZINkQrOVVEZmdLS241MHFscFVF?=
 =?utf-8?B?YU9lSTl1RGZ4eHluTkJSanN6OWJ3cnhYTFMwNGZoWmtEMGZDajd6SmNZZWtD?=
 =?utf-8?B?Mm5OR1FCUlRFRzVuOUNlbEtCbDQ5bWNaM2xkM1FpYTRQcGNzVURVYUtOUzJh?=
 =?utf-8?B?SWtLa2xjUUx4ZXhuZ1VmUXNnZzhuQzVlUkhycE5aUkpzbDRIWCt3TGlZWnQv?=
 =?utf-8?B?TlB0WXJzcnAweDArSDJadDQ4UzQ4OFBIUGpsRUpNVzhGRFNoMlhYTUNWa25w?=
 =?utf-8?B?cWJ2eWpVQ1p4NkVqR095VUZCamM4dnhkWVNJZmFxWnNMQlhnNHFUaDZZSWJ1?=
 =?utf-8?B?c1RDWFVFZzc4K0RqNmQ0SUovVllOOEQ2SGpnWkQ3UUN2eUdwNVpjZDlXSEdK?=
 =?utf-8?B?SWRaVU5aRTdoRlZubzdiSTkwckI0bmFnMm1FNTFWTkxjQWNVTzJ1bDNOV25s?=
 =?utf-8?B?MVJjTTlWVURvTEZManBLTW0zNEhmN2hRVDhsYzBGMlN3SWNuUThldGpoNVpu?=
 =?utf-8?B?VGtsZEkwUmdVMjFqZDJnUGswVVNXckRXY2FFSU9Tc3d1R3c5U29GanNsSmtI?=
 =?utf-8?B?aENQYWtKU3lVWUtPbjI4dzh4TzBqTXYxTkt3WEhVSDZRUzN6WnVVZTdSSWVr?=
 =?utf-8?B?d0VBam9pQVJ2bFpFcmE2OVVudFQzL1NzZlBxOEdGT21McFBPblVnbVhIL0dq?=
 =?utf-8?B?Mkg1STVlQk5rTkM2ckR2WHhyN2hsZTNCWjlLa29Ha0FTY0ZaeWNOdUhBZlBD?=
 =?utf-8?B?bEM0ellyb29SSCtOYkR6WmZ6bTQ0N3pQLytTakpoRFoxaDUwNElYOXQzQ1pC?=
 =?utf-8?B?KzlSeTJWOFh5dk45eG01dk01dHQ2VlFhTVRmU2ZySHBLaHd6cGlBN1R2YUdz?=
 =?utf-8?B?cVNDUTY0ZTN0TG4yYUVuTldWbFluSVQ3Vm9JWXpkTSt6SE1aOTd1VWIxRGxj?=
 =?utf-8?Q?2NiWcbpJ/vhaM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1pPbTYzcVJEQkVxOGljRnEyN3dsZThUSUhQT0lXbmZFSGJkdFpZbThmSHk0?=
 =?utf-8?B?VTlkcTN5VlNuSFlMSW5xNDBiT1FnbHZBSFltVTNsdkJydWROcVlSVE5aQmwr?=
 =?utf-8?B?L1V4aGhXSmZNSngrNnJlbmxNSWR4N2NSLzA2d2Y0L1VKK29XWEN1NG1JOElY?=
 =?utf-8?B?MzBpQzdZeDJzNWhEcld5dXJuTHQ0eVFWc2FRSDMzTGszVDFtY3M2aS9LaFJn?=
 =?utf-8?B?NjZXa1ZkalVITm12V2w2Ukl1aS9CYVNnaW5PdG9ybTc3bGN6ZlczRlNjeG5j?=
 =?utf-8?B?Qi9JT0FQU2ZRZHpsdGdjZEh4RXIzcWdmMUNZdTlwUmV2YWp2OTVyalBkS25j?=
 =?utf-8?B?Y2RCaXg3K3kvMXJvVzdYbld1YnFXcFhXL3lJcENWa0s0MUxDczhYb0ZnV0JY?=
 =?utf-8?B?cDdkZGJaU3JjbDNtRzUxMzhrbmdJSGQvdXVodFZ3VlRYSElobmE0aGtmSDMx?=
 =?utf-8?B?WVl3dDM4UGZiTWtwbHBBRThPam40YUFSZWNqYmlGZUduci9FemtLT3IweG5D?=
 =?utf-8?B?dVlQOHluM0NLaEtybUNtNG1zciswMzd3OWpocElLRGc3U2htUnhXODhKUGt5?=
 =?utf-8?B?VTBYMUZDSzFJOGRVdUVHUzRueDZ0eUk1MGpSL2tKTDJPbTlwUkdoZUZrQXBI?=
 =?utf-8?B?VGxweFp3dEhSSk1zSWxsY0FtNXFKOXI0aE5VcTBad1N6SVBycEJac3dKbmJo?=
 =?utf-8?B?VXJiNEhWMGZwaVNRK2t5STlpU1Y2RWJBRUtKaXFKaHBvZ3lRZVVKV2QzMUxU?=
 =?utf-8?B?VjJTeWhHNjFkQys2SDRFWVJKdy9PVXlhay8wbXl5TW93T2J0ZjNYMXRidmVL?=
 =?utf-8?B?dWFkZWVTc0x5QWhOaTJ0dGxhUkpYcVVOdFpTRHZ3L2EzdDdOOUExYVN5dmdk?=
 =?utf-8?B?L0JCSjczZFN5MjIzMTBGOWl2azVKWE01ZlR0WWxIRmlLWndSRmJuT21SdnIz?=
 =?utf-8?B?NUFHTzVxQU15S2Fhdkg1SHJrdkxNbmJEcFZsQ3FOWURFT2dWeUJXaENHQjdR?=
 =?utf-8?B?b3FvbUUrN2k2NnIwd1J5dVloc1p6SG9NTXZMVERWNUVuZHVwRG5SOW84UUhT?=
 =?utf-8?B?eUg1LzMvWjFSb0p1SEV4WXEwU2hYMnlRYWRNSUdzYTlKMlJaT1BDNER3V3BU?=
 =?utf-8?B?S1A3ckNOeFhjeEF6WXAzY2xxMy9uY0JnRmNhVWRjL0w3M2hsVlNwcjdxSXVI?=
 =?utf-8?B?dmc2aEhqY3dRaG5PN1p3MVlWODRhQWtuZEdVbjN0VDV3TDRtYTM0aHVPR3FU?=
 =?utf-8?B?NDVVcy8rcDBHaFByNFFZR3RzTUYzQUs2dnJyWU94ZWNTRzRWczE5WWN3cnBZ?=
 =?utf-8?B?SGdxRW1vZkFLSE94MjhBTHVYS0dWTkViWm8zUjRLQ0YyK2t4dkNObjB0a3VI?=
 =?utf-8?B?amQ0TDZFL1NTVksxaG40N0tpb2o0cmVoUHdrMllGa1ZqY0pFdEtPU3MxaVU2?=
 =?utf-8?B?djZkK205eXMvYUQvZjkxVVhVeXVXa3Y4WCt6cWFXRjlyZDgyaWFqc2VBRVNz?=
 =?utf-8?B?S1dET3gvUmpVUFlCU2RnRGVEVjkzd0xvUWpsWTlEUURmUDZrbGhXeEZlUVVW?=
 =?utf-8?B?ckpBOHVnQ3E1ZTByUDB0QmpGbmxaQWNoeXVxcmxDT0lydUFRKzl0UFk2cEdK?=
 =?utf-8?B?emxEazBxeHRhamVlK2p4RFJlb1RYcDRjWHBUaWdhbkJab2FSVjR3QjVMaE9U?=
 =?utf-8?B?R29OWmFzR1lyVmQvd1hyOE41NEVnWHorazNTbmx1M0xkWFd1Z1JjT0JaSkRZ?=
 =?utf-8?B?d0ZVTzFMbW5yM0ljMHRnUGVvclArL3J6Q0xzOWJGVmluanN2c0cza1pZWjV0?=
 =?utf-8?B?Zk00djR4TFNMWU9lT3c3ZHdWNWd3WGRGM0RhMFE1bzJLaFkzVDRnTDBQM1d3?=
 =?utf-8?B?UnF3ZXBGUXZZallkUzlqdXdRUVNpbDB5Vmx5US9sMWlnOE9PSTQyRWdORnVH?=
 =?utf-8?B?aEVhZkcxQ0lBam9oWWxrb2FGV212aWhRRExmNURhNitrVFlYVTRoVkQ3SDN1?=
 =?utf-8?B?RnJuZFhrWUhIUUF4UzY3dHA4Rk96bEJFajlhRXo1T1d5cGN4OGlXR1FaTW5S?=
 =?utf-8?B?NEIrK2VpanpURTBBYkxVcnRIZS9MZzhuK3ZMR2tSeVBMamJCeDBQa3Z5bVFG?=
 =?utf-8?Q?QfOfiVxjwon9igX1BbIEHnJOW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac1c0b96-b827-47a6-bdb5-08dd50df0ae9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 12:15:04.9382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6FM3PvzG1OCDmA+dprkdAJra9EQMZIVBLDfXPnQx6WEUUrWQNxFHpvCAGJzxGIiNrTVsQLjPHocb2QLEnCRrVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6139
X-OriginatorOrg: intel.com

On 2025/2/19 03:57, Jason Gunthorpe wrote:
> On Tue, Feb 11, 2025 at 10:05:40PM -0800, Yi Liu wrote:
>>   static int __iommu_attach_device(struct iommu_domain *domain,
>>   				 struct device *dev);
>>   static int __iommu_attach_group(struct iommu_domain *domain,
>> -				struct iommu_group *group);
>> +				struct iommu_group *group,
>> +				struct iommu_attach_handle *handle);
> 
> I think I would split this particular transformation and it's related
> into its own patch, it would shrink this alot. It is principally about
> sharing the handle and non-handle paths..

got it.

> 
>> @@ -563,11 +591,12 @@ static int __iommu_probe_device(struct device *dev, struct list_head *group_list
>>   	 * iommu_setup_default_domain()
>>   	 */
>>   	list_add_tail(&gdev->list, &group->devices);
>> -	WARN_ON(group->default_domain && !group->domain);
>> +	gdomain = iommu_group_domain(group);
>> +	WARN_ON(group->default_domain && !gdomain);
>>   	if (group->default_domain)
>>   		iommu_create_device_direct_mappings(group->default_domain, dev);
>> -	if (group->domain) {
>> -		ret = __iommu_device_set_domain(group, dev, group->domain, 0);
>> +	if (gdomain) {
>> +		ret = __iommu_device_set_domain(group, dev, gdomain, 0);
>>   		if (ret)
>>   			goto err_remove_gdev;
>>   	} else if (!group->default_domain && !group_list) {
>> @@ -625,6 +654,8 @@ static void __iommu_group_free_device(struct iommu_group *group,
>>   {
>>   	struct device *dev = grp_dev->dev;
>>   
>> +	lockdep_assert_held(&group->mutex);
>> +
>>   	sysfs_remove_link(group->devices_kobj, grp_dev->name);
>>   	sysfs_remove_link(&dev->kobj, "iommu_group");
>>   
>> @@ -637,7 +668,7 @@ static void __iommu_group_free_device(struct iommu_group *group,
>>   	 */
>>   	if (list_empty(&group->devices))
>>   		WARN_ON(group->owner_cnt ||
>> -			group->domain != group->default_domain);
>> +			iommu_group_domain(group) != group->default_domain);
> 
> You could also probably put the conversion of locked group->domain
> into iommu_group_domain() into its own patch (though not using the
> xarray to start), that conversion looks like 9 hunks.

got it.

>> +static void *iommu_make_pasid_entry(struct iommu_domain *domain,
>> +				    struct iommu_attach_handle *handle);
> 
> Should move the helper to the top of the file in the patch that
> introduces it
> 
>>   static int __iommu_group_set_domain_internal(struct iommu_group *group,
>>   					     struct iommu_domain *new_domain,
>> +					     struct iommu_attach_handle *handle,
>>   					     unsigned int flags)
>>   {
>>   	struct group_device *last_gdev;
>> +	struct iommu_domain *gdomain;
>>   	struct group_device *gdev;
>> +	void *pasid_entry;
>>   	int result;
>>   	int ret;
>>   
>>   	lockdep_assert_held(&group->mutex);
>>   
>> -	if (group->domain == new_domain)
>> +	gdomain = iommu_group_domain(group);
>> +	if (gdomain == new_domain)
>>   		return 0;
> 
> This is not quite right anymore, we could replace a domain with a
> handle or viceversa.

I see. yeah, even domain is the same, it may be on a replace_handle path
which needs to update the pasid_entry for sure.

> 
> Probably like this:
> 
> 	if (WARN_ON(!new_domain))
> 		return -EINVAL;
> 
> 	pasid_entry = iommu_make_pasid_entry(new_domain, handle);
> 	curr = xa_cmpxchg(&group->pasid_array, IOMMU_NO_PASID, NULL,
> 			  XA_ZERO_ENTRY, GFP_KERNEL);
> 	if (xa_is_err(curr))
> 		return xa_err(curr);
> 	if (curr == pasid_entry)
> 		return 0;
> 	gdomain = decode_pasid_entry(curr);
> 
>> @@ -2290,7 +2343,10 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
>>   			goto err_revert;
>>   		}
>>   	}
>> -	group->domain = new_domain;
>> +
>> +	pasid_entry = iommu_make_pasid_entry(new_domain, handle);
>> +	WARN_ON(xa_is_err(xa_store(&group->pasid_array,
>> +				   IOMMU_NO_PASID, pasid_entry, GFP_KERNEL)));
> 
> Ah, this flow uses the same as I suggested a few messages ago already!

yeah, I used xa_reserve() though.

>> @@ -2302,16 +2358,17 @@ static int __iommu_group_set_domain_internal(struct iommu_group *group,
>>   	for_each_group_device(group, gdev) {
>>   		/*
>>   		 * A NULL domain can happen only for first probe, in which case
>> -		 * we leave group->domain as NULL and let release clean
>> +		 * we leave domain in pasid_array as NULL and let release clean
>>   		 * everything up.
>>   		 */
>> -		if (group->domain)
>> +		if (gdomain)
>>   			WARN_ON(__iommu_device_set_domain(
>> -				group, gdev->dev, group->domain,
>> +				group, gdev->dev, gdomain,
>>   				IOMMU_SET_DOMAIN_MUST_SUCCEED));
>>   		if (gdev == last_gdev)
>>   			break;
>>   	}
>> +	xa_release(&group->pasid_array, IOMMU_NO_PASID);
> 
> This does not seem right, the prior flow left group->domain unchanged
> here. IMHO just drop it, the xarray is always populated and almost
> never has NULL.

yes.

-- 
Regards,
Yi Liu
