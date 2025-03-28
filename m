Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1661A08B5
	for <iommu@lists.linux.dev>; Fri, 28 Mar 2025 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743147724; cv=fail; b=LDRSdW/0UsNY3/mc2ewKRzPCVO+8PNk+SlErB0U3JacHKO9jffhSMgm6Ahm5wK1KHvvP2rafbitZWL+xbiG21MtNKXhprX1Lmn4Cw1SiDd/BnOt57m6UFdP8Z9iE/nmsUW7JzqoPAr/x0OeB7mYsne/rdaJRLSmV47b41lx5kIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743147724; c=relaxed/simple;
	bh=41jSIwrfyQxre4lNEwyyzK8YI7IkRGQryyF/LqnxSLo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IADemjAH0xALeIVUNRjnlfNFX5hQBhqBSgssGTJvS5p2shdUAHJG8MrOWlrZqB7NmMFrhI86alNp4dCM+BGj2QBpgCOT+FOWn8MRYGoE31S+a6Mn/dJn1ZaZz78557Od880lgnfQQAD7O0NPBVyko+br57M43VIAKjdauhZR9s8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cUwr6B/W; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cUwr6B/W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743147722; x=1774683722;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=41jSIwrfyQxre4lNEwyyzK8YI7IkRGQryyF/LqnxSLo=;
  b=cUwr6B/Wm0FLutzkEgSouox20e3gfbRSTvqDGamX0+jCtYdk2ejQaVvY
   POW6K5xaXkagjddqXx3BY7dPxgxneG9nrYj72y1sehK/QbUjpxbO9fAB1
   Dly3CEdW2H2tl7ehLsIBEujq7x56g8h0DDJ2YgWvZm8Juxz6nbhG9GyFz
   W69gjlvWcHnm0xKJZMmOcdLtQPkzqIEDuWfrTjVOvLHgrdvsmY1DFFq4k
   AQkxUOlyx1/1u3VO4oz4WY54G6JJ6xcbILjDdxemlkdmrmtlyAv8P6Rwb
   3Kggst+mCVyaK44CibICxbGN8aYCpLOD9775Pwf0BECerkH9lSsz0IFsc
   Q==;
X-CSE-ConnectionGUID: 0kSqogf/RfmYnndMLyohzQ==
X-CSE-MsgGUID: kncRmvGtSY2f7FCpc3QypA==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="55870549"
X-IronPort-AV: E=Sophos;i="6.14,282,1736841600"; 
   d="scan'208";a="55870549"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 00:42:02 -0700
X-CSE-ConnectionGUID: pOv9/YRhR1qdtIkAxzrnfw==
X-CSE-MsgGUID: a43n3hfZRj2+8QzDlyl5YA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,282,1736841600"; 
   d="scan'208";a="125601893"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 00:42:01 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 28 Mar 2025 00:42:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 28 Mar 2025 00:42:00 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 28 Mar 2025 00:42:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSWhLF2uTlkw21a5gJyHJT2RyXVaaw+wbSyIVQ5sizSYZP67zq0sxNsuLF0+qb8ttUf6/l2ibHC3fqOagBlweA/yVhHWWx0c2l9vOgsQuREG7dT3ZD7zNdqCaHCM63ElfhKHNbGP/ZppSdx+GLBk1iQ86BoJUDu5enGtSr0Io35q4mijIv6BfcA7OhK/Pnns/vddj75+5ujdMIMqa1bHIfOLjAssMkW2EqnteGo+VfYyCMNeb3k3uE7FaANtgeLHwxw4KpgaGIDMLPsOkMJam8BgVRJVlE6HnPMLfTK7vZefcMOPBIYl1kD4w11JoqFHMToLkqURLtbC0NfUEEwlyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x9sE/AdD5w0L1FQ/0+q6OCxo5hc4U+kgmdrUfzhqo7w=;
 b=YAm9xdEZXsyk+r2iwDE7c2EYqQvdpyLc2JqMFveFkC5up12FPVuwraCy5tyVdLB3st669Ofst+RXJgBBmWl0rOgDIhUD46B/AfEYUA0VWEEgIb04jvtv3xJTKGYYiiVLWhktH0Wo/R94R+22p8Vya/KF/J0S8VbQiPRCggl8cKIyOBAFOp1Xu1Uz/9adLO0b9r9eOYkpfcoN42lWeKjDp+x9y80pZylokGcKJlmJgpbuIiuIY9gIXpiScT4K18oYtnUaTsNKfNqiQFr+WmAkDOETfJpzONrUGeUOdPObZecmMc8WIi9IRG0jZD5W1JVc0Wpb4pH7/FfZpW5QQAXB4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by IA3PR11MB9134.namprd11.prod.outlook.com (2603:10b6:208:573::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 07:41:53 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.048; Fri, 28 Mar 2025
 07:41:53 +0000
Message-ID: <ccdbc43a-500e-40f6-96aa-f7f33b327995@intel.com>
Date: Fri, 28 Mar 2025 15:47:21 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 17/18] iommufd/selftest: Add test ops to test pasid
 attach/detach
To: "Lai, Yi" <yi1.lai@linux.intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>, <nicolinc@nvidia.com>,
	<yi1.lai@intel.com>
References: <20250321171940.7213-1-yi.l.liu@intel.com>
 <20250321171940.7213-18-yi.l.liu@intel.com> <Z+X0tzxhiaupJT7b@ly-workstation>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <Z+X0tzxhiaupJT7b@ly-workstation>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0134.apcprd02.prod.outlook.com
 (2603:1096:4:188::14) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|IA3PR11MB9134:EE_
X-MS-Office365-Filtering-Correlation-Id: 94c37f8e-1b83-4c13-c5d4-08dd6dcc0194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eGNWK09CQUUwU3orR0RDNm1uemREckNieTFhV0hIY1U4UzFWSzFueGJOK2pP?=
 =?utf-8?B?M09EV3laR2JjTTA2UklRZVAxUEtKTFQ1WitjOFNWb1ZrQnBzdVhyU2VVVm5s?=
 =?utf-8?B?UHhncjN5bFhIUmM2TFdKZjFDaVVsZkhzd0ZKU01LM2tSMm9acHZsUE15NXlm?=
 =?utf-8?B?K3RXTTBjRWttbnVCdHZTU1ZMNEJROVhsZ05GalpXdTBjVWNoTitzRi9xTnJl?=
 =?utf-8?B?NXNBRmhYQzgyWktSQUZMNDFYZkhJTkplcWxTa1JHTDZrN0NtT0lxWEdCV1RX?=
 =?utf-8?B?ZGNNZk9tRlRCZTZpNGN3aUtlaDJ5YzZxRDQrUVFFVWhyamF5akJJK1pwNGs0?=
 =?utf-8?B?bmhjQXFRUTBqQ1RwVGRmaVduSW9OUFRiclVLUlNXdm1VcjhMaFlEQTVGS1Jx?=
 =?utf-8?B?MnNwb0FwbGNNdnNuazIxakdxV0lUQ200eldFRDBrd1pvRkJaUGIzYmhxS1h3?=
 =?utf-8?B?RlpVdVBFMDEvRmVZb0ZZNm1BeWJVbnlPU2JybXBIMmhaRVJMcDF1aGRoLzZ0?=
 =?utf-8?B?THV0TUtJT3JuUWdVWlAwNVRpT3VUS1pqbnpMYTVuRk9FWnV2OHl5UGtOTi9y?=
 =?utf-8?B?SWJ1THhKejhUS3FyVHFMUDEyN3FDc1djeGdJVE9vK0Faa1VMZ3lPZVJvellE?=
 =?utf-8?B?VDVFMzFta21YREoySHlsT0Jnd0JHRkg3azVXVGRPWE5OekJIcEE0UHA4SnIx?=
 =?utf-8?B?cWJ2VE9XbGpGRUFXU3VROW1ENkg0UHlRdjdsbncvbytGQ3FGYVZ0WjYwNXRo?=
 =?utf-8?B?QVJmSnNTMXcrOXFBdlMyMGxydlpndFVFaXI3ckRsdDljS3Bmc0t1NWwrUUJz?=
 =?utf-8?B?OXdPMjRIb0NIZGhWNUl2RHVzdUxiNzVJdFg5bHp5LzVtY2xoV1RBeEZSQWRZ?=
 =?utf-8?B?K24yak5ZOW0xTXZlKzJ2REhEVXZEUUlqS0dxQ0MyaG9nS1pjQm16SzZqUm90?=
 =?utf-8?B?bHBmS2hQNGNtK0p1K1VYeCtnTlFQa0FBdHJKMEJYdUZBUHhRSFdyOUZraFpG?=
 =?utf-8?B?V2xEY3RtU0ZjYjBzQjFiZzNCZFhITlJHNDIzQ3hNYWdnMW5yQWlUWm8rQytP?=
 =?utf-8?B?Y3JzNkNPTHZrOEUrZDBnS3ZlSmtSOFIrbUJNQXNQR085M2dLd1E2eWJUdGVy?=
 =?utf-8?B?RHpVQXYxMzJURndhVktiVWpVTWdoOUU0cmkxOHVVdzQ2VVJrTHJhbUllVlNI?=
 =?utf-8?B?V1B5bXVJdVBIaCtZRG0ycnMrOXZtdjBxeldXbGQ0dCs3YlJSbVFrZlNPQmdU?=
 =?utf-8?B?SW82SWFjc0hnbFRsY1RuVFh5U084UWxSQ002MWV3TkNTZCsrelkxWVlpaXdI?=
 =?utf-8?B?L3VEV3ZjOERrREtkdFR2V0NxTW9LazJheUpLcVoxbTBwdGZXSm5TVFdHM1g1?=
 =?utf-8?B?QUwwSnF6MjBMYS9XWm4rT1UrQXVIeURsVnZIWDE4UDBnT3VhS3ZmaGJKL0FJ?=
 =?utf-8?B?eWRIN0psdHQ5Umk3eEc1LzVtcUovWk92OE41RWZEcjJGVEFDSU1CKzFXTTQx?=
 =?utf-8?B?VmxqZ1Y0clZtUVMwY1BjZGZyRlc0VWxySEdpcE5iNTNRR0E1MVNXVW1TaG95?=
 =?utf-8?B?QzJoc0dsQWg4UHljR0pkczEvTUk4Vms1eGlidnpNMnBsd01BYlEvcXlYNkpv?=
 =?utf-8?B?bnlNQVJMNjJrQU5NeitTdTZjK0E3WkhkSVFzMGs3Zk5ZUWl5SlV0MDFBZW9B?=
 =?utf-8?B?T3ZYRlo4U284UlVEZlBiZjUyeG1JdkloWklzVjRYc0puN3JDSjk2NDJ6ZnJB?=
 =?utf-8?B?QjNLTHhvdDNnUEFCWWdxRXhTMGxqTmtlOEJaOWdGeXhybysyVmVSMXdweGdM?=
 =?utf-8?B?ZHZITHFBZ1QyMEJuQlRvQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFFuNEZlLzJRMENuZjNqOC9lcTk4UlVTRVhpS0U3eGF5dWVBN3Y1ZE5GbHg4?=
 =?utf-8?B?dldkd0ZKcExLMlFpQzdXcW4xWkdVSUVCSmFHK3BOUTJCVGF3VEFaejhKZzhL?=
 =?utf-8?B?SExnNWJZdm1ObUtqVU5jaVB6Q1h5V1d6NHMvTG9UU0ZQUmlTeFllNnhpemU0?=
 =?utf-8?B?VWNEUkV6bFA0M0QyZi9wQmF2RVMybXhWMUNlNG9LbGpFL1lYS2w0QjZrMnVm?=
 =?utf-8?B?dXVoSFpmbzNaT2I2R1l4RFdyaCtxQjRVRWgyMTZtY0RLZmJjYXo5ajhLUXM2?=
 =?utf-8?B?UG1tQ0dzdVgrSTZ3QWhXUXVTaUo1UngrYmU5STg1ZG1hV0tJL3REU0h0dWNs?=
 =?utf-8?B?c25TMWNURHlWWEhpQU9ZUzAwT2N3Wkc0T09WRlplalBUeGM1aHZwSWRodVRh?=
 =?utf-8?B?NHBTVENqbG9xRGRRWTlEbXdwWFpDcndqOGd4WjEreTBNUVlFUTl5UlllZ1kv?=
 =?utf-8?B?NlRzOCtVTlY1NkhTQVBtSzBUTjc4aWVYZkE2b2NXNzdPWFY5ZEVTVFNJUnYv?=
 =?utf-8?B?bENzUXYxcGc2czBibkl5OXdmVmRBRTBlR2tMaTh3OHJnQ3ltOUEyUldhRy9E?=
 =?utf-8?B?QlRkQlUxNkd4RU5DUzJtTCtyb3hBRGFCbnZKejdFb3J2dFVmZnBtTHFQcHVp?=
 =?utf-8?B?c3A1a3MyN0JSbHJ1OC93aE42R0piZ25wUTBreVZKczZpcjZlZnd2SnNxeDJW?=
 =?utf-8?B?MVRCSDhWTXE0YWlYSzlQNjdPQVB4cEJwZ0VNMUpiVDM1WlRmRGJoRGhZamNK?=
 =?utf-8?B?U0dtS2tGc3Y5dFpWcG1ZU3paN3l0OVIxV3ZwT3NXYWlmbm5TTE5RUFh0K2cw?=
 =?utf-8?B?RE5sUHk3Wlo0b1lUa1NtSGxqdzJ0Zjd1cHlyZWJEWUNZN0FIQThWaWE5TytQ?=
 =?utf-8?B?dHBYSTl5SUNHWXcxNlk3ZGZBZmhZNnZoajY0K1VPZENaaDQ5elVEa2tlbHhU?=
 =?utf-8?B?Z2FXTml1MElqOFR0SlY4SElrYngzVEtmNDJ0ci9qY2MrL3dpMVhybXJicDdR?=
 =?utf-8?B?YjhNa2pQTUhrd216WnR5Tm5nbWNKSXU4M0l0M2hsM29LdVp6MUJBSnFWcE1n?=
 =?utf-8?B?cEwwbFhNUHdVQnV3UEtlNTBMcnN2U0JLb3pVTTVROFI1OC96SVQ4UTY0T2tl?=
 =?utf-8?B?VEtTazFEVGg0YXdOVi82alcvcWNiNHlwM0xaSHY4QXliYmhKVGZ3amZ2UUtZ?=
 =?utf-8?B?TmprNEZKNGZHemU2SG1HVFZUbW9KR2ZKejY1MkUyODZQRmh2R2VJdy8xbm9F?=
 =?utf-8?B?dmZlTzhsdXZoNjlUd2pRa01MeVNPY0p4U1ZKb1ZhZWlQL2VrLytQQ0NwQjJ5?=
 =?utf-8?B?ay9XaVR3VG8rbWpYTkJENlBhakFMazdmdzFyTlJQVW14Ly9nWGthYlRpeWRw?=
 =?utf-8?B?VmpmanFyTXF0Y3NYaG1LRTlqWVEyZEhlZmIxcHVEWCtCZWtELzJIdy9jUEJF?=
 =?utf-8?B?TUFDZXdWQkgwUC8wVllsTXpVMlFuSHVwUGlTd0dqM3F0YjRJWUhKcUFJSHNM?=
 =?utf-8?B?ZmZHbEFFM0w2NktVT1p6WHpHSk1ERnNzdElpelNtWC93dXFnVlJUa1FvSWVD?=
 =?utf-8?B?Q3JhNWNCUUlBbWlvb0Y1aHlTUFBiUmRJSWxONUQwSjVDNFRMQTRnYi9DcWVF?=
 =?utf-8?B?UFlScURiWmtPcVhNSUV5eVNZeUlGM09TWWlxcmxrVW8vZnVaemN3VmdSTS9u?=
 =?utf-8?B?YUxUZnZEQWcrNWIvcHd0K1FSQUxzamxrenBubFFhTUxKb3BYRFRQczJ1YWtx?=
 =?utf-8?B?Y2ZqUjU1cE1lKzlNL3dia1hxTWlHdXdFMTRialZnNHJEL3VQcmY1UnRkSWt0?=
 =?utf-8?B?VlFXZ3F4MnhiVFFOYmRCVDZJUjliY24rOHVXc1d6L2ZhajI2TFJKTU9DWnFi?=
 =?utf-8?B?cU1SVnhMUnRGdHhnZkVKRGJrVW5CS0s2bmtEZkNnVUoxSmkzLzdnTFZXeEwr?=
 =?utf-8?B?bnlCbVQ1Qk5YSEpSSGlVV2hxRS9yN0pPc2FBaldMM3hleSs4aXptTGpDY3c1?=
 =?utf-8?B?K3lCdjFQOWVxeHoxUmMzd1lXbDl2UVU0OWxka2xtbTcrMWpSTWJjcVVlL3hB?=
 =?utf-8?B?SHRuUTNScG0yVmltMjk3cEwxcE16ZExhcGZLckYxVkRnRmpKaHNnN0FVWnRC?=
 =?utf-8?Q?+FNA9zm2ck8XiFihpDqsko1OO?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94c37f8e-1b83-4c13-c5d4-08dd6dcc0194
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 07:41:52.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aqSktBrxKsjlJmTKwYHO7GsxzflARxSsxVnlupMz5zmaERyYYoTcTv4R4CLHpuPseShgm6A9/9FPYxi7/Cu+xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9134
X-OriginatorOrg: intel.com

On 2025/3/28 09:00, Lai, Yi wrote:
> On Fri, Mar 21, 2025 at 10:19:39AM -0700, Yi Liu wrote:
>> This adds 4 test ops for pasid attach/replace/detach testing. There are
>> ops to attach/detach pasid, and also op to check the attached hwpt of a
>> pasid.
>>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>> v10 -> v11: Various tweaks. Detail refer to discussion in v10 of this patch
>> ---
>>   drivers/iommu/iommufd/iommufd_test.h |  26 +++++
>>   drivers/iommu/iommufd/selftest.c     | 162 +++++++++++++++++++++++++++
>>   2 files changed, 188 insertions(+)
>>
>> diff --git a/drivers/iommu/iommufd/iommufd_test.h b/drivers/iommu/iommufd/iommufd_test.h
>> index 1a066feb8697..1cd7e8394129 100644
>> --- a/drivers/iommu/iommufd/iommufd_test.h
>> +++ b/drivers/iommu/iommufd/iommufd_test.h
>> @@ -25,6 +25,10 @@ enum {
>>   	IOMMU_TEST_OP_TRIGGER_IOPF,
>>   	IOMMU_TEST_OP_DEV_CHECK_CACHE,
>>   	IOMMU_TEST_OP_TRIGGER_VEVENT,
>> +	IOMMU_TEST_OP_PASID_ATTACH,
>> +	IOMMU_TEST_OP_PASID_REPLACE,
>> +	IOMMU_TEST_OP_PASID_DETACH,
>> +	IOMMU_TEST_OP_PASID_CHECK_HWPT,
>>   };
>>   
>>   enum {
>> @@ -62,6 +66,9 @@ enum {
>>   	MOCK_DEV_CACHE_NUM = 4,
>>   };
>>   
>> +/* Reserved for special pasid replace test */
>> +#define IOMMU_TEST_PASID_RESERVED 1024
>> +
>>   struct iommu_test_cmd {
>>   	__u32 size;
>>   	__u32 op;
>> @@ -150,6 +157,25 @@ struct iommu_test_cmd {
>>   		struct {
>>   			__u32 dev_id;
>>   		} trigger_vevent;
>> +		struct {
>> +			__u32 pasid;
>> +			__u32 pt_id;
>> +			/* @id is stdev_id */
>> +		} pasid_attach;
>> +		struct {
>> +			__u32 pasid;
>> +			__u32 pt_id;
>> +			/* @id is stdev_id */
>> +		} pasid_replace;
>> +		struct {
>> +			__u32 pasid;
>> +			/* @id is stdev_id */
>> +		} pasid_detach;
>> +		struct {
>> +			__u32 pasid;
>> +			__u32 hwpt_id;
>> +			/* @id is stdev_id */
>> +		} pasid_check;
>>   	};
>>   	__u32 last;
>>   };
>> diff --git a/drivers/iommu/iommufd/selftest.c b/drivers/iommu/iommufd/selftest.c
>> index 04a4b84f5fa1..18d9a216eb30 100644
>> --- a/drivers/iommu/iommufd/selftest.c
>> +++ b/drivers/iommu/iommufd/selftest.c
>> @@ -167,6 +167,7 @@ struct mock_dev {
>>   	unsigned long vdev_id;
>>   	int id;
>>   	u32 cache[MOCK_DEV_CACHE_NUM];
>> +	atomic_t pasid_1024_fake_error;
>>   };
>>   
>>   static inline struct mock_dev *to_mock_dev(struct device *dev)
>> @@ -227,6 +228,34 @@ static int mock_domain_set_dev_pasid_nop(struct iommu_domain *domain,
>>   					 struct device *dev, ioasid_t pasid,
>>   					 struct iommu_domain *old)
>>   {
>> +	struct mock_dev *mdev = to_mock_dev(dev);
>> +
>> +	/*
>> +	 * Per the first attach with pasid 1024, set the
>> +	 * mdev->pasid_1024_fake_error. Hence the second call of this op
>> +	 * can fake an error to validate the error path of the core. This
>> +	 * is helpful to test the case in which the iommu core needs to
>> +	 * rollback to the old domain due to driver failure. e.g. replace.
>> +	 * User should be careful about the third call of this op, it shall
>> +	 * succeed since the mdev->pasid_1024_fake_error is cleared in the
>> +	 * second call.
>> +	 */
>> +	if (pasid == 1024) {
>> +		if (domain->type == IOMMU_DOMAIN_BLOCKED) {
>> +			atomic_set(&mdev->pasid_1024_fake_error, 0);
>> +		} else if (atomic_read(&mdev->pasid_1024_fake_error)) {
>> +			/*
>> +			 * Clear the flag, and fake an error to fail the
>> +			 * replacement.
>> +			 */
>> +			atomic_set(&mdev->pasid_1024_fake_error, 0);
>> +			return -ENOMEM;
>> +		} else {
>> +			/* Set the flag to fake an error in next call */
>> +			atomic_set(&mdev->pasid_1024_fake_error, 1);
>> +		}
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>> @@ -1685,6 +1714,131 @@ static int iommufd_test_trigger_vevent(struct iommufd_ucmd *ucmd,
>>   	return rc;
>>   }
>>   
>> +static inline struct iommufd_hw_pagetable *
>> +iommufd_get_hwpt(struct iommufd_ucmd *ucmd, u32 id)
>> +{
>> +	struct iommufd_object *pt_obj;
>> +
>> +	pt_obj = iommufd_get_object(ucmd->ictx, id, IOMMUFD_OBJ_ANY);
>> +	if (IS_ERR(pt_obj))
>> +		return ERR_CAST(pt_obj);
>> +
>> +	if (pt_obj->type != IOMMUFD_OBJ_HWPT_NESTED &&
>> +	    pt_obj->type != IOMMUFD_OBJ_HWPT_PAGING) {
>> +		iommufd_put_object(ucmd->ictx, pt_obj);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	return container_of(pt_obj, struct iommufd_hw_pagetable, obj);
>> +}
>> +
>> +static int iommufd_test_pasid_check_hwpt(struct iommufd_ucmd *ucmd,
>> +					 struct iommu_test_cmd *cmd)
>> +{
>> +	u32 hwpt_id = cmd->pasid_check.hwpt_id;
>> +	struct iommu_domain *attached_domain;
>> +	struct iommu_attach_handle *handle;
>> +	struct iommufd_hw_pagetable *hwpt;
>> +	struct selftest_obj *sobj;
>> +	struct mock_dev *mdev;
>> +	int rc = 0;
>> +
>> +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
>> +	if (IS_ERR(sobj))
>> +		return PTR_ERR(sobj);
>> +
>> +	mdev = sobj->idev.mock_dev;
>> +
>> +	handle = iommu_attach_handle_get(mdev->dev.iommu_group,
>> +					 cmd->pasid_check.pasid, 0);
>> +	if (IS_ERR(handle))
>> +		attached_domain = NULL;
>> +	else
>> +		attached_domain = handle->domain;
>> +
>> +	/* hwpt_id == 0 means to check if pasid is detached */
>> +	if (!hwpt_id) {
>> +		if (attached_domain)
>> +			rc = -EINVAL;
>> +		goto out_sobj;
>> +	}
>> +
>> +	hwpt = iommufd_get_hwpt(ucmd, hwpt_id);
>> +	if (IS_ERR(hwpt)) {
>> +		rc = PTR_ERR(hwpt);
>> +		goto out_sobj;
>> +	}
>> +
>> +	if (attached_domain != hwpt->domain)
>> +		rc = -EINVAL;
>> +
>> +	iommufd_put_object(ucmd->ictx, &hwpt->obj);
>> +out_sobj:
>> +	iommufd_put_object(ucmd->ictx, &sobj->obj);
>> +	return rc;
>> +}
>> +
>> +static int iommufd_test_pasid_attach(struct iommufd_ucmd *ucmd,
>> +				     struct iommu_test_cmd *cmd)
>> +{
>> +	struct selftest_obj *sobj;
>> +	int rc;
>> +
>> +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
>> +	if (IS_ERR(sobj))
>> +		return PTR_ERR(sobj);
>> +
>> +	rc = iommufd_device_attach(sobj->idev.idev, cmd->pasid_attach.pasid,
>> +				   &cmd->pasid_attach.pt_id);
>> +	if (rc)
>> +		goto out_sobj;
>> +
>> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>> +	if (rc)
>> +		iommufd_device_detach(sobj->idev.idev,
>> +				      cmd->pasid_attach.pasid);
>> +
>> +out_sobj:
>> +	iommufd_put_object(ucmd->ictx, &sobj->obj);
>> +	return rc;
>> +}
>> +
>> +static int iommufd_test_pasid_replace(struct iommufd_ucmd *ucmd,
>> +				      struct iommu_test_cmd *cmd)
>> +{
>> +	struct selftest_obj *sobj;
>> +	int rc;
>> +
>> +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
>> +	if (IS_ERR(sobj))
>> +		return PTR_ERR(sobj);
>> +
>> +	rc = iommufd_device_replace(sobj->idev.idev, cmd->pasid_attach.pasid,
>> +				    &cmd->pasid_attach.pt_id);
>> +	if (rc)
>> +		goto out_sobj;
>> +
>> +	rc = iommufd_ucmd_respond(ucmd, sizeof(*cmd));
>> +
>> +out_sobj:
>> +	iommufd_put_object(ucmd->ictx, &sobj->obj);
>> +	return rc;
>> +}
>> +
>> +static int iommufd_test_pasid_detach(struct iommufd_ucmd *ucmd,
>> +				     struct iommu_test_cmd *cmd)
>> +{
>> +	struct selftest_obj *sobj;
>> +
>> +	sobj = iommufd_test_get_selftest_obj(ucmd->ictx, cmd->id);
>> +	if (IS_ERR(sobj))
>> +		return PTR_ERR(sobj);
>> +
>> +	iommufd_device_detach(sobj->idev.idev, cmd->pasid_detach.pasid);
>> +	iommufd_put_object(ucmd->ictx, &sobj->obj);
>> +	return 0;
>> +}
>> +
>>   void iommufd_selftest_destroy(struct iommufd_object *obj)
>>   {
>>   	struct selftest_obj *sobj = to_selftest_obj(obj);
>> @@ -1768,6 +1922,14 @@ int iommufd_test(struct iommufd_ucmd *ucmd)
>>   		return iommufd_test_trigger_iopf(ucmd, cmd);
>>   	case IOMMU_TEST_OP_TRIGGER_VEVENT:
>>   		return iommufd_test_trigger_vevent(ucmd, cmd);
>> +	case IOMMU_TEST_OP_PASID_ATTACH:
>> +		return iommufd_test_pasid_attach(ucmd, cmd);
>> +	case IOMMU_TEST_OP_PASID_REPLACE:
>> +		return iommufd_test_pasid_replace(ucmd, cmd);
>> +	case IOMMU_TEST_OP_PASID_DETACH:
>> +		return iommufd_test_pasid_detach(ucmd, cmd);
>> +	case IOMMU_TEST_OP_PASID_CHECK_HWPT:
>> +		return iommufd_test_pasid_check_hwpt(ucmd, cmd);
>>   	default:
>>   		return -EOPNOTSUPP;
>>   	}
>> -- 
>> 2.34.1
>>
> Hi Yi Liu,
> 
> Greetings!
> 
> I used Syzkaller and found that there is general protection fault in iommufd_hw_pagetable_detach in linux-next tag - next-20250325.
> 
> After bisection and the first bad commit is:
> "
> 3d183bab95ea iommufd/selftest: Add test ops to test pasid attach/detach
> "
> 
> The deadlock can still be reproduced. You could try following reproduction binary.
> 
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250327_190630_iommufd_hw_pagetable_detach
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250327_190630_iommufd_hw_pagetable_detach/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250327_190630_iommufd_hw_pagetable_detach/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250327_190630_iommufd_hw_pagetable_detach/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/250327_190630_iommufd_hw_pagetable_detach/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/250327_190630_iommufd_hw_pagetable_detach/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/250327_190630_iommufd_hw_pagetable_detach/bzImage_eb4bc4b07f66f01618d9cb1aa4eaef59b1188415
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/250327_190630_iommufd_hw_pagetable_detach/eb4bc4b07f66f01618d9cb1aa4eaef59b1188415_dmesg.log
> 
> "
> [   37.609031] iommufd_mock iommufd_mock0: Adding to iommu group 0
> [   37.611696] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASI

thanks. I think this is due to detaching without attaching first. Noramlly,
it should not happen. But it is better to test the attach before using it.

	mutex_lock(&igroup->lock);
	attach = xa_load(&igroup->pasid_attach, pasid);
	hwpt = attach->hwpt;
	hwpt_paging = find_hwpt_paging(hwpt);

-- 
Regards,
Yi Liu
