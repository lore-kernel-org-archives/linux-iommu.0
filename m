Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D3F236F81
	for <iommu@lists.linux.dev>; Wed, 11 Dec 2024 09:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733909082; cv=fail; b=dT8EXHRae54XPzQ7obCeqb5cFr+XFyGhNfG//4z3yoyOn4QZ0oEGSMC0sg3ijWvF4sQYPhYdD6uhhHqqGaTd1nZLuwj6kjY7OGg/D11QOuG4PTDbmYFxQjchZI2jPK0axz7LRKfHvEUiR7R1djvbuzFC/x9UerTSeAXRzXINBpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733909082; c=relaxed/simple;
	bh=4F1qlsb29HrA2UGAz1lWHNFsPG42dDPfxSpztcaeYXs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QaYnrMAetpCKxSfiF9tCH9TmtOhOT31hudHeO1+ts+PhqaoVX4UnjauHx56hMjNS7kNGnuMa6ddyamtRu63pzzrsraC0dff+i1t40E8yuXEMYNbm7WxBAiawSrWxK1KaVXgvzYYeslv6XPD0TdiQEEfdp+ZwE3xmp1DRrXwd4Mk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l9+YyTvu; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l9+YyTvu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733909080; x=1765445080;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4F1qlsb29HrA2UGAz1lWHNFsPG42dDPfxSpztcaeYXs=;
  b=l9+YyTvuqnXEkPD+KO1DqAI0aw5iYb3ZZb5SEA8NNUEtE+UTbukIQWsS
   1t4NlApaCCZcpJgjg5/kHSYu8pov+FWpZ6V5RZWLtMIpFTPEeudfZYPfj
   o9yt+OJDZBQzMVMR8zlxEH817vOqr6bpbxzjDHp5PkXsMm6Zwaq147sy1
   dOGD71Kgu7nCMNZl7pXseEbyzqGR27gYlH6N+zaKKQN5v/vwK/4Gh9MgD
   x2elBpU725k8TsD+PZc1aLP76OtYH+JJ3xM5W1GOKimlpkQ8aBZ50k119
   h8yhC9f4RrYR3/hqmlyL2wlUORw/34u/jrH24hKqIzChg42UMXow7UqwG
   w==;
X-CSE-ConnectionGUID: DJirmmVpRqiXFzLKNHKJFQ==
X-CSE-MsgGUID: wH1eHlRpQEOl/YMV9H02hA==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="34405382"
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="34405382"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 01:24:39 -0800
X-CSE-ConnectionGUID: qHewik1PR5+qPrdTQ3YZXw==
X-CSE-MsgGUID: izeW8umYTX+nNQglvzCTRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,225,1728975600"; 
   d="scan'208";a="95562785"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 01:24:39 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 01:24:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 11 Dec 2024 01:24:39 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 01:24:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tqLJSOvsYyvyfKfVEzhqvBd4M0URpJxcYc9GSD/I5LHfBfnCe+Vqu4U976nLerIFAMR0FbJRTq88R/8FakSFb6vBwd4lV4AecueFpBvJLaf3HnIfjJwlE3mWIE9zuSGPLyb8s+17wIZ7W/IJt4SrwoTefWhW01qErGW21VXA7oOHhwpBxqjEq0F/G5j8JPJJ0wr1EKCZezL1xToChNgDx0rB7HMLT6eEPDmBYQGeo0Tt7VZL6MTrNnaGelyfSUaLRFZFlnKztwD6DYYzpqXvMMv8+BIHoAWdzjXh092uk2DTnLGb1vVmjTPGHjuJ2WsYZpw8YK8seldM3GWFFdlsog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rAuLCeosfnhKS0yeILIc6FvU1J6+j98HG98ToM8C2IM=;
 b=Z973fusl3coVgF7zE/IaoIViRLDkBLP1MKJ7Gt3ol2zDhx5wukVuMEHQQI7wm2iy2jJ8a4nyC+qPAsq2wAf03DxSCwWjbQKviKWoSL1CypwVU+YEbcxkn9o+HxE/LHmjyyGxYQ3oJJ/pX+EdMeCDQxAwibKwvc623RBsNb6ObB9AFpftZ2bo1Ivdekshy0RprrGyQpi96bT94A1Kn2FND31X568vIkDo7hYNq9keVkAtrRHHPSTFaehMF1KHw3OyHSDogYFbao/TCctwA1Sx3AU5HDBR521P+moUG2zlt1137QeBevARoTHeEkMTOCKudnV+9BG5OdAxditPGEmOew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CYXPR11MB8753.namprd11.prod.outlook.com (2603:10b6:930:d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Wed, 11 Dec
 2024 09:24:17 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%5]) with mapi id 15.20.8251.008; Wed, 11 Dec 2024
 09:24:17 +0000
Message-ID: <6233f996-6b7c-4c5e-be92-8523d4c16193@intel.com>
Date: Wed, 11 Dec 2024 17:29:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/vt-d: Fix qi_batch NULL pointer with nested parent
 domain
To: "Tian, Kevin" <kevin.tian@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>,
	"joro@8bytes.org" <joro@8bytes.org>
CC: "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
References: <20241207120304.5710-1-yi.l.liu@intel.com>
 <ce413d97-ec46-4cd9-932a-af804cd531cf@linux.intel.com>
 <b25901cf-6483-4434-804e-62bda4385796@intel.com>
 <BN9PR11MB52761F40C3A1923B78478C0D8C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <BN9PR11MB52761F40C3A1923B78478C0D8C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG3P274CA0016.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::28)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CYXPR11MB8753:EE_
X-MS-Office365-Filtering-Correlation-Id: 1555a2f3-bbeb-4ad4-e25f-08dd19c595f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M1FKY0pNR3NRVXREaXVBQjdQSDdCeVdsS0U0SjJtb3lsMG5mOExmRVNkYWsz?=
 =?utf-8?B?WHJIZy83OFJlNmVoOHNjMTc0YU8zcUdwTUVQRnJMYytjTXpwQ0hNMStUUG5D?=
 =?utf-8?B?d29ZQmVUR0lmc2FPNXJJYkpyVXdGdkJsd1NybTlhQkRxQkpNSjBBcmZscWx0?=
 =?utf-8?B?OHFmRkREUElvTW1OZTZNYnJrbVprSHpVcGU5RlF5UFZIR25nZU9LUmtrazNE?=
 =?utf-8?B?eUlQNjdrZXlLTUJld1pYbVAwVEFpeVBvTXJCNnRydkJYUTJnb2Z1Yk9KYllG?=
 =?utf-8?B?OS9iK2ZPMUc4THBNQzM5NVlwcWgzYUYxL0pCWkJNREdRWVFmTDBROCt3Z1J6?=
 =?utf-8?B?NkVjWWlCb09qQXh4RzczWVJNV2hhS3U4YUtUNFJFSnJkNEpWM0xrVnNWb2NV?=
 =?utf-8?B?a3MzV3ljenRGOC94ejBKKzRSVng5Z1Q1VndyNWkrRDNzcUZjTzFJVENhZnZD?=
 =?utf-8?B?TkU0c0NyVFBwc3YvekliSVNSNXFsWTV5ejBrb3NMK25aS2JxT0dGUW9wdGpF?=
 =?utf-8?B?RFhRY2s1RjNMbXRIa1hNdzQwVWpIL2Z2SVoweUZ3M0s5dWs4MldFYUlWRVlP?=
 =?utf-8?B?R3prTUNrNWJ1WmpwY3ZBYVUyVU9MNDRFK0FSN3FQTGQvM1FsNW9sZnhuOVlj?=
 =?utf-8?B?akZCMHZvK1dFMVpXMEJlZDBZNndxVTJyRzhEQ0VWN1hDM2JqWUZNazU2a2hB?=
 =?utf-8?B?M3c4VTdKdGV2SjRobVhRWlJtSnA4cm5YZDgzemtoMXl6T09ORGR1VDdVVlZ5?=
 =?utf-8?B?Nkh6U0k2NHFRZ0NwWnRVMW5kdXhFaWpjZ29pVUJXN0FZeURvR25xRFpJK2w0?=
 =?utf-8?B?L0YrS3N4SDNONnF0T296dlRTTlN2b1M5MFFadFJtVnp5QWlHaXZsM3VqZlpk?=
 =?utf-8?B?dlkycjFnUU5URUZ1c3FWeGs0bEoxcGg5Y1hYZ2QxM3lmcUFlL2NjRFcwSVNv?=
 =?utf-8?B?NVJIM2F3WlEwWXVJRGdocWF0RjVLdEdLV2R3Z0ZLNGdyQlg2M2oxQ2JQK0E2?=
 =?utf-8?B?T2s4cjdTZVNrRnd0NHNuOHpCb2pHNE1QaUFpQytNUDc5MC9SbGZZOVJVSFl4?=
 =?utf-8?B?M0REL3pCTjFadEIvNThEUGVJMzQrcHhEVGY1STd2WFlXbVF3eGo1aVlWUlFD?=
 =?utf-8?B?U1NITTZCZWMxVzNvZm9Sc2xQWS9VSkRCMFZrdVpEWDJrcHFQSFFaa2VNZlJh?=
 =?utf-8?B?bHZSNW9ZK0VlTkxFbFczbE5EUjY0eWxjVDRWMWpEckRGUC9yak1qVXZjOWs1?=
 =?utf-8?B?SDNBNVdka1RFd3ZQell4RVV3akxjOThWT0E3REF5c2pkU0E4a2xhc3NYV2pN?=
 =?utf-8?B?QVI3d2xjN2VYYkQ5UCtPZ1hEOFp0czVpYitWTytNUXhpZUU1c2gwQlVYY3Z6?=
 =?utf-8?B?QkN3R3NRaXlDZkZJcnQ0Vkw2QmsxYTE1S0tRL0ltbjF2b1pDUmpkRlpHZzdF?=
 =?utf-8?B?MmpmUEVSNlM1VW1xcjdLTUZkeGlocmtHMWp1cUh5WkxrNHREUEtTYytNdXgz?=
 =?utf-8?B?YnM3cDNmbHBOVUVrcWZaTFUwa0QxdEs4WHhNWU9pdHlYM1Y1UnpyaVQvVXNi?=
 =?utf-8?B?Q3IzN291S2ZRT2VDL01xS2dyR2ovNCt4SGVjL28wajJnZ0kwT1p2RXo2aDh1?=
 =?utf-8?B?aVhURGl5Qm0wU0x2L1hTeUM5elBBTG1UMHZHRTRjUkYrdFRBQmRJZ2VEL3pK?=
 =?utf-8?B?eHQ4WTZaOGVXZFUrVXFiT0pDdVB1YnZwMzR4L25JdU80MmpNN1BTY2ZzWjM0?=
 =?utf-8?B?ZzRzREJJNE92bkRwZXVVc3VtY051Rk4yckcvVHJmU3laQVlwQ3A0UWNBQ0p5?=
 =?utf-8?B?aE9UQXRpM3RGMlBSajdvUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2xraU5EMEN0eml1b2h3UzBDWFBYQ0FuTEpJSGgzYTZOZ0o3dVZ6UEFSUkc0?=
 =?utf-8?B?M0xWdkxwdVNzd0Z1MmlseU5IYU9DdmQwVDcrOGRzTWFRK2dhZldid2xLVlhU?=
 =?utf-8?B?UTgyMk5tSnVQVlJrcVpRZWQ3MzVoOXNoSjlPYXFKdmxubWlJZmdZWEIxMUlv?=
 =?utf-8?B?UVo1bjc5YWNRWEhSbWNUb3hpRjR3OGhteTlVcERBUGxPa3JJbm5QSDZqNUdQ?=
 =?utf-8?B?RzBiczNNOEtxUnBqR3p4cXU0L3dPd09SbHIreVcrd0tJZlB0cDRGWlRLUXlU?=
 =?utf-8?B?K3cwZWZway9aZlBVWW11bUVqVmFIWlV2b004aCtwL1hnM0tVRzlweWp6U2RG?=
 =?utf-8?B?Y1drbUFZN3EwbUFvUmt6N1lUL1VwZURFNytCN2RIVFc3K2pXbmFPVjJpblBG?=
 =?utf-8?B?U0czc1p0SUUvVnpUd200aDBSYlhhWkdzU0hIYmZEa0NHS2ZUOEs5eGxqRUNv?=
 =?utf-8?B?NmdmVlQ5WjhFdndqRlRjeit1ZzZKdUFwRWV4YjJZNUcwVW1kQUxoTzNUM2tU?=
 =?utf-8?B?b2hSNEdTRUFLUGxVOWpETjdESUZPeklsWEQyRVd0ZGoranJxU0NUbkloTTd1?=
 =?utf-8?B?UUlvbVJrM2hoL09kWERYdXNFUEcxbnBPWUhXanljaW52bzF0aGlSTlBoWkVO?=
 =?utf-8?B?ZnNoTXRCVFQyMzF5d2FCM0xFLzlyc1NPVEprOGdQZWpKOGo1ZFVCZkpDYjFJ?=
 =?utf-8?B?V2xRdzBkKzFEWUkyeHhIZ2FtNjM2eXhEWjFEYVdpdzJpanRYRVM2dFAzTmdr?=
 =?utf-8?B?VlJYMUE2VUVCbzlFN1BkVTlBWHJzMUJnd1VEVm5CMkxGU2ZIL3M2OXZwdVJY?=
 =?utf-8?B?WmlsS2llSXFXSktCN1kzb3ROc2VQbnBqTG1lSzJ3MXdYWURzRzZSb0kzK1dy?=
 =?utf-8?B?dElSQVlFMVVYdVNOd3QzUEhzZnMzanpqcXZiOGt2NWtEMHdXWGtiWFFITUJQ?=
 =?utf-8?B?cHJ3WHh2b080VVlrcGxxdDFRdk91SkdUSFl1WXpYdVRmZ1dpSkVsWGNrUW12?=
 =?utf-8?B?aWpxVC9LR3RYUnVPS0pCdFF4bm9xdiswanB2QWdXb2RQNlJTUTlQZjVKeXdo?=
 =?utf-8?B?NFNFeDltOVhTQnBGaExuSGlvVis5SXNWVG1CN1dlUVZsRFpxSjVXYnhvdHdl?=
 =?utf-8?B?MC83WGdxZ0V0bUY2RUU5ZGZqcUZldmQ1d2N3UHZzSmttZG5Xc1lJOFB5aFpv?=
 =?utf-8?B?Y2N1OGFrV0YrN2JSYUl2Z0puSk5TTlpwbXFBT215UkxTQWxGV0tocUZ1OFNr?=
 =?utf-8?B?c0VVZGg0WERBRTlKVk83cHZVMTAzOFlTR1F5d3pUVzhobGdKS04vRHBLTlBm?=
 =?utf-8?B?cTRzcm9aLzZKRU02THpRb25tR3RoYVZEcGpzdFZiZ2d4QzhRd1YwaGdXOVhT?=
 =?utf-8?B?czlQOHAwNnNYbEx1R0RRMmNDdXBzNDZpeU1xV1hYZWJ1eGtnbmZTWEJhbXlE?=
 =?utf-8?B?aFE4eXExVnRNWmx5OWs1UjkwNkF5MWZ4UldheitJdURwNDdhY05QUkpCTm1s?=
 =?utf-8?B?bkFBSXVzSnhVRkpER0R0NVF4U0R5M2p2WmhLbktxVmZuT0ZhbHd5Z2JybUg2?=
 =?utf-8?B?UzhrSzNpbFRlT0tLUFMrYVFxQmFjTjUrblNHajRWbUhnazY0aWZPd3owTSt6?=
 =?utf-8?B?VU1hN0FzUDRHZHdiZ3ZxTEpWRGdhT0k5RnY2amZvRDVpb3h3MVd2dFhYdC92?=
 =?utf-8?B?QXdGRUJCZFFGTGtiVWZINHJtSzNMR1QvUDRiMGxJQTJnSXBvakZ1U3ZmcDVk?=
 =?utf-8?B?UnpuWEpCRWVrU1NRbUl4K0pPemFuNWlvMTJFUHJTZlRWWlp1ZE55NHlENjdn?=
 =?utf-8?B?MHpabGNrRVNLMXovTVVSMnlCMjZxTDB2NkJ3SklxUU1HdE5ubXRDNXFNVU81?=
 =?utf-8?B?aDN2RVNrWVpIaTZnR1k0SWFHVXAzYytPR3FCUDRhbUpsdHgzVEhWNm5YckhB?=
 =?utf-8?B?ZWlibVF0Ym00SmFUTS9IY2hPTDVaV2VSN2cvdTZtQnBBSXM5eGd6Zms0ek83?=
 =?utf-8?B?bTV3SThpRmRSK3lJbFdEb1BwTk9WaXV2MzQ1SGxoV29wV0pVejUrUC9helJR?=
 =?utf-8?B?cTBPZGM3TCtkWXZ3U0NpT1lJWE9iaWVGRENsZ3RXb0xmWTZhcUt2bHI1b0J6?=
 =?utf-8?Q?G5EPo/b6nXfvzMAuqBXo3mdDT?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1555a2f3-bbeb-4ad4-e25f-08dd19c595f6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2024 09:24:17.4723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g0VEjq4CkgXFULISgkqmTkxbdDOIBtAX95mUaFzrMO2jXnvgPwaAMsZs8gIE72dzboQQnsjVPHd1EDSkOcZA+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8753
X-OriginatorOrg: intel.com

On 2024/12/11 16:32, Tian, Kevin wrote:
>> From: Liu, Yi L <yi.l.liu@intel.com>
>> Sent: Monday, December 9, 2024 11:07 AM
>>
>> On 2024/12/9 09:39, Baolu Lu wrote:
>>> +/* domain->qi_batch will be freed in iommu_free_domain() path. */
>>> +static int domain_qi_batch_alloc(struct dmar_domain *domain)
>>> +{
>>> +    unsigned long flags;
>>> +    int ret = 0;
>>> +
>>> +    spin_lock_irqsave(&domain->cache_lock, flags);
>>
>> I'm wondering if there is any difference using the domain->lock v.s. using
>> the domain->cache_lock. The RID attach path acquires/releases the
>> domain->lock first, and then the domain->cache_lock. While the PASID path
>> does the reverse order. Although neither of the two paths hold the locks
>> for a long duration (no A-B-B-A locking issue), it still means when a
>> domain is shared between RID and PASID path, the domain->qi_batch check
>> is
>> not in the same phase of the two paths.
>>
> 
> why is there different order between RID vs. PASID attach?

I think they should be consolidated to follow the same order to have
better readability although there is no actual problem for now.

-- 
Regards,
Yi Liu
