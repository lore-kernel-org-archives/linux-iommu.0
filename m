Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C808529D0B
	for <iommu@lists.linux.dev>; Fri, 21 Mar 2025 04:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742530442; cv=fail; b=ZDxN7YUhLhOWcGAuuWky+JrlaGbmgm4wbER/c3/bemeiTYNU7cNHrgeR0XUEDenkl35cq+VF3riN7A2ZjxQ120LB46ylJD/LnZbLRL7t5Q1W4DOPRW9YL6F6XNrjgqU8Zo7KTFvmYyulGgkOwmYAFHPIVaf6iFuzPQYiLCNefp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742530442; c=relaxed/simple;
	bh=Crbd3IFRxeIW6PU5UK5V0b0qOSbwVtvX2bPCP6u0+Wk=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lonmkGJULOrAhP63xcjIhhA5u/0mIkPTwZXOzBJIJ1O6jKEyEzOtP6gX8uyU2x8ml4+pEPNFTDykxPvtoQSfoDw/IJsW7LIcK8GDywnA0NGW/Ruag5WKcmbQbT6R03bT4bodqo8+jsO1st8li6jZc3lGfwqkw7O141aMFlkuUL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ivn/gMAN; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ivn/gMAN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742530440; x=1774066440;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Crbd3IFRxeIW6PU5UK5V0b0qOSbwVtvX2bPCP6u0+Wk=;
  b=Ivn/gMANigWEuktqadWH/Wag83gXOky0PPtfsOqw1AJl0d83fNnlrMrP
   yU46lvIVcfhVACdR9AMaJDp/5hicSeoTmUZTKQ8qcsNgsv7HRbZRqc3KH
   4PtZiJata7ZSpDZR/qdL8uyOZHpy9zQ6ebMMnRRR3DzRvukHoTsT5MtSO
   n/NPObEnIuVFCuxySdHGya5OlFjne4lbDkVdzKrIUSkufMkoNTUsVmU5m
   cGIv03krUF8iPXFR5ZeNjGG0pnAwhLaREGcHLO53viXqIOaH+OUq4n6l9
   etgsKSaoDGQCbf/KnxrLfr48OQ+nrONylzRcmeXbuxERLneJRkotVu9gY
   A==;
X-CSE-ConnectionGUID: TLRJOC6NR660yfUWBYzgDg==
X-CSE-MsgGUID: xiHs1pRoTXuxnzbWhQBFLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="66255465"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="66255465"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 21:14:00 -0700
X-CSE-ConnectionGUID: AAUX2pL8Th+xzE90zKHDQA==
X-CSE-MsgGUID: 6LGhOCzLSlCRSJDkszsf8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="127447513"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 21:14:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Mar 2025 21:13:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Mar 2025 21:13:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Mar 2025 21:13:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m8S3bGh/p1obBqnDgcFs7f9wHNUV4xArSZf4HQ392dF3JSZEq48O44nTbKnNS5L3xa86bzy1gzNDvFaoHJi4Edv4MqsVSwdllWlw0qD42X7zjOxOkoyn3oMx1LLk2qol911Yv420SvmupbgFXvWoHDp2+92/2qz4vMCvda6gkAmIBs/f7riYE2ND2kw2phGecMeBN7VY7UVPBT0+lnA4bgQyiyaMStmIcFr3gNlPUxBazeRfh2wQb5/+dRQh1GK0S+RiViW/nxEiqPXADYkm9+I60h/6+nLp0AvBNar5BXrIvk+wSwnRiLNHEoJniWg15lf4VbkkIkUnsCcDxArGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFEjTGWl/FvaskkeKwtuS4DbqaIIer+SsF0/10cszmw=;
 b=YWBp+3oQml9Mu+pJfIHmKnY6HcKHu0xBaamVjn12LxW6i11t54rAWNRKj8BWV4KlLYSy61yqlyl+N08kA+9BIKw6nJKZOKFGr2tJ0cOPth+nZ9V5HA0X01/01q0s4qKfWNj5PZCLUt0jF49v7xmImC8IPLRINOHqBweo4iBXjolVyq1EN99aYqWMHY1o1QvLlXds0X+3OX07acKxDMEDqU5JuVYcWOOItHxnlkFx2WazVjEpgX/3P+sXUYnaTbZGmcHowQUebPdvQjoyY/ywEK6Jomtn1ZSz5JWu+b5bicrgV3bQVWSG5p0XI2NlrYeY0qvzL+Kp9wCYO6bu81sLpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by BL4PR11MB8797.namprd11.prod.outlook.com (2603:10b6:208:5a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Fri, 21 Mar
 2025 04:13:56 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8534.031; Fri, 21 Mar 2025
 04:13:56 +0000
Message-ID: <fd7e174e-f73b-49b1-b854-5d7f4811689e@intel.com>
Date: Fri, 21 Mar 2025 12:19:22 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 02/18] iommu: Introduce a replace API for device pasid
To: Baolu Lu <baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jgg@nvidia.com>
CC: <joro@8bytes.org>, <iommu@lists.linux.dev>, <nicolinc@nvidia.com>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-3-yi.l.liu@intel.com>
 <bcbe2747-a76c-4f3e-ba40-787a2a55b1e4@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <bcbe2747-a76c-4f3e-ba40-787a2a55b1e4@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|BL4PR11MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f38ba85-c8b1-419a-d826-08dd682ecc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cXVjSDFXVVBsak93ZUR1ZFU4cDlsZmQ5NDFzdGkyMjhkYWZ4MzdoblJxQWhG?=
 =?utf-8?B?UGF4TVFUUXZ5U3hOUWVLclZGQkJiZE5jSWpBMlcxZFpjNFZ5SkJlQ0tJUFFO?=
 =?utf-8?B?QkNkak4xNHcyMkNoeHErNURrYk00TzV3VU5MODdoZHZReTFEMGJ2OVA3N1dZ?=
 =?utf-8?B?T1daSnZpK1ZSSkpPU1htdHhYUWNCMGd0c0xVaGx0MTRDSjFOWUM5Y1RTVUNl?=
 =?utf-8?B?TUI5OTJCTS85cHJCL3V2R08yRHNyamh1by9UVFZCaUw2Sk5HOGJEVmpXbE1v?=
 =?utf-8?B?Q0h5V0gydmpzNThBdzRONnNYeDlteGE4bDA5cFpwbkdGMTdOVktnQldSYmRw?=
 =?utf-8?B?UHdvUy8zUVBMVzhsZk1rT01xNUxMV2dYdi9lMEV5OUZlRDdRNFI3c2x1SDJB?=
 =?utf-8?B?RTlaUHJZMDhTV09RSWFKZmNkK2tIdjVTazE4NnAxMk1aanRSc2MvU21KSmZi?=
 =?utf-8?B?OENuTkRHQUtzZzFFNHVYRXdwKzlSbnUxSHYvWUVjZ0VMVjFuWlJ5dFVLUlZq?=
 =?utf-8?B?WXhFek0xNXh6dFBJdlVoOEdjTUZLdlF0S0haa3lUd05VKzdreTRBTnFlZHNQ?=
 =?utf-8?B?NHNtR2VNY2tYc2tWNi9uZi9VRDhZd2tCRXBNK0NRZUxLcGdDSlk3eHRPazZR?=
 =?utf-8?B?eStOZHo0cGlPemVlbmIzNUprWC8rTzZvMlJKa3RTcldsRko0cFVVbXhlL2pI?=
 =?utf-8?B?SElOM1NSaHdVVExtd0kyVVgyMjY0ZncrOWZsckVWMFArc3I1czV5SC9rc1Uw?=
 =?utf-8?B?cUpRYldWUVRWSEMxb0k1N0RuOU9tWW1CUUViVmtEZ1B0ZndZNXdNVEpvZGRn?=
 =?utf-8?B?VWJ5UUJraG1kQTdDblRnM0lpZVgwU2tqOWJraDh2aW56OCtRd2dkNUU0WWtu?=
 =?utf-8?B?bjRqdmkwWXpuK3pNVG9uTElxTk9nY1ZEVllqS0VpSkdsa3QyM0NRbjcxUjMz?=
 =?utf-8?B?WXNSaElJMk5DTk1OQi8zNkx5MTF5aU5LNHZTMXMwVDUrQjlKZk1yNnl6YUR2?=
 =?utf-8?B?Nng2YXhRNkZCVGFVeWdGRWhrZDF5V05SelhuT1ZFSCsxUndVUEhxSkl2NnJn?=
 =?utf-8?B?WVUycVJEZzlIOFJSNWpTbXlyZ1BEdFlxaG5neWxleGZpZHlNRVladXdqOU9O?=
 =?utf-8?B?dGQ3QTY2TEpncUV5aGNZVnh1R0xZM0QxMjFWUjZBSHBZM2tRYjVycmpMeFh6?=
 =?utf-8?B?Vk1rOTlmdnBBSFRkdS9VSW8vSWlna2hpaG1xbUgvQWRFUEVZVWhmVHdjbDMr?=
 =?utf-8?B?Q3RmajIyMENBSElON2dWLzJGSmNhYTMrckNjTzQrbW9FS2F2ZEN5dW9nZWhj?=
 =?utf-8?B?RnprMXJoWk1TZmUvZmt6ZlZydGsrUFF1aEc1MHJWRlMwWHh2QTl0elN0dk1K?=
 =?utf-8?B?WHNaUmRLKy9uZCtLTHNaWWRScStwWUVROTBBNkNhQ2FaOEtlc3JEbks3enU0?=
 =?utf-8?B?MkdFekhvYXRwMkFRQUVUM250MWR0WElZb251WGtRSUMvenRWNDJrL0t3TEdL?=
 =?utf-8?B?N04vUTZLa3dSS2VyNFF3bkdzckRZcjIzaGo2WFg3b2dmRlhhTkxpVnVlN3Ba?=
 =?utf-8?B?WHpmcUhnMmZwQ3BXSkh5UEpvSGRnT3g3VDNqNVpRSitGRksvamYrVDNRdkNW?=
 =?utf-8?B?Ym42OW1kMThrWmxKelFINE52eDV3WVVTS2FTL05kZFZ4NWFzRVhqdTEwRHVt?=
 =?utf-8?B?UFV0Nm9HSTZ6Y1UwR2RsMlpwSFJZZHA3VCtJSkRqVG92OVhUM3lFV3kzcmNk?=
 =?utf-8?B?V1o2TXRsS0F4UnhCcG5XenFGcG5adW54ZG1iSlBLWS82UGNJVEpIMjZ3ME1h?=
 =?utf-8?B?SElINW4yZ2p4aXhnVHZwSWF6aWx4OUU4aWdlcysyOS9KenJUQUZSRlNPZklj?=
 =?utf-8?Q?wG42RigO4atUR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2hmUGp3YXNBWEhLam1LVGc3dGVwaWdoN21QaGtLUDlWU1NnZVJwOERPQkRy?=
 =?utf-8?B?bXJpY2pmQU9Wd0ZnZG53VDQrbUZyWFRGWWJELzVkZVlJbjVaUzcwWWt6a0Uw?=
 =?utf-8?B?ajJ2VjdoazBGNVE0YmtNSDVkK2ZZTitYejRiWEY3R2h0a254ZWc3dXNDSUVW?=
 =?utf-8?B?NFRnQTBkMnJHK3IvS2Y5VFRVTTU1WHJwenRRbldKUU04dm1wOXBibnU2dVUy?=
 =?utf-8?B?SllVOHd1L2ZLUkpvWTdRS0FaZ2g3ZUZBMzhTZ3ZPa0o4K3Q4U3NQMmVYREJa?=
 =?utf-8?B?TlRWZVl5T05rb2ZCQksyQk9HazVHcmtaM0hTUzZTVVkva0doRDVRYWx0ajZX?=
 =?utf-8?B?SzFvZ0pmbnhCVWpVV1dZWlNXVERTUVplSmpWOHROYUJablRRN2I3Wnkwalo4?=
 =?utf-8?B?cUg4K2ZkOW1PYmJXeko0WXJnZ0N0RWs5OFJLU3VsN2kvZncyaVNUTlRjM3RB?=
 =?utf-8?B?VlJIVUVCSnROZ3ZQbUMzS2xxM0JhVERkd2U2WUt1WDcrZlBEYUxtaVRsR2Va?=
 =?utf-8?B?UFdvYVNubml5SVE0alVzN2QyM1JDbGsrM2dieVU3YjlNaWM2QStJdkxXU3R5?=
 =?utf-8?B?RGxpVHcrYkRHOWZ5V2pnODliVk5LNlhYaUFkZ05SS1RRWFh2NjdraG5Fd01Q?=
 =?utf-8?B?bHNKRGFTL0RhUnlZcGVxanJqV202YndDM09sNWdiek55UkdXdnZJNXBFb0cy?=
 =?utf-8?B?VWpqWFF6dkc1bDJuYUtPTUVkSE5yYjQraTdvQUxiRUl1eUNYNFoweHRpRDJS?=
 =?utf-8?B?c2tFMlBDS2xQbmdaSUhjeldFKy85bWdmSURHU2hLQ3Nwa2JNS2JvRHYwNjNm?=
 =?utf-8?B?MHRJUHR2U1lObTg3Y2FJT1d1NU52SjdWOTRtUTZ0RmlRNEVUa0RKZE55S2sv?=
 =?utf-8?B?QTIrbEZNSzVWM3dyb3NzTXYwUUhjZm5QMnhNSGxQMzNQcWw3QzA0THdqa0Iv?=
 =?utf-8?B?amhtVVBrYUlVREVJYVVTSW1nU1hscWtqNzhpSkEyTFQ1cGdwalRlQ1RlYVky?=
 =?utf-8?B?S3lzQXFEODRjM3psazJUZ05PNE1DU3pPRW5KSCtxM3RQQkNVS3ZBeHV6anV1?=
 =?utf-8?B?UWMzbStUaFIzKzhuV0FiMHdvQVBqN3BiUk5uWFlrRTY3WmpwS0R4REZEa3Fq?=
 =?utf-8?B?TkFXTkF0RUxlREdsY09nclJjOFRiSHhQTnRiNk1oMldYOUM5ang2VGlUN0Zy?=
 =?utf-8?B?dFJrOWhpWnVTSm1waDBPQjFnNC9ydmpOZFJFcmlGWXJXTGszM2NSRUhJaGFy?=
 =?utf-8?B?bHJRS2xvdHUxaFdNRmcxMXk0dExZYnlWYkpaUE05RXFiZ1gvczIrSENOSWly?=
 =?utf-8?B?WHJIQ0xCS2ROalZLSnBxdmQvMXpTNEYrR0ViRHU4VUE0cnFvZ3dOcGcwcHk5?=
 =?utf-8?B?K3QvaW54QzVBV3FwcUIvaXBaRGpZTmplbzZ6S29XSUJQOXVpZG5kS1BsVnRL?=
 =?utf-8?B?eXQ1ZERmQ3JXNTdwUFZ1Vk1FOVNCSWJMdTNIa3lqalFvMndiTmpEUXlXaGVl?=
 =?utf-8?B?TjVHWU9HT0RMRmZ1bWl2M0RjbHoyakU0U3E0SFRCcEZrUTdxQi83R0xjY2k2?=
 =?utf-8?B?cjVETEJaWlFyaGxmUVprdklybnE1UDBWc0RCQ0tmMkZYbUp2UHdEbU9rUlVM?=
 =?utf-8?B?RkxId2oxcGpvR011aVBaMFJaM2FwTDRwY2hrcnNQZEI4U2JTaFhmQitQSFpx?=
 =?utf-8?B?K0EzTFFxcnBlU1poNVUxK2tmTG50VlZBMG5GMHlaWWRyWkRDWTVnMVRncG9Q?=
 =?utf-8?B?aytpaFBXMVQ3czlIWHoyclFnUFVFWEFLQ2MwZnBuTk0vV1cwL2g0SlNjNnlL?=
 =?utf-8?B?QVo2Z0ZqMjdJWFRIdlF4WGRyVEJvSmNWKzFobGE2N0NiUUREZWJPcUpPWWZ5?=
 =?utf-8?B?YUZkVmxEQkQxZ0hzeVkyQUpHOFB5UVA0NmREa0VvbTU0K3F4QzI4emg4SDRq?=
 =?utf-8?B?Z3FPRE9RRldlUXZFRkhzc2ZjVFBoOEkzWms4eHpQcWQ3Z2MveElIalpnUVlU?=
 =?utf-8?B?aEZlUFM1MFRJOWNleWNpN3ZCU2lSNm5BZjB6NGVub3lNdmxpbFZmbE9rbFJ6?=
 =?utf-8?B?V0dOLysxa2JHZTRiT2czdzJlNDNiZVdLVXhMVWYxL0xXODJGS2pUdkVQWkh3?=
 =?utf-8?Q?GRbwDuzIAeT5kX4UPtWEkW1+5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f38ba85-c8b1-419a-d826-08dd682ecc76
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 04:13:56.7763
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6mECcX/2umdi+j4j/2Zs3Dc3ARQ633j23n1uIu2Ti8yaWWZcrgVj3YSyx+M1RGWwfr+v+IQVRxzEuygwHJwhVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR11MB8797
X-OriginatorOrg: intel.com

On 2025/3/21 11:08, Baolu Lu wrote:
> On 3/20/25 21:47, Yi Liu wrote:
>> Provide a high-level API to allow replacements of one domain with another
>> for specific pasid of a device. This is similar to
>> iommu_replace_group_handle() and it is expected to be used only by IOMMUFD.
>>
>> Co-developed-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
>> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
>> ---
>> v9 - > v10: Convert to the v8 version, added a check to fail the case
>>              in which the passed handle is equal to the existing one.
>> ---
>>   drivers/iommu/iommu-priv.h |   4 ++
>>   drivers/iommu/iommu.c      | 117 +++++++++++++++++++++++++++++++++++--
>>   2 files changed, 117 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/iommu/iommu-priv.h b/drivers/iommu/iommu-priv.h
>> index b4508423e13b..2985f05d699f 100644
>> --- a/drivers/iommu/iommu-priv.h
>> +++ b/drivers/iommu/iommu-priv.h
>> @@ -43,4 +43,8 @@ void iommu_detach_group_handle(struct iommu_domain 
>> *domain,
>>   int iommu_replace_group_handle(struct iommu_group *group,
>>                      struct iommu_domain *new_domain,
>>                      struct iommu_attach_handle *handle);
>> +
>> +int iommu_replace_device_pasid(struct iommu_domain *domain,
>> +                   struct device *dev, ioasid_t pasid,
>> +                   struct iommu_attach_handle *handle);
>>   #endif /* __LINUX_IOMMU_PRIV_H */
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index cffd96e3efd2..07134bb85c00 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -513,6 +513,13 @@ static void iommu_deinit_device(struct device *dev)
>>       dev_iommu_free(dev);
>>   }
>> +static inline struct iommu_domain *pasid_array_entry_to_domain(void *entry)
>> +{
>> +    if (xa_pointer_tag(entry) == IOMMU_PASID_ARRAY_DOMAIN)
>> +        return xa_untag_pointer(entry);
>> +    return ((struct iommu_attach_handle *)xa_untag_pointer(entry))->domain;
>> +}
> 
> It's not good practice to put an inline helper in a C file. Probably
> change it to a regular function or move it to iommu_priv.h?

got it.

>> +
>>   DEFINE_MUTEX(iommu_probe_device_lock);
>>   static int __iommu_probe_device(struct device *dev, struct list_head 
>> *group_list)
>> @@ -3311,14 +3318,15 @@ static void iommu_remove_dev_pasid(struct device 
>> *dev, ioasid_t pasid,
>>   }
>>   static int __iommu_set_group_pasid(struct iommu_domain *domain,
>> -                   struct iommu_group *group, ioasid_t pasid)
>> +                   struct iommu_group *group, ioasid_t pasid,
>> +                   struct iommu_domain *old)
>>   {
>>       struct group_device *device, *last_gdev;
>>       int ret;
>>       for_each_group_device(group, device) {
>>           ret = domain->ops->set_dev_pasid(domain, device->dev,
>> -                         pasid, NULL);
>> +                         pasid, old);
>>           if (ret)
>>               goto err_revert;
>>       }
>> @@ -3330,7 +3338,15 @@ static int __iommu_set_group_pasid(struct 
>> iommu_domain *domain,
>>       for_each_group_device(group, device) {
>>           if (device == last_gdev)
>>               break;
>> -        iommu_remove_dev_pasid(device->dev, pasid, domain);
>> +        /*
>> +         * If no old domain, undo the succeeded devices/pasid.
>> +         * Otherwise, rollback the succeeded devices/pasid to the old
>> +         * domain. And it is a driver bug to fail attaching with a
>> +         * previously good domain.
>> +         */
>> +        if (!old || WARN_ON(old->ops->set_dev_pasid(old, device->dev,
>> +                                pasid, domain)))
>> +            iommu_remove_dev_pasid(device->dev, pasid, domain);
>>       }
>>       return ret;
>>   }
>> @@ -3399,7 +3415,7 @@ int iommu_attach_device_pasid(struct iommu_domain 
>> *domain,
>>       if (ret)
>>           goto out_unlock;
>> -    ret = __iommu_set_group_pasid(domain, group, pasid);
>> +    ret = __iommu_set_group_pasid(domain, group, pasid, NULL);
>>       if (ret) {
>>           xa_release(&group->pasid_array, pasid);
>>           goto out_unlock;
>> @@ -3420,6 +3436,99 @@ int iommu_attach_device_pasid(struct iommu_domain 
>> *domain,
>>   }
>>   EXPORT_SYMBOL_GPL(iommu_attach_device_pasid);
>> +/**
>> + * iommu_replace_device_pasid - Replace the domain that a pasid
>> + *                              is attached to
>> + * @domain: the new iommu domain
>> + * @dev: the attached device.
>> + * @pasid: the pasid of the device.
>> + * @handle: the attach handle.
>> + *
>> + * This API allows the pasid to switch domains. The @pasid should have been
>> + * attached. Otherwise, this fails. The pasid will keep the old 
>> configuration
>> + * if replacement failed.
>> + *
>> + * Caller should always provide a new handle to avoid race with the paths
>> + * that have lockless reference to handle if it intends to pass a valid 
>> handle.
>> + *
>> + * Return 0 on success, or an error.
>> + */
>> +int iommu_replace_device_pasid(struct iommu_domain *domain,
>> +                   struct device *dev, ioasid_t pasid,
>> +                   struct iommu_attach_handle *handle)
>> +{
>> +    /* Caller must be a probed driver on dev */
>> +    struct iommu_group *group = dev->iommu_group;
>> +    struct iommu_attach_handle *entry;
>> +    struct iommu_domain *curr_domain;
>> +    void *curr;
>> +    int ret;
>> +
>> +    if (!group)
>> +        return -ENODEV;
>> +
>> +    if (!domain->ops->set_dev_pasid)
>> +        return -EOPNOTSUPP;
>> +
>> +    if (dev_iommu_ops(dev) != domain->owner ||
>> +        pasid == IOMMU_NO_PASID || !handle)
>> +        return -EINVAL;
>> +
>> +    mutex_lock(&group->mutex);
>> +    entry = iommu_make_pasid_array_entry(domain, handle);
>> +    curr = xa_cmpxchg(&group->pasid_array, pasid, NULL,
>> +              XA_ZERO_ENTRY, GFP_KERNEL);
>> +    if (xa_is_err(curr)) {
>> +        ret = xa_err(curr);
>> +        goto out_unlock;
>> +    }
>> +
>> +    /*
>> +     * No domain (with or without handle) attached, hence not
>> +     * a replace case.
>> +     */
>> +    if (!curr) {
>> +        xa_release(&group->pasid_array, pasid);
>> +        ret = -EINVAL;
>> +        goto out_unlock;
>> +    }
>> +
>> +    /*
>> +     * Reusing handle is problematic as there are paths that refers
>> +     * the handle without lock. To avoid race, reject the callers that
>> +     * attempt it.
>> +     */
>> +    if (handle && curr == entry) {
>> +        WARN_ON(1);
>> +        ret = -EINVAL;
>> +        goto out_unlock;
>> +    }
> 
> "handle" should never be a NULL. Or not?

yes.

>> +
>> +    curr_domain = pasid_array_entry_to_domain(curr);
>> +    ret = 0;
>> +
>> +    if (curr_domain != domain) {
> 
> Is there a real use case where a caller needs to replace a domain with a
> different attach handle? If not, let start from simple, just don't
> support the same domain case...

The RID path allows it. __iommu_group_set_domain_internal().  I think it's
better to keep the two path aligned. Especially, there is chance to
consolidate the RID and PASID path in the core[1] as well in the future.
There would something to be done before that for sure. :)

[1] https://lore.kernel.org/linux-iommu/20250228151250.GT39591@nvidia.com/

> 
>> +        ret = __iommu_set_group_pasid(domain, group,
>> +                          pasid, curr_domain);
>> +        if (ret)
>> +            goto out_unlock;
>> +    }
>> +
>> +    if (curr != entry) {
>> +        /*
>> +         * The above xa_cmpxchg() reserved the memory, and the
>> +         * group->mutex is held, this cannot fail.
>> +         */
>> +        WARN_ON(xa_is_err(xa_store(&group->pasid_array,
>> +                       pasid, entry, GFP_KERNEL)));
>> +    }
> 
> ... then the code could be simplified like this,
> 
>          curr_domain = pasid_array_entry_to_domain(curr);
>          if (curr == entry || curr_domain == domain) {
>                  ret = -EINVAL;
>                  goto out_unlock;
>          }
> 
>          ret = __iommu_set_group_pasid(domain, group, pasid, curr_domain);
>          if (ret)
>                  goto out_unlock;
> 
>          /*
>           * The above xa_cmpxchg() reserved the memory, and the
>           * group->mutex is held, this cannot fail.
>           */
>          WARN_ON(xa_is_err(xa_store(&group->pasid_array, pasid, entry, 
> GFP_KERNEL)));
> 
> out_unlock:
>          mutex_unlock(&group->mutex);
>          return ret;
> 
> Anything overlooked?
> 
>> +
>> +out_unlock:
>> +    mutex_unlock(&group->mutex);
>> +    return ret;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(iommu_replace_device_pasid, "IOMMUFD_INTERNAL");
>> +
>>   /*
>>    * iommu_detach_device_pasid() - Detach the domain from pasid of device
>>    * @domain: the iommu domain.
> 
> Thanks,
> baolu

-- 
Regards,
Yi Liu
