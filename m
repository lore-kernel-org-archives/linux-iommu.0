Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6EB12B93
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516392; cv=fail; b=D68dU4hN5IaL/UKHgDrj3GKXerScExb2bTI3buO97xNzSrd6ilKK8K5+Knm1sFUI0j2S4CSWFOSqc6p8OpAnzThKHGVn4QaEZLgh1ZAgtfRrfrBAnD2fzEdaP6OWCjnJ2ZCN1eMSuQcPaV86ffq8JE3zV9XYjKmi1rayz1bwNsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516392; c=relaxed/simple;
	bh=+E9X6pd7+RzwvqLQdLQkus9wc2CMoROqfRzeeXNvOpE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WneqfaA9ZScQSf2tXq2fg7qajcuVUtPZO1+JgCNgFdLdb792UEPSMJmkWiEimLsZGh8JlGMGardlSt01iQ6yPsRnE1x6EcqK8ZjVszBTm35bRz0uH1Y+Iq1zjsarq/e7RmW4KMXwI0EGxCbinvaYkafrEhefPLJUsOe8JnrIQTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJqe6tBN; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJqe6tBN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742516389; x=1774052389;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+E9X6pd7+RzwvqLQdLQkus9wc2CMoROqfRzeeXNvOpE=;
  b=jJqe6tBNhmDhpfizsKF8pNk9o26SNSe7OTA93vvuPpkREOTOg7NHGHPf
   b41t3VeTRPsXq3/l2G28xzl2689DFf30w+OfH20sgaP9KyhAKhNPFR7It
   tkeNShKECupMbFLmqhA2p2JZS2gzHbDZiXu+JTCG7uTnRc0FEBbdSkgMF
   hysbfWAdDL+jnM3M1H4LQCE2KXTRJmYQVDiJJe9PWYfMoLIuUGONo73ga
   futzGsc7YEZI8HmlVCZBmRJb1NS7xsLm/RNIZC0mnmBhELXI2ZOC7kdT/
   GWgOqqVO5wqPJv1dyQfj6F+HVg++peM/sG/xLuOp/e2kLHYB9iLEuFWYD
   w==;
X-CSE-ConnectionGUID: LzDPJv/TT+S3kozdkMNxQw==
X-CSE-MsgGUID: 5g7755OWQX2Oi0uYw0rOrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="61172154"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="61172154"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 17:19:49 -0700
X-CSE-ConnectionGUID: lbQA98wjQzyWERyOqA43Jw==
X-CSE-MsgGUID: Eldj9xzNTnaIDOT9tteBxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="128361673"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 17:19:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 17:19:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 17:19:48 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 17:19:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENj3FF/qJNmFyqot2Sk2N1fxezktTe3ecqQq8CqyIVkYM4MDWe4SxbxX1txftrb0ysiBxQM0GFzwIgxjI/LAK+6Crpcmih1yHtX8nohcBz8CHVaQ/0PYjV1a8dM0s04fcg4feF1WFzkIOQMuypM8vm8Fjxepyq4qrNp2jcTJg+s6oN5DA++caCKOoWY9UvWuIcpJaubDVxZrlVAOSB3wrCasuSRiEV3gmpqRf/YEgekUQIauS7KARQMVar1et7Mjwesar4qva39FRS1jge17b2e42pXzszCIT3LKbIvInaPq9l9b7z97e5KX7lp2tuW8kn8r9fYYTmIAFfofbrbiVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ky0FHn5qLPPUAJ0ta+8BARiJh0oGhv0NEHJTgLvA0fo=;
 b=w0ILn3apnDv1a66Ei/MwNVsR2Wp0plrDe76219LG+EQ/L1fGxL/TcQpvvA8BnxAhNlHvdrdEvbChkCL/PMI52+DdHLnWRBn9N9XFbwDxW/LIvZ8MXVfOx+tcKXL/bUvYajJ/IbMCA3TzlR29uCimFqLNJ2+3QrTnbpA/F59NFNcKcp2uiCw+Neyw0Ac8XVAMgI6bYJN0YRSCPKDWCdvJXRuuQIAWwVRyLuMHdlmlYHAiA6Sq1KMX+eZsPks6pCPygh7baxahqotXi8artDf85q6rqH+1ZBsDfhAmIa/F9dqcn4juTMuZ5c6FyjYH0G8VeoHhkk2k22wIfx1dkC39Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by PH8PR11MB6754.namprd11.prod.outlook.com (2603:10b6:510:1c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 00:19:44 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 00:19:44 +0000
Message-ID: <93bca2e4-c91c-40f4-984f-61b3a03af8c2@intel.com>
Date: Fri, 21 Mar 2025 08:25:12 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 08/18] iommufd/device: Replace device_list with
 device_array
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <kevin.tian@intel.com>, <joro@8bytes.org>, <baolu.lu@linux.intel.com>,
	<iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-9-yi.l.liu@intel.com>
 <20250320172057.GA206770@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250320172057.GA206770@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::20) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|PH8PR11MB6754:EE_
X-MS-Office365-Filtering-Correlation-Id: cb51a9bd-debf-479f-4a12-08dd680e14a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXc4dnRRTkt6U1c2OUhHMWJWblR6SDgvL2Ezd0s0UHVwQTN3ZUg4K0RUWmJE?=
 =?utf-8?B?bWltNEx0WkxhWVluMkM2WjRLeG5DRWdtcU0rNzB2N0h2RDBzT0VnSFd1N0NU?=
 =?utf-8?B?VXNhNUNlRk5MMnMxREU2MitUU3RoUDZPL05CQmZBb3dsbnRNVkt6NzZvdjFl?=
 =?utf-8?B?OXdDQzc0d3dLb2w5ak0wd05hY01wYVJHL09ic2pCWmoyWndodCs4VTNseFRE?=
 =?utf-8?B?cTloMHVwYmF1L3ppN1ZYUXREeTFnWkZCSnBzNk8rZGErWjdQNUJBdU1hQWpw?=
 =?utf-8?B?RGpYRkpSQStBMjB4OUhyYkZJT3lVS2NtMlNpOURTUU13L2szaGNaRUQ2S3Bo?=
 =?utf-8?B?M1ZIZkJvUlBYL3BLaldtSEtCVCtlY3ZxZHpLSW9VdXZOVTVTWWRxRHBWTGl0?=
 =?utf-8?B?a2pKOGdCcmJQUW51aTUveFRnZ1d1NmwxbXdJZGlmTDZuVFQxREd2MUVOOU56?=
 =?utf-8?B?ZWdwTzA4U283US9SL0ZsS3pJNFRtYUJxOTd2bUVRSEsxakV4b2YvdGNiNEM0?=
 =?utf-8?B?ZW1GZnFpeEp2WDJIUWZjcCtiRzU3bVZJUGNBQVpIbUFUNTluR0Y5bVYwQXEy?=
 =?utf-8?B?RGVLMnFZbEJrOUprR2g1czQyY0pZUklrSGdEck4xME5KOFRGZXYxWGVNek0z?=
 =?utf-8?B?S2dxQXI2SmpIV3d1T1ZFaU90djcyU3Z6OFN6ODc1cTV5NUp4eHZrQ1V5aU9u?=
 =?utf-8?B?TXVLVDllL2dFdVVEWjlZSFZSYkVMVEdiSis0YWNUcUpKVElvenJXTlpCbHNE?=
 =?utf-8?B?cFNDOWZqd0h6azJVd0FLNVhlRHQ0c1ExcWV3OEU0aXYxV3A4YWNld2lXeXpN?=
 =?utf-8?B?RlR6TkVOYXVKSjNrZWVXZFVWQkczeG1MemNFQVBSY01kM0VtZ05rSmhDekxh?=
 =?utf-8?B?czU2UVlHUUxKdzIycTY0RzdwMC8wMGZRRWRjdjFFN2p3TUplV2ZxSjU2T204?=
 =?utf-8?B?WkRKY3BMclYvS1ZUOFRPUzRYWEh2aTZPaEszeWJkakZUa09zZUFxT1BydVFX?=
 =?utf-8?B?b3h2bEViVlJ6M2lxbUp3ZWc1TUlLYWhSZDFRQnNXOFBIVXdncjFvZW5paUlE?=
 =?utf-8?B?S3hJdWxiZUUrQWVvbnU2TllqSDBmUlBkRnNKNmVubTZTMUQzTnhyckFjVU5M?=
 =?utf-8?B?djFsRjdqdFdBK0Z1eHQzMzNJSzVwUC9XeU1VeXJLZVhOQmV5d2VwNkNpczdX?=
 =?utf-8?B?QlFiU2xqcHprYUdEajh6QW9ZeGQ0VnBNQ1dhUVNVcmc1amozM0FPdXJ5VUFy?=
 =?utf-8?B?cW1Ma1Z3YUlsRzNMcGFWRkxuRDQrRUFzRGZOSk9ub2hzbWNXem9sazk3THFH?=
 =?utf-8?B?T29BZkJ1c1RBYWI1dkF2eDlmUE5ab0pZeE1hRDNEM0FxZVlEMXVodmNKbFE1?=
 =?utf-8?B?ZHlSK3Z1L29LaGNiRVB5L2gzcytPYzd0Z3VBemhjTlpSYm1UdDBJQlpUaitQ?=
 =?utf-8?B?UG9hRWtZWkNWY2dPTnhRT0hueFNmQW1tazdQK1E2R0dIeXpyN0hYSkVmNHdT?=
 =?utf-8?B?ZnZtMzEveTdFbnlPR0g2RkpoYVZ3dlpkYnNia0FreEVoRUhIUVk1anRzTktN?=
 =?utf-8?B?K2VPUXF2bGE0N0JGdEpZVDRJWE51VTVENndaSFp5K3h0NkJlT1Q0NU43WUtu?=
 =?utf-8?B?SFcrZ1pBRXBiOVdyTEo0UlRwcU9CSno0RmtUZGViMWMzczQ2bXlPWjNjMU9p?=
 =?utf-8?B?Q1pVOGhvRFlKWVRNZllJYVZWbmZhTWpKeW4yZnZzVG9ZUnF4Tlc4MjdlQ0NJ?=
 =?utf-8?B?WHhPZFo2bVgzV1Z3eDhvdGZzYWUzeHU3TERkang5djFaR3RpNEVRZ2trYjJU?=
 =?utf-8?B?Q0RVTDlaM0pMeFVZeVZwZE9vbnNlMjc0d3gzQlhRbXVNakNTL0tUaWo3ZzU5?=
 =?utf-8?Q?xUwmcG2ci2Vo1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U05XQytVcFEyd1hsVmVEVWtlRGQ0MyszZFhhbkcxWW9XRzI0TytmNjVMTDdT?=
 =?utf-8?B?V2JxZDNBM1E5MUxzdy9rQW05SFVFcmVLeFZGVXl0Y2Vkd3JRckwvT0poK25D?=
 =?utf-8?B?Ny9idW4rSTRzNFBJT1UyblQ0bEwvM0tYN2dVTjZkSjl6R0FFVTdabHBvc25p?=
 =?utf-8?B?RWdMYmU2VElsS1NnTW9JdEFzNVYwWklyekF6emQ2and1K2hnSm9rbWo3L0RG?=
 =?utf-8?B?dTBQVTVBVC9oRnAxZnhsckg4bit6cnNDZmZTVHJySzMwY3lhcGdhRWpYZG1x?=
 =?utf-8?B?dm1YZG5RaDNxN1hKQUd0eEdYOXB4WkF5dWtvZkp1MU8vWjk3U0hGZm1aZDBn?=
 =?utf-8?B?eVQ4S3JQdjFyYmxiSWFIT2xnVjJKNy9NR083RzJpQ3c1VDBhY05nT1kwZ2Jh?=
 =?utf-8?B?K2tvY2Q1NHVOTXJRTVJxbUU5MkFYWjExTW1FSDA4NDQzT2FaaHpNbEJTSzdF?=
 =?utf-8?B?L3dBTVJyTVE3SjJZVDNJS1JlRGJhNkhzbkRvR1kyaW5RNEJzMlp6SWU4WThk?=
 =?utf-8?B?RFU0dEpJRXJTZnY1L2xWQ2NNem5nZE8xeU9vaGVKYkdvMU8rbk5Zbm80QVpo?=
 =?utf-8?B?Y3NDejBnZDlWSkZiSjltVGYwSnhuOEVjczNHYVA2YmxpVTlrcnBhdFlsRzUv?=
 =?utf-8?B?Ym5UZk1QREhabmIwUTNwZURPVUNMaHVVcFdSck52eXZqVCsyS0tjZGYzTm16?=
 =?utf-8?B?aUZ3QkdsS1E2VEt5eWpxZ29FKzN1NXBQUms0YitibFp2LzNjelFvZmVOUmJ3?=
 =?utf-8?B?dzlnWHE5MUJOMVdwY0RJQ3ViVDlBV1d5bTlGQm1KMW9uUzJHc3NpVDVUVkFL?=
 =?utf-8?B?Mmd0UG45LzM3NDRBWWpHV3dUL1cwMGdQR2pYVDByUDBwM0JDZjkybkZOWExB?=
 =?utf-8?B?SXl6MGpnTVpaTEtGa1YvenBwZE1BUnZ1aEhhWXkzTm11d3lKV0ZMdlRDLzN1?=
 =?utf-8?B?RlhsNFdLLytqRG8yK0dzSHZmeHFSaFEyZnY3V1gxNDBHanRyM2NCYUVHall3?=
 =?utf-8?B?VW5vRlhkS2owNi9iRlRBeHhFKzRoLzRIUTBSUXBFdHV2M0xFNEhhMFpVZWx4?=
 =?utf-8?B?R0d1Q2ZVbEpCaXVSWkdjYzZUS21KdXRUZHN6Y04xZ0ZSN3VmZ0M2R1lmTm5s?=
 =?utf-8?B?QU9kRWQxeFRMenBwWHVUQTFoQVJuUXV1RWpBL1JIVnNuNmZmVEJuc0tKKzFC?=
 =?utf-8?B?c0oyWndpelNLZVZnQUtHMkE0eElVdG5iUC9hV2o5UlU1aGxiMFIxYWpINDlZ?=
 =?utf-8?B?MHRBZjVraHhVa2dPVG9YUktFMWIxdVpRTEE3QjNobk8wYWhjcXZQUUtTbnVu?=
 =?utf-8?B?Ym5laHc4dzcxczhNdkFSVlVsSzhBNUdFeHdLOTdqSkcyM0FXTjVzMnRjb3I2?=
 =?utf-8?B?NENYU3FkaEQ1bzZ2NVhLZ3lTbmV5ODhsWExwWjNSM3RZQkJwVnNxOENyanhW?=
 =?utf-8?B?dnMvTEZicjVnaTczMW1OeFRMOWowMkVaT2x0UXUxS2xya0tRMnJDcUh5bUR2?=
 =?utf-8?B?cEkzNytVejlHV3JHTndHL2Y0T2ZPZHZvd0dMaXJFaUJNaU1veWhEb3hPT25q?=
 =?utf-8?B?NTFTT0dWVHhONGtWUXBneWZRbzNSQlBlanFSUjhieDdqWXg3bWJKelgvREZw?=
 =?utf-8?B?ZXpuT2hGN3hGeW9rZ0lTZy81VmFWdkJqOUVhbEd5clc3MVZwcDZoMU1BUWZx?=
 =?utf-8?B?aW9XOWxtL0R1NjZPQ0NpR1ZFeDFPRWQ2bDhmQTBVUXIzMlhIN1l6a0laYTFQ?=
 =?utf-8?B?VzV6amxjUXV3aS8xZ0cwOXozNjdLZE5yZkJZV3RrcDFhRFliT2wxaGpYUWlJ?=
 =?utf-8?B?WGJGcFZlTUpIZWRMTDZ6bkZlUmxEN29mOWNLWGtpL2hyYkE1ekNOSkxuaGIv?=
 =?utf-8?B?MDh6bURsdFZGMlY0Q1RScXgvRXNrQWo1WCs3N1kwNHNBbVlraU40ZWFIOHNS?=
 =?utf-8?B?QWJLOWNQbVJFYk16YUEwWmNqV3RTUnZhNEtRUTZzR05uLzh0cjl6NmdCK0hi?=
 =?utf-8?B?RE1GOE8yYkx4VEt0VzVyeU9ic1NaUHpBV3l4QkFhRTJGYi80QVI0T2tUWkxR?=
 =?utf-8?B?S0d1RXhkcjk0SWpsUkVxV25aOEFZMytmTlVtaGV0WDh3a09EZ2dIOUIyaTNF?=
 =?utf-8?Q?wx6v5KrHI6E75NQXEofu+08fr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cb51a9bd-debf-479f-4a12-08dd680e14a7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 00:19:44.4946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lcCrjGNK3jPNK9NO1L0AIg5czhH0w4LCzFUoZ19ZwhXnYZPJxCnvhc7V2xKdh/9lrYzDqm0Z0ANgsBahA0u4uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6754
X-OriginatorOrg: intel.com

On 2025/3/21 01:20, Jason Gunthorpe wrote:
> On Thu, Mar 20, 2025 at 06:47:34AM -0700, Yi Liu wrote:
>> @@ -298,6 +298,20 @@ u32 iommufd_device_to_id(struct iommufd_device *idev)
>>   }
>>   EXPORT_SYMBOL_NS_GPL(iommufd_device_to_id, "IOMMUFD");
>>   
>> +static int iommufd_group_device_num(struct iommufd_group *igroup)
>> +{
>> +	struct iommufd_device *idev;
>> +	unsigned long index;
>> +	int count = 0;
> 
> unsigned int and unsigned int return code too

got it.

>> +	rc = xa_insert(&igroup->attach->device_array, idev->obj.id, XA_ZERO_ENTRY,
>> +		       GFP_KERNEL);
> 
> Probably don't really care, but note the choice of obj.id here is
> going to waste some memory in the xarray. 0 based would be more
> memory efficient, but some of the other operations would be slower.

yes. The iommufd_device_is_attached() and the detach path might be slower
since it would need to loop all the devices. I also considered to store the
id for indexing the device_array. But the problem is idev can be stored in
multiple device_arrays. A single id does not just like a single list_head
cannot work. Seems no better choice...

> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason

-- 
Regards,
Yi Liu
