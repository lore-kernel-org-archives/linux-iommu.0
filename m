Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C473E264F81;
	Tue, 16 Sep 2025 03:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757994058; cv=fail; b=OI7UXCijyGosB4rgJZePDDFBh6rC8OnmsIcSZhx1fHGU/9hQG8CmwDNKhb/2N5gpFw9hIiQyvVqIBcdK/gE2J/wqvkY88mfysILlqPObNmwCuahyHmSj6NpWFodAY2c9+swcWFDqf1gzZK8cl0bTwmn25ZodQbuFObktE6iw/qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757994058; c=relaxed/simple;
	bh=oArZDkkxeU+aqXPGFoP5PQGEc8FjDdnzBCMdDtpJYgQ=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gOQ3XF9QXN0cwOGOwzX5pemzYO1JEWsVSU3x6QdXbW9lpE6oKXwrREDkZ/ne4/fBL7fnyoncLapEmTFD75nARm6AyGwWLo0DQyNHU3ZyWgvhabhWBrvv9BjUhdYirZfZwkeyjDgADgJt9UgdLS9Y7lUJKT35u6WSwftvapxVM6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VRjT6X1Q; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VRjT6X1Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757994057; x=1789530057;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=oArZDkkxeU+aqXPGFoP5PQGEc8FjDdnzBCMdDtpJYgQ=;
  b=VRjT6X1Q/bJYcauzJ7SYi5GLoRyZLXkn2VVnk5SrlTSg925K5HkKwXgC
   TSntcI45n9q1MbT0bdF94PVJAk0mBDsYG2piZsgCNQ/eEpCYnp3n+CN6D
   0KdR3a0lk653n5E1DRxtK6PxFxOJnZCQFWk4PxoCPOwuiJI9p8ZiBJoQ3
   WUh4CF1Ue3Cr/dqT76+nsQjlf0v5sQAVrr1VPWQoyvt6OAMgidoGTDoqW
   g/KekqAjuYaNm7kyoY2gtF+u+NtlZkNj7j4HAt1zO55Hv5+gBLzvr1b7z
   j8ZE+I8DahZciPTVln0gRJcZqKIKsEFlcn/U6AMOMGg9Nh57WZoi8UZaR
   w==;
X-CSE-ConnectionGUID: oQDqsY2aQCasoWvd6oFEMw==
X-CSE-MsgGUID: YK8fv8fwSS+9rTm1F5VtkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="70885963"
X-IronPort-AV: E=Sophos;i="6.18,268,1751266800"; 
   d="scan'208";a="70885963"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 20:40:56 -0700
X-CSE-ConnectionGUID: TFUJKTR+TtSLGn6Vu9expg==
X-CSE-MsgGUID: jCPEnVfpQvCA8EQkuUAyuw==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 20:40:56 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 20:40:55 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 15 Sep 2025 20:40:55 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.25) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 15 Sep 2025 20:40:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lSwkAFPpVfCCckFX56VZf3rdl/X4ZwblK39Kn/nGsCImaiL8yKJsn2ltgUhR3oEdQB+eMi8Dj82N6moeDjghkrIbCZ/Cucyf8rdQ/l3TgPCBESAgNHec3tkuB0ML3kU2vwY3IkWAw1qXWgbsxP4xVF9QOixYozGmKSPYCT2ErpELpN9cbwhFDz1WQWnhv7Jz9z8qQDVsn+yTJs3TryIyoPf2LNj1tRNrq2Ol/3HdTXZnBUyNeNPRqaaLjK8jCjTP2XWNeONMUF48TzjDNhCQ9D4R3MVP2Ps9Du7wfDp7RGeHVGLWuN05Xxb6jw13chUB6Uzz2HOdVE9HJSux29hJIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FqEjUE9ECkxikXOg4j8AYPFY3B2QU3QtBxBcmhSpcZI=;
 b=NBRbcotPpLJh6pSk8TiaQ9v1sGvqesrJ5vbSXxb5z+aY/fxzlAzQdqNqd3EV5YOAi78M+BC9nAg99C/xwqeeHA2GhuIZ7t/QnR0YvBUX1TwSQHovm5YXthIS5vkmr5iRuyvn+ujSXRqPN9hoegRPnhmJDP8IUnY/nmE4bMR51DFP2bgf077Z1PZzrVRdM4XbM1KjGb8QUrWoo4vC4eO80OrhG0mK5UyFh4FMO1DlxSAdLR3/1SUhMsQTka+DYY7LtltgXf30h3j2vMj4AwQOTaL8WKoOi5QrqMfvkpSA//V18X6R7ofrCqdI05Hj06wA5MFWVhBiKNSefNg0NsekOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by PH7PR11MB7449.namprd11.prod.outlook.com (2603:10b6:510:27a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Tue, 16 Sep
 2025 03:40:52 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%4]) with mapi id 15.20.9115.020; Tue, 16 Sep 2025
 03:40:52 +0000
Date: Tue, 16 Sep 2025 11:40:41 +0800
From: kernel test robot <lkp@intel.com>
To: Yaxing Guo <guoyaxing@bosc.ac.cn>, <linux-riscv@lists.infradead.org>
CC: <llvm@lists.linux.dev>, <oe-kbuild-all@lists.linux.dev>,
	<iommu@lists.linux.dev>, <tjeznach@rivosinc.com>, <joro@8bytes.org>,
	<will@kernel.org>, <robin.murphy@arm.com>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<anxu@bosc.ac.cn>, <wangran@bosc.ac.cn>, Yaxing Guo <guoyaxing@bosc.ac.cn>
Subject: Re: [PATCH v1 2/3] iommu/riscv: Add Makefile support for RISC-V
 IOMMU perf driver
Message-ID: <aMjcOWPjLUezyvR0@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250915020911.1313-2-guoyaxing@bosc.ac.cn>
X-ClientProxiedBy: SG2PR04CA0162.apcprd04.prod.outlook.com (2603:1096:4::24)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|PH7PR11MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: d632ac4c-cfb2-4368-467f-08ddf4d2d5c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?11oaKrScjtmr4tbZULFKDgSvF+uKFxtFR51hPoELQb4jBcNvVNkc6baM9kAW?=
 =?us-ascii?Q?z0JV56ReV5vnsnZgvovkqCwuCS0gdvUcPe4WkzrrvzUctNqgF+UIp43xMgi6?=
 =?us-ascii?Q?MYPdvuDzEn1qSWHRz0jb+uc8DecBID4L5eDqf3A1IyRocnSfStG44lI+4OUP?=
 =?us-ascii?Q?VHgWpa7Ym9GTtQoRXurQpMBZXJhNUkfWAKR1judVz5X5jV82oS+BCHk7Hb8A?=
 =?us-ascii?Q?YQ6uiycBnIF9x8LCt7DGNxJ2dPVdSVIxY5+etnCKzaocGkgNNN/0d9RETAyb?=
 =?us-ascii?Q?XBEdQ5OnZJMN9DTGpSpXxYNWtuvTKcItWzlVqyXOvnDJJfyKT9PnL05DyVEy?=
 =?us-ascii?Q?r2MsSmE/u1P6MLGOrZyVshxLye0k3czmH907L8qKgcklkMmb83Irmu9dqj1v?=
 =?us-ascii?Q?hKma2B32HGScXIqE+M49E71Er5xewurv3XMSW1WHdcsjYv2XO9LZ5FaFA1zk?=
 =?us-ascii?Q?n2kxckXyPii5YzlXxUDoGKmx8Y2qrWxDouo+kQDVP/nvod2FFhC0DIkhhvRP?=
 =?us-ascii?Q?2ApjUb0k86QBt3RDNkTOr58mmaE9tSrrPTYSUitBYP7Dh2NFeKp2jR9UGY+Z?=
 =?us-ascii?Q?6il5yc7X9uQzZDiKhArOVQDfAbiV/T4j0Vd8wKjb4UH5WB69h6sGo1GYGsQ5?=
 =?us-ascii?Q?AYqYgUUURno/q2HUtHpgPT49ed9O735gts6jEsssnqOt0zOl+FA9XObgkIdx?=
 =?us-ascii?Q?ePB3cXyq6UevhOgeXvYpu2a3lCvf5C3LZSMuhiCz0p9kXfkLYMRy0Ow8cqYM?=
 =?us-ascii?Q?ZEL/Z+vvV+ox3BRPgZ21eo0nDgob/eFwmF+BuNgefABxY/kwWwW61cBG1xia?=
 =?us-ascii?Q?4CczPb0pRcHn0b/fZNV2+DE5JzOqepi8CtPPKBxlUNUe4vSpUAGtu3tVRocp?=
 =?us-ascii?Q?Sg3MsDrvdqW6pcp/Me1YzjvSb+3nLOQbHwgeO8EBLptB92El88rFP9kvR/P5?=
 =?us-ascii?Q?cJT+4GG9i5mAcVRhSbeXRmTSP/9jCzUeO3JnGtsxL8Jn3I3buC7UKUJiYm4t?=
 =?us-ascii?Q?evj3NJk3Nwc9nzvao/NnkQ5eVosKKkX3Y5Fa9f49v2ZzosyT07l7EoENZkG6?=
 =?us-ascii?Q?qYaO5RaUHVKJ1vGqI+awetnURj+pkSlkvwti7VlJ5rp4J/pzsR9VBfLV2M27?=
 =?us-ascii?Q?giY6XdtL+wMtdadIrpOu/b8k/tnjgjDh3t+RopBPKBu8eGGffjb9zcP7r0Ar?=
 =?us-ascii?Q?s0ty2OBKgn0xD478jamgw6YR/Dt2/cinxtn42ID+J/JGbh3xgo8SUqUQGaXq?=
 =?us-ascii?Q?YLqcpUCeTWKd3QVc6JvK1MTgjia/+NnpiHSJ91z/dUjFyQ/A3Ng73DuRKpZT?=
 =?us-ascii?Q?VEyTaSEtoTW+vgGwAGuXFFd6Xsn1rbWmq3RD4DQPc+OpwhSCo2ay5SwFJKzg?=
 =?us-ascii?Q?GIeo/6+dV9mEgLqcc3/2uU+aInjs?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tg3ZdKcmgRdYogCO7LYfOcmHFBgFaH6lKQX1zbVLk6n7vknR0NeysvbIqAkq?=
 =?us-ascii?Q?99RH+a79KooiLzSSmu8QbveOhtAZ+6o4fdwb9BG6NbaYwbm7uE/8fDeobl1y?=
 =?us-ascii?Q?aMd4TLPynUngvvWdhCrFdGPiaN1Da398JYBVTLaKjl2FVZfvI1j34iAcfkLY?=
 =?us-ascii?Q?Z+sZOny0whCZFR78PlV7uz/GXiJ7kIDyd2kZqWbsF7I4wXaLy8CUQK+fDJyR?=
 =?us-ascii?Q?ldEZuVaP8tXuw5IFNZVyYQt7gEGxoFMHnzMGSzCroggQWH7xh8fecdhfH/QM?=
 =?us-ascii?Q?jfxDc9pXqeJAKFxpGoHmb953c99P9s+4ZduHX2QJsTdpVtjV5wlLDw4vgOA9?=
 =?us-ascii?Q?XBduH2lrmWKeXZygdTLKmDAjnu63xfiftpI1rWQmWKY8wdnsUfkP2b9fU/O7?=
 =?us-ascii?Q?UVcKxa8THh1dzYbyvLFOIKOrD8Yn4Cb0+bJoyuP9OtAmToOLux8SUgXZRucW?=
 =?us-ascii?Q?OY/hbIe3Q+1hNrtwUXntQxubzv8cBgu5mkTvYyKvkpHZE7TCLebk98pAShx1?=
 =?us-ascii?Q?uCD9PzH640Feq1G7okXy0q7RdVkRlcXXkwfSO4ypBIgXslq2V7DddamXA0wC?=
 =?us-ascii?Q?fKfss3I0COHOABlz+kFLEhVdqXjEUGK9Grar80NLJtah8qjw4y82fVXod8iT?=
 =?us-ascii?Q?qhZVANK+oJRr/z2iQOuseLbVtSeIIk9wkbUutIM4eti6iekU0WeUhh7iSu7b?=
 =?us-ascii?Q?C9adc5suOs9wYeptPbERhjnzuc69AuNORk3+AU3j9SzW08u0UszdA/YM9jHH?=
 =?us-ascii?Q?aodxxXwqTYtHYAw13QoXsl87W9Bn9IFbAl/ypcA4/luVlmzK5Roe3+wRFT6x?=
 =?us-ascii?Q?3ti27Qwvsj+Gy1qxdh8Fs7mpllZP4eWlviVYPnmDWiqdgMEE55D+M2Kx3LYj?=
 =?us-ascii?Q?CwMPtaMuLVAIlPCoTE5R/rK1M7IG1kYpnJfo13+Ynx8IaM5SBE2nFP6oyeD8?=
 =?us-ascii?Q?akS/4I2rGRjnbuDlVlbJ7vF6EBF0JUTMB5Zq7etBtetdFQpVaDWi29FGCibN?=
 =?us-ascii?Q?p/zXxEImtyjfjohwa9m0cpOglJo6Si4hx+OemduZjn1hx5m/cDsUJyY5eC1j?=
 =?us-ascii?Q?GxXg9GjMRMPyVdoytJIE4WLLzFwXpSJhtYpflCDzk00nxnpedU0cRIxcoEhF?=
 =?us-ascii?Q?OS76Pkb7GAXxW9pj1ZuXKWxxN/G+HoYpxAZ/ubo8zlCBbSdjjSFzAFdjECzp?=
 =?us-ascii?Q?bp1h2AE6NwB4N41MD8FW2t2BuRqeOmxezAiK+/7vmOdkFso3B2DHMe8e2m0b?=
 =?us-ascii?Q?jYGqkATUNPkUDRXD/Rx9TN72JxImXtV9R9kFcV4CrhMI7CKA78oMkMKYCwWG?=
 =?us-ascii?Q?6t4etgJWA06KJX/tqbcNZ0HHc6VrUT18Y9MSv5X/9Fbi7+FCoabwvVv1GAge?=
 =?us-ascii?Q?3lRp4gS7PHKjvhVDJvCqipKWQDhFErHWVO3pC6u1A5RKPv/YisQe6H5qvG+E?=
 =?us-ascii?Q?c9VTDcoakg7YI13/4+AvfeVGaBylGda7Lbi1UxeW0pcPwYw7+bUUSkMkQ+de?=
 =?us-ascii?Q?k+LxGkSGHjq9PnkuG7S6lOE8EDp27+4XEGl7/zovOovNpc3MUzNyEwjIiaG+?=
 =?us-ascii?Q?omFcL1VaNzs8BzKkHBLghSvkmyTGlNhR0sJMKz0hxUid5yT7fdMkkSZ0NkbW?=
 =?us-ascii?Q?+w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d632ac4c-cfb2-4368-467f-08ddf4d2d5c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2025 03:40:52.7523
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kDeKKkd5B5E6//w2o7vJJqyPJzXv2/RllfbtzznHfFaVH4F+zWckT/o4lXRUxQRGnb2DOn76+3w4zmxBdBmwuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7449
X-OriginatorOrg: intel.com

Hi Yaxing,

kernel test robot noticed the following build errors:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.17-rc6 next-20250915]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yaxing-Guo/iommu-riscv-Add-Makefile-support-for-RISC-V-IOMMU-perf-driver/20250915-101640
base:   linus/master
patch link:    https://lore.kernel.org/r/20250915020911.1313-2-guoyaxing%40bosc.ac.cn
patch subject: [PATCH v1 2/3] iommu/riscv: Add Makefile support for RISC-V IOMMU perf driver
:::::: branch date: 25 hours ago
:::::: commit date: 25 hours ago
config: riscv-randconfig-001-20250916 (https://download.01.org/0day-ci/archive/20250916/202509161121.SHWsStQM-lkp@intel.com/config)
compiler: clang version 22.0.0git (https://github.com/llvm/llvm-project 65ad21d730d25789454d18e811f8ff5db79cb5d4)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250916/202509161121.SHWsStQM-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202509161121.SHWsStQM-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iommu/riscv/iommu-perf.c:12:
   In file included from drivers/iommu/riscv/iommu.h:20:
   drivers/iommu/riscv/iommu-perf.h:68:29: error: no member named 'pmu' in 'struct perf_event'
      68 |         return container_of(event->pmu, struct riscv_iommu_pmu, pmu);
         |                             ~~~~~  ^
   drivers/iommu/riscv/iommu-perf.h:68:29: error: no member named 'pmu' in 'struct perf_event'
      68 |         return container_of(event->pmu, struct riscv_iommu_pmu, pmu);
         |                             ~~~~~  ^
   drivers/iommu/riscv/iommu-perf.h:68:29: error: no member named 'pmu' in 'struct perf_event'
      68 |         return container_of(event->pmu, struct riscv_iommu_pmu, pmu);
         |                             ~~~~~  ^
>> drivers/iommu/riscv/iommu-perf.c:157:34: error: no member named 'attr' in 'struct perf_event'
     157 |         unsigned long event_id = event->attr.config;
         |                                  ~~~~~  ^
>> drivers/iommu/riscv/iommu-perf.c:159:38: error: no member named 'hw' in 'struct perf_event'
     159 |         struct hw_perf_event *hwc = &event->hw;
         |                                      ~~~~~  ^
   drivers/iommu/riscv/iommu-perf.c:162:23: error: no member named 'attr' in 'struct perf_event'
     162 |         config1.val = event->attr.config1;
         |                       ~~~~~  ^
>> drivers/iommu/riscv/iommu-perf.c:182:8: error: no member named 'idx' in 'struct hw_perf_event'
     182 |                 hwc->idx = 0;
         |                 ~~~  ^
   drivers/iommu/riscv/iommu-perf.c:201:8: error: no member named 'idx' in 'struct hw_perf_event'
     201 |                 hwc->idx = nr;
         |                 ~~~  ^
   drivers/iommu/riscv/iommu-perf.c:224:32: error: no member named 'attr' in 'struct perf_event'
     224 |         unsigned long config = event->attr.config;
         |                                ~~~~~  ^
   drivers/iommu/riscv/iommu-perf.c:252:38: error: no member named 'hw' in 'struct perf_event'
     252 |         struct hw_perf_event *hwc = &event->hw;
         |                                      ~~~~~  ^
   drivers/iommu/riscv/iommu-perf.c:254:13: error: no member named 'attr' in 'struct perf_event'
     254 |         if (event->attr.sample_period)
         |             ~~~~~  ^
>> drivers/iommu/riscv/iommu-perf.c:257:13: error: no member named 'cpu' in 'struct perf_event'
     257 |         if (event->cpu < 0)
         |             ~~~~~  ^
>> drivers/iommu/riscv/iommu-perf.c:260:7: error: no member named 'config' in 'struct hw_perf_event'
     260 |         hwc->config = event->attr.config;
         |         ~~~  ^
   drivers/iommu/riscv/iommu-perf.c:260:23: error: no member named 'attr' in 'struct perf_event'
     260 |         hwc->config = event->attr.config;
         |                       ~~~~~  ^
   drivers/iommu/riscv/iommu-perf.c:276:38: error: no member named 'hw' in 'struct perf_event'
     276 |         struct hw_perf_event *hwc = &event->hw;
         |                                      ~~~~~  ^
>> drivers/iommu/riscv/iommu-perf.c:279:7: error: no member named 'state' in 'struct hw_perf_event'
     279 |         hwc->state = 0;
         |         ~~~  ^
   drivers/iommu/riscv/iommu-perf.c:281:11: error: no member named 'idx' in 'struct hw_perf_event'
     281 |         if (hwc->idx == EVENT_CYCLES)
         |             ~~~  ^
   drivers/iommu/riscv/iommu-perf.c:284:77: error: no member named 'idx' in 'struct hw_perf_event'
     284 |                 count = riscv_iommu_readq(iommu_pmu->iommu, RISCV_IOMMU_REG_IOHPMCTR(hwc->idx));
         |                                                                                      ~~~  ^
>> drivers/iommu/riscv/iommu-perf.c:286:21: error: no member named 'prev_count' in 'struct hw_perf_event'
     286 |         local64_set((&hwc->prev_count), count);
         |                       ~~~  ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +157 drivers/iommu/riscv/iommu-perf.c

8cf5fb280f5fc0 Yaxing Guo 2025-09-15  152  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  153  static int riscv_iommu_pmu_event_add(struct riscv_iommu_pmu *iommu_pmu,
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  154  				     struct perf_event *event)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  155  {
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  156  	int nr = -1, of;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15 @157  	unsigned long event_id = event->attr.config;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  158  	riscv_iommu_pmu_cfg1_t config1;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15 @159  	struct hw_perf_event *hwc = &event->hw;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  160  	struct riscv_iommu_device *iommu = iommu_pmu->iommu;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  161  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  162  	config1.val = event->attr.config1;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  163  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  164  	if (event_id >= RISCV_IOMMU_IOHPMCTR_CNT)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  165  		return -EINVAL;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  166  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  167  	if (iommu->hpm_irq)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  168  		of = 0;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  169  	else
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  170  		of = 1;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  171  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  172  	if (event_id == EVENT_CYCLES) {
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  173  		unsigned long val;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  174  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  175  		val = riscv_iommu_readq(iommu_pmu->iommu, RISCV_IOMMU_REG_IOHPMCYCLES);
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  176  		if (of)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  177  			val &= ~RISCV_IOMMU_IOHPMCYCLES_OF;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  178  		else
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  179  			val |= RISCV_IOMMU_IOHPMCYCLES_OF;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  180  		riscv_iommu_writeq(iommu_pmu->iommu, RISCV_IOMMU_REG_IOHPMCYCLES, val);
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  181  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15 @182  		hwc->idx = 0;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  183  		iommu->events[0]->perf_event = event;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  184  	} else {
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  185  		struct riscv_iommu_perf_event *iommu_perf_event;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  186  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  187  		iommu_perf_event = get_riscv_iommu_perf_event(iommu_pmu, event,
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  188  							      config1.pv_pscv, config1.dv_gscv,
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  189  							      config1.idt, config1.pid_pscid,
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  190  							      config1.did_gscid, &nr);
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  191  		if (!iommu_perf_event)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  192  			return -ENOSPC;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  193  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  194  		riscv_iommu_pmu_hpmevt_set(&iommu_pmu->iommu->iohpmevt[nr], event_id,
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  195  					   iommu_perf_event->pv_pscv, iommu_perf_event->dv_gscv,
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  196  					   iommu_perf_event->idt, iommu_perf_event->pid_pscid,
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  197  					   iommu_perf_event->did_gscid, of);
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  198  		riscv_iommu_writeq(iommu_pmu->iommu, RISCV_IOMMU_REG_IOHPMEVT(nr),
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  199  				   iommu_pmu->iommu->iohpmevt[nr].val);
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  200  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  201  		hwc->idx = nr;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  202  	}
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  203  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  204  	return 0;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  205  }
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  206  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  207  static int riscv_iommu_pmu_hpmevt_idx_get(struct riscv_iommu_pmu *iommu_pmu, int event_id)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  208  {
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  209  	int i;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  210  	iohpmevt_t *iohpmevt;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  211  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  212  	for (i = 0; i < RISCV_IOMMU_IOHPMCTR_CNT; i++) {
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  213  		iohpmevt = &iommu_pmu->iommu->iohpmevt[i];
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  214  		if (iohpmevt->eventID == event_id)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  215  			return iohpmevt - iommu_pmu->iommu->iohpmevt;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  216  	}
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  217  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  218  	return -1;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  219  }
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  220  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  221  static int riscv_iommu_event_del(struct riscv_iommu_pmu *iommu_pmu,
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  222  				 struct perf_event *event)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  223  {
8cf5fb280f5fc0 Yaxing Guo 2025-09-15 @224  	unsigned long config = event->attr.config;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  225  	struct riscv_iommu_device *iommu = iommu_pmu->iommu;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  226  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  227  	if (config >= RISCV_IOMMU_IOHPMCTR_CNT)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  228  		return -EINVAL;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  229  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  230  	if (config == EVENT_CYCLES) {
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  231  		iommu->events[0] = NULL;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  232  	} else {
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  233  		int nr;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  234  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  235  		nr = riscv_iommu_pmu_hpmevt_idx_get(iommu_pmu, config);
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  236  		if (-1 == nr)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  237  			return -1;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  238  		riscv_iommu_pmu_hpmevt_set(&iommu_pmu->iommu->iohpmevt[nr], 0,
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  239  					   0, 0, 0, 0, 0, 0);
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  240  		clear_bit(nr, &iommu_pmu->iommu->iohpmctr_bitmap);
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  241  		riscv_iommu_writeq(iommu_pmu->iommu, RISCV_IOMMU_REG_IOHPMEVT(nr),
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  242  				   0);
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  243  		kfree(iommu->events[nr]);
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  244  		iommu->events[nr] = NULL;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  245  	}
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  246  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  247  	return 0;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  248  }
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  249  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  250  static int riscv_iommu_pmu_event_init(struct perf_event *event)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  251  {
8cf5fb280f5fc0 Yaxing Guo 2025-09-15 @252  	struct hw_perf_event *hwc = &event->hw;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  253  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  254  	if (event->attr.sample_period)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  255  		return -EINVAL;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  256  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15 @257  	if (event->cpu < 0)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  258  		return -EINVAL;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  259  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15 @260  	hwc->config = event->attr.config;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  261  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  262  	return 0;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  263  }
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  264  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  265  static void riscv_iommu_pmu_enable(struct pmu *pmu)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  266  {
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  267  }
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  268  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  269  static void riscv_iommu_pmu_disable(struct pmu *pmu)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  270  {
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  271  }
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  272  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  273  static void riscv_iommu_pmu_start(struct perf_event *event, int flags)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  274  {
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  275  	struct riscv_iommu_pmu *iommu_pmu = riscv_iommu_event_to_pmu(event);
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  276  	struct hw_perf_event *hwc = &event->hw;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  277  	unsigned long count;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  278  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15 @279  	hwc->state = 0;
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  280  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  281  	if (hwc->idx == EVENT_CYCLES)
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  282  		count = riscv_iommu_readq(iommu_pmu->iommu, RISCV_IOMMU_REG_IOHPMCYCLES);
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  283  	else
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  284  		count = riscv_iommu_readq(iommu_pmu->iommu, RISCV_IOMMU_REG_IOHPMCTR(hwc->idx));
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  285  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15 @286  	local64_set((&hwc->prev_count), count);
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  287  
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  288  	perf_event_update_userpage(event);
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  289  }
8cf5fb280f5fc0 Yaxing Guo 2025-09-15  290  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

