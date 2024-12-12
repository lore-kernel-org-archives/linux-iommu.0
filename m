Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEBD20ADD2
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 07:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733988166; cv=fail; b=W8Vu5kLicq0xLACeiW1xy7wQf480PNFktgU1ruKygNfXI2EWRtl8/Vy6DsNU8R8fBApvQ5PXqEF1PGl5nNJDMJ58oMcebgZsMEbFBBGcNqDt3HrKckDwJtpFOELzOBrAH5q9rBeb7RbuauKzp2v/tXI3gI6nJ1skHurRTzU4GoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733988166; c=relaxed/simple;
	bh=UT8pITxdvxq2gEdxC2wpg6XsI1YRF0zWrAif1y4sIy4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rHFPJ5tkk9BYqPuqAtGm24vcYFsIbgrSA5Ul6KiMfSv7ttwcEThfb8R3K7fG9YBJMKFOCumJ0brgyiBTeKhXzokhwqXiDY8SPHUVlTcBsZPkqB4t+Mp+S8mPtzKuC+cUk9wRZWg59neVYS7XOlw+rrXT8nj4CzQ45W8MxG0LFeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OtJfhDXj; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OtJfhDXj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733988165; x=1765524165;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UT8pITxdvxq2gEdxC2wpg6XsI1YRF0zWrAif1y4sIy4=;
  b=OtJfhDXjlaalwRuwhIyLYPTzCt1dxZvPgFrhuUEcQ4V0J6pY6RWj01+6
   U6yCPfksLcL6w/mYWsqMs9lTNhurd8SPy7EyjCVcHMFNfUp500zVSGqT5
   P5JZMWTXzBjOe/O5p+StAj9tlk7CWn57ZcR8wq0Iu/zNc1qObxTMeow7D
   ccQSCOfYv5OP5g+a5aW2Rb0GkaxFofiQi1DzXfX2OxKqVxm64HAjYPxQz
   2UX1mqoSFmnRVBFp1aZjNGjp+gZt6arOKGCeTz521hcWhjxVLY6aUMKOx
   l1bHWAonJGRfGaKXDDEektMmOsFw7JnUfiHK2u9JmkPaX5tWDG2KfGS2r
   w==;
X-CSE-ConnectionGUID: YP8CBraNRcCqs7GWmiY9Bg==
X-CSE-MsgGUID: SIEr/kjGTzmbU4TtdBbagw==
X-IronPort-AV: E=McAfee;i="6700,10204,11283"; a="34312378"
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="34312378"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 23:22:44 -0800
X-CSE-ConnectionGUID: bGj4fdDZS6i4Zfhj6C12fw==
X-CSE-MsgGUID: HrloPTFZSx6Tk0nZHetEvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,227,1728975600"; 
   d="scan'208";a="95902188"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 23:22:44 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 11 Dec 2024 23:22:43 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 11 Dec 2024 23:22:43 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 23:22:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUdRNoBiHqw8C3ZTihBcHdItUoWAqXsBcgiIXer79KCU1N1ZUFR5jcimHUii/IIIGQUR4Utx+vP9qT84mDkSkePaZvznHvfLJ0o7NFsBd0XdsInM1m/4e0vgNMJKwKO/8lIY+ur+fiv2x0Bu+MEBACRF2xDHCfmpdZuWpoUfXdYaww09FIDAjlBRmg6FM3b0DVZoFohxEshUZ2CIMGEgVVzDEMZ6QXi5oOica60/YoOCJHonkhK+IPRjT41yzwT2eLXfZq1ly0vjBFcJa9MtADuvGG3projDEes76sdGRTvWwIsGfF8HvSxnSsmm+UDJJ3vkyqDoErivCLVVbuGlsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U1otqabS+zJJXKkIFN0balUbLLiKR1OewqUTw06hrd4=;
 b=ipETukB+LTqeBWIYGGVbXcQcOHYcd1ZMsx6gWjL+cf+m16uEWUkr07pZed3jGBO7nvtrX2JsuKR2gq5quHnMmDV9ZdCtK01IwjZhh2y14rtRshX0Mf4aAQft0QtIbQYRC7RVQ5uaGiPMMnkjlPLI/J8o7jAuI3bYHNkK+kyeOyYm8qfqz/yJMWwkIMVxm+5NA1+AvkkoHbLlgu3I6EefuoMHmamHGH9yn6bgi/gZryTjx12GNTOziez1nyGmDn5lL2EDxCkWCkIUIgijR3F79ZZnWqfB5c9t5K3PULBkButhZbJ367atdi9umaYdmQ8jQCApXd8lr90Pc8mCQ7h9fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS7PR11MB6200.namprd11.prod.outlook.com (2603:10b6:8:98::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 07:22:39 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 07:22:39 +0000
Message-ID: <c893e582-9526-4832-97fc-2487348bfa91@intel.com>
Date: Thu, 12 Dec 2024 15:27:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iommu/vt-d: Fix qi_batch NULL pointer with nested
 parent domain
To: "Tian, Kevin" <kevin.tian@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20241210130322.17175-1-yi.l.liu@intel.com>
 <BN9PR11MB527673D307E992D5D69CDDD18C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c031213d-a86c-4f7c-81f8-235116638291@intel.com>
 <BN9PR11MB5276F5B100BD155B371533238C3F2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB5276F5B100BD155B371533238C3F2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS7PR11MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 212a46fb-ec46-496d-9bc1-08dd1a7dc213
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?THBUSFdQSy9qN251R1pyUnJuMTFuYVYwZUhWTkd2ZlVhTjNIMFQ3NFVqUGJ2?=
 =?utf-8?B?NThScnREWjB2ZU9IZ2pudHRmOW9oSURrclR2bFM3OE5xRVpoc3N0dkpWNHl0?=
 =?utf-8?B?ZEZ5Q3JIOExtL2trcFdlVmdXOGhZZU52ZXFZSlJsY2E2R00yWGJFaDlEd1NY?=
 =?utf-8?B?ZXRJZUIxeW0wcndSZGd5TElsM1Mrc0MvTWFGUUVTM1RIck9RRE9vUjM5TmVC?=
 =?utf-8?B?bnVkYXcwVytUQWorZXFzWkVRK0VOdXBJRlpHN2g4bHlOL2tCNndUeUJjUlBv?=
 =?utf-8?B?Y2VYQnVnM1VHM3BjUWQ3SFpKMEN0VlNIeEM1ZE13a2ExNmgwdG02c0pkSUZM?=
 =?utf-8?B?ZDA0MlJTaHkza2t5UXZXY1lsWlllMCtxcVk4am9wbDdOV2NLOGxacHh2Z01J?=
 =?utf-8?B?VTdsY0lReGNUVWRsMDNhSVROY0FmM1hzZlZUeU9IZ3lFcWxGUUo5anUxSGw2?=
 =?utf-8?B?ZmhOQWF0aXdtUFJMWjhna1IxVDRIa2QyVWlrNm1rRWxPY1dDYUVyL0F2RUwr?=
 =?utf-8?B?bGRMeVI3OGNvYkJhUmNtVUJRTWpnVFU3Y1A5d1I0TW9LTnBZZjcwUGRWcUZE?=
 =?utf-8?B?U1E3TW1jUEZpTFcwaHRqdklTOFR3WUVUcjZhRDZmWExwZ3RJTHlnT1J5cXo1?=
 =?utf-8?B?b2FKN1hXbDZKMGdOdXY3T0RzdWtZLzhQUXNyL1BxQjVTeHNwSW1iTGE0UG1N?=
 =?utf-8?B?bDJDR244ek5LbkJBREVYaXFSczJvNktkTnQ0WVlyQlRzOHdKM3ZrSGNJT2tE?=
 =?utf-8?B?dEcvT2JGZ0l2dEJBOGk0MnI3dDN6OHZXdXRweUtqRVhvRDJxSzVvV1VwNWVX?=
 =?utf-8?B?L1FLbzhOaVdvR2VRankzWU9ZU1EycFFrSW9LSi9EdkxaZFhmd0JnZElDN0Vm?=
 =?utf-8?B?TlA3MWM5dHVQWUI2MSt4MmRqazg4R3llY1EwYzFmc3U3cjluZE9tV0NzRkdO?=
 =?utf-8?B?NnlZVEY1Y1BJWm9hRlhhVmhuc0ZhMjJuRjF5cEpha1BMZG9yTXg1Vm14TjMx?=
 =?utf-8?B?M1lqYzdVbVdZUnlvMVBtL0VmajFLenNaK3RKMjFQL0doMHJ1UFQ1cUdNQ0RK?=
 =?utf-8?B?K2xoY1RabjV3ZjkvazBTUHlYVHp4V0FoRzEvYzRoYSs5Qkp2ZTR1MS80bTJM?=
 =?utf-8?B?Vk0wMEQ5b2dsOHhwTitsYTlCNzhXcnVGVlBVZXIxUDF2U0Nwa3ByWktVQmR0?=
 =?utf-8?B?UUZRNEhtcHlZK09OQ0ZYVktld1YybnBHNkI2VnloclVXM3Izd01mOGN0ckFF?=
 =?utf-8?B?Mkt2ZlNqako0RWpUOVR0MGJNbEJsUm0rK0VaejdBNDAzS0dLbDlmMCtGVWd0?=
 =?utf-8?B?b1Jsc3JhcmxnS3lpM1JpOUlyK2ozdFFxMU9KQVNqSGgyQzB5UVM2b0plWDFL?=
 =?utf-8?B?cStYSFlZck9xbXBPTzlURWRKajk4T1pJdHQycnN6RzlqU3VZM3ZNZWd1c1pI?=
 =?utf-8?B?VkdjYitUQzFZQnFtZW9yZUFXZHNxWEtRU0xKNk1UQlJsYnJaVkFWR2sycEY2?=
 =?utf-8?B?bWlVekEwb0QzbGdqWGg0UkpHQ2tkSHp1SDhKVjRNKzhmejlmbmtoc29WWlFl?=
 =?utf-8?B?blgwdWRWdG5aZDdlNS92Y212bTlaYkx3TGZDU1BMM3dzR01uVGZJd0dmTGNG?=
 =?utf-8?B?U3lyTjJRQmVqYnRTd2xwbGlpMThzMGRSNksxYWxGY3JoOU82R29hVFc2OEtj?=
 =?utf-8?B?cit6NDZxL0tRb0hqVGMzeHBjOC9nVy9Nc0JTL1c2L2trT3kwUzZWZmZOSEV2?=
 =?utf-8?B?Z1pwYkNhNHowV2NXTllFUE1CcUFNb0lTdEZINXBETGR0WjZYVjVTTFVKdWhI?=
 =?utf-8?B?Y3Rmd2ZFNDhTS1l3U1NFZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzZSSjVOQnd6RzN5ckNJV1k2ZFh1WEZHcGV2RmV2UzdjdnJaK1NPR1VHS2o2?=
 =?utf-8?B?SEhmSjNXZk5kSC9rRi9xUVA1QkpZZGFGOGZoc3BQY1VBZVQ5NVR3MW1iNE1Y?=
 =?utf-8?B?aGxqcHA1b1NMNFVMVktTanVibW9NWXU5bytscDNVVE90YnNzRmI4azZWUTdo?=
 =?utf-8?B?aW9GamttcFNhUFFZSkplM2l5MkJGQlh0TTFVcnBuOXBldXNHdS93Q3Mybmdy?=
 =?utf-8?B?UW1oWWhFM0c4UXJHNjl2d3dkcjBDbE9zSXprNlphQVFKRTJDVTh4bncwNGEr?=
 =?utf-8?B?QWFFSmVzMEdUbVVTQ2lsL1k0TDFSNkVqUXE2V3VqRGMwSEQ0b2Vmam9rV2dt?=
 =?utf-8?B?OWwzbElSL3VCWk1WVTdXM3h3VWxzNTBnTUVNN0ZVWG1xWWFLczd0S21LUWRq?=
 =?utf-8?B?V296YlhnREwzcjEzWk0vTC9kZmY2RXFLcEYvNkdiMk16K0ZGTlNEaktwRm9F?=
 =?utf-8?B?NzVNVWlRcklOdXZaRjNCbVNienh6MU5GcFpPNnJ0N3BMdEl4K2dMUGZVM2lh?=
 =?utf-8?B?bVFaY2tlb3MreHhjQWg2aVVaeWVybDNYeHBSQ2F2eHIyd0NOdks2OXBxRFdt?=
 =?utf-8?B?bEFsVzcxOWY1cmF4bHhZdjNST1UxMFo4TmVEamNXbjc0YXNrbktWd2ZaUXd5?=
 =?utf-8?B?T3AwNlRUdUptYlR2ekJ2WVhROW5RZHJOMU9PTk9NWEtlOUlNa2RWT3ZUd051?=
 =?utf-8?B?cHhSUUkzMmx4UGVxSXZnVnc0a3NJZ1RNcUIxOUxWZlgrNjQ2TWlnTFhNaWt2?=
 =?utf-8?B?OERlOWVLbkVTZUhjYUlUWjY3MlpxamNFODg2UEU0eHVNZ3NXZEFic09Nd1cz?=
 =?utf-8?B?ekJML2lrTW52SjlGRFBJdUFWa1lWRVNGT3JNRTk1MDZpZHpXdCs0dkV0UW5V?=
 =?utf-8?B?T0tUNndLVkVIbTYzcnl1Z2NRWVZEZUw4bG5EU3VDVm15OCszWFBZUmIybHlM?=
 =?utf-8?B?eTR5K09XT3VWRzBnaFkyOHkwQWp3Nm9hcXJIem8zekpFeXM2WWJwTndHeVdl?=
 =?utf-8?B?Y3ZpT2JGMjlpT1RDTE1pdHBGMC82bGl2bWQ2dW5ZTXZrM3YrYmRmbDAyY1F1?=
 =?utf-8?B?TW92QVdCdmM4ZVY4SjdVSDNvSTdVMW1FNTNnVnBlQ2JDeWNXMTlMSWZhK1BS?=
 =?utf-8?B?OVh6dWFqMzNmMlluY0RiZkZPMU1MSUEzczN0WTIrVU5MRmpoQVdwUlVWYmNt?=
 =?utf-8?B?eUZXMkdhcTFHSmtjSnA5YUx4UTVHQXdVMjdWbzBjTmp3a09oQURaeTJRUUJQ?=
 =?utf-8?B?bitleWFNbW1XcmdXYnpNSUVIU0RiWWtCS1N6NHYyZ3l2bnlSa3paN3JmbmNG?=
 =?utf-8?B?SG5mbVVKL0ZLQ2o4d0R1NEQwbjNwYUdTeUJaZEpDbkUvbzlvdWFmSC9kRXpw?=
 =?utf-8?B?WkVKYjdRTWUvalpqR2l1WGNJYktxQ1FBTVRKWmlJa25ZZS96OGowZlFvSnRz?=
 =?utf-8?B?QUNmdVAwTkhqeWdkamhyOVhyRDJTTUJZWk1vT01YbDZBTmNxd3k4NVdaRWdC?=
 =?utf-8?B?cHBTQ0xtck9NZ3FtMlprUFl1d1RlNFJHdWZwYmJNWlU3UDJjdzMzRDFPNnFY?=
 =?utf-8?B?S0Zha3dMQlBOK2FOMmpmbWxoRnRhcW81ay9lMXBCTDNyVjlFeDA1SHZpNTBZ?=
 =?utf-8?B?VHVsSUdLTGNGaEdqbjEzRFdOM0FHOHVDY01jNDRtVkE1UTFtSHV3dVg4VWpB?=
 =?utf-8?B?aGdkRHVZckpqRDR0NjNGRzNRUG0xOXNBU1VoU1Zid2dRTnhSUllkUTlGNVVa?=
 =?utf-8?B?RWl2NVdaUnRxWHhaUU5WMnZlYnJOcXNGa3B6ZjhDMWFnanRJMkNNMUh3OUl2?=
 =?utf-8?B?NHZTbnJNUVh0SE1MTjN2MVUzakN5VVh6VzRMbEZndmhteWVRVlhLZnNRenor?=
 =?utf-8?B?WUQ0MnpVYW1STFpOZTBXTUJOWndBQUJmbUJnN0ZvdVFrQlpXWGZCS2dmOUpr?=
 =?utf-8?B?NkcvOHBXUkk0WDFXQ1RyWlZpb2tVaWJNOGJpdnhPbFhOUThBOHk1MDhlNEYz?=
 =?utf-8?B?eFZ0SndPUnRnenlFZkF6cjArQitJcnVFRkRsTVdrNisvdHZjZUlDYmdpVEZq?=
 =?utf-8?B?M0lzZ05ZY2I2VzBCb1g5eU5DSGhjN3RReWdjV3F3N3l0TGNwb00wb2E3TVho?=
 =?utf-8?Q?9QnEDMIcTJXg61cTIusvIT3Zk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 212a46fb-ec46-496d-9bc1-08dd1a7dc213
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 07:22:38.9165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWG4TQEp0JhmgwlhKUFbFlmWg813Q2zqVof14hZiN0PEQWSSe4TTpwPIJrU5tHtnVnaWf2Xa3UdhVoVSoFPlGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6200
X-OriginatorOrg: intel.com

On 2024/12/12 13:46, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Wednesday, December 11, 2024 5:27 PM
>>
>> On 2024/12/11 16:35, Tian, Kevin wrote:
>>>> From: Liu, Yi L <yi.l.liu@intel.com>
>>>> Sent: Tuesday, December 10, 2024 9:03 PM
>>>>
>>>> The qi_batch is allocated when assigning cache tag for a domain. While
>>>> for nested parent domain, it is missed. Hence, when trying to map pages
>>>> to the nested parent, NULL dereference occurred. Also, there is potential
>>>> memleak since there is no lock around domain->qi_batch allocation.
>>>
>>> Out of curiosity. In which case does the VMM try to change the parent
>>> domain mapping when nesting is enabled? I know this is allowed and this
>>> patch does the right fix, but just curious how it's triggered.
>>
>> This happens when there is map on the domain. It can be easily produced
>> when userspace allocates a s2_hwpt but never attach it to device. When
>> there is page mapped to the IOAS, the mapping is then populated to the
>> hwpt and its domain.
>>
>> In my test, I just allocate s2_hwpt with nested parent flag, and allocate
>> nested domain with it. Then I attach nested domain, and replay all the
>> GPA mappings to s2_hwpt. It hit this issue.
> 
> so this is a case where there is already a s2_hwpt with valid mappings
> before creating this parent s2. When replay happens this bug is hit.

yes. In QEMU, we will allocate parent hwpt when guest iommu enables
translation (TE bit). We also have a choice to reuse the hwpt created
during VM boot up (allocated by VFIO module within QEMU), but we have RO
mapping errata, so creating a parent hwpt that does not have RO mappings is
better. When this parent hwpt is created, we would replay the GPA->HPA
mappings, hence hit the problem as the parent hwpt has not been attached to
this device at all. This also means, this issue can be hidden if the parent
hwpt has been attached to the device. And this is exactly the reason we
didn't see it in the qi_batch merging. My test application has attached the
parent hwpt to PASIDs of the device to test out the pasid attach path, so
it WA the issue by accident. Recently, I'm clean up the tests by adding
them one by one, then hit this bug.

-- 
Regards,
Yi Liu
