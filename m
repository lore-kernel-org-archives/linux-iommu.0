Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA3B2BE7DB
	for <iommu@lists.linux.dev>; Mon,  9 Feb 2026 05:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770614272; cv=fail; b=N5JxiVdaT7iWhrAtrSor/NaPpspLYv2mcDb5yfoFBlosG/21CWojrYgN2TzK25/At0aXsouwfpJVZzhtJVlnQAilC+LY7b5Ubkohnk/92qRrPrCCSt30p+2G2kjsWxbCLIGpEVhSet9SjgkSnTestkVsEjbgfKuWrmQPaqxzBRU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770614272; c=relaxed/simple;
	bh=kL67FEBcggxIHU1AYXIsORF9o0APyf/Ospy8HRKetJA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9rYuArzPWr6SIv0YTLV0eGLCC+QesOlEtPIFKPyG2iwkZMf8G1DPfkISjCHxOahQbLK331xklRl0mnPtwwwJzw1av53Ce5Qr6MfrC7EQAWtVbAd7tZJMdd5yJlfYFk9ocSIAKWzf/9tNxWK6V5H6WLlPa7jQA5LvN7cLp4OPYg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RRDF2hV3; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RRDF2hV3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770614272; x=1802150272;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kL67FEBcggxIHU1AYXIsORF9o0APyf/Ospy8HRKetJA=;
  b=RRDF2hV3mIr5MV/EwCeLlcqvjn6huq471B7gK1IYOxkTOd8rM+CeA3TP
   X+MeYV+1gWyq5ga16NsoMno2rT6NESTJTxGLjwZxJQLBOzFPVt/Dawd+L
   4bkigCEmTupP7GCDsiMswOujQin5Bu5YSuTT40YPj+wNwMI4dHPgYTm4Y
   mnH9otCLPQz20voqJH/GULwDKXCTTLTKIZvIPqDDRYcb5bEd/DHt124/l
   n19CmD4OvwhB9Y5672Be+apF0HNAcrIsvce4sz/rPqYWrtzoVQXtM91iY
   FDJ+flYMBSnhstOHY/BeMnY++q1VMXRDRczbz+Mm45yGSAKOGfoWuEgEg
   w==;
X-CSE-ConnectionGUID: Vb+Zk1PxRj6+e9o3tVdC0A==
X-CSE-MsgGUID: djYWae1JSimpwo0DMm4vUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="82361014"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="82361014"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 21:17:51 -0800
X-CSE-ConnectionGUID: +uxCtif0RJ2CiXIp8XUkCA==
X-CSE-MsgGUID: 6DUomBAdRFSxfNHQ/mZeCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="210561729"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 21:17:51 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 21:17:50 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Sun, 8 Feb 2026 21:17:50 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.46)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Sun, 8 Feb 2026 21:17:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kZdSkQCTFobM21hhnCdcHaqcZXEeRTU2VCnDJF9ph+4kgJcRjBJcV/qrlJpveIIcu0nkKPbhZzU3JYbw0reX4EueyuwbBri3r4/jvqxTVYQdegaDTNmrku8ZA/NmHa6sEfHPM21lxyJtlxhplJd2ORzF/+wR4ZUVJA9RNXqlqZ4/DA2UH99ZQFTRHaZ46Opy0P+L5pcflMBZFijI3A8DFtPAT7raGegPSXNWi8aoMjw14oecmhypd+CfR4gIvdlMDlFEdeNpa6Vg/Jn3CXGmMvq0tgPSK4fPNEirwNWjY0lTr0ioUeaOR/VtZ53yK9A06OyiAdJjHZ4PfIiD5dwQcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kL67FEBcggxIHU1AYXIsORF9o0APyf/Ospy8HRKetJA=;
 b=TQ4U5Kvh6OrrgXPUHH9JS+NA3G9aZMSol0mOL6MGnFrlCXpkyr+/jyW+vS/oiKSsjTHzdMoRNCMl2BR66iiTRVmA+UqTbISiPclhGMWXZvDyyjKs4V26CcFbeGBtVk1pr2HzZ0XrEBXtvbvD/qxHwYsTExvhzWZ9DIN9KwYZmnVmcjUJQ+6IxtYc1YeWE9R10iQMC/CWUrz66INDW8/z66ArQjcCvxVpYVsQfGDxUifeOw9MKqYZIuBDpZdjU9MDDDJHZHA2p9DPjQ7aCrNtNBhYc9V7cZ9RpyPIeiLKNVg1p18phwHu7pNjkzdjfpu8cwTmFQOGdQer2fWeXQXTYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB4830.namprd11.prod.outlook.com (2603:10b6:a03:2d7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.18; Mon, 9 Feb
 2026 05:17:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9587.017; Mon, 9 Feb 2026
 05:17:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>, "Baolu
 Lu" <baolu.lu@linux.intel.com>, "dwmw2@infradead.org" <dwmw2@infradead.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: xunlei <xlpang@linux.alibaba.com>
Subject: RE: [PATCH] iommu/vt-d: fix intel iommu iotlb sync hardlockup & retry
Thread-Topic: [PATCH] iommu/vt-d: fix intel iommu iotlb sync hardlockup &
 retry
Thread-Index: AQHck+kHmJunq9bMDkqZ663uMXRimbVySnSAgAGh/YCABfFKoA==
Date: Mon, 9 Feb 2026 05:17:48 +0000
Message-ID: <BN9PR11MB5276CF1CB3BB86987AAFBCAC8C65A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260202020920.3557883-1-guanghuifeng@linux.alibaba.com>
 <086971f2-cec7-414d-8cc9-01836ef7259a@linux.intel.com>
 <ebd62398-342f-4b28-8c7e-ce0ec8dd8889@linux.alibaba.com>
In-Reply-To: <ebd62398-342f-4b28-8c7e-ce0ec8dd8889@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB4830:EE_
x-ms-office365-filtering-correlation-id: 33f0cae4-0e0f-4258-1c22-08de679a90b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?d1RhVHplZzdGd1NXTm1EUUxXNEpoTEw0Rk01TzVVUVJoVGY5bzhtRnB4ekor?=
 =?utf-8?B?MmhlbDl3TjZuSXQ1OWlNdFZaREFBWG9hWFRiM3E1clg5dXlKZ1dqVTVoTE1X?=
 =?utf-8?B?MWdmUmZPMHA3TGIrWXBNcG5LU3EvR0N1dmJLektWbmd6c3BIRUF1U3FqTXBy?=
 =?utf-8?B?OVNKdVl4Unk5ZzNiUFNKaWF4ZVJYa3FTQnZYcmlXRm5UVVNvY29FaVY0allo?=
 =?utf-8?B?bjNJaSt1UHE0NzYvSHQ2dXlrQXFGeFo1Y3VOQUFQclZrTzBoK2JvVmRBeDdI?=
 =?utf-8?B?RlFib2p2dnM3NTVqcW5NZy9QUDl4YUp0V0ZVVUNjOTUwODgxcEVPZEFXSGZT?=
 =?utf-8?B?aDBsZ1pSZ1V3RHk2UlBiYlpRTVRVUDI4djR6QUVvMVF1b3ZQZkp6L3VrNXBl?=
 =?utf-8?B?NWU2Mm0wTG1zWk9NSFhJRGJBc0RVNmJqMUtTb2RISFJuU25vQ0lhWWZEaUZz?=
 =?utf-8?B?dmplY2NYcFNRdERjSnJ3MUdkbEwyS2tYYklEYWgxUUtIeXplYmZUM1dHdnZ0?=
 =?utf-8?B?V0h0cGxVYmNiSDVtSnBGZ3RnaGRuYUZuRWZkOWpTMTBOdHdIYmpHb1pLNGxj?=
 =?utf-8?B?Z0hReDBuRWdKM240UHVweTVhejNITFdEeVNZbExQa0JKeU5DREtlUGw2L1R1?=
 =?utf-8?B?SzZQR0RleFlrOE9obEU2cXZNdXNwUmUwOXhJa3VibjNldjBrS284cnYvdWJR?=
 =?utf-8?B?VEhhMitidmVFSVVJdkJRUFZ5SlFXVWFvOUhPajQ3cklHbnBxRDlmM1lLR1lo?=
 =?utf-8?B?a2JtOGNzK3dsMkx6dy9nUVRIZXJOWWM1QWhESUsyT2NYNGk0ZHlQSlRadTZV?=
 =?utf-8?B?WjFkdVY0b0VtYVZIRUNGbXBvSFk2OWhCajBWK1paaU1admUxbWhZRmlNK2gx?=
 =?utf-8?B?YXk5Zkh0Rzd6Q1NYT21uZjFmSk9zQ0YyT3dUcElTbTRCQ3FHdXB2Y2N2aG50?=
 =?utf-8?B?bk1ybTNwcVFrcDJ2RnlQZm0reVFmaWE5MkNiOVI0V3BMZEcvU05EanpoQ2hj?=
 =?utf-8?B?UHpneWdEUlJaWlcxRnRvdXJFZm8yMDJiUnVHajExM1pFNGV5TTVhYzNCbTRM?=
 =?utf-8?B?cGpVKytiQXNCbFRjejhlU0ZWM210bjBWQUJPbXdBRkE4WjhHZSsxMlFsbk5k?=
 =?utf-8?B?Wk9aWWRXc21DT3UrOWdvSVQ2UEYxdGNZcTNlVnNQK01ZWEd5Z1BwRGdqZCtH?=
 =?utf-8?B?VUZEK1Q0OTVBcXI4ZXIrMC8yRGdiSGo2RGVWYUF4M2JNdThlNUZadnNmS0tU?=
 =?utf-8?B?QVhnK2VQVzFWK2lheGxEYlEzL1JoVXgvYk9Oa25GcUN1dGFLOUJZMDQwcDFs?=
 =?utf-8?B?Z3c4eXN0VDhvOHNsaWtWWWZpU3FCbXRMT2JpWkFqeWxRUkU3UDhQb09mR29J?=
 =?utf-8?B?MkhySFB6a1daM3krbkx3alFhMk42d041d3lwQWNoSVVZNEdoRFBXakM2Rk5i?=
 =?utf-8?B?aW14Vm5BMUFaRXFWb0l4cDlVMHc5eFM0bzFTdmJZdTFoMU54M0dhTmYvZ1FC?=
 =?utf-8?B?SVBoWWJUTDV2QmJ4ckJhOEhLL3UwL3dwejNYVzl3QXJoeE9ESUQxdFVZQ1dL?=
 =?utf-8?B?SGUvUGJpY0Y4Mnc3VUM4L0gvdm5TNS9JTVYveldITHZsS3Zwdm0zeG1lVGpo?=
 =?utf-8?B?STltRU9hdWlUdjJrYytoMUszUW52bjgwODh3NytPTG4wVlN6MU1ld0tzVVdD?=
 =?utf-8?B?VGFsNGVjWnlSTUFGdDBZSmNSQ256QW42M2lJbGR4MVJwb0lobEM1NHFKSTBE?=
 =?utf-8?B?QkJoVHpzUENkU2RoRUhBcmh3dXVFM0EwSGhXcXl2eGpyN1Y3eUdERXBxUWRk?=
 =?utf-8?B?VXFUaGt2VjA1Qmp6elhLV1kvTWVNeWdyOGZDaXpZWkJWNnZCcUgyaGhOdjlV?=
 =?utf-8?B?TDBCTmYyRVVJa0FQT29jbTUzR21XeU5ua1lvemRuL3J0WUo1b2YxUUszTFVm?=
 =?utf-8?B?VVJwYU95YkJuRHBHWmxNU2x0QXhIQUo4ckV6OUJHZjZncXBkcURkSFZMM21F?=
 =?utf-8?B?MU9GTktFQnFvWXBPbmdzSUVRN3V6TUdyTFZDaWI2TWRSaCtPQlBHNi9RTUNz?=
 =?utf-8?B?UHduTGhvdVVzbFdOaStzdDlka1lGSFZvWTVNK3RRRi9wdkx1YUc0K1lQT3l1?=
 =?utf-8?B?bG5POUZ0WnZwbFh6ZFZHMCsxUmRuWkRLbE10TVRtR2VWOThCcGwzeVl3YlZh?=
 =?utf-8?Q?EiJStvAbyJPGGGnyQ8JIWTI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bHpSYXZ6bjA1MWtGYXc5ZFZleHpsRGR3eWo4UnRyZnF4Y09UQTdCaFA5SzVY?=
 =?utf-8?B?aWhxYjRCaEl6Vk5KRXNnT01lSjFkM2xyblF4enVtbENHZjNoYjRndDhjME1U?=
 =?utf-8?B?WjhQZFJ2MzNvV2VTWkYxWVU0djZOclFtNVV5dVFSTjVUOU50QU5FdmY3dDdM?=
 =?utf-8?B?VktuRTZxWWRzbmUrVmxtZjloazlqKzNqTS9xakpPZFJmdXlqUDhJR01ONVJX?=
 =?utf-8?B?aTNtMU1ZckVkOWVSRU1wRElvNlRjL245aGxhVXRNUGZ1K1B3MUsxT0kxbFVJ?=
 =?utf-8?B?YjdGVURkaDNKSW5vVXVKeEFxQ0EyOU9Zemt4VHY2eklpN3BhOXlzU1RNSzdD?=
 =?utf-8?B?TzJNZ29YZEdod3JzUmRabURaRHcwTUxIbFMyaU9jUXd4Uzhnc2RUZVpwWHRR?=
 =?utf-8?B?Ukx5ZkhqeXZVcm5ycDFUQjFKc2dQMHZ0eDRqalA0RHA4UlJJaGdVY05NRVk2?=
 =?utf-8?B?b1BNYjgyVFRPaTlGS2R2ditDaytJcnY1Tk1UVUV0WWxCbitDaWdyVUw5am5S?=
 =?utf-8?B?VTQ0QXhhRXU0VW1YVTlnMFRkQUk2Z0xvZGRUQ2VJR0RjZDkraDJYVFBCZlVz?=
 =?utf-8?B?a2FEOW5ING5HczFvYklnc250MWtidHkveVdiTmhxSi9HZG4vTG5raXJKZFJz?=
 =?utf-8?B?WUcvNTk5UEpUSmN5R1Fjb1IvODgrMnM1QzQwYW1LTTYyWWNORWI2VHYzYmhm?=
 =?utf-8?B?cFo2Y0I4ZjVJNGFqN3NPRUJwNld3YWhCL1hqTVhQRzg1TjFoa3hEdnQ4U0Fz?=
 =?utf-8?B?VTZHSlpiU2JLdUNHbHdINFlOZlBrWmU4eFBqMU5jWi9qKy9VSEhRV09tdjNh?=
 =?utf-8?B?cytFeGp5Vml5c2tIaHAyVVlIdXpCUms4TDFuYytRam5iSVZMWnBxOVUyT0sz?=
 =?utf-8?B?Y3ZBRWVUd0hMeFhJTEJjZTdlYnFkbUtjMzgvVE5IVGY5NDRmbkM1dVpvWGFW?=
 =?utf-8?B?YTg5Nk9tWWI4ajh1eGs5Qk9PRXVLYnlNckIvdWdTcytDcGJkL0tLYWgyb0tM?=
 =?utf-8?B?dlhrcXZSRkw1Vk5KSEZmU0d2Ry9VODN5ZjhZNGNrNkZOU2pvQ0VtWWR3NVE1?=
 =?utf-8?B?akV6azgxM3p3YXFEQ20zM1RKYk90ZTV6OFgzWG00am5zU0RYQlZabFAvaGNj?=
 =?utf-8?B?SzlJZUVBMVVvbytobU9IT1hISnBNVjVBMWptcUxsZ0tKZE9xa3ZWV0ZrbnB3?=
 =?utf-8?B?VzN2eUI0blNwMVBJRE03ODVBVGxFWkRZNy9RYXVCTE5pckdvZFdpTkkzQ25m?=
 =?utf-8?B?TVhJc0Jabkp6eWhkUWl4czhXR0FOOFhHVkwrQlJSNkxCNmpyVkpHQmlmV2Ux?=
 =?utf-8?B?OFB3YWV2TExDM2pJc3JacllTdHNRR3I4RmxNcHpaUWxPRWk0MXRPa0lZMTdo?=
 =?utf-8?B?RmtMWFRyVms5WXYrdGF5WTZtWC9ocm80UWI2QkZIeGtuWlNCU2l4bnlORmtP?=
 =?utf-8?B?eit0SjYxOC8vdFhoM0lqR2ZLWU80eHRPaVVnTkkzOGZoS05ERXBsRjJDMFFJ?=
 =?utf-8?B?Q25udjVGVXA3bTd3YVpmcU9WQ21nQnVxTkFpL1djYXZRUnh0c3ZkN3dZZmVn?=
 =?utf-8?B?ektSTEU2cVE1V3V0SnNSOHRSQzg5QkVWRlVyd0pSdHFKSFpkTnZVMllETmRQ?=
 =?utf-8?B?MnMyeXFTOFZNTEFnaW9HRDVNNkpJa2NITjhuK2RYTnZMZTk0dnhIMTZwZkRM?=
 =?utf-8?B?Q3l0cWhzRXNWenlMSTNaNlRRWFJLaWFQaXU1aitLNjlRNUN2ZVFvekdTZ1I3?=
 =?utf-8?B?VXFiWjQ1QkpEeU9YWjBoRVFuSktGTmRDVmUyN0F2Y0dpY2tUZm9Dc25yMDlv?=
 =?utf-8?B?MnNZUlBqMVdObmxQclFGRmtUS1ZlM3ZKZEJSMkI3VWg4dlIzUjM4dVVhTXFm?=
 =?utf-8?B?SWV5YUI0SkFuc2ZoclRFRG1PWlgwNTladmQ3cWNVdzhEUkkxYUxzZXFOcWpn?=
 =?utf-8?B?T3QxK1pxZ2I5UDZGRDVzNGNCMDlIL1ZFMlJPQjEyMmh2cUlDRGxESmZGZGRa?=
 =?utf-8?B?b29jWnh3WVMzaDZxTis1Qk5OV0JxYVlaWVR1Y294YUF4MGEwb05yTkFOd0Jh?=
 =?utf-8?B?Z3J4YWsyUHloYWViMm1ZMFJwSlE3VGZPazNJbWlkWWRCanIrazVHQ2JIN1NT?=
 =?utf-8?B?cXordGJNRVVMdnJNSlJPWDdQQWh2cm92OGtLVDROM1ZXZkpTRnIzL1AwcFVY?=
 =?utf-8?B?Q3k2TlE3MDlidzRHTEVLeHVUUVpoV0RweDJueVRkWklnRytkYmVCaXA0d1dz?=
 =?utf-8?B?cU5wb0hpSWVQYUxid3M2QkdSWjdwU01kUmt6c2E3OVRnZ2FJR1hwelJTeTQv?=
 =?utf-8?B?a3pkaW80SFd0Vmh3cUtTU2xTUVdydHlqMXhhNjhYYUR6dC9RSE9IQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33f0cae4-0e0f-4258-1c22-08de679a90b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2026 05:17:48.2915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ubSvtjoPbwwXlf0vGZxyyTswgeoX+olTsS8mw5TVyLEiU70MADIaUCqgR8GsiR0js42SMK1Y+r0cRiKTao+ugg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4830
X-OriginatorOrg: intel.com

PiBGcm9tOiBndWFuZ2h1aWZlbmdAbGludXguYWxpYmFiYS5jb20gPGd1YW5naHVpZmVuZ0BsaW51
eC5hbGliYWJhLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEZlYnJ1YXJ5IDUsIDIwMjYgNjoyOCBQ
TQ0KPiANCj4gVGhlcmUgYXJlIGEgZmV3IHBvaW50cyB0aGF0IG5lZWQgY2xhcmlmaWNhdGlvbjoN
Cj4gVGhlIGRlc2NyaXB0b3JzIGJldHdlZW4gaGVhZCBhbmQgdGFpbCBhcmUgcmVxdWVzdHMgdGhh
dCBoYXZlIG5vdCBiZWVuDQo+IGZldGNoZWQgYW5kIGV4ZWN1dGVkLg0KPiANCj4gDQo+IFJlZ2Fy
ZGluZyB0aGUgcmVxdWVzdHMgYmVmb3JlIHRoZSBoZWFkOg0KPiBNZXRob2QgMTogRG9lcyB0aGUg
SU9NTVUgdXBkYXRlIHRoZSBoZWFkIGFkZHJlc3MgcmVnaXN0ZXIgaW1tZWRpYXRlbHkNCj4gYWZ0
ZXIgZmV0Y2hpbmcgdGhlIGRlc2NyaXB0b3I/DQo+IE1ldGhvZCAyOiBPciBkb2VzIHRoZSBJT01N
VSB1cGRhdGUgdGhlIGhlYWQgcmVnaXN0ZXIgb25seSBhZnRlciBmZXRjaGluZw0KPiBhbmQgZXhl
Y3V0aW5nIHRoZSByZXF1ZXN0Pw0KPiANCj4gVGhlIGN1cnJlbnQgSW50ZWwgSU9NTVUgVlQtZCBz
cGVjaWZpY2F0aW9uIGRvZXMgbm90IGRlc2NyaWJlIHRoaXMNCj4gYmVoYXZpb3IgaW4gZGV0YWls
Lg0KPiBEb2VzIHRoZSBJT01NVSBjdXJyZW50bHkgdXNlIE1ldGhvZCAxPw0KPiANCg0KSXQncyBj
bGVhcmx5IGRvY3VtZW50ZWQgaW4gdGhlIFZULWQgc3BlYywgNi41LjIgUXVldWVkIEludmFsaWRh
dGlvbg0KSW50ZXJmYWNlOg0KDQoiDQpJbnZhbGlkYXRpb24gUXVldWUgSGVhZCBSZWdpc3Rlcjog
VGhpcyByZWdpc3RlciBwb2ludHMgdG8gdGhlIGludmFsaWRhdGlvbg0KZGVzY3JpcHRvciBpbiB0
aGUgSVEgdGhhdCBoYXJkd2FyZSB3aWxsIHByb2Nlc3MgbmV4dC4gVGhlIEludmFsaWRhdGlvbg0K
UXVldWUgSGVhZCByZWdpc3RlciBpcyBpbmNyZW1lbnRlZCBieSBoYXJkd2FyZSBhZnRlciBmZXRj
aGluZyBhIHZhbGlkDQpkZXNjcmlwdG9yIGZyb20gdGhlIElRLg0KIg0KDQoiDQpIYXJkd2FyZSBp
bXBsZW1lbnRhdGlvbnMgbWF5IGZldGNoIG9uZSBvciBtb3JlIGRlc2NyaXB0b3JzIHRvZ2V0aGVy
Lg0KSG93ZXZlciwgaGFyZHdhcmUgbXVzdCBpbmNyZW1lbnQgdGhlIEludmFsaWRhdGlvbiBRdWV1
ZSBIZWFkIFJlZ2lzdGVyDQpvbmx5IGFmdGVyIHZlcmlmeWluZyB0aGUgZmV0Y2hlZCBkZXNjcmlw
dG9yIHRvIGJlIHZhbGlkLg0KIg0KDQp0aGUgd2FpdCBkZXNjcmlwdG9yIGlzIGZvciBzeW5jaHJv
bml6aW5nIHdpdGggaGFyZHdhcmUgY29tcGxldGlvbi4NCg==
