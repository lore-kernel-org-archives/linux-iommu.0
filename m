Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0937B42A9D
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 01:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740531899; cv=fail; b=I6FD9verv22uAq+iyUvbxYf1Fmf27Qv2x6vDsMKtVAPhgXMmY0QUDL1fmMzZuUopj/2DcGVNdEgMwk3jcGQsILv4piEB3kW9wlujxFuYX98centQc/lSMVVfA/6wMx+WTFslI3eeHuy0tZnDaH9R5PVWZxkkVNkZLpSHZQXm+Dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740531899; c=relaxed/simple;
	bh=cGCPiJmq1V/IgbK5i4D+aMOLNHXbe9ph0VwkByxubPo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dymirzMr/5aNHSGobrGnezVQlziXKR6Th2zwQtppGs+dHcz0dTXeKCUe3P+5yRVlX7fDDjh0Ws/2qhOrTGgQ8ynneV0wpIhE/N0pCg4yHzz9E+VM6kkUiD8D+o2SMWx5b0OvFb3sDdz4s7LJhgQa2yYLKgcJy+HBIzFR0I8u/ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G2t61pz5; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G2t61pz5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740531897; x=1772067897;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cGCPiJmq1V/IgbK5i4D+aMOLNHXbe9ph0VwkByxubPo=;
  b=G2t61pz5kw8o2pUQTBfRtwaKemzaUKndS6wYvzntUcHI+ZeX9RZnsfO7
   7FwG726uHAeI76fyc+azP7hQqC+Lqm9n6fvi8dp60I0nILqgyHm6oqA6j
   03c6loq9UDeF+s7aiaiA66ujgtviBOeCsHagYdYEahtxpX0eek1Dlyhpt
   O4/TC6CqFj5DqN0RurbMGsTyeIRDmctaYPeEB4UwcvK1xyCZ2sUJY2R3F
   Hc2f+td9haulWqxtHBvxeCLgG+R4WsD7KxyYCdUshGKKaQ6ABo3x8Hvjl
   syTX6y+ul40FVztvJmj6tzIx4MHvCBIq7nFJOpzdU4DWMc1i3ZQw75B9g
   w==;
X-CSE-ConnectionGUID: 4+y3W1gvQp6AmTM6RlEOYQ==
X-CSE-MsgGUID: 5n6UPsd1SYqj85rZzI5kwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="45014282"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="45014282"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 17:04:53 -0800
X-CSE-ConnectionGUID: 9qH5Z5eXShmIrI3fb/gCdg==
X-CSE-MsgGUID: fF52HaBLTiatuaRwIeQHBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116559162"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 17:04:53 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 17:04:52 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 17:04:52 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 17:04:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YQViYgbHZHOizUmz85zwfXj3RL8QQaja6P/myOGdLdBQTOWCrhKzzvHkgeDiDh/t2B59An22aK0eZ/wdFETpyg051ZVmDPPrEv24tq0Sv45wHXSMbjbY1HWewh5IVoJ3iZvWKzCGnCc9d79Taw/0tHYCGsbb5LczIzBkM2nkTH2lHSWHPLwxB3y8kAgtaBQ8Otd2XnagF73Gn0xeDzGxeppWZSWyKeKRXz9Q16Dg8dNGZjEKB2IV5iRPk72PWpM3kx9LK0l5dOE8OdgE1uRfOclSzqeBQ4OU4VM7T09eRedmwgY88hPsFL29ynjom+fWXYUqJAYK991reBipSyDnng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQ5WWi33yrCBf8htFSY3hl8UPw/0w5yK0XDaNtfLTgw=;
 b=Fgq/tMVywV5g8+tnXBMSX75M04Lu9bFihp31Zq13UH5uafbCzxyvHFABxZQl5FIWTBQCxqo3Kjjw9Rf/LLiYQvG1Zv7nfxfr5/ksSz7yVeV/dYPhAFd1OFpejE7ceJvby4ww2MzNpEUe1WHx7V5nRthLh9OSXO2SV/lmLwWXBKlGNnm2RNprGkP2fBnJFF4Of//aW2NwFe43xJj4ikwm3hQCJuOZCHCe2k12cszSQ6LYAWdpq/dr1JntwK/AWqG/i6IY23pXDX8QAAusjHeU2gBFdLhrASDKsyX6iIYhLK7yuUNYd9G2+dqX7TNk9CncdZlxIY3fbWP1cIYNQRj30Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by MW4PR11MB6665.namprd11.prod.outlook.com (2603:10b6:303:1ec::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 01:04:06 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 01:04:05 +0000
Message-ID: <baa35632-eca7-4779-8862-b032d56f82e1@intel.com>
Date: Wed, 26 Feb 2025 09:09:29 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Add Secure ATS support
To: Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>
CC: Vasant Hegde <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <will@kernel.org>, <suravee.suthikulpanit@amd.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250225145518.GJ545008@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|MW4PR11MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: b06f1881-53cf-4ac7-f05c-08dd56017771
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WG91QVdnMGI5aDYza1pYanhud3I3emlPRk84d2VGZVlnUmhIUlJhNiszRlN3?=
 =?utf-8?B?aUpzSEMrQVVkdHgzYmFrSG5SVFoxNXZvM2crSU0zbktLTEFoTW1qVWxkUEwy?=
 =?utf-8?B?L2k5OTBOdEp1T0Jkb3lOdWQ2RENIeENodC9zYkFqMkxGSGNDazd6KzczK29H?=
 =?utf-8?B?RmpGbUU1UFFFdEhrNXkxeWZEMzBybHhycWcxT3lEajgxQUNVNmxjaGxlbXVy?=
 =?utf-8?B?Qkp4M0Zua0RHOHlSQUdYSG5DV3QyWVFLN0tmQUV2NlFrbjR3Sko1T3p4cGIy?=
 =?utf-8?B?b1Fyc0JOQlYzc0VIbnpFZnl6NGpNQWc2aldYWlJweUJNR0Ywak1ySVRDcUll?=
 =?utf-8?B?N3BjVTFubGIxd1AyUG1RT052TE9HT3FaNk5rQnFLOENUdWhUSUVNMVM4LzhF?=
 =?utf-8?B?aW15SWhYRDBVUjNyWkxYNms1TTVqa2xMa1grS0VsSG9vbUI3S1NKbit6cUk5?=
 =?utf-8?B?SCt1RWN2VmFaRHZyRTZDYVNEb3BwUm0wYzZZZjM3c21TdzZrZm45bDlVK0Fk?=
 =?utf-8?B?NTJYWjhLZndhejhFK2VQVWlHMFpOZVpSTWRlVjRGb1hlRXhLc0VSb3VqYjNT?=
 =?utf-8?B?ZEJIaVB5bVZyZUdMVXFEUko5ajJtT2VJU3Jrc1E3MytQNTZKYVdvZ2M4UzNQ?=
 =?utf-8?B?azM0R1NnM0VmZlVQNWU0M3pQOTdldkJjSnZFdUF3QTJ1N0FhcHoxejE4aVU1?=
 =?utf-8?B?YzZlMTFOUXlydUJmaEs0NDVYaTZIbS9hTGdJOXlCQ0thVDZVY1RWWVhraFVq?=
 =?utf-8?B?elBhZ3FXamVGbUgxeHBCRGZEMm40bVBNNmNBS0ViVkdnbXA0eFc1UjRvSmdm?=
 =?utf-8?B?akZIdTBRQUtYd0lON050ZjRRZmQ2anJEWmVGMHVmNEdUbXRET01oSnhVbUZk?=
 =?utf-8?B?dm5sdWNQQzlmR3JxbXZhRzN2UnlOL2hjQ3hudFpDV050ZVpNblNQamxlV3RJ?=
 =?utf-8?B?NFNqMVFaL0tKaHlna3dBRWhOU0hOVVdTSGtid0h4YklLZHduZVY3eHlKaTdl?=
 =?utf-8?B?RWg0Mk40TUxlOVVhaHRBcUpuSkRBendJQzVwSGJGNWYrTzA2WUcyRjhaTnE5?=
 =?utf-8?B?Ni9Fd0tyYzQ0Z2RiTVhXRHloQmhsQzZKNHpXWEg2UGtpYStPL0NyS214THEz?=
 =?utf-8?B?Ym1xcXVyQWd5by8vUjJPNDNCdmNNRDFyb2dEMG50aDQwT2x6cCtNNlhJL1Ro?=
 =?utf-8?B?TlVneDd6UzJ0UVAraWR2L0xaWGZiU1Y5SHl0NzJqbVZlVVQrTXFHWDFMd0hM?=
 =?utf-8?B?cWx5c2UycWI1aUJEeCsrblZaM3FIQXJiNHlLbFpQakRyeW9FZCs0bzd2Tm1H?=
 =?utf-8?B?YWZmVyt0d2dWK3FOMnVySXZ3Z1dEakZZVlNqeFI3b0FvWkFNY1Z3RHJPV3dQ?=
 =?utf-8?B?R2ZNc2lRWSs3Y3FnVitKN3l0S0RUU21admZCUXlyaTJPUTd1MUx0NVRNNTBG?=
 =?utf-8?B?VFYyc1owN1p2UU93bCtjZmJ6aDd6T21CejVaYTRkbHQrNzVITERjOTFLNERF?=
 =?utf-8?B?bmRJbmEyb2RSNjlWUTc5TWFKL0NqamJ3Z2dvTStjZVJ3cG1kRlJOWXVIRlVn?=
 =?utf-8?B?TmlkY3FnWTRZcW9UK0FZYVFhSy9vVm5jaVRIcWIxbjlGRlpTYzZMU0daQkVx?=
 =?utf-8?B?NXlGS1ExRVlKNmM5YjVZcWx3bUdkenpsV0lRNFdPdjlSeG42UUZYSXN0Z3h4?=
 =?utf-8?B?UmVITUJtWEJmL2N6TnZGV0hBRHNTY08rL1ArUXFGWnRTQWoyR1NneFBvUlhF?=
 =?utf-8?B?Wk84QmpkSHBnWEpuejVZbWNld3Uva0tZUVpRVFBOc2VTVWJYS1c4Zy9PRXBZ?=
 =?utf-8?B?VVo2WWZiNmQ4bUhFeGRYaHIvRThKOERuaFB6UFJKU0NoRjhiRzUrMFVXcHZP?=
 =?utf-8?Q?SAQ3TdxvZGDgo?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEUrN055NnFHSmN1MXV2NVgwTmQ3Sk0xY3ZPZUNrbGV3YzZ5UGtsUUVDdU5n?=
 =?utf-8?B?MElwTW5IbnBUNDg1Rkt3YkdLdGJ5UjZtM3RiOWIwR1JGclBwdXZQaTRYWnJZ?=
 =?utf-8?B?K0lNbVo3ZCs5UXZRaDJ4SWdJY0x5TzRXaUZrdnJtbEl0czVBeHNBaGtEWTk0?=
 =?utf-8?B?OXpsSmVXY00zZk5SZmV4WEJLU0d1czlxaXZzSUtJb2xCc3dwUXhjNW9Hdkg2?=
 =?utf-8?B?RysvTmlLK1BLOXhUR2w5UldXSmQrTmVzSVZHbnRnM0RNVmZDQkR0UDQrT1Bt?=
 =?utf-8?B?RnNZbUFjSm1scHU1ZWFQbDZEeTcrUjhxQTBFbTNrZ21oZXZLVUVuTGpBeUtG?=
 =?utf-8?B?WjRjOUc1QzJsRkRqQTVsMXl5dU5OY29QYzN5VFAxUDYra2JQU0IveXN0d2RQ?=
 =?utf-8?B?am9sTFpZUkp1R09mUEUweWpHVjFkYjRjaXFRZHlweTVDaENtbW5nanNielBP?=
 =?utf-8?B?Q2l3VmZEL0FYL295OE14UEhjaENFNVBuNEU5UzRMTVhuT2FiUUpaVGw0MUdj?=
 =?utf-8?B?QmMyemdWS2M1OURodE5rZ3ZLMXpGN3hoQVdaTm52V1l0VWxLME0vTm1KY3Y0?=
 =?utf-8?B?Q0ZlUXN2TktEOTl3RUY3N1E2aEdiN0srTy9iWlVvZXlWemM1NkNaVEEyeUhx?=
 =?utf-8?B?MG9zNHRRN0YrODlEb0VQODNkU09VSHdzZ1RQUk12ZVdROVZkb1I5YUE2cCtz?=
 =?utf-8?B?QXRpaDBxVDJZRGdxN1lmVWg0MFZhSXRpNmp4VDRzQ0JsVVpac1VSZGhFaUdt?=
 =?utf-8?B?QXNKb0hra0JCVk5sVnlRZUxVRmhaTHN6NEJJa0VkT2V3UnlBOHIvNnZEVkhY?=
 =?utf-8?B?MVROSG5PYzFTRVl4N0M1Z3NQOGJUUFd1OGZ5NDYyL0M5NnZMc2xnWXloNjJk?=
 =?utf-8?B?YkQ2bGNkZ2pmQmh1YzN6NTlrWkJOTmpLVEVlRDA2SUYyLzJ2N3YvQnFIVnhI?=
 =?utf-8?B?M3daN2QrUVh0OFFpMXdRd1pDdG4zLzh2Z2FhVi9kb0JWTm5MMndwUnAvK3FP?=
 =?utf-8?B?NGNzQjd1NkhlMTAzQXVDZTVBRFdQNUFTWXc3M2FIN1BNd0xIUjFmYXFrR2NJ?=
 =?utf-8?B?Q1pLeklTU0JwUTlUSHdORStsRGRpR3dZSHZzTWdxMU84dzFmVkExTWJQY0Fi?=
 =?utf-8?B?ME0rYWZ3dUR6WWFKRWRVRjlVTjQvbUhvQUNaTHpadE5CVm1lZ0xMQ0pkRnEv?=
 =?utf-8?B?c1NPcG52ckFyWFQxOFdMWlNBVGhja1dFSzdCaDZqREJuWHZhNUJrM3dGcDhZ?=
 =?utf-8?B?UVdmSXpXTjMzRDdhdWVVbEhlVzdjOVYvQzY2U2t5OEcrbE42ejFkVDVrZVJZ?=
 =?utf-8?B?YngxVHJGaGcxUE9GS0Zqc0YxN1k3MHlOZWJDcEp6YUFVRnlRVkp5THptM2ly?=
 =?utf-8?B?RldlakUxNzRWNkVpVlBTRElkRXB2SDhnMnRIVG1OWGpFMFVOeGJOZ1ZaYmNP?=
 =?utf-8?B?aVdRZktseVB3NVh4VXJzbjl6RWVyNVBTUTFYZ280L3VVWGZieWxKVSthVEVE?=
 =?utf-8?B?QXZLajNhN1JDOUd1T3c3STFKMzJWNG0xVVdKMmVacDBTTHI5Y1BYZjJkb054?=
 =?utf-8?B?aG1wOW9VN0xzdVRUTlI0QThnR25wWkdyWldqN3hjUDRHMkszNGJ4RHdRakk1?=
 =?utf-8?B?ZSswaVdBYXJxaU9EWWhmMnIzaWw0ZENsOUh3WHdDb2pTRkxQM2RBYzdDNUJa?=
 =?utf-8?B?YkFiUXRENE0xM0xaZVJ5dTVvL1RBWW1ObWY0RW1BazlLeXJKWkdBTGwyRmJp?=
 =?utf-8?B?Zk55Y3h2M2tYeXFHdmkzYnRlaFkrVVdRRE5YSlFIVHRlMkxVTk9HTlRSdWNn?=
 =?utf-8?B?TnJPcktSMUhsTnY0aHVTdkdVYklmclJwWWM4N2N0LzlqWEl1b3ZETGpLYXd6?=
 =?utf-8?B?TDR2TW5KQjlKVVBxOU02cmdUcGdPcFJtOXhkV2lpZFVkbjg1cHRhSzRaL0VL?=
 =?utf-8?B?UG9sK0xYcFRDWW9BUVIwb1ZTTlVoOFN6WVllNzZDRVVMdEF0ZUlNd0Z4VnMw?=
 =?utf-8?B?eWtXcXhJdFpPcDA4UXhDd2VDYVlWelVZTGRrbThEWEFNeWFmck9EMUNyQmdh?=
 =?utf-8?B?eVNQNTB1dkxVWjJMZXEyN0ExdUZ3RUFqSExpbkt5Wk1JZ3ArZEgwUUlPd20x?=
 =?utf-8?Q?DKc/NgQJvujVokbAOJNzkSXRf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b06f1881-53cf-4ac7-f05c-08dd56017771
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 01:04:05.8765
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nxgbvfl55dsqfEo6JMLBa6ECojTV2gExj11b6zxmTkOIveQyc47vUVwdatwPt77Gh3PmWlS0gRwaIRI+ppIsUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6665
X-OriginatorOrg: intel.com

On 2025/2/25 22:55, Jason Gunthorpe wrote:
> On Tue, Feb 25, 2025 at 01:18:43PM +0000, Robin Murphy wrote:
> 
>>> My thought is to add a flag in iommufd_hw_capabilities to report the
>>> capability, and add a flag in iommufd_hwpt_alloc_flags to let iommu driver
>>> know if HPT is needed when allocating S2 domain. Userspace attaches the
>>> un-trusted devices to the domains with HPT. While trusted devices can be
>>> attached to 'normal' S2 domains.  Will to send it out soon.:)
>>>
>>>> With Secure ATS, for ATS requests IOMMU return GPA to device instead
>>>> of SPA.
>>>
>>> I suppose AMD Secure ATS only works under nested translation configuration.
>>> is it? I guess admin may want some flexibility to opt-in it. :)
>>
>> Heh, and in SMMUv3 we have both options, with split-stage ATS for nested
>> translation, and our Device Permission Table for full ATS, so it seems like
>> there should be room for some kind of generalised capability.
> 
> Yes, lets not have another driver-only command line parameter but
> somthing global managed by the core code.
> 
> What are the options here?
>   1) Translated Address (TA) is a full physical address and IOMMU does
>      do anything (today)
> 
do you mean "do nothing"?

>   2) IOMMU converts a S1 IOVA into a TA as a S2 IOVA address and the
>      IOMMU runs it through the S2 to validate it. (ARM calls this
>      split-stage). Requires nesting
> 
>   3) TA is an IOVA and the IOMMU runs it through the full translation
>      to validate it. ATS is just used to signal non-present
> 
>   4) TA is an full physical address and the IOMMU validates the full
>      physical using some kind of permission structure (ARM calls this
>      Device Permission Table)
> 
> What are the three HWs doing?
> 
> I see #2 and #4 clearly in the SMM spec. Is #3 a special case of #2 (a
> STE with a S2 and S1DSS bypass)?
> 
> I think AMD is doing #3 from the docs.
> 
> What is Intel doing?

Intel does #4. It has a Host Permission Table which validates the
physical address.

4.2.4 Host Permission Table
The Host Permission Table (HPT) allows software to control access to the 
physical address space when
one or more devices uses translated requests. System software may create 
one or more domains
which permit memory accesses from only those ATS-devices that are accepted 
as part of the domain’s
Trusted Computing Base (TCB). HPT is only supported when operating in 
scalable mode. The HPT is a
4-level structure described in Table 11 and an example HPT Walk in Figure 
4-2. Each table entry
corresponding to a valid page size can reference one or more valid pages 
using the Page Permission
(PPi) fields as well as providing a pointer to the subsequent paging structure.

> A domain alloc flag to put the domain into #3 mode seems like a good
> start to me. The core code can decide to activate the flag for the
> default domain. Suggest starting from pci->untrusted.
> 
> Also, #3 requires PCI topology support, the ACS flags need to be set
> to route all TA's to the host. The core code should check and validate
> this before turning it on.

yes. I think both #2 and #3 need to enforce it. The TA device got is
not really a PA in the two modes.

> I think #2 can be requested through the vSTE on ARM?
> 
> Not sure how to setup #4? The core code also needs to detect coherent
> systems (ie CXL/etc) and refuse to do anything other than #1/#4..

The DPT and the HPT validates physical addresses. So such tables need to be
programmed when a physical address is mapped in I/O page table. So the
choice may be associating it with paging domain (e.g. the S2 domain that
converts GPA to PA). If so, a domain alloc flag is also a good start.

-- 
Regards,
Yi Liu
