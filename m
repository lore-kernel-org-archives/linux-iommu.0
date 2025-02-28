Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF051B960
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 13:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740751107; cv=fail; b=OasFd794CGwY4HvfUaLpk1tS262Sg3rWXcym6LyVfbFjuCUlid+F+wdSoBU/s4oRnw8ym6wg1Fq6VVtlDGgGFbvFcUbSPQOmLumNS7s1tAny896GkMHZE2CvstGyGkj78zeXswyR54J5q9CtMR3bJ+WCnBKjtcCLuoA3CaXudSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740751107; c=relaxed/simple;
	bh=/onlIvgpZFCsBenNXnrrq5rp3dmpVKk/0k9vKD4q3hs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dK/7WBEJBUoMTrdN/9e3z/dcFGBi6+KkQJor9LS0TWo9rO0PX4fSsYJAXeOY3Z8oRBgsYgjKDhhnB50e1cnuSvelBdvc85KKmsCwj/a9h/RWWsBtINlCk/uw/YC2nmBOlHzCGP3DDDzcAYaKCbGBGnzC1WKAheLrLmq0vsnXScU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UYmsLLv4; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UYmsLLv4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740751106; x=1772287106;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/onlIvgpZFCsBenNXnrrq5rp3dmpVKk/0k9vKD4q3hs=;
  b=UYmsLLv4RMdtmjFn5fMO1eYiPVIoc5bNMnPqvKBxvjrOW9NltPoCOYzk
   ME9h/9CUozVjJhy9ag7+fAL3zsDVmjHcKHzCcQOqtg/96PUJzzqzhTvVW
   K0o4/Og/o4PY5DTt43RUSWSVlJlNgeF2c67W3nO7fQACV4MJyKGTsmk0X
   mH0Vl3C9osrCMKS/XU66ehv9e+jb0aocVy/I26cIISMt5GFob4nf0T3Km
   /jCTb82fsBbXJydnky11cq+2lymc1pcIrVeg6q6RQEqpaUXu+pT7C2fHv
   d+ltM77cOOH9sqWJ+QKOHrSf2XeDB7/sxqe67W8b+7PePK14p0LWol2eK
   Q==;
X-CSE-ConnectionGUID: Ctm7yFEpRTWZyCkNbAT1dg==
X-CSE-MsgGUID: /0hlzwLGSjaWXwCFc+gK4g==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41802194"
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="41802194"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 05:58:25 -0800
X-CSE-ConnectionGUID: Awoqt6ZYRe2UJluxAkfDmw==
X-CSE-MsgGUID: hPjhZj5rRvS27PxBAe1ufg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,322,1732608000"; 
   d="scan'208";a="117377750"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2025 05:58:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Fri, 28 Feb 2025 05:58:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Fri, 28 Feb 2025 05:58:24 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.46) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Feb 2025 05:58:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3OfXZqZxIbay7rEmYAKVtCRprtdsXWMrSXIP9ryWBwkKERO/x2aq2WY8e2Ujnv7RKeSLWeO7B51Ba1JmYUAw9mZ9r2TMsXt9hU+vNnmTqzEe1pm2nAjWxudYqejhudUhWFw5doeXSikLHhN5Gs0el55JBqkcodpQdMCB4fEwBX7cKHDoMnjt80xNEpwjHOrJbhZ7e7HEiw+vagn6qE+D9cFAhjAei2MzddTM+RMApZj848jJ6VqxzC2WED8/2eGlWfi7HtKKS4fM9Sn1F72w+uKf69g09/L+Rd9I+4LnIVLXG9Hiz//bPnZd/nDCpXXigPPZs+HJr6C1HTfaBGJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DDCrYVus3U6J3x6SZUhBGpIrK7fKh3LMqBOwHOSlQE=;
 b=igB0Zrhvv1S/ptJyCH8GPVsLKaEmJDdAtI1OhnGIFIgQKwKpBCBEAppfaDMh1xMwVAdJrA/zj6i/0tUlOnvaPy6skEM0hjzfJ5wCceDOuCRCMfXY+nwAXm+MSnoIWS3VDc/NCkYzw+bp5hYx94b50QZcvMcaypMMwrKFlCB51pQF/nsHl8zEIUrvgd/fYG5S0stF2zQPKg0nBCFpNB8aauwU9eEKfVfWpftG1jVjd+Ou4KX+uMaQLcInVxXFyAZB70KjqAPUSbswjOnuuoX1Z7m9bGP/sEPEjeaaslWS2ZNsA7FHtCz4MHD2m/+qkA50GkV0/aiZm5/d2U57PZ8G/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB7102.namprd11.prod.outlook.com (2603:10b6:303:22b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.22; Fri, 28 Feb
 2025 13:58:07 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Fri, 28 Feb 2025
 13:58:07 +0000
Message-ID: <cc6ff6db-14ba-4c82-acad-d38ad08bdeb9@intel.com>
Date: Fri, 28 Feb 2025 22:03:31 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 04/12] iommufd/device: Only add reserved_iova in
 non-pasid path
To: Nicolin Chen <nicolinc@nvidia.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-5-yi.l.liu@intel.com> <Z7+sQOLeSk5hEcr4@Asurada-Nvidia>
 <1cf0cd58-3154-4412-ad39-0dab4b701ba8@intel.com>
 <Z8CTXk6mg742xdZ3@Asurada-Nvidia>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z8CTXk6mg742xdZ3@Asurada-Nvidia>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::15) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: b504cb6c-2b1a-45d3-637c-08dd57ffed85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dnVZdDNPWVpqNUtGM21JTEZCSE14M2UvM2kvRzNpT1ZrUDQrWUNZdFdFSUV1?=
 =?utf-8?B?SWVUN2JkZDZDTWI3NHNnL1dlNEZUZUxBdEY2UnJKZ0E0cVhVYURMdm1OU0Jk?=
 =?utf-8?B?SncrbDJHdVAva1lrSWwwRHVKTnJsRU5hb2hNQk1mcDA3dDVtTWVac3NzRzdm?=
 =?utf-8?B?dWdSOVFMbVF0TlZITW9qY2Z5NWdUOGF5MEZEb1BIMzJ2MXh5elV2M1hxajNs?=
 =?utf-8?B?d2RkTGVuaElDVW55YUVxOVpEWEEreEhGS0pMZ3VxUEdVSGhBZEJRaWRVenBN?=
 =?utf-8?B?ZHZjVnNNYmZ0d0dPNzlxcllZYnN1ZHhhVm5wTCtLU09PdmNQVm5JNHRDdDFO?=
 =?utf-8?B?cXA4M2Q2ZlBLS2tzUkNTbzNjcG5jMUl0MzhxclA3NUJlN1NyNU5ocDJLS3hU?=
 =?utf-8?B?MVVnTzlrTW9MTG45WSt1VkhnODI0UDBzRUw0OFpWRjNFZ2c4TzlGNHRCOFVE?=
 =?utf-8?B?RXJtb2NtejJpamJob0ZDYlo2bmM5MUVEWUNoK1RuZXA4VDJrRE9YT0dxN3pV?=
 =?utf-8?B?c3pJQ1QwR1c5bWY4TTc3YTVVNFFiS21jZG5jNnBPcUZTT2tueU1OTGhOSnc3?=
 =?utf-8?B?NTY0RG1PWlBpT0RyUWZnQnNtdHcyb1l0SzJVZDZaQkM3OU9LaFJwTnV4RitK?=
 =?utf-8?B?dHJFd2xoTUVYMzA4OEdGVUNvbTFkUGtUSW9jTGZ5RThLOThqS2tsdHNUY3o5?=
 =?utf-8?B?K0kzeWtscEhkemVBQklDb1hIZHJJVmxsZUdoVEJzdEZDVk5SR25ubGwrdTl3?=
 =?utf-8?B?V1h3Y2tTOFBZaE5FNFZjdXN4N3FMMEZmUTZDUnl2ODVaR0sxakY4aThmNncw?=
 =?utf-8?B?OTRiU29ZWGk5dU5PUFU0VnRLRUQ0Ynd2M1JoRGVoYml5UUo2ajR3Y2t0M1Fv?=
 =?utf-8?B?cTc5d2xzSzdxa1N0eDZ0Z0FER2s1Ulc5SE1hcjArQ01ESThBbUY2WEZMYXZG?=
 =?utf-8?B?ZzZ0RnhNckw1Vmo4cDl0bkZzTnZMM2NvZ3JRcEl4a05vY1Nhci9Nc2ljWGpj?=
 =?utf-8?B?Ri9UVU15SkdBVnRYb2pjakRHNzVnSmFmbkk3NEREZW5ldUhtVnVwQ2tMNXky?=
 =?utf-8?B?ektZQUpac2ZxMzhwYXA1eE0rekY1TE1zdWhDWHhxSHhQZzU2ZVpNNW9xUW8r?=
 =?utf-8?B?dWV6N2l3WjYxMWdkRWVqc1Fub2VQVjRQTS9CQzJVaDF5dmt2SEZMRnM4aHBk?=
 =?utf-8?B?U0dkeC82RDFNNjdzQzMxQ0pQZ3VhdnljTzRjbVFyWHJnc1lFdmlOTkMwbkRV?=
 =?utf-8?B?MEgyQ0Zic2k0cDE2Nk96QzlwVGhReWVxU2MwTjlDZnFlVkdOMEd4b1crZFdE?=
 =?utf-8?B?VWR0TGdwYnJUWVphT0l4MlJ2L28xSWZnWnZkRUNjbHRrZytrYittRmg5RG9w?=
 =?utf-8?B?Wm9NeHpWRURYNXJJbWlDTmNaMjI1d2p1OTJuZWlnUDlJdmE2a1lWckN5ckVQ?=
 =?utf-8?B?MTZjSzhwUW55RmpVT0g4SFNOQ0h2amlNRTc2VVVHckRyWHN3RnRUVHBXMXMx?=
 =?utf-8?B?RVl2Q1p2czJlbHpPeDllVkhYRXgxd2t1SDl6bjA1VXJwWDJvVDNOQ0hhUnlP?=
 =?utf-8?B?dUdLS3hlMmlBcjcrVkY0N1cwV3djWTc0S2RDdWNNU3VuZUluRmF3a2tQS1pv?=
 =?utf-8?B?U0xiVFdVbDFmZFpmaGpPV0lHZXVGT1BpcWk4elFPaWFsWS9vM2hDU2hJODhJ?=
 =?utf-8?B?UGRJczlkQ2VUdTJDYlEyU2VHYXc1bkNweGsydXFRK210NUt6V092aGc4R1h2?=
 =?utf-8?B?eDIvOERBWktiait4SVZwa0hJL0JMS3VTOGsxSERLaDllNnhqcVUveGx6aFdw?=
 =?utf-8?B?c3pGWGo1dUhkVkJYMm5mZElZK0tLVDI3UjdySmVrMW1DalNmbG42S2tnSENK?=
 =?utf-8?Q?hOrXK7Nlc3d3g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEtJTHQ2ejBRWlhxblcxdGlrdFNab3A4QUdKam9DRlVDV25BclZVK0JkYktS?=
 =?utf-8?B?b0h6Zm1ka3gwYUd4UEdWcDJFSTVTNWNuZ0xyUnY2RURXalFaNUc0T2RoK3pQ?=
 =?utf-8?B?OFJhSEp3emRzZTgwVm5PdlQwMHZMVDg1UHp3eEJsTFVFczdGS01XNnJCTHFN?=
 =?utf-8?B?eU45MDBWeUtZTENPWHlXTU1SY0pTNHYvTEhBd1k3L2l2TzYyVFJtM3BMVWlV?=
 =?utf-8?B?blNpSmtva3l5OURJMkV4M2IycWRKWGZWN0xLMUFyVnZKT1hNSmJsQ3A1dENw?=
 =?utf-8?B?SkZ5dlNMOUtvNkRtSm11TWM2bDdSMG1lRmJWQi9kN0xtcGdXNDRTaGRENFZN?=
 =?utf-8?B?YWZpVFJZVmFTcHF4cXNXR2NSbW15dGk2YjhhT2tBNCtzQkF5L2R2UU9yVER1?=
 =?utf-8?B?TUpXTEJ1RGxxMW1ySGVaVWpsdGtpM25XK3hiNkZJamJ0WVJRUDFGYS9NZWFj?=
 =?utf-8?B?SkVWbVBoRmhqSytlRjFKWElTNkhXRXRjZURHa3VtdFlhZDF5cFJnWWhORjRT?=
 =?utf-8?B?bUF0VHE2N1NLMnZsNThycmxYMHkrTzIwUHNsY05tZmkrbjY3SmVURWxWSW5M?=
 =?utf-8?B?OXF5dnNtOXZPbUtVTjRaU1Zka3lvRVR6OUJvU3ByVjFOMEI2SU52ZmpUalI2?=
 =?utf-8?B?OGlkTmtaOUM2eVd1N2E2S2FlQk1kWWlMRUFIdXNDWFp2NGozN3VNZ3g3bnBS?=
 =?utf-8?B?NTY4SVcvSkY3WVlLSlVFa3BQcUc2S3dKdW52Tk1kVzZsbmMxaXdEQUZ1cnB3?=
 =?utf-8?B?UlprNUh2K0FlTklQY0dpS1JJL2xheitSVXNxaDNBcE0wQ21ZTE1IaEdGM0RW?=
 =?utf-8?B?ZE85VU1LY1d1SDVhdE1RWFdsVXRKcHZZM1NubHpBZGJlUGxwTEIrRFcyTkgz?=
 =?utf-8?B?bEpiVG9BL0FTa3BobFl6b1BTTkswQzBJcjErYUVRM1lhclVLK0FkdUw0K0dL?=
 =?utf-8?B?dlUzR21TQ3cyVzNtbmpVWFZvMk9td1k4M2xNbENXUzg0THR5cXh2NmQyVG5Q?=
 =?utf-8?B?Vk9zaFA4ZjlIbG5ETEVQdWs0Qnl1TC9tMWtYcDZvSndaYWtQUTlqU0VVQVEw?=
 =?utf-8?B?TnFJOXJFVmJoTUFHSHNkdWRnR012SHU1STh3L1ZTTjJiWFBZVmtwRHptRi81?=
 =?utf-8?B?dzIwZmplMmNCMVNyc3hudWE2Nkxkb2k4SFBJMzkzSERZaU05ZGZlME01ak5z?=
 =?utf-8?B?V2syR01tYTR4RmFPczJLQ1dyWGxYK1hZOHo1NlBmTUUrYk1IbU1oellzeDJM?=
 =?utf-8?B?VFdxTXZwRHpWNWdCNU82YW9CdU1ObmhtbVhLTWF6MmpYVUg0WDIwV3JxYWhB?=
 =?utf-8?B?T09zM2t2c3pENlJjams0bVIxUThSdXdIWjJiUk9ucU5vN2tpa245ckoybHl2?=
 =?utf-8?B?eUFFL2I3bHJxRnMvVlhINllWeE8zMFBOL095SDRXSVpralpWMEdJa2lvcVdX?=
 =?utf-8?B?UVczRjhlbHlBcHpsWUtCeWgxTHhWUFVxTFo0a2h3Q2Zsemo4S0Z2RWJ1N0JR?=
 =?utf-8?B?bTVkdU5UVWJ5Smk2MnNFdWFMUlJDaG1HQTV3N0w1Z0pvV09McVRrNEdKS3Qy?=
 =?utf-8?B?NlNwTm5ZT1dLVlFVNFkvakt4bXlJT3FuOXUyMzJvYXNyODdPT2cxQjVmY2JC?=
 =?utf-8?B?TStlRTBZdXR2Tmo0VDlmZnYyM0NmOU9uN3lvajRNR0FXcXhkeVhtdXpkZkJ3?=
 =?utf-8?B?NXZoU1d3cWVQY0dKZmZVSFk3ZnFselJsMzl6aWlDcnpLMW0rdCttQVlTcEwr?=
 =?utf-8?B?QUU3R2VpMjBsV0sxT2hadi8yd1AzUGFtaHF2MUJ5b2lBRktvQmxycmVEK2ds?=
 =?utf-8?B?TnRGSzVSRGxNUHRBcnljQzVJOWVBR2NYSDlNbUlPN294YnRVQkZNbk1RWDNV?=
 =?utf-8?B?a0hxRjJEdlFmWTUzdFIwSkMwNk90NTl4N1R6aTBmeUYyTk0rdWpwemZjclN5?=
 =?utf-8?B?MjZkVGtEZTd3OE9ZMmVnTG5tdm0xd3hjb3lVSmV5dWtSWXVpTUprMTVyaUFQ?=
 =?utf-8?B?ZUxIWFZWVzN5R0tTS0x2T3loTjRCVnNMMVZVbnpDVXNqVjhKTlU0ckFQaGI1?=
 =?utf-8?B?dytXQmZJNitvMGIwR0xXNVBBV0ovS1Z4WEtJQjFyVVNxbGJSZSswc0ZJanY3?=
 =?utf-8?Q?rG8jQf8ft4bdSAS0AdKhVcTcX?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b504cb6c-2b1a-45d3-637c-08dd57ffed85
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 13:58:07.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gbczPilnLhl8olapaC6VVPxK3TNvyNfEW08l8LBxJYxmDsCLyKXnTzlb34RFZOqbTExieqc9lKiFHXnxwq8gCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7102
X-OriginatorOrg: intel.com

On 2025/2/28 00:31, Nicolin Chen wrote:
> On Thu, Feb 27, 2025 at 09:50:29AM +0800, Yi Liu wrote:
>> On 2025/2/27 08:05, Nicolin Chen wrote:
>>> On Wed, Feb 26, 2025 at 03:40:24AM -0800, Yi Liu wrote:
>>>> @@ -620,7 +622,7 @@ iommufd_device_do_replace(struct iommufd_device *idev, ioasid_t pasid,
>>>>    		goto err_unresv;
>>>>    	old_hwpt_paging = find_hwpt_paging(old_hwpt);
>>>> -	if (old_hwpt_paging &&
>>>> +	if (old_hwpt_paging && pasid == IOMMU_NO_PASID &&
>>>>    	    (!hwpt_paging || hwpt_paging->ioas != old_hwpt_paging->ioas))
>>>>    		iommufd_group_remove_reserved_iova(igroup, old_hwpt_paging);
>>>
>>> I am a bit unclear about the use case with pasid and replace. If
>>> we replace the old_hwpt_paging with pasid != IOMMU_NO_PASID, what
>>> would happen those reserved iova on the old_hwpt_paging?
>>>
>>> Or does that mean a device can multi-attach to one hwpt_paging via
>>> different pasids so that only down the IOMMU_NO_PASID path would
>>> it remove the reserved iova?
>>
>> yes, and only the IOMMU_NO_PASID path adds it. So only this path removes
>> it when the old_hwpt_paging is replaced or detached.
> 
> I see. This is replacing one of the domain in the per-device PASID
> table, and only the master domain (PASID=0) owns the reserved_iova:
> 
> PASID=0 -> domainA -> attach_resv/remove_resv
> PASID=1 -> domainB
> PASID=2 -> domainC
> 
> ?
yes. it is.

-- 
Regards,
Yi Liu
