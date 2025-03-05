Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA231624EB
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741145366; cv=fail; b=QYS/eYGfOwu2pIsjKaFL3GSfw2q9lgM2Fh6/GHyMzI1Dvu4UmkYmB3g7ckJADOUJcNBpAWnuyvFn684prMKhW2fat8E/wuJlWkLxQttxwIlHGAVjTWSPDSI4ogT50G3sSVBJjS0sdxagQYUC+WdfdKVBjhdGIwhKhMCOhlnVAK4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741145366; c=relaxed/simple;
	bh=VUr/tPE9mDuVh6NRvQG3YXuXcl7RuBt4AX7dvrjpPLQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eRgpY10+95CGA0UZaNuFv0wVaQFE7PRdovWoUDoOBTHik3A8Fejkoj3A1ebbINw35g4WoP1E1fwojeO3ZVTHM9w8s6kPo6KGiY7KS7Tp9CRr3EmkU7upJkoZN2dsZ5BUntxtijuoVRyXWM7sU/LsVELWqOqNPo4RiyaZu9g0k0s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZHbFgZSh; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZHbFgZSh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741145365; x=1772681365;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VUr/tPE9mDuVh6NRvQG3YXuXcl7RuBt4AX7dvrjpPLQ=;
  b=ZHbFgZSh/UC5Ao+qdM0UFtDZ2CNJnIVOHl3k96gT8iZEZVUS7x7yf/iR
   yK/i6l00BKJ0WuqTv9M9UnITOkOIVsapZwWee+a5Vt1u4lk6FaqVPKPza
   /wGFN6JpeiFGvkZ8tBCUfewjW6uTNKXINTL5ObdvmwVOFhHmtuKrKUW63
   dwTaPrZIuAeau2uyCAOB5IBFWwaVcHJK20mEHR1+HaunXEfSYCb2P0usH
   9cBBQ4+dhUdV5W4f8kQ3b/3fcdIaNnEWa7s+viPW5YKDZLavz8Nc1f6H2
   DOAqaH7S6+Sx99ZsGIr9In6qyy4+UXHkY5oGC3jhoSSP0JdeOjuY1mmbB
   A==;
X-CSE-ConnectionGUID: 8A2JjVKWSQyy2edLV0NstQ==
X-CSE-MsgGUID: xpZ0MMc0R4m02JXACVmK6w==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41983839"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="41983839"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 19:29:24 -0800
X-CSE-ConnectionGUID: MIfyCv8TTRebf1nfbUeIBg==
X-CSE-MsgGUID: 9ngG/43pTDu20reO8Oij/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="149516051"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 19:29:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 19:29:23 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 19:29:23 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 19:29:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IvrhE8ToEPW52I2CHXanz1RGOFUeNLrz0A5hRDuFTwFutcNwohTxyOLjPs3uQ7UQeiFPY6NiaWlXrvAYwezM+wv/Sdw4u4IVoxStlGztV3ffCj/h82ELYcTq+VyBkqkYtnNUZNGKoc/logciLTgwc5HRhHHz/e0QPaJiMOklk1ocpVYfMuuZfgyC7kUTGjkyHjCIdqEL4ey+OMPh34ymG8l/HZqZi6b4IRYxnTNwTykygdKVZMMmLhClvJQFNqZ8tvnKITbwN22romAj1T+RgzG1m53Xgga9Phr3XwMQl9kXgdJ8R9Ii2OJMSGfvg7NdOo9KyDWtJ2AkHdLexpZIhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BRqka9ZuqP72Vs1LYy9YbO+roLL+x6JFKPFnLvwP5sk=;
 b=OqSuhwgOsL7JxyYjGuqcraj+W1UNs8rUR5lJ52m0ZB7DbPVgrZJ9HRslnG7JyYnbFNvj/uABzdDo3GSnPv24VdXKOnjHX+0wgPrYTvaBtARqyXQWt4XfWLEX/Z3N62uNM0li6npcAYbVErBH5Jypj9V0kwoHRgLdPSIx67wk0d/ILHnLZh998TpzVOtQykUvharg6Cve7axQXuIwCpgx+/G0aJOlqovTtnnMmyvbDlGt1jlo8bVzXjbW6azr8uHDmpg6YI8B43MxeV2RiviSfL0vtL4n92G3zPMiouU8jicWEe37ktv4CyGL4pIhlKOInssMahkhNJdXUqte7gbBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by CY8PR11MB6962.namprd11.prod.outlook.com (2603:10b6:930:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Wed, 5 Mar
 2025 03:29:21 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::d244:15cd:1060:941a%3]) with mapi id 15.20.8489.025; Wed, 5 Mar 2025
 03:29:20 +0000
Message-ID: <338ee285-ae28-4e3f-a7de-57205d9e9873@intel.com>
Date: Wed, 5 Mar 2025 11:34:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/12] iommu/vt-d: Cleanup
 intel_context_flush_present()
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>
CC: Dave Jiang <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>, "Fenghua
 Yu" <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>, Zhou Wang
	<wangzhou1@hisilicon.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-7-baolu.lu@linux.intel.com>
 <f7d84e3d-a648-4292-a652-408f704411c7@intel.com>
 <51cb2ef8-3cce-4af7-b6ce-c3e3d490e6a3@linux.intel.com>
Content-Language: en-US
From: Yi Liu <yi.l.liu@intel.com>
In-Reply-To: <51cb2ef8-3cce-4af7-b6ce-c3e3d490e6a3@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::25)
 To DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7529:EE_|CY8PR11MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: ce0c199e-de57-4eae-0748-08dd5b95eadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SCtHMVY2UHBKcFJmaE0wTHVobzBUd05CS3lRUUlZcWYvZGsrRlB6YmVqNzEx?=
 =?utf-8?B?Z3JvZXZrOGoxTGlydHVHbWlPOXZDYkxyS0Zpam1Da0MwWHJmL1RmQjJhTjc1?=
 =?utf-8?B?WSswQlN0YmVMNCs4ZGtXbkwrNC8xQmMwUFFuY2tlb2dyUXNlNERhWUtjS3Vm?=
 =?utf-8?B?bHhaeCtrb3BDUUZFSmJYaXlnVEN4dGptM0FRYmVucjRaRGFsL1QyZTlPbzZQ?=
 =?utf-8?B?cHppSXpmK0pOWkFLbEdVcVZKQXFkRmpQc0FJMURRSDhIQUJWSnNTd2lLeC9N?=
 =?utf-8?B?bE5qd0swSXBOOUR5czBHQkw4MGpZblg4ek1tbFMvUTYyS0xmZWQ1WW95MkY0?=
 =?utf-8?B?QmNING9zMUgzZjkrVCtHZ1QrV2pqZW5MTUtWckpTZks0Qkt5Zy8vdlZqK1hz?=
 =?utf-8?B?L0VLMnZoc2M1RUlEQ0pGS2lUWGNaVW5aWmxxa0J0Q2Q2bytDZnR1a2QyMkhK?=
 =?utf-8?B?TUV1eXRkZGRpVmtRc1NQMzlBWkhEMG8rVncySnlOc1JzVzFhQzJJdEJyOEha?=
 =?utf-8?B?ck9WdWRNSUhvUWxaTUVvUzZsdjQ5aW8wc1dEMWc0eExDS3IrcjZGWXcwNVJh?=
 =?utf-8?B?Rm1MVEtWOWNaY0VXVUwxQ2ZGeXRjNnVyRUs4TWZBcWJOS3BmamhIL01pWnhL?=
 =?utf-8?B?T3RoTHR4SU1YczI4Qjh6bWlNL2Q4M1FJd3diNWh3Uks5eGJ3R3JmY3dEamV6?=
 =?utf-8?B?anpnTW5sRFZjdlQ3YmR5TkxmMVZjM1BYZHRsNnY5QzJvNnV0MCtBZy9wOXdI?=
 =?utf-8?B?M3VBV3E3RkRwMUNWcDRyN0oyS0dTTHZhaGVqcUo5WUxPTTJTSGgwTlA3TDdR?=
 =?utf-8?B?TXlaNi9CMUQ5aGQwajVyaWlpc3VLdllmS1prTGRBazlUT1gyYm5MekJHZnFY?=
 =?utf-8?B?NkFxSVhsMlV4NDd6ZWpEWjl3aWJkYWVzWjUzUUQ4dFBIKzl3VkxzZzYvMEdT?=
 =?utf-8?B?OWFTVm1raUNta1JsUVV5akpDWFV5eXdjc1FoeURGZEh4aHpjeHhmNTRDelVp?=
 =?utf-8?B?Q1cyWlhHajN0dnNyVEJxd09oUmZaQzVCQkdoNTUxNUgzQkxCTEpBbjgwWTV2?=
 =?utf-8?B?ais0NVRQTkRPaHdITGxxRXplNis5d3ROTjdUeGdHcHhXYjVWSldtNVhxdEw0?=
 =?utf-8?B?ZE5tbVF6dDFhRDYvbXpIQU1heHJHN2dleGwrdXVtS1FKc0JaTloxVXlXa2pu?=
 =?utf-8?B?RzJNcUpYZmhrK1pmM2hXd2RHWWYxWW1PYTdCVWUzOFp3cisrNFViWGZOTnFE?=
 =?utf-8?B?SlA3QWZnVmJsR1l3R256Z1pyUmE2VjNKNTVQZnN4MDFKUFAyV0s4cE0zRVhx?=
 =?utf-8?B?YnNJS0pXd3hCRkxvTU5pckZMVER2djZGT0ZSSnFlc0ZZZnhBQnR2N3Ntem5S?=
 =?utf-8?B?S2JVbjNDYlh1TDNyc1hsNDR1VDIwcHA1dGdiMnJnelN2aFJ5RStuY0IvdWdv?=
 =?utf-8?B?QUhZOHlVeXpPVnVNcTdyVS9pM2ZWZEhjemIrZ1BlNDI0em80VzFSL1AzV1VV?=
 =?utf-8?B?QzlEb2xhc01QaDZPVzRSUktFUEpVRTdDam91bFRQUlZzejlVSzNHdlFwUUNQ?=
 =?utf-8?B?bmxwYzZjZ3YrNDA0U3FacHo1clhEakwyYmt5dkFwUlBsMncrZzJid3NFS2gv?=
 =?utf-8?B?d3g1M0NoR013QWhNdTBxRE9CNGVnaFpibGpMRWhFaUdwVVhHb0IwMm1WY1ky?=
 =?utf-8?B?OHg5VkNaK2xzaG1hN3JDK2EyaU5xYitMbVlUaDRlWndacUhyaHFSLzZQMjFM?=
 =?utf-8?B?Z01FaXVWcXBGbERSMUtpanpaM3NnbnowU1FVc1RPa0NOdDl2dk1OcVNjb1h5?=
 =?utf-8?B?V2E1QUtyMWFQZG5wVDMrcEJURjV1NHl6Z01tbXVGTWZobVVvY0ZiSXNqUTU0?=
 =?utf-8?Q?J1rr3FucYviwL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7529.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L1dtaUQyb24rcnBmRy82OUYxK2puY0NIbGFpbnZISFVVb1RjTlJKcjJtanND?=
 =?utf-8?B?RzRRcDd0UThEQjJRRkMyaGxuWkdKRWlsWlZNK1JCYUltMHByRzlWZFZrNkhT?=
 =?utf-8?B?QklJMGsxNkUxU3JJdXk5OWdjdWRkbitDZnQyOFBuMDZvcGtZdERMSktTMThJ?=
 =?utf-8?B?aHZNZk80dXFTS2g2dEhwRWloeWl4UUxpOTYvUDJxR25hZE1kMi9WN3kvSFM4?=
 =?utf-8?B?RHE1WFRDQlc4MS9uVml2b2NudmszaFVNaFM2UFlrbmRzRjJmMWFFMFpRM3pI?=
 =?utf-8?B?STlYcnBYcXJ6TkQ3QzZLVXZlbU1lWU0zdnFrN0x1bUFyOGE1UE1CSU1aQTRX?=
 =?utf-8?B?TXhnUm9HY0EzdDFXbFptanJzNnV1bjJDNDZNOW5NSGRSRFR3S0NWYVRDQXNt?=
 =?utf-8?B?Q25hN0w4Z1V1LzNEeWRlT2dYNHZmSXFDS2xINC9sa0ZxWDgyMWUxWXJwZkcv?=
 =?utf-8?B?Y3RTd0RlbHVqcEtsbkQrT0s2bllWMitPY3dwRWEzRG0xM0FPdnFTYU1LMDV1?=
 =?utf-8?B?OXk0dExjTGZ4Wm84MVVkZ0xIeFNYb1d3WTRVZVRVSGkvVWJzRU05dlZoazJZ?=
 =?utf-8?B?QlBPcFFqcitwWk9UT04zZ21qaEd3TXdnRVd1YjBLN2d6VnJ0N2lzQ1ZLNm9J?=
 =?utf-8?B?bVlNemNnVWFZaTUrSjd5cHAvMkdMYXdtL2Z2OG5xdzVjWTJ6dTNFeVBiMWhi?=
 =?utf-8?B?Rjl5TEtmbEgrdlRUUkljdzMrdVFLemFOeTZ2V0lHaS9EQTF4bnRBUnZuaTMw?=
 =?utf-8?B?d1FrR3pRSWFxdDg0WnNMSkx3eERORFFGZW4wOTQ1Sk5BOXBHSmVScUZ0WXpi?=
 =?utf-8?B?dFRucFIxWHVXaGhCZ3NZckxoN2Z1WVNHWlh2c0lnOE1LaEpVWWxXTGZ3QnEx?=
 =?utf-8?B?eHdGZjJUZEphdlQ5SDQ1TVdIVmF1U3huV1BQZGtTUjVMYWg5UGlNWDF4aGl3?=
 =?utf-8?B?SFdRQ3lKYkFWZkRqMGV6ZERUU1c3Z0hXZ0hYMlMveW0rY2FxMyttOTUxeUVh?=
 =?utf-8?B?c0tGTm4xVjlsTWF2TitiS2hrdit1MlpldVhNRlVIMVpGMzBUYU9YVmlGU1l2?=
 =?utf-8?B?RkpoRndsTE1JUHhGK3J0KzZxRVQ1RkxpT0lTdnpWZnZuYytMb1ZtUXA3TGhh?=
 =?utf-8?B?YXpYNUVDMENtVjVPMTVWd2pYWVZSRUQ4N0F5TW1FN1l3K0M1Z2wrS3Qyc0hO?=
 =?utf-8?B?TE1TclVid3Q5Sk9WMHN3emNUblNJWlZXMDM2RVRXL0plK3N5eEhOa0NwNzJo?=
 =?utf-8?B?clN4cEpoU0k5VWVFcWFDRThpS2o4V3RyMm14VmwzcGFSZ1QyVmYvQnBzRXpY?=
 =?utf-8?B?WUE0cjlRdHhPelRob1ZRUnVFdXBrVGlFYjNKVDYrLzFUblFpelZUYTIrSUps?=
 =?utf-8?B?SGgvRFZKcGd6ak1Ed3ZqZlNpdUR4YmJKWVA1Y1R3d0R5TnF3NG02R0RwTmFV?=
 =?utf-8?B?UHhyWml3QVc0UytNZVdOWVdoSGtSZmFaVm5HenlXNWJpejZ1L292YVE0bG8w?=
 =?utf-8?B?bVhFK0xyeGR0a1hoemQ0eDFLRStrSkJQQytabnI1aTBWL0dnR29PNG8zS29Q?=
 =?utf-8?B?M01QU0ZjU3VMVzJEeGN2amRwUitab1FScXBqRHBMaHV2dy9VZkVsdHJ5QjFC?=
 =?utf-8?B?cEh0Y3dxRkZ3TWN1WUVXdjJBYzVEN1dNaHFSUGhmT21uSjFOY1EvUzZTdGFV?=
 =?utf-8?B?YVZNVzVKOUdKLy95WU1JYkpXVTlLeXRGdEZUMkdRTlVGalZCSllNR01YazZz?=
 =?utf-8?B?NVo0enFZb0JzU1Zic09FWElwUVRaRkQ0SXdrenA5YmFBTEJLeHFkTWZlTExL?=
 =?utf-8?B?MW01QnNYTmYzbWNXZU9VU2NVaG9BWkpmQ0VBMG9xR1BhM0lOanRkNXp2WjR4?=
 =?utf-8?B?dzdMMDFuK3ZaZ0hlNkIzUUg0UUdKMzdwcWV0disyUjFpelJhaW8zM3RuYUYx?=
 =?utf-8?B?TnVnRnFNUzVuSHVubFR4dzNpZVhmNW44aU9GK2pxSUY2cEo0ZGZXUWJnR1BH?=
 =?utf-8?B?MlNmQ2JUdWtGNzdTbDkvQ0RhSmVINmRNRzByRERPUWIwbUowRzFVd1ZpUVJu?=
 =?utf-8?B?T09EWWRCa2pMdXBTaU9MT2JMVlhyRGUvNUdsOHh0U3ZPSmp3THdnVlVXTjRw?=
 =?utf-8?Q?H/34NaWg3wyibb1XrIPj9xrym?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ce0c199e-de57-4eae-0748-08dd5b95eadb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 03:29:20.8037
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DW2eCdFPp+7qk0KLeB0ffAY0SXSgTWaqEVockE0+a2Pu7mzXKsmvORskoRAjyrwvmWTLn3J94wZj+MjhpuU21Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6962
X-OriginatorOrg: intel.com

On 2025/3/5 10:21, Baolu Lu wrote:
> On 3/4/25 16:43, Yi Liu wrote:
>> On 2025/2/24 13:16, Lu Baolu wrote:
>>> The intel_context_flush_present() is called in places where either the
>>> scalable mode is disabled, or scalable mode is enabled but all PASID
>>> entries are known to be non-present. In these cases, the flush_domains
>>> path within intel_context_flush_present() will never execute. This dead
>>> code is therefore removed.
>>
>> The reason for this path is the remaining caller of
>> intel_context_flush_present() is only the domain_context_clear_one() which
>> is called in legacy mode path. Is it?
>> If so, it seems unnecessary to keep __context_flush_dev_iotlb(info); in the
>> end of the new intel_context_flush_present(). Also, since this helper is 
>> more for legacy mode, might be good to move it out of pasid.c.:)
> 
> This helper is for invalidating various caches when a context entry is
> present and certain fields are changed. It is used in both legacy and
> scalable modes.

hmmm. the kdoc says all the pasid entries are non-present, is it necessary
to flush dev_tlb in such scenario? I suppose no present pasid entry means
no pagetable as well.

> In the past, this helper would work even if some PASIDs were still in
> use. After the changes introduced in this series, this PASID-in-use case
> is removed. So remove the dead code.

yeah, I got this part. As I mentioned, the only caller now is the
domain_context_clear_one() which is used in the legacy path. That's why I
feel like it is now more for legacy mode path now after this series.

-- 
Regards,
Yi Liu
