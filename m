Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD042905
	for <iommu@lists.linux.dev>; Mon, 31 Mar 2025 02:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743387574; cv=fail; b=ujj+3KpgoaVaxN2i9CNKlMVNTO2GNRll/ePzORYHDxAZBGJkBFZYZs9rVkvYtDOG9Cmqeo5Ii1O4UvKSL6+rILZZkhGVQigiKPkWDl5/h03chbI276h8J6NdaCJ4m4TmBkI8D51tGPF9UnlX+RYETNJF8hDE8VYPHHjRIu24vTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743387574; c=relaxed/simple;
	bh=U+LeONG1K8GYjHuRdHWGRj7ffmX1Pu7i6/d+fIAdN34=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cuAVgMq8tAFRYPHm1HMRo4/PpQyp0SBI7VF997J2GvWM3DLAjcquClPjbzaLY9AuShClpCBvPY2YthZtV6RqYNLiKpxOo5gd7yHk4lbL439Z2ZDtKTa/+B3NAUdlSjPnLVWkRtB0eI9a6icIbHX+N9ve7FIPZqblawCAjubjpfk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=An/D/8PP; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="An/D/8PP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743387573; x=1774923573;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U+LeONG1K8GYjHuRdHWGRj7ffmX1Pu7i6/d+fIAdN34=;
  b=An/D/8PPv1TU/tQASS0ZXF6ZNK6BcSfWYa4zOB/vVSASlD7b8CeC9bLE
   vycTx0kE6UcmLUQh5LHSOGHRJ2LYcHh31aAzSrBFeaUiQm34tl8VTjz2u
   F2ZVyZTs1gi/yxFZtmZVAedVhTnaF1rYSJQa2Za/xEWE87wEaRO4uQRdh
   ak/EwRblpX1vwhR8XQsiVJYrU2qRu35ZJAHDS8bqAdwUS+0F/siVUF+Ep
   CSlNOpW0TXh72pREOjXXbBgP651VqYbmKpcjU1a24fbZf2j2vami/eznh
   3lZ/M7oeH+Pw4V3QpufSn/KqiASr0RLWEUPpJ+cIHkKiaF9mnY6SNo7QS
   w==;
X-CSE-ConnectionGUID: PpnLOOp0RY2ote6SHMHCoA==
X-CSE-MsgGUID: rHIMWKV1QVCDvR4e5RceKA==
X-IronPort-AV: E=McAfee;i="6700,10204,11389"; a="44828404"
X-IronPort-AV: E=Sophos;i="6.14,289,1736841600"; 
   d="scan'208";a="44828404"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 19:19:32 -0700
X-CSE-ConnectionGUID: mk30ZCj4QYy68bLaigHu/Q==
X-CSE-MsgGUID: ube/cPZ2QySCfgEF05ewNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,289,1736841600"; 
   d="scan'208";a="126481847"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2025 19:19:31 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 30 Mar 2025 19:19:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Sun, 30 Mar 2025 19:19:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 30 Mar 2025 19:19:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xbh4wyXHYj561cpqlPqX2aAEfD1dKwu5vla3sdvsYi08QPH5yEtbMCOew3q05aytmfWQSQTfVn71T9cLv2G+GEwO01icnhvuulTCyKVpqYLxrH7afh0knYWg0FjPGxzcZ4YSnzp0iBaLDOTD9K4HPnj/sJu4N4+6wyi6yQ2CgvTt4GALWgzKN946ojr/LnIDrihBxd8bWb1gookFqtDdIw1mPC9zu9FjCciEQMs4A+ZmvNGcjXbdeJya1acQZuHK5D6/ju2EqScS++qvA2DiMiKQXOAgG8NVgvUo8zET7WHNDkpBl185U7f2NPGyetbZx2oA4ZgG6BPmzHZRfaPtig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYkyy0SHK2JezDGQhLbWZTI436802M0lgZFJcuPVwNI=;
 b=rZP/4gDDpUPuKW/XK2VFA1/W5eOqJwUQNA+7xYpW3FcHKkgSMKnXUJLI+R16uMxfDrZSJ/RhtumOjf+b09MFtSqBlgVUoxCc910/x64Sq+PJLs7g65B0wuKkCPAAy7pAfxnTZQSK3OtLD89518hoyS1SpFVBE1VuQWuuksFt5EODypQfP2Rx8uBKe0UzG6dcRz/2sDHmAJEa/wAJb1cN1Vy3LSFbJlndgPkrIm/BAiN10KHXEb0mNMs3vhoHnJMeHvUjihrFhWN4kRpIBtapgsHZhDmi3cQDgBFfZrnjAkPgYOjyXDa0QUGqJob4+1JRordhEohXi05k8Gsj6o6mEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH8PR11MB6561.namprd11.prod.outlook.com (2603:10b6:510:1c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 02:19:27 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.048; Mon, 31 Mar 2025
 02:19:27 +0000
Message-ID: <c9fac54b-5974-46e9-8f94-b14fa354fdee@intel.com>
Date: Mon, 31 Mar 2025 10:24:56 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: Test attach before detaching pasid
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <nicolinc@nvidia.com>, Lai Yi
	<yi1.lai@linux.intel.com>
References: <20250328133448.22052-1-yi.l.liu@intel.com>
 <20250328144035.GB10839@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250328144035.GB10839@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR01CA0152.apcprd01.prod.exchangelabs.com
 (2603:1096:820:149::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH8PR11MB6561:EE_
X-MS-Office365-Filtering-Correlation-Id: 26abf087-011a-46ac-f933-08dd6ffa764e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TmwrKzNxc1p6L1JwMm1rZjI3bklIdVdJL1c2cjJ1VWhweGVzQXlEVWNuMEdC?=
 =?utf-8?B?V05YMHFSR243RXVLUytYenp0VlFBRHdqdUYrNFBOUjFlYjc2a2JZTkZXcVZl?=
 =?utf-8?B?T2VacGZ2NWVxODhKdTBpL0MyKzNkMXh1Vm1PeGljK0lRQ0FIR1R2Ky84QUwv?=
 =?utf-8?B?OXJERUFMVkVhWldpOSthV2NuTng3aitjekdtbUkxOE5tMUxDMkRTRGVGQ1Z1?=
 =?utf-8?B?Nk8zWG1rOVp1V1I0YXlON3hiTWZlQ1dHZ2xteXFTbUluUnNOQUlYKzNOaDdp?=
 =?utf-8?B?MkFOS1dKd2cxTnBzWnNlZW9uNjlTN2hhaUI4dHN5SG05SkRPQlAwZHlGUHJy?=
 =?utf-8?B?QjlEZG40Mk9abEp1Yjg2L0QrMWU2MVNGQU43bW5ETzh3ZFhYVHhuTWo1NHQy?=
 =?utf-8?B?aVk2YXBZSEpPVHdPL0lMRUM5bWxQVitONXNCbWxnWUFZWCtpQXUxbnRqVnk4?=
 =?utf-8?B?bmFEUGdVV1V1VjE2cENKVnVLckVLaUQyV2d1ODNrYk9HZHRQYnU5SUdWMHFt?=
 =?utf-8?B?Sm5Uamk4VVJxdUNJSzVUWlFwYW4vNW1NYVcvK1VKa1lwdzFobEFnMGtJZWta?=
 =?utf-8?B?SmtqaUZ3dmlrVHMrbkRHMTlya2oxczhQL3RaZmlhUVVDWmFJcVE2LzBZd2kx?=
 =?utf-8?B?K2lNYjM5VWphc0tRVlh3RXloVGoxbTZObkpJT0NoRmVzbVIwYzA5MGppTDZB?=
 =?utf-8?B?Rjg1YTV3Vjd4bzlmWGJhNExCU1R0STczK2tzV3U5TDRyOWlobUFPRjNaYzRz?=
 =?utf-8?B?eldIWGc2Q296bWE5NkNINEJ0UEpTeWhZbDZZTWs1K1lQU1h5bGNXa2xZaUVB?=
 =?utf-8?B?cXBzYmR4dk1BTXR6aGpOcVBhblhUcnFwZmViUklwMXgyellJY0ZVcytOMVRY?=
 =?utf-8?B?TzltTjVHR1kwR1R6bFhTL1hyZnZlRWNJUUt1N3dzTGp6MmM2SmZRbjcvV25i?=
 =?utf-8?B?WWJZSkx0dG9yZTJTYk1qN1J6RnpUNENNeFpSZDFVdXh3bE9BdFpaelBJeUdp?=
 =?utf-8?B?dUtyZ3ZRemNvaEdpOHhWV291ek9oK2JZQy9UWTBmTXc4ZlJYbDBNNDhTSUg2?=
 =?utf-8?B?UG9FZVVod0Z1UlFoRG1GK2J1TmNKMm1PMW5jazNrQ3FWNXYwekFHQk9wMFZ2?=
 =?utf-8?B?ZW1EbkhLODl3SmJDZk4xd0Fsd1hNemFWVGl3enVZbDN3UnNhTEM5MU45TFZP?=
 =?utf-8?B?L3JxVjF5c2RpZUs1VUNKaFcxQ01XVFBlTUVkNlFlWkNuRyt1VTg3Sjh1dWVH?=
 =?utf-8?B?bzNYeE9QcmYzL3gwbFhoOURRbjQ0WFRLNFUvbkF1TC9rcVcxQlp5d1pCbHBl?=
 =?utf-8?B?Y1pjTWdIN29XQy9RaEJTeE9LT0t0elkrUVFKbHRyZ1loZklNWTZUQTZzeVdL?=
 =?utf-8?B?d0R4UW96Y1d6ZEwzQXFLT2xTemhubUp5aUlRRkhjRzduRklPbUlMWi9YREh2?=
 =?utf-8?B?Q1NxMVRtQ2s2Yk9mb2VhMThZV2oreTN0b3VOYU1xS2g1ZXdXWVk2Y0o2VnhY?=
 =?utf-8?B?MXRsNDZEZmJBQnhOMkFmcmMvaTh4VmhLTklucDl2dW9WcW9lck1KVmVKcmRj?=
 =?utf-8?B?UUdMcWdBZjFMZ1JsckJKaHdaM0ZTOGtmRjhhQStUVFZZakxEZ0lRMkp6M0hX?=
 =?utf-8?B?QUx3N2RWZHJ4NGRmV0h0eHoxMWNuNVRDbEZKT3N1UkhFRHVucHhCd3hIZlBY?=
 =?utf-8?B?b1Y0WHJyUXpzUG9pekVTaWI2OHlCMmJuTFFleDZ5L1NMdWJOT1RyRFV5aDFJ?=
 =?utf-8?B?RFRPajlDeWZOMmp4S01ONHU1dXJpclN4ZDZ5Mmo0bEJiV2NzelJ3M2F2eCtp?=
 =?utf-8?B?YmRaVURLTnk4eHlmMWpzZlFPMUdGbUFKcTdtOUwydXUweVpRMkd2enltRHkz?=
 =?utf-8?Q?NiKIjezfgwtHl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEFnTU9iaWhhZEFiNnZyamdBUlIwd3Rhei9ueTAvY0pYWFRQTlFMZEVScXd0?=
 =?utf-8?B?MnVTZHZRdWVmcGJFRTkza0wvRzBmNlVIdFcyWFdWZUNvcDNWOEJUb3lwQWh1?=
 =?utf-8?B?c1k4SlM4d2NrWjRHTi9KSmlMbzErWFg3SW93NUFjVGwyOHoyalNvWEVyR3dh?=
 =?utf-8?B?RzFCMDI1Q2RVeHFpSklLekJsSC9IdUFWZVJBbXFFcEJNL0libUkya2VmVWY4?=
 =?utf-8?B?eXhObjNzMDE0L3NET0ppaGRFcVVoUU40d1daUklHaGhMVXdORFRwd0VGbUVO?=
 =?utf-8?B?T1hVUXFvNzA1SnY3bkJWTDNZVEM2dnl6YnRvcTcrNnM2cFJhcGdsRVB3dVNR?=
 =?utf-8?B?QkorR3JqY3BoUGZzVDlvWXBoeDFBeWEzSVhJeldVclh4bFVBTE5LZ1ozdFUw?=
 =?utf-8?B?eEoveExES0ZpdkZhY081eFA5am1NRlRQejZkRUJOMXRhUjBEb090V3ZUalNF?=
 =?utf-8?B?U1czNjhjTFlyanovY1k2Y1ZibmIwU3NMM2RMSWZVcG9KNkdNcE1pRXg4SHFM?=
 =?utf-8?B?UDlLeC9YWDV6RUlmUXdONi91aHVPanpGakluY3FkbW1NQ2ttby9YNkptSENC?=
 =?utf-8?B?OVZiVStQZHpldFlPV0Z4dXMwYWpObkFxVDBtd0JQeUtzNWpTcVo2cjdRYis3?=
 =?utf-8?B?eTBHYjg2QUMxbWd6bmxuUGtKdzg5VG9HUlhZS0JXUHhsaVZ1NUFhOUpEamtM?=
 =?utf-8?B?aUpjOHJKNXhndGNlU082NXNJUE1PY2VVRC9SUTA1QWNkZFluQ0lSK1RFYXJW?=
 =?utf-8?B?VGMvWDFyWG1iV3IweGk1L0trT0RubVJpNjZlb25NdGJ2N01PTnJiUHR2U1Nt?=
 =?utf-8?B?Z09JeXptYy9hVUZoYmhxOW5kR0RUQUtiazRpQVp4MnJCOUU4Ykh5L0w3RkRv?=
 =?utf-8?B?cGI3SGgya3YwZXl6d1VvUmJFYXpqcWEwWHVtZlB6c0tsNnArdXJBaGZJanhG?=
 =?utf-8?B?aWR5SlNDRUVMQU5LeDV0RmpoUjJXaWs2bitiRFhXRUUvdVN5Q2NaOG1JZGMv?=
 =?utf-8?B?V0FoMmx6QUVTS1RQbVF3dzdtTE9IVGhTTWFkMzRvUTB4bzYxNGNRZ1VKd29M?=
 =?utf-8?B?QXhCV3g4OVVTTy9tSmg5RkVpZ2NqUFlhRmNFQzM2Sk9OTnJrbmRrYVFHSUxr?=
 =?utf-8?B?MUVrejNubjZvVjQ1dzBKa3lCejAxU29iS0xnNlF3QW96VnhMQ2N6ZXBsbmRR?=
 =?utf-8?B?UlArVGlpdG1hRHdPczF5M1RNWDg2SmlKUjNaeWNMRkJjeExZMUhPNndXeXkr?=
 =?utf-8?B?MGNvblBUNlZSN2lwbzBJL3lBVWxsTTJBSFNhcVpoYWxONXhvMC9mNXJnTi9i?=
 =?utf-8?B?ckc0V2xhYjd6RXR5djlDcFkyMGFld2lkMTd6cVFYeUxyVWxjMUJEWTRBRHRu?=
 =?utf-8?B?TW5WNUp1RlYxZUpsOStIdk5xVnVCc1VIYnRyOGJPV09qaHlwaUVyWVpQNmJJ?=
 =?utf-8?B?WHBCbjJmV2VsdWltRUFMeGxVdXFaQkZTTHZ2bHFrNkRSdWdWUDJVWlFJS2Y5?=
 =?utf-8?B?c0kzT3F1QTh5cmVtWWdaVnFDaFVhNnB2RWZsTUhrMEU1eXQyS1BXeDJZRTQ5?=
 =?utf-8?B?blJyQ1h6Qm9RS1k1YVlLYjBoQ1A2Nmo5WjErNnB5eUNxenROZkYvZktKOWd5?=
 =?utf-8?B?TnducXBoaFBRNHVobXdxMWtWcFlpQTNaNzY0QmNHNjNCSWRzRmQyZzVLMTkw?=
 =?utf-8?B?SHBGcHA1WDNKZUtzdHZpbnYyQ0p0MGp1VXROdU15czJLNTBYV0RHRnQzRU9M?=
 =?utf-8?B?V1hBd2UxVGFtdmRZbDNRdFEwTSt4NlpNdS9ocTRFRW1QQU9hcVNnK01iSzJy?=
 =?utf-8?B?MlpGK1B1K0R6VVpiNEE3RU5YMUNWNkF4a3FiMmY5bjV1bkU1anZkSUFtLy9P?=
 =?utf-8?B?dHV4NGZiVzVTK20zWE96ckc4ZUlXOTlBSGFFa1AxNHhqYVVCOWh6N1FmaXRj?=
 =?utf-8?B?M1gybkZUMndzbWRwUExWL1lGNEliRjJISDg0WkNlWTBNOWhMWktERzd5UkpH?=
 =?utf-8?B?a2JjUnc0UzdnRmVSWlpobGJGd1Y5eEFKY3BzVUpIM3Z4VmkrdDhmT0dSV1Rv?=
 =?utf-8?B?UmpvVWJwelNJMFBqQUx4bEJ6V0I3OFp1dUFWR0puYXdsSDc4eFE4T3V5STRV?=
 =?utf-8?Q?SrKNqkBJDz6w4iP9mE6znPi1u?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 26abf087-011a-46ac-f933-08dd6ffa764e
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 02:19:27.7102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9y79GP5JxkStRcmRCXpwTi2VPiVVYoBNOnOJEmN4kfxlYry064/bSJPckXnovW+qdSCTZgC5BakIOAENsUrkdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6561
X-OriginatorOrg: intel.com

On 2025/3/28 22:40, Jason Gunthorpe wrote:
> On Fri, Mar 28, 2025 at 06:34:48AM -0700, Yi Liu wrote:
>> Check if the pasid has been attached before going further in the detach
>> path. This makes this path more robust. Add a selftest as well.
>>
>> Reported-by: Lai Yi <yi1.lai@linux.intel.com>
>> Closes: https://lore.kernel.org/linux-iommu/Z+X0tzxhiaupJT7b@ly-workstation/#t
>> Fixes: c0e301b2978d ("iommufd/device: Add pasid_attach array to track per-PASID attach")
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>>   drivers/iommu/iommufd/device.c          | 7 +++++++
>>   tools/testing/selftests/iommu/iommufd.c | 6 ++++++
>>   2 files changed, 13 insertions(+)
>>
>> diff --git a/drivers/iommu/iommufd/device.c b/drivers/iommu/iommufd/device.c
>> index 2307daad65c0..375dd262f431 100644
>> --- a/drivers/iommu/iommufd/device.c
>> +++ b/drivers/iommu/iommufd/device.c
>> @@ -644,6 +644,11 @@ iommufd_hw_pagetable_detach(struct iommufd_device *idev, ioasid_t pasid)
>>   
>>   	mutex_lock(&igroup->lock);
>>   	attach = xa_load(&igroup->pasid_attach, pasid);
>> +	if (WARN_ON(!attach)) {
>> +		mutex_unlock(&igroup->lock);
>> +		return NULL;
>> +	}
> 
> We can't trigger a WARN_ON during the test suite!
> 
> #  RUN           iommufd_device_pasid.no_pasid.pasid_attach ...
> [   23.723948] iommufd_mock iommufd_mock0: Adding to iommu group 0
> [   23.724532] iommufd_mock iommufd_mock1: Adding to iommu group 1
> [   23.724722] ------------[ cut here ]------------
> [   23.725194] WARNING: CPU: 5 PID: 1169 at drivers/iommu/iommufd/device.c:647 iommufd_hw_pagetable_detach+0x1e7/0x230 [iommufd]
> [   23.725350] Modules linked in: iommufd
> [   23.725406] CPU: 5 UID: 0 PID: 1169 Comm: iommufd Not tainted 6.14.0-rc2+ #1
> 
> Just drop the WARN_ON check right?
> 
> I took it like that, please let me know

looks good to me. thanks.

-- 
Regards,
Yi Liu
