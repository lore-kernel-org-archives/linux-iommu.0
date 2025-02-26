Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BA41624C3
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 01:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740532953; cv=fail; b=km300YeKAbwTZ5l3StmV0U97Rb/RbqsZr5NoJfJtTJCDBgvb7oOivYHSD+bKdP3So4q48JkSjhIR2GXiXnCY80ySJA7+9BosW649I4gKrWClsdWC4rvji+qy2G9hyU1IhrM0271UCOqRQc0Rl+0q55qZXvJ2hNkR+4YbHQki9NM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740532953; c=relaxed/simple;
	bh=OMSfPdiuXN7H/omtWEKNMLXHysanP27EcetoiQ+3374=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IPLqxf6pywrywotbR2Q5+mFHb/XV1SWQQbB/n1habv4qn7QUccd5C+UyPcAtO+pLYYE5ixx60CBfWnxQbgeDc8lqPZSx0LGdNLpeBMC3u9npZWMKOnHfJmMDiNjzklSL6UrF7JFMrJDP0H4nhPkFbKZS1VY19LMQdtw8O/xhi4o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V76JrT/2; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V76JrT/2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740532952; x=1772068952;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OMSfPdiuXN7H/omtWEKNMLXHysanP27EcetoiQ+3374=;
  b=V76JrT/27v42gUv/d7Ng4+i1N9TY6aeRjcYIP7/IjBH8BClUT4PLuZdN
   GD/0Rxi0sv1W/CZKe0o/dc5vbbRxOsTHussKTyQz6CR71fjYseuaUHiGH
   2beXSnn/jRDODRhjPrHN8WhNoln6k1cus1B302vxU56vP1ZsHkCgiDc6i
   LIxFDs9EjreerbuH7TTVQeyCNO/ONZglY1XjwNaZG+ZEp9OcrO2jY2yGc
   uXVHBpk+8t3+0tcnIYhvUYeS+KzSkOBdAM0mtcgKQXB7/I2lkL7W/7rF8
   2QiXsNnKL0Pj4Y5S/jS0vPORq3JdEKH7v9ZXqaQtggWgeeKMz4dpK63qL
   Q==;
X-CSE-ConnectionGUID: vSK71vdeT3uiAMtyS8sBlw==
X-CSE-MsgGUID: UkY+vJ2sTJaSLeTQzEaSNQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="52786050"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="52786050"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:22:31 -0800
X-CSE-ConnectionGUID: OvkBD8l3Tp+9ntvJVnXPqg==
X-CSE-MsgGUID: KwMDTaqSTySvRbX9hifpog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116341286"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 17:22:31 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 17:22:30 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 17:22:30 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 17:22:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sevHRBIe9dRiAIWLXg8fppPr/StIT2xDvMZVmyucVB46EJc/QyqWE1KXvlvp4WVNmh+pAg4UNHpnBOOa7C6oLidJu7+xkKM2lHFjkrNG+6f7TMrKXd+RiOWdP0Uq9VrLz+4wpYEw0xqvdbZrifYqsV/KVtLvTq9cRDvdvvkBsOslWF5QmUW/beAJtVdYmP7PVzEGNDriPXmCJItTgTQohQNGvzuNmR8YlofoToLcyG3ya/OsrhCt0F2wX2PcG+dhXNy4gyYuc/wdZ0cRv6tyfDCOo8StKGfP6lUM/mqBaywmSuz38uk0Pb2NwDzVwKqQ7K9HcVjWvBfL1zxdMpc28Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WXpdAlRDSl7dL5RKCCbZTCLjodSJcLkK77k/32AzpY=;
 b=wuXzA+eXlobHahggC6G7c12q6ELbBuddn4oUVX/yweo0MuXYMMu3n4s//2/+8F+cBAY4rOsb2ujE3P5UpWKed/w46CgIbB8eTn3ULrEdSM9bxlrzKZUWklZoUYNM6i0bWzCf+FJZL22yoh1xN28iwf9Di3eLipF2HGyhV/j8YNmmaisC8H+9+mBDEXNPsAsSPDbU6F6/1wY1+NVKEwnHD/5ah3rz6t9vzo0LEGImcVXkiu2ROCaK8mBHedrOfAnVC7fOfaqLwtpOGlRxYOreUZpHfngJBJcv/EqyqacDvIbWOHYWbYu42mfePU/IyRJFmCRymhBzm3jO1GHfm/M8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by SJ0PR11MB4896.namprd11.prod.outlook.com (2603:10b6:a03:2dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 01:22:28 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 01:22:28 +0000
Message-ID: <91516b2c-1ff0-498f-bdad-a05af0599f72@intel.com>
Date: Wed, 26 Feb 2025 09:27:51 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Robin Murphy <robin.murphy@arm.com>, Vasant Hegde <vasant.hegde@amd.com>,
	<iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <baa35632-eca7-4779-8862-b032d56f82e1@intel.com>
 <20250226011303.GA5011@ziepe.ca>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250226011303.GA5011@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:4:196::9) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|SJ0PR11MB4896:EE_
X-MS-Office365-Filtering-Correlation-Id: 44c8833a-d967-425b-91a5-08dd560408c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0lBN2ZDSjAxWkhaOFdpRDZ4STc3REpVZ0VDZVlOTUJKbnR2MkdSTG5RSSts?=
 =?utf-8?B?eEFDV3VUcHpBWGVqSVpIUDJONXdINUtOQmF5TUFtcmZ3UUVuTFJDZnhpOWNx?=
 =?utf-8?B?WGxBZEtjZWw5ZUEvWG05OFMwdTltY2JHV2szOWJOWUtFVDJPMXVaM2U0YjM2?=
 =?utf-8?B?V2E3R3VYdGtKZFJTWkdNOUFwTFZDSTB0Nk0xa2lPclI4Uk1VVTlzaCtoQ0tC?=
 =?utf-8?B?dnZScTcyTGlzN0hFd1dQQmtvRTJHeXJRVUxpay9IbjdLbzExNGhrb053NzVT?=
 =?utf-8?B?Rnh5SGYrQjVhSFJtTTcrL3hxMkZyTHVTSXE0Tm5KL1Nha1Vib1JOSjFReUV4?=
 =?utf-8?B?Zk5RTHJ6WFhhWEVoMnRQeC9iR3Y2V2QzeDhaaWNYRStKQStsOHlXUGQzeTkz?=
 =?utf-8?B?N0ZvN1UwK1A2cUlyanRlOE9FVkZFOWxkL2hhNmZaS1JXbE1TNWJtVGY2SUsx?=
 =?utf-8?B?cmVYSWlpQTJEN1Z1c2JPR3dGSERUd1NnR2hmTC80ZHhLSDVDQnA0K3ZKOVZP?=
 =?utf-8?B?R2ZWb3pXWGYvV1hMbkg2dFp1UmUwQzhJRXRGc3NZSVRWVDVncU85ZTBvMkF5?=
 =?utf-8?B?b2pNaVltbEZuUjhsMW1Hb1Y3NEFBNG9pSTcwOGUrZHh3L3ZCMVRmd29RN2t6?=
 =?utf-8?B?dnNwaUwxMnFGWEVCWHlPQkdQaXVNbVZhT01YT2xzSEpUSEZEd005RlNVazVT?=
 =?utf-8?B?TlM1Y3hiK1orTk44dmQ5YzU2T25sOXVoT2U4YTBVTlR0M0N2OXJFZU5ETTZW?=
 =?utf-8?B?V3ByYnN3cXpiZHIrSHlQWDljazVpdGF3MWcwMUlCTGNJYVhBNzRoN2h6eXpC?=
 =?utf-8?B?WkQwb05xa200bG40a2xHbFdqaFRPUmJRUmNwM1B4WlNKVlc1Q214R25ZY3J3?=
 =?utf-8?B?MWYwSUFwQ1c2cnJxcUFocnhnWjM1SnRCdjA4UXFCbTQyblRweXlPUFJIdFBl?=
 =?utf-8?B?ODBHNnVTTEdDK3JXalkwRUhIV0lRK0IveTJrb25ndnRHSDZTTkxUM09aTlBC?=
 =?utf-8?B?SHlhbk9mZmpyY2dYang1T3htMHkyVFlCU1AwRzNoeWdCbzJIVXV0elZ4VXlE?=
 =?utf-8?B?RGtXRk9wcllYUVpBL3NXWDhhQXVnUlJvSG1iUlZCZU5UTEk5TlJodUNzeWxX?=
 =?utf-8?B?S0lYVEdmNWNVdGVZV1VTUDVMM0NkR2ZYcWJzeXpac2d1SDFwOW43elM5bzh6?=
 =?utf-8?B?RUQxU0g4SHZiQWltTzR0c014OG5nQ3VnRkI5SnZESXZ0NU9YUmR5bk5WSVd1?=
 =?utf-8?B?bE5EUzZ5YU9tOVdHRVhZTG40R1J3cUp6MVpLZTNBQmtNRWVnT0JpeHJQVE1Y?=
 =?utf-8?B?RWZIWnFTeTloUVE0cm12d2YyR0lFMGQzdmhZUmFmRmtXUFZ4dTZtQU9lOVRj?=
 =?utf-8?B?eUoxd3pvSHhnNlhyZ2lIeGM0MXpSUVpkQVplTmdvOGMrQTdoV1JtUUhPcWhE?=
 =?utf-8?B?a1QyT2Z4K3kwSlJQdzhxL3pycVhwZDFEQ0JhVTYvSFprRVJJSGRjbUlwUENS?=
 =?utf-8?B?VVZGZ09Lak9NVEQyVEt3S2o5aUh2Y3grVVdwTjNpR2ZvRVZUQUc0aW1hVzky?=
 =?utf-8?B?NFJHamtTbG16QU1KVHZ5dnhwZ3dTb1N2ck9EdHNTRi9GQ2c0cHQ2dnppZ2Ez?=
 =?utf-8?B?TDJNcjIzQWJDYVUvZXF2bjlFM0V0RlNOSDVNcEJTak5yazFmT1djaTNsSHJO?=
 =?utf-8?B?dlJIVzdRNkUra3hycm5XYW93SE44OWdVamNCSjU2Tk5heXl2b2FvcUx3R21Q?=
 =?utf-8?B?S0xZZHd6UlAwQ0dpaGg4QWhQL25jRnJDZm5MUVhmNkMvV2V1SEtPckkxU1B2?=
 =?utf-8?B?SGhyMlpaUVA4STJNWW0zMTBQQjZybWhXdE45cDB2RUNwN1dPZW5ZY0R1S2Jv?=
 =?utf-8?Q?kez2UJXBuzLGx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjFOUHc1UitlSXFaWHhqTFQzL0dodkk4cDhHRm4wOWRSZkFxTUJBcUxYWFpG?=
 =?utf-8?B?djdHQTBGMjNvTEE4UUsvVzBvR0tWTCtKeUQwb1JFUy90dWdMM2U3MWJTTElk?=
 =?utf-8?B?RkZmOHFRZ0FKb2xhSVhnczEwbWdCd2tGd1RiMGQ3ZWNpRFpiOVRaM2ZSLy90?=
 =?utf-8?B?SmZmaGVjQ3ltVEpxN2x6RWhLOW1zZ1JIOEVNZXBPek0yNzFSaDdnWTZQM1RO?=
 =?utf-8?B?N0F4emRwOFY3YU9aNDM4WWZRdFg4UUNJS1RQQmFTTStlRlErZzBmenhsUjZ4?=
 =?utf-8?B?Rk5mWnJMY1hLRUlDZTJMdy9aTDc3RGtLdnZjYkxvTC9xZk5kNGc4MmVSMlVO?=
 =?utf-8?B?MVgxb0R4alZ1MVNkclRyVzNncDVydzZ2TnlmMEx0NEpJM2NLMkN0WWJMWUph?=
 =?utf-8?B?YW9Fc3N1eXk2UlBwejJKTjBUazV3V1hLektzVnV6UEVDYTl0d1QxR0JTYVUz?=
 =?utf-8?B?YlBRemI5Wk5PQ2lYRUNsN0VZTWowL2l5WUtsSXoyTFlibytKUjAvck9pWlIz?=
 =?utf-8?B?dGdsY1IzK3lsdjFDMXRLelUvQ3Mvd01MNnlBRXV6MGw5aUdvRDhFZEVZMzdj?=
 =?utf-8?B?YkFNQUdrYzA1NzI2M1pKRm5VdG9xYUpZOTErY0l6V2t2UTMzTDJNM1VWZ293?=
 =?utf-8?B?eEp1cnhKMHJEZkZyVWkwWEZIdGtmdGxXeUtNNVA4ZVJrRndhOGRYVFV4Rk5O?=
 =?utf-8?B?L2dDbjNyT2hDd2toN3E4MEpIZERJMm9Xbm5uU0Q3cUVyRHBLZElRbjNKSlVy?=
 =?utf-8?B?cGJIRW1ieHBWeUJHM25KU21qdVdMVmZ3UnNNOCtSVGNESGhHSno0d3ZBMGJk?=
 =?utf-8?B?Q3Fic3JpUFBqc1ArRTY2SVVaa3lhRUZEZDMrcW1YYmRvcDRtTm5tMUY3SWl0?=
 =?utf-8?B?SytDSGFMZCtOVnNpNS9JOEU4ZlBBYmV6cGNYUDY1VkxPcEhGUHZnREtTZkF3?=
 =?utf-8?B?WFJaTW1hYTFDWG1pL2Q3cGo3ZE1FRWprWE5yZTRJRzdKMmExRFRFTVNUQzNT?=
 =?utf-8?B?QkRkRE1lVjBaKzlTdXhXcFMxR0ZwYXh3QlJPeXRMUUtFL0JoQ29MRUFiOGR5?=
 =?utf-8?B?L1NRWTllRndUdEU0N0piRThaanFjd2tjUFAxUi82aWJnSXFkb292QWNFTDd0?=
 =?utf-8?B?b2dydVNpYzdkbVMvNHJqODFjN2tlbklmZ2pUQ08vRlkzN2dHTy9hZGdNei91?=
 =?utf-8?B?SDFHSGtYUGFoaWRTeUFIL1VEdWQ0MjBPUFBUbWZBMjJQRUxVT01YeFVSamUx?=
 =?utf-8?B?SE40R25DSVJhSXA2TXl6bUxnelovWWk0QnA5cGRTOG5yZEVxaWZPYWl0UHpz?=
 =?utf-8?B?S3hjUzFFdmI2SEtmUG5SbGMrWnhxSFZHcVNkU3UwdUVGWEJPMGJPYVV0djlD?=
 =?utf-8?B?bG12UnkvbXNkL01sMTFwRmNXWWdHTlR2YnZMTEZjNEg1ckhFdXdtenFLYVY3?=
 =?utf-8?B?YU9NUGUxLzYxdnI2MUtMVVNuYWNjMjJhSXRreU53alhPL0crd2szU0ZZOU9S?=
 =?utf-8?B?L0F6VGdPQ3pJa1dBS2NlNXVpdzY5a3F1Zk56Y1kySndObk16RkMrdDg5VnBD?=
 =?utf-8?B?WkZudFI1NkQ1eUZrUFpOZGt5aEwzeis0WlJldzNsaTExcWxhQ2w1TDM3bXJV?=
 =?utf-8?B?U21PYitMV0RseXZibjVNeExtTVVXM0xTa3JsTWM4MGtJK1FRZ2cxbk5nS1Nj?=
 =?utf-8?B?L1ZKWkhhRTJJS2hmME5ROW0rS2JLMThoUnVROGVOVzJjZTNWNi84ODM0Q0t1?=
 =?utf-8?B?N2p4Y1VxdUtVRmF2b3hlRUFEbyt4QmlNMlhTdG0vWEg0eWg0Wk54dGU4djlE?=
 =?utf-8?B?c04rc1lKRlJHaWozamRBRk56V01ENnczWWExMEVIQ0tIb0Y5UUUvOTJGTkRs?=
 =?utf-8?B?UVhuSlZCczJObEdXeDJrMEZsQzA5eFVpZTFuL2lqeGRudm51dkc1U3cvWDJv?=
 =?utf-8?B?aHkydkxDT2Y4QWJnSTlicGlDTVhmTzlTQkJ6dUdxWWdiQ283UGpVOFpBM2gx?=
 =?utf-8?B?YXVVeTgyNFNUU0duQ3FyRzhyVnJjcGFabndUaFZ2OXFJWDQ3ZFJET2E5ZHNO?=
 =?utf-8?B?ZE8yNU94enpidlhEU3FPWWZrSmZRVmRhbkNVTzNkSmhuTmxQYzA2dW5lSzdl?=
 =?utf-8?Q?9PNDpeDjMLu+heO7St0qO71P/?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 44c8833a-d967-425b-91a5-08dd560408c9
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 01:22:28.6683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kK0X1s6QieOChHxUrTluMsctoAt0oYprPC3doEidmo4TXf9dSOIvpu4rF4ATNbvon3P7ST1gapQp5Lp/1f9HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4896
X-OriginatorOrg: intel.com

On 2025/2/26 09:13, Jason Gunthorpe wrote:
> On Wed, Feb 26, 2025 at 09:09:29AM +0800, Yi Liu wrote:
>>> What are the options here?
>>>    1) Translated Address (TA) is a full physical address and IOMMU does
>>>       do anything (today)
> 
>> do you mean "do nothing"?
> 
> Yes
> 
>>> Not sure how to setup #4? The core code also needs to detect coherent
>>> systems (ie CXL/etc) and refuse to do anything other than #1/#4..
>>
>> The DPT and the HPT validates physical addresses. So such tables need to be
>> programmed when a physical address is mapped in I/O page table. So the
>> choice may be associating it with paging domain (e.g. the S2 domain that
>> converts GPA to PA). If so, a domain alloc flag is also a good start.
> 
> Hmm, so you imagine doing it as a side structure under the map
> operation.. Maybe,

yes.

> that will complicate my effort to unify the page
> tables somewhat, but maybe not too badly.

I'm not on purpose about this part :)

-- 
Regards,
Yi Liu
