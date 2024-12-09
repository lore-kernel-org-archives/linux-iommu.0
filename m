Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1132612F59C
	for <iommu@lists.linux.dev>; Mon,  9 Dec 2024 02:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733712433; cv=fail; b=RRRQU1JDsFWGTKauK+6+tybHXySiO523aLhZpoHug3ewTI+boX6PO4+JqgOrpxxev7JMYpOHsqStpcnHa5XwfePd55j/r8T37ktxFyDM+7mluCgPRMokx1o7Q9z6O9ML0W9i5+90E7gOfnYobv6RJj/0QK1V28M4gAP18QB+5NQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733712433; c=relaxed/simple;
	bh=WJjzw6JJkJ20tYUVcs9E6GBHcP6bOoNMVvhA3ab12B4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M03yY73zEHwjKMkzhLBHU7THpj4gtllk6mRCQvstEB9yosT8BZ0HvzpYzljHLH4jWydDlvFnuona4mx2pSggywNRraGgoEWHX3JMO/a5soPm4+trP98KSJguVCTeUFEUqEmQ4jjGmkjxlhbcW/2udET4Z+605Xi0NbxBQNkdRis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADuAnZ+A; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADuAnZ+A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733712433; x=1765248433;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WJjzw6JJkJ20tYUVcs9E6GBHcP6bOoNMVvhA3ab12B4=;
  b=ADuAnZ+A1/aOjVXVeYn/FXzICPPAgpcCmmy0w2WBzpuD3TrXURxnOeVH
   ChbEh2lckAxMe9RU+vToYmpviT8ZHGYfZfRzFQJnI4Hbao+yRk/K+0VTB
   xlbvh64vO+5Kg31/pgkAJmjZ3hYwJ0ZTkZO1IYUMDg/4QOcPoDc4sQNRc
   BOCkg9mtx7SAz1XPfKhOqUS1te9sVoenbIqBJPvj3rLXFjjLkH3uQnFXQ
   9vsa296CQzrW7XVmBF1hPrT/Z0FP+HNvh4yj67/RMa4V3Vd8PSaBCioz1
   zUrfKj9HRU7CwY2DkHxmvyzrmBi5SlkzuMQwBMhksDMpARwphjMOa/4Yn
   w==;
X-CSE-ConnectionGUID: 9SlMQBw6TiOXrxHMYVY4Qg==
X-CSE-MsgGUID: A44VyjwtTgWAEQa7EBTbAw==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="45006247"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="45006247"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 18:47:11 -0800
X-CSE-ConnectionGUID: h3ozw4nySTWkEPVat8ZPag==
X-CSE-MsgGUID: 6Ym2FZrCQM+9d8O9pCzD0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="94782217"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2024 18:46:57 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Dec 2024 18:46:56 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 8 Dec 2024 18:46:56 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 8 Dec 2024 18:46:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LoXMN5gNhDksHO4bLjSf/gh7PhF6gdd2bLGWyxEjTkDFOP9iDUCm2qJZrQb87+WGaDmK34A6/A3eRLPgxdcSjlrbw3opupIrxJs5n0C8Qmdq5fRlsjuY3PQ8ziEfpz4BmI7OqZ4HSWm3PKyvBTg8FDOm4EfokmLB6PYbhy4U/I2aRSKwwUclNPNc51qG3+Sb5MfDU+gFQ6IbcMs8+qANPDIJkc8snoOWO2kVPKtQpa+9nYKt818i5qK1pFcXqTnzc/OWmnPwVYzTOJ99aH7V4FpVFG79LTJH85cw6mYlB4in+y6gMtAAoVefs8L28l798mbej2ZjnkxDzu1KwDfWMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdGOL71EArk8GjWdWT8a9v7ts9sNHywrxSetFtTlcqI=;
 b=i8QbfHxi2I7INRol5Q/UTd220+VIT7MpIFDuMhHaev6SntuUAH4D1ronejsJJHHbzHgBAyPjSleqD23N+55XSQcPH/6IHl/QiUIHBF2Ini7TEngcGQSkuPCFjk0Qi4s1hriae8ZiZq6w6tD/+PA5UdsiRagGDGgPq6oJQRZu5MWQEQPhHkMDxhUcPEPcarixNuw73jkLuPt13mgaBUDAd/oSdLtLmbF7aonljzYOaURwn/iqVpLCcetblSdpZw+/NL/SBcs6fAYWsLv5Lu43jlL32itZj4nldzTLjCwLRcT8VBy0SMcQZ+pSCNEqlfhVQLllQ2ud+4VmylMo0SmhMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV8PR11MB8559.namprd11.prod.outlook.com (2603:10b6:408:1e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Mon, 9 Dec
 2024 02:46:54 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 02:46:54 +0000
Message-ID: <3f9e3172-dffb-449d-8bd5-23f9cb2de73a@intel.com>
Date: Mon, 9 Dec 2024 10:51:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommufd: Deal with IOMMU_HWPT_FAULT_ID_VALID in iommufd
 core
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>, <jgg@nvidia.com>,
	<kevin.tian@intel.com>
CC: <eric.auger@redhat.com>, <nicolinc@nvidia.com>,
	<chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>,
	<vasant.hegde@amd.com>, <will@kernel.org>
References: <20241207120108.5640-1-yi.l.liu@intel.com>
 <b1e8ad5e-e149-4502-8242-b971ac1d4eff@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <b1e8ad5e-e149-4502-8242-b971ac1d4eff@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0030.apcprd02.prod.outlook.com
 (2603:1096:4:195::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|LV8PR11MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: a47e24bc-3095-4f0f-dca2-08dd17fbbd43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUlTR0tybnJuaWlJSVByV1paM2g4NzdWUm5Ba3BkNUZUR3F2MTJTZGY1VnNy?=
 =?utf-8?B?bUhMK09iV0hBS1grRVNwbjVnRWV3WkxRWXJhcy9YVWluNjVNVjhKSXRRcWtw?=
 =?utf-8?B?YXcwd2pRWWxLdDBveW1YdGNiYmpFeDlpYk5GSXhiN3lad2ZsTmZFa1N1YWdI?=
 =?utf-8?B?RENMQTUwZkhEMlI3UEptT2RhZjA4K20yeDFwQmoxQmNnQWtWaTdJNWhNOEdW?=
 =?utf-8?B?REJKVHBpNkR6cllxVitRUEJmdnNhQm9yM2hNdWU4Wm9CQ01ZQzlnV0I3VW1F?=
 =?utf-8?B?UUhlRTRJWVd2N0QxS2xldXZUNkZqNXhla1pxMmY4VGRTaVNETjhBTTNkR1JL?=
 =?utf-8?B?Y2NJc1FTamsyRXE5OTBGVm9IVWVyakZxTmFuQjZkVTJoNjQvWDF0YjIxczNX?=
 =?utf-8?B?NkFNeWxGTy83QTdOL0F4ZEViaVNWU3dxcHpVNnJ1eU1EaUJyYVRka0lxUnBY?=
 =?utf-8?B?ckxVbEVpa1RNa2JTaXYzRFl2NjIrallzUk80bXFIdlB4SVAveUNkZ1pYblZE?=
 =?utf-8?B?aVgyWDVFRFAxaHdxNnBkNHlEZGYvWFllZ3lIM1JMY0JEek85M25ZY2tzb2Fn?=
 =?utf-8?B?Zk9mU3M2dTZEVERRSlRGMi9EdkcrdGp3ZHd2Zm5vTnBkS0RGNWRDYndVUThq?=
 =?utf-8?B?OTc3VTd1QUMvLzg2bHAyaW5zK0tkdnJPTEpIcDZJVngreTB4SWliOUFKMS9U?=
 =?utf-8?B?bzZqOGFSNWxYUThEdi9YUzE5cGNoOGVraW1uYksvSkpoZGNVa1Bjald6aS9j?=
 =?utf-8?B?VFgxSjNxaFJhbTBxaUVtNFBoaXJDdjhwckVYMWNxV3BmQ3IxT0FwNWFqaU1a?=
 =?utf-8?B?OVF5NW4reW95Z0RuWjVXQSs4dVdvR21PWlhXajc3dUp0MDNIc1BpcEVFa3JV?=
 =?utf-8?B?RFZNK0JCUnJRbDZhOWJVQzM1cTJqQ3MveTh1T1FiMXFLZWdXdEpKMmNCZHNx?=
 =?utf-8?B?ZytreTFrcy9IRWdMcGIvbUQxNTlLUmtUV1MvNDFpUmhzOHZMV2VGTnNOU05F?=
 =?utf-8?B?NWxhTGVxcVd5ZGM3alJCcDNEQXhtQlYvaEpzMG9mUERtU3FlZWlJRk96S05U?=
 =?utf-8?B?U2g5ckh3R2YxOU9oTTZqRi9CVnFhTEpEbFNXNjhzeldGTExpTW9HcnJCZlJq?=
 =?utf-8?B?alkxY0Nqd2xleTR4d0pEZDVlMk1KdStDWW80bXAxUmRUZHBocjZPV3lIVHJp?=
 =?utf-8?B?c1dzbkJYWmFoM2EyY29oWmZrT2h5TEsrMmc3Y3NuNUhWdEVkd25BRU5OMHFS?=
 =?utf-8?B?Tmx2T2FLLzhnTE0vKzJvWWx3OUVEWmtQV0k0NUxnb2xuc2ZFSXl4MGJZazkr?=
 =?utf-8?B?TnByMng5TFl5YmZSbENRaFJEL2EwdzZSOG1tbm0wWGFETk1waGkvaXRobHVq?=
 =?utf-8?B?L2hadnRHeU5SSHlxQVVtOE5YeWZjcDNFRTY1NUY3M2E5NXBYYUhZK1p0YXhj?=
 =?utf-8?B?TkgxME1xSHhnZE1EVzBETXNKWFFrRUl4RCtvUzZuMzVzdHpSRTA4aGJqNjBZ?=
 =?utf-8?B?QVNSU28vUzRHWlNsb1NyZ2pTTmdJR0FuNjNMdTJaSGpEU3NGWU4zSGhXZGI2?=
 =?utf-8?B?TEMycDhOUUg0RDZ2ZjVCNHFJdkhyb2xxUlcrY2ZPYWxZekN2MTFrOUVGYzFz?=
 =?utf-8?B?b29rMDI4ZGVOWUpLVHVrMnkxZUZYUnoyaVQ1U1haV1drbGcwSUhFZXZnYnRQ?=
 =?utf-8?B?OUVobk0vMUx4eURPM2xZMEVMaVM4RUJBY2hwb1dFL1ZXOG8zOUJnZmZxcVFK?=
 =?utf-8?B?WisvaWRHYUlwc1hCWFEvQ1AyV0RibmFpVkJjVytIUXVCb0t4Um5Iak5lQUxN?=
 =?utf-8?B?SlIwaGtRLzdOSWdnMjYzdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bDJSOFNxRVhITS9rL1hGYUlRUGVxcTQ0MjJZRnliMU1INHdsSFJBd2FMdDkr?=
 =?utf-8?B?eW90UFNpdG5RcTRFd285ZU94NXllOGdEYTVWV2tXRGNIdGllQk90a1lJR1Rn?=
 =?utf-8?B?YW8ybWtqSTlRKzYvb1NkS0RwQ0dsVWlhN0NvUDJjWkZ1M0haZXpCV00walNp?=
 =?utf-8?B?Rjd0M0ZMMFhNdEIyMDVpa2NIdERHUzQvZjIvc1JUVlF2b0lkVk1EZy8xT3N2?=
 =?utf-8?B?VjlySk5qeUxMdFozVjI5VTU0Q3lNM0U4SGpFU3NPU0RKc0tTNmd5engxQ1Y0?=
 =?utf-8?B?UngzV3ZobDVCNWdKY3llMWhYaHZkeXY1V2NDS1BMbE15RFk3bis4Si94THhm?=
 =?utf-8?B?aFk0Y1JDcEcvMjJLYjA5MnowQUFNNzdJSzc3TVJHZlFWcExHZ21zeFZWdjJJ?=
 =?utf-8?B?RVVHaUxyZVZkNmh6Qmo0RzNreEhLNlRHcklQdUR1cXZlNGR6ZVhsc012SEx0?=
 =?utf-8?B?Z0k0ZnQra3g1K05EUzFaaEV2QTdld1ZZWFd2dVNHS1lHY0RsZU80OEF0YW4r?=
 =?utf-8?B?K05ld0I0Rk01MzJWUW9idVNmS1F0dkdKa28xS3cvTEZ6WHRudGF6RGpTQUlq?=
 =?utf-8?B?cEZnb1gvdnRXS01SVE05N2FZekduTjlVODVrWGJyc2VhOExTR1k2SEt2OHdD?=
 =?utf-8?B?TzAzT3ZhRy9aM3Jrc05xMk9zamJIZEhMQVduNTdZNEpOUEFYYUNjZ3Z1UlhU?=
 =?utf-8?B?Y0hIQWVMRUw0amxNMFJjL3N3V3BTbHdPQmZ0RTFxNmhmd0FPd2VGcWoyY3p1?=
 =?utf-8?B?M0o4cGdhZTZtV0x0eGdVZFlFU3BPeXErMGVnYW1BNWo1U0F2VjVtTkFYNUk5?=
 =?utf-8?B?VVpQTldUNGhhV3VTTHNzZjZNcnpyanV0Z0wrUmRQZzRLd3dTYkdNNmZNZ3pl?=
 =?utf-8?B?TFFPeTk1eWoyQkpwcDhvOW9GN1F3QkIrT210Q1RXMlh1d3hhTjBrdXBucHVr?=
 =?utf-8?B?SFlicXVZVzVYbWFTbU1rRk1Id0dXL1h6MEVPMk15cG9XODRjS3A0dFFBTk5W?=
 =?utf-8?B?UGFsUEtuZ2wzN25qckV3djFieS90RW91K1doWVE5QmlqN2x5b3M2NkZ4WDR1?=
 =?utf-8?B?L1BSSmZodU1pQ3dFWFJwdmJDQy9LU3FaZ292NnJPaW1WdjVXSGRTcWE1TlJu?=
 =?utf-8?B?YjlUQTdvYnBZanl3YWJZbDE0OEV4VTAvY0VINmVaWXVpTjZLVHhmbWU2cm9k?=
 =?utf-8?B?RGFFZzVIRmRqeFczYlhIMmdRdHJEZDVsZ0RPMlA1dWMyQmZEcm9LelFyWUdN?=
 =?utf-8?B?enE2WU94V2QwZTc4emtoK1J5dFRYTnphWDlVR3lISUozNmpyT2xOTU9Yemkw?=
 =?utf-8?B?VEplYjN6cCtRNGREcHhWVGh1YXBndWRFTVhiL2FtWUNmSWl6YndIc241RWlW?=
 =?utf-8?B?RGU2aUFNYXMzc1hSVU5rZEMvWDNkdzE5bUMyejhRVkZjcFBHUWJEZWR0WlhF?=
 =?utf-8?B?YnppZng2Ynl3TUQwQnhuMDJaZXNpNDZ0eXVmRnhZeUFaaCtkY2g2akpuVE9Q?=
 =?utf-8?B?U3BHVU5ubnlSeStrWEpvUU5qRTgrNGlzdDVCVnpnMVkva25acWRCK3ZtemdR?=
 =?utf-8?B?MW92NXZVaVVweHRLRTM2dXZGdnFhL3YvUWlMeWNFZ2I5ZHhRdmR5MmYvZ3dL?=
 =?utf-8?B?WXJzTHd2eUZvem1ZS0pPOEtGZHJsaVJrMngwVlgrQjdybDZPd3hMWjlicGJj?=
 =?utf-8?B?Q3IxWDNqM05xK2FhNWFBZ1ZndlNUYVd6MGtwY0pveHR4TDNVNDdxMDl5eVhG?=
 =?utf-8?B?RUFoVWJOQ1d1UjlYdU5oNmpVTllMc09KeEZ4MTRpSjMvajEwR0JycjFzbi9w?=
 =?utf-8?B?U25rR1pHSHJvRmNvbC9XN1NCcjlEazVQQWZScHArSWFudmpITml1eFJIdkR3?=
 =?utf-8?B?OHBqTlk4NGQyZ2hvbTV1ZjBVZ2dPYUFsSE5XM0Z3OSs1eFhhTmNzdFNBT1ox?=
 =?utf-8?B?K1hZTHYyS0hSYVEzZzRrSW9WYmMrYTAzMDU2Q0YzeUFERlpiZ2xoOVEyU2sy?=
 =?utf-8?B?cWNhWXRjQk1vek1sTFRnYk0wd0RRaTA0Y1RoRFBIeDlFVHdlL2phYVFBSzhW?=
 =?utf-8?B?Z3FjMmFLVFVhUnZGcXdqcmQyV04rbDB2cTJieFI1YmlkY2FyRzBqK2Z0UTdh?=
 =?utf-8?Q?ywA6+M5pFKdR1GMNtOH0kTnBA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a47e24bc-3095-4f0f-dca2-08dd17fbbd43
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 02:46:53.9207
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBzDt9jArGPRtYItHRFFjbcfFE7dW9OM7LoUQrsXDfCFiEpWlHdf7EgpecrROd+kJyKB+reIvfCslUGsOd1O9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8559
X-OriginatorOrg: intel.com

On 2024/12/9 09:08, Baolu Lu wrote:
> On 12/7/24 20:01, Yi Liu wrote:
>> IOMMU_HWPT_FAULT_ID_VALID is used to mark if the fault_id field of
>> iommu_hwp_alloc is valid or not. As the fault_id field is handled in
>> the iommufd core, so it makes sense to sanitize the
>> IOMMU_HWPT_FAULT_ID_VALID flag in the iommufd core, and mask it out
>> before passing the user flags to the iommu drivers.
> 
> Is it a valid use case for an iommu driver to intercept the
> IOMMU_HWPT_FAULT_ID_VALID flag as an indication that user space requests
> an iopf-capable domain? >
> If the device and its associated iommu do not support PRI, the domain
> allocation should be aborted and a failure returned?
> 

Agreed, it is better to fail the hwpt allocation. BTW. We may also check it
by reading the enable bit in PCI config space of the device. Which one
would be better?

Regards,
Yi Liu
