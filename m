Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A26725569
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 05:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740547058; cv=fail; b=cmAw+hqtdXOfd88iizBYIFQcUWPbUCAMMrGXONwCpUnwIx2j0Hk8TaX9KGPWPqYHO2XmXOmRgR6GnAp8gsVWnL77V5g0ajhfAvRBEoFMdw/on37jpQiz7Ujr/Jh4EMmFTkMx7bD+CuYjkjjrERQWnuH8SHUi1WBdhAcuaU/+YDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740547058; c=relaxed/simple;
	bh=N9aauW39sp0nahKpht99+/4km1dPZoRqrxJeAe5PZ8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NY6GSE9QxLo1DUWJMFrwtHNnw0XFGYChu5DUi2Z7n2eQY9oh3ovW5hSvMSASjeTyHlWtVEzJat2swF9A+HKpHss33OnkGG6XNm+GzE4jGH7ZvIukFTJyDVKuhes8LlhYc0g1KyjISW7qIO7Oo/QdrH7fwMGSQp1vgMOzfpqoSP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BlF8Lx9j; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BlF8Lx9j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740547056; x=1772083056;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=N9aauW39sp0nahKpht99+/4km1dPZoRqrxJeAe5PZ8c=;
  b=BlF8Lx9jgMm+jJt7ipwKSgsxevtosLwEjaChP3Rz9au+J1Qo2jxpUXkv
   dSeICtvZ2w+jiTiFacftT3s/uyi7CZTIVe+eqvuGWa4ekHXulsvmQN1VR
   2Vrz1hu4XlCaWSSSQR7JEQAqqY8sZJz+106l6kelZ5/mxIKzXwEZSjGrZ
   tc+3HXUpIWG4sFf8V4fu0wXll1zDqXnsIcvy7vZwRqu1hmmfoHCR4RQGK
   i0AzvBeW1UoYrL5cPyb5yVHdmEPDe3brt2C2w9NiOsfy+1LlYmGp4HRmY
   FzZxJO7UtejR2jZq0s8rbYsgWcBQScxhjXwPvJsY5qo4JO2eFWcN63Ply
   w==;
X-CSE-ConnectionGUID: ixauSs3YTAmiMG4FJC2WWg==
X-CSE-MsgGUID: WQx7S0GLR8G9a9ClkbNSFw==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41398263"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41398263"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:17:35 -0800
X-CSE-ConnectionGUID: 6ITDL+YOTzOxEitgWTwgbw==
X-CSE-MsgGUID: p51jWlcjR36VXLlJR2DCjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="116389029"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:17:35 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 25 Feb 2025 21:17:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 21:17:34 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 21:17:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx95ENbRk212QtK3jwC+eqL8HqFzcmFwQw9YCecJhej0hjyAO/FhGLbIKy8wY9lYL/dqQoSIOvvL2ulv03KJCV1rmRcb8BlhovIzzHNUlH0bM6p5KocEsNWqvvQbAgZ+0Gug2hj2DTA2RZ0IhvsAZqfilG8o1Hmf3lJS0LKOjyrzl2qlWPK4dWjS4bu7RfWMOY2FRShL+vTEvTq/7JnRe3HPyuYZQsB447fQQV91ZPd7/S1e629pjTgTGRvMkk50CuZMeyeSUUcY7LxL2SHvCgrSGqTcX7vpwNXzgDJe34y92O97leDY630tcLiosjgtN+8zud4sbvLChbFiLGmIWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9aauW39sp0nahKpht99+/4km1dPZoRqrxJeAe5PZ8c=;
 b=nWWwNHctUz52TSWsFTONxF58wFgnqk209C9umNe558J3vggt8Kf/o69/Q6PqqB6GQUKLoNn+M3ocn7VPL3J6R0d4MIvpGgxemllaha2+HG80FN+Rq1kvrfclL/YJlnFVWN7tAUs9E07vCrYtApR/KgU5A17Ab9Cs204JT+SpjO8gAOen9W9MG4jQ3pAXR8uq8D9FWna+citG11ryombwMjas8aSOsc+pmL+ITc+KgmrL+gzUcPkreBN9OcF0cz3w2OZcPCSSbjSc77A9OAuYJWDNEtZwdr4PO3Hjl77KxTupREmWcX3JxgYdU5GW6rl5zRM+P1wGc7PbcN77DneyRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7993.namprd11.prod.outlook.com (2603:10b6:806:2e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Wed, 26 Feb
 2025 05:17:27 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 05:17:27 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 06/12] iommu/vt-d: Cleanup
 intel_context_flush_present()
Thread-Topic: [PATCH v2 06/12] iommu/vt-d: Cleanup
 intel_context_flush_present()
Thread-Index: AQHbhntMC6a5A/3El0281ujJDWut9LNXpELAgAFT5YCAABZK4A==
Date: Wed, 26 Feb 2025 05:17:27 +0000
Message-ID: <BN9PR11MB527652E646F7437CA7E4AFE58CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250224051627.2956304-1-baolu.lu@linux.intel.com>
 <20250224051627.2956304-7-baolu.lu@linux.intel.com>
 <BN9PR11MB52763EE4B5976621A7797DBD8CC32@BN9PR11MB5276.namprd11.prod.outlook.com>
 <421bb6af-4b7b-4987-8db2-037a39d43078@linux.intel.com>
In-Reply-To: <421bb6af-4b7b-4987-8db2-037a39d43078@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7993:EE_
x-ms-office365-filtering-correlation-id: 06e13819-96e1-4a46-8312-08dd5624dc4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?OFdqQ2pGSGFZZjNKSVgzSEJoTWY0em9SVkFVUFlidzdyWG13RHJBRnhZaDRm?=
 =?utf-8?B?ek9FT0pKTVZrS2xsTVBtQWZUQzZRNUZSVmRmbitWT1E5QkRyV3hFblVidUx4?=
 =?utf-8?B?TzE5Qis0czJsZThsbnUxNlJBc3JTSWo3NnhqN1piR00zR016a3V2bzcvRmsz?=
 =?utf-8?B?RmRDS1laWGRIbS9JckhtT0cxL1FpRzRROGU4Wk9ZZ3llQmRkRktoU21uUzBB?=
 =?utf-8?B?YnRmcDZZRm91dW5paWlqVk9sdzY0blBpdGxqTWxsOWZyR3J2V1R2L0ZMMDhY?=
 =?utf-8?B?TCtkL0lKZzZld0ZDdWF6dnJBRHdqdjRvQzVKbnZEdnUzMUJ1WUhmMmdVdGJa?=
 =?utf-8?B?ZUNxVGljTHR1QkxncVlha1dIWC9teTZDcmZkbWtpL2FlWnB0STlaQTU5K3Vi?=
 =?utf-8?B?a3JuUDU4azNnREZFZU5ickUybUxhNWFSNVFoblBKZHFQRWVyb25hU3U5ZHBk?=
 =?utf-8?B?bU9wWm9VSFg3eDhkMEh4VUpHdklrbEtVaVZCYVNhK0wwU3JYT0dSUWh1Yld0?=
 =?utf-8?B?WWJzVFJYbWFvaXRlSnpRWFR6K1FEMGxSQ1dTSkpLUVpvY2NycHJ1STVmaUt3?=
 =?utf-8?B?VVdoUTFwNjdsQnZqZk0wcFVTUDcxUC8rOEtWcWZZa3ZQbWMyVlpWRTRHM2VQ?=
 =?utf-8?B?czB0Tnp2NS93VEhCMU93dW5Yc2RNSXozcm1jaXU5RjltOHErZU5XWjFZQjZj?=
 =?utf-8?B?SjRPcVpmdjgrM0pXTGZzMUxoelRhS1JCQitqZzhZVDJ4aTFuTnFDTEk2dkFn?=
 =?utf-8?B?a1FVY1JEVDMxbFlmNjBSSXVXN04zaTVTZEV5V3E4T2diNnBoOWUxdmJvMnor?=
 =?utf-8?B?V1JTVFJqb1krV04yVjBZdGlFYk9TK1pLTEV1bzNJQTJhWUY2WGFOSGorMm55?=
 =?utf-8?B?cVIySHRLVkxLeE9IZERFMkQ0TnFISW03Q3libUJFZnd0Q3pSM2x2ZGZQYWhq?=
 =?utf-8?B?NzJPenJjMmFpZHdmWHIrdGszdHN1Mms2aUZPaGpGZmMvRGFSNDZnOUMreXI0?=
 =?utf-8?B?SHV0eW9UR3NlV1h3RzkrM25ucmZaMkFRWTJJb2ZzNTg3c0hjNnRLaFJ2MXhk?=
 =?utf-8?B?ZmpGcmRaZVRDdmdwUzd5b2NiQVNPOE1oeXJRem5YV0hUMDk4eTdRMGlpWHVX?=
 =?utf-8?B?SGxZb2t5TTVtb3A5aHB6RWo4bXY0Ni92MnZxUThQK0ozK25TSTQvZGZSUmpW?=
 =?utf-8?B?T1B5cldTK2E4eTMzb0hxZkhEZE5oN1o1QmpPTnVLQUludEI2bXNOVW9BN1dN?=
 =?utf-8?B?SjlPV210alpXRjBXMVB3bDBOdGVlSjJKb2tTSVN1YmdMTW1sR09DWU5DYTBK?=
 =?utf-8?B?TEFKNmFtZ0RkMnlzOTEwaVFsZHFyQU1ORFJtcHNlVDMyUjRJOGV6Y0t4aXZ4?=
 =?utf-8?B?UjlrY2tkSWN6ZTVpaGY5bzJtY1NPVXZQRk9TOVFrdHpUUXJNK3NONkFBb1Bm?=
 =?utf-8?B?QkgrcmxHZlZncUpqMGdFZjdva0ZnYmorUTNXOTMweVhQMlJhS3NsbEZZSHcv?=
 =?utf-8?B?OWMrWDRvOXYrc2daZXloc3FMMmFhMVhnTVByK3ZuclEvSGg1eC91RStxN3RK?=
 =?utf-8?B?VXdFaldHUFQ0VHNOb3BqOU5XOHlPUlhmUEtTa0xPdUVIeTZBa3NhUitGcGR1?=
 =?utf-8?B?VE5QdFdXbEJrSlpQbjJoNjdYSzZzNmtHMjlUOUxya2Ixa3gwT3dSLytRZXdh?=
 =?utf-8?B?a1lWY2FYcWcyeWFtcUQ1SkRnVjltZDAybkU5S2E3RFl1MDRuY3RHSEJ6U0JZ?=
 =?utf-8?B?aDdCckJHNEZWTncwZCswMGd6OEZhbWgxMnRYb2Z4YXdNRUxQR3M5VXNyQSsv?=
 =?utf-8?B?Z3VmYUxWNkpNM2dyTkVNbEwvUmdjVmVmS2ZiV0VnN1REQ2dWc1QrYjZTOWcz?=
 =?utf-8?B?Sm1pT2svZWxxUVBsY1V1MXFoZnhUdlh1OE01TUxlUHVnS05QZnBEOUdCc3l1?=
 =?utf-8?Q?M6E0xXDcUTnEQGy8fIPNm8NnPelBYPTW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnI1b2dsNEd2UXVjZHBlRUp6OW5GZi9YMHlGcW9naUltQlpkaU5rdVhJQVA5?=
 =?utf-8?B?R2IzN043RG5yNXFndHlvdmlGTEVGdk9PMkhJL252TE5UNUt1dkMySUJTeFRk?=
 =?utf-8?B?YThjWGhTc1JKdC9GcWxvMkdLSXRsVmxETDR5NXJwUE5JeEg3SkpQbUczcW9q?=
 =?utf-8?B?MlRLRTBCRW1kRTA2RG50ZVJZTXBDczBSMmJLVlBvWlk5NHdhTXROZUhVZ3Rs?=
 =?utf-8?B?eEdFUWdTeENMeXNJMFNxRGdBVFh0Q1dUK1doMDFEek5MNVZuRzlRRkhxSjFL?=
 =?utf-8?B?OU9TWUdHcERoUlh0WldpYTBhRVJuSHdmZ0VZcklJOFQ2Vk16QzRMcGYzaDNF?=
 =?utf-8?B?MkdkWFdHaDhOQTJjNVh5Nlh4TDlsT2V1aVdJYjRUSnVKVVB1RGQydXRqUnFs?=
 =?utf-8?B?SlNxTzJxdjcrYUhCRXorMEF6ZjQ3Sy82V0lrMVRrY2pLbUR6ak1lb2czWVRZ?=
 =?utf-8?B?SmxPek1ieWtKa3drbmJIUTgwZDlxMCs1bmFvR0JxM0wrN3dYZ2JGT0s5ZVp0?=
 =?utf-8?B?cTM2RU9HTkJEVHYzbW1jVkowaEdTV21lTTBwVHhReWpGb292T1VZbWY2M2Vv?=
 =?utf-8?B?MjBxTHZhNmw4MDBJSmR3V0J2MzUxT0JsU3gwN3g1NWJQYzVmK2o3ZWxYR2pq?=
 =?utf-8?B?UVJ6dFpGZVNWMUI4UEh4K1ZxcmFVK2QxV1lTRUVLNVB5NkR3T3FXUWh5dG9O?=
 =?utf-8?B?OTJxY0Z2ODk3bXZ3TldMRjRXL3JJWjh5NW02VUl1VGRDL2pESG5NVG41RDhk?=
 =?utf-8?B?b3JJaVJDWE5rcGYxekRmLzFLNERvYWpGNGRSOUN0VTQwVkFieXFsYy9ibSsz?=
 =?utf-8?B?SS8vYngvNzNCRlgzQzVnTkIxUkgwZmFYcFZBWUJVQzRLMDRwR0F5TDFOcC9x?=
 =?utf-8?B?RklmZFVTeXYyN1htL2FHV3JQbGRtUU9VT1c4Y3ZxSGZDTzBObFpsaC9WcVlM?=
 =?utf-8?B?MzhVWWJabndqdnhFRHJWVlJURTFrZUcxNlpDdGp6TEtjTVJwWHlFd0ZEbHpD?=
 =?utf-8?B?bi9vbUZVcHlZVEluR2QvYmRGSS9DMlFLRDVrMXBsaHJGR3d4dCtWZmh6ZkpR?=
 =?utf-8?B?eEVwa2g2Vlg3ZUJxSGFOaDNFaW1vZzd1by9telJDaGxNK2poajVWRkN2bEk1?=
 =?utf-8?B?YWYzVG5DNmlKaU9WaDdRMGFwTmFqbVY1Vmp5NWdSemk4d3ZPQUVTMDNpbWZK?=
 =?utf-8?B?cm85UVlCKzdjQi9zM3JGQVcrWGxDcDJQdFBURFBiOTc2TFFsNXZ3NnBBZ2g1?=
 =?utf-8?B?UEJEM0VoOTkyNytzWXk4b2pDZTYyUkIxUGE5dFI1T2U0eXdsQkVBY09TOXha?=
 =?utf-8?B?UURQWjVSZWRLSVJuVzJZUjB1KzRTY3FrZENRSHVSS3E2dWhJbXpUdStYejZG?=
 =?utf-8?B?VHlaOW1KYS9sSU5UamtHYTNja0REWE5CZFVyV09wM2x6WU1vaHlhTGFIKzRM?=
 =?utf-8?B?S3FRUlNtQmJocG9vN1JMQmV2OTFQanZrQjBsVnMxUjhrNDAxOStyWXhpa2xz?=
 =?utf-8?B?UFdWWVN4NHZWNlYxc0d1SW1QSDd2WURHWlZZRE03OWlCbllYVDVQaXdpNjJx?=
 =?utf-8?B?RERXTHpxZ3o3T2VXVHNLZWhCdXFoaUhmRlVFY3VQbEJUKzVMTHlCZnZXUnhU?=
 =?utf-8?B?aTIrVXJibEErY0MxZGNPV2hYVHIyRG1XZ3hIeG5kc3RmUG1lWXlrZSsxOWZa?=
 =?utf-8?B?YWFlWUhtZm80SHNyOGRweVlScHVqc0FzbG5NUktzWlpQUHVNM3hVZEhGaGV5?=
 =?utf-8?B?OU9xdFJGc1hUSGErRnZaZUxtRTZTTms3dE9oTDgwSGNmT2VsNVduUGZla1VF?=
 =?utf-8?B?dC81dEZjQ3dwZlNhMjROSjAzakdLcUY5NzJ4YzZlck9XRGRBZmdRbG1DNXNU?=
 =?utf-8?B?SnpieGcwWnlqMGw1dG1KbDQ4RDVzTHdyNTJlNzRySHR3MndCd29nWlNTNGtm?=
 =?utf-8?B?SnNzN04zS1Q3bk1vd3BzUVhlRVIrRkFvM3JSU3lIQjZqM1dCQURPdDQzZkp4?=
 =?utf-8?B?VjRFeTREV0duSlFZVVRjNDBOcWtpMTZYWEt1cUFxc1VLU3lxTWVaNkdCS3h5?=
 =?utf-8?B?eDJmMW9zcXp2cE5nVDRrODBWckxVMlgwSmFzUTFlc2pYdU5CMHJhNXN4cVFn?=
 =?utf-8?Q?ngRzpg65jlI9UntFud44CAb7A?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e13819-96e1-4a46-8312-08dd5624dc4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 05:17:27.1039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /uktuIvOPVrIYR1GyidCE7VL2u5ZXAtJgj3BDIU+i2icTQpm++dmUnkx7usdarEBveLvbEqHOV6Z5SmpgpSU1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7993
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEZlYnJ1YXJ5IDI2LCAyMDI1IDExOjU4IEFNDQo+IA0KPiBPbiAyLzI1LzI1IDE1OjQz
LCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHU8YmFvbHUubHVAbGludXgu
aW50ZWwuY29tPg0KPiA+PiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDI0LCAyMDI1IDE6MTYgUE0N
Cj4gPj4NCj4gPj4gVGhlIGludGVsX2NvbnRleHRfZmx1c2hfcHJlc2VudCgpIGlzIGNhbGxlZCBp
biBwbGFjZXMgd2hlcmUgZWl0aGVyIHRoZQ0KPiA+PiBzY2FsYWJsZSBtb2RlIGlzIGRpc2FibGVk
LCBvciBzY2FsYWJsZSBtb2RlIGlzIGVuYWJsZWQgYnV0IGFsbCBQQVNJRA0KPiA+PiBlbnRyaWVz
IGFyZSBrbm93biB0byBiZSBub24tcHJlc2VudC4gSW4gdGhlc2UgY2FzZXMsIHRoZSBmbHVzaF9k
b21haW5zDQo+ID4+IHBhdGggd2l0aGluIGludGVsX2NvbnRleHRfZmx1c2hfcHJlc2VudCgpIHdp
bGwgbmV2ZXIgZXhlY3V0ZS4gVGhpcyBkZWFkDQo+ID4+IGNvZGUgaXMgdGhlcmVmb3JlIHJlbW92
ZWQuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEx1IEJhb2x1PGJhb2x1Lmx1QGxpbnV4Lmlu
dGVsLmNvbT4NCj4gPiB1c3VhbGx5IGEgc3VmZml4ICJfcHJlc2VudCgpIiBpbmRpY2F0ZXMgdGhh
dCB0aGUgaGVscGVyIGNhbiBiZSBjYWxsZWQNCj4gPiBvbiBhbiBvYmplY3Qgd2hpY2ggaXMgY3Vy
cmVudGx5IGluLXVzZSwgd2hpY2ggaXMgb2J2aW91c2x5IG5vdCB0aGUNCj4gPiBjYXNlIGhlcmUu
DQo+ID4NCj4gPiBUbyBhdm9pZCBjb25mdXNpb24gcHJvYmFibHkganVzdCBjYWxsIGl0IGludGVs
X2NvbnRleHRfZmx1c2goKSBvcg0KPiA+IGludGVsX2NvbnRleHRfZmx1c2hfbm9fdXNlcigpIGlz
IGNsZWFyZXIuDQo+IA0KPiBIb3cgYWJvdXQgaW50ZWxfY29udGV4dF9mbHVzaF9ub19wYXNpZCgp
Pw0KDQp5ZXMNCg==
