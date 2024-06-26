Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8448B134DE
	for <iommu@lists.linux.dev>; Wed, 26 Jun 2024 02:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719369244; cv=fail; b=m0Cg1Vo/iUkxIs/6j/m6btrnqRYl1hmCndKHuFPh+iH4WPwvDqKicYrB18bAVEcx2W/Skhi58isvFHG/zDBjfHBvyxZtJQhtikSs3i0SLaeloF3UnEYC9PWG34H2JGsT+kuNK+aP8fdRI59GCwKHoaHWObJSXr0qhYblsEWYjxw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719369244; c=relaxed/simple;
	bh=kRjtFAi+kfiuVPkQMEl68IytIhy0VS7DObu5TUWW/z8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=beCSglEA+Dgl49dx1Lx57+Sx9AwRduMmSdYC5fQJPDQii41XB5Q9wZpWLZiP+O3c2Hm0W8GI/NVH8BZf+hVuQECHmvZM0pBdUjL6YsUVIvyFvFu5yyahCv+cS2NmLBAx/9r1VJND+3tJ8YHMq5NPGZSi+t8VS3bO0HBYUDrc2lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=By/C1OFR; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="By/C1OFR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719369242; x=1750905242;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kRjtFAi+kfiuVPkQMEl68IytIhy0VS7DObu5TUWW/z8=;
  b=By/C1OFRM8sLJxZN0ynQogtwgh9X43QMypy2MDXC517U8UpItkvZX18p
   V4I+kcUu18bmHyHLcL/OruUkR1cyKwECcsmBI8SoBvCwqn6VmOD/xWBgt
   qGKT3QOcurPD9c+9IBGevLOr2jvtnSwLf1LQDc/9oIJC0Hm79bQgA3TqP
   7YE5RB+suEqfOqjenqTRnITdywMpEHpGMdFQXOGhrUYfqTMIVoU3yBwIS
   GpTzFu/li3gz90xBWsBAjZlvZ2WZsts5YGK0UB6E6mYzcrvefQ70G/IoP
   jTMov5kiu+VTmcWWmMsF9IMPGrFsN21Qa/S6bWTlcgCj3MLPQIu3EudIM
   A==;
X-CSE-ConnectionGUID: 17UFZZx0Th+KWQW6mGD73Q==
X-CSE-MsgGUID: NH5fYCUETSWeeRCKIqEPFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11114"; a="16547839"
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="16547839"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 19:34:02 -0700
X-CSE-ConnectionGUID: tbazonqsRd+6z16mFM/ZYw==
X-CSE-MsgGUID: L0MZa5UERBy/ieates7UrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,265,1712646000"; 
   d="scan'208";a="43947917"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Jun 2024 19:34:02 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 25 Jun 2024 19:34:01 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 25 Jun 2024 19:34:01 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 25 Jun 2024 19:34:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsCGb+XbODM0Yaka2hDBJ2oy7jZErzZ6PGKEFq0C+BFJEAWwuNE1CoZHsduVEiXu/6EiA6sNjlMwuOQZSb6Kz3PjgRITwP6S+sK5Jb8SseTGBHVbbNNfGXSzwePnG2DzdsRys37EV5gcbfQH7SjP1397HPwWZ7IpCuucpwQg971c3eWIG+fRpMaxqZbD5zWaQYZEP8nJRqxn6cTSEdnfx/j5Q8TXdrGVUr+b2fRxpJCuMwqR64p2EvHFmLuXCG3ZZYyelohGUcr3Z7Sw/zrKryjHbaSie/3lgurkL3S09oG1ESHhGF2393jHVdpEM5TxV6Y158EoxNQHZLMnwGvSHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kRjtFAi+kfiuVPkQMEl68IytIhy0VS7DObu5TUWW/z8=;
 b=anDUtZ389Mlffnn7SgRTapu7ngNh7B7qBXJ9h4v5IzQevZtex+1y3K4qbBkJOFLco11Acp+hRd5tpdLj3SR1sbMFWQhN5WcMnTYBuEVwyzkslytFZ5HrZNUw85G/0mrz9oeOnvc3WdtwpGN+TIlw34vS2CKmys3+WXieepoZsqRTm/BGkwTgr2XccF/3hULio/EexQOPEJkfOpT4zAdzGGfYnk2SBhPDbg+z3y68phUbXTJ2W0gnOk+XnG/43wQMUwlMQ6g21sEiXrGG+UJWgSJK4Tm0FH+DWJonucBhzJaeIeHrlY11JdFa9HyY4/610ldpvAR3osmwQI7bSL+A9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5083.namprd11.prod.outlook.com (2603:10b6:806:11b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Wed, 26 Jun
 2024 02:33:54 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 02:33:54 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Lu Baolu <baolu.lu@linux.intel.com>, "Avihai
 Horon" <avihaih@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v1 03/10] iommufd/selftest: Add tests for <= u8 bitmap
 sizes
Thread-Topic: [PATCH v1 03/10] iommufd/selftest: Add tests for <= u8 bitmap
 sizes
Thread-Index: AQHaxAr20AVbmXF1cUqB2uodB5oDW7HX2CrAgAB+xYCAAQJiwA==
Date: Wed, 26 Jun 2024 02:33:54 +0000
Message-ID: <BN9PR11MB5276D0EEDBA3F6D7587220478CD62@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
 <20240621184254.45477-4-joao.m.martins@oracle.com>
 <BN9PR11MB5276C4EFEE9E6E2E8A096F748CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
 <a82fea7e-d76c-4ca3-88be-2a9455f63f9e@oracle.com>
In-Reply-To: <a82fea7e-d76c-4ca3-88be-2a9455f63f9e@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5083:EE_
x-ms-office365-filtering-correlation-id: 1d7de580-8504-495f-498e-08dc95886c70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230038|366014|376012|1800799022|38070700016;
x-microsoft-antispam-message-info: =?utf-8?B?dmhLRzdUN09Xb0tBL3NDQnRvcHBpSCttQVJuRXhWYXMrV3I0SHYyM3NOOW9O?=
 =?utf-8?B?ZFZMTWxzdFc4aTA2dlkzZ3RQelVUT2hBVWh2YmIyNnNDRVFVdDAyU20yaXpX?=
 =?utf-8?B?VFpYNTBscWR6MVc3cVZMck9LMWdINURqUm90VkdUWHBpTFhaN3pHOVpYTWhW?=
 =?utf-8?B?aXRjZlI2ZlVSN0QrZGJNY2M5UlZaekV6MzdaZ2IzMjRNWjFiOU8xbGZNMlh1?=
 =?utf-8?B?Y08xRFNqR1p0bGliR0V2RWRUaU4wSjJKNnpTc3pyVGtNUlBFeUlHUGgyeGpY?=
 =?utf-8?B?dkZ6ZVVBWWhjK2YzQWk1Y0hWbGNvelNhNm53dU1HSW5YWCtYSHRkM0dNRkJr?=
 =?utf-8?B?MVRjSGFMaFRob0JLTm1TQ24yS0NyUERLZnV4RlUzek95OWMzMmpVckI4cXRl?=
 =?utf-8?B?V1pSc0tkcUhJWlRKZE9JYVNaNGRlZ2NKcGlZQkxWZk8zVzBRcTJNMWlKTGNq?=
 =?utf-8?B?MHowQ0s3aml4VjRoa0RZSUh1eDVOUXBqeTVVNDRjbjlhU0NJUnIwbjRzOGNu?=
 =?utf-8?B?UVk3ejZFT1F5YVNXSlV1L0ZJeXB3b1BnUWpVTmNYWFk3Vi9oUjZ0dGUybnFK?=
 =?utf-8?B?dHU2ZWIxRC96RWxQSGxZKy9JVXVkM1BCNGpNdGUwbDFyekl1R2JYKzZISUN4?=
 =?utf-8?B?RHRqODl1QXVGdEh0bU5yMjJMaEpXRHdNN0dwMTBMb0JtU0NKQkZhREkwTnlZ?=
 =?utf-8?B?Y2xkSklxbkpZTWxENStHUE1POFJLSld4R2ZQMk5tREMwdDBqR3k0eHowRm1I?=
 =?utf-8?B?OUMwZHNHWEZNU3FHWVVGRWNWcmwwV2lPZmk0ZDA4Z0RNd1pVejJQS2JCR2pm?=
 =?utf-8?B?LytPVnFudmswb2NXYkUrT0RHNnJtU0xkYTdkN0N1TWgyK3VrU241UUk4UW1w?=
 =?utf-8?B?T24zNk5XaDlmRWF0R2JqdFFLVjlmaVVmL2RTdnRWWTJraUIvSEJQNFFZYVZW?=
 =?utf-8?B?OUNIT3YrQlZCQ1ZMcEwzMWswcGt5eDU5c09ZTkZjaWhsVU1CMkM4N3JYWXdF?=
 =?utf-8?B?amtKcERmYloraVV0SVBXcWtIZWVqSVdvRVRYOW5qK2NRd0V2ZE0vc3N6QmhU?=
 =?utf-8?B?SkVOcTErTGJIdHNDSm5ITytyL0RzTjhsV2NESWlUaFozRW52Uk1JZmxtVE5j?=
 =?utf-8?B?aTFveUhNcGwzRWRCN0h2NTM2S2VFL3lQbHQwaWZ0bWxpUUlRRjBsdmh6dFAw?=
 =?utf-8?B?SEhtV0RxWFNOZ3hUcFlhenM4bjhUeUdQTmplL0sxWVhzdzl1RnhFZVR6MGZH?=
 =?utf-8?B?N2t4Sm1iMG9aTjlDU05ZSGhqOFM1aFp0L0NZNklxa3ZLU1ZTYjBtOXhPdWFi?=
 =?utf-8?B?TzJtT0l4SHVGK0VsT0tuMGM4RThnWmRYZFoyZE92U3Z1TmdEd0JkRVhleTZ5?=
 =?utf-8?B?SENmMXpzZlE5VFQrMEhSMzdaMEFobGRXbm5USXFVTitmaXhVdDhIdm5aTWhn?=
 =?utf-8?B?RFpleTJ4dG96clF5TE5VZzZXb0NSUW5DSXI0RS9Ha01iTWI1MFdLSnR0UDNQ?=
 =?utf-8?B?Yjk1YVM5YUVnc2JIZi9jSm5iczY1MS8yaldMcmVyWm0xWlk5MDdMVzdqalVG?=
 =?utf-8?B?bEJnUXJJWEdMR1lYS0lDL1FNY3Q5Y2hsNE5IbHIrUTZrbGFPNEJVOURKRktx?=
 =?utf-8?B?bEVCdEg5UEV2VUF3VnpDRElKQ1NUbGs5VHdyWE1iZFVIYis2ck1kbmc3ekZB?=
 =?utf-8?B?U2x6UElxME9mbE1zdDNmZjh5Y3c3ZmNhWjVUaFEvRHE1UVpBSk1UODJtQXNB?=
 =?utf-8?B?RFE2dlIxWWw5cmllWmszS2JWVjdpbXVidTZlYjVWalNReGVVMnYyOGVoa2hG?=
 =?utf-8?Q?0yssyCjG0mSs8Ae1AzDzB4M9wclm0ogZJ4WhI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022)(38070700016);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WEs3MzBNVUtyTzJWWllVc3QxRzFXd095OFhZdCtYZ2RxWU54ZitxaEdORjlP?=
 =?utf-8?B?eHJKdTZ3L1FDOFQ3QUZ3Ymp2dkdrVFZjNzY0VjhkVzhPMmJlUGl0WC9hRjZQ?=
 =?utf-8?B?bWpvVmZpOHFJQkZMZFJtM1RqQ0RFOUpITkMxRXU0aWhCT0RPQThzS284NnZN?=
 =?utf-8?B?MjJKK2t3OFh3QkRmZVo5SlM2M3l0T3Bwbjdmb05QdUZKUmw4Y3NrVVl5Qm1h?=
 =?utf-8?B?dEVVdW8yd3ZXTG83a29SMk51Q25TZ3ZkN3AyNVZGR3N1c1FQWFZNYUVGbXhJ?=
 =?utf-8?B?MjQ1TSt3dk5uVHZqTDh2YzljNks2S3BnSTl5T2gyelRQSmh6VkN0OFdjOVM1?=
 =?utf-8?B?QmdlbXduTEc3UExKZnVJa0QrN3VrNDBLOElsWlBVSE9zcnk4SmFkWnN2MDJM?=
 =?utf-8?B?ckhudWczaTNlSEFiY0pzdm9DRVBLc2laU0dCcVUvanZ3aWorUFdBRDVOUWtD?=
 =?utf-8?B?RUlEUmpNa0xwT3M1KzgxMmlJNXp6SVJweFBPZkxzdFFHZUVqRnQyS0FkdzBy?=
 =?utf-8?B?cW9MNnprT2pvK3prZzU2dXFNd29kRWJtdE9Mazd1M3lJMTZwSWZyYjQrUXJJ?=
 =?utf-8?B?L0ZwVmJoNUNwSlJDcGwyYm96RmpqUDdpRUpyV202ZFVzRENHMnhrSW10M001?=
 =?utf-8?B?OWxCWUNpVFVxOVgwVjdxTUlkY0Q0RWhvYXdPUE1uWnhRL01KQXpIWWlkZ1VO?=
 =?utf-8?B?SkZnNlVPUlZzMU5TL0pOS1BTS0x2T0lDZzhNUUJYZTRXTmY3SzVHNytRblVk?=
 =?utf-8?B?MUlaVGYySDB4L293NmpMVGo2bjkzcnVOUm9mdVFhb0dNeGpnTEUxZXErWDhV?=
 =?utf-8?B?bTR4QmZOMlFadWRscUVkb3NNZDQ2R2dIVVFmaThFWGowd3Nna1NSdTNsVGlX?=
 =?utf-8?B?WVhTbTBRYitsby9jTHpmdFZRYkJPYkMzWG41NUVYU3hVMlZyOFl6eWJBRWRH?=
 =?utf-8?B?Z3BQZS9BMXdhVkJHNGQ1ajJLQUNHUWh6a1A3dFphY2liQnplSFhxKzV3d0U0?=
 =?utf-8?B?RUlwakZYK3lQTnNtY3ZRREc1M2dPNkJCQWszV2NLMkxIOFN3R1Y2S3oxVWNN?=
 =?utf-8?B?THdwaUQxcERsZ1gwOG9PcTEyN1lYM2FVZGZRNWxBMldaVzZnamJuQ3R3SGhr?=
 =?utf-8?B?SXNHd0Zncnk5TFNqRjU1eEkvU1BwbjVYR21qTGUxM0pOUktyY1ZJZ2VsNUhx?=
 =?utf-8?B?QncyV1JnWC9uQnYwWmdjVUNoaE02UCtKUXkzTzJENllhZ080Q0lRVlFSejVP?=
 =?utf-8?B?V0xwbU1Tc2EwbjNTSzhqTC96Y2hwbXVPd0xaUUxCRk5Od2FBRUdleDZxN2hw?=
 =?utf-8?B?ZnFsVGdWbmZidHhUOFJYRXlueUtMY2RIMXpEdTNnN1hyZGo0eGQvNzVzQWp5?=
 =?utf-8?B?Z0owazVneWxZTms2WHh1OGVVZmEvb3V0RiswRjJRcHBRb0Q3OEIzZzZXRDhT?=
 =?utf-8?B?UE55ZlYxclJ6OERKd2dyNU1YVlZTSklMcTU2TUVHTDBjQUM2OEtvd0Ewb2VU?=
 =?utf-8?B?cEUrcEJ6R1ZmOFRTdVBiYkRlR2tOVzVqdEllMEpCdXdMQWJLRVBRNkQvU0kx?=
 =?utf-8?B?L2JUbW1hWlFNaXMzR3VpWXVWZWhYc3hGS3Y3RWNGaFJMNWpubUJ1N1Y0dk9v?=
 =?utf-8?B?YWw2bU94VkF6aG1pT2xEY1N0NjhBaE1GY25Ed3lVT3FmK2htWGZmQUc0ZVJw?=
 =?utf-8?B?VDVpNStTWDNPQUR6QW9kNi9HTnlndUY5MlhTdHVPcm01SEZ4WTd4VGlidC9H?=
 =?utf-8?B?Z1R3anJNUTJaTkFFK1VOOXU2NUVQdzVsZE43Y0ZMbm9KeVUwWWo5bXcrcFQ2?=
 =?utf-8?B?QS9ZQTVmdEhVcXR6ODVuNGFOeis0T0xyY2NQVW1TbDd6WUNGbUs3MHU5OUZ5?=
 =?utf-8?B?enJlemcveFdsTHYwZjAzOHlWOWdPRzRRblJQTzl6a3dVQUt2dmxBTTgvc0tN?=
 =?utf-8?B?Rll3YWZvTFRlOXlOcDE5WWlzMUtGNjUrZTVHQmdFZG5CVEZVWFc3KzRiVHo1?=
 =?utf-8?B?eUNEWmpKeW9jSlRkejYxSkoxZDBmSFRHSm5KZ0IwSzNZNWRNRXBnZXBFNFND?=
 =?utf-8?B?TnIrNmdyV0trbWVaRGIzUDV3V05HeldLMFAwUUpydUtHNWdZbXpaeEx5dHN1?=
 =?utf-8?Q?WfguPSJBx511Rffzi7PUb47Wm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7de580-8504-495f-498e-08dc95886c70
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 02:33:54.7139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O6cj3VUG5Awr+MapejMaCyiAgFyyouJlrjrBVCuHDdX1RUeo+q1yIxH67Z5CCABPhCQpQgZ+Ua0cMTWxWl0paA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5083
X-OriginatorOrg: intel.com

PiBGcm9tOiBKb2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+DQo+IFNlbnQ6
IFR1ZXNkYXksIEp1bmUgMjUsIDIwMjQgNzowNSBQTQ0KPiANCj4gT24gMjUvMDYvMjAyNCAwNDoz
MywgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEpvYW8gTWFydGlucyA8am9hby5tLm1h
cnRpbnNAb3JhY2xlLmNvbT4NCj4gPj4gU2VudDogU2F0dXJkYXksIEp1bmUgMjIsIDIwMjQgMjo0
MyBBTQ0KPiA+Pg0KPiA+PiArRklYVFVSRV9WQVJJQU5UX0FERChpb21tdWZkX2RpcnR5X3RyYWNr
aW5nLCBkb21haW5fZGlydHk4aykNCj4gPj4gK3sNCj4gPj4gKwkvKiBoYWxmIG9mIGFuIHU4IGlu
ZGV4IGJpdG1hcCAqLw0KPiA+DQo+ID4gdGhlIGNvbW1lbnQgaW1wbGllcyAxNmsNCj4gPg0KPiAN
Cj4gRXhjZXB0IHRoYXQgaW4gbW9jayB0ZXN0cyB3ZSBhcmUgdGFsa2luZyBhYm91dCBNT0NLX1BB
R0VfU0laRSB3aGljaCBpcyAySw0KPiANCj4gVGhhdCdzIHdoeSBpdCdzIGhhbGYgdGhlIHNpemUg
OikNCj4gDQo+ID4+ICsJLmJ1ZmZlcl9zaXplID0gOFVMICogMTAyNFVMLA0KPiA+PiArfTsNCj4g
Pj4gKw0KPiA+PiArRklYVFVSRV9WQVJJQU5UX0FERChpb21tdWZkX2RpcnR5X3RyYWNraW5nLCBk
b21haW5fZGlydHkxNmspDQo+ID4+ICt7DQo+ID4+ICsJLyogb25lIHU4IGluZGV4IGJpdG1hcCAq
Lw0KPiA+DQo+ID4gdGhlIGNvbW1lbnQgaW1wbGllcyAzMmsNCj4gPg0KPiBMaWtld2lzZSBoZXJl
Lg0KDQphaCwgdGhhdCdzIGl0Lg0KDQpidXQgdGhlbiBleGlzdGluZyBjYWxjdWxhdGlvbnMgYXJl
IHdyb25nIGlmIHVzaW5nIDJrIHBhZ2Ugc2l6ZT8NCg0KRklYVFVSRV9WQVJJQU5UX0FERChpb21t
dWZkX2RpcnR5X3RyYWNraW5nLCBkb21haW5fZGlydHkxMjhrKQ0Kew0KCS8qIG9uZSB1MzIgaW5k
ZXggYml0bWFwICovDQoJLmJ1ZmZlcl9zaXplID0gMTI4VUwgKiAxMDI0VUwsDQp9Ow0KDQpGSVhU
VVJFX1ZBUklBTlRfQUREKGlvbW11ZmRfZGlydHlfdHJhY2tpbmcsIGRvbWFpbl9kaXJ0eTI1Nmsp
DQp7DQoJLyogb25lIHU2NCBpbmRleCBiaXRtYXAgKi8NCgkuYnVmZmVyX3NpemUgPSAyNTZVTCAq
IDEwMjRVTCwNCn07DQoNCi4uLg0K
