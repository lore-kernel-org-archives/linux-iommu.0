Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFD62DFA4A
	for <iommu@lists.linux.dev>; Wed, 25 Feb 2026 09:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011706; cv=fail; b=YafNwLCfhN7/95bsIgJG28xM3Dxrwav4KDEkcitdVWWAbib5s061nfCpt1IDJyVGrmKQrIXC8Fr7oEg3Ok/4kl+TjIV5B/lJIhuIZji7/iwJ2fY5lIfeW/hdG5tITeYcljjTwtb/tpBKJHe0hOPxMov+7OVVMWeIyQVnVjks9rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011706; c=relaxed/simple;
	bh=1aOqxgYsBx1fGCRdWi4EgQI6TwDvB14USjlfG6U8J9Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OlZFOgZTXUL1BYbREEjYCsIsUgC9jyeAuTY1LWTEOVc2bEVZkdxL0w25yGmxVgsyaLCRE1k7qm+syy7dx4sLCcr18Edr3WB9os1zAJfyMbf9h4eAwjQCjkOHbbp7eVlGn7lSNGFguJ1t5tI+R0+4lskcKvlAA7N8OpijxzxNML0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IrMA+PNp; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IrMA+PNp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772011706; x=1803547706;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1aOqxgYsBx1fGCRdWi4EgQI6TwDvB14USjlfG6U8J9Q=;
  b=IrMA+PNp1dGTauWARcd2S9YcX2Uua61qEgwLLhu9e97526Oa8t8wKMAY
   JXJ5NpPR8tazIdKnyAPr7VWO6r9/4F8qgCwmboDAZQpx/6ZtNeROATFjT
   Y1SlJtkxt3HYWigFoliKR0OFxz0CIhse8E7iV5fTFmHcXTaHpSawryMrm
   HNz1mLZmKxzYx5AGMNc+Bozc1s4h4gKWXbOWIVPyCm+A0hmATZCtGCWcK
   FoeVR7P38+qjdi5nzHtd3SylFxLVwHpc0hPpxcmoGc1tR7E9QBcp2nRB5
   rubw+35w5VS37OXhsvFBueTIquuQcX3E/z1wsOIATrNtxC1RdIJCDj3jE
   A==;
X-CSE-ConnectionGUID: hbLrfABPRlOd/UHXfXtKJw==
X-CSE-MsgGUID: VyfhA8xMRUasItHUWJxH+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="83367988"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="83367988"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 01:28:26 -0800
X-CSE-ConnectionGUID: O962knkrRKmCVxaf9+sLgA==
X-CSE-MsgGUID: 8bONTrUlTGWsUT+raXAh2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="214317225"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 01:28:25 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 01:28:24 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 01:28:24 -0800
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.36) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 01:28:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgL8r6mExL6qcqZ+wJVlNjkbShv62/YxjvMEvR558JDdHE7kus7embNVsbiDo5r0UX2rP0aPL2oJ4dFcPqU+IbVwlSHVl7CN/6EvqMxIrsveU56AIhYuJ1/BI3NOrnu4ioICo+qO0k/LMjWYStK5kToOTRWg3ZglIE+dzrDDCJjLzbyOEaLQQXtVh+BQRFzONg3yliku8SOd8x3FfMskyKKFhQYEzQdyBTv8IwGfrC/0D6ou50cz/6of5fh/PhEMsrK6nMCsAAtLmqSmYrnxHAPp5TXARNAxBdLgdHydwlaw9TN8DK7q+ZvO+BAZnszCIpR+wJuqXBLRiVB7Sk05gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/RvdBEKSmgWxvptDCwQx8j85kjeumaZp8i33GxB1Tc=;
 b=lE6J6exFkiHUN8w7aFgyd6a+44HTBLiD/MewnlufN8LKHV5gg7+1HUIZkcrmqBE568tjWz06lMX7TKivvZxgbyJOqfH/1IzMohj8vkz8Etxo508GAGZZKgQtg2obP6grhXQXKsNwmefzOLkh6+S+ofvUjkTdIpEVpynTCv7vd3+Sg4zn2c9uB//Uaado96OPLMxtSZGayZk6h4AnpS/+f/8CY1qGPJdAYdxyUABtsioz+3Juhdzudb30fAlaIvLAgKFPNRGSWSfpSKQsJb5FLeCuuxjk3TQVaB7Quckc0nUsu9RRel+AOzR40Hl67+mB/Zu6FhY6IwcITjH+9tk69Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 by IA0PR11MB8398.namprd11.prod.outlook.com (2603:10b6:208:487::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.23; Wed, 25 Feb
 2026 09:28:23 +0000
Received: from LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7]) by LV8PR11MB8509.namprd11.prod.outlook.com
 ([fe80::f5bd:4dde:4f2f:20b7%5]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 09:28:23 +0000
Message-ID: <1c486a5a-7115-44fc-9705-18b292cb9d00@intel.com>
Date: Wed, 25 Feb 2026 17:35:15 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] iommu/sva: Fix crash in iommu_sva_unbind_device()
To: Lizhi Hou <lizhi.hou@amd.com>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<baolu.lu@linux.intel.com>, <vasant.hegde@amd.com>
References: <20260224183056.2628698-1-lizhi.hou@amd.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20260224183056.2628698-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::10) To LV8PR11MB8509.namprd11.prod.outlook.com
 (2603:10b6:408:1e6::15)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR11MB8509:EE_|IA0PR11MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 0617ffe7-6daf-4e47-7bea-08de7450387d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|42112799006|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: 34nwuqnE9qr6LPXehakTbGLLFh12EUiCHhw6GrPLm2sAMDjSw8gkAp3n2KVz1rtTFZtYJPmljyv4Mvp8jwsbFsphIT6Yc4YmmMODtv0BkcdvqbdAhn61cVgSIMvk2dIkVVTv0MDwelyGNGhenbsG6PhLhgxYhZcgmoPCDtSyGkR6MEhIvlO1T9x832JvYGZm2kHMMimX61y/Cb2z9u8NIRAo6P2GY2A76j17W2p9KGx2watVCcn698poh3o+6vW+UV+1ls0nYKZo+8qaBxxQHFmQnRWzTL8mMAOh/MznCloCk2QY0lR4Z5sAxN/QDZpEYPaH5Z5JZPROaJHbQ+lauJGfNN3V+DGttuZ/ZeaAbBmNC08YYOjSh4jQtjdJ/2kqOaRPpTZFKBcxGZqs2dFNb/tW0jHmnGYR+y46ebcBVwoXZumUSXVeDajhVblFNIUAyNLCFUqbCeHnu5y96UCx/ZOdUp56wHK7gU+RamIh+dOJaK3a8tNZRvnbMozotfhval90x9e2VFEwUU6zCRR1k1j7OvBVoevJtnxrhoh6OOlFU3nWGzEvaJa7KWNW1hX63tUWwfQNn0p6oQA8AMxad5HZujnKj5GOVpkjWI9ypSTINV1sQYn3T8zYaTSQh0tQtupzWM4k9lw4flNsbmeqnmNNA1TCMF5ZzWqNvA9pZfpSDAok2JmMrgFbfAndHDVJgaWMIsk1+ieNuqrmFrCDJ4LesjlmAzT7D8HBIg+jZ/8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8509.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(42112799006)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wkg0RHFxdytvNHgvZzd2UllHa0UrMXYxckVnRkw4WVB5SUpWTHc4K002eC96?=
 =?utf-8?B?VFhVMUpsN3VYc3d4R1NOWW8yOUFaWVhnRlZJZnlkUU1MZzNseVZUS3M2eHYz?=
 =?utf-8?B?alMvY01aZXFZbk1RS0xYQmRiZVZjU3ZIT3hzVWFZREVENCs2aFpGNjBraDlZ?=
 =?utf-8?B?TkIvZnBkOE5rNXYxYnlieUFhNjQ1YTdhTXVlYStMdlg2Tzg3bUhRRHZNcWdq?=
 =?utf-8?B?QUc2czVScjM2d3ZzOGpoM1I0Yndnd1llcktiNTIwS0ZMMWRHbEt0UkZ1R1NV?=
 =?utf-8?B?RmdjZ1Radk9FUVlMVjVEdHR4QXRiRW8zczlXSERLd1Q1TzIwbE9RSmpsSU4x?=
 =?utf-8?B?ejZhYlpmeXY4bXFITUFlcXBDR04wUnE2Tzg2VitrWEZNWVMvUGhKcjRZSlZj?=
 =?utf-8?B?angycEdRZjdJODJjVHh6K2d4WmtCTzdlNzBwdlQzVmoyVVZTekhnMTVHSlRp?=
 =?utf-8?B?UmkyR0lSYjdWM0xIZG9mY1BQOENLZyt5aEFxdEh4djNONjhYRSs5aDkweUlx?=
 =?utf-8?B?bTdUZWR4YzBUcHpScXJCblZycXd4TkNpVitQVkxsUmxkSWU2bUpnc1RqaUJJ?=
 =?utf-8?B?UVB5RXhxVGxwSzBLMnJ2dWlyYUE0Yk5zMUJIZklKS2pRdXFkOUNWNXRFNzBi?=
 =?utf-8?B?MElwUktvRkRiNFZrYjlNUmVRVzNhTktRM21OS0E0MThZU1YxS2dwbkpXK1hm?=
 =?utf-8?B?MEcrVHMvN2RaM09XNDdWRllucmtFN1lYZ0ZtREFvZjZHMzNldjFoR2ljTFRa?=
 =?utf-8?B?bHJxSGl0eTdpKzF3NUQ5NkhzZHJpZjFsQkk4ZUU5Sk5jY2Q2bEk5dkpPNm9K?=
 =?utf-8?B?cnNWY2VKTkttNnYrempjMzdJMVhRTEMvSnoxajFoTzFybFNUTFhaeTMrMmJa?=
 =?utf-8?B?eVFpU3VTR0RSK3o4V1hEamhVS1dmaXBWTjIvaktqQkErcThyc3RmRXEvaGNV?=
 =?utf-8?B?OVRkNDlONTZEa1FHbnZ4T1ZJYzcyT1ZLZEhDWEJrQ21HcHg5N3ovOXZ4d3h6?=
 =?utf-8?B?SzZoM1FNRTFNNDA1Mml4Z3RURUc3bWd3cFFpeHBjM0Jkb0o0NGI2Ynh4eUF5?=
 =?utf-8?B?dW9mUTNGNFN0OXZOZEdGeUZuVVpScEFkSFFVcjVDcWVrQkxldjA1NWhkWGp3?=
 =?utf-8?B?dTRMRkplSmlQa0VhVjJrdWpXTUoyNVh5THloMER0dEMyY1AvUTErZ0ZXVmhu?=
 =?utf-8?B?VTdNUWd6dGdYVmNiZ1E3dzYxVHFSVndCSFMwUU51Mk1RUE1SOFJ2ZnloSFQ2?=
 =?utf-8?B?TDhIRHloQ2NqKzRyZHFIKzRReUNRRGltbUQ1Q3lES3JYOS9FR0tjN3hmVmhU?=
 =?utf-8?B?NXhqL2lmbG5JSUJ5YzhqSmFnL080eGNpN2Y3TERkdlh4V3duNU0zamFuYVU5?=
 =?utf-8?B?NkZ1M0paRXZTREIvWTFJUHhMRkMwcDJSeEFleENYT083SjdvQ3hQMDNrSyt2?=
 =?utf-8?B?d0dJbUhhNXVXZDBBM3JLNFk5bDkrMXcyWDNJQkFUTndwR0dqbVI2NjhSYytS?=
 =?utf-8?B?aHBELzF6NWxibW5EejZpaWplTXY3UVVmeVpoVk11c3dpNEphRHdDYnl6a2NS?=
 =?utf-8?B?NjZweVNXSVlMaWVIV0VnR09XSkZ3Mkp4YndoNCtXSFRLa2hoM2xzc3FJNnpT?=
 =?utf-8?B?SXM5c3BxejlRSGg5Yk9tSUlXeW4yODVIOUdRa3lIeTU1TTNiOVFreFJQSm5t?=
 =?utf-8?B?RFVYcEMzR3F1SmYvNERxMFRKdEJ2QkJWaGF5dmxPMG5BMmxuRUFvTVliS0wv?=
 =?utf-8?B?dlVpSWs2WEorZUFUbFhNUEhYZzU0N0g2cTlIUDdCQkJZQWNvWWZxbWxzMjVu?=
 =?utf-8?B?ZFFFT0d2WlZYR0s1M0pWSWVEeFVJVDlCZ21JZys2UmRtR003Tmp2UmRlTTBH?=
 =?utf-8?B?Q0N5aG5EbjZrb25ISmNTRzV0ZVplNmNaSnlMNmxRT29wNUNSUDdaaXZDeHUr?=
 =?utf-8?B?a3J4TlhhMWlXSjZUTjh6dDlzZ1g3Q3M3VENHelZYWjduUXNhOG05NllVaU9H?=
 =?utf-8?B?MEZ6alI5U0YvelNFQXdvbXFEckdjaCtPR0E3Zmo1UVpRTk8yTzB2ck4vcld0?=
 =?utf-8?B?V1BzbzdSVk5Vb2VJdVdqcDd1a0ZqZ3N0ajFEWXlLTmVod0VqZWYzVXZKME4r?=
 =?utf-8?B?OSt0WmU3Rmd1MGc2SjVRVUYwemp2bDQxUUpvOWIwQ1ZGbnhVdnBpbk5kYThw?=
 =?utf-8?B?ZmdJNXUvRW1PRUoxMXU1OFh0M2VtWUM1aDhvOVJkRFp6ekVuL1JRM0VZTkdy?=
 =?utf-8?B?aE4ybTZBSm4vL09FNHRaSU1Gd21ZWDh5MmluaHRWcnpKSFpzSkU3cGJpdUFy?=
 =?utf-8?B?dEltbXF2R3phWGprVThTYmRwZ29QazBibWs1c3dvVkdOSlJYOGFoUT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0617ffe7-6daf-4e47-7bea-08de7450387d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8509.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 09:28:22.9627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UooIrhRNNXMT7waLdD+zcrK2yy6HmMcJi5OLX7jFcK9Rii5/WkLCARNtJ9XE60a/6hEsIbFzWD5eABNW14t/rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8398
X-OriginatorOrg: intel.com

On 2026/2/25 02:30, Lizhi Hou wrote:
> domain->mm->iommu_mm can be freed by iommu_domain_free():
>    iommu_domain_free()
>      mmdrop()
>        __mmdrop()
>          mm_pasid_drop()
> After iommu_domain_free() returns, accessing domain->mm->iommu_mm may
> dereference a freed mm structure, leading to a crash.
> 
> Fix this by taking a reference to the mm via mmgrab() before
> calling iommu_domain_free(), and dropping it with mmdrop() after
> finishing access to domain->mm->iommu_mm.

need to be more accurate. The issue is that iommu_mm is freed in
mm_pasid_drop(), so after iommu_domain_free(), the later access to
iommu_mm is problematic.

> Fixes: e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for kernel address space")
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/iommu/iommu-sva.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
> index 07d64908a05f..523b8c65c86f 100644
> --- a/drivers/iommu/iommu-sva.c
> +++ b/drivers/iommu/iommu-sva.c
> @@ -179,6 +179,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>   		return;
>   	}
>   
> +	mmgrab(domain->mm);
>   	iommu_detach_device_pasid(domain, dev, iommu_mm->pasid);
>   	if (--domain->users == 0) {
>   		list_del(&domain->next);
> @@ -190,6 +191,7 @@ void iommu_sva_unbind_device(struct iommu_sva *handle)
>   		if (list_empty(&iommu_sva_mms))
>   			iommu_sva_present = false;
>   	}
> +	mmdrop(domain->mm);
>   
>   	mutex_unlock(&iommu_sva_lock);
>   	kfree(handle);

will moving the below hunk in front of iommu_domain_free() simpler?
Only when (--domain->users == 0), shall the code check if sva_domains
is empty. right?

         if (list_empty(&iommu_mm->sva_domains)) {
             list_del(&iommu_mm->mm_list_elm);
             if (list_empty(&iommu_sva_mms))
                 iommu_sva_present = false;
         }

Regards,
Yi Liu
