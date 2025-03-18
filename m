Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92FF206F18
	for <iommu@lists.linux.dev>; Tue, 18 Mar 2025 10:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742292889; cv=fail; b=dKr64H457mmM3WGzS+bCm9FKJqQVjDRovUv35x+dVVQIq6tZOTFKu3xs/AU4XgsztODmaR1h0zdL/6Z2N++qZTK8rMPDAK7Wbx6XrEXPpPOgQ88X+cL7Efyk5U8/ApkoW1wROx6msrs9yn0Tkn03sYEePCHxcGJljLfJh5I/B5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742292889; c=relaxed/simple;
	bh=tkVCrBrLlnr6GdBYJLEj3c6gpuwhn1GTebO9rVOFy1I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Dczip52aDe5WyU9o4btkOUU2xDiyzTiaJ2R92d+XXYVWfeZej0t6SbALani70+s5b0P0TwMFzKwQ3bKirxdNRYtfPvmkp+P9i/QtmdPX15/73cs1DzLLNH9EW1lf70CsceBgr04YrOt8IyZgGriAzbCvDfqdK/PkrVFRI/TREbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aslauFPp; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aslauFPp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742292884; x=1773828884;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tkVCrBrLlnr6GdBYJLEj3c6gpuwhn1GTebO9rVOFy1I=;
  b=aslauFPpM13U6vSa9EpP6dphI7i++10xeB5cXWf4UmOjHsgx5MJ4z2LM
   FqX6KwmOwyzY0666j+YWlp67d+m1yFUWYKE3amXudCzxFuxSoRKaEAgEo
   qUohCdFHeYMBFjc3HUBb5ph0X49JdoEF4JVRom5CHCphwt3cQXO/A3Mvv
   XvbpBTCL3wNOubj9L5RskqzWdc7JTB0tZA21VD0P/FxewDXk6pZ6wpB3h
   us23mzSoNkh27jAaum5NQQMXooITJEoNJMVtorE7ypO3q+McKCoxfaBmt
   QLO1VUWpoaRt0cCaFSH9Ylo5w4olEbdncywQ9MxJQoXqVvpnvwuw3PG3H
   A==;
X-CSE-ConnectionGUID: SCkpklZjR1u6fU9iHyYUpg==
X-CSE-MsgGUID: gePu2MMfRC+CvUIat8uIKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="42600705"
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="42600705"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 03:14:43 -0700
X-CSE-ConnectionGUID: xHA17MBwQ/yxZZJMWlH8aQ==
X-CSE-MsgGUID: 9GHuDWX7T+S3jJE8xHcH2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,256,1736841600"; 
   d="scan'208";a="127315776"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Mar 2025 03:14:43 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 18 Mar 2025 03:14:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 18 Mar 2025 03:14:42 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 18 Mar 2025 03:14:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mZFHto67do/z68HaOSc8LPwI3RXGer4RhV2oPGlinU6cVTOb1BC1TFVOhQmQcz6rJxuaZa5MMWq4YIUKqHix4yYlsRnvupLiYkEMLfWtvZeQ+fPSw41g2kifCWLQmyGaMk5zNh2AyxbD7o5c00I3hdqf4G0ORqbon6sCZe7CMfB9lAvcSIr0Rq7kv5vGQIT7eyYauyHjrLwDYKE6z8BLc7op4t8q2/rLnDbY/WxaUmvsoUN63RzKUat1FDku/TvOCSq1DKyDAlZCKHUZZhss1V6/w1psKvhGA9xUFhu9J8jgEvidQWZClpk+A8Gvm+Mz6/vApBtCGNfgclGFj2S/AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=exlqT1H6083t/aJgdy2LVDgD+47MmwAgLO68tzOJ0Q8=;
 b=GJ6E5yQGHmAPtP6i3AqFMKIrNGjVmzkzgX/mwdKaDcN0S8pz7T771MfuTtgDXbBS7BUNkn1C6PRBjQNZTfKz/6VCDZ4P/m2WV7uwI1XwUu1P4vK8aqbmZXaUhgnhBgaSUrli8IsoGyngj+lv2+eSq7rqW0VuqZA5g5XcTgaYwlSnANC/Y6L4ahjJu2OIrncSrhbtRecYWvKSKmpR9OxJ4dzrvFKmefdV5Kf4jNPd9Wl7/ACT3WUuAUG6yEgYHKiOGynrJXLqU2f2VuCOaPtpJhpTzo4AfB2CSeaWQRwS0D01q+YTgnbIVw0NHs9gHtiRK+xZc8wn5GsO3eq9eUdn0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 10:14:40 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 10:14:38 +0000
Message-ID: <5ea99aee-0b94-4373-9c17-5d1bb6662f9b@intel.com>
Date: Tue, 18 Mar 2025 18:20:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] dmaengine: idxd: Remove unnecessary
 IOMMU_DEV_FEAT_IOPF
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, "Fenghua
 Yu" <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, Zhou Wang
	<wangzhou1@hisilicon.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
References: <20250313051953.4064532-1-baolu.lu@linux.intel.com>
 <20250313051953.4064532-6-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250313051953.4064532-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0042.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM4PR11MB6117:EE_
X-MS-Office365-Filtering-Correlation-Id: b20aee58-ea02-4f73-6ad9-08dd6605b0e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N29USG9wMTJvQXFaZlpqeTdBVDNsdWhJazdUQ0QzU1g3Z09uVHh0OWhGdm9n?=
 =?utf-8?B?Z3ZJcU5yRFJtK1FWQ0kxdFRYSnQ2ZEU0UlZXWnhrck1wd2R5cHUwc0ZaeUJy?=
 =?utf-8?B?Rk9BZzBMaUIxRnRjRGIzVk5ZcTM4NXNYYnFJRW55TGd6eThHeGoyNVhTaU9h?=
 =?utf-8?B?NjhzVGpkVzVkTU5mWnplcG15YmE2a0xXSk9objc5Vzd0S3FaVUpnVHZaWlg2?=
 =?utf-8?B?anpzNDhHZ1ZhSWx2M0txdU45dFJGSmhxNW14MnBjeUxUZHVCV0VaN2E1VnBv?=
 =?utf-8?B?cnFIV3dqdS9DbXd2NnlBYjFSNGUwdmp0ak1CVG41TlplTlhoTzRpWE04NS9V?=
 =?utf-8?B?TnNBc3AvcGR0Nk45c1RXWHMzaWhqMmttbnNxRXJrSlhYajBtaExpQ0JFZGdY?=
 =?utf-8?B?bzlzbTd1OXpHU29KdzJpVjFMak5laDYwYnlXWTUyNGRoNVo0eTBWZk1WQklN?=
 =?utf-8?B?a1kvZ05nTDFLcGVZU2RXUmUzU21SbU9LWFBJZUx3UjE3dFkrVG81RVhBY2Nw?=
 =?utf-8?B?U2p1R0FGUTJGYjVFanN6U1gzV1lPWkh1VEZpMWhvVFNXdis0VU10YjFBQUJU?=
 =?utf-8?B?bjVNRGY4K2wwRHFTYTJtLzRsMDY1N2JTZFQ4c1E2T2hUb1JmdDEwbmZvOEJO?=
 =?utf-8?B?SWRpaEJGTUhTaWlNZzR6bzNyVlBLYWJOUmpka1RkamcwVGc4ZC94VlBoWEJR?=
 =?utf-8?B?NzdibFBHOXRiQlVuK1k4Z0pOd2JUUmpUUDgycmx2YXFnSjYzR2hOZEVIOE5s?=
 =?utf-8?B?MUdYbWlTL3hJa0lCYWtsUTRlbGFYMVdvdXBhVDFDNmlVeExvc091Z2FZSXlT?=
 =?utf-8?B?eW1RNVJwb2FkTFpnbXNwTjN6dGV5Nm44SDdkeU8xcjg3UXBNMVh0bTNyS2c1?=
 =?utf-8?B?WkF5NU1mTzRnWUE1Vmw2ZGlqY0ZDUitMS1RaUGF4ellndmZlLzZIVGREcEwy?=
 =?utf-8?B?emsyZnNZeHhVbDV1b3FQekRHajlmcVdBMWpPbXg5MnQrK3J4MlR1bkNyZ2dI?=
 =?utf-8?B?RjJvcENwSXE5NXZyYTVoemRkSGVlLzlJN0VYZ0Z4ZDEzSzlWMmNJdjA4YnlV?=
 =?utf-8?B?aUd0U3BNV3RXUFJzSjhtVVgxVk9tVkozWDBNVjVud003cmxHQmh1TFhFL0pa?=
 =?utf-8?B?NHFuVW1pQWdqVXVCcmdHQnlpN3Z6YWtucDB6UUpGYzlwT3JkQTExbktET2FV?=
 =?utf-8?B?LzJJYm9YcDFZYkJscUhDUFBIWEoxb2VlVHhvL09jYVJtdGs2VkZDL0JWOUds?=
 =?utf-8?B?dk9xSGZNdXdtQTJNWFZaSEVsVTEzcHJjZVYvQkxWRzUrNVd4cWRBWVF5dzNC?=
 =?utf-8?B?SklIeFVQT3dNTW5wTzQ2UWtJdUJUdkFBeU0rUXYvWUZlWlRmL2dOYUZOajZt?=
 =?utf-8?B?SmVuVEFuNkJxTHp5WkY3MlYzVENQYXdSR3VXMWRpbUh0LzNGcVUraGgxZ1Fj?=
 =?utf-8?B?SHpvWW5jME4vMndKZHpMaUNMSTNjdlFTcEJrenVLODNocDRhS0ExS2dReHpt?=
 =?utf-8?B?dzBVY3NkMS9JSjlQOFIvemx6cVpHMStFa1QvbThxeVBOVlVkbWUxVEU1Zllk?=
 =?utf-8?B?N3JwR3g2MmpYMnhoTmdvRnQzell5alQxNUFIVExtMWRLK3BUenhsV2kxUTFL?=
 =?utf-8?B?V2RXNWRvSkZDU0ozQXRVWmlyWkdZOFRMTDQ2SkVVSS9ISU5uLzFVbzE2VHFC?=
 =?utf-8?B?S0FUUmt2TkZvUklEdEZkcVYvQ3BLcWRFdVU3VFYvb20rVFBzbFN4dk0wRXJh?=
 =?utf-8?B?UWoyM29yN2swTUhsYlUvZExBY3laUnRITGhYdmFhanFveDhoV2R1NUtKYkJv?=
 =?utf-8?B?dkcvWkh0QUczOU01dVlPelFvaXpYdTdYUjZnZ3NUY0ZsRDhqRGlaWXRzb2lF?=
 =?utf-8?Q?voOOKR1QToIvJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDhDTjBOQWZyV0FzV1lLeDVVekZ4WFVkaG1uOW1za3oyK2pSTm1nM3FUc2Qz?=
 =?utf-8?B?Q1FXbm1mN3RINXRyajBkV3FIbHhGK01LV0FqS05TdXBYclZ3UHFKbmlRZzNW?=
 =?utf-8?B?LzNGeWNNZjBwK1Mwd25zOS9IN0RyVjdYbmFuNWFOTFdJRktmdG9JWkgwdVNw?=
 =?utf-8?B?eWwyd2ZyUGxjQVBSWUt0cHc4RGViVnVZY0t6L2dvazlOYzMrSlo5aWlvSHBY?=
 =?utf-8?B?ZU1UYXppeTQzNXdDd281RW41eG9jZ0Z0bW9tOXczTHd4eGdnNGZnMnl1MEwz?=
 =?utf-8?B?Sy9UQ3I1MG5XTUx1SXdweG90UGhkbnVsQ29mRThUbkE1S3VMNEhsTDc2TjdK?=
 =?utf-8?B?NUV0TDRWRmJNWmtRVlMveXdQbHFEVDB6TFlZVnF5NnVmNk50cVNjZW5LSjdz?=
 =?utf-8?B?Y25YTml5NnB3OGhzL1d6bE93YjRJRnBUaGdQT05leWhMVXh4L1NSa3haTTZW?=
 =?utf-8?B?elZUaXRGTWZsTjhXeHR3R3FZWU9FM1pPUVBuOHFTcUF2UlRJci9PNlg1TzI1?=
 =?utf-8?B?RDE3NEdXRXRvaXZwY2duK1BXazNqS0R4UjFWYUxoazdRclc0VkJrL2JqOUtG?=
 =?utf-8?B?Mm1LaGwrUVJOQ2RCNEdQK1lmc1hwN3d2UWhKeGlJTzF3SXJKYUk5ejk1Wmo0?=
 =?utf-8?B?MjRQdGc5SlFTUTF4ckFrUk9VUEdFOW0rMXZydk43bG0rUmNZZ3M5MTdrVzBq?=
 =?utf-8?B?VGJnWjJJU1VKVUErdjcxVW83MWNudTl5NlZJaVU4a1c0cWwrdjFZMjc5Uml1?=
 =?utf-8?B?L3l2SURpNTNERDdNR1Nucm9URzc2VUVmNFhPZGZ2U2JaLy92QUYyanc1V0dP?=
 =?utf-8?B?aVJGN3lQWm1CK2FkbHhkWHlub1NsWjl6Qzh1cUhPZFQrclhZQ09zZlE2d2Rm?=
 =?utf-8?B?dWNrZ216OTltSHpvQUk5d2VmRGt0MG5kc1VCN2FkQjNYQVpPY0hucU9uRmli?=
 =?utf-8?B?RmcxM3FUNDNsTkZMQWNrRVUvTVRNakt6b2RISnZYLzlGTUIySzBocFVYYi9l?=
 =?utf-8?B?LzJWYjIrYkEzNnpJakc0L05UdUhqMTFjSUd6WEJPSUlaZmdyOEhCS3JadlRJ?=
 =?utf-8?B?b0p4MVZCc3hCMytwMER4bFVJaUp2QVZoWGUrWG5yV0tUL3RGYXZzQUdBVTJJ?=
 =?utf-8?B?ZmNqK05IblJvdndvZ25JZVFDdGxSdUo4OFdoT1M2eXlwcFFaSTU4UzJYMWNM?=
 =?utf-8?B?VVJlTW1SdEc3RFdBZ2dWL1NxaWNDTXoxaXY4SHVNWFRIZ3EvMXdzbHByTHZ4?=
 =?utf-8?B?cUY3bGFPU2h6WDUvS2svUFZpanZqYjJseS9RTUxYa2pHVURTUU5IZ2tqVGdm?=
 =?utf-8?B?NHY2RDFlbDhvSEhrRGlDSzRPek9yZUVobTR4M1RBZkhOSDlBUkMxV3U2WGJV?=
 =?utf-8?B?dTY5SWlWNFRuOThYSG9hejlrU25kYm96VXl0Q2VvV3F0S2hGQXdPN2o1OWl3?=
 =?utf-8?B?VDRSakxZb1VNeVNMWnJvTXU1U3gzSlpiNG9ocFlWaG5oTFRGVVVZdXF5ZzRU?=
 =?utf-8?B?WGg1aDd4UGRQU3gyenBxUmdJanVldllLL3RuQ2VHS1I4SnM1dlp5Sis5N2JP?=
 =?utf-8?B?dy9QS08rSEtQdS9ZcDNHN3BqQWNtdTVUemFEZjNDT1E2UmpDeEMzWU1qbUgx?=
 =?utf-8?B?dzhTTUljOEtjTTRTejhlRit5bC9iSER1SXlOeXdXL2gzWCtneEZEbmdwNUk0?=
 =?utf-8?B?V0RMNXdpbk5LaGZab1I4RWxhN3NSRys1R3VnNnEwWTUyM0R5ay9HZ2JEanZn?=
 =?utf-8?B?VmVKRDZKT0dqSGZ5endNdnpwVDFTOU9rL1NFeG4wZWFvQXZ5aytpeFpVUU5u?=
 =?utf-8?B?VzlucUJ5ZHdGL09sVFBjNEt2bmJDQWU3S3NCYnpEVmVlY1d3a2RhRjBrTmI5?=
 =?utf-8?B?d0NxVzdXNGVHWkZIenpvaStjS0F3eXVTY3JPVi85K3p0U2xXRHVZSFY4cTRl?=
 =?utf-8?B?WVhSTkZiUzFVY1l4K25KZFdVakNDTkN6QkZMWmpLWmdaYTE5WlB0QllyTUdY?=
 =?utf-8?B?ZUhtLytNM0NqZmtqU0cyQlhtaEdiZDVkTi81dVFPelJHUGplVlVzUjhrK0or?=
 =?utf-8?B?RytPa3Y2aDJQTm1UMWJXb0NnZmczY3ZwRHZIZUlQT240NTZ1SytWV01qVG1v?=
 =?utf-8?Q?R8kxGRsnd7GPNG0spG3sL32ST?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b20aee58-ea02-4f73-6ad9-08dd6605b0e5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 10:14:38.6199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uuleknp7O6vQj6xiJ1gv3sgEVntqq0T3eV3wIiH5WbgksJ9ZEbMPwtGjGJLj6c5WDb0Tmhfpy80LMRfSkRrrBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6117
X-OriginatorOrg: intel.com

On 2025/3/13 13:19, Lu Baolu wrote:
> The IOMMU_DEV_FEAT_IOPF implementation in the iommu driver is just a no-op.
> It will also be removed from the iommu driver in the subsequent patch.
> Remove it to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Acked-by: Vinod Koul <vkoul@kernel.org>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Fenghua Yu <fenghuay@nvidia.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>   drivers/dma/idxd/init.c | 37 ++++++-------------------------------
>   1 file changed, 6 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/dma/idxd/init.c b/drivers/dma/idxd/init.c
> index 1e5038cca22c..d44944195807 100644
> --- a/drivers/dma/idxd/init.c
> +++ b/drivers/dma/idxd/init.c
> @@ -626,21 +626,6 @@ static void idxd_disable_system_pasid(struct idxd_device *idxd)
>   	idxd->pasid = IOMMU_PASID_INVALID;
>   }
>   
> -static int idxd_enable_sva(struct pci_dev *pdev)
> -{
> -	int ret;
> -
> -	ret = iommu_dev_enable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
> -	if (ret)
> -		return ret;
> -	return 0;
> -}
> -
> -static void idxd_disable_sva(struct pci_dev *pdev)
> -{
> -	iommu_dev_disable_feature(&pdev->dev, IOMMU_DEV_FEAT_IOPF);
> -}
> -
>   static int idxd_probe(struct idxd_device *idxd)
>   {
>   	struct pci_dev *pdev = idxd->pdev;
> @@ -655,17 +640,13 @@ static int idxd_probe(struct idxd_device *idxd)
>   	dev_dbg(dev, "IDXD reset complete\n");
>   
>   	if (IS_ENABLED(CONFIG_INTEL_IDXD_SVM) && sva) {
> -		if (idxd_enable_sva(pdev)) {
> -			dev_warn(dev, "Unable to turn on user SVA feature.\n");
> -		} else {
> -			set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);
> +		set_bit(IDXD_FLAG_USER_PASID_ENABLED, &idxd->flags);

a nit. The IDXD_FLAG_USER_PASID_ENABLED becomes almost equivalent to the
sva option. Is it ok?

This patch itself LGTM.

Reviewed-by: Yi Liu <yi.l.liu@intel.com>

-- 
Regards,
Yi Liu
