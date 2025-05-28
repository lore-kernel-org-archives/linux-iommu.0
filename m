Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A0C322A
	for <iommu@lists.linux.dev>; Wed, 28 May 2025 07:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748416330; cv=fail; b=U1PY6dlBDKD3xenw6ddseyPcGG+Up0xIJH6LwxdKPQpljwPZ93ofGcXjJM/xkb4dc6VdbljYX5WG7MwVHPU/GKn38j5vTP4oQ4kXSvTWVclz81LtcvXqyn/aGZFaUMLAv/XTUjdssMBmK2gK75lj7nViKhyw+jr6bh5NmLYSyyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748416330; c=relaxed/simple;
	bh=oIp2SHgqWLkQKg0jy63+VuK7KNDRMdWBng6FqsK7o84=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dab6LjUwGqFZVzRAbS/F7hcymuppunOWZT2OmUEjazk+UP1vEkct5MriHUlGc6OMt2GRpLoksTwfPSV0x8tl8Wq83ADNd/9J8x9tsidUhwQmIz8rjWQH8Ath6Zk9HWtJBNfgcq9NzqpY3BQM00z5bvQe043TymCTTsGxMLEw2gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TNF3Kk8Q; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TNF3Kk8Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748416329; x=1779952329;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oIp2SHgqWLkQKg0jy63+VuK7KNDRMdWBng6FqsK7o84=;
  b=TNF3Kk8QXqb3a1xAwDlffjyhvsV0aOc0nYvKRcmY1WWEmGwsSbfwugF9
   ZAPQRICi8OwjRs8X7U5iNDqlNKGpdfRpOyN6KDqd2qga3y5jY/bH2teYI
   BGS8RacfDOd1pleSlIQiwMxGOoUGtDZRRFfxd3iNxv5pIj2Z2+5XHDqYV
   4xKoZZiqNFRVskV7ow+CR1tordXL8V1Aw9jZqqnsIm2uC8XkUWi2sLLVd
   NK3ingefbGJ2G85+Yrb+D909ubtwEWARBUJEBPE1KiBV3bnQvm7QwoYIy
   /HeTyXHllqZSHaoN4M8vmG74JdrJu42tO+ylUIr0ZNIRtiZuBF9Ik7ljU
   A==;
X-CSE-ConnectionGUID: Fu8jlcHVTHePeJDY51I/xA==
X-CSE-MsgGUID: 2GGgcriVS5u/bb/yEPFzhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50127292"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="50127292"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 00:12:08 -0700
X-CSE-ConnectionGUID: 0gre1YOCSFmIuuMS+lMSJA==
X-CSE-MsgGUID: wTmCcKZ+SE2i3nX7gz9CBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="143132339"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2025 00:12:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 28 May 2025 00:12:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 28 May 2025 00:12:07 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.54)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 28 May 2025 00:11:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KvK2veQWk0EoujAI27Qa4xr39RXleWUHSfNjMFrg4scZ+96e8DQjFFsqlGLra+akdrsIJsfzaSdeIJzpCmppTtQmNR/DBvZT1ssAPIUl4bDDBShSZfDe9I9AIfq3TmIad+QxcjfzEzVIFBpBSiAVNs9HVB2SACaOzMat4kNUEndcl0o6faxmNvyPiyY7dP5tPrkkA7GF5a42WlrucmuXeKJHdyqEfIIeQQzpLSNT46II8/hnRnbSWQNMN8ShLBs91uHjYQ16lyatwMXNhVOc8t5ZoBhxGEGvXG0E8f+p3CNiiSSnunY02D5//L52JU5mT0KV+56qodABGzdmZvzXBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZE2fD2tAa700CZPAFhe6eWNdcKPPNU87bFuVnrPkVmQ=;
 b=DqMAyFn4aopJyllrJILm0LvMgD10Z1k2UVzF4cE9l86rx+IbWgh5awYa0RjwSW5ocvXYgCNS2KaKMqdYFEzcH/1iiO/Vbaa1YbGVvzRbKDexFlFgtGde0EXvvMBqgKxcyQc0RrNgmJodYuFPaM1x0hz0cqLkYLtmea5Zt4hrAtFinVcMjEt9DR/+iLfHpGSEIaUJl63yyR1RbSr0WUFJmLB3BcTWECDLvlgoBJDrYdyjqiGgeHkI365owDYFI36RJgZ+rWG6G7FnpO3bji4JHuEHRlY4URRHIpH8xpjPNWLodoRrbeLn6zXUV+EyukzdyYxW3Uzvbcds80UOEelSZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CH3PR11MB8705.namprd11.prod.outlook.com (2603:10b6:610:1cc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.25; Wed, 28 May
 2025 07:10:47 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 07:10:47 +0000
Message-ID: <dcd0cf4b-1907-4c27-a8f6-3dddf8313f6b@intel.com>
Date: Wed, 28 May 2025 15:16:57 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] vfio: Fix unbalanced vfio_df_close call in no-iommu
 mode
To: Jason Gunthorpe <jgg@nvidia.com>, Jacob Pan
	<jacob.pan@linux.microsoft.com>
CC: <linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Alex Williamson <alex.williamson@redhat.com>, "Zhang
 Yu" <zhangyu1@microsoft.com>, Easwar Hariharan <eahariha@linux.microsoft.com>
References: <20250516164522.51905-1-jacob.pan@linux.microsoft.com>
 <20250527000511.GK61950@nvidia.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20250527000511.GK61950@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU0P306CA0076.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:2b::7) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CH3PR11MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e6eb786-5236-4de8-338f-08dd9db6c540
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b2pFNVZVK0I1YVlEcTdTTm0zUDBCV3JOc0pzZ3dZQkJjcG1saUZ2cmwwS24y?=
 =?utf-8?B?Q0k4WEtNTjcwMUpQcmttRGM3OTUyRUNWTUd1b3piaVVqK2JTMXgxZnlyaHdV?=
 =?utf-8?B?aGVlT01vUmU3TnVHQytCTldVeUJraHB6Q1liMmZiWGs1STBsdnU3RFJ3dFVa?=
 =?utf-8?B?YWZIaVBxRTc4YzU0aUcvcHk4ZHhnWWhNL2pjM05oK2h1OTdMV3Erci91bkQy?=
 =?utf-8?B?cks4S041dVZ1ZVBwUnVXNmxNell6czY0UGVOWlByVVdIKzEvSWxPMFNENGZU?=
 =?utf-8?B?anMrSk1kYVVLZjhxSndpMEtWbTZPaFUrZUczVDljU0xwYjJqZ0lHTElPMmVZ?=
 =?utf-8?B?b0N2dC9LRnBzSDFHY2NsbXRrbmQybGNZNnZwcHlOY04vSVNGSERHMUVwWDZE?=
 =?utf-8?B?RmszMmV1eXpvZ1RCQ0VBY2Z6a2t5VDhRWEt1VktudEFrSE1oSjA1L2Rvd1BB?=
 =?utf-8?B?R3dTdXV5VDN0Z3RzOFVZaDRDSUFlLzJWT2RTMCtiOTB0bjBJMHNWdk5nTkpG?=
 =?utf-8?B?UUJiczYyRkR4UnRvbFZza0ZNaFRmMFV4aDFDUm9FVHdFaU1YRWozUHNnUnJF?=
 =?utf-8?B?STRscitVTURlSDRCODVYNTdOVEs4UUlFQ2pkZlRaTWszcWxYSnRGS1Fkd3Bx?=
 =?utf-8?B?cEJkVGpLRVlKcThRNGN5VWxzcE1Fd2U1akFOckxiUXRTck1WR0gwYmtPTWkz?=
 =?utf-8?B?Z1JXTjJBYU9XUUZ2cEt0d1pteENpTzhPSDhwWXB3ZFNmYjRPNnhDK3VVQTZF?=
 =?utf-8?B?S2tSa2hVd1AyUTNhTTlteWdJVllISjh4VG1iRzBFZ3I3M2J1cDI1NXpzbXhm?=
 =?utf-8?B?bFNmVi9FS0MvZkQzd3dQaEtSNStHZjI0R3lDTndjNXMvRGdLcWJSLzJ2M3Jy?=
 =?utf-8?B?N3ZJWC9YdlAyYm5iWU0yVmk0TFpxdDdDRHdMSVBqSzkxUS9jMFdRaUJ3SlBv?=
 =?utf-8?B?azNPbkFlbXlNZFcyYWFkR01HVlR4WGRMOEZPZUhsbTE0NHBsYk5taGNEVkEz?=
 =?utf-8?B?Wnk1NnBpSlJDRmNiSmhPeEJEbU1YbDBLWVpSVWRoVjYxMTFCQzdUQkxxTTB1?=
 =?utf-8?B?Q0E0a0p0cFNBbk8yVnBXeVBBaDJma2w4NmlQT21pM3NCQ1ViYjd1bDVSSXFG?=
 =?utf-8?B?TE9IYjI4QjZscUxEdTRnYURHcTZ2UkVoMlFzRm5qRzQyQUVsT2trV0UyaG9W?=
 =?utf-8?B?Z2d3Q21lN2x2Rk9KcEx1K0dHaU51VmRMSnlCUXkwTU1YcjJ4d0wwOFdGb3VE?=
 =?utf-8?B?TWxYL0YrWEVEWmZtYTZTTUJlMTRnNGlLVmNmT2FubllhSHV1SlRLYWlPZFZI?=
 =?utf-8?B?ekt6RHZQOEFlQnJpOHdOcmxzVXJpcUxyeTNyZHdtcmM2elVZWms5MmUzWkZJ?=
 =?utf-8?B?anNxTlFOcHF0cVk3WnNUN2Y2YVQ3NFVTUHpoRjYvcXZKRlRMSytnaWkraFFF?=
 =?utf-8?B?WWJaZ0JnVlhNVFR5MXZTUE5aNzRoNEhwRnVBc3dzK3g0K0o5RnpUQXdlSEVN?=
 =?utf-8?B?RWRUNHlBc0J3MkRIQklFWkhwYVo4VkhPRk1rWFd0ZFdUK0UrS1phWEpNbkwy?=
 =?utf-8?B?ODBJZ0QxR3NQVEw4clRGaWhUUXE4QTRaRXJCQ1ZQOGdqQlE2MEY4aFJWNmQ1?=
 =?utf-8?B?cHJpcFFHMWM5UmI3RjFwOGtJT0JZcmxsUjlXRllGbFVxcmk2SW16V1VPM0Jq?=
 =?utf-8?B?bU5XczcwbVZwai9pNFhySS90S2xEQWZnRUxhT2FKbHJNYWxBUmxEYlVpN2Rw?=
 =?utf-8?B?Y2tFTFpFRUErTXd4eVIwWEZyTTloak9vZmw0ZDFwaEM2TFhGWTNzVUYySHdr?=
 =?utf-8?B?eWowSGJRYjJ6eVNjckd3a3pxMXVzOVIvUDdwaUN2N3UySlhncEhPUStJdGow?=
 =?utf-8?B?eVJGeFh6SFNPQXpFdW9YcERoT0Z3clo3RjlNVkxGempOZStBTkwvWm0vQTc0?=
 =?utf-8?Q?UufeKqxJ1JM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjZZZCtEQzNpUjBCYlU1NUplU0VNaWs2VWN5TGpsMEsvMkdsZEM0MUl1blJM?=
 =?utf-8?B?UTk4eGNsV2NDc2l6VGJpaE1xaVY2dGoxMWJjc2pGUW9uUGN2YmR0ekNKb3N5?=
 =?utf-8?B?Um5mOTVtdUZpUjNuUkh1ZGNRbWxnbjhkRC9nMUlxbW8xdmdIQjgxRVJoSXNy?=
 =?utf-8?B?RHBwYWo2SkJidGFtRHFwZU8wa3B0a3libXBYeVlJcS9HcG05cHQyM1Y5alVO?=
 =?utf-8?B?ZDdCTktXZkxlTXlQZ2prSlJ0bTVLTTE2OEJOQjZPck9Ic2RnK0k4di90MkZS?=
 =?utf-8?B?b25OQUhFNWcyQit4bDBkaldya2d0d3NDbnZjV21JdU9DTm1CencyMTZ4ZERN?=
 =?utf-8?B?RmdmRUNrWE1DYjk3VW9pT3dzTlVWMHV2US92QkZhcmFpMHY2cDVyTEd4S1N2?=
 =?utf-8?B?KytQMlgzOGRadnJzRW5pMzBGakFpRGJjUWVHM0UvNGpGbkE2RzRMUjhJUTNk?=
 =?utf-8?B?V2RteENMdks1MjFCMTRUM2lUWWVHUCtKQXJFOGJ3WHNEaDRFakdWZ0d2UzA5?=
 =?utf-8?B?VURPQUJTTEZWckJtU005UkVNcU16STFreitYaWhxVDdMVVlrMEpDUkNRR3lU?=
 =?utf-8?B?RHdocnRZcnhqcVZCdzJ1bmN6OE9yNVYxN21mOXZ1SjBKc3REUGRIeGdnV3Rt?=
 =?utf-8?B?Y3lhaXA3Wi9VV09iczJiUit5RlRiU1JscEg1K1QycFZYMWEzeXQ1azNwS0Zu?=
 =?utf-8?B?cGMvN0t2VDRieDFpVmVpUDV1SmJpZXFScjVYZ0hWeG5kcko5dmM2K1RMTUhJ?=
 =?utf-8?B?MnBtZGpiK1BiRkF4VVo5UTArV2xjWVJKMDlmRWpRWndUbWs5aU0zWDdKM0M1?=
 =?utf-8?B?cTlkUEpwWml3bFo5QjVqY2xmQ3BuelFWWlc5U1c2dkJEZFNpL1lZcHd2bk95?=
 =?utf-8?B?eGVRQzhLRVRlQXN4VytJUHhGY09SdWJVdWNSKzBVZlFxTGtkTFU0RGZ1YWZC?=
 =?utf-8?B?bFpOWHpqNFcveXFoV2hiWmMxQjJZR08zZnREYWJGTTMyNGZwS0ZrNWRTTm13?=
 =?utf-8?B?RFllR3NxcHZ6TGJ1QmhJNDZmdEdtZTBEdWRCWDR4Sk1aak9jS3lUcWdBL0RS?=
 =?utf-8?B?RmJBZTRCY011L0tkQTFpQnVGMTV5OUNublI3U2xWS0RwMVBDMHkyeHNXR0Vq?=
 =?utf-8?B?NHBQbnB3b2Q4Q3d4ZGFvaUhlY3hld0JTM0ZicU1Fb2syZjc0VUlhSkQvUERv?=
 =?utf-8?B?MmdRZHlHUGVBdk11YUh3TXBCMXR6Z0NXdyt0cDBoRHFtSTZ5TzE1dWNLNXhW?=
 =?utf-8?B?dC9KRm9kMi82bjBGdUpxL0RjRFBocnZWWnpUeWVWWWg1TnFFcEVaellDODJx?=
 =?utf-8?B?TUtsd2hvcTdZYlhVMnFYSWJZbFNjNkVLbXVTSXd0dDkzM2JlSWhQdS9oYjUz?=
 =?utf-8?B?SXUxbzJ4RklvYU55ZWlrdmphdDhrV3o5aGFVUDVvZGpjdjkwK0JZNFRhckNV?=
 =?utf-8?B?QkYxR2RxcUFERWVrQVVEK3Z1ZjdFS1pUTnlNNmJyazlqbG5JS0dvVXpzMGhO?=
 =?utf-8?B?cm1HOEpDRXFzRTliZEhodTd3a1Ywck0zK3dYdVh5ZXRvY1M1aHliOVlHcm1F?=
 =?utf-8?B?Vi9JUHV5dVJaa1RQbnRwd09DWDA5WXU3YWFzZW4wOVJ6a0JBUU5tb0xmcm0y?=
 =?utf-8?B?SXFsYUovSVB5clU3TTY3UzBuV3lpVjA1Y28va05TVkF5dkl2Qmo5M29EcG42?=
 =?utf-8?B?YUhxNm5CazFuNnJIaDJSallacHVlbWNLVy8xVU5UY1VtN09zblZGcHRWdSsx?=
 =?utf-8?B?VXFMNmpEM1BwbjIzQmY4TDNNaStNNVhYUU4xQVpvVEp3bEFIVVRCSkVkWG5Z?=
 =?utf-8?B?NDA4dFlvOE9FSnEyV3J2dmJEa25VRjA5eDZDUmQ2TC9NNnU2V3Ftcm85cHpZ?=
 =?utf-8?B?eTBSUERaKzhGZjNDdWJ6TG9jRTc2NGtyL25KYzhVbzdMWStUUnl4QXVjM0cr?=
 =?utf-8?B?TFpQQWtzNWcybEhQZVFuQklWRnUxenpJSWxPRWtVMm5XVzQxc3R4Q01iNG1o?=
 =?utf-8?B?S3NFQjMvL3dxOS9BMkRXbFJ5a1VhWmNYQUQ2a0dWTkxNcUNYeXFoLzN0U1hI?=
 =?utf-8?B?a3JDeDJ6K1NkbEtyaUFJbnhjS2FZdHhHZ2xMaWNLMlRrZFp1dFZlaUtaOG1Z?=
 =?utf-8?Q?melY1vofYMKJ1wugLGoTZ6bwB?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6eb786-5236-4de8-338f-08dd9db6c540
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 07:10:47.6893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u1HDE6HrDqHyK5Hg2TSv4Ied9jEDu0OL1NZciQobSBQ9AUGfu+kwiiB7BssQsB8YOW6eFrKW710YG+ip0omEzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8705
X-OriginatorOrg: intel.com

On 2025/5/27 08:05, Jason Gunthorpe wrote:
> On Fri, May 16, 2025 at 09:45:21AM -0700, Jacob Pan wrote:
>> For no-iommu enabled devices working under IOMMUFD VFIO compat mode, the
>> group open path does not call vfio_df_open() and the open_count is 0. So
>> calling vfio_df_close() in the group close path will trigger warning in
>> vfio_assert_device_open(device);
>>
>> E.g. The following warning can be seen by running VFIO test.
>> https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c
>> CONFIG_VFIO_CONTAINER = n
>> [   29.094781] vfio-pci 0000:02:01.0: vfio-noiommu device opened by user (vfio-noiommu-pc:164)
>> Failed to get device info
>> [   29.096540] ------------[ cut here ]------------
>> [   29.096616] WARNING: CPU: 1 PID: 164 at drivers/vfio/vfio_main.c:487 vfio_df_close+0xac/0xb4
>>
>> This patch adds checks for no-iommu mode and open_count to skip calling vfio_df_close.

thanks for catching it. :)

>> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
>> ---
>>   drivers/vfio/group.c | 7 ++++---
>>   1 file changed, 4 insertions(+), 3 deletions(-)
> 
> Sorry, this should have a fixes line:
> 
> I think it is probably
> 
> Fixes: 6086efe73498 ("vfio-iommufd: Move noiommu compat validation out of vfio_iommufd_bind()")
> 
> By the look of it, since that is what started skipping the vfio_df_open()
> 
> But after looking at that patch I'm now doubting that this is the
> right fix.
> 
> Previously we'd still do vfio_df_device_first_open(), just the
> vfio_df_iommufd_bind() was skipped.
> 
> Now we skip all of vfio_df_device_first_open() which also means we skip:
> 
> 	if (!try_module_get(device->dev->driver->owner))
> 		return -ENODEV;
> 
> and
> 	if (device->ops->open_device) {
> 		ret = device->ops->open_device(device);
> 
> Which seems wrong to me?? We only want to skip the bind, we should
> still do open_device! At least that is how it was before 6086e
> 
> So.. This may not be the right fix.

yes. this makes sense. If not opened, userspace is not able to use the
device.

> Maybe more like:
> 
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index c321d442f0da09..1b6a0e30544401 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -192,18 +192,18 @@ static int vfio_df_group_open(struct vfio_device_file *df)
>   		 * implies they expected translation to exist
>   		 */
>   		if (!capable(CAP_SYS_RAWIO) ||
> -		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd))
> +		    vfio_iommufd_device_has_compat_ioas(device, df->iommufd)) {
>   			ret = -EPERM;
> -		else
> -			ret = 0;
> -		goto out_put_kvm;
> +			goto out_put_kvm;
> +		    }
>   	}
>   
>   	ret = vfio_df_open(df);
>   	if (ret)
>   		goto out_put_kvm;
>   
> -	if (df->iommufd && device->open_count == 1) {
> +	if (df->iommufd && device->open_count == 1 &&
> +	    !vfio_device_is_noiommu(device)) {
>   		ret = vfio_iommufd_compat_attach_ioas(device, df->iommufd);
>   		if (ret)
>   			goto out_close_device;
> diff --git a/drivers/vfio/iommufd.c b/drivers/vfio/iommufd.c
> index c8c3a2d53f86e1..26c9c3068c77da 100644
> --- a/drivers/vfio/iommufd.c
> +++ b/drivers/vfio/iommufd.c
> @@ -54,9 +54,6 @@ void vfio_df_iommufd_unbind(struct vfio_device_file *df)
>   
>   	lockdep_assert_held(&vdev->dev_set->lock);
>   
> -	if (vfio_device_is_noiommu(vdev))
> -		return;
> -
>   	if (vdev->ops->unbind_iommufd)
>   		vdev->ops->unbind_iommufd(vdev);
>   }
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 1fd261efc582d0..ff19ea05442e7d 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -506,17 +506,19 @@ static int vfio_df_device_first_open(struct vfio_device_file *df)
>   {
>   	struct vfio_device *device = df->device;
>   	struct iommufd_ctx *iommufd = df->iommufd;
> -	int ret;
> +	int ret = 0;
>   
>   	lockdep_assert_held(&device->dev_set->lock);
>   
>   	if (!try_module_get(device->dev->driver->owner))
>   		return -ENODEV;
>   
> -	if (iommufd)
> -		ret = vfio_df_iommufd_bind(df);
> -	else
> +	if (iommufd) {
> +		if (!vfio_device_is_noiommu(device))
> +			ret = vfio_df_iommufd_bind(df);
> +	} else {
>   		ret = vfio_device_group_use_iommu(device);
> +	}
>   	if (ret)
>   		goto err_module_put;
>   
> @@ -528,10 +530,12 @@ static int vfio_df_device_first_open(struct vfio_device_file *df)
>   	return 0;
>   
>   err_unuse_iommu:
> -	if (iommufd)
> -		vfio_df_iommufd_unbind(df);
> -	else
> +	if (iommufd) {
> +		if (!vfio_device_is_noiommu(device))
> +			vfio_df_iommufd_unbind(df);
> +	} else {
>   		vfio_device_group_unuse_iommu(device);
> +	}
>   err_module_put:
>   	module_put(device->dev->driver->owner);
>   	return ret;
> @@ -546,10 +550,12 @@ static void vfio_df_device_last_close(struct vfio_device_file *df)
>   
>   	if (device->ops->close_device)
>   		device->ops->close_device(device);
> -	if (iommufd)
> -		vfio_df_iommufd_unbind(df);
> -	else
> +	if (iommufd) {
> +		if (!vfio_device_is_noiommu(device))
> +			vfio_df_iommufd_unbind(df);
> +	} else {
>   		vfio_device_group_unuse_iommu(device);
> +	}
>   	module_put(device->dev->driver->owner);
>   }
>   

this looks good to me.

-- 
Regards,
Yi Liu
