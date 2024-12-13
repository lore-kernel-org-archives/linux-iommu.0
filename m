Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8393B18EA2
	for <iommu@lists.linux.dev>; Fri, 13 Dec 2024 02:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734057940; cv=fail; b=osm0CoJVFoWKWXr166kOkAi7CQEPIOy9DTIL3V53NppapwgIAh6VqjRqrwynrfu5voaAdxtdJY3Y4ZgHOF8NNA8R9CqeecN8rxjWjT2XIcIqhtegisOL3WvpBNVr+Dofrn62l2JOCtpBsS/p84I0dMmOqNC3NqXsqef9WH7JrCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734057940; c=relaxed/simple;
	bh=1ZRW+aotLjMtOhqSm1fY3oB5ZzCCZ50PyTOBDFVOuyI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PyI+sqMgBDKmovNXjv6TZ6lfIJic6nE5+UNzjyFjdnbbI7Jgh7zDw9p+O7zT752MDj4J3KbBVoAjIH0Jsx+7SepknQTx+lmpTJziqLUDKQGJtwiA9x6pUseaHiUaKZra/Kln69J2l25KXqfFrEL8g35hP9L1bxhb8jV/EK9+hMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OWP+yuw2; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OWP+yuw2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734057939; x=1765593939;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ZRW+aotLjMtOhqSm1fY3oB5ZzCCZ50PyTOBDFVOuyI=;
  b=OWP+yuw2fD6kdj4HWdYTOfJcZ1jhs3TCFsUL+0mD0HPpr3OIvz9unaDQ
   wrznvHqOdRTXF+bvdXJLVavRQ7JKwJYNf1LEHpzxF5Aex76EcB9DEnIjx
   y9otycISQ0Nil9qEwB2Z4Bgk7YMy7Girl+iurYJhBsQ4IIqGBPUJfUWre
   T15w0kb27wyTdi5//nnUeT0cmPF4sfUeybGdQM0e11D4wHwY6p1nTZtGh
   GfVpDVvUYq23AHPbkcCU17bipr84dL2F1raui4gqYX6h1MigR2J0NBIY9
   gj+ZlDmQ5QFUzxbA9YCLkjuQvoFe35tPdKjzbGDajiI4C3Gj2JwcET3HE
   g==;
X-CSE-ConnectionGUID: V7NHHAD/Tnuzh3dkobamxg==
X-CSE-MsgGUID: VYwM5nvKSteFLuKqb7YdKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="52028844"
X-IronPort-AV: E=Sophos;i="6.12,230,1728975600"; 
   d="scan'208";a="52028844"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 18:45:38 -0800
X-CSE-ConnectionGUID: xjAUe70TS8icSam7HL+9Fw==
X-CSE-MsgGUID: vGr3/XNOQhCRQ2iw8Us8Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="101372135"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Dec 2024 18:45:37 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 12 Dec 2024 18:45:37 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 12 Dec 2024 18:45:37 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Dec 2024 18:45:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fidE/HEke/3U+iJeu22I2UMTye3j6eOe/4BZ1Y90VFnA1nOc5tIetfqzjEhQ4815Fe9q/yghO4ACeUMWl1zthINzatF666h9J4Ij3ITK1sh9D9lFtMr9KEvYZQrvmIwwCDGNqu3acLeiUPfHTbkj7wQXf834ec+SiBDgQ6XcpmpQVjGe/LqFJV5FCZ6FWzUwovB+p/72DufhGKL1bwXs1YnSQmPw1b4I+Mcb2egISb9VWqQvZ1Jk7rWQrttMcKKr02mjHMBKDiWKzwySfW730kZSoPvwFhshiaz8FHvLCW4muGZx9Pa5KkDspQ9hWFOA8MP3m3CbzD7FrSPT4JPvWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ZRW+aotLjMtOhqSm1fY3oB5ZzCCZ50PyTOBDFVOuyI=;
 b=q99IBaUzH6P7wP8pXRpeQL/8naEOHRZZkz3/mT4aTIEM2P0d11fw43TiNtIyHvnMwrsLOmXz253klvBQmnHEPN2GDDMnFAyB6cygFzU+vcML1fWNZb/P1PTxYHEWfvncNRyV9Vii72clHgrp4lY0YbPcdRcQQrC6BW81ml12y1d/s7/CEifLOzTrQapBy9g1fwAPBRgH4YCyvBM99Qa77dvJbOhC5mhMYqcl6dt+qbaqRv1mYApGFD9TLrHeQXU9kcVdPZ6+83tkg2Yh3K4UcJHqvyg0mslkypHc2Ay2jZNpI7A8H24b8IfKLuqEIcqultFj9f+ZPDTcM6iQJjT9nA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB8250.namprd11.prod.outlook.com (2603:10b6:510:1a8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Fri, 13 Dec
 2024 02:45:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Fri, 13 Dec 2024
 02:45:17 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v2] iommu/vt-d: Fix qi_batch NULL pointer with nested
 parent domain
Thread-Topic: [PATCH v2] iommu/vt-d: Fix qi_batch NULL pointer with nested
 parent domain
Thread-Index: AQHbSwPq5ChM9YYSNkeNT67odQk8MrLguE5QgAAPUwCAAVRrEIAAHJGAgAFDVlA=
Date: Fri, 13 Dec 2024 02:45:17 +0000
Message-ID: <BN9PR11MB52764790EF8CC2EFEB54C2BF8C382@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241210130322.17175-1-yi.l.liu@intel.com>
 <BN9PR11MB527673D307E992D5D69CDDD18C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c031213d-a86c-4f7c-81f8-235116638291@intel.com>
 <BN9PR11MB5276F5B100BD155B371533238C3F2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c893e582-9526-4832-97fc-2487348bfa91@intel.com>
In-Reply-To: <c893e582-9526-4832-97fc-2487348bfa91@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB8250:EE_
x-ms-office365-filtering-correlation-id: 9d962585-3ad6-4f4d-3210-08dd1b202d72
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?N0x1cU1MOEZJSnZndWtoTkJSaWttUUdzcGEvSk5tcEtjWXczdjFWYnY3U3Ba?=
 =?utf-8?B?aGlpeXFuaGc5QTNveEVvb3YrUTRSZGw1d20rZDJ5czRRVFpZWDBkZTRpRVhv?=
 =?utf-8?B?K2FJNEtNcGhpck1ESk5iZHNaOUNMM3dFUUZKQ1NualVGVnBPQjIrV2haSnhq?=
 =?utf-8?B?RStmVDRZSy8ya0F1V3hlZ0tzc1Vqa25lc0NQL1luMzNCM1FPTVpra0U0RWpU?=
 =?utf-8?B?T3Z0OWwxVkJMeCtmT0RValhSUmxaYUJLV1JLRVBvanVlU1pJVFhJRkZMb01V?=
 =?utf-8?B?MURSWngrWDYzY3JzUVN3V2ZmcVQ3RCt0R05rMWRsQjhEcEhoOVpMelBZVUNa?=
 =?utf-8?B?NlY4Y3gzYitCNTV5Yzg2b2JCVTRTY1lhN1h0VUZ3SWU4NHhHalBMa2w2L0pn?=
 =?utf-8?B?ZXZnMjZhWThpK0pZTmhKMUdDODlvSXo1RmlORlFZNHJKTnZCeitUNVhHbzVJ?=
 =?utf-8?B?QmNibFF4dEZQZW0rU2laOTVyRE9ySW9jYXhTSndrVms4RERMbEp6emNEV05o?=
 =?utf-8?B?UGxEYWdOQVpma05NbmwzTm9ZVlBYd0Jib05IQURYNG03RFRlNnJQblhDcFpH?=
 =?utf-8?B?cFhDYWlrSllpbjZZRHRsV0FQWHRIUUE5cUFGZmZvU3htaE9nU1NvRFRkajE4?=
 =?utf-8?B?NmZhNUE5NGlsTC8xMWdsK0lBUXlucjVhQ2ZVWUV5S05Pdm13akpvajAzTEIw?=
 =?utf-8?B?UGYvUm1EdUZyTDlCUmsvSTNiUVl0UFVaNVhoazZLelM2QXJYRE1EeS9JWDJz?=
 =?utf-8?B?Njhsb20zeHZBWEJWMjJrK0tJVmFZV3BTVStGRWRwaVU3S0FyN0F0dXhaNUQz?=
 =?utf-8?B?YkhwNFRGT1c4MHBPcVQzYkhmcmFNcWhrTXBOeGNlWVFkQnljUjA1UGxFOXg3?=
 =?utf-8?B?ZE1SY0tIQVV3WlF1K1VTcGpWNVM2Q25leGFVZHVFa1NOdWRoRmROeWtPWTgv?=
 =?utf-8?B?Tm5hcVlFalpPUk8yZWRML25iUk50aHNxRkNHUWxLYVRESFpaYU1ubkMweUNI?=
 =?utf-8?B?YXpuTHUvelhkUkJGbVNWVUJmcW5lQmh1TXdhZXlRSU13T0ZkckFZaDBnckhP?=
 =?utf-8?B?dGltbjdQV09la2ZtaU5xOFJsU0xPWVJ2YU4wWEFGWnMzbGQ1U0NDVUVnQ2Ry?=
 =?utf-8?B?d1V0dE9ieEtDVGVxK0hjVWpwNHREcEE0Tk1iaCtudjY5VHFNekNxZ1Rzdk0y?=
 =?utf-8?B?UkVqV1g4a25MdXBzS2t6TVRKV0lTNTVOMmVrd0hJdmVCTWREbzJmSzVOa1d2?=
 =?utf-8?B?SmUwS2F2ZkUyRWdQTUJEcVRBaEVrR2djb05mR3ljcDJMU2lMbitkbHdiTFc3?=
 =?utf-8?B?SFlLS0ZNRjBOR3Jwbmw2ZDVKSkNpSUNtYllMU2VxemdlZ295U0NBc1lJK0hI?=
 =?utf-8?B?aXgrZXVXbUlZeVRySEkxeUh2aUJWUVhZQU16M1MrMWRLQXdyVERtNVRPeXRG?=
 =?utf-8?B?S3AwU09TSjB6UllpYWZmWThwVjNncmNnUEhaR2FRWEdEMEJFT1pNS2tuOE9M?=
 =?utf-8?B?d2hEaklyZzJKOWF6eE43cENqSnNRRUMyRW9lVzhWYmh1bkF2czFyYnVvYWRh?=
 =?utf-8?B?ejVYRmJBck52aXZLV3VzWEJjSk5naG1MU2FsekVJWWRlSERpRXgzM0czMjZB?=
 =?utf-8?B?VGJKQ2JlVWFDVXpPZEVidEdzQTFWQnlGMHBQeXFIVGJsUTdkd2xoekY2VllJ?=
 =?utf-8?B?OEdnODRjUlBSRGJlN3NoQnpOMlZPVlFKdVpmQUlLeVE5VDBwRk03aEh0TWcy?=
 =?utf-8?B?TFNBVWhKMThtVU1pTUM3d1NxRng0VURzYzdXTWx6T0s2cDZpMW13TDlKU0hs?=
 =?utf-8?B?NUFCUzJKM21NbFNadGtOMXJmaGNZUXRrWUQ2L3cwYjhPQ1FvVWxlaUZNZktB?=
 =?utf-8?B?cnU5WDV6UmlEQnhPMTJLZ3BXSFJnTGtFK2kvb2UrcFMyT2c9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bmxQYjV3WXhmeloxdTcwN3Z2TDlaWVIwRmJ0Y0VSR2pTdjhMTXJZS1ZTQk5L?=
 =?utf-8?B?ODNDVjNKYVJpUWYwM2NDQzVJeXN4WlU1MCs5RnZkUCszYXNmaXZ6Q3UxNEd4?=
 =?utf-8?B?VG9zbFFFcVJGbGpYd2tKS3BIYmhiRTYya252bGQ5eTM1aXJMbzJsSXlWcTJU?=
 =?utf-8?B?UmVjSWx1cWh3Tk13aGJoNUE4MVIrcXord0xPOUgvK25sN0JTbUJ0ZEZldVI4?=
 =?utf-8?B?QWl5VDhyQ3Z5RkE2SmpSbmJGVUhxYmNVcDBkcUJkUThYQmFkenI5UWFnOTFz?=
 =?utf-8?B?RFRDQW0weWtXb2FVTmpnRS9SYWVmeE5lQ3ZIUHRQNXREWVZCVzNSa0VkTlJl?=
 =?utf-8?B?ajQwVzN0ZEpneWVsMmo4TDZiUDNsTlY0QnRtN2lrUUEyMXY2ajNQQW5DS1ZR?=
 =?utf-8?B?SE9aQzAxNFF6UHlVVzM0NHFoUHlNMmswMnRhUGd3ODE3eFpZL2hvVmtKL2VJ?=
 =?utf-8?B?RkRMSWp1eDh6WWpzKzVneHNRbXNmcnpOY1RPSVFHVGVvSHVGSTdWV1lrZ1Zv?=
 =?utf-8?B?OEM4cUxlMDVTR3BYRTU1ZmhOSUhuUDVERzVKTVVVcTUyQi9nWlMzR1F2Mm5L?=
 =?utf-8?B?T0pZaGRxVnJ4TzBPM3VPWUxVR1pNTmhGZ3N4VnRYT0krSjhzSlNkMUZld20w?=
 =?utf-8?B?cGh1M0w4ZnIva0tFYk4wZ0NQNjVkVWpHRXJrYjJEekRkSkZjS25yc0F2VGQx?=
 =?utf-8?B?czF5WXJ5a2JUaE45ZC9jRHI2UjlkVy96ZHFvNWIvd09VTHlKUG53NUdwNUNp?=
 =?utf-8?B?Znowd3Bpam9IeUFqaEZRQm5lZ3FLbU5ZZHh1Ym91aVdYa1UveUNPTUxJcEFU?=
 =?utf-8?B?VGttOUJqZHZzN0JaUHhWcjUxRS9SOXZDMmtOLzhhcG5ZMm1VdDdib09CL0ly?=
 =?utf-8?B?LzZOcTJGTUtTajNibk1QMWlWeGxnUFZpdjJhYlIrK0E4YWkyUi9jeUpMTXNa?=
 =?utf-8?B?ZW4zTVVaOFBIeWZvdDNiUGgvaDd0YnFweHRpbXpLQXQ1clY4MG11Y294dEpO?=
 =?utf-8?B?bWRSdUJlb3N6dkl2YVRxY0dxT1pKMnZ5Z2x4Z0FzcGlDS3k3SnNNbnVzUzRr?=
 =?utf-8?B?TUNMT3JhaGxtSEVjVzlxdWJRNTl5SE9TYWQvUFVMYThvakdyWm9YeFpDMmRI?=
 =?utf-8?B?Ky9NcVNhZmEvRU5GZmhpRlREb0dyaSt1MUZScUMrcjZhS3d4QzF3UmVpWjY1?=
 =?utf-8?B?MW5HSStDWEVpYlNEOWdhYmp3dyt0bEt2bnVocTdFamNOMVQzcjBYZW1ZUWx5?=
 =?utf-8?B?bHRPSkhJNGxMMVFQNWdVL29qQjFTUnphYlBLU3cyOVFiYzNlUUhWUVhzK1B2?=
 =?utf-8?B?TUtHS1ZjSEdRVnU3T1VqVGhWNkwvM3BKdDVJSjdxbmpoTTU5STl6WlFmOGJq?=
 =?utf-8?B?Q3pMYXptN3kxRGM3VDBBaUliemFsTUFwRDJnSnVNSG5neHE0VlZ2VDl5TEdm?=
 =?utf-8?B?aFp2YThwWUt6Z1ZGNHdGVnRPU2p2VzVwQk5tY1VOaVVyYUlNRmZ0bnRMNXQy?=
 =?utf-8?B?clc0K2xpcVd0WExnWHFyUVcrTTdudzdRaGN3eHRoWEVEVW0ybnhERTRvWjZy?=
 =?utf-8?B?R0VKT1FIK2MwM2lSbVdiUmd1cGhQeVFoL3VjZEV5YmpPL3B4UjUyU3FwaGxY?=
 =?utf-8?B?eU85bi9DOTk0UFJCK3lVekFTQ1lnRE0rSjN6YVBzNDBTRG5EZzFBMGJjdERU?=
 =?utf-8?B?RS95ajZPRGRnL3M2MGNmWWRaeFVya09tam9sRzVCMFRkOXlkWGlXZVZnNlNJ?=
 =?utf-8?B?ZkVZNHNLK2kxdHpEMWllK3kvanFyd21lcVVwdjdKVXA5SnZzUmJ5Qk5FbUgy?=
 =?utf-8?B?dm9rSlhRNjFYYXBaeXQ1YUk5dTJ2WUJzRmpEdkErSzZieTFxQm92TFJabWRL?=
 =?utf-8?B?dmoyelhaTU90ZVllYWcwK0xOdXBqNEN2WFA5U3ZEbnhnem9JcmhxNktUU0dW?=
 =?utf-8?B?bE8vTEh5V0dzVmJUZXJkcmpVZFM1MUJ1V2xFQXlKWlN0VjViN2N2UmVHZitp?=
 =?utf-8?B?dENwOC9hblZIY0FmcE1WcWFQWW52YWZVaGEvU0o5a1c4bll1QmoyNGY3Ukl2?=
 =?utf-8?B?ZGwwUmE2YzJBS2NnNUNxZGRhT0JvY1o5QlF6V25JZ2VReU5kd3hyaW5mZ0tR?=
 =?utf-8?Q?3yDIKyAhkT1Q+3n7tKEpb/vQZ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d962585-3ad6-4f4d-3210-08dd1b202d72
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2024 02:45:17.1438
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZBO0muwWzJzdo2WTO3km8VlPDlbd8UkMWfrfIMPlfnWbfmq21JDJu0CN1cpHv2726FX+cDVUzF4tLud1VzCQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8250
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogVGh1cnNkYXks
IERlY2VtYmVyIDEyLCAyMDI0IDM6MjggUE0NCj4gDQo+IE9uIDIwMjQvMTIvMTIgMTM6NDYsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNv
bT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAxMSwgMjAyNCA1OjI3IFBNDQo+ID4+
DQo+ID4+IE9uIDIwMjQvMTIvMTEgMTY6MzUsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+Pj4+IEZy
b206IExpdSwgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+Pj4+IFNlbnQ6IFR1ZXNkYXks
IERlY2VtYmVyIDEwLCAyMDI0IDk6MDMgUE0NCj4gPj4+Pg0KPiA+Pj4+IFRoZSBxaV9iYXRjaCBp
cyBhbGxvY2F0ZWQgd2hlbiBhc3NpZ25pbmcgY2FjaGUgdGFnIGZvciBhIGRvbWFpbi4gV2hpbGUN
Cj4gPj4+PiBmb3IgbmVzdGVkIHBhcmVudCBkb21haW4sIGl0IGlzIG1pc3NlZC4gSGVuY2UsIHdo
ZW4gdHJ5aW5nIHRvIG1hcA0KPiBwYWdlcw0KPiA+Pj4+IHRvIHRoZSBuZXN0ZWQgcGFyZW50LCBO
VUxMIGRlcmVmZXJlbmNlIG9jY3VycmVkLiBBbHNvLCB0aGVyZSBpcw0KPiBwb3RlbnRpYWwNCj4g
Pj4+PiBtZW1sZWFrIHNpbmNlIHRoZXJlIGlzIG5vIGxvY2sgYXJvdW5kIGRvbWFpbi0+cWlfYmF0
Y2ggYWxsb2NhdGlvbi4NCj4gPj4+DQo+ID4+PiBPdXQgb2YgY3VyaW9zaXR5LiBJbiB3aGljaCBj
YXNlIGRvZXMgdGhlIFZNTSB0cnkgdG8gY2hhbmdlIHRoZSBwYXJlbnQNCj4gPj4+IGRvbWFpbiBt
YXBwaW5nIHdoZW4gbmVzdGluZyBpcyBlbmFibGVkPyBJIGtub3cgdGhpcyBpcyBhbGxvd2VkIGFu
ZA0KPiB0aGlzDQo+ID4+PiBwYXRjaCBkb2VzIHRoZSByaWdodCBmaXgsIGJ1dCBqdXN0IGN1cmlv
dXMgaG93IGl0J3MgdHJpZ2dlcmVkLg0KPiA+Pg0KPiA+PiBUaGlzIGhhcHBlbnMgd2hlbiB0aGVy
ZSBpcyBtYXAgb24gdGhlIGRvbWFpbi4gSXQgY2FuIGJlIGVhc2lseSBwcm9kdWNlZA0KPiA+PiB3
aGVuIHVzZXJzcGFjZSBhbGxvY2F0ZXMgYSBzMl9od3B0IGJ1dCBuZXZlciBhdHRhY2ggaXQgdG8g
ZGV2aWNlLiBXaGVuDQo+ID4+IHRoZXJlIGlzIHBhZ2UgbWFwcGVkIHRvIHRoZSBJT0FTLCB0aGUg
bWFwcGluZyBpcyB0aGVuIHBvcHVsYXRlZCB0byB0aGUNCj4gPj4gaHdwdCBhbmQgaXRzIGRvbWFp
bi4NCj4gPj4NCj4gPj4gSW4gbXkgdGVzdCwgSSBqdXN0IGFsbG9jYXRlIHMyX2h3cHQgd2l0aCBu
ZXN0ZWQgcGFyZW50IGZsYWcsIGFuZCBhbGxvY2F0ZQ0KPiA+PiBuZXN0ZWQgZG9tYWluIHdpdGgg
aXQuIFRoZW4gSSBhdHRhY2ggbmVzdGVkIGRvbWFpbiwgYW5kIHJlcGxheSBhbGwgdGhlDQo+ID4+
IEdQQSBtYXBwaW5ncyB0byBzMl9od3B0LiBJdCBoaXQgdGhpcyBpc3N1ZS4NCj4gPg0KPiA+IHNv
IHRoaXMgaXMgYSBjYXNlIHdoZXJlIHRoZXJlIGlzIGFscmVhZHkgYSBzMl9od3B0IHdpdGggdmFs
aWQgbWFwcGluZ3MNCj4gPiBiZWZvcmUgY3JlYXRpbmcgdGhpcyBwYXJlbnQgczIuIFdoZW4gcmVw
bGF5IGhhcHBlbnMgdGhpcyBidWcgaXMgaGl0Lg0KPiANCj4geWVzLiBJbiBRRU1VLCB3ZSB3aWxs
IGFsbG9jYXRlIHBhcmVudCBod3B0IHdoZW4gZ3Vlc3QgaW9tbXUgZW5hYmxlcw0KPiB0cmFuc2xh
dGlvbiAoVEUgYml0KS4gV2UgYWxzbyBoYXZlIGEgY2hvaWNlIHRvIHJldXNlIHRoZSBod3B0IGNy
ZWF0ZWQNCj4gZHVyaW5nIFZNIGJvb3QgdXAgKGFsbG9jYXRlZCBieSBWRklPIG1vZHVsZSB3aXRo
aW4gUUVNVSksIGJ1dCB3ZSBoYXZlDQo+IFJPDQo+IG1hcHBpbmcgZXJyYXRhLCBzbyBjcmVhdGlu
ZyBhIHBhcmVudCBod3B0IHRoYXQgZG9lcyBub3QgaGF2ZSBSTyBtYXBwaW5ncw0KPiBpcw0KPiBi
ZXR0ZXIuIFdoZW4gdGhpcyBwYXJlbnQgaHdwdCBpcyBjcmVhdGVkLCB3ZSB3b3VsZCByZXBsYXkg
dGhlIEdQQS0+SFBBDQo+IG1hcHBpbmdzLCBoZW5jZSBoaXQgdGhlIHByb2JsZW0gYXMgdGhlIHBh
cmVudCBod3B0IGhhcyBub3QgYmVlbiBhdHRhY2hlZA0KPiB0bw0KPiB0aGlzIGRldmljZSBhdCBh
bGwuIFRoaXMgYWxzbyBtZWFucywgdGhpcyBpc3N1ZSBjYW4gYmUgaGlkZGVuIGlmIHRoZSBwYXJl
bnQNCj4gaHdwdCBoYXMgYmVlbiBhdHRhY2hlZCB0byB0aGUgZGV2aWNlLiBBbmQgdGhpcyBpcyBl
eGFjdGx5IHRoZSByZWFzb24gd2UNCj4gZGlkbid0IHNlZSBpdCBpbiB0aGUgcWlfYmF0Y2ggbWVy
Z2luZy4gTXkgdGVzdCBhcHBsaWNhdGlvbiBoYXMgYXR0YWNoZWQgdGhlDQo+IHBhcmVudCBod3B0
IHRvIFBBU0lEcyBvZiB0aGUgZGV2aWNlIHRvIHRlc3Qgb3V0IHRoZSBwYXNpZCBhdHRhY2ggcGF0
aCwgc28NCj4gaXQgV0EgdGhlIGlzc3VlIGJ5IGFjY2lkZW50LiBSZWNlbnRseSwgSSdtIGNsZWFu
IHVwIHRoZSB0ZXN0cyBieSBhZGRpbmcNCj4gdGhlbSBvbmUgYnkgb25lLCB0aGVuIGhpdCB0aGlz
IGJ1Zy4NCj4gDQoNClRoYW5rcy4gVGhhdCdzIGEgY2xlYXIgc3RvcnkgZm9yIGhvdyB0aGlzIGlz
c3VlIHdhcyBpZGVudGlmaWVkLg0K
