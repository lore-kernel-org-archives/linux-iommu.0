Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CB249659
	for <iommu@lists.linux.dev>; Tue,  3 Jun 2025 03:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748921504; cv=fail; b=W0yI3KGRYTYzY1S1mZAqPuc54rTyM0r3JzN1elwyuhGcV2coIw69J52S629FBFf/pRc6r+RR6Y4p7LRJPnD16F44K963P3GASOB/HkT7N6J93Aw0g0gzr2jWYgvo5MYJddqOTVVFkJsL1pZRiVehZTQVEwJRR7xUAf1sUkyueAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748921504; c=relaxed/simple;
	bh=5pDkg1CgwR/YUGeiorVzWfbF1BmY6pjix6sWfHxfnDI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jIIEUgrXP+2rlaiSeGaHMsNY/8yyUi/m9xtBPUz5Dzxb3Ec9E09/aUf//Izjy7TsYhUbI8xmqe8xSRfi4h/+mGXKJpxZBsmh/G/Dgj7Z43fdAMD1tjPE0MoPMBj0Z4u5ZHbfD1Y4tKQj7mu8r/OeOxpFqDc4kRRarTa7zwkEHkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gP8QJy/i; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gP8QJy/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748921502; x=1780457502;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=5pDkg1CgwR/YUGeiorVzWfbF1BmY6pjix6sWfHxfnDI=;
  b=gP8QJy/ig2+3JX3tjiLCGxnapXTGNflLg917GEo78IEJwyO0Lv8Si8ql
   XZVby2n/0SwKnpNMjAM73olm7Muu2J3N9d/Yd+mj8/+tZF5Z6cGQMpBp3
   9HVnl3Rtzay2JRikww1gSJG+4N7eb9tY2pEL9S52uwkcDQrZJ4uBPslpe
   XrUOHpFNocs4r8YcGnTbuKxb14VBvqXgdBnt2hC9erhst945+b8eooW3Z
   IY+eacwR13dcj3gNOpXBaEe6JCVNQQtUtbLf0SZEapG2K9LrFgeiIrsQv
   Hn55J2pO2jr67STvQGeKg+hc3pwN6Ia71v5TbphptFI1PrOa08Ae2KdCF
   A==;
X-CSE-ConnectionGUID: PcOrYd1RT324i98wCCtDiA==
X-CSE-MsgGUID: 8nF0Tf/pSJWIEe3+K1prGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="68498676"
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="68498676"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 20:31:41 -0700
X-CSE-ConnectionGUID: TfJF09A6QUGY2SS6l5bDuA==
X-CSE-MsgGUID: kEXWY7DkRDKZ/N8nQKBDzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,205,1744095600"; 
   d="scan'208";a="145673356"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 20:31:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Jun 2025 20:31:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 2 Jun 2025 20:31:40 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.44)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 2 Jun 2025 20:31:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dcp54eSBP3MP/S70TZl5m7wdMM0yBTm5EjlHp6p+YuRqdhyDUlO6sTUMJQlQWS3aiP8xlKPufBF3UtBKOXSex99fUci2vwtZE//NZU8lS7Iz2J5B5vJrydDZ0Bq/9kwHAQmbnt/rAo/9oGJiGkap+PoSQAy1JVpnR2XZYsGXobbUH4YxNYNaIAIz6T3Li6tTckvT/gFpkosSz+fYw8lPbX1285FT3qEMuBdE/9gU8fnTDolKir+LevJVE6g3ZfozOc+ruyne4hnaGvO9+hZmvLkjpbdOH4jZfMctlhbMNEhPtdTGjeiMmD1AXYA2j5aNEwRFNu1DySH9IbbNoyN8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pDkg1CgwR/YUGeiorVzWfbF1BmY6pjix6sWfHxfnDI=;
 b=GUpuPea3fMqlIMnsXi89TDOWrlCBzB9zoWJVd7T2bZA+EchudAy91IW12+ETdx535ImQicITwFgt6lstDyR9gFogp0Uh88EIOoXxJ0pnezsqEkME8pPFGxT46FoOUbY1s7ObmxqQVUN0rq6idoDu8vXNORUzTd6tTaO1QlplHk/pz5zjlgSyIqd8Z7fcqE+1eUpyQUY0lsEjjlXlmFF4sPOj/vtTHDgJRtogj4gbtpvKSZNdKHiGzOJA/FrWZrQ+7J9G88ashIZbSGVR5dDU4I+CFX02GXVMQYEB8M2JeJr/OZdKvFejZMSLolt6pM2q4iNccY5ozrkXiwpqZKjrUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 SA2PR11MB5019.namprd11.prod.outlook.com (2603:10b6:806:f8::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8769.37; Tue, 3 Jun 2025 03:31:04 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%5]) with mapi id 15.20.8769.029; Tue, 3 Jun 2025
 03:31:04 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
	"Liu, Yi L" <yi.l.liu@intel.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "jroedel@suse.de" <jroedel@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v1] iommu/vt-d: Remove dead code in
 intel_iommu_domain_alloc_paging_flags()
Thread-Topic: [PATCH v1] iommu/vt-d: Remove dead code in
 intel_iommu_domain_alloc_paging_flags()
Thread-Index: AQHb0QHfGB5c4emmLE6iO4F5TjJVP7Pwv4uAgAAJ/rA=
Date: Tue, 3 Jun 2025 03:31:04 +0000
Message-ID: <DS0PR11MB637391ECB166209035638E8EDC6DA@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20250530091325.694456-1-wei.w.wang@intel.com>
 <f1f55968-28e0-4c5d-876b-1c5499b3c01a@linux.intel.com>
In-Reply-To: <f1f55968-28e0-4c5d-876b-1c5499b3c01a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|SA2PR11MB5019:EE_
x-ms-office365-filtering-correlation-id: 6df5245b-1006-401f-7138-08dda24f11be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZWErakFmdEpTOVVKQkgyanVpRG1kMExKbjhrY3Y2VlNPelV6eTBPbFFKcWg0?=
 =?utf-8?B?b3lsZmVoTnlLQUpXaXMxcDBDeFUyVkhINEJlY3BBSFZCbVZLZm9HQ3lXNmFE?=
 =?utf-8?B?VjBzVFc3MFBXamh3Ukl0cXlYL1pMMHRHSlRWbFozaURuOXlhN0dqMC9RQ2Vy?=
 =?utf-8?B?MWtDUGUrcms2a0pZdzRVcTNZdUt5eXU1NDJYNTdUdkkrRWgrcWw0WmhRNFoz?=
 =?utf-8?B?M2R3NUswVzBjVjliRmtVc2xsTEFQUFZ0UGVXS3hYb2JQU2RnMHdidTRhNTh2?=
 =?utf-8?B?anhnZ0dvZE1FanA0eENLdE1nUkFteEJkNkQyVGlxcEgxaTU4ajRhN2xuYkxE?=
 =?utf-8?B?RTNxcUpBUEZPNmlidXM1YmRod0lwaVdMVWY0QW1LRDFwUlpWMHlmano3QVBp?=
 =?utf-8?B?Q1BQL29oYWFBbkUvZGtGam00aFRkUm9TTVJxU29ST3FjeklFWHlvdnlKWk1E?=
 =?utf-8?B?QlhvZWxPNjFhdC83QUlCSEwvWU16VGFuOTNKdkdhd1BCcUYxTWxqMVU4SFA1?=
 =?utf-8?B?NWh2aVdzY3YySC8rcy9FdjZqZGNqQm1najJ0RDRTbE55RHU0dERaT092VWxF?=
 =?utf-8?B?bUNKWTJ5MXRoR0Q5ZXlWcWRkWlNjbG8yZGJhS0tOdjZ1Q2FaMUZ3V0dMcGpB?=
 =?utf-8?B?SXp3TTAreE93OTNMVnJ0eHFDdnEwYVAyU0hpbjVTbFZlT2FXUXg1eDBORTBw?=
 =?utf-8?B?aDl3L09xR0VQR3Jmd0FVRjJXY3dONEY2dGQyUUhLQmEwVVphc2IwSjVISzh6?=
 =?utf-8?B?L3dTYkpuQ1lOekVQNlpuRkcveEU4a0VUUTlHTmdTWUg0TXBXS011V0pNQTlo?=
 =?utf-8?B?NkgxU0dvVWJUUGZqL29CS0J5dWY1M3ZsTjVYem9RRVUzdnU5ejRSWElwQTQ0?=
 =?utf-8?B?RDdIaEp0aTJJcm5wd1hhMWlERkdRTEs2cjE2SnF5SXJtdzZwR1d6VzhUdHJK?=
 =?utf-8?B?TWdOWXBNejk0U21RRTFkOHc0R1VXQ2Fnd2hXVmgzSzFPT0w5K1g4cElXNTRP?=
 =?utf-8?B?cDBtUmFRTjU0clFqby9yTXJSa2pyaUUvaHV5MDUyVldnU0wyTWc4b3pZOUo1?=
 =?utf-8?B?dm1EOVNZeWFVbjFKb0t1TXlrQ2p2dWFWanNmMUlPSjdWR0NhYkh4TURBNDNz?=
 =?utf-8?B?RlJJTWlTRGE5WjlQbDhxcG9DZWpQUUVRNGxSVS9kM0Q3QUJIZjdxK3QvLzNs?=
 =?utf-8?B?ZG5HMDZZS1UzWU80MmJmSytJM2ZZSEZsUTFpYXh4bHJreDJBMTlPQkVEUjBQ?=
 =?utf-8?B?Q21vRXFjWkZBWjNPUzBOeXZYbnRXeWdGWmx5ekZ3dm5sK1JBN1UwRzNuUkYv?=
 =?utf-8?B?Ty9JNDF1OWs0Wm9TNGJaT2ZYYk9TMFNVQlpYY2VsQjg3dnFQQktZNU4rUXla?=
 =?utf-8?B?aVVIWWRUTzIxU3kzMHpjVTl4UGs3dXp5TURyOU1TM1QwM0ozYmZuMXdUZ3pH?=
 =?utf-8?B?MmNYY25EQit6S3hrVCt3aUUxM1VHVjU2eVVhOU9GckNyZ1p1UWZQK2I1K2pW?=
 =?utf-8?B?ODhWUHphWFFlT1RLK2V4aXZHTyttLzBxOWpkWXdsNGxiZDFBSEE0NG9Kc05F?=
 =?utf-8?B?Q0ZxWkZ0NGdBOUxHWU8yL3hOa3Myb3FWVy9QTzBxWnZXdi9qSllHcldrNEkx?=
 =?utf-8?B?UUN6UHJTQ1E2TkhuK09EYjFvam9yVVRodkVuZVVDSU1JVXp5aE9RTmR5SytW?=
 =?utf-8?B?bzlqNFd4aC9EclZKeEFLdkU2U3p2MjY1VUV1ZkNkSktKbWp1bWVJcEQzdU9O?=
 =?utf-8?B?aHdGYUlzSXZHZXhiV3dVSDRtS3dCY2VtTDAxZjJieWxJWndlRVJRR2JORlQw?=
 =?utf-8?B?QU9FZmM4emJZczdaWWdHSHpQNWFNYVhVdDBEQU1KSW9XaUxUUzlEYXNXUFRj?=
 =?utf-8?B?dHRvMzJIby9zRlI4Z2hRVmVjNXVuaDV5dzVybVVTZ05mMVVTaU1LQWtLOEIx?=
 =?utf-8?B?WWlLRWt6UDdyQkZMRXVmS3RaaFN1a3RTc1Y0NFhGampUSUZGSFhyN1ExV1Nv?=
 =?utf-8?Q?7njuReuJxYaUWybxXGZv6rlmhVJ3uc=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a2VtSGVJd0g4aDRGRHRSckc3M3FhMy9WMExyY1ZBYjZmUTFUcXRQNFdOYURE?=
 =?utf-8?B?MnZMcjEvaDJEK0ljY3JqZDcyclBkc2h2OGRqYW8zQmZOSGorNTgzOHEwc0VP?=
 =?utf-8?B?dzg4WW92Z3laeGdXcnBGNGZqb0xMVVpyN3RkZkFWcVFFZkZlVWNGMWRlZC90?=
 =?utf-8?B?Uy9DK0F3enZTeWlMRFBuMVY2UjA1aTlTVzVPYUhXcnJGbHR1ZDg3TkRpV0Uw?=
 =?utf-8?B?SG9HL0NoS1JUY3lpSmdlRlNONlRvRUhyKy9UVVJkWU5XL3p4OFlpM1VhL1dJ?=
 =?utf-8?B?cXFNclhTLzVVQWlkb3A1RXFVemFURG5Eei9TQzkxdXY1ZXFDS2tYLzB3UjJ2?=
 =?utf-8?B?ZlFJMXNVQm5Wc1BiWGVSL2phYVZTV2hsd0krMk5SOTJGYnVVZFJmYjVyOTFj?=
 =?utf-8?B?Mm5GNUVTREpvY0Z4SmRWZXhKVXpqQUlCQW5YOXNFMUo2N0IzdlI2eHFkNkx1?=
 =?utf-8?B?UmNBNURuYlBnNTJFaXJObzVDR3NBWlNNdS9hYk11a3gxU3NGTzJ3aDRaRDNp?=
 =?utf-8?B?SGZDYlB0TWlObnpDbDF1ZlRsdEp1eEVkUjFzdXNuMitPRGtxclJoalROY2pa?=
 =?utf-8?B?STRIeXA2TTgzbllQRTZNT2wrcXFKbnoxMy95bDRCVk9CcUwzbTFwb2pVcFFr?=
 =?utf-8?B?NXZuVU96ZkFvMWVCM0ZFU3ZkamVXWGx5dkZQWUFTaUsxKzA4RWR4eXlteTNh?=
 =?utf-8?B?VmsxbDJOelpwN00rRXZtMmlhakU3em03SFFZcGR2OTVrTGhNQmZ4c3FJV0VO?=
 =?utf-8?B?dDZVUUZRVzBDMkxudkIwNHVUK01yZnVCZThOc0VTdVI4Wlp6NFlEdWhFQnJS?=
 =?utf-8?B?VEE0ODEvV0YzTld5S1BMMnVzUTd0VUVQZUxJaTJsYVU3U3ZVbmdjaXJYQk5K?=
 =?utf-8?B?S01YYXJlTVF0OFo1QVJIT2xBN3U1RmRFdGREc1AzVy85UW12MWpZNExyZ0xL?=
 =?utf-8?B?aUFvcllXb0JkK2YzamNZMSswcWxsNWNwU1JNQ1FDdHRuUFhHc0g5Z3BjdzEz?=
 =?utf-8?B?d1RZWnN4WGdYN2ZIYVM4K2VROEJ5akF1ZjdWQTJHWEFoZHpUdFI0UktaeEhu?=
 =?utf-8?B?T0FWR3VtWTlSVUwrSHNTUk5vVmNGREl3ZlNuZDI5NlFDNERXUUtCQmpJOWM4?=
 =?utf-8?B?NGFGVStWY3hRRFNHbnB6dVloV0NhdkROS1hnNmZ2VktZaHkwNmVWclRpTnpG?=
 =?utf-8?B?dXkwM1BkNStYN3pTQzBQY1VUc0l6aG5jZDAyUVBtalFwTmpZbFNSZEZoVzZH?=
 =?utf-8?B?SGRXMGQxZHJlZ1orRXJTZkpDVS9nelF0NzMyNVQ4YXhNd0t6N1BNVjlWc28y?=
 =?utf-8?B?Vk5xcUNmNWpyYTh0WkpZNUJIZWhGWWxQZ0QrbmRVd3dGakV2Q3hNV1JaeGsw?=
 =?utf-8?B?ZWFyOEcxb3dBMkw4YmpYWTNUTTlTUjZDWUhNeVZNMjRXbytWbDAvcjVzQmc5?=
 =?utf-8?B?UkdUQWZuak94WjAxTGZrRkJIY1F3NHk5dzJqLzVlN0IyTVFTYVhIQkIxYUs3?=
 =?utf-8?B?bjVuYU11L1hQOVI5WTBVbWlFbnhRNzdyV2p4OU1xa29TNEN2YnI1RnE4cjE1?=
 =?utf-8?B?Syt5aVpZUzlzdFBWTUlJcng1R092Mlp2cFJ5TDBTaFdVUEZoZVhTaDQ3OFhu?=
 =?utf-8?B?NkF5Y3dHSlBvRlozSmE1WXJwai9kTFpmYlB0a1EzcUFRUWVDbHltMlI3dmk3?=
 =?utf-8?B?aldMN1pyQ2NTR21PNWFMb1p1WmRKTy9za0dESkY1bWg1dVppQVE4MWFjWENQ?=
 =?utf-8?B?Y1QxRGJabmdGU2Fsb09HdlVNbHJ6MTFqRTVhRE1FZ3ZWaUJlSk0xdkwzVjEw?=
 =?utf-8?B?YWVXS2JwL3A4SldUMllxUVo1M3ZqSWY2UTc5UDJ3MXNmM0FFblJYdjhZZVRr?=
 =?utf-8?B?TWZGVE0yU0wyQVVJSDIya1hJYmZpUm9ZQTU1STlaZ3J0K2JYYi9XTVNGUTly?=
 =?utf-8?B?Q1NQT09yS1lHaU50SEhvNXp0SXR6b0lGNFNLa1paTmo3dmFZV3oxOW85OFky?=
 =?utf-8?B?RTE3MHF2ZVVoTVNEbU9ZMVphMTlWZzFGck1GbHFJcm1TdmFKRDRVYi9WRUVO?=
 =?utf-8?B?WmpwR1VqREI0aW5FMm5VZW5Ubm5pTjNvVWREYjRKQ0F0dXRSaEVKWEo2VWNK?=
 =?utf-8?Q?R3E2cNMuAVrNR2YTnXR/RPlB2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df5245b-1006-401f-7138-08dda24f11be
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2025 03:31:04.0219
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p3B+nqOpVtDVwS4RvTtSeJO0irOD0eb/XZXBieqSIa4YTi1Qj7wZ34nyst02xEGo3/WIg1EpMVjhhu2QZccnxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
X-OriginatorOrg: intel.com

T24gVHVlc2RheSwgSnVuZSAzLCAyMDI1IDEwOjQwIEFNLCBCYW9sdSBMdSB3cm90ZToNCj4gT24g
NS8zMC8yNSAxNzoxMywgV2VpIFdhbmcgd3JvdGU6DQo+ID4gV2hlbiBkaXJ0eV90cmFja2luZyBp
cyBlbmFibGVkLCBmaXJzdF9zdGFnZSBpcyBzZXQgdG8gZmFsc2UgdG8gdXNlIHRoZQ0KPiA+IHNl
Y29uZCBzdGFnZSB0cmFuc2xhdGlvbiB0YWJsZS4gZG1hcl9kb21haW4tPnVzZV9maXJzdF9sZXZl
bCwgd2hpY2ggaXMNCj4gPiBhc3NpZ25lZCBmcm9tIGZpcnN0X3BhZ2UsIGlzIGd1YXJhbnRlZWQg
dG8gYmUgZmFsc2Ugd2hlbiB0aGUgZXhlY3V0aW9uDQo+ID4gcmVhY2hlcyB0aGUgbG9jYXRpb24g
b2YgdGhlIGNvZGUgdG8gYmUgcmVtb3ZlZCBieSB0aGlzIHBhdGNoLiBTbyB0aGUNCj4gPiBoYW5k
bGluZyBmb3IgZG1hcl9kb21haW4tPnVzZV9maXJzdF9sZXZlbCBiZWluZyB0cnVlIHRoZXJlIHdp
bGwgbmV2ZXINCj4gPiBiZSBleGVjdXRlZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFdlaSBX
YW5nPHdlaS53LndhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9p
bnRlbC9pb21tdS5jIHwgNyArLS0tLS0tDQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21t
dS9pbnRlbC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4gaW5kZXgg
Y2IwYjk5M2JlYmI0Li4xMTQ1NTY3YzYwZjkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21t
dS9pbnRlbC9pb21tdS5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+
ID4gQEAgLTM0MTgsMTMgKzM0MTgsOCBAQCBpbnRlbF9pb21tdV9kb21haW5fYWxsb2NfcGFnaW5n
X2ZsYWdzKHN0cnVjdA0KPiBkZXZpY2UgKmRldiwgdTMyIGZsYWdzLA0KPiA+ICAgCQlzcGluX2xv
Y2tfaW5pdCgmZG1hcl9kb21haW4tPnMxX2xvY2spOw0KPiA+ICAgCX0NCj4gPg0KPiA+IC0JaWYg
KGRpcnR5X3RyYWNraW5nKSB7DQo+ID4gLQkJaWYgKGRtYXJfZG9tYWluLT51c2VfZmlyc3RfbGV2
ZWwpIHsNCj4gDQo+IFRoaXMgKmV4cGxpY2l0KiBjaGVjayBlbmZvcmNlcyB0aGF0IGRpcnR5IHRy
YWNraW5nIGNhbm5vdCBiZSBzdXBwb3J0ZWQgZm9yIGENCj4gZG9tYWluIHRoYXQgcmVsaWVzIG9u
IGZpcnN0LXN0YWdlIHRyYW5zbGF0aW9uIGR1ZSB0byB0aGUgbGFjayBvZg0KPiBlbmFibGluZy9k
aXNhYmxpbmcgZGlydHkgdHJhY2tpbmcgc3VwcG9ydC4NCj4gDQo+IFdoaWxlIHRoaXMgbWlnaHQg
YXBwZWFyIHJlZHVuZGFudCwgdGhpcyBwcmV2ZW50cyBwb3RlbnRpYWwgaXNzdWVzIGlmIHJlbGF0
ZWQNCj4gY29kZSBpcyBtb2RpZmllZCB3aXRob3V0IGF3YXJlbmVzcyBvZiB0aGlzIGRlcGVuZGVu
Y3kuDQoNCldvdWxkIGEgd2FybmluZyAoaS5lLiwgV0FSTl9PTihkbWFyX2RvbWFpbi0+dXNlX2Zp
cnN0X2xldmVsKSkgYmUgYmV0dGVyIGhlcmU/DQoodGhpcyBjb25kaXRpb24gc2VlbXMgdW5saWtl
bHkgdG8gb2NjdXIgaW4gcHJhY3RpY2UsIGVzcGVjaWFsbHkgaW4gb2ZmaWNpYWwga2VybmVsIHJl
bGVhc2VzLA0KYW5kIHRoZSBjdXJyZW50IGhhbmRsaW5nIGxvZ2ljIGFwcGVhcnMgc29tZXdoYXQg
Y29uZnVzaW5nLiBJZiBkZXZlbG9wZXJzIGFkZCBzb21lDQpuZXcgbG9naWMgdGhhdCBjb3VsZCBj
aGFuZ2UgZG1hcl9kb21haW4tPnVzZV9maXJzdF9sZXZlbCB0byB0dXJlIChtYXliZSBieSBtaXN0
YWtlKQ0KaW4gdGhlIGZ1dHVyZSwgdGhleSBjb3VsZCBicmluZyB0aGUgaGFuZGxpbmcgYmFjaywg
d2hpY2ggbWlnaHQgbG9vayBjbGVhcmVyPykNCg0KPiANCj4gPiAtCQkJaW9tbXVfZG9tYWluX2Zy
ZWUoZG9tYWluKTsNCj4gPiAtCQkJcmV0dXJuIEVSUl9QVFIoLUVPUE5PVFNVUFApOw0KPiA+IC0J
CX0NCj4gDQo+IFRoYW5rcywNCj4gYmFvbHUNCg==
