Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2CC4C7C
	for <iommu@lists.linux.dev>; Fri,  1 Nov 2024 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730429266; cv=fail; b=K6QtX8ylBxFVv0EopP0/5DxMJj4sIaTL1N8+zjsMJd+7Z/KO1h+Uq2kWTtfgO6re1VEg6vKCSqlaP7LZ1R72ZTjG7oJilb9oyNtI8NEFiuO4uF5/mj8jdMZFd9nP1BhFFbWCk7OzGLrJ/YdBah5m+ISYOVzXM3wmyxvIai7K9WI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730429266; c=relaxed/simple;
	bh=OLYyuBtm0Cr3aWy99CKEi99pMsKz5dkn5X2Lcp2WquI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U9XsL2Ecl2fEksT2grftK9S2FBZdw5EIj5/Cgp1sJfgPUvvI6TCq8eyVnl21N+7GQqM0STqGL9NiKBkqXTCoxg9ZYTMj0fWpWnafU0QJ7B9jRs3ui2/FpqRMKZCyXY/Go4+eLFybkcj3RceQ5ppKrerzAga9eG+91CiJDGavd4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h9IR7uMX; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h9IR7uMX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730429260; x=1761965260;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OLYyuBtm0Cr3aWy99CKEi99pMsKz5dkn5X2Lcp2WquI=;
  b=h9IR7uMXWdIFjsqXTqmuF+ZUWaEifb3FzafMrVUIemPpog1twbO6N0iE
   VM5bCAItrVGTL1PSPKmeiumX5Sw2BjMhC3x6qJ/XiX+4tfwRJainEQwvy
   5BjuIP1pSZzX5Fl6WbUIDyUX0R/glUM0TnJctDjaG0XsY3qm0assOWh3C
   BvqNpgN4aQfvUE0ACyOiDKBDDGefAxmBA5AjJxrejJKSZ/de+PHvZQ6/N
   /aMdInIuNATpusCnDa2L9vgsB4qUGZCW3DvIA3NozHCyt7k2zjbIBER/Z
   7fHSP2H3rng+C9jTuN8NBoDW08TU3lsJ0sIobgadmVj6FZwS6Boo1M6dk
   Q==;
X-CSE-ConnectionGUID: rKsSFKaETtywERQ9zOAApQ==
X-CSE-MsgGUID: 6qQXAy0ZSl22XANUGtcFHw==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="33881240"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="33881240"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 19:47:40 -0700
X-CSE-ConnectionGUID: pugXYN1yTnywJgLKjuFsGg==
X-CSE-MsgGUID: W11680hST/uSjbGFsdeSjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,248,1725346800"; 
   d="scan'208";a="113672249"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Oct 2024 19:47:39 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 31 Oct 2024 19:47:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 31 Oct 2024 19:47:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 31 Oct 2024 19:47:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQHzteUT9yD/UHL4ErBCpEQqTMIklp3RwAh/yH0S8AAN/1s5kU0WJyoyGMK/RxKFk4XdbAvVn/1/yDw+deAhei0zJBJhKkGxaFuN3376+/RD/yAfJe+Rs+a9YA8gFtjWWwc+BwdqLuucTFFdYjPoNLzI/eqw4s3o2n0r3ClarCXBUk+xcPF/1tTDhCdLYSz/xHN4I0XFU5CCHzJhz22RMHdCs6cHbSyXLdjTYW/JuX+eiHurYBj+YUmVFCZWlAYdobaD9j75yWXlAGVIKP+iLDQWw4TF6P2kOORX1Dkvv0G9U//hPqz19txSRZcTfVOFqDnL3dZ34sbcbnrPl6hrQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OXu7GGp+BBi/t2EhmC9OxEYf3PMcjGyP9ObYsV+1IVc=;
 b=fOlFQlLc0EEQx2z5csqCJKn7fVn9VN48fljaEPwxN+JfbqqqL68jjh9LbZc7FfgVEoVeet9osSz0/Q5pOTbXm7boSPFSM7JYOoovvVb/1vXpYTRKhCRgx70GGgOWJIkLY9r14dp2QhCi9YxlKmRh4zJkA0oGgrvLxNUovhRtg8MHU01kU1yTuMzhB0QMSd4cvTWrJy1f/7wYBO2zWT0rPiTLlJAm31HfRTBpS+J4oorZ5X3Oc0IyXBLMVFlsl23X8HZGnrf5e0joEqXTYa3PWb/4xTe8S70PdKrR1euLSwHTHZr4Paxej5iOb+e3ULw4rOdwASFKOeu2eYNGOGPiSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7629.namprd11.prod.outlook.com (2603:10b6:8:146::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 02:47:35 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 02:47:35 +0000
Message-ID: <97e78485-5eb2-44cb-ab33-4f8a8488b428@intel.com>
Date: Fri, 1 Nov 2024 10:52:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/vt-d: Drain PRQs when domain removed from RID
To: Lu Baolu <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Joel Granados <joel.granados@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>,
	<linux-kernel@vger.kernel.org>
References: <20241031095139.44220-1-baolu.lu@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241031095139.44220-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:4:188::23) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 43995ee5-ef5c-41aa-ed66-08dcfa1f8a5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VGR2T2tuL0VieGpHbWRTaDF5UkFtZUlGSHdHWU83ZHVZMGpDOG9OREJnK1dr?=
 =?utf-8?B?TWpGcUNtZTlqRVJJZ2FhZTQvY0gveWVFQXpDQk9IbUR6S1Fubk1EKzAya1oy?=
 =?utf-8?B?OTdHL1g0ZVlUZGRIb3dkUDAzV2Ryam9vRmFVSEZEQXQ0NjBIdlFWTEhxTnpR?=
 =?utf-8?B?cFFMSnZZYXZmNTN3Y0xNOXJZcm04c0JkRXBBSWtFNW5zWDI2UlZ6SGhLUS94?=
 =?utf-8?B?L0QrUkdTeUxQZHMyQXM1MVFKdDJVMnRiRFJxRnVKcHRtdzVyd1pFNk9QYlZU?=
 =?utf-8?B?QlJtNmRPaGwweWRYVU5YQjRmWllEb2toRmxwdzBKcGdXNGkzNENCNlJEY2Qz?=
 =?utf-8?B?K1lydXpwcWFkSzN6UmNVU2o5Q2NyUTVJWERkWWFsLzk5dHBwNUdhc2lHRXNX?=
 =?utf-8?B?RTg1a0VUaDhSM1FvblZJcjBQbDV3cktxVXZwR0Q3cjRyYWs4RmYzWG1JKzI3?=
 =?utf-8?B?YWhoVlRoNHNCKzdZK0NNdW9kb0JEZHRRRi9WL3B0RU94NlZUeWlUZ1l3OHZL?=
 =?utf-8?B?Z1E3emJzWEh3YmpxU01mRTA3SzNidDZDWXRncU5uYzh0K3RJYUxWMXNFWVg0?=
 =?utf-8?B?OXRoUERObW92V3E4Tm1UeGFZM0x5OHhtTFZucmJPd1pWbE1janRlZTlQaE1D?=
 =?utf-8?B?VVVleHdrRlBUaWczNUJaTUdlMWFYeDVSKzZiTXdBdUJsbFFnTy9VOHRCQUhh?=
 =?utf-8?B?VUFHZEluM1FRSllTWFpSZmdhdVFIam9vRG1YUGdidklnWDlwMVZ4MkNKcFNG?=
 =?utf-8?B?REMxaWlTRkpqalRNQjA2ZU94N2ZNY2RldU1qbDhPak9ya050VDYrOCt1QUxT?=
 =?utf-8?B?ckc3YzRpdnJTcXhQUUFGM2hnVk53aUNoUUlxM05rYjNLMmFJVC9qTVB6MS9H?=
 =?utf-8?B?Y3V1dkNZYng0NXVBek9qQmkwZjRnaVZhNmZhY0V2eDNOOW1VNHRaU0llQzQw?=
 =?utf-8?B?REZZcDJqM1AyWSt2MVRXSEtTTE5nWGhod2NvRGhuekR3UlJ3WkE3bXVraVRh?=
 =?utf-8?B?YjJUZytjMlQ2RzRxaWNFTWNhSDFTenl1Ti9vMG1MYUxwYTdzbU9zaHRSZUdj?=
 =?utf-8?B?cVhGQk51NUxWQnF5UWVnblMwSUJ5ZytWdTZVM2NZSFZva1JBYkVzdEt4dDV4?=
 =?utf-8?B?Qm8zb2ZDWEpoTWk4YjNONVJVanFFcHlwWGdkTy93TVVHZHNGOWkxYks0M3NS?=
 =?utf-8?B?UFR5Y3NkSFBHY2pMbWlPRVVLN09ZT0Jjb2lvRHZQVG9HYnZWcEhMWk5Nc2hY?=
 =?utf-8?B?bS9TK09LS0dZSHk1S0pFMVpqVnBLOXBmeGcvMnQ5eHRKakdWZ1ZsVUYxQnNK?=
 =?utf-8?B?aHB1YlRPaEYzOVR6dFNTVW1XQVpSWUg0MlVEeXNJeXphZmR1a0ltbnZsQUlv?=
 =?utf-8?B?UitWeXRTL3VIb2lveUZ3YUg3ZHkxUHdFOVZ2MzAvTlBMNUtDMytWR2dteW5i?=
 =?utf-8?B?VWQwTGhlOGZ4ck0xMWNaVEhnR0xrZUlUY0psd2psaVJ2Q0FSNGdvYTlMQSt2?=
 =?utf-8?B?RVl4d3dzN2twaTI1MzdUdEFTT0M1WmFNZkNuU1VwRnZIRUdWa0xYUi9DeWJB?=
 =?utf-8?B?VzZaV3hxa0NzbloxSXIvRTlaZTZhL29GNTFlRTFsczRMU09iSFZ0d0d1MVNU?=
 =?utf-8?B?MnFFaGxaTEpqSzRES2RxLzNhWUxhVUxQTWxjMTJTTHVQWDhrUFkwamNoWUli?=
 =?utf-8?B?WEk0Tkx0Ykh4M0xvaEdDaXpwNURMWG80eGxoTXcrNjBoazEzSm1JU1p5QzJT?=
 =?utf-8?Q?RUNS9DfvA3k2dx41xjTZUBeei6iOj1SUQHzxogI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?REM1THRYRmNTK1JtaDRIajZlM3ZNcWd2UXArQ0xBWitMdUZtSGlUWjlLTno0?=
 =?utf-8?B?RVFMUlJ1clNUT05yQkdiekxuVEYrSFN6UyttT01xSDRpa3YxY3RmQzlNQ0dj?=
 =?utf-8?B?Mm5iLytFSlJidi9CcE5FZm5vUFhObmZUVW5UUCtDa0VPMXR5R2ZMQmdudjVD?=
 =?utf-8?B?Q1R3QVV6SGZpTndJSkx2NTdheDR5SmdjTEtBdTBESkNGeXQ5TVNBVElibmdG?=
 =?utf-8?B?d3kzL2ZlSm1UeGN3RzdwUUsrc2p4K1hPRE03eExkM0NrMVdoVkV1RTkzelpx?=
 =?utf-8?B?cmdUZEhZRDQ1c1R6OG1DN3prZEpUd1ZqN2F0bXgxclR1dUhXYmZiOUl4djR1?=
 =?utf-8?B?NEdway9yc08vNWpEOW56MnFvVEhaZ1pURjV3VWx1SmZSd0gzdHc0TlBYSnJr?=
 =?utf-8?B?TW5LSFBIYzMxVm5jODNxd3BMQmZLRzd3VGE0M0RDdmRoTTk1S2NucUo0OUkr?=
 =?utf-8?B?MXorY1p3MkhaYVorSGtlb2NiVVIyZEZ6bjl5T3dlZ0VCUStIMzBVT25ocVJ6?=
 =?utf-8?B?Q0l3N09NenpzMEQva1c1aHRiTXJiVkdtV01LQ093aE5samNPaTFLN2dHZ3M5?=
 =?utf-8?B?SEpMN3ZQeVo4U29ock5Nc3UwWUtLWnhuOEZLcU9zR25rcGIwK3g2N2RGQXJz?=
 =?utf-8?B?eFkzZXZDaWpCcWJlVWVMU3drMmJmb0RzZ1MzUit2cmJVd3VMeWRkM29lQ2JC?=
 =?utf-8?B?aXE1bHZsMjZFZmRLYWUxQmp3dE9HWXN3SFQxYVVCbVlDTkFMUy82Zy8yYTZy?=
 =?utf-8?B?dERYKytOemxhL2dITVRNajYwTlAvVnZQQmJLL1FkVzBaVUgrOHFPbXYxeXBM?=
 =?utf-8?B?QVRXV3UvWHJxUTBMNjM1VmphajNJcmlvL0NIUkt1N055MklVRlNkL1RPQ2I3?=
 =?utf-8?B?YWg2bXRIb0dTcnhGWXlJaCtHdFFRQ3B4T0g4QWVzL2xGZFRtU0J0TGV1bFlQ?=
 =?utf-8?B?blVNL0lNZkQ2b3JlUi8xU2lVL1Znc0xITTJqaE9VMjdEZXROQU1YODlwaUhn?=
 =?utf-8?B?MXVOSmNiRjhSTG41VmtLdnpIYlVlS1RxcURiUG51V2xQRnpNMEY0OVNvSGU2?=
 =?utf-8?B?c1BDTmNIeTlGWWxJQ2duM09rMkpLRkhvVXZtUDA1NURSUjI0TlVUcERoODdI?=
 =?utf-8?B?UERxUXdTb0xtb01HckpuZzdVZW4xNkJvSE9pNWUyemVMcW9UYmNkWXBOZlFS?=
 =?utf-8?B?REVLK0d3T3gxSTdTRldrVGZXWFU3VlRuT2dEVms0OUVoaHNPSUtDVkwvU3A1?=
 =?utf-8?B?Y20zTFY4UXFxczFQZEk4YWtJQVJqNDVrL3V5V1J5TGR1Nm8wcUJldzNtK3pO?=
 =?utf-8?B?emc5blhOYzBOT2tNOGFNWnA2anNZRUNlSzlWM2JtUnR1T3VNakd5Z2JORkN1?=
 =?utf-8?B?YWRpQzVMWlFLRmh6ckxNZlNNOC80a1dxV2tucU1sVldzSGFTYUlwMjlYcnBy?=
 =?utf-8?B?M0tlcDlVZGFGMmplNGs1WG9qeDJENmxHYk1Ha2diUkpCbjNpWkRYREFiVTVK?=
 =?utf-8?B?RTZId2g5aDQzbUN2YWdKWjcvUk1nVHhwSzR0T1dteHpZR0ZEWC9VOXkraExx?=
 =?utf-8?B?Ukw1OE9iekdvODdZVjJpaDR4WlhtS3BXUzlVY3grUjkraWRkSDI5M0RuVDFh?=
 =?utf-8?B?U2NEb2VQQnVpNUlReTRWMzExRkZCUEJDa3F1Mnk2bmc1ODNBbzcvUjZNTG0w?=
 =?utf-8?B?WEx4UC82a1lGUEhlemF2MlhoUFRWV09JMjc1NHhlYiszc0RWWGcxU2tlUll4?=
 =?utf-8?B?SnNCSXVTQjZ5SGl1MFhnK3hrVUtvQm03bE5EOUVyc2FGTmJwZ2ZKdi84cmI3?=
 =?utf-8?B?MWx0U1hIUnNVdU55WDQzNDdDMlR3ZCtmZ2x4MEdnU1NJODQ3UjN0Rk5ZN2l6?=
 =?utf-8?B?LzRkVmZYcndSNEI1NGt3YVRCT2hwN0RFenU4U2pEU0NMVzlOVCtteGtmQm1m?=
 =?utf-8?B?YklwNnREcjEvQXBubTdqSk0xckEwNWhNdTlYYVlCZmxrWkdsVXdQeTBtUlpj?=
 =?utf-8?B?Y3phODBzUnBoallGT3JCaldlTEM3ZUc3R1gvemVZU3VpakxlajZjN2ZPMVVS?=
 =?utf-8?B?cktiQk1qNko2Ykh6Smo1YTNyamtxalN6VlJmV25lRG02cEo3ZGRZcFNZT2lE?=
 =?utf-8?Q?yyMIBqv/PoKzpG4QIglK75ZmU?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 43995ee5-ef5c-41aa-ed66-08dcfa1f8a5b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 02:47:35.5681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVxkgm9JD8+h8MMsAt10LXgyznFtlfkynZqPAjisPtIKlncKb2gr/sHUVW+4PCGHSTQZKOBbKOZwlkYwyyO5TA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7629
X-OriginatorOrg: intel.com

On 2024/10/31 17:51, Lu Baolu wrote:
> As this iommu driver now supports page faults for requests without
> PASID, page requests should be drained when a domain is removed from
> the RID2PASID entry.
> 
> This results in the intel_iommu_drain_pasid_prq() call being moved to
> intel_pasid_tear_down_entry(). This indicates that when a translation
> is removed from any PASID entry and the PRI has been enabled on the
> device, page requests are flushed in the domain detachment path.

s/flushed/drained/. 'drained' might suit the spec more than 'flushed'.

Per this change, the callers of the intel_pasid_tear_down_entry() will
get a mandatory PRQ drain. I think this makes sense. But most of the
callers do not follow a prq drain in the before. Will it introduce
regression (especially performance regression)?

> 
> The intel_iommu_drain_pasid_prq() helper has been modified to support
> sending device TLB invalidation requests for both PASID and non-PASID
> cases.

would it be better to rename it to be intel_iommu_drain_prq()? Also, it
makes much sense to separate the PRQ related code into a prq.c. :) It
might be done later though.

> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>   drivers/iommu/intel/iommu.c |  1 -
>   drivers/iommu/intel/pasid.c |  1 +
>   drivers/iommu/intel/prq.c   | 22 +++++++---------------
>   3 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 87a3563dfe54..3878f35be09d 100644
> --- a/drivers/iommu/intel/iommu.c
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4069,7 +4069,6 @@ static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid,
>   	intel_iommu_debugfs_remove_dev_pasid(dev_pasid);
>   	kfree(dev_pasid);
>   	intel_pasid_tear_down_entry(iommu, dev, pasid, false);
> -	intel_iommu_drain_pasid_prq(dev, pasid);
>   }
>   
>   static int intel_iommu_set_dev_pasid(struct iommu_domain *domain,
> diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
> index 7e76062a7ad2..31665fb62e1c 100644
> --- a/drivers/iommu/intel/pasid.c
> +++ b/drivers/iommu/intel/pasid.c
> @@ -265,6 +265,7 @@ void intel_pasid_tear_down_entry(struct intel_iommu *iommu, struct device *dev,
>   		iommu->flush.flush_iotlb(iommu, did, 0, 0, DMA_TLB_DSI_FLUSH);
>   
>   	devtlb_invalidation_with_pasid(iommu, dev, pasid);
> +	intel_iommu_drain_pasid_prq(dev, pasid);
>   }
>   
>   /*
> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
> index 3c50c848893f..ae7f6f34462f 100644
> --- a/drivers/iommu/intel/prq.c
> +++ b/drivers/iommu/intel/prq.c
> @@ -66,12 +66,8 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
>   	struct pci_dev *pdev;
>   	int head, tail;
>   	u16 sid, did;
> -	int qdep;
>   
>   	info = dev_iommu_priv_get(dev);
> -	if (WARN_ON(!info || !dev_is_pci(dev)))
> -		return;
> -
>   	if (!info->pri_enabled)
>   		return;
>   
> @@ -81,8 +77,6 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
>   	sid = PCI_DEVID(info->bus, info->devfn);
>   	did = domain ? domain_id_iommu(domain, iommu) : FLPT_DEFAULT_DID;
>   
> -	qdep = pci_ats_queue_depth(pdev);
> -
>   	/*
>   	 * Check and wait until all pending page requests in the queue are
>   	 * handled by the prq handling thread.
> @@ -114,15 +108,13 @@ void intel_iommu_drain_pasid_prq(struct device *dev, u32 pasid)
>   	desc[0].qw0 = QI_IWD_STATUS_DATA(QI_DONE) |
>   			QI_IWD_FENCE |
>   			QI_IWD_TYPE;
> -	desc[1].qw0 = QI_EIOTLB_PASID(pasid) |
> -			QI_EIOTLB_DID(did) |
> -			QI_EIOTLB_GRAN(QI_GRAN_NONG_PASID) |
> -			QI_EIOTLB_TYPE;
> -	desc[2].qw0 = QI_DEV_EIOTLB_PASID(pasid) |
> -			QI_DEV_EIOTLB_SID(sid) |
> -			QI_DEV_EIOTLB_QDEP(qdep) |
> -			QI_DEIOTLB_TYPE |
> -			QI_DEV_IOTLB_PFSID(info->pfsid);
> +	qi_desc_piotlb(did, pasid, 0, -1, 0, &desc[1]);

Does it make more sense to submit iotlb desc when @pasid == IOMMU_NO_PASID
just like you've done to the devtlb desc? Spec looks to be unclear on this
part, but it sounds reasonable to use iotlb desc for the
@pasid == IOMMU_NO_PASID case.

> +	if (pasid == IOMMU_NO_PASID)
> +		qi_desc_dev_iotlb(sid, info->pfsid, info->ats_qdep, 0,
> +				  MAX_AGAW_PFN_WIDTH, &desc[2]);
> +	else
> +		qi_desc_dev_iotlb_pasid(sid, info->pfsid, pasid, info->ats_qdep,
> +					0, MAX_AGAW_PFN_WIDTH, &desc[2]);

I noticed devtlb_invalidation_with_pasid() passes '64 - VTD_PAGE_SHIFT'
which is equal to MAX_AGAW_PFN_WIDTH. Might be good to consolidate it. :)

>   qi_retry:
>   	reinit_completion(&iommu->prq_complete);
>   	qi_submit_sync(iommu, desc, 3, QI_OPT_WAIT_DRAIN);

-- 
Regards,
Yi Liu
