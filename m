Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9579F136338
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 05:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729660621; cv=fail; b=NKs9MhNk4/bWEigGxrYDUGABY6jG93i0ILgTeb0+mNG1tJj5j8eColmLpm9tbjXbzzKHxedhJP3nCocyskXTclkq1z+qwVhsADikJuScLKC4TPRFNCEqpdyRR5W8N13RTEg4M09DiG4Df68if2YAvKWGRKPcTumontYZGf8UhnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729660621; c=relaxed/simple;
	bh=Zcd5iNAjMKadNyCvbFG/m+kdZ0q7N8bA095CvY6csiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PaW876Tskq65NCZqzb7PNyvthk5rigbIAbsFZXeoqKnMEaRYYcXO7BnQbEJQizzJ+VFNzwHhXiOqS1sYzXu1CyeJxNpx8sIBbKkUQTLzUoaHwpBq/AnzqaSxMbO9UgH+omNgZDDVlA+v1x+TwyZmuQv28HR7xFupWm0w+u7H+eA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L/Fan3yv; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L/Fan3yv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729660620; x=1761196620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zcd5iNAjMKadNyCvbFG/m+kdZ0q7N8bA095CvY6csiA=;
  b=L/Fan3yv63BEWvRvo/UaACJiLLLlitvZvfOgDsrZHQnEkHYKhMYsLzad
   7UA83vtfjaaoX0W7URjQqHKldg212mCoqKcqOy5oQaPPzTqrVzVeFeWjD
   6NtW6x7sMDBW5VHfcrKa7iaoxN5+a4uRrJyE5YoCdr/hJWV6IBobBTxW8
   5YMy7mnowD8hCuMfz+IPabC78t1pSKwjYP6VaG++X/wxd697jWs6y/5x9
   l7CQxmD6iDuw27d+1zvtymxcJxAJjsj5lVku+pomL8pulMw09w4ibxhO0
   BZCKePDmCvphA2Ybz+7VlwDgVTvgLK91/dROttE6AbLBNvOqzHUSyWB2B
   Q==;
X-CSE-ConnectionGUID: a0/yLDSARLC1/bKmi9/sTA==
X-CSE-MsgGUID: A7512vmrRXKGr+nr/2Y1aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11233"; a="29123628"
X-IronPort-AV: E=Sophos;i="6.11,225,1725346800"; 
   d="scan'208";a="29123628"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 22:16:59 -0700
X-CSE-ConnectionGUID: n5RFwkjBQ2eNgscdeWbc+g==
X-CSE-MsgGUID: PuWnMsGxSqe8RbT6eKyIfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="84902866"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Oct 2024 22:16:59 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 22 Oct 2024 22:16:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 22 Oct 2024 22:16:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 22 Oct 2024 22:16:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aquy7wodEA4gZ1NCDa1DYA7a8jiCcfSW6Dq1XfCszBTWwmvlY0UQ/+XhM2QNy806UU46BoPCgDKfWCmb0SpRSWQz10kxYdJ0MqKjfkyCL6gV4vQyg6Zi3QZq/tH9bm8bUU7RbHxCPbpBzyEE4Ehmc4No/bqCs7KGbg8rcR7M1BVUWeLjcITtKJPqU3brjp7L37uscuW7ZZXh5Ni2Ew0f5xQsezMDvbMLP7Rnshd2itY9KadSr19OBZSk+kYfrF0vOGsZha9HNrscCeQ0dXg9YDbbB7xLdh5gsz4e3/zr4/Db11LsoZnPEslBQlSP60DKg2T4L0Vl8pyheXdH1Zv6fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zcd5iNAjMKadNyCvbFG/m+kdZ0q7N8bA095CvY6csiA=;
 b=HFFi6FAek39gYMD15rQR4IsnQiWRUCPR3AI2dljloHckyzwf34CjIHBoK5/CC4TsO4w8waVSpzkS2x5yHZ7aO5szew6+lFj59qkLC2XR3++c/U5scSQLm02VO+SXy6daYH4A31r8GuF0nrsyhgT1nuvKgg8ywaFoRy+QgU9/v7ptvyILIFtzlUQPGMu1BZUJHXq6nKg41BFM0dRYo2pz+khqn12u2YFQaHBaO2jQK4u4x+3dsfM6GYjxc0ChWF275NNVUDts17tVxN0g6vx4Tru8iP9E5hDgvL/gFkj2jAqf1aZpoh5dY1EPsHz9PrT1LQaaHPDRwpwxoiT15VL1WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by LV3PR11MB8674.namprd11.prod.outlook.com (2603:10b6:408:217::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Wed, 23 Oct
 2024 05:16:55 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::fe49:d628:48b1:6091%5]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 05:16:55 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "Peng, Chao P"
	<chao.p.peng@intel.com>, Kyung Min Park <kyung.min.park@intel.com>
Subject: RE: [PATCH 2/2] iommu/vt-d: Fix checks in pgtable_walk()
Thread-Topic: [PATCH 2/2] iommu/vt-d: Fix checks in pgtable_walk()
Thread-Index: AQHbJGhDqRDkRT5yak+iRoHXqTbTzbKTxSQAgAAFi0A=
Date: Wed, 23 Oct 2024 05:16:55 +0000
Message-ID: <SJ0PR11MB6744EC9F9B202E1BBE7DC4B1924D2@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20241022095017.479081-1-zhenzhong.duan@intel.com>
 <20241022095017.479081-3-zhenzhong.duan@intel.com>
 <813d32e8-e84c-4744-bc2c-b76adc10d00f@linux.intel.com>
In-Reply-To: <813d32e8-e84c-4744-bc2c-b76adc10d00f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|LV3PR11MB8674:EE_
x-ms-office365-filtering-correlation-id: a7d54053-1d10-4df3-9914-08dcf321e933
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NnFHVC91Y1lsLzNhclZQYlIxMzVDVXFNSnkwZmh1N3dGN1h4RTE4anVaVFZM?=
 =?utf-8?B?a203Q2ZrOVJGb1hpdzdESUFWR2p5cFpJOWtrR3p6U09XZjlndThRYjczWldE?=
 =?utf-8?B?bHdrVzNGeFcwNWl2b3VmSU1SMnZJSGR6QmZBSzJrWUQybWNxdWVzZklxaTFn?=
 =?utf-8?B?SnJKazhBWWtXR0RkaWt0dzRla012RkR0Rmh1c0ZZMERGNnFvMU5zUG0ySExJ?=
 =?utf-8?B?cjI0dGRaeDc4NWtTc0xIOGF4T1BnWXVEaWtFNkttdUp4VHpxcjNubVNacGhK?=
 =?utf-8?B?WUFCZW5QWmpNK2hKMjNvRUtjeFUrZUVtVlFKbWhaRTB6bHFHZlQyaUtBY3lY?=
 =?utf-8?B?cVYwczRZRkZoTHJ2eUs5NjdEU3RqMnJHVnZvMTZudVpOV3Rrc0IzSmYrRHMx?=
 =?utf-8?B?K3Q2NTRUSmpXcy9wY1ZUOVIwVURFaUZrWTUzamhXUEZEdmE4VjVOcVZOLzhu?=
 =?utf-8?B?YUUwNktsRURRT3k5emF6S0NIVVNWRC83VXlNcmh4T01aZlZvbkMra2o3Z0th?=
 =?utf-8?B?MndUdjJCakZoUjEvMmRzU3V2Z0dLMWFxL3BlQ2tuNlI5cEZFcld6aXptZlB6?=
 =?utf-8?B?T2plRkdXVytaajVZcWVoMjhpNHU4a0RMN0hxNkI0R0xTc0UrVG45cnZyWWUw?=
 =?utf-8?B?Wk96a3dNb2ErVmVZeCswU1FINU95cXRvMDc1MXNsTHB5ekM5L1ZvQnlPM0RK?=
 =?utf-8?B?WDNTMkg2Q3FIN2VUR2JJVTE3OGtDYmg3Zmc4UmxOdnoxcHVzd3RremNwZldK?=
 =?utf-8?B?cmViOW04UXhMUUNnMjIwZUVpNGZHbUx1YUNlRTkwc2dpaWlBVVcwc0YyL1Uw?=
 =?utf-8?B?TkRTUFhZNnZYNXJ0TjJHV3M2V1dNTEVBemRXMyszRWt0SWFNK0Vjc0ZZakNQ?=
 =?utf-8?B?V2ZsQmpBb0RLRzgyVnRnUWFpMW1WVERCNkxYMXlTN3E3M25ud1pHRDV5eWV2?=
 =?utf-8?B?em8wTjBWRG9OZVFwQWpTRUNzQkYzalJiMkNGYnFzMUxERDFqUGNiN21rajZ0?=
 =?utf-8?B?dmRaUThJaStYd3VBdFVCM3JkNnJrY1o2TXAzSzZuVVBiRFJraS9PTnE1WEdZ?=
 =?utf-8?B?QnJHTzJ0OGlyWEg1UEMrZnV2TU9nR3RpK0ZiVXAvUHpxbzdtV0QwNGJZYmpy?=
 =?utf-8?B?eVVrT2IyaThJUXZXYmxyc2dMMzNhektrZENFVkpUZllMZ24xM1VvS1MrUFZR?=
 =?utf-8?B?NEFrbURlNWNZTUM4V09mSTJwZXRmZ0RHK0haeG9Jb0wxTkZBQTJqY3JaUnZh?=
 =?utf-8?B?Q1BtdjJodStjQVd0dExRR2dOYkJha2I1TXd4emFjYUQ0U2xUZndxRFJ3bUpO?=
 =?utf-8?B?OG1wTXdTWHNGY0FWWndhTXN0SDFBTFo2LzI4ellJeHdXZlZqNGZ5NW9BdDF2?=
 =?utf-8?B?T2ltQjhBUDJVVzhxemsxNzRFTHp0aGdSZHc0K2tRUFBpTVd0LzdnN3BqTUJD?=
 =?utf-8?B?T1hUL256ZkNNWFh6N0lqN0liRXc0elpLOEhaOTduMmlXRVdZSXFWZVdXcERU?=
 =?utf-8?B?TU9wNDBDQlZRRHYyN0VkRGdROHd0emVrdXJPU0J4OFMvd2ptQWovN3VycWxk?=
 =?utf-8?B?NlhtTFVlTXhWNzRaV1JlK1cvelNRQ1hEY2V6M2RYQTROc0Y2bDFtdGZQbURs?=
 =?utf-8?B?WE05UnlFWTFuaU0raDNhZmFrU0p1WU5vYVpQU1Evd25oVkRzbWVJOVErRExG?=
 =?utf-8?B?aVk2Y29NU0ZxYkRoSWZ6Z1M4SHJiTWFsN0JjdUhqbi9Wc2JoVkRPOVloNGZB?=
 =?utf-8?B?aldoWjJZTXlWWTQxVUlwRmdtYW9xcExwdXE2eGFQVFVFZndDbTEzeFp0NlZJ?=
 =?utf-8?Q?h4Cw4KjJyIUkiUBUajf4STzrGoZKc8tLDrN7g=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB6744.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YlZqU3daY2Vvall2aTZQMjBkYjJsY0dQRy90WnRWVk9vNG5vcFlkeHRxcVp2?=
 =?utf-8?B?SlV6RGIrQUxIT0d0ZklSSVJlZ1RSandZK2M4em9YQU9tcjlHZmQxNVNXbWtn?=
 =?utf-8?B?ZUU4SUczbHBIZ2VRN2lDZWNnSGZqbWN3WVZFZE1veEFMZ2t5UjhFOEJqY1pU?=
 =?utf-8?B?d3pleTROSGFybEdpOEtWaUJNMkswbnBCWjhPWDNPVWw3V1ptSzUwNGY0cGVn?=
 =?utf-8?B?bUVIdHkxa1lxSEZMNndvQ1pSNU01cnNFVnEzbFdkNHRKNFZHc3A4OWZFTzM0?=
 =?utf-8?B?Q2VEOTZ5VGJYclV2S2pFbmI1VzNXT1Z5QWdGeVF4bjNRZWVZQlhLMDRSN0JM?=
 =?utf-8?B?YnB4d1RJQkZjRmlwbzRPdnBFWm1TdDNxZFZFcHdKWTlrRjJuY0FyaEZMVjJN?=
 =?utf-8?B?SE5BTVM2UDcyYXVTUFZqd25EU0gyMnhwWGJuRHErcmhVQkcxc0JtQTY0d09l?=
 =?utf-8?B?R2pxRWZ5bnZKVWdWMVR0eE55L1pxWUIxcmpReHVFRXhSRXNVd3dJL2M5eHph?=
 =?utf-8?B?OG10STJrZHZrOEpGSUdNSkM5OGljbnlkbmRWYjRHR0ZKb1d3ZVg2VzNMckVk?=
 =?utf-8?B?aFpYaUNjWjRYa016dkJhTlJBdS9WTDhoOTRpbU1ObmhqZUxuVExUb0NSdCtW?=
 =?utf-8?B?OTNOc1BlcGNieVlEajlxQ2pYT2JnSGpoeG92dWhtd1E4RXUzcGx6NytNQ0Qy?=
 =?utf-8?B?MWhzdkorbktzUU0wcDZoRGZrbUdHRzBrb0VJb2NaMTdFbWdLdkFxWHNSUzNX?=
 =?utf-8?B?ZFpSTUtGQzFPQkZLTVFxL2lTRjd3cUxuR1hjSDQrdTQ4N3YxSlU2UHEwbHZn?=
 =?utf-8?B?bkpEN25rQ3lReUpocmJIQzlHbzhjVmplNTVsS09YOFVZOW9IWjJXZmd4elB6?=
 =?utf-8?B?Qk94VWNGeVl6bUNSWkxFbEF5WnJ6OW1QTVF1c3hObUZkNUhvRWlNMUF2L0lk?=
 =?utf-8?B?M3RiM3FPS2RzRkJteG91WDVkYmdwMjBvRkd5NmlsdlE4enE4U1I3NjBiZnJK?=
 =?utf-8?B?cGcyODEvMllrREtRbXB2WHRFdVRCdk5QREdtNmRSU3FKTzc1SzJRQ2NNTE1Z?=
 =?utf-8?B?d2JIODNQWGM3OW1zTnlOV3EyMksvMU9pZDZnS0piMExtNm5HcTBJd2VXWmJD?=
 =?utf-8?B?YXNTL1kxRVZLckREUVM3ekNvMXgrVlV0QUtSaXNGL2hGSWFaS2lhcXRGTEpP?=
 =?utf-8?B?WVlwUHNuMnVVRjZlVDRxc3VLTlp5Q2lBQ3JERCtLV0Y4MXlFRzhiN0xFbWto?=
 =?utf-8?B?aDU2L0kwQzFQWG5NcVZKamFWY0hFSzdxU0FWNk55a3Q0Nk9QWEhrZmhPM09k?=
 =?utf-8?B?eFR2M1lZS2lmRXNkZE5FMkFQdUJUN2NDMUVmeC93UjNyd0xqSlRyMG5pN3pj?=
 =?utf-8?B?Vlo5NWtIMnAvUXV1OXBaL2dCeTlIZkNGVkt3U2xTVlJZRmJLZ0t3WjlBQW1u?=
 =?utf-8?B?M0NENmliQnpJV3VEL3ljWUlXTEkyY1c4Q3I1NVBBcCtsWWZkd2o4SWtiajhY?=
 =?utf-8?B?d3NKZEVmNUt2TzJaTEhBZG1pcGhvUWxmeUFKWkJrN2J3a2J0ZnNXeHhSNkdz?=
 =?utf-8?B?ZEpDUmFKYW1CQzlRN1NKanh0MENnV2tMVEtNNWIvWXRXK21WWUFnRWpSdGUv?=
 =?utf-8?B?K3lVMU0rQTI3ekxmbCtCRUl6eERTZjZ0dVVqdGkrckM2d3l6RUhNRUcvb2hZ?=
 =?utf-8?B?dnZGNDd1dTZPdk9XZnNIOUVWK3ZwNHZxWXQ4ZG1tZWVnaExQSHFuaWVDREpl?=
 =?utf-8?B?V3Q0Q3ZIYWkxZ0dHMng2THJvOWdhczFTMGNiS0ZrRlgvQnlIOFlYOHRYRlEr?=
 =?utf-8?B?NVd1M2JPWktTaGN0aENaVEs3dFk5QmxCak9iOS9UZWt0ZjJiaVNQeWZRZWhv?=
 =?utf-8?B?S2ExWDh3bWxCUzhTUDZKSDB2eVV0YUloRkpvWFFjeUFYSHpEeFF1b0J6U2ZR?=
 =?utf-8?B?aXBwbEszVFY2NXI4QVZlVjh2djRQTlFJK013V0JKSzlCTlRZTEhWdjFUdWlL?=
 =?utf-8?B?blV5Vnovc1QxRmh6N3dEVU0vQ0pCd0w0bzdtNHl0Sll1ZVRicWg3VktUOUdh?=
 =?utf-8?B?T1gyUW9kQjhwS09MVjVldCs1Sk82Q1NwSFdjci80UFZYV1gza3FQWit2TVRS?=
 =?utf-8?Q?BjUzhyR7U1mIbrHdIhpPqTtV+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d54053-1d10-4df3-9914-08dcf321e933
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2024 05:16:55.1639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h83iVerjYYP2PRpFrcORT8rtBqAA8d0DMOmqhFk93q4m3639SIH7G6bKOuSs44h0kvBYrEsK9riiZ8koUlTqPAxPXaynRYB4sGLnbAQtex0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8674
X-OriginatorOrg: intel.com

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEJhb2x1IEx1IDxiYW9sdS5s
dUBsaW51eC5pbnRlbC5jb20+DQo+U2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDIzLCAyMDI0IDEy
OjUwIFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIGlvbW11L3Z0LWQ6IEZpeCBjaGVja3Mg
aW4gcGd0YWJsZV93YWxrKCkNCj4NCj5PbiAyMDI0LzEwLzIyIDE3OjUwLCBaaGVuemhvbmcgRHVh
biB3cm90ZToNCj4+IEl0J3Mgbm90IGFjY3VyYXRlIHRvIGR1bXAgc3VwZXIgcGFnZSBhcyBub24t
cHJlc2VudCBwYWdlLA0KPj4gbWVhbndoaWxlIGJpdDcgaW4gZmlyc3QgbGV2ZWwgcGFnZSB0YWJs
ZSBlbnRyeSBpcyBQQVQgYml0LA0KPg0KPkNhbiB5b3UgcGxlYXNlIGV4cGxhaW4gaG93IHRoZSAn
Yml0NyBpbiBmaXJzdCBsZXZlbCBwYWdlIHRhYmxlIGVudHJ5JyBpcw0KPnJlbGV2YW50IHRvIHRo
ZSBjaGFuZ2VzIG1hZGUgaW4gdGhpcyBwYXRjaD8NCg0KV2hlbiBpdGVyYXRlIHRvIGxldmVsIDEs
IGl0IGlzIGxlYWYgcGFnZSB0YWJsZSBlbnRyeSwgYml0IDcgaXMgUEFUIGJpdCBpbnN0ZWFkIG9m
IFBTIGJpdC4NCmRtYV9wdGVfc3VwZXJwYWdlKHB0ZSkgbWF5IHJldHVybiB0cnVlLCB0aGVuICIg
UFRFIG5vdCBwcmVzZW50IGF0IGxldmVsIDEiIG1heQ0KYmUgcHJpbnRlZCBvdXQuDQoNCj4NCj5B
bHNvLCBwbGVhc2UgbWFrZSBmdWxsIHVzZSBvZiB0aGUgbWF4aW11bSBsZW5ndGggb2YgdGhlIGNv
bW1pdCBtZXNzYWdlDQo+bGluZS4NCg0KU3VyZS4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0KPg0K
Pj4gYWxzbyBwb2ludGVyIHB0ZSBpcyBuZXZlciBOVUxMIGluIHBndGFibGVfd2FsaygpIGNvbnRl
eHQuDQo+Pg0KPj4gRml4ZXM6IDkxNGZmNzcxOWU4YSAoImlvbW11L3Z0LWQ6IER1bXAgRE1BUiB0
cmFuc2xhdGlvbiBzdHJ1Y3R1cmUgd2hlbg0KPkRNQSBmYXVsdCBvY2N1cnMiKQ0KPj4gU2lnbmVk
LW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0t
LQ0KPj4gICBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgfCA0ICsrLS0NCj4+ICAgMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9p
b21tdS5jDQo+PiBpbmRleCA4Mjg4YjBlZTdhNjEuLmZlYzVjYzExNDdmMyAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPj4gKysrIGIvZHJpdmVycy9pb21tdS9p
bnRlbC9pb21tdS5jDQo+PiBAQCAtNzA3LDE0ICs3MDcsMTQgQEAgc3RhdGljIHZvaWQgcGd0YWJs
ZV93YWxrKHN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUsDQo+dW5zaWduZWQgbG9uZyBwZm4sDQo+
PiAgIAl3aGlsZSAoMSkgew0KPj4gICAJCW9mZnNldCA9IHBmbl9sZXZlbF9vZmZzZXQocGZuLCBs
ZXZlbCk7DQo+PiAgIAkJcHRlID0gJnBhcmVudFtvZmZzZXRdOw0KPj4gLQkJaWYgKCFwdGUgfHwg
KGRtYV9wdGVfc3VwZXJwYWdlKHB0ZSkgfHwgIWRtYV9wdGVfcHJlc2VudChwdGUpKSkgew0KPj4g
KwkJaWYgKCFkbWFfcHRlX3ByZXNlbnQocHRlKSkgew0KPj4gICAJCQlwcl9pbmZvKCJQVEUgbm90
IHByZXNlbnQgYXQgbGV2ZWwgJWRcbiIsIGxldmVsKTsNCj4+ICAgCQkJYnJlYWs7DQo+PiAgIAkJ
fQ0KPj4NCj4+ICAgCQlwcl9pbmZvKCJwdGUgbGV2ZWw6ICVkLCBwdGUgdmFsdWU6IDB4JTAxNmxs
eFxuIiwgbGV2ZWwsIHB0ZS0+dmFsKTsNCj4+DQo+PiAtCQlpZiAobGV2ZWwgPT0gMSkNCj4+ICsJ
CWlmIChsZXZlbCA9PSAxIHx8IGRtYV9wdGVfc3VwZXJwYWdlKHB0ZSkpDQo+PiAgIAkJCWJyZWFr
Ow0KPj4NCj4+ICAgCQlwYXJlbnQgPSBwaHlzX3RvX3ZpcnQoZG1hX3B0ZV9hZGRyKHB0ZSkpOw0K
Pg0KPlRoYW5rcywNCj5iYW9sdQ0K
