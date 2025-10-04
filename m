Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104321E5B7A;
	Sat,  4 Oct 2025 06:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759559968; cv=fail; b=gYMW052zvoQMu1+Yuhq3h1qi1j8LUOo7j7nUt9QXoeVO/3YdtBABhlxOv2njppy+re9xB9N/jrdiWsq15ycOQviWOvXbvue9SU13DeqkWqU+LQ/DQLKMSq/Cwce7G42B5Icn02vhQ1Ws/xDb/2+nYq83kvRJmrbVY0o0miPlmyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759559968; c=relaxed/simple;
	bh=BDmCyueQ9bWCw4dFivU/ATD86tpVszYwdEE4J8FfTDs=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=tIhS/jrdxpCqawBh88FLVP0MjCUr7FUZ2iaCIH1ZzZO/RUED68izx4d8wdcwwmc4RMc/3C4ZdyyY2hAnZn4MgZr2J5YbWDpF+tUOsUTXSx212siYMhJw69SBAlAk6y57tBQqhug3/7Py5a0rwbEnzpuinT/s+/xQJD7nOUzX+2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MG5Xz0g/; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MG5Xz0g/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759559965; x=1791095965;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BDmCyueQ9bWCw4dFivU/ATD86tpVszYwdEE4J8FfTDs=;
  b=MG5Xz0g/9JkelRgZoHqKWsBJ8nRbp7cHIKgWffV34+qivlIN9Y7BWMWx
   irg7RHzeV7uZA8mqXBks4AOhQw+36kR3haDduSBcgbD8eiqif/OckLwkA
   We19igW/vrs17cDzz6rzkH6mIIg62XvPbLlVtRW0vSXCOmyIn5sfQKPax
   dX69WgJ8ZaE31Q5EeCJZhMvvQRJ4ZQnJjMwQyfVU/fjxvHNvpJnuYYvqd
   n2Az33hOpryyANNdzYnxWcd2EfHEpiR2UTsUpFULuuE+ZM1WfLxaenk6z
   wbcJCNQVAAwEZSsukJyDdIr1nLGZ/eWn+TG7KgN7CPQNPxbxY2PjR8WYP
   w==;
X-CSE-ConnectionGUID: FeYjT2G4SMu8ClP+N91nWg==
X-CSE-MsgGUID: LYZr1p3mTv+06JsN2VsUqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11571"; a="87287656"
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; 
   d="scan'208";a="87287656"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 23:39:24 -0700
X-CSE-ConnectionGUID: xQElud6GSDKa2x72TdtHFA==
X-CSE-MsgGUID: JWtKL3PzTU+0SHSql7ezmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,314,1751266800"; 
   d="scan'208";a="179888747"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2025 23:39:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 23:39:22 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Fri, 3 Oct 2025 23:39:22 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.17) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Fri, 3 Oct 2025 23:39:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOR9YLzZezrHuf7ZzYOFVAFbYCAkvNFKY8h5wpjzrwfoQWAIVgMTkJT1S73CffnNJocjJFkdqsdJD8cRaqrchsYHWoNgutLnZlbUcCWYivM221In63KUbuISLXSYKxmF57Natu2F03AmgTGpsQXy5L9ZAknwKSgVqpOCbifIU1MOui0Q8BauK+MXkdIT9WawKqMn+tM2AMkachtuqe9/s9VAqkf6cQISGyrQ/bq9Y6RvaHDznbPtL2cyuKxUVb4Zn4cfXW+eDl8YQYzfNpS7haZymXcY16RLr7zwAawaNFMtOwqvDIX6JNaCdTLhQa82/S97HNqLhLPQE0DbvfzXAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJAXCfhTympI4bO/mBh42QVAYxBbYS/dta/iVhChk2s=;
 b=ZpFb2m7klwyJKdEu8uZctjZ9AYdnFfqKsqM9yqOg6RXXV8RwSejgdaxwWzGFPLzBCF6wT6ekNd5hvWteJ3uapApRV7LLscyMmhngnXzCifQ30/GNgS8Swtwtf1KzCOcAvCj4ASyjCtfaEUPfD1iZYtLFLKhNxHJx4MLiRXb9OxZVImYyNxULeqhshh5gQRXR+DuCmLv9BjvOkFEYd/4vPidks80+KcmIB/mULdIPyRUoXSRzY+2wx4BV4HO0M6qLb6plhcInb8kf5gexNq5+2WlK5rUv5yCldN3oHAIMdjmNyRLIvl+AplXe/Voaicem9L9TbJBB4jWV0O+GzmstPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by CH3PR11MB7297.namprd11.prod.outlook.com (2603:10b6:610:140::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Sat, 4 Oct
 2025 06:39:19 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.9182.017; Sat, 4 Oct 2025
 06:39:19 +0000
Date: Sat, 4 Oct 2025 14:39:11 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <iommu@lists.linux.dev>,
	<oliver.sang@intel.com>
Subject: [jgunthorpe:iommu-fwspec] [iommu]  cca42a9b53:
 BUG:KASAN:slab-use-after-free_in_intel_iommu_is_attach_deferred
Message-ID: <202510040814.19c7bd7e-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: KUZPR03CA0017.apcprd03.prod.outlook.com
 (2603:1096:d10:24::11) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|CH3PR11MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: a3e78e49-1e44-4e84-8814-08de0310bf38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IZetsWpOQzTWJpAjqThrC0bLwFZfuhBJWVkCw7/Exh8zies2PW2eJ7EmPp/G?=
 =?us-ascii?Q?K4TftVUzCdIadiKFAO14Aq95N3jE5G4QgSaScFeOf+QbjsyqeIWRJQqyjdAP?=
 =?us-ascii?Q?DixIRGPOzzdLpkM6ZR0VKSAAG24xGHEW6bWRcaP0wxdUyEODIxiGqGoPwiup?=
 =?us-ascii?Q?16jhdLSeCIU1ya2xIzAyxuyNOk/fdH9fSsFCnlEPRVCMGqOjZWlBqzExCZjE?=
 =?us-ascii?Q?lUMXvDGO3KhutNgSF7A8j995J0FJuZouGll7OiJ7syXxLZY6A1qcAc/ikGb7?=
 =?us-ascii?Q?SGY/B6luUprvm5yHZ5D/6MxeDY43i5/8ryuRdQXPPxQsEMN8HN61+LO9rFWS?=
 =?us-ascii?Q?HJkte4nnY4YRbd/B8nouTNj0g4LorpoagwX2J570wNPa7FWy/phHqzbVUqG7?=
 =?us-ascii?Q?kazqt0v2WZRtGSgWRAqJ4aNfhUDDoOS+1woiWsvvM64oDuco6R2NuGuaYjt9?=
 =?us-ascii?Q?J7lFa7yZ3K2yXEUBLECaKT8vhS9Hm43BVWTWfHahk34Z01tEP42dl36vkp2G?=
 =?us-ascii?Q?UrkklleBH13ocB63GpHY5ACXU49MDOLw+2f81K55TVuYD5FPzw3eZgd57M+v?=
 =?us-ascii?Q?yOgKBP4qo+WC1pgTCkGDgFTzTopLKAnI+5vNcqlPaULiAu9Z1+FAus8yp4zT?=
 =?us-ascii?Q?6d1w0NaKKbjcZkCNUczmFxuSEhqMTtXjVGo5Ue5qxbAFG6aOvg9ZmnapAFfE?=
 =?us-ascii?Q?r4H85Kt7mvmnI5ZKRlUPNgqFRhg9h5skhmfARIr7h/k/QKNO/LDeCN3NL5lw?=
 =?us-ascii?Q?rRuCB9k1lZADzLGoEr0fzwOXYyi4SSeyJ52m/A2QHZe+X6W2VGK/9kBbhYns?=
 =?us-ascii?Q?mdzTym4ssISRqDS2z2RFy1/BV2K08Owot0Ji3vD3WMksiNilLVSYom1a+QMI?=
 =?us-ascii?Q?0F5DzW0w77MWxsXrJtyKsHnbGDbHDU3Q4rZVE5p87PH1SWBgnlpV851Lq3ez?=
 =?us-ascii?Q?eoyQvKG1dEFLrpqhvlLp8z0OUdV/8gyoCZxnlligUYxBuRgxel/n41ygQnNF?=
 =?us-ascii?Q?36Cn+J67FjSST4RCTn34SlYeXsZsOlxbs6aOjsTsZsClZAkSi0jle1/6lzBz?=
 =?us-ascii?Q?9vAGf8JqLpXxBPImh6Y8YOPjGcLnC5q7OFuMKkeGkL1sfv6RLcgk3Ez8h9kC?=
 =?us-ascii?Q?DJKXqsCR0NNPAqpPEWQt6Un0m+RqCzXustJ2DQrbi9KQWCkTkF+H94Lqo2N5?=
 =?us-ascii?Q?oB+fKECBG6HcOt3/i4bTkwbCEhnWfbXVic3UQyOFDjsCTrV9YlwnQGMcGUl6?=
 =?us-ascii?Q?ZXQ3boPorZ7rfTy5kmmHKpkk5dYjavccox2JFULieGtTq/YgFFbD1yfwOqXJ?=
 =?us-ascii?Q?Gq4dza7UU/d0Mi29SDbUqcN63v3nWcB2CnN+lgqtPUncTRCCukbYqpdM3QGp?=
 =?us-ascii?Q?gbd1Hzq2LnlWQfPocknuW3lM7p/e/2lSBs5V9MrSq+Ookiamyw8gAGeYQqt+?=
 =?us-ascii?Q?YEbIFtTdeW8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?u8h0pBSM3KE+fpqHeIy4P2AN7I7MqiKGDl9DVcaHmFQUQJ398ELdr0pGYIut?=
 =?us-ascii?Q?FY6mA6NiLr7EgwlS0Bzm7DJrgpkbo/GoeWIDm7GQQxA7caRBhsFyUGHSvIrI?=
 =?us-ascii?Q?XBID0P2GZQWbbgm99IRnzcedbU5mhMTg7iSnsXGf3HCgDNYrhZpba+MEAZ13?=
 =?us-ascii?Q?Z5Y5nGR4BZhIq7mGbRRhVq5+T+rVXquaLNxvolUocx1sSxo0h5v87mvTynTg?=
 =?us-ascii?Q?fF5cjGUXwhv3q5tY21fyF4V9p7B9jVUqTzj/NwIuSB1sUD4SzBvcLj9rSYdh?=
 =?us-ascii?Q?mfe1ofMF4Hk5GNxNcTcweVCuiDaw6LoBxR7S/6Thb3ukbM8ogi12RGb5VdXL?=
 =?us-ascii?Q?Uu5MFPfntrfPd6nKfiCR6tGjy60KeSUV6k4TyiT2gT55YeI1t5KQoJ/+6uQ2?=
 =?us-ascii?Q?rBrvh9gPWo7SYALRqc6GazyHyBUdzxtQHCNHoxrfPWlR+TVripFUXN195ZDQ?=
 =?us-ascii?Q?O5BfLNdVNDgaNfdfFp65KaoR4zS5zYy7ZITN31lChLbnp+RzxIv4DW/hgazv?=
 =?us-ascii?Q?k+PJ1zz/iPqVSqhVP6O8YmSHuy9cJQbw1U7YLB0XbTtmW2gXrBiB/qPvY37w?=
 =?us-ascii?Q?6+vqJKNPRbYd40L1fCylJVv1uJ2l/dvVC9pJWzi+qkag895K6Tu/rltXVWJZ?=
 =?us-ascii?Q?sOfE83g+cqQA3fKR5Dlh6s15In9rhAg8xc/jdCXh1L4KZUJeSzn6I9QOSdcU?=
 =?us-ascii?Q?Bz1bS5S9B0KSxULshku2T7fcd7rwf5j8KwvYsV3Xbv4TvHldIqZgZVqp6lZz?=
 =?us-ascii?Q?GfK67MmtVSKGYxgL/V/WPcVCPbglXHUHg4Rd7LHx2hq0/m08ajMTtncriB5l?=
 =?us-ascii?Q?z8IG358GNRSzO6zH+DDlydHVXjM6Hw8FCgyjuvJRNXVLW+2obJ+VNvrNFRes?=
 =?us-ascii?Q?UqldDO27EuWs+abnAnfiNi5ohLV9uXOoW6Pju4ZIDn7ug6x7b3aZgJdc3syr?=
 =?us-ascii?Q?u8akcQ9cWCjXQFGUtl+oAQ7bj4Y24/TCnTj6jhX7afXH562dpNXrWB3JaaIP?=
 =?us-ascii?Q?H0QPK4XyQpbZ+Z2mw+fPwJ3nOVfuYlYewl3E9kSxL7AsKslmJDvXvnJV0bqj?=
 =?us-ascii?Q?Y7HblD5AilgpX3MxySJPrqqffbOpl4CaxNMfpO1bdGocJew/yVE8C2sgFYRL?=
 =?us-ascii?Q?FbkOtsB0MjYqPYqGRc6Ll0B4/YQnSSvrypQ0O4Q0RLWx0p6MFPPtdkvtvWO6?=
 =?us-ascii?Q?c5h1cKZu5yMVNXzd1a51LYaz3tfnMIPm7zMo7XXd2R8HlBj/zb8Yoqwt68+s?=
 =?us-ascii?Q?3KKW/DJrL4EKNHQBmu8W5IlcV/03Tli0VfU4s1DE2aMSY2Ja+iryQkgRmqsz?=
 =?us-ascii?Q?Q+dnjfXyz1H44aThp8rzcfwGlsAbDQ/vzF3p3VpmO8sYKub4M2nvaBMXhtQA?=
 =?us-ascii?Q?7yDKAQyacnGhwbroGFsXthLtOQegAs38SsFMfAIWhm/DRlppk/Iy7l7+bad7?=
 =?us-ascii?Q?fOCJC/J4GL3PBiyWZlUZq7ZH8jiZKAUYwnsV798ZaIvlAG+fo+31suA205lM?=
 =?us-ascii?Q?Z/FN6y4yhb3+3hdSY8U3v1XOobEBafNNdrh6mk8b5WisQHBGSSikTXzR8VAS?=
 =?us-ascii?Q?wA/PxCI6MRYsKnDBNBIiaq8ITlJ2wz1g6i7nJGUT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3e78e49-1e44-4e84-8814-08de0310bf38
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2025 06:39:19.7235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GxqbFq3dhQYWXgECU8QZad2tg3/WsMU1LIYuCTVB3ZhQr4QdifqfOhYAG8cKTZChTUB59O0jvWkHZ/MZ5MWFNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7297
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "BUG:KASAN:slab-use-after-free_in_intel_iommu_is_attach_deferred" on:

commit: cca42a9b5325b96bfd3d74e24628511f537afbe9 ("iommu: Add a probe_device_fwspec() op")
https://github.com/jgunthorpe/linux iommu-fwspec

in testcase: ocfs2test
version: ocfs2test-x86_64-d802bf7-1_20210827
with following parameters:

	disk: 1SSD
	test: test-reflink



config: x86_64-rhel-9.4-func
compiler: gcc-14
test machine: 22 threads 1 sockets Intel(R) Core(TM) Ultra 9 185H @ 4.5GHz (Meteor Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)



If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202510040814.19c7bd7e-lkp@intel.com


kern  :err   : [   10.461010] BUG: KASAN: slab-use-after-free in intel_iommu_is_attach_deferred (drivers/iommu/intel/iommu.c:4026)
kern  :err   : [   10.461010] Read of size 8 at addr ffff8881399e86a8 by task swapper/0/1

kern  :err   : [   10.461010] CPU: 17 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.17.0-00001-gcca42a9b5325 #1 PREEMPT(voluntary)
kern  :err   : [   10.461010] Call Trace:
kern  :err   : [   10.461010]  <TASK>
kern  :err   : [   10.461010]  dump_stack_lvl (lib/dump_stack.c:122)
kern  :err   : [   10.461010]  print_address_description+0x88/0x320
kern  :err   : [   10.461010]  ? intel_iommu_is_attach_deferred (drivers/iommu/intel/iommu.c:4026)
kern  :err   : [   10.461010]  print_report (mm/kasan/report.c:483)
kern  :err   : [   10.461010]  ? pci_bus_read_config_word (drivers/pci/access.c:75 (discriminator 2))
kern  :err   : [   10.461010]  ? intel_iommu_is_attach_deferred (drivers/iommu/intel/iommu.c:4026)
kern  :err   : [   10.461010]  ? intel_iommu_is_attach_deferred (drivers/iommu/intel/iommu.c:4026)
kern  :err   : [   10.461010]  kasan_report (mm/kasan/report.c:597)
kern  :err   : [   10.461010]  ? intel_iommu_is_attach_deferred (drivers/iommu/intel/iommu.c:4026)
kern  :err   : [   10.461010]  intel_iommu_is_attach_deferred (drivers/iommu/intel/iommu.c:4026)
kern  :err   : [   10.461010]  iommu_init_device (drivers/iommu/iommu.c:523)
kern  :err   : [   10.461010]  ? __pfx_iommu_init_device (drivers/iommu/iommu.c:479)
kern  :err   : [   10.461010]  ? _raw_spin_lock_irqsave (arch/x86/include/asm/atomic.h:107 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) include/asm-generic/qspinlock.h:111 (discriminator 4) include/linux/spinlock.h:187 (discriminator 4) include/linux/spinlock_api_smp.h:111 (discriminator 4) kernel/locking/spinlock.c:162 (discriminator 4))
kern  :err   : [   10.461010]  __iommu_probe_device (drivers/iommu/iommu.c:623)
kern  :err   : [   10.461010]  ? __pfx_probe_iommu_group (drivers/iommu/iommu.c:1775)
kern  :err   : [   10.461010]  probe_iommu_group (drivers/iommu/iommu.c:1781)
kern  :err   : [   10.461010]  bus_for_each_dev (drivers/base/bus.c:370)
kern  :err   : [   10.461010]  ? __pfx_bus_for_each_dev (drivers/base/bus.c:358)
kern  :err   : [   10.461010]  ? _raw_spin_lock (arch/x86/include/asm/atomic.h:107 (discriminator 4) include/linux/atomic/atomic-arch-fallback.h:2170 (discriminator 4) include/linux/atomic/atomic-instrumented.h:1302 (discriminator 4) include/asm-generic/qspinlock.h:111 (discriminator 4) include/linux/spinlock.h:187 (discriminator 4) include/linux/spinlock_api_smp.h:134 (discriminator 4) kernel/locking/spinlock.c:154 (discriminator 4))
kern  :err   : [   10.461010]  ? __pfx__raw_spin_lock (kernel/locking/spinlock.c:153)
kern  :err   : [   10.461010]  iommu_device_register (drivers/iommu/iommu.c:1934 drivers/iommu/iommu.c:279)
kern  :err   : [   10.461010]  ? up_read (arch/x86/include/asm/atomic64_64.h:79 (discriminator 5) include/linux/atomic/atomic-arch-fallback.h:2749 (discriminator 5) include/linux/atomic/atomic-long.h:184 (discriminator 5) include/linux/atomic/atomic-instrumented.h:3317 (discriminator 5) kernel/locking/rwsem.c:1358 (discriminator 5) kernel/locking/rwsem.c:1633 (discriminator 5))
kern  :err   : [   10.461010]  ? __pfx_iommu_device_register (drivers/iommu/iommu.c:263)
kern  :err   : [   10.461010]  ? __pfx_up_read (kernel/locking/rwsem.c:1631)
kern  :err   : [   10.461010]  ? dmar_set_interrupt (include/linux/topology.h:93 drivers/iommu/intel/dmar.c:2052)
kern  :err   : [   10.461010]  intel_iommu_init (drivers/iommu/intel/iommu.c:3137)
kern  :err   : [   10.461010]  ? __wake_up (kernel/sched/wait.c:129 kernel/sched/wait.c:146)
kern  :err   : [   10.461010]  ? __pfx_pci_iommu_init (arch/x86/kernel/pci-dma.c:173)
kern  :err   : [   10.461010]  pci_iommu_init (arch/x86/kernel/pci-dma.c:178)
kern  :err   : [   10.461010]  do_one_initcall (init/main.c:1269)
kern  :err   : [   10.461010]  ? __pfx_do_one_initcall (init/main.c:1260)
kern  :err   : [   10.461010]  ? __pfx_parse_args (kernel/params.c:168)
kern  :err   : [   10.461010]  ? __kasan_kmalloc (mm/kasan/common.c:378 mm/kasan/common.c:405)
kern  :err   : [   10.461010]  ? do_initcalls (init/main.c:1341)
kern  :err   : [   10.461010]  do_initcalls (init/main.c:1330 (discriminator 3) init/main.c:1347 (discriminator 3))
kern  :err   : [   10.461010]  kernel_init_freeable (init/main.c:1583)
kern  :err   : [   10.461010]  ? __pfx_kernel_init_freeable (init/main.c:1551)
kern  :err   : [   10.461010]  ? __pfx_schedule_timeout (kernel/time/sleep_timeout.c:62)
kern  :err   : [   10.461010]  ? __pfx__raw_spin_lock_irq (kernel/locking/spinlock.c:169)
kern  :err   : [   10.461010]  ? __pfx_kernel_init (init/main.c:1461)
kern  :err   : [   10.461010]  ? __pfx_kernel_init (init/main.c:1461)
kern  :err   : [   10.461010]  kernel_init (init/main.c:1471)
kern  :err   : [   10.461010]  ? __pfx_kernel_init (init/main.c:1461)
kern  :err   : [   10.461010]  ret_from_fork (arch/x86/kernel/process.c:148)
kern  :err   : [   10.461010]  ? __pfx_kernel_init (init/main.c:1461)
kern  :err   : [   10.461010]  ret_from_fork_asm (arch/x86/entry/entry_64.S:258)
kern  :err   : [   10.461010]  </TASK>

kern  :err   : [   10.461010] Allocated by task 1:
kern  :warn  : [   10.461010]  kasan_save_stack (mm/kasan/common.c:48)
kern  :warn  : [   10.461010]  kasan_save_track (mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c:69 (discriminator 1))
kern  :warn  : [   10.461010]  __kasan_kmalloc (mm/kasan/common.c:388 mm/kasan/common.c:405)
kern  :warn  : [   10.461010]  intel_iommu_probe_device (include/linux/slab.h:905 include/linux/slab.h:1039 drivers/iommu/intel/iommu.c:3777)
kern  :warn  : [   10.461010]  iommu_init_device (drivers/iommu/iommu.c:456 drivers/iommu/iommu.c:502)
kern  :warn  : [   10.461010]  __iommu_probe_device (drivers/iommu/iommu.c:623)
kern  :warn  : [   10.461010]  probe_iommu_group (drivers/iommu/iommu.c:1781)
kern  :warn  : [   10.461010]  bus_for_each_dev (drivers/base/bus.c:370)
kern  :warn  : [   10.461010]  iommu_device_register (drivers/iommu/iommu.c:1934 drivers/iommu/iommu.c:279)
kern  :warn  : [   10.461010]  intel_iommu_init (drivers/iommu/intel/iommu.c:3137)
kern  :warn  : [   10.461010]  pci_iommu_init (arch/x86/kernel/pci-dma.c:178)
kern  :warn  : [   10.461010]  do_one_initcall (init/main.c:1269)
kern  :warn  : [   10.461010]  do_initcalls (init/main.c:1330 (discriminator 3) init/main.c:1347 (discriminator 3))
kern  :warn  : [   10.461010]  kernel_init_freeable (init/main.c:1583)
kern  :warn  : [   10.461010]  kernel_init (init/main.c:1471)
kern  :warn  : [   10.461010]  ret_from_fork (arch/x86/kernel/process.c:148)
kern  :warn  : [   10.461010]  ret_from_fork_asm (arch/x86/entry/entry_64.S:258)

kern  :err   : [   10.461010] Freed by task 1:
kern  :warn  : [   10.461010]  kasan_save_stack (mm/kasan/common.c:48)
kern  :warn  : [   10.461010]  kasan_save_track (mm/kasan/common.c:60 (discriminator 1) mm/kasan/common.c:69 (discriminator 1))
kern  :warn  : [   10.461010]  kasan_save_free_info (mm/kasan/generic.c:579 (discriminator 1))
kern  :warn  : [   10.461010]  __kasan_slab_free (mm/kasan/common.c:282)
kern  :warn  : [   10.461010]  kfree (mm/slub.c:4695 (discriminator 3) mm/slub.c:4894 (discriminator 3))
kern  :warn  : [   10.461010]  iommu_init_device (drivers/iommu/iommu.c:470 drivers/iommu/iommu.c:502)
kern  :warn  : [   10.461010]  __iommu_probe_device (drivers/iommu/iommu.c:623)
kern  :warn  : [   10.461010]  probe_iommu_group (drivers/iommu/iommu.c:1781)
kern  :warn  : [   10.461010]  bus_for_each_dev (drivers/base/bus.c:370)
kern  :warn  : [   10.461010]  iommu_device_register (drivers/iommu/iommu.c:1934 drivers/iommu/iommu.c:279)
kern  :warn  : [   10.461010]  intel_iommu_init (drivers/iommu/intel/iommu.c:3137)
kern  :warn  : [   10.461010]  pci_iommu_init (arch/x86/kernel/pci-dma.c:178)
kern  :warn  : [   10.461010]  do_one_initcall (init/main.c:1269)
kern  :warn  : [   10.461010]  do_initcalls (init/main.c:1330 (discriminator 3) init/main.c:1347 (discriminator 3))
kern  :warn  : [   10.461010]  kernel_init_freeable (init/main.c:1583)
kern  :warn  : [   10.461010]  kernel_init (init/main.c:1471)
kern  :warn  : [   10.461010]  ret_from_fork (arch/x86/kernel/process.c:148)
kern  :warn  : [   10.461010]  ret_from_fork_asm (arch/x86/entry/entry_64.S:258)

kern  :err   : [   10.461010] The buggy address belongs to the object at ffff8881399e8680
which belongs to the cache kmalloc-96 of size 96
kern  :err   : [   10.461010] The buggy address is located 40 bytes inside of
freed 96-byte region [ffff8881399e8680, ffff8881399e86e0)

kern  :err   : [   10.461010] The buggy address belongs to the physical page:
kern  :warn  : [   10.461010] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1399e8
kern  :warn  : [   10.461010] flags: 0x17ffffc0000000(node=0|zone=2|lastcpupid=0x1fffff)


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20251004/202510040814.19c7bd7e-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

