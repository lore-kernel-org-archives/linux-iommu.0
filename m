Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EFE157A46
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 07:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736493741; cv=fail; b=Bzvt/LpYGXRJIMnKd6Nw79pf0eE1nLN+O/8FPfooQoqIgg433hV2N2Bphw2284eFwujRxc53DyDymBt0VzQ2qxZHy6Gn35nON7dl+d4Erl6CEqo30enu+HVrj3ZJUR1TzEbe1X/1KQh+yF5ovReBbr2l/7gZpOp+qNnaoiCjo2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736493741; c=relaxed/simple;
	bh=P8CAIu5Gu95vQGbZt/1WjMi5izHPgqhIypy8tdEgetA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zz2iVq+j6R7g2CwIblSP0gxYzJgVG1LCIc69MOUc3fhot/pgZOEn/+iEPU/GyORziy+dNLYWx0evdLucCHOMkN+jV6r/oG7ipsz42D0IFXGX9XlmGbkjthGvfCYdAeoDiSoeJiDI+XnkPqT68efdWbtu9txFNi19zqDPoV2RZxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LJrQVc8B; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LJrQVc8B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736493740; x=1768029740;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P8CAIu5Gu95vQGbZt/1WjMi5izHPgqhIypy8tdEgetA=;
  b=LJrQVc8BUTd3TMpMgQYY++ipepg1OnW51DHsvYUomugqAvLjJlWM95G9
   sX6QGYMrWBt7CQLIA7UYDHrreo4UwMwjmSoYWt3remWsYOXgIZqB6Q3Au
   5wPTY6+yBUSfLq2ZaDCJZYQV6zxl/Vsf5MYX+uGgk4bcdX/ySSM7+YKuE
   Dg5v0wTP/Z1DrvYXg1CbFyGx2IjEgKUIdYW1yiAv+0Lwi+Z7IDWFUP98h
   MxI99+akTTtfpsQItlJOdetlJUz95UrBd6tLTyBxX2cCmvkH80OjyDaTb
   6c3CedPXk8OcQJ9aUvx3+uxetlCUKUF/bRxXoypl1DzLLXVkfeIniALqH
   w==;
X-CSE-ConnectionGUID: +QP+mkYkRsa5qts55htlcw==
X-CSE-MsgGUID: mBjw8BN7S+G3NfvrAIkoDQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36804453"
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="36804453"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 23:22:19 -0800
X-CSE-ConnectionGUID: AD+vX3kSR6aSju0+iPAOlw==
X-CSE-MsgGUID: bUR33rYHSbS4wCDIxpl+/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,303,1728975600"; 
   d="scan'208";a="103708848"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 23:22:20 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 23:22:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 23:22:18 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 23:22:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SUiZ0zNqvzBCYuRNwk4uEga2A3tw6ZjQA6t5QEcVf5AbttcvQKdrJzZQUDP+DrmLCFPqtvskP9sq17td6Ee/9tTBUbXtA9aoiaJqHNj3ElTxA26YZIsb378GwKR9g5bgCpTLLYJ8qAGdmS6Hkx0QXhZzTtRaoDhfXuOJWywWQXiqERnBubhYQLMR+z+iSON3DPMySEkEqA2V7qtA9gIxZTitbOcOXoEAd9pKFglsQrh5zXLNRCDj6p8YoN9pMFrShnWQrhQZNOvEnFkEWwt+0BLhTP017xWgooi/ylpT1DAaC6rFUqvm1XuJb6utArO9VdigRhzrt1SRUHBg0NIicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8CAIu5Gu95vQGbZt/1WjMi5izHPgqhIypy8tdEgetA=;
 b=sn7PhTYbTCo5iFmx6KDcmdEj62IbhgYQ3bqyYltB12M1Qi/tCvG4tf6WEJve7ajE7J9DuAsjVKSpGQQddkzJWA+qj8ZyDMZ6Tao/p1XalfoOos1EDKdCgR0XuVdM4sSajOoiRIcZt16eBOJguqEp07nmUHG6PBDjs2vkHHH5TFgExYQX4jZm1poB64bhKdR3rgW62JrYgmFv7bf58KpUB9Faihc0DCNKc5MyKbXvj5VHSTlwHEn0IMfIqrDt5uvEgGQ2Iz4u+vWnn+WixXdJzdaGn837EKxrCwixJD06rDBgLbbvf2mM2mqZI1Z6YucpWfztzfsLWoNOMOCqwKmTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN6PR11MB8196.namprd11.prod.outlook.com (2603:10b6:208:47b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 07:21:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Fri, 10 Jan 2025
 07:21:44 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Thread-Topic: [PATCH v6 01/14] iommu: Introduce a replace API for device pasid
Thread-Index: AQHbUhnUNnXzHh2m/02CvPrIPwhbUrMOJdsggAAC+4CAAHyXgIAAxfcAgABQIiA=
Date: Fri, 10 Jan 2025 07:21:44 +0000
Message-ID: <BN9PR11MB5276B732FCEFCB6254A9745E8C1C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-2-yi.l.liu@intel.com>
 <BN9PR11MB527699DB033F2B192DC120EE8C132@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250109144315.GY5556@nvidia.com>
 <2ab7fb0e-0351-4b2d-861a-da6f72138778@linux.intel.com>
In-Reply-To: <2ab7fb0e-0351-4b2d-861a-da6f72138778@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN6PR11MB8196:EE_
x-ms-office365-filtering-correlation-id: 462b5629-97ac-4d2a-7b5d-08dd31476f9d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Y2Q4NmhmRFZZb1BCWUR0ejdINnp3TnZjSldpd2cvM1krK0pHSG1XZkxBMVpi?=
 =?utf-8?B?VTZIWXhxWnJrdTNhdkY3MDlSQWZka2xPWUZNSEo0dFVVckFvbzYyWXlXOG9K?=
 =?utf-8?B?QXg4cXQ3cTZsRjBIaWJmR2VnN2s0em1WbmZGY0YrQWo2RHc3Q1EyejlmbzN5?=
 =?utf-8?B?NnFTTW0vNGNhYnhmN0JGbUtadktaeHRRMi9Gb3lNSlFqQm1Xc2RHdEdPV29S?=
 =?utf-8?B?dXZkM1BzT0JlUXNvRWtJN3dCR1RKWUIzbitOa2lycWlRaGE2dGZkdFhwekN5?=
 =?utf-8?B?eGxXYkdEV1ZIcUkySVlqaXN5TjhFWGZ4QWIyUVZ3MHJHZVI0WTZ5cDRnUlgz?=
 =?utf-8?B?M1d6Zmd2YXUxN25IWmI5a09IbnlrUk9xM3BjR3hMOU41S2JuSDMwU0IzRVUv?=
 =?utf-8?B?d1NrZzQ2Yk5SVzhiUm9vZVptWWRVanhueDcvandramZjblVIa3ZtTlZueXZC?=
 =?utf-8?B?a2JXMUpRaUNFK09VN25TUmc3OFNZc2hpOGcxSlpKTnp1L3hVSmpTTEZoWGlk?=
 =?utf-8?B?KzFhRklBUXd3Ums0Ylp4dFhPUjVVNi9IRCsrN1ZaNHpiMFFjbnBCWlFrSi9s?=
 =?utf-8?B?N05CS3lnRkE5V0lCV0w0bUZpVTFTUnovTUxLNlg1dklMVUd1M3RVVzhUSGda?=
 =?utf-8?B?VGFCN1doQVZva0ZYRTREMXZnSjJSQmZDWW1tTWRPcXFFZ1M3L09BL3lQdEYx?=
 =?utf-8?B?WXREcXVTclRSR3lxNUUxZnh1WHBJRzN0UjYrTlVSVDRDaGo4SVkzMHhGem5W?=
 =?utf-8?B?bGZOZ1o3bGVpMkJxRDdqKzR3QWJOeFVIVDh3cE10SHR0TU5yMSs4STdxWElK?=
 =?utf-8?B?MmJXdEloRFM4VEJzeDV0RFcvVFNHQ29BOWRJY3NCQWdUYXN6bXBTU3MzTkx3?=
 =?utf-8?B?UkhLZnNLbFZyVWNKall2SjFWOTY4NEhIRURsb3Q0RXpqNSt5cFpENjNXWW5x?=
 =?utf-8?B?VmlocUozRWIwellKTmVPRmN0QXZBakdyK1JJRU55allkM3Q1NFFUTkhrVlBY?=
 =?utf-8?B?ck43SUNILzVOK2RxbFFYekFBZjlPYitUbVNvQStzZWZpNW1sM1c3Zk85NWdG?=
 =?utf-8?B?SVZXZUZ5T2gzS21LRHlEZ3dKVEkvK0hGN3VpV1hoMzF5VnE5dG4vNlNCMFdV?=
 =?utf-8?B?My9wdGQwU0hyYzR4TTlGY0RXa0hoaHZKNXZWYjBrVUJHWWtRN3d5QlIvdnlN?=
 =?utf-8?B?LytkVTVrVWt1RzRzVHU3Slh5TkVidmVhOGdoVk45RG5XSHNQVi9PRXlrQllU?=
 =?utf-8?B?d3ZHeUZSeHMvOUcyOW43RzFZQVdGajZRSDJra2ZOcGNiTFhHZGZnREJJOGl0?=
 =?utf-8?B?ZUcwRlNhdTNjYjBPOVpXbUY5dDRUbUgzZmxEa2ZDaWZCeVFXQjZmZFNvUW1s?=
 =?utf-8?B?U25xUXZRNGdEYm1ua21YSXpITkt0S0tkTVIzM081M3FINjdRRC9sb2d1bVhG?=
 =?utf-8?B?aEJ1L1JyV1J6bVNvaDd6b3NIRXExYmFGQzZOaFVOdDJaa2ZtMklXRnlOY3Fz?=
 =?utf-8?B?eDQ4QVBqT0R0MG85b1BHOWxLUDdsR2hXa0xrSVE2UE1acWRFOGt2dzhsbDdG?=
 =?utf-8?B?TjI3RXVuTFBVdVZVRzVwV3lKdk94SjUxVGFaaExRcWxGT1pRbTV2dUV1Nmk0?=
 =?utf-8?B?eHgvOW1vQ3RMQytoQkZFRHFmcjU5SERVOTRpT01tYzZLblBaUVJmOFR3TlY5?=
 =?utf-8?B?SEEvRmJtRjNCdWphUDRmQXZiNnRDRFhyc0dGaU9saGZNWlViR21xeG94WlFh?=
 =?utf-8?B?WnRqNTJkblpCMlpqUC9VUFpVUDFsUHFWS21jZmR4R1FDekdNQ1FUazZraG16?=
 =?utf-8?B?aDdRK0xJV2l1bEJINi8vQ1hKL2EyNy9rTzhWNEZLUWFQNHl4U2ZYbUVUN0lU?=
 =?utf-8?B?VjU4RFJSeDZnTTNKN1hveXFiUmtKSkpFMEtlM21vQzhlK2lGdGVhZkd6VHI2?=
 =?utf-8?Q?u6pI1yt+fUq0x1bEGyg5yjjWh3w3ypuW?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTRMdWt5V3F3NXRpbWY0ZXFFYU9TWUZKUnU5eDBGWEpRdEN5UzQ1MlErRkJK?=
 =?utf-8?B?bGx6OWNPMjRsTUJxV05iYWdRTTZQTDR6VnpST0QyZDlkOW9rQStEY09BeTJz?=
 =?utf-8?B?VStaaGpBdWxNRndVcXVzSEo4T2ZMMnBCK0U4TVZEbXZmUkRPdk5kQ2dhMUZy?=
 =?utf-8?B?aDBrOHo3V1dleTR0MENpVlc4Z0J1dlhTbEdYZVJRMTV1TDdqOFhheXAvQWUv?=
 =?utf-8?B?UXBPbHRGaU16NGNlNDE3NEY1SmdScjArNjJhcWs1UGpkdWVtSVA5V3dHRXA5?=
 =?utf-8?B?VGNMOXhkWEZ6VkJRNE0xTDN4ZE90OXZiS0tzRjlBSVBjTk1MdTJPQjE1Z2Jl?=
 =?utf-8?B?dDdnNTFtSjExeXZ5bjJoaWs3N2pSZDRNSzNZVFJZVmNPYVAyWnQ0UzBrRGFI?=
 =?utf-8?B?T3hERHlpYVpUNHVlQ0VWb0M2eENLcDBoNmowY1RHckl4Ykh0RnVXNEZGMlBC?=
 =?utf-8?B?Y0hnSG1obFdLSHVHd0EvQ0F2c0JOVEsrUGFHVlZ4VmQ1ZWVZaEhSOTZoTFky?=
 =?utf-8?B?V0Jud0tIaFkxZWNybnV4a3FXT3YwQ29SNkNkbUNWWmVYS0NUZEtVUGhpc0VC?=
 =?utf-8?B?MVhYZlBIYzZGRi9RcGxzdmlnZ0N4Y1NSaHhoWUQ0LzBaSDFGYXJGTHhEZGZV?=
 =?utf-8?B?aTRLRHlnWi9iem0vTG5jRjkxaTJZczBkb3B2b3ZFMDF1V2laMnF1TmtNOE1i?=
 =?utf-8?B?WlA1eVlKd0hFTDFVRjJCSzhGbE9IY3pLOFllTStiQlp2elhjN3lJTWFtS1ht?=
 =?utf-8?B?RkcvbjNTS0NubjhTMC9xQVpISzBIZXVqY2UvOTRtaWhsYmM3M2NHNlh4cURy?=
 =?utf-8?B?UUQyaUNFUi9RbVhlYWFTQU1mWkZtNDBmWkxoaDU4U1lDcjJ3KzE1Y3VReTBv?=
 =?utf-8?B?YnpqcFRCV2owZUk3TXdHQTR3SGJSUVlCRW5VeTZQTzFkM2FqSnpydFk2ektI?=
 =?utf-8?B?Vm5qV3A2VHgyY1lIaHROejZrYkdCZzlpb0FzTnFQWnJzSmFiNEtFU2tYUFMv?=
 =?utf-8?B?WjRwbFBjRzVSRGh3NFN6NjJqMC9aZ3ZnVVRVNXBVZmk4VU9PYVFGZUlUSjdm?=
 =?utf-8?B?alRqWklnRFVYZ0xDS0RHSEJYbUZybUR3YnE4cWVSOHFwSDhmZzBnakt6cW1P?=
 =?utf-8?B?RVVpMit3V0piVHZRMTgwOGFnUHd2NnpEVzBRRmtkU0cyditnOVlCMmRDamhv?=
 =?utf-8?B?ajA4SEllZ0MxUERYSmJQak9NWUZSME5xZU43c0RLMktaU0pXbjB2T0RQcHE1?=
 =?utf-8?B?aHBEQUdxMGVnWGw2RUFqVzdnS25waFpXWmVDa1BEOW9SVldRdlI0L1k0Zy9Z?=
 =?utf-8?B?V09uSXhRUkNiWWpENUxWWUFwSVB1VnlHRzFEcDNwT1JsVlpDRU54WW95L0NU?=
 =?utf-8?B?Y0xiQ1ltMFd5aDh4UXZaTWhqMFVIL1A4amZqWjZjU0h6anFQM3NpUU9WbDNn?=
 =?utf-8?B?Q01jMjJlVGxTbi93OXl4VlhiUkJVSjdjSVlnVENzY3pvR3RYRHY2SmxQR1lq?=
 =?utf-8?B?ZURENWVLeUR1REFiRDM5S1gyd0tUNkZnVll6UU5lT0I3ZVBZTGxjUytQWHRL?=
 =?utf-8?B?MHVCQkM2MGFOY1paaUV4T1dLMXJnZmMzMFlUTzlxNkZ0aWhVdFB2dFJ4RTNZ?=
 =?utf-8?B?cW1UcE5mcnJFQVkxcWMyTWxTQk1aZDU1cUlneVNHTllDcEhHOHVyT3pqcytD?=
 =?utf-8?B?dkx3eWJUN1hKVnhnTVlrSWxqeUdJREt6VXY0U0xZbHlxcTNhcXBIVkNBazJ3?=
 =?utf-8?B?cjZSemhTVDdRS1g2dWpUUXhoelFmNmQ5S2c0c3hPUWpOT2FKOFFUN3VlWGhK?=
 =?utf-8?B?dUpRRTFUSGxUTTFiSFd6SkN3QjVRODV4WlB4NDVpSlB1K1FRNzlzcGpMRXdq?=
 =?utf-8?B?blMzYUpaSnZLUW1qK3FIQ29TVlIwUGdtanRBeWptbTJ0Z09xcVJlZmwyaXpJ?=
 =?utf-8?B?dGo5anlUcWpnZUxlcHh3dDBHN3lkSm5YY2tQNlJLTmEwVWVxc291UnQ5cFJB?=
 =?utf-8?B?aU14MTg1THdZY0JzVDJ2QzRiYXpzT3FzMmpHWlhZVUVpVXR4OFhLZU4vQzFZ?=
 =?utf-8?B?NHVubHRCMGVsUnRlcFN3YmNIMGpJdGFOKytBSzlPaWp0RmRnc01nY05qYnhy?=
 =?utf-8?Q?I4rUTZIXxpc2/xQD5fIPmPcOy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 462b5629-97ac-4d2a-7b5d-08dd31476f9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2025 07:21:44.1491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LBFTIqVgYtb/Z1NtdREbH+F5ZfZJWVjISDFG+0+U6qcYssFpP7DyUR/rwNgBK8PODd/h0YWS3kbArPMVigP7yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR11MB8196
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIEphbnVhcnkgMTAsIDIwMjUgMTA6MzIgQU0NCj4gDQo+IE9uIDEvOS8yNSAyMjo0MywgSmFz
b24gR3VudGhvcnBlIHdyb3RlOg0KPiA+IE9uIFRodSwgSmFuIDA5LCAyMDI1IGF0IDA3OjIwOjAx
QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+Pj4gRnJvbTogVGlhbiwgS2V2aW4NCj4g
Pj4+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDksIDIwMjUgMzowOCBQTQ0KPiA+Pj4NCj4gPj4+
PiBGcm9tOiBMaXUsIFlpIEw8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+Pj4+IFNlbnQ6IFRodXJz
ZGF5LCBEZWNlbWJlciAxOSwgMjAyNCA5OjI4IFBNDQo+ID4+Pj4NCj4gPj4+PiArLyoqDQo+ID4+
Pj4gKyAqIGlvbW11X3JlcGxhY2VfZGV2aWNlX3Bhc2lkIC0gUmVwbGFjZSB0aGUgZG9tYWluIHRo
YXQgYSBwYXNpZCBpcw0KPiA+Pj4+IGF0dGFjaGVkIHRvDQo+ID4+Pj4gKyAqIEBkb21haW46IHRo
ZSBuZXcgaW9tbXUgZG9tYWluDQo+ID4+Pj4gKyAqIEBkZXY6IHRoZSBhdHRhY2hlZCBkZXZpY2Uu
DQo+ID4+Pj4gKyAqIEBwYXNpZDogdGhlIHBhc2lkIG9mIHRoZSBkZXZpY2UuDQo+ID4+Pj4gKyAq
IEBoYW5kbGU6IHRoZSBhdHRhY2ggaGFuZGxlLg0KPiA+Pj4+ICsgKg0KPiA+Pj4+ICsgKiBUaGlz
IEFQSSBhbGxvd3MgdGhlIHBhc2lkIHRvIHN3aXRjaCBkb21haW5zLiBSZXR1cm4gMCBvbiBzdWNj
ZXNzLCBvcg0KPiBhbg0KPiA+Pj4+ICsgKiBlcnJvci4gVGhlIHBhc2lkIHdpbGwga2VlcCB0aGUg
b2xkIGNvbmZpZ3VyYXRpb24gaWYgcmVwbGFjZW1lbnQgZmFpbGVkLg0KPiA+Pj4+ICsgKiBUaGlz
IGlzIHN1cHBvc2VkIHRvIGJlIHVzZWQgYnkgaW9tbXVmZCwgYW5kIGlvbW11ZmQgY2FuDQo+IGd1
YXJhbnRlZQ0KPiA+Pj4+IHRoYXQNCj4gPj4+PiArICogYm90aCBpb21tdV9hdHRhY2hfZGV2aWNl
X3Bhc2lkKCkgYW5kDQo+IGlvbW11X3JlcGxhY2VfZGV2aWNlX3Bhc2lkKCkNCj4gPj4+PiB3b3Vs
ZA0KPiA+Pj4+ICsgKiBwYXNzIGluIGEgdmFsaWQgQGhhbmRsZS4NCj4gPj4+PiArICovDQo+ID4+
PiBCZXR0ZXIgZXhwbGFpbiB3aHkgYSB2YWxpZCBoYW5kbGUgaXMgcmVxdWlyZWQgaGVyZS4NCj4g
Pj4gT2theSwgaXQncyBiZWNhdXNlIF9faW9tbXVfc2V0X2dyb3VwX3Bhc2lkKCkgcmVxdWlyZXMg
dGhlIG9sZCBkb21haW4NCj4gbm93DQo+ID4+IGFuZCB0aGUgb25seSB3YXkgdG8gcmV0cmlldmUg
aXQgYXQgdGhpcyBwb2ludCBpcyB2aWEgYSBoYW5kbGUuIEl0J3MgcHJvYmFibHkNCj4gYWxzbw0K
PiA+PiBvayB0byBkaXJlY3RseSBzdG9yZSBhIGRvbWFpbiBwb2ludGVyIHRvIHRoZSB4YXJyYXkg
d2hlbiB0aGUgaGFuZGxlIGlzDQo+IG1pc3NpbmcNCj4gPj4gYnV0IHRoYXQgc291bmRzIG1vcmUg
Y29uZnVzaW5nLg0KPiA+IEkgaGFkIHNoYXJlZCBhIHhhcnJheSBhcHByb2FjaCB0byBkbyB0aGF0
IGF0IG9uZSBwb2ludCwgaXQgYXBwYXJlbnRseQ0KPiA+IHdhcyBzY2FyeSBlbm91Z2ggbm9ib2R5
IHBpY2tlZCBpdCB1cCDwn5mCDQo+ID4NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1pb21tdS8yMDI0MDMyMjE2NTkyNy5HRzY2OTc2QHppZXBlLmNhLw0KPiANCj4gSSBldmFsdWF0
ZWQgaXQgYXQgdGhhdCB0aW1lIGFuZCB1bHRpbWF0ZWx5IGRlY2lkZWQgbm90IHVzaW5nIGl0LiBB
dCB0aGF0DQo+IHRpbWUsIHRoZXJlIHdhcyBubyByZXF1aXJlbWVudCBmb3IgcGFzaWQgcmVwbGFj
ZW1lbnQsIHNvIHRoZSAnb2xkDQo+IGRvbWFpbicgd2FzIG5vdCB5ZXQgYW4gaXNzdWUuIFRoaXMg
aXMgd2h5IEkgY2hvc2UgdG8gYWxsb2NhdGUgb24gZGVtYW5kDQo+IGF0IHRoYXQgc3RhZ2UuIDot
KQ0KPiANCg0KTm90IHRoYXQgc2Nhcnkgd2hlbiByZWFkaW5nIGl0IGFnYWluLiDwn5iKDQoNClNv
bWVob3cgbGVzcyByZXN0cmljdGlvbnMgb24gdGhlIGtBUEkgaXMgd29ydGh5IG9mIGEgYml0IG1v
cmUgd29yaw0KSW5zaWRlIHRoZSBoZWxwZXJzLiBJIHdvbid0IGJlIHRoZSBsYXN0IG9uZSB0byB0
aGluayBhYm91dCB0aGUgZGlmZmVyZW5jZQ0Kd2h5IHRoZSBwYXNpZCB2YXJpYW50cyBpbXBvc2Ug
c3VjaCByZXN0cmljdGlvbiB3aGlsZSBpdCdzIG5vdCBhcHBsaWVkDQp0byBSSUQuDQoNCllpLCBj
b3VsZCB5b3UgdGFrZSBhIGxvb2sgYW5kIHRoaW5rIGFib3V0IGFueSBvdmVyc2lnaHQgb2YgYWRv
cHRpbmcgaXQ/DQo=
