Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C739188926
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 07:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730101576; cv=fail; b=uZpkBHDLYQlxHRbgHmNx1Qb455eAbh2qi5nLZf00xtBO8PUpJiaoyaYt23k+qVWABVP06vqlcMsDSTMW62ZWeV3sms8lBCl6mxH+ppI/7F2qDDowg9wFeNLxyTXyJUMGSINq53S1LBE61/MFYdnGyvtgWr9HdwKNBwqTuVUA9Ps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730101576; c=relaxed/simple;
	bh=pYk5Oei/wm9nuoJc+QQTnmewmfzMvkdrcx/WeOYNh20=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lAMvtXxJKYEQ5d1npn+pvWlZiJdhE97V5lz9p2uGGon8ZW/gOaZMLVitg8YtZzWW4x/cEdU9GNAJrUsmLRJ5o46q9bsoKl27KLiGC64gUQoiyv2exrH98GuzhG5QsC9zI3NyQoZtJZWgSJ5cKytKSJ2QHCMcpOMcONBBGbFFCi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KwcMf3nP; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KwcMf3nP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730101574; x=1761637574;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pYk5Oei/wm9nuoJc+QQTnmewmfzMvkdrcx/WeOYNh20=;
  b=KwcMf3nPB7x+Thn/u3au/9mJLxJtweBEm3RHAVSB2eJJh6FlH9D7Brsp
   ZJ2nmOeYDfal8ny36IGbw9Z25nFvr5NP4IlVdNoaYvIriwFA62k3899SZ
   w4P4RUB/nxzmEdcAhPuX8mkmWto0VahQXID8p6GZ0O5I9MZjMdSRe6CFW
   a3pZt7OBMgkgvyL854xwLLDsm1Iz9jRLhBtUZxLeDEikoe3RdlzqPHIR9
   BHferNs/uM55tO0SENnnh37O0702IbDga0huhgL9lgArRq151Fv+VIwLM
   HByAQSy6r0PAyY7fFzG0KGiaiSq9SquNZFpylZOFCXVzSQWY1ePCqDYJn
   w==;
X-CSE-ConnectionGUID: kNbl9g2MR+SqS87pVz/5Ug==
X-CSE-MsgGUID: HtFfm+W4SXOjScrfJ9RbJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29121842"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="29121842"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 00:46:13 -0700
X-CSE-ConnectionGUID: K0TYtp9BT8KyuwXyjA+Nyw==
X-CSE-MsgGUID: xlwSV4ywRny1qMzjEwA9KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="118999168"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Oct 2024 00:46:14 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 28 Oct 2024 00:46:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 28 Oct 2024 00:46:13 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Oct 2024 00:46:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=quJM6lKG2ggk178QPw2q+vVXwwaxe8k988EVaDoyWi6vwCBWHoFAXsEY5MmVaUfHdQottSyw+NoLLwpd/NutXRzbfoa7oZlLNVN+I7dUYGS8SkjMLQm+AdgpPYmAtBBbKBiUlb8xX+aq9fSyHIPziPGGhxlo0M3FFSXJrxgavrtlfTFg3oEt4VZ2O1vuQNy10+4P4+O3ev9FQPXIy1s3gckbflEijt8G2dpKE+DYKRETWrN3OkuIwZv/BmqA7eQalzgE4zu09tP3fp6UDO5q7PtnOdObbTNl9fUVdMor6Yag/fvb6C5ActPY5lRhFDlA0ZSNRifX2JOOBTBK/UqO6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34E5tEKe0+fDgu4I30rY3JwQ7fr3yK9rb+KZ3oXGV2c=;
 b=KAGo+LUlf40ccnf+8gHD4P+fwsUHy7RTexxDkOu+qWFifvPYY9SACWW2ar+hj+XrRTOPmWHOIhK4qTNrZWbsFB13XfUrEpa13svITeFMXIU6AtdH6/4hRvB9BIadyEqUXmIQOhhh1A9UDbr4X3V53XlPL3r6LxuBBORvs8GSEGcMuanpuj4/0h+VXBmCZRa5dyIJyuhCo0T/9F+iu3AnG13B1F+2QhtXHR3gvAVpqRJiA75VChXqVyvneChvRpB8IlRK1gdkJ/6r7gLlGkE2or2keo4GXKX2rFFeTAgQPLDY1bjDckFgZuFBI12biwE9ok08MLOxNLI4vVLuV56TBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by DS0PR11MB7786.namprd11.prod.outlook.com (2603:10b6:8:f2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.23; Mon, 28 Oct 2024 07:46:11 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%4]) with mapi id 15.20.8093.023; Mon, 28 Oct 2024
 07:46:11 +0000
Message-ID: <90c772ce-6d2d-4a1d-bfec-5a7813be43e4@intel.com>
Date: Mon, 28 Oct 2024 15:50:46 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] iommu/vt-d: Remove the pasid present check in
 prq_event_thread
To: Joel Granados <joel.granados@kernel.org>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian
	<kevin.tian@intel.com>, Klaus Jensen <its@irrelevant.dk>
CC: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>, Klaus Jensen
	<k.jensen@samsung.com>
References: <20241015-jag-iopfv8-v4-0-b696ca89ba29@kernel.org>
 <20241015-jag-iopfv8-v4-2-b696ca89ba29@kernel.org>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <20241015-jag-iopfv8-v4-2-b696ca89ba29@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0137.apcprd02.prod.outlook.com
 (2603:1096:4:188::17) To DS0PR11MB7529.namprd11.prod.outlook.com
 (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|DS0PR11MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: 4525a46f-33b1-4957-2c13-08dcf7249736
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0l1TUx1QVlOOGE1Y0RBOWs2Y3JvWXlwbHZFNW9Yb2dqREdQcEhiUnhpb1Nk?=
 =?utf-8?B?UEFHNkdFUFpCUWhnM0R4dXdLQk5nc1I0ZU14ZXVPRmZtUU5KWG1kR3hjOWRw?=
 =?utf-8?B?cUM3RGx0S2tINzlkUW5nUndHK3BqV1JiMHdkS211L1JpR2Ivd01EU3dTVzRC?=
 =?utf-8?B?ZVVHc2VzSnhGcDNRRlJrVzZOa25mdFk2MllQMHpzMytNcW5DbzhDb3JEOUkw?=
 =?utf-8?B?aG56VkNmVjVWOHN0Q2RkQ3NIWWlKSEpOWDc2eFBLZDZ0KzZlNGNpZ25lM0Y2?=
 =?utf-8?B?TWVrS05FUFp5TDYwNkJQcVhwTUdDL3UrZzVISDRKNXdzQjJyeFRJbEw3c2I3?=
 =?utf-8?B?UUJPbldrdWZBYmhDclJSRDVJSytRMXA0NjhNaWdsbkQ5SVRWb3N5YVZTSUVT?=
 =?utf-8?B?aGtnM3VpempmczkzU0gzdEVJMit3MzlvbFZuQi9wdkhJVWN0M2xDWXJoV25y?=
 =?utf-8?B?Tlk2WGNuYkI1SXlVazZRZGEwN3dlNFhlM21XQ3dlZ3Z6RDJYTDJ1WFBkbGdj?=
 =?utf-8?B?dDdNbUJESEdhbXgvNEJ1UkNCbEkwWU51TEdoWTNhVnMrMitGUUZzTkwvUlZj?=
 =?utf-8?B?eGl4RzdHMFFCUlBKaUpPak1DOVR0b1QzNWg4WEFCVUhWR3UxT0xyUXBiQ3o2?=
 =?utf-8?B?MWtVQzRhdDlwc1l1YnkwNE51djVGY25HTGhPSUMzd0FXSVpNR3dJNk1nTThk?=
 =?utf-8?B?NnNoUWM2ekFndXZhR3BuMUYrWk44a3N4MmhxdGZ4T0xNZnhCK3MrUnN4UlhK?=
 =?utf-8?B?ZDd0Ri9WaFVBUVFRalh6d0Q2VlpjTnJlTU00K3hRMWdWTVluN0JUMDdRbk15?=
 =?utf-8?B?dWNQNjdtWDhGbWc0UnhaQVNHNm1VaDQ5YlV0ajExTnpvTmJNU1p6cERucDU5?=
 =?utf-8?B?a0JoTVZXVExVcUplU1p3bHF1eVVTZTZpaENVMzJzbGsrOUJJM2VnWVdHdnBQ?=
 =?utf-8?B?aVVhb3BKR2NodU5PRUxDVno1d0ZIK3lkbmN5aHY2SGhWV1dQMXdTcmg3cnJE?=
 =?utf-8?B?NUFQbS9mZ1N5MmNFRW50Yjh2QTRaWGg4eDVNVmtmRGt4VGlNS05YQWo0WkQ4?=
 =?utf-8?B?Q1gwd1FqVzJXdU9oTWFMSThHVmFUWEtsWENFdTB3WVJxaGV6UU41YTVNbGg4?=
 =?utf-8?B?clNaZENUVmRCZzluYTdMdmhCS1VYUFgvTFlKNEdkYUFFZHhXbFJRbG1RSkZ3?=
 =?utf-8?B?Ym05emk1alRVRzYwWnVEejJmMDBzdmNVbGVBYW8yWkdXOGpzRW5STnZ5QXlq?=
 =?utf-8?B?ZDYvRUZkL3FNWlBBNUdNUnFHMnNRaThVRVBDbFROMXBWQitKRDJ2L25IZWZm?=
 =?utf-8?B?bVRTWXVKZkg2bGZ3b29NV1Y3Q1Fzd2Z4YUhvSXN5S0NhbVVKdmJURlM0VjRD?=
 =?utf-8?B?UmNiSDVpUVFxaU4yOWFMbDg2c0JWYUY1dW5XT3BnK3czTCtrV3hWeTh3MzRs?=
 =?utf-8?B?bHN1UWZFT28zOGtxblp3YnVNOFpnalZHcG9Vd3N5Y3gxKzFtZmJiT0tFdi9E?=
 =?utf-8?B?WGVGVXRtdnQ2WGpaY2VIL0c3NUhqWTJuV2huRm5ubDNyc2NwQ3NBYnJleXBw?=
 =?utf-8?B?VEYzOU05UWRVQmYzL2FBZGNtR0FWRUh3RXVadDREWHUyeXdadENVbG9SbFFh?=
 =?utf-8?B?NVFtY3IrK3luMEY2RmFwcHg0QVV2cW9vVmYvekNMVGh6WWx4UDl4SFRkRmVK?=
 =?utf-8?B?SkMzU3poNmxRQ2NWVnFkYmxEWTRyUUNjNVE5UFM4aXZRZkkvSjcwSUFwVnl3?=
 =?utf-8?Q?scDWC4Irp9u1Q9i8lzhgbGLuwaYL7xBg53bmgrp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFRRcjR4WHNFMUhsTEZmaVVSZ2YxK1hBVnUyWXhDSGZmNjdzMCtGek9BT1BL?=
 =?utf-8?B?c0RVNVN6bE0xL2dYTmVtNVJtb0RaVlFWU3FMaURQNExnaVdhR2ROVDZCSTdr?=
 =?utf-8?B?WTBxVFdOTm9vWlQxZ1hsNExVYTQ0b2pvbWtQek9wNGdOSlk1emY4VGJLZHRU?=
 =?utf-8?B?d3I1bVRidG40RTZyZzZHeER4Ynp4bzc5NC9UZjYzbU5DQS96U3J3QzlvQUlR?=
 =?utf-8?B?S0dGSjI0TmRQdngrblhydGYvdjcrNWFWTHJkYXVzbzdROWVSY0R4YkUrZmtX?=
 =?utf-8?B?UjIvQXVORW5tU3lubWgzd1UwQ1JOd3Z6eVRzdUVsMlV5SVBUV0pHdUY5WEVN?=
 =?utf-8?B?cmwrRnRXMkFKemxXdVBwU2Ria2JhdWFhTElCMHk1dVo0R2ZycXdRa0pUaisy?=
 =?utf-8?B?aUtHUVVCNFRKS1ExS21MV3VQaWhaWDdxRWxOb0t0RVJwQ0hieVJtVkRTMjBY?=
 =?utf-8?B?dHQ1cUVYbkdMVjNsK25tek1NNy9qNTQvSjNtb0JvcFNkWVo4elRZZ1ZuSitP?=
 =?utf-8?B?bTB4NlJBN0ZGdjkveGNFR25xRkVNWjlxaEx3Tk9vbnYyZzVNM2ZDS1ViM3Zs?=
 =?utf-8?B?ZzlDOEJNbGJXQVhRc2tlL1VaWlBFbk9PekMrWG5EdGlBcXViWmlQT2VFcnVi?=
 =?utf-8?B?S0tYUndTWHV2V1UvbGZGWGE4MWFtVmcwdVJrM1BhaWtMV0dqdDdyekd5blZj?=
 =?utf-8?B?RkQ2Mnd5UmVGaXcrNGJiOVpzSW41RjFPR3NWTTArVDBwQzFmMEdxS1dNRXBs?=
 =?utf-8?B?d0hYeld2cHV4UGwrL0NsTjFhYmpxdDdXc3ZZMG8yNlZjQjNvRnVvam45NHhN?=
 =?utf-8?B?VWltZHZiSVJUVndkcE1DSm8vSFNlRk9vU0pvVDk3OG9QMVB4Nzk3TU9kQUU3?=
 =?utf-8?B?TVYwamJjMWpvNXp2ODZwTUxrZTRscFQxSDJTUGR2V1NndmRhK3c2RmxlRzZ5?=
 =?utf-8?B?V3RRR09LM2Y3bmE1N2pZWG4xWktya3N2enBIaFZDMTVJWGhZMjlzWCtIbjhB?=
 =?utf-8?B?K3lzOTg5UGgrZDhoRUZtbFpqaG1RRU1kdFFmM1FiMWRPZVgrZTFKN3FrUHBC?=
 =?utf-8?B?STczemRreFJnMWpRNW52RFJJMVhZcmp5TlFEVDgzcy9GWkt2YXBHWEl6Z2sr?=
 =?utf-8?B?MnN6M2phMy9YOGZqckJTbDBVek5OSUVLQUNIWkNTZTIwTVZNMmNJRWNaZ0tU?=
 =?utf-8?B?VGRRTG5jclZaSTJTV0RYSndpY3FHcmc1K0k4ekFUTzBBbGNRUVNiai9DMlZa?=
 =?utf-8?B?RW5JVjBPRzFLMGRHd0FtYWlDa3cvbHRPMGhVamhNT1dUa3huVFNTYmFtbDZh?=
 =?utf-8?B?aHQ2QTJmMXdWNmg0VnJZWEk4cEN1R1A0T2FwKzlxWklidjZIT3hpWStQT2VV?=
 =?utf-8?B?TFVXWjVRK29uZDErbzhhTk9HZTlMaFpKMmZ2OXVpNVlMRko4bmdGZWc0T0Vh?=
 =?utf-8?B?ajZKTVh4a3ZscUpEdWFnaXM1V3YzNGtrNDF1WjFQQkRVaGFRTHMzVU50ejJL?=
 =?utf-8?B?MmV0ZGVvTE9KNVFCM3dUdVRocnJsV0d5U3ZBbUVzVk9Gd1UweDZyYk5nT1FV?=
 =?utf-8?B?QVZFaURtbnJKME5sdFQrbjlBM0RtK1JGOEp4bHNvejZUc0hmanQvZ1N0UTB5?=
 =?utf-8?B?czBibGozZkhKdjV4YWVaemYzQkd3emZxdWJQRUtIV3pqM3hnd245WmdDMVNW?=
 =?utf-8?B?bE10WkFHNmdhVVIwTm9nUHVHWHIwcFVvVG9rWWhnOTNlTGgvZHRlNThOOWZm?=
 =?utf-8?B?NGppempXTmRFaUZ6aG5Qbko3RjcrNENVT1FMMXpFb1ZoQ3FkSkJPV1FyVzlx?=
 =?utf-8?B?MHFaOHpMTGJRSm14RXcwWFBxNEVNSFhqVnlhUVZrdmNNYW5jMC91aHNmS2tT?=
 =?utf-8?B?L0E4Uk9IUG1QSmUvWVpESW10VlVNenpEVFhFeXc5RkRFeFpCVk1TOTlaRE1l?=
 =?utf-8?B?ajNVU3Z1endvdWp3bjlCSEE3NFkxOXNlMzFydExyVnVkdTRBSHlIWFhIUDNP?=
 =?utf-8?B?ZGRFRWpaSjduMzZ1T284cXphWllqYTlvdEtrbi9FR1o3bVVRaS84cXdvNC9K?=
 =?utf-8?B?bkZGZ0V4a2NmODQzUUJQRFhkRFJvTmt2dllLemt2TUtJcFlTeGtDblRmSUpu?=
 =?utf-8?Q?d4vZvqrS3BseheSQ5eNUcoqNI?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4525a46f-33b1-4957-2c13-08dcf7249736
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 07:46:11.0584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91h3N9m+LGPmdHqb09Mvbl+UZhV6NeQsQMpUY+0EdBRzszWXbY4qGczS0qQFKMniuboC3KXXq6QxCcJhZFvacA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7786
X-OriginatorOrg: intel.com

On 2024/10/16 05:08, Joel Granados wrote:
> From: Klaus Jensen <k.jensen@samsung.com>
> 
> PASID is not strictly needed when handling a PRQ event; remove the check
> for the pasid present bit in the request. This change was not included
> in the creation of prq.c to emphasize the change in capability checks
> when handing PRQ events.
> 
> Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Joel Granados <joel.granados@kernel.org>

looks like the PRQ draining is missed for the PRI usage. When a pasid
entry is destroyed, it might need to add helper similar to the
intel_drain_pasid_prq() to drain PRQ for the non-pasid usage.

> ---
>   drivers/iommu/intel/prq.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iommu/intel/prq.c b/drivers/iommu/intel/prq.c
> index d4f18eb46475..3c50c848893f 100644
> --- a/drivers/iommu/intel/prq.c
> +++ b/drivers/iommu/intel/prq.c
> @@ -223,18 +223,12 @@ static irqreturn_t prq_event_thread(int irq, void *d)
>   		req = &iommu->prq[head / sizeof(*req)];
>   		address = (u64)req->addr << VTD_PAGE_SHIFT;
>   
> -		if (unlikely(!req->pasid_present)) {
> -			pr_err("IOMMU: %s: Page request without PASID\n",
> -			       iommu->name);
> -bad_req:
> -			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
> -			goto prq_advance;
> -		}
> -
>   		if (unlikely(!is_canonical_address(address))) {
>   			pr_err("IOMMU: %s: Address is not canonical\n",
>   			       iommu->name);
> -			goto bad_req;
> +bad_req:
> +			handle_bad_prq_event(iommu, req, QI_RESP_INVALID);
> +			goto prq_advance;
>   		}
>   
>   		if (unlikely(req->pm_req && (req->rd_req | req->wr_req))) {
> 

-- 
Regards,
Yi Liu
