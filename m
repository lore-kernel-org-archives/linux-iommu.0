Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727D2226CF3
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 08:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750752755; cv=fail; b=bVC7XzZ30h0RPIi+V7TERSF8tDAMDEQDGThCpKFjlkh31392o/dsCvQXAJ5MBZzvQQcMwMslQzuMBA14CTRz1+DwOFzBSwDnK8M1ZZsAXILo7Qoe40hIgJAOCwEorR+rvA3eNMyGblCnp9xUSXQWqOMJUoBTi/nRtv0DaNQgf5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750752755; c=relaxed/simple;
	bh=rez0kFCoIfRd9vdX3Vh4e3EsUCzILf5N2GRqS2i4dwM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fnURCRTxA6aQFm3J1B+RZKBRgPL6iz7SLpugXZqN3eT50Sx1wRE2xQzipTohWbbK+sOKzaZqYwFGmr2IqLY9RJe0zCSpZNHw/Dx1tkxTIJSzuJtdIcBZlyCJrAsDPnuxO6ImCGalQszjUiLqOauKVksS5+4mVpHJQt195dS3RxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BRg04R3q; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BRg04R3q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750752753; x=1782288753;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rez0kFCoIfRd9vdX3Vh4e3EsUCzILf5N2GRqS2i4dwM=;
  b=BRg04R3qJ4jXDxFixSqw04tuU6vlBsl96LQ8ZOo2yXzqEGDN08lNQ/O2
   ey5GOHug2ecTvEyo5VrPFOUhUktgR6gDmagTRUd4a4SU9BHn6R5Eg7I1N
   FdvlZVEfrRq+VZ6FcoSKxedUqV7BD17GYx1Q/H7AQTW53NqNGodT5+paz
   EjW11iyXOpjgsSS03H52Z08CT3sQy3Vir0i0NJv2+RJ5mhSGOa5FOuGyK
   DsO6XGzKZqMIP8Q+WGwCv0AfNm1G1mok5A5fMro1fsYE69lgcPF32tU4r
   OHev5LC7Zh6jIQQ/IGTDmytj329oHQn/LtIo9u8kEaM5ukqiqkq0aYsEP
   g==;
X-CSE-ConnectionGUID: bXP58RtCRtSwdfhlMDP0gg==
X-CSE-MsgGUID: Flfz8t7eRMuDybpk5sCugA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="70552635"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="70552635"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:12:33 -0700
X-CSE-ConnectionGUID: f8WrWKibQWGU6Uukockc9A==
X-CSE-MsgGUID: uxs6VX2ZQ5CeYGN5WuhEMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="152145576"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:12:32 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 01:12:31 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 01:12:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.51) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 01:12:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lsv0p71snKxVwNneWmMV/yIvrgxHgNbVWiLFvQxlA9lqkcDu+w/4lGOSO/0wW/mjPBySJor5NyhNN0ViK9Wu+gJZADqN/geR4lIfkkdlkMFR8FnyPT6dcAyrY9yBnDC2c7yD4IozgURnyVnnYZPxDQmPu3gpah+R73ujgRya53oqKV7MU0umHNMc1dL1bG1l/7xUmMPbVGksdSqs2ZvGAdckyKLFmdAbeJRALwgwHmJ/W9MDkUIX5Sznz9BDcHdLwQwFv2jAFOdJVRGDV8KLfSuie/SpN72FM9R3pU+mwKNPRY5Y2ocrUv1sV/3wIJFfCoiEkuPCjAO5JuXQTiA/kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rez0kFCoIfRd9vdX3Vh4e3EsUCzILf5N2GRqS2i4dwM=;
 b=J626vb1V0cBWpsU6eFhRVGuRWCYC6+tnjGYILFZlXojpe1mkWbW2GY0iQ1bUMXYirnRk1kJxHH0F7IrK23TrQ1DaI3ZH7b6fz/zOK2xnPZfH4AEg5Ckp0y754W4BXnXkIR6TW3F9MYOjgcIM2l5UbDQjp38jzMswTFfuNX2QAxMVk3U9qYTeQNQpA7KmBWeSINktDax/Jwmcgf50pqNsrEZeKsk8wNQVAQPOMyopznJlrXDqdd8f1t9lf8Zl89EanDn34/ysM14Jce4WoCNnyf02OdoN9l3pIDakWIreH4fN7i9Qq1rgHV7kO4Z/IVSPUo6X/ZFxPA/OWejaVhSHmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Tue, 24 Jun
 2025 08:12:14 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 08:12:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"will@kernel.org" <will@kernel.org>, "aneesh.kumar@kernel.org"
	<aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "Xu, Yilun"
	<yilun.xu@intel.com>
Subject: RE: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Thread-Topic: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Thread-Index: AQHb5CVFBE31qd5pKk69rn63g+oyeLQRqM2AgABNuBA=
Date: Tue, 24 Jun 2025 08:12:14 +0000
Message-ID: <BN9PR11MB52763649BE32A38A60866D518C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
 <a2fddab4-bc85-46f6-9008-57a26e099698@linux.intel.com>
In-Reply-To: <a2fddab4-bc85-46f6-9008-57a26e099698@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7185:EE_
x-ms-office365-filtering-correlation-id: cf3b1126-d3a5-4b9d-17fa-08ddb2f6d412
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VVdWZVphSzNZOGdNemVoWFd4QTN0MWhpNStLSERxSXVQT1BHaU1UUCtiTGJZ?=
 =?utf-8?B?b0daOTIvMlpWQ2o0bmRmeUViVjY2MlhhWlMwZEFJVk5HSXhrRHQxb3IySGFH?=
 =?utf-8?B?QUppTGFkM01BMzNsL0tGaHF4N0psZHZ6MjFCMTJTMy9MOFVuckFSK3U0bzJP?=
 =?utf-8?B?eS9ZMTJieDhoK2VDVlhNTUZIc2hGbkRlZGhISXF5WW13aGtvTzVTQnNrSmxt?=
 =?utf-8?B?RCtRdm5PenNCdmMwVVVaR2h3eHNmbXpDcjhBV0pVajR6MzVEZENRTW1ia1dW?=
 =?utf-8?B?K0svVzhSNWFKQ0JEQzdQRktWSVZMNGJUZ1hzZGY3Y3BDQnRCUHNpdUl2YVhJ?=
 =?utf-8?B?ZDh4ZlVjWFVmMkJ6cVQ3QUtsOExBY0xqWE5Ld0N2K0F0SGpNWldZQjV2YStN?=
 =?utf-8?B?b1dKNXRWZThXZWRIQ1pUWEZoWlFlang1MHVpSXZnRG1WazZ3TXJDMFk5cU5I?=
 =?utf-8?B?ZnBKMGlTVEpGRGZLbUVkRXI5QVM3RjRXU3FmOVhOd2tsTTExVVAwb2Npelps?=
 =?utf-8?B?b3Awc0tadDVrNWpCVGg2U2U0MXhXbDkvQkhGTVowZ0prRitqRXVKRTZOVkRB?=
 =?utf-8?B?aTh5SnlHa0h3S0ZjVlY4TGxVMHFvNFdDa3Qrc1NPdzFtbHJ3Vjd4bDYxLzRV?=
 =?utf-8?B?TEdOaGV4Rjdnb3JCUzE5SG9MdXlMZFBRM3dFTGhyekpEb2U4eElXTHR4ZlVM?=
 =?utf-8?B?VTdxWjhOQUQzMTF0T2hwRlNFUzA0dlBRaWVoZEF6YU4zc2srRVlyUTJJb3Rk?=
 =?utf-8?B?MkJUdmtVaHdaNVJqUU1BcG15ODRsKytaREpJVERPNHRaYjIrNEFGT1YrVWx5?=
 =?utf-8?B?WDZ6TVp3ZGFLTTlzNGpvaE5WMGpjdmx1YXRYM3U1SkNLaEFBNlFyS1RyZjBu?=
 =?utf-8?B?Nzlpd3RodEU5QWl0Sm13dmFqVHVFUDROVjRDY3hQTElaUzRRM0ZtaG1VWGFz?=
 =?utf-8?B?TjQxWDdOSnp0cS80NlF4b2JtU0FWYnhOUmplN1ZLakpoWVNBNEZxYm1vcVBt?=
 =?utf-8?B?RUxpNjdtbk9DR0hXbDQwYUlQUEpQMEQrdVNUc1poYm51VWhyUXBJMnpGbXEv?=
 =?utf-8?B?dlE0ckJMb1lhMnJUZUlCL2dQbFBVRVkrazRzVEkxK3NFZHVabXBtSmZDS3Rj?=
 =?utf-8?B?MHBQS2xkTDdmRDBiRzBJVEloY3lHcnVoNXVTV1cxeXpYdjJGcEE1ZCttK2RJ?=
 =?utf-8?B?NkVhZ1BUbmRwekFxTm5WY2tDMEgycmJCRkNQby91TUJmNDhUK0JjZkEzQVFy?=
 =?utf-8?B?Z3BROUIwSXlhS3cwRm5sQkJmQ1cxaHhaV3ZvUlZLeWxaTklZVTJDK3oxWTlH?=
 =?utf-8?B?ZGJxL2UyTklFV1dNak0wd0VCaFFpT2U1cE55ZVpIUHQ4eGpCKzVMa3NaUXVO?=
 =?utf-8?B?Z083V3dKUURrUWNHMHFMQlhjd1pwY1JWY0JPRHBrNTArQW53L2R0SmxSUXZS?=
 =?utf-8?B?NmFzdnB1RkI2TDZHOEczSEhoeFZlbHRKdzhYUGYvYUFzYkJGNjdCQ2RVUjJM?=
 =?utf-8?B?MEZ1ZTBYVWwrNnR4d1kwclVvZE0vNWxSYVIza0JYcmk3cnlScXV0dnZ6d1J6?=
 =?utf-8?B?bWpuQ2g3VmwvNE9wbHZ6RDAxZ1plRS9OclR0Q0JZODF1cC9VQmthcExFK3B1?=
 =?utf-8?B?RTBDZkZTN09iWHliQUZwV1RDcUl0bjZXVlBFclpjeXpSYXR3TTRSa1h3VndW?=
 =?utf-8?B?Q1VJeXlnL1JaTk8vaXlXeE9abzZkbzBEK2gwaEU4MTFtTEo1UVM2KzB3b0ZR?=
 =?utf-8?B?UzFPZWNGVCtYU3VJSmhmVmlWSjNYWnI0R1IrSjJ6a0xyRDBZTW5PY3orUUN5?=
 =?utf-8?B?RUd2V1Y0QSsrYUF5QlYwVDF3UFJ0V2xnL1BydmZHTGFKbUk0aUJmUWV5cWFG?=
 =?utf-8?B?eUx5WlRRTGd1cVNzNThqUmJMbDBycm9lbnBrNjRkOUwrMWFucjBGVnNWY2wv?=
 =?utf-8?B?ck1DZ1Z2REhiSG9Zb04zS1FoVllQa3FWNmtETjhWLzVmQ21INTI4eGRFNTlN?=
 =?utf-8?B?SXMxQlQ5bGx3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cThyM3VCK0IySlNoWVhnZFVkV3JsRVhHQ3IzK2cydE9UMWFHVlp6ekdhTHJp?=
 =?utf-8?B?dU9HYUZKbi82eDRMVHI3cFVJTEprSURCSW8rc1dRdXlkS0VLVGZlVEZlai90?=
 =?utf-8?B?dzlxbHd0bUIwQk1halZXWXF6Vi9FVUE2cTNZUnJkSTdNMnVXakNQZGgyK05w?=
 =?utf-8?B?bnV6blQ2VzBHQTRUb0k0blZlRlNRL3ZIQVZNb3VpQmhBeHYvTUs1VXBNczZo?=
 =?utf-8?B?MmtydENLdGprc3BmWER2WkF2SloyMXk2cHBGVmNEOHVUSksrWHNNWGtPU1VZ?=
 =?utf-8?B?dmRwdW9iU09jOThpSUpFcU5TK1FtYzVZN3k0bmZUZEkwcTR2aEUvRTNDSFZ2?=
 =?utf-8?B?VGVFc3Mxb2JpalVEMGZjeURlWW1SL0JQVlNhOW5XNzUyOElkUWZjajZBQWc0?=
 =?utf-8?B?SmNkaWZxNjhVWGhUUXdCeEFtYktkeGx5TW5wZHYzYXY5OE41TkFYMWU0andF?=
 =?utf-8?B?WVZ2ZTFDTzRPakV6aVd4SEZyQTg2NTFPT0JZQjN5MWt0NTJXeUFoMXp5bG9o?=
 =?utf-8?B?Um4vT1RTM25TMWk0ZGpCTFRlVHpxQi96NDNzeXdabnkzUEwzTkZKSU5FL0VO?=
 =?utf-8?B?VVVxNCs0a0gwQ0dGM1l1TndESGpOY2F2bGhjL0FQbVRhOEN5R0dIYURMdGJs?=
 =?utf-8?B?TWVZeG1KV25OeTBjY1kxeFV0Wnd2Q09aYU9qNnFreE1UNW5nTmdoWERGb1l3?=
 =?utf-8?B?cDNISmxGT0JDbGN2U080S2JiM1JqVGlpaTJqazJDZ0kyczcwOWpWTTEwZzIr?=
 =?utf-8?B?TGJiY0dINmI4V1dmd1FCNTlkVGhPNEYxMWRhdWszTjJEN1BLdXBLckREOFgz?=
 =?utf-8?B?dHBzWG1FN01OMWtud3g2cWN0UUxZMG8vdmdia2V4OFB4WUpGZktXVUV1d1lU?=
 =?utf-8?B?U3U3NEdSZmROcitUTGpXY2thN0pNeWN6NVZQUEFvc3pXV0FqTUFyVVlJalNs?=
 =?utf-8?B?bXBYYzNHUFliMEovMjZYSGdYZGEyMitSNjNWOGZYT1VOYmZyU240aUZKWXJC?=
 =?utf-8?B?QmxDSGhBdkdLQ0JHY2Zjb1JsK21Vd2VjSDE5UncwdHJjUWh5NTc3U3ZxaDRh?=
 =?utf-8?B?TU83dVlGdERhM21iN3Qzbkwwb0k5L0x2MHB6WFBDVk5xUFQzM2lSNWpSOHNK?=
 =?utf-8?B?aU1tdldNb1VkYkwvbVVBNWxsY1VoSDN5WE9GaDhXcnJJb08zcGRJL0pLZXZH?=
 =?utf-8?B?YnY2bDJiMnJDRnJaTWhkL1QxVHg2WXNJSnNWcm9RVTdmVjQyeWFmenBkQ1hx?=
 =?utf-8?B?c0c0Mnd3ZHNYblVmSFZNRkx4QXNHZE1xL0J2Q05LbjRVQnYydUxYNjY1RTVU?=
 =?utf-8?B?dVpUU2FZbHRoMS9seUl3MzgyN0NCcHBrWXlFa3JVNkgzOVdybFAyc3NxTEQ2?=
 =?utf-8?B?RkF5KzBMMVp2RTczYjJybC9XYUMxaTdBL09WeW02MElaUGQ2Z2NOT3grbStr?=
 =?utf-8?B?NGVTSStXREFaVlVXNkJBZFpSY1h0UURNSU9palBZOFpsSGRVMjVoYXpMeGVW?=
 =?utf-8?B?T2Rkb0FYekRWZlpXQU9PRWhCc04yY1NnQmhCWUxnTWJ5dHhZQTlrTGlqZHBj?=
 =?utf-8?B?Nm9MOXFiUXhVbWwzZHpZZUpvNThwWCs3cjBCaWROWUY1WXNOQ2dFZytodVBJ?=
 =?utf-8?B?dWFVeStEbzJmeklBM1lmeXNPemhVWEV4dk05M3diZktQNEE4clNjQzFFL3FL?=
 =?utf-8?B?SitaekJGdHlzKzRLcGRpUVlaYnNtcHJINVVpYXVHbEJwU1BENmRnd0JxSzh3?=
 =?utf-8?B?bzNHKzFsQkZibnlrZURVNkxRYWFvYk1NSUpRZm1IVkZYT2hjR3VFOUNZN1hw?=
 =?utf-8?B?YVI0V1VUa1drRXkrcDRRbHZMTGtxaHROVjlGaURaOGZicVZ3M2RiTmtNMEtV?=
 =?utf-8?B?aHlYamRhTllWWHMyTUVHS3RmQzI5QVo1dFlJeVdtbEN4SGo4WjhSWWIxR3A3?=
 =?utf-8?B?Qjh5RS84VjZIKzQ3R2tsSDFaVis0dkVxekhzWEo2ZnFuOEd1SnZzQ05DQSsv?=
 =?utf-8?B?dGtkVGpVa2puZVR3a2MzSU9tb1YrREpRRzJNTSt4eU10Q2lMNU9raFZ0UWtD?=
 =?utf-8?B?c0ZZamNFU1lSdU83dUUrOWxYakk2UTlUL2J4djRuY2xFTVIza21xaWFDVS8w?=
 =?utf-8?Q?wZOkXMCSgAkCrlpcSiZ/AbyAN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3b1126-d3a5-4b9d-17fa-08ddb2f6d412
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 08:12:14.5682
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jzg4LdD+yiBDaVxIaYclEdTYE5hNJxE5c7J8DRmy4QcFgalxK/gF2jNloZZEgbvJdmEpjUZVAxk5ZTA58/DXEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7185
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKdW5lIDI0LCAyMDI1IDExOjMyIEFNDQo+IA0KPiBPbiA2LzIzLzI1IDE3OjQ5LCBYdSBZ
aWx1biB3cm90ZToNCj4gPiBEZXN0cm95IGlvbW11ZmRfdmRldmljZSh2ZGV2KSBvbiBpb21tdWZk
X2lkZXZpY2UoaWRldikgZGVzdHJveSBzbyB0aGF0DQo+ID4gdmRldiBjYW4ndCBvdXRsaXZlIGlk
ZXYuDQo+ID4NCj4gPiBpb21tdWZkX2RldmljZShpZGV2KSByZXByZXNlbnRzIHRoZSBwaHlzaWNh
bCBkZXZpY2UgYm91bmQgdG8gaW9tbXVmZCwNCj4gPiB3aGlsZSB0aGUgaW9tbXVmZF92ZGV2aWNl
KHZkZXYpIHJlcHJlc2VudHMgdGhlIHZpcnR1YWwgaW5zdGFuY2Ugb2YgdGhlDQo+ID4gcGh5c2lj
YWwgZGV2aWNlIGluIHRoZSBWTS4gVGhlIGxpZmVjeWNsZSBvZiB0aGUgdmRldiBzaG91bGQgbm90
IGJlDQo+ID4gbG9uZ2VyIHRoYW4gaWRldi4gVGhpcyBkb2Vzbid0IGNhdXNlIHJlYWwgcHJvYmxl
bSBvbiBleGlzdGluZyB1c2UgY2FzZXMNCj4gPiBjYXVzZSB2ZGV2IGRvZXNuJ3QgaW1wYWN0IHRo
ZSBwaHlzaWNhbCBkZXZpY2UsIG9ubHkgcHJvdmlkZXMNCj4gPiB2aXJ0dWFsaXphdGlvbiBpbmZv
cm1hdGlvbi4gQnV0IHRvIGV4dGVuZCB2ZGV2IGZvciBDb25maWRlbnRpYWwNCj4gPiBDb21wdXRp
bmcoQ0MpLCB0aGVyZSBhcmUgbmVlZHMgdG8gZG8gc2VjdXJlIGNvbmZpZ3VyYXRpb24gZm9yIHRo
ZSB2ZGV2LA0KPiA+IGUuZy4gVFNNIEJpbmQvVW5iaW5kLiBUaGVzZSBjb25maWd1cmF0aW9ucyBz
aG91bGQgYmUgcm9sbGVkIGJhY2sgb24gaWRldg0KPiA+IGRlc3Ryb3ksIG9yIHRoZSBleHRlcm5h
bCBkcml2ZXIoVkZJTykgZnVuY3Rpb25hbGl0eSBtYXkgYmUgaW1wYWN0Lg0KPiA+DQo+ID4gQnVp
bGRpbmcgdGhlIGFzc29jaWF0aW9uIGJldHdlZW4gaWRldiAmIHZkZXYgcmVxdWlyZXMgdGhlIHR3
byBvYmplY3RzDQo+ID4gcG9pbnRpbmcgZWFjaCBvdGhlciwgYnV0IG5vdCByZWZlcmVuY2luZyBl
YWNoIG90aGVyLg0KPiANCj4gRG9lcyB0aGlzIG1lYW4gZWFjaCBpZGV2aWNlIGNhbiBoYXZlIGF0
IG1vc3QgYSBzaW5nbGUgdmRldmljZT8gSXMgaXQNCj4gcG9zc2libGUgdGhhdCBkaWZmZXJlbnQg
UEFTSURzIG9mIGEgcGh5c2ljYWwgZGV2aWNlIGFyZSBhc3NpZ25lZCB0bw0KPiB1c2Vyc3BhY2Ug
Zm9yIGRpZmZlcmVudCBwdXJwb3Nlcywgc3VjaCB0aGF0IHRoZXJlIGlzIGEgbmVlZCBmb3IgbXVs
dGlwbGUNCj4gdmRldmljZXMgcGVyIGlkZXZpY2U/DQo+IA0KDQpQQVNJRCBpcyBhIHJlc291cmNl
IG9mIHBoeXNpY2FsIGRldmljZS4gSWYgaXQncyByZXBvcnRlZCB0byBhIFZNIHRoZW4NCml0IGJl
Y29tZXMgdGhlIHJlc291cmNlIG9mIHZpcnR1YWwgZGV2aWNlLiAxOjEgYXNzb2NpYXRpb24gbWFr
ZXMNCnNlbnNlIGhlcmUuDQo=
