Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3194F17335E
	for <iommu@lists.linux.dev>; Tue, 15 Oct 2024 08:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728980698; cv=fail; b=sp59YjbiYib5Refax5eqd41EVoM2yuW3j7YjAFcxtzH+meDQ6Sqn+/FOzT1UehCcPFqEl0CgoIg02m1ACdvdNyfTbU0UGipi5l/u9knA7umft/+rEEUlIXJjdfD7yrzoHu8roq3asdbtqqLeWA2xENiGNgyXYncKUKLgYEb6HHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728980698; c=relaxed/simple;
	bh=aLDfr5y92N44HKJD67Aqf/e6ztwMf4BytU/jd+CnEX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L7rE1WtkMm1jEKu+PNSQ14FpmTSCawl99E6LZSnfXnGv7jRJWcrVO+s5/n+k9MWKgL5Ux26EkD3/UoKPCILvuT2MV5k4lwz2Mpuc0uj74fnDOthBPEr17zDVgBrzWt9QuNLxBYtPVV5W8eog2JxygXgd+5v+h7wox0ucLzuMYkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hij2ZUmd; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hij2ZUmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728980697; x=1760516697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aLDfr5y92N44HKJD67Aqf/e6ztwMf4BytU/jd+CnEX4=;
  b=Hij2ZUmdLWu/lFCCHNfm173o5chOv641lbpHmL8gQGjyWU+RxupApWO+
   sb142HZCEtdRF7VJy6RTWa/IhXDA2cpgxH/MXHgIuWw5A+2MjBPQEoWPD
   /Y4BsDKxlVFRsdNChmQUgEhd0b/PDvsNUKgdKDSQamUKGlUOR0xeI3eDr
   ZMwInLo5eed+f6EIV1OUJuj/JJOXJ/SPKJCfoXVynHe0bYipS9dsM5pqR
   5SnhU74jvKdQFyJ+GG1WAbJMjnltHWZx6EMdKLGEsZ0lLeYQV60x6Bxs7
   TV6POFbj3ldwgu8zrNetWesIfV35VL5kJnM4kdfK6v7cdbF4RJJXqmimD
   A==;
X-CSE-ConnectionGUID: OtII3ebPRR6tyK5A96DphA==
X-CSE-MsgGUID: fC99nrUNQLCJcjjoarTaCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="38912866"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="38912866"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2024 01:24:52 -0700
X-CSE-ConnectionGUID: fr0iidGFSoe5FR9BD89RMw==
X-CSE-MsgGUID: sxO7zoXfRruES77nEn4e6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,204,1725346800"; 
   d="scan'208";a="77491871"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Oct 2024 01:24:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 15 Oct 2024 01:24:49 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 15 Oct 2024 01:24:49 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 15 Oct 2024 01:24:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AW/nOsMk3MJk80l/bbGHw5euW/vZX/sAT9Teh6UCvxNrEIcA2m0B1a4pv1egTmUrJRMLr9QASe6KnM/3OvIr9P/D/QSVt+x7kHi8/PALV9Qo/hvdZ5RLs+N+H9cR+QqeUm9PCp/VNxaFwK6p1Lv7FkWcaltAajkAAuIsxIMTsqWg8kuhs0aJ0f7fTc7tDbp/8j3IUtcoPpRVYfCLzFq669zfmW4mLAFXJUFXOqoqkQETbWL2MUTD5UwmPGLfA6So+A9DnFpZq88m+GOqtS3r1YMO3YYh6ejQs7hVCzVSqj77vMtG/tMJ3vzhsdLXVoVlmrTkiQGSj2eD/qS2k0BmTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLDfr5y92N44HKJD67Aqf/e6ztwMf4BytU/jd+CnEX4=;
 b=eCtvnfALhTEjD0ce49yLAUd3KHNZ89DmWW2Z0v0AHC9vDYeOj0CEBtfyCYcXaMvPzsv5DtBEBeAhc8nQvHOA4k5w/gTFtxAWWXOBez3TBmVl+6uJw02XZZfJCyhKCV/J2e50rgV1BjuklbhCUkTYDGyHc5e+HibuD6xOw+qyCCqbXzzLVqUN8Vq2tcwqn6qSTgwtnMiB5fjSrAZTr+MXPceJHkFFn+QEwB+8o3qEO8eskfjiZiIMM/JOlvZh1tTEZ/wC/wNM/Dhcd1+5rscyBLBasegzRjkcWNJx6dsVfA9/QCput74elZc79U6Zi+IcjZ4Ur4QALxYXsOa6Ik2QNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM4PR11MB6096.namprd11.prod.outlook.com (2603:10b6:8:af::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Tue, 15 Oct
 2024 08:24:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8048.020; Tue, 15 Oct 2024
 08:24:44 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>, "Liu, Yi L"
	<yi.l.liu@intel.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>
Subject: RE: [PATCH v2 2/8] iommu: Introduce iommu_paging_domain_alloc_flags()
Thread-Topic: [PATCH v2 2/8] iommu: Introduce
 iommu_paging_domain_alloc_flags()
Thread-Index: AQHbBDRE6u5zVfoyV0SOdUgALEZpF7JTiWgAgDQjU1A=
Date: Tue, 15 Oct 2024 08:24:44 +0000
Message-ID: <BN9PR11MB527639C51F172B6A3C6996EB8C452@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-3-vasant.hegde@amd.com>
 <2e2c18f5-382a-4144-9a78-29e3dfc973c4@linux.intel.com>
In-Reply-To: <2e2c18f5-382a-4144-9a78-29e3dfc973c4@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM4PR11MB6096:EE_
x-ms-office365-filtering-correlation-id: aa88e39d-65d7-4640-f029-08dcecf2d30a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d2NaYXJ0WVc1bTNSS1R1Y00yMGFldlpnYkhnVkp0QVdWSEZYcC9ZTCt2Rmpw?=
 =?utf-8?B?ZWZBS3dsdDhPTHFjcHdlby9yWGVPZkI4eFRNY0h2YU8xM0dINGtuYlYxM09i?=
 =?utf-8?B?ZktldVFkdjNteVcvZE53U3ZudzZPVGZyaDk1TWF3Yi9HbUJqcVg2Z3o5ZytR?=
 =?utf-8?B?cm53YUZ6SHZjY0todTBwTHltZFVMYkZCaHFpQlJqSVFlUEd3dWhMSFRMR2ND?=
 =?utf-8?B?dVliNEVBZkh0T3lDV29yU0tjZzF4T1RVRUVkelhZNUJuNlVaQ2hDQ2drN1VT?=
 =?utf-8?B?Vk45eWJ5cFdVT0NmYlYwUHI2RWRMeDZzaFNlZHRRQVhJY0NsN3NNaTRPWUFv?=
 =?utf-8?B?N28xbm9aWmRWTGh2UkUyZlpkNVRRQkNsWEdlK2J2YjVlU1hpZnkrT2c4REQ2?=
 =?utf-8?B?SWlTVHc4L25QWS9aT1lRSjljQXo0Rm5YSy9MU3ZzSWdjOVlJR3M2bzVQRUZG?=
 =?utf-8?B?QU9qRjFyZEo0TDFWU2VMMXNVVXd3MHFhd2g1Z2trSm10WGdpcUJOSm5GZDlR?=
 =?utf-8?B?S29BVTVXYjNUK0VrSFpKMHFvQ3RJV3k4SlN6YmtqR3NaMnlDd3lhanNxb0FC?=
 =?utf-8?B?bTkvU0t0bmo2M051K29aWWRlN1hnTXZEY2FIT3ZIdE9pbjJMbXNQSktyQ1FU?=
 =?utf-8?B?Qlo1VzFxVU5JNm8xa2RTQlZWY01GY1NRZDA5aTVWQzExOUF3L3cwa0VtWVpz?=
 =?utf-8?B?VXgyN3VZeUM4bHloWk9JaGp6aTdTbVBicS9pZ0pzdnlSQVprR1BMVHRxMnZX?=
 =?utf-8?B?T0tjL21EVklZU3owUWI1S3VQell0eFI2Tmx5VVhqbjVqM3AyL1RHdzg5dHVh?=
 =?utf-8?B?SitrV2ZzcUFweXlIbDlyWDhDdHUrM2JQNjlUOUtYOXJldmtxazIzWWk5QVcv?=
 =?utf-8?B?OGQzaUtGQ05xK1dSakIvM1NNZS9XVjEveDlhb1c4VTJMQlJaM0R2UERWMXBG?=
 =?utf-8?B?TjlTdGsrZTlUcmtKYzhmRjc3RTFGOUEyYlVnb1EvVmlLOUMzcjVKVVpMWnJD?=
 =?utf-8?B?YkdyVkc2ZlVLQ2dPYkFPQTVnTFd4RXl6d3dKL1hlUmp4L1VmWnVoeUUzWlZC?=
 =?utf-8?B?bGJLL3hmSWlmWktCcy9nVi92UTZZeTliZ1dvVlQ3Tzd2bFZ4cS9vdWhPcmFL?=
 =?utf-8?B?bExyenMvdld0czZxVzdWTEF6L24vanBuTkZBU1RTZWpiblNnYmlUdDNYVE9l?=
 =?utf-8?B?UzIxcVR3aGFBNi9zNDdXWnFWTVZmNXpWV0RqNi9KNHU4bS8zVkYyZFp3RTIy?=
 =?utf-8?B?QndhaGo4WGpiUTEyMFlrSitBcEZxdFhDanJieElsa01LWVFPc2Joano3MHlB?=
 =?utf-8?B?VFZQdmJ5d2FHMjJXV2FXQ1NjL2dZbUN0VVBWQ01GWFVmS0pTT3djVE0xNjBy?=
 =?utf-8?B?bG94RUxmM2pZVE11NzlrU3dXQWh3b3YyNW82L1B6LzJTczVnOGJlR2lCN3NR?=
 =?utf-8?B?UTJhdnlId2pBZDZkaUdVejZhTXp1dUdXL0hLUUU3WWtBL0xXdkNHS0JpSExY?=
 =?utf-8?B?SHZmOVRKSXgxN00xYU5XZjJxOFArSXlqTFZ4UWQ1by9SeUh6Yktma0drUGN5?=
 =?utf-8?B?TDZ1czJBMW0xeit2WUlvMXJNSWhtTlhsZjR4UDdvOFFnYmJoUmxZb0VZNHBQ?=
 =?utf-8?B?ZCsySVhseC9wdDVvUFVwVFdZVkF3WXhVc1BSMUNYLzRobmNSUEQ1a0pvZUhW?=
 =?utf-8?B?M2F2Rm5pV0dQRnpURkZManNZQTVPYmtQdEdrdGxZMno3UU52RFhuVm55WHBq?=
 =?utf-8?B?VXpla1BEd05NbmZCTGFQL0hiYjNyZmRPSmdzZzkxdTM2UnpDeEtHd1JZVG9P?=
 =?utf-8?B?cEl6Rk9KeWp2QUd6VTNiUT09?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzRkSjAxaVp3Z2xaeGViaEdRWWdpZ1doVGJDZjZzVWlSamh5V2t0NS9pWUFw?=
 =?utf-8?B?N0ZVdlZMcWJLMXZ6UzV1bWxIc3JFNURqaFEwMEhGelVtTHFuMzFiZ1JwSE9Z?=
 =?utf-8?B?aFVBNXJLb0NUR3ZYVG05eGEzL1VDcWJwNFJtSFExM3FJbGNORW1MWTRrRUh5?=
 =?utf-8?B?eXQzZkc4VG94QWlyRjJ4YTkwQUhJMzk4VnBTN2VhbjgvSzhJaU5PTkw0ZSs5?=
 =?utf-8?B?WlVlNDdrOTdCeTJyTWlzZko3bDBqZUdid0xIUU9NSUdaanJZVmYycmZSZkV6?=
 =?utf-8?B?YzZSbndNZGpCOGszbnUrSURwalp3YUV0NERPcDkyQUFuRkF0OHQ1SjY4NW5x?=
 =?utf-8?B?cndNRDhXNUxlNm5yMCtKcTFKaDVCYXdDN2wxbnNoZGNlYmdvWlNoUVVIaVBD?=
 =?utf-8?B?ZnhScHlKRURtSi95dzZvVnVlWkF5eDBGbFZZYkNBNFYyV0ZwRlp4MUlsdUdl?=
 =?utf-8?B?MWVxSXpYb2FuL280QWE3K0wxcEhTbGtUSHVLeTc2cjhxRVorOWFOZzg0WTdx?=
 =?utf-8?B?bTJpMXIzeFQvZi9PWjgwZHd1WXFZRzZDNGpvV21hYnJ6OGJIOWZqbnVmb3RW?=
 =?utf-8?B?aHdEU09BRTNJLzJ3Rm45Qmh4TFFCbUgxVjBmV3hXYnJDR1VycmMvdWEzSUQz?=
 =?utf-8?B?OGU3NDBuZDAvZW5QWFlmVkV0Vm9ZbEZ6Z2RWYnJLeElWdGV2bDFQdFUxV3g2?=
 =?utf-8?B?Y0JEczNZMDJSQnphSnZ1SjVlSEUxczVvdnVJOHVNWmRMcHpEbXdlR2Zmd3Yz?=
 =?utf-8?B?M0ppaEp0OGo0aGtaUTFhWTF3YVo1YzNEOFBmdEMra3N4V2tjRG1HT0JJa2hE?=
 =?utf-8?B?M09LUmRpd1ZEaEhMREVOeWRneHJubkhOQjVYSHJlSGdNd0kvWHJYOFBUWDBr?=
 =?utf-8?B?ZDJsNDNUN2RQWE5DaXdmVytva1ZUcnFJeUk1YVlTUElCYTdNd0VlQWw1d1p6?=
 =?utf-8?B?M05ML3A0VUZGSjB6V3Z6WGZyQS96cEhwbjVmcWpxcGNremFTM0RkQU1uWmVU?=
 =?utf-8?B?OUhKOTJXdlpLMFM5T24yQm1ZZURtMFlyK0VqUitqMDhpaXRTZHF1Yldqczhq?=
 =?utf-8?B?TGkyaE51clRoY0lWUExqTko4TkRyRnNKaTZjNno0eU9zSmZUZ3NiUzYxWS90?=
 =?utf-8?B?eHhhS3VGR0ZzWXZEM1NWTXdsR0J6Nng0bWVxN2l4dUJGWDYwQlN0Z2FrQzB5?=
 =?utf-8?B?MW80bVRIQVdqQ3NMYXhWa3RKTHJNTHFJWTgzeVhvaWkvN1hxdmpyOFNncWV2?=
 =?utf-8?B?dVNsT3BEanhhbFhUZVk5UHdiT2thMGZPdklzOTBlTm5wTjZ5Tm5CRUtiUm9Y?=
 =?utf-8?B?dFBzUnhubGNoUEpWVXIxZzhncGFXcnMwMUdkMkh2d3l0RXZxcWd6UElFazZL?=
 =?utf-8?B?eDMydWlHVzFMQU1jMENDdTJVNitNTXk2OGpNSWlUR0lFUVdydUt6VFp1RHVi?=
 =?utf-8?B?cDBpWjE4V2NGcVZmWWRSMzRQeThqQXdQcmloM0F6MU1jMGdkRVp6MWhJQ21G?=
 =?utf-8?B?dE9TZGw1US92djMrSlJCZlh5MW11VVk1S3pZaFFwTEJuSk1CZFplMFlnU2hq?=
 =?utf-8?B?Yzdoa2s4aEZ3TTMwUHdadVlTYWZXUHByQ2pTdVhPSGltbUNGTll6TlZSWHhP?=
 =?utf-8?B?bzFhUmVVK2Irc3dmbHY3REFYdkx6Z0hyTTNyc2RNY0wzYUVxeWtKMFJ3OUV2?=
 =?utf-8?B?Y2ZybFZyWmJsT3dZYmJKeEJhNFpLeDByekFnU2Q5VVBmYysvclNoQlBVK1hW?=
 =?utf-8?B?UUpzOWhuTGRCNzhobHIxZExQMDNCRHNWSWdzNHFmUHJwd3dCZTZ0VWp1aHRu?=
 =?utf-8?B?SGxLamhEMCswZEpqL09VSzVPYWhZbm1tMmhCcGJBeWxWbjMzZEttYitKR25y?=
 =?utf-8?B?MnRCYmhkVmZib3BsdHRKRzFLTnliYWFwYU1xcndiVnZwaHVsNkovdnl1RURR?=
 =?utf-8?B?UkpEVk9SNlFjR3ROUFRqL2tSTUJYMEhUR1VJc1VTeDUwOTA1NnU4QVpJTUg0?=
 =?utf-8?B?VGNmZCtkcnZkNEpDU213QWFDUlhZak0wWHJTc094TlE1UlFzVzM1Y0pBck5K?=
 =?utf-8?B?ZU1VMUNHR2ZKS1hUbmE5Zy9kQ3ZTMlNweC8zVVM4a09sK1hTU3FTY2xzcnNu?=
 =?utf-8?Q?4hgjMEJNkACqymOFRiyJo2V3f?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa88e39d-65d7-4640-f029-08dcecf2d30a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2024 08:24:44.6119
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0EWkumbRqwbbFIOZ5LVW8ZZm7oPlrM2MlxhHpNPFhfAxCX3ESYzGvq3DWdy/zd4rMaOZhXBXgEX9hZHF7BxE8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6096
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgU2VwdGVtYmVyIDEyLCAyMDI0IDEyOjA1IFBNDQo+IA0KPiBPbiA5LzExLzI0IDY6MTkg
UE0sIFZhc2FudCBIZWdkZSB3cm90ZToNCj4gPiAgIC8qKg0KPiA+IC0gKiBpb21tdV9wYWdpbmdf
ZG9tYWluX2FsbG9jKCkgLSBBbGxvY2F0ZSBhIHBhZ2luZyBkb21haW4NCj4gPiArICogaW9tbXVf
cGFnaW5nX2RvbWFpbl9hbGxvY19mbGFncygpIC0gQWxsb2NhdGUgYSBwYWdpbmcgZG9tYWluDQo+
ID4gICAgKiBAZGV2OiBkZXZpY2UgZm9yIHdoaWNoIHRoZSBkb21haW4gaXMgYWxsb2NhdGVkDQo+
ID4gKyAqIEBmbGFnczogQml0bWFwIG9mIGlvbW11ZmRfaHdwdF9hbGxvY19mbGFncw0KPiA+ICAg
ICoNCj4gPiAgICAqIEFsbG9jYXRlIGEgcGFnaW5nIGRvbWFpbiB3aGljaCB3aWxsIGJlIG1hbmFn
ZWQgYnkgYSBrZXJuZWwgZHJpdmVyLg0KPiBSZXR1cm4NCj4gPiAgICAqIGFsbG9jYXRlZCBkb21h
aW4gaWYgc3VjY2Vzc2Z1bCwgb3IgYSBFUlIgcG9pbnRlciBmb3IgZmFpbHVyZS4NCj4gPiAgICAq
Lw0KPiA+IC1zdHJ1Y3QgaW9tbXVfZG9tYWluICppb21tdV9wYWdpbmdfZG9tYWluX2FsbG9jKHN0
cnVjdCBkZXZpY2UgKmRldikNCj4gPiArc3RydWN0IGlvbW11X2RvbWFpbiAqaW9tbXVfcGFnaW5n
X2RvbWFpbl9hbGxvY19mbGFncyhzdHJ1Y3QgZGV2aWNlDQo+ICpkZXYsDQo+ID4gKwkJCQkJCSAg
ICAgdW5zaWduZWQgaW50IGZsYWdzKQ0KPiA+ICAgew0KPiA+ICsJY29uc3Qgc3RydWN0IGlvbW11
X29wcyAqb3BzOw0KPiA+ICsJc3RydWN0IGlvbW11X2RvbWFpbiAqZG9tYWluOw0KPiA+ICsNCj4g
PiAgIAlpZiAoIWRldl9oYXNfaW9tbXUoZGV2KSkNCj4gPiAgIAkJcmV0dXJuIEVSUl9QVFIoLUVO
T0RFVik7DQo+ID4NCj4gPiAtCXJldHVybiBfX2lvbW11X2RvbWFpbl9hbGxvYyhkZXZfaW9tbXVf
b3BzKGRldiksIGRldiwNCj4gSU9NTVVfRE9NQUlOX1VOTUFOQUdFRCk7DQo+ID4gKwlvcHMgPSBk
ZXZfaW9tbXVfb3BzKGRldik7DQo+ID4gKw0KPiA+ICsJaWYgKG9wcy0+ZG9tYWluX2FsbG9jX3Bh
Z2luZyAmJiAhZmxhZ3MpDQo+ID4gKwkJZG9tYWluID0gb3BzLT5kb21haW5fYWxsb2NfcGFnaW5n
KGRldik7DQo+ID4gKwllbHNlIGlmIChvcHMtPmRvbWFpbl9hbGxvY191c2VyKQ0KPiA+ICsJCWRv
bWFpbiA9IG9wcy0+ZG9tYWluX2FsbG9jX3VzZXIoZGV2LCBmbGFncywgTlVMTCwgTlVMTCk7DQo+
ID4gKwllbHNlIGlmIChvcHMtPmRvbWFpbl9hbGxvYyAmJiAhZmxhZ3MpDQo+ID4gKwkJZG9tYWlu
ID0gb3BzLQ0KPiA+ZG9tYWluX2FsbG9jKElPTU1VX0RPTUFJTl9VTk1BTkFHRUQpOw0KPiA+ICsJ
ZWxzZQ0KPiA+ICsJCXJldHVybiBFUlJfUFRSKC1FT1BOT1RTVVBQKTsNCj4gDQo+IEhvdyBhYm91
dA0KPiANCj4gCWlmIChmbGFncykgew0KPiAJCWlmICghb3BzLT5kb21haW5fYWxsb2NfdXNlcikN
Cj4gCQkJcmV0dXJuIEVSUl9QVFIoLUVPUE5PVFNVUFApOw0KPiAJCWRvbWFpbiA9IG9wcy0+ZG9t
YWluX2FsbG9jX3VzZXIoZGV2LCBmbGFncywgTlVMTCwgTlVMTCk7DQo+IAl9IGVsc2UgaWYgKG9w
cy0+ZG9tYWluX2FsbG9jX3BhZ2luZykgew0KPiAJCWRvbWFpbiA9IG9wcy0+ZG9tYWluX2FsbG9j
X3BhZ2luZyhkZXYpOw0KPiAJfSBlbHNlIGlmIChvcHMtPmRvbWFpbl9hbGxvYykgew0KPiAJCWRv
bWFpbiA9IG9wcy0NCj4gPmRvbWFpbl9hbGxvYyhJT01NVV9ET01BSU5fVU5NQU5BR0VEKTsNCj4g
CX0gZWxzZSB7DQo+IAkJcmV0dXJuIEVSUl9QVFIoLUVPUE5PVFNVUFApOw0KPiAJfQ0KPiANCg0K
VGhlcmUgaXMgc2xpZ2h0IHNlbWFudGljcyBkaWZmZXJlbmNlLg0KDQpPcmlnaW5hbCBjb2RlIHBp
Y2tzIGRvbWFpbl9hbGxvY191c2VyKCkgaWYgIWRvbWFpbl9hbGxvY19wYWdpbmcNCmFuZCAhZmxh
Z3MuDQoNCmJ1dCB5b3VyIGNvZGUgd2lsbCBwaWNrIGRvbWFpbl9hbGxvYygpLg0KDQpCYXNlZCBv
biBkaXNjdXNzaW9ucyBpbiB0aGlzIHRocmVhZCBkb21haW5fYWxsb2NfdXNlci9leHQgaXMgdGhl
DQpwcmVmZXJyZWQgb25lLiBUaGVuIGJlbG93IGlzIHRoZSByaWdodCBvcmRlcj8NCg0KCUlmIChv
cHMtPmRvbWFpbl9hbGxvY191c2VyKSB7DQoJCWRvbWFpbiA9IG9wcy0+ZG9tYWluX2FsbG9jX3Vz
ZXIoZGV2LCBmbGFncywgTlVMTCwgTlVMTCk7DQoJfSBlbHNlIGlmIChmbGFncykgew0KCQlyZXR1
cm4gRVJSX1BUUigtRU9QTk9UU1VQUCk7DQoJfSBlbHNlIGlmIChvcHMtPmRvbWFpbl9hbGxvY19w
YWdpbmcpIHsNCgkJZG9tYWluID0gb3BzLT5kb21haW5fYWxsb2NfcGFnaW5nKGRldik7DQogCX0g
ZWxzZSBpZiAob3BzLT5kb21haW5fYWxsb2MpIHsNCiAJCWRvbWFpbiA9IG9wcy0+ZG9tYWluX2Fs
bG9jKElPTU1VX0RPTUFJTl9VTk1BTkFHRUQpOw0KIAl9IGVsc2Ugew0KIAkJcmV0dXJuIEVSUl9Q
VFIoLUVPUE5PVFNVUFApOw0KIAl9DQo=
