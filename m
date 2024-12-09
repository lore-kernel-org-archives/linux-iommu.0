Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879A920ED
	for <iommu@lists.linux.dev>; Mon,  9 Dec 2024 03:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733713517; cv=fail; b=s4QuJ674BUMHCqOlaHQd+b1ToxDI/4X9EOGw3nqSb2wLBr/YpSRt1BuwKBgzSCD8ytf3+6IB2KJ7ZFH6L/s3+b7RIW2KL2T1MXvoVdSFdhgmOqJ/zXJwTv6JNtNqQtEmJeG5+WI65JU+ge8BmA6SDB/NP36NvWbfXWeq8Q8rRiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733713517; c=relaxed/simple;
	bh=owQHEzp3+4DZDeJF+n51jfmjdGzkhyGEt1QK5bmiSng=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HAsZrAqP5BUP5L/4xsHV35pZxqfZYeIGo2L6Yc/X9bFNVgpsy7lXPF4jdlMTs1Ym456TklnDmyjk2LpnKbl9h/KU0VENrMKi6tNuLZr6BhlTfZ+mvDF5zA/LWq1IwebEFU4dj5fZKtG62LSHjB2pP0HgGQRj0CEjxyDj75KJJ6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9URMgD/; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9URMgD/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733713515; x=1765249515;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=owQHEzp3+4DZDeJF+n51jfmjdGzkhyGEt1QK5bmiSng=;
  b=W9URMgD/wAh4VybL2LRAgSMFPniaqW9jK6X8G15U4tGAQAjRJkTAwKii
   d9yXJEjPJhSpbxd3/6Vb6ndoVCLHQ6eRrWOljXvT2A3WfeiRazhx3NFjX
   f8EzWUiJNSlK/6bb2ZwoJog0tixiC3C4UKkT33n+jD1zae/O6Au05aa4o
   hbPnasK1re/SFPkwpVUindbhsYeUtHQSo0v5Wki2t/yQ/wXuf1m5obuXT
   T/ZgfYFnifwT3aLHfUt0XGlqbqqPHqbOfFDSu7GOhDe/KSCTKDT+S4Exx
   u8HUNI1XguF65KrSTvvov2gZzDYb4+LtagpscLZhcsrB8BnZJ60/h9wdi
   w==;
X-CSE-ConnectionGUID: UybipXuJS6+OZHt2JPpAvg==
X-CSE-MsgGUID: r6YhuvuvTTS8OzcpoR1WcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11280"; a="37676745"
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="37676745"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2024 19:05:14 -0800
X-CSE-ConnectionGUID: 1CI6gI61SW2JEGsjq4y8ZA==
X-CSE-MsgGUID: jBWKfS/BTi6dwjejmeEc5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="99887589"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Dec 2024 19:05:15 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sun, 8 Dec 2024 19:05:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sun, 8 Dec 2024 19:05:14 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 8 Dec 2024 19:05:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2p9hB4yIQXM7NPV5Ydzr7Vfaxn1DfwCjvruRjFYFqMPZGbKq0vd02fi2uGJqrgZRct28oJtBkB4tBRKUmQGo2clxX5YtF2cfMfpFPLBVeNh0O3Ppwx+9RlHtY2Pz4NAwqtToV4CZiif/g0SFBwVG3hAgwExUH1auvl+Ipv2u4y6reYsPHdOLQJTZo/5P5lbq1Wf4Y7AEUCxNiFBxWoZyWgTzdBMGiPT4iJ2i07AQ33Qx/K4Fwfc2hmwoPgTvwjn6qbaBfcwDVyT/1Fj99znd7ouVv1MaxWZQJu6CxC70j0uUtHeaHJ5aAFLGVoll7qrYwp1/62RjGuhePC1o5piBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xgsoktaroAoi/VajNMnPauf5rjrT0vEGZ/z2kO+8sI=;
 b=WuoKTEDetVtBn6IMunpoCuhKX4WuzR9rnDDda4QT7lW3xSUsPZF35BD/TDaYrF7uRonH3mB4MNQjNRo2/R5Uxwrl+A1iXLdKr1nmbXdN1KpGvuUWBwnwWaCBnkTWJE5qo+nTTW7h4YjyFU47pYIMlSo/2AK6tHeRDr3wrsXq/nk7mknG910QeeA8FJ1Jxd4c1DhQ3aIfzSBEFrVXvrqY48SuXr8HevngLimLh5NuzCQj6DwvSMXuySxJN7tuc0cjsVUGp3ihnb7TMbW898pf2WxMJzikXeV17QULe/sAKYHy7bQy0lxhP07izxtaXlINmEkEdlU/K2r2wLp/oUjoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DM6PR11MB4561.namprd11.prod.outlook.com (2603:10b6:5:2ae::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 03:05:12 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 03:05:12 +0000
Message-ID: <4f7ca7af-5c5e-4d00-add6-47625f38c8e3@intel.com>
Date: Mon, 9 Dec 2024 11:10:10 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix qi_batch NULL pointer with nested parent
 domain
To: Baolu Lu <baolu.lu@linux.intel.com>, <joro@8bytes.org>,
	<kevin.tian@intel.com>
CC: <chao.p.peng@linux.intel.com>, <iommu@lists.linux.dev>
References: <20241207120304.5710-1-yi.l.liu@intel.com>
 <ce413d97-ec46-4cd9-932a-af804cd531cf@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <ce413d97-ec46-4cd9-932a-af804cd531cf@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0006.apcprd02.prod.outlook.com
 (2603:1096:4:194::8) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DM6PR11MB4561:EE_
X-MS-Office365-Filtering-Correlation-Id: b1fb0fac-d1f7-4a23-e1fc-08dd17fe4bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TnhlcFA1Q00yUGFRdWJMRHdiRVB4czN1Zm5JRyttL1VqYjd2UHgrSTVhMGpm?=
 =?utf-8?B?K0VZdGdJRVFLeXpEMVJnVE1qdUh0YUp0bGgzMzFJc09TMDBhR3VERUkwU29C?=
 =?utf-8?B?Y0VlZjNNbkxEdzJIanZFd0ZHLzkvR3E2RTVPR2EwREdwYWxod3ZzcnhiNG1P?=
 =?utf-8?B?RjRjaW04VU5uZWNuQ3N3YVJyeWRSVXpYcWZXeXZZNVhoY1ZRdVdlUnl3SHRI?=
 =?utf-8?B?U2ZEVkhvSzVyUUtKYzNlbWE0K25RMGJqbWNiOEpuUDV5aEtXNGNqWVVSODZJ?=
 =?utf-8?B?dndrMHd2cnVjclRVTEswN2syUXFia2kwbVpLN252dldISk5GSy9VbHNWSGxL?=
 =?utf-8?B?VzdCcGIwTWp6NEx0QzNoazJYS0t0a2hDMnZDYzZnWTVFT0N5bVFneG55WEhv?=
 =?utf-8?B?ZFE4Q3FwQ3NpVGY3TGRQYzFncURCNUE4ODVuRGhvMHh2emlEVERtbTVUY3pT?=
 =?utf-8?B?Ym1rU3NabXlRRmo5eGJuQ2RNYTZkbVlvZjFWSlFIMjFiQmJMSlo3b3E3SVI5?=
 =?utf-8?B?ZFBRSmhnRmhWcjJjWWkxT3VRZW9lRW5QNEFQRzI1dzRVdXpKQWloRmFMK2Jt?=
 =?utf-8?B?NXdyOTc1blRyNklnMmFqZ1dOeHhXeDlVekhQRnVKV1djaUF0VVNTeWVGMkhM?=
 =?utf-8?B?QzB3eHVTc3I5cWo5djAyd1I1bWx1ak5TNGczUlplOVh4amJ6VTZWQWoybUdL?=
 =?utf-8?B?amc0enJ2MitwSlkvRnVpR01XdmJhTElQTVM5NVdQekdpQTdoUGcvZTEybTZO?=
 =?utf-8?B?WUM5Zk9zRnQxVzlaWlBjV3JEV1Zzdm9ERmxJK0t3c0llTklsbkwzUzF0Nlpm?=
 =?utf-8?B?ZWg2MUdDR0NDNjFnZ2hzcWJyWjZlNkZzUjJxSTYzMlNYK0U4bG4vbmpYQS9p?=
 =?utf-8?B?RkpZOXEzRytrNmZESTNZQkIwci9GcmpieldjSGtFcGNITDhIZkU4R3ZaNU0x?=
 =?utf-8?B?NjZLT1FXLytNWUIrMEsxT01lVFFJQlJIQ200SnZBaDZ1VVpCWFBHMUt4dlFG?=
 =?utf-8?B?WGJmRW9FeHNkaFFucHdBQmt2K3IzbUI2Y0dheSt2VzFpMFcwWllIVVF3eTR0?=
 =?utf-8?B?ZU1RTW5MdHBtc042ZWdDOCtqQmJRSzUrNnIxRWJrTHM5WmNXM2RaQ09Vc3l3?=
 =?utf-8?B?SVRLaVBoT1orei9CSHBqQXJ4NWFSbmt5bDFGM3FlWTVoYmptUVAvMWxYL2Uv?=
 =?utf-8?B?TkxnSlMxTVBjczhnbGVjYjFCWWN6YjBvcnE4OVA1S2JMK3paTGhKSGFJQVlU?=
 =?utf-8?B?azRLY3pZT2p0S2ZKdm15b3loa3owcjg3U0FOMjI0SWx6QkdIMnpxY1Y4cHd4?=
 =?utf-8?B?c0FaaW1SMUtlM2xlLytzZElvYVYveDhkZjZEbVkrVDRaRHlkSmVTR3FlN1Jp?=
 =?utf-8?B?Slc5QmxUTmIraWpDSm90eW95elNpbCtzMFhZWm8rZ0RtN2RraHg0U0xqS084?=
 =?utf-8?B?clFzMWFzNkVBVndaK3VnUkNvZFB0NWQwQnZQclRqSFB4L0drQThsLzd3Z2pR?=
 =?utf-8?B?dVNGMU1JMWMreTlMRi9OdnE5dDdvRmNZRUcxVWZ5d1VLcXFrbm5YZ1J2Sm5J?=
 =?utf-8?B?QSsxNEYzMVVwTDdwSmQ4QUtLbkNwR0tMS3ZaUkV3dVNMTC9yRE4xUjh3dmsx?=
 =?utf-8?B?UEtFR0lZTWhqUE1BcVBZa2pST054M1R0UFA1aUQ1dTh1OUFSTnF5b3l4UlZZ?=
 =?utf-8?B?U3lEYlNha0diN2syM0E5TXMvY01VdnY2MWsvZjBCWERnVFd2ckl5S2JIMTJE?=
 =?utf-8?B?VVp1THVERkFvWlB6aDBOM2JKTnhEUEpoeVR4R0Npbmt6dDJRb1pDV0lPWG5I?=
 =?utf-8?B?eURMdW0wTVZCazl6a3pNUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2RySjZNakdWdlJ2N2lPSnZqY2NrUzhXbTEwQTBaSXZiQXhINWcrZzlkamZh?=
 =?utf-8?B?YWJLamhJUEZsM0JpZEd4cmtSVUR6SzA0SHNyeDA2Q1FsSVlnT0FUNzQ2dW9T?=
 =?utf-8?B?alRsU1RSV0QyUTg5eXRtZ1dlU281UlBiMnVlVnBLTWVXSHdySjVKRlpjY20z?=
 =?utf-8?B?VzRva0NGL1lSQWxoMGdSa3ZWQVBrWFFoeFNxb2hlME1qL0Y1V0ZSV3EzVEhN?=
 =?utf-8?B?alhjQmJUQk9peG1VRkRqZmFQWGVpMkJtZ0gzL29FVmFhcjJrdmZOczlEZFFF?=
 =?utf-8?B?Z3JpTS9qUWhHRDUwWDlLT3g5SXEzUkxTN3o2b21EUkNmczYzTm5janZCQmt5?=
 =?utf-8?B?VEJCb0VqVjBWeDFQRk9XQk5xM000Vm9UVFd4V1ZRN0JEOU8rOWpRY1VNZWdR?=
 =?utf-8?B?NHdOVGFOam5UK3J6VURBc21WdU9yRVEzOU40WlhlZWI4em9WQ3laWjdBWllh?=
 =?utf-8?B?VVRFanJ4VUtOeFFWWnpxaXM2NXJwZ3l2elN0bXZ3R3lEeXFabDYzQzlWWGpr?=
 =?utf-8?B?bnh2NzFaN09jcHltVUlrOGJ5MklhTlJxemduNDc1dk5qcE9oTUZNeTdLMlhU?=
 =?utf-8?B?cXB1NktOYWl3Tjh3dGp4QlVCWVYzRFlybEp6WkY4b3BvcmFSQUNlNTJNeW1I?=
 =?utf-8?B?RThNUHBTV2Q1VjQ4c0U3S2VNVEZyRWdXcWlQcUthT0JQQlpTdXhtdG5WRW1r?=
 =?utf-8?B?eDdZZUFMOXBKYkFzcEVnYUpNaFJhNEFURDhROTcxSWhXckpHQkRabUJsQVRr?=
 =?utf-8?B?YjR3aXozdmZJMDIxN1RXVFk3a0NCZmdpQXNwaE5UY2FKQ3M4c2FPUW55dGR5?=
 =?utf-8?B?ek9yOXVIcStxSSs3Yk1jWE1sUlZSaVJpYUI1anV3L0ZvVXZkVUJXL3RHc3Bn?=
 =?utf-8?B?ZWp5dnYydmROcmN4WkxOVkVyeHVpUnNRL1J5bC9UcXZJTGxuOHdTWHIrYS9M?=
 =?utf-8?B?Njk1bkxXelRPWW4zRTVSaisrQURLZGM4RU9CcGN6djVJajRBSDhhbWhJQ0kw?=
 =?utf-8?B?d0xKUDNvdWlKMHJtK0l6eVF3bmJRbndYY3hFOEMvdjFieFRlSnlRRjBuekFG?=
 =?utf-8?B?dkxGM0ppM1Y0dXdaTXRzVmRHU0Z5aU1UTld1MHl3OElGbllRT2RVR28xZHNI?=
 =?utf-8?B?eVp2L3dMS0pBYmw3MGg1U1BCSlR0WXFRWFRiM29oSXFIa20rVFlOYitva25Z?=
 =?utf-8?B?eEcxN25UWkcyeGZQYXNzcFQxSUNuV2xSTHJPWFkvZUF2UVUvc2dCS1JNMUgx?=
 =?utf-8?B?d0tEaThhaXVZMGpycmNJbFk0RGhUODBkdkdiMHdkMHFSQm9rSUZ1Mk5Nak5w?=
 =?utf-8?B?VGN1V0lrZWUzOUFtd3VpYnpPajhldE5NVTF1bVVXQmxOWGRaRkJpY3k2VWpO?=
 =?utf-8?B?RFdvSHppWkh3cFlLOEdQQzgzR0FJN21HZ2lxTUJ2TFU4dWVPSVV5MlBKTTRq?=
 =?utf-8?B?ZFVZa3ErWFpuQkVvdUV6VFVndnR1NWxmMEVvNVh0QmNaYzk2WW44eHNDYlNv?=
 =?utf-8?B?OW5VTEpHUHNmWWgxN2tuZFpXTG85ZUR2V0QydU1nWW9YdFY4TVV5dThqVU1u?=
 =?utf-8?B?RWxwbHlORWU5Ykw2UjRkOTdyVExzSU4vUkhMcnhFUmZiTnVhLzFUNmtzYUpo?=
 =?utf-8?B?WW1ZTlRQV2ZPekt5N0ZYWVJSSjk5a0xYNk1lSDB0VFdlckk1b1Vxb0JYa1dF?=
 =?utf-8?B?TEk5LzdlNm1JeFZ4dEx5c2VMN01XcFZUcVFzeHp1TUVRdERkQ1pPTkpGbWov?=
 =?utf-8?B?eC9leFlrMVVyaEtnbnA4WklsQzlnU0FMMEpNVklzWHBVWlFlNGhuUXhxZFdm?=
 =?utf-8?B?YjU0Rm95MTVwc25zS2ZKMXNHVnhWWW9weUFIbXR3ZDdrSXZLbHM2ai9PRjh0?=
 =?utf-8?B?SXB4eDRjdEFpcG50V2wybFZRbFFHeTh6a3dvK2dUK1NDNTdFeUMyVWpGWmRP?=
 =?utf-8?B?YXJvZUo0TmV4NDJzMHV0ZnQ1SXVMTXZTUnczNjZRbnExdzZXa29EVU16L0Y5?=
 =?utf-8?B?RnN6OTFyZFUzUzZkdDkyUWMwbmJKY3VQa1htVHhlcTgzRWxPQlZnU05hQWhh?=
 =?utf-8?B?amp6RTFmWmRzMlJiQXF2dCsweGVXUk1nTHJkY1J3YzhSOG14WmlBd0dGSDht?=
 =?utf-8?Q?Xmm/20xgByKJy+AWBH7C3Fsqv?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b1fb0fac-d1f7-4a23-e1fc-08dd17fe4bbc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 03:05:11.9363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmAjxjdlTqJjl+opABsYAug6FaSxvlZFFNR+RBlAvvlk0auZHoH0ntF9tdXci4GFzXyDUtm2IjkAf4D5ppQhTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4561
X-OriginatorOrg: intel.com

On 2024/12/9 09:39, Baolu Lu wrote:
> On 12/7/24 20:03, Yi Liu wrote:
>> The qi_batch is allocated when assigning cache tag for a domain. While
>> for nested parent domain, it is missed. Hence, when trying to map pages
>> to the nested parent, NULL dereference occurred.

> 
> Strip the kernel message and leave only valuable messages that
> developers might be interested. Something like this,

got it.

>   BUG: kernel NULL pointer dereference, address: 0000000000000200
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 8104795067 P4D 0
>   Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
>   CPU: 223 UID: 0 PID: 4357 Comm: qemu-system-x86 Not tainted 
> 6.13.0-rc1-00028-g4b50c3c3b998-dirty #2632
>   Call Trace:
>    ? __die+0x24/0x70
>    ? page_fault_oops+0x80/0x150
>    ? do_user_addr_fault+0x63/0x7b0
>    ? exc_page_fault+0x7c/0x220
>    ? asm_exc_page_fault+0x26/0x30
>    ? cache_tag_flush_range_np+0x13c/0x260
>    intel_iommu_iotlb_sync_map+0x1a/0x30
>    iommu_map+0x61/0xf0
>    batch_to_domain+0x188/0x250
>    iopt_area_fill_domains+0x125/0x320
>    ? rcu_is_watching+0x11/0x50
>    iopt_map_pages+0x63/0x100
>    iopt_map_common.isra.0+0xa7/0x190
>    iopt_map_user_pages+0x6a/0x80
>    iommufd_ioas_map+0xcd/0x1d0
>    iommufd_fops_ioctl+0x118/0x1c0
>    __x64_sys_ioctl+0x93/0xc0
>    do_syscall_64+0x71/0x140
>    entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
>

-- 
Regards,
Yi Liu
