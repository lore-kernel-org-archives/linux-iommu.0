Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B318BF3
	for <iommu@lists.linux.dev>; Tue, 13 Aug 2024 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542039; cv=fail; b=AU4W/fOPGMtyJRnx+GVwjXvZuP9TCGFOKEsRWRTsuv/CLt8TtoH9wdA/2Ie+RbyticB5iFDEwkSCNUOSusmHUq3UiqF8lOlWLUAmTtzAKgpridTpLN4PU4WrhQqzVYxTuI+DegRMqn5PAY/QBKjfDwlZ2FqF6q+aW04lMA4p95g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542039; c=relaxed/simple;
	bh=Fke+2m5w1IL+mkzDCWTmUDMRTg170qZo1PvY4WNw6k4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OhkXSzp26YCO/9gD0qoStJ8cbSW23xY66OGMVFwiD8+CsD0aCi6Ty+cpAOUCu1mAtfY0QWiquQv8HjXaRBOardLgR/I7F0xZyaKUqcX7RMK5AIkEWsR/5DcsWBNHg4ZIQe/55sR73IBi91Uj7rl02NTdLhK4Fab/Vf3PDXeVTr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i07RTiI4; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i07RTiI4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723542037; x=1755078037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Fke+2m5w1IL+mkzDCWTmUDMRTg170qZo1PvY4WNw6k4=;
  b=i07RTiI4+Ryq0TepPGhCFrgJgmsky11zs+9w/XGDCTnyyh5jHMgMAeYe
   lFURWiYNQo9XrAI3tL+I3Q7zryOyj4VX0FVK8OJHgQT5uiHBEMaXTh/w2
   kkIEymErQ+8tXpMvUwmRmDEGg/9FS3VzNuePY36+dV0sCpSu92xjCUwaJ
   wmgyASLBuGNwFxMPHZPN3IChkt9VLc/aC/F+drobWQf6AolweqxoCNvkp
   P67OQBzaC7B7EVWavYsAX26FxHPquo+FFw6xQrDSHCFhSPp2eNtbsM69q
   nB+yFocKt51c6X1DAq7ZsS0MmP5/zYicknRhoK/4Hgs8fXjtSL4ErJcrc
   A==;
X-CSE-ConnectionGUID: g3cyfEQQT468pfJS3UNpRA==
X-CSE-MsgGUID: HfPGul/eRESdHBsh2eJcvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21562041"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21562041"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 02:40:36 -0700
X-CSE-ConnectionGUID: sPV0uo+jRHGfCKJU33ooWw==
X-CSE-MsgGUID: J2CUT3GLS2W9DGX7lVzNiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="89415916"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Aug 2024 02:40:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 02:40:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 13 Aug 2024 02:40:35 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 13 Aug 2024 02:40:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 Aug 2024 02:40:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuHrgwrO30dWFeOLd8ftDpcTQHHQyGlf70pgeLZqSDcovlp46k/UQW0Zkghkc2Jx2teUXbYSIFuWe/o1+u9A/X6DrFnp+xakd7QGeCUN4XSr6qpdDX1NRV+iUultnlro87kfUL57aEAzWuon8J1YyD5LuLpp5FkB2SlJZQEiMrsTDl/GNgaB9tAOAMYVJFomlEECKzrRarLBHO7C2F7TybUTo4XYosFRTiroc5LA7qmRDOnvKK227n1goyIC/RFOG1YblIOHEU/qSXq8GkLr8iWZa6HZhFkH6aa4nnu6vf2hrzXma8mUKsabVo/9rK5zNl9v00NGwAXjcThF4Rzr4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fke+2m5w1IL+mkzDCWTmUDMRTg170qZo1PvY4WNw6k4=;
 b=mbK+RcuMI/JMSQ+6u9OdZg1sV0biEpyOeVTWBRH9DfJsOVnIdN+gZpBaDkOyQJHMg09zzFtfYVW3fpFXAEoByMwV61uCkXYA34ABN+p0+tcXDGuzGIPrRSun/haetch7Ai4TQy43iqXxMwvrHsVwMZfEUdoK0mKe4PIZRNUMKmPMX+1//VodxLqRFD3H+SyawmJshJdCUFEDOTghKgK74FXnnNUM+iByKm9rX0P3b/LF7ZiLnCp4iZ8Hc0d0RzN/0rNiyE8ZmYChLf0+OTQFDUnzSuZP4RZk5A38yWQcDUgqB9VHMiRQt4I8A25gFptmdbnk25McFIXM+FMTkJd2JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.31; Tue, 13 Aug
 2024 09:40:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.031; Tue, 13 Aug 2024
 09:40:32 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Alex
 Williamson" <alex.williamson@redhat.com>
Subject: RE: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Thread-Topic: [PATCH RFCv2] iommu: Add domain type and flag to
 domain_alloc_paging()
Thread-Index: AQHa5CGX7pk7CM+gYUOgDC4/LHbhALITIeAAgABWkQCABrldAIAAI1SAgAAv1ACAAQvCAIAASv6AgAAwRACAABtSgIAI1n1Q
Date: Tue, 13 Aug 2024 09:40:32 +0000
Message-ID: <BN9PR11MB52765C37F5401E9AA7113D748C862@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240801144523.11803-1-vasant.hegde@amd.com>
 <8e531f39-9d14-4d3b-8a52-c2e8ca026f9e@linux.intel.com>
 <098008f7-2b3e-405a-a096-947e5df560e6@amd.com>
 <20240806123452.GE676757@ziepe.ca>
 <6b197aac-c38f-4e6e-9d32-d74e1a5b3968@amd.com>
 <20240806173230.GS676757@ziepe.ca>
 <bbe564b6-5079-4973-8678-1068a53ddf70@amd.com>
 <20240807135915.GF8473@ziepe.ca>
 <e5da0709-86d3-4b45-82cc-d995a2686afa@amd.com>
 <20240807182947.GI8473@ziepe.ca>
In-Reply-To: <20240807182947.GI8473@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH7PR11MB5818:EE_
x-ms-office365-filtering-correlation-id: 19fdd798-b424-4899-2fd8-08dcbb7bf9fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?MmI1MXFYWUNUREhZWTJFNitKRlBZbTJEYTRrdVZnNWVrMEdUeGVaQ1FvdU5l?=
 =?utf-8?B?UTFyN0pIM3VuVENlbXBmYy8xK2gzTTlyN3Y0ZW5YQ0lGWTVpOTBnODlySVpU?=
 =?utf-8?B?TllGYUFhNUZlL1hCa2psQkdjVDhRRnNYMFNGcjlUK01mUVFXVFVGcExMSVMv?=
 =?utf-8?B?UVRHaDVyK0d5ZVV0ampHSWtzcmV1NVZhU21qZ2hnOGdaNHg1aXRpdW83Zkt4?=
 =?utf-8?B?S3NRM2xDaXdLTUY2SmN6SmlUYXBQK2JwOFFPQ2QzTmc5SnVZNy9GSVVIV0ZN?=
 =?utf-8?B?Rzh0Tnh1QVN5SFpzR1lKcmRadHExeHZ3citMeENMb2JaS1VEUytLeHg4TmVZ?=
 =?utf-8?B?WWVCM1l3dll4blIzY0RzTFd6RTlERklCRmVQV0kzb3c1ZGlKY3dJTjZ2dG5j?=
 =?utf-8?B?WkJuTiszS0tWc3g1QlVYYm1HRHBRYU9FeFVNQXJNd0R5VVNXdXl2U3dva0g4?=
 =?utf-8?B?bnlGeERQOE5zbTUwTU9QYlBaQVhGM2FwZ29BTG1KMHhNZlBMWTArYW1lS0hS?=
 =?utf-8?B?R2xKL2NLTVNGeVZkS3pGZEFYdS9WZlpDWTRrSmllSzU2N0dvOTVDQituTlhi?=
 =?utf-8?B?UkRqZWplcEZlbXI1UXJvbElTZUtKMysxTUNGbHptRFF4bmthYlNlaEY3QXZy?=
 =?utf-8?B?Z21hdzhWREQyYnBrckN1ekprU2FDNW9vZC9hN0UzdGplNFNZZzBZYnNRdUtv?=
 =?utf-8?B?azc0U0lRK21XVGJkSXpVTHQxNmlSZFdLbUEra2t0S1dVR3lSTW14MXR4Yng0?=
 =?utf-8?B?dFNBTEZjMU1nRlhwbnpZUUJNTUdva3kyRDhHT3JIcFUrZ3UrN2pKdWZhLy93?=
 =?utf-8?B?YUp3NXloSVBPVlZHU1NocmlTcVhTS3pkSHVZQmJZV1dzbjBxK2JBVlhrYi9n?=
 =?utf-8?B?NTBrdzFkb1lDUGJhM3IwcjlVQVJYRFNnOE0xSHh4U0lSY0dtdjNzVTRqMVZ2?=
 =?utf-8?B?aUN0eUdQRzU2cFY3MlhyYXVUUWZXdHZqSUNVeXhJOSs4ZE9rUHp4eEhZTCtu?=
 =?utf-8?B?WFVWTXR2RTR0OTNKRnZETUNpMW9xbkpCNHZlYUUzOXh1bTV5WDZXTlZsa2Zs?=
 =?utf-8?B?YmxTNCsrZEVOcXp3cjFIaERJZjJlV0RXN2ZjSHp2ZW1KTWZ2eFE0ak15a0dQ?=
 =?utf-8?B?cC9VRUtTVVBxNnV4UzZ4NXFoVUVRRkZaTUE1dnhEck9XOVl3SHhnWjN6N1Yx?=
 =?utf-8?B?azFvZUFQSEJ4LytXZFNBcEluc1VwTCtVa2ZrSnV2T0Z2VWVPcHRqeURqWjdo?=
 =?utf-8?B?aXdjR1hobURnTHg1bTluWC96bWhkbG4yY041S2Rqekx1THp0Vm5HeENTRjdh?=
 =?utf-8?B?Rjl4SzhPSDVxSTE5VUFUN2l5WUtMeWlibjQ0TFhQMmFKWUpEencwWWJvTDVa?=
 =?utf-8?B?MFZQemtVYjF4K3JZNit6cmFQZHBEVFhPU3JCaisrbUUvdDZ6T2V1YUxnaTNU?=
 =?utf-8?B?VzRIRm9tRnhNTUhzNjNHbGhHMjFHdmpNVzQvQThianMzaEMvRDdEdVcvdXI2?=
 =?utf-8?B?OUh2Q0R4K2xVY2dhS0RibDNJMnZJVWRQbmY3QjdCb1NWdmtra1NMeEN6LzZY?=
 =?utf-8?B?NkYwYTJ6SWJrOVhZemx4N3FveDZMOFRTVXBEOUw0S0JzYk1DSUtpeHIrNzdX?=
 =?utf-8?B?V29UYW5GYnhrb3d2ZmJRelhWZjlaMkNEaFFsVVo0NmIwVmhkcFFLMTB5b210?=
 =?utf-8?B?ZHlCMXd0U09YS01LNU9kbkkrbzJaZngxVmpOVmJ3d1RoUE9HRHpEdU10OGNG?=
 =?utf-8?B?VGp4RjNSMld0T3h2cDlOSUpqVWJtVWd0K3MvVG90QWVDakZLS2Q4cU9TQVBk?=
 =?utf-8?B?OWJVSHR5V2NSdG5zdUVIdXp0SHUrdDN4dUViaEtxb3hseHFsNDJtR1loUVZJ?=
 =?utf-8?B?UFdvRS93ejRFNG84eWRWcGNwckZzc0tZcXJzRUlNSVpja0E9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NFhFT3ExL2ZUaEc0L3NJZW5QaFZLQjk3ZzBGQXdGQTlLMFplMnRrVGN5aTdS?=
 =?utf-8?B?OWVDeUJxUldEa1FDdjl1bXlzaC90TmpxVFRTN1JmR0RCdXphZjk0RDBRRCtK?=
 =?utf-8?B?YjJkajFtMU42bWV6Mlc0Q2NpbnBsR2RxNUh5TFhRNjZCdGtPYWFvUFg3b2hS?=
 =?utf-8?B?WXArUGJ4WDd5QlFzb0lmajFvYTAwN1pxdnJ6U09QNjlPdENUUVI0V2VmWmRB?=
 =?utf-8?B?Wmw1cHR6WkxwSFcybldQMG9UN2JnQmpCcWs3QlNQQ0RCUjNRT0xCWnI4SXFE?=
 =?utf-8?B?QVhDdkg1NWdFcTVNYXE3b2RRdVV5WlhvN2c2eVczc04vVmpZcndWcVd2SlM5?=
 =?utf-8?B?YUZHZjRrMjBnVHFYUDZrSXdSOHFsV1RHZStxdWx2WUxvK01wYlpaZU51YWZD?=
 =?utf-8?B?aG16WTdXY2REZWd5b3l3RWhxNCtqREdpVGo3WlozU010NHJNOEtJcjNKbEVZ?=
 =?utf-8?B?SnVkMW9TOCtDVzNIc0o3eGhMVnhIUi91ZkpOVGlHZGhGZ2xCZEhpbEdYS3Bt?=
 =?utf-8?B?UWdzZmxUNEZQTDZqSW9XV3d6QzVpaXp4bE1ISEhKSHkvMitIOFdrTjg5Nkhv?=
 =?utf-8?B?d2QweE1IdzBkY3VXY0JUNWV1bC95eHJBSFlvQlVOOFZYb3FwSlB4dVBTVmlO?=
 =?utf-8?B?Rzh2ZmR5ZGcwR0tYMXZVWXVFODg4OXh4Y2NMb1FWVXMzNi8reFpxODNqZmFu?=
 =?utf-8?B?MTN1dTVqYnp0K0tZSzlobGNsTXdqVFJDYm1QMkUzaTVEM3o3Z3Zxd04zTVBx?=
 =?utf-8?B?UXh1YklJeTlFT01PTC9oNUlZTk5PUGFicTJ4YTIyY3B4endNY0p2NTNFNmJZ?=
 =?utf-8?B?UFl6S3ZoR0RDSEExZ05zVG1rR0pEYnNNN0VSM0FudTAvOFhiczVqR3A1Vkxx?=
 =?utf-8?B?MDU5V1NrVkF6RjF3VnExSnlzUFFqSnIvWjhWTzVhL1diZEFhVk53UHgzcHFO?=
 =?utf-8?B?b29kTmpIVm9YOG9kcGxNc2c5cnJyYk9HNHMwVENiVXZ1elBBSWMvNDNvZVVH?=
 =?utf-8?B?QnRtNzkzSWkxdjR2VjlLKzJwT3VTNmNzVWdkbTF3T2x3R3RrQW9QcVZHVXRO?=
 =?utf-8?B?eTh5QVZPdGxKNkUwRlo2aHE1dlV2WTZkWkJEQVIyWjU5T0RhTGRiWWRpKzFU?=
 =?utf-8?B?UmZVMm9LRGVzWjZZcUhMOVNzWi8zNGJFcm1RWFpTSzI0MkRwY1pVVW5tNmww?=
 =?utf-8?B?ZjNBRm5lT3o5OWFGTE9PNkE2eXB4c1hjTU1SQXRMRVluN01RdmlyQ1hXMGht?=
 =?utf-8?B?Z0VtVUdhdnQydm1rYUpMSUMrdTJYTFFOaHdGcmM2M3dvYVo1N0hXODl6N3VZ?=
 =?utf-8?B?NXArVTdBR0k5azVQV2RFWVpDSStwby9lSHhLTUZkK1RPOEdGVHJnL0ZSRkxN?=
 =?utf-8?B?MXhrbFh6bXFpMHlkWURHTWt2U3pORWZ2d213SzkyMUxmSUE0MDlRTGcyZGpG?=
 =?utf-8?B?ZFBjdWMrSC9jL0NvMENodUNGOFZLMkszeHgzbjh6L1RtZ1E5MEFHeVdRNHVZ?=
 =?utf-8?B?Q21zTFEzS1lGcSttSURxdlE3N2J4ZVI3NnI5ZnR6VklqRHJSRW45MlRMeHRL?=
 =?utf-8?B?R2ZMMS9sNTlnMzEzeTFVL2pHTlFzTnhXdDVqMDd3MEtFWjN0UWdoT1p2ZGZH?=
 =?utf-8?B?bDZNMGpqSnRqemo3WlB6T3UrU3ZXNDZ2UWVXNTNTS1Zta3lpWmpkeWFqZU5x?=
 =?utf-8?B?Q2ZnUlEzbmRKRXJCMFRldUl6UWtjaXRlWVR6cFM1bzg4dnVza1dJVk1GL25P?=
 =?utf-8?B?MlZkQ2FURXRzSTV4RjhhRUdXeUltT08rZVJEM3FmRkUvNFdIRFJPbUR5dGdV?=
 =?utf-8?B?bjB5R0JEbXNsS21UbDhvcEFZNEU0bTk5eGJ0WmxUZnoySjNNN05iVkNHU1B0?=
 =?utf-8?B?cFc5U3dvNG9MdWozZlQzNWdaV2NEQTRDd1Q0b01VZ2M3d2kwRGljMElqTkFF?=
 =?utf-8?B?QnB2TWgzY1RQMGJ5TGUvcXdaY2ViTzhZMU8rei9EZzc1WFNjUVp1Ykw0RkE3?=
 =?utf-8?B?WU5BYzdnck9BNnZkL0g2Ry9jelVLYVRjMFcyTmdVMW1hRUpkZjcrdTJBc2RF?=
 =?utf-8?B?ZDVOaFJ1M3p1cEx1YWJ4NFloSndmMVlGV2dTQStsSzdZcnNiakJ0YjJUNjRw?=
 =?utf-8?Q?3LX5ac8QbIV2K+UgoJI5OPNKw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 19fdd798-b424-4899-2fd8-08dcbb7bf9fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2024 09:40:32.9018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tnPho3DGItQPB3H09NfuSf9p1zKGq2MQbYLecjJEH0j1Wqe8SH+EKouGJFASO6BN+3FJz2hi3f9pHMmUVmPRPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
X-OriginatorOrg: intel.com

PiBGcm9tOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVwZS5jYT4NCj4gU2VudDogVGh1cnNkYXks
IEF1Z3VzdCA4LCAyMDI0IDI6MzAgQU0NCj4gDQo+IE9uIFdlZCwgQXVnIDA3LCAyMDI0IGF0IDEw
OjIyOjAwUE0gKzA1MzAsIFZhc2FudCBIZWdkZSB3cm90ZToNCj4gPiA+IE5lZWRzIG1vcmUgd29y
ZHMsIG1heWJlIGV2ZW4gdHdvIGZsYWdzPw0KPiA+ID4NCj4gPiA+ICBASU9NTVVfSFdQVF9BTExP
Q19ERVZfUEFTSUQ6IFdoZW4gdGhlIGRvbWFpbiBpcyB1c2VkIG9uIGENCj4gZGV2aWNlLA0KPiA+
ID4gIHdpdGggbm8gUEFTSUQsIHRoZSBkZXZpY2Ugd2lsbCBzdXBwb3J0IGxhdGVyIGF0dGFjaGlu
ZyBhIFBBU0lEIGFzDQo+ID4gPiAgd2VsbC4gU29tZSBIVyByZXF1aXJlcyBhIHNwZWNpZmljIGRv
bWFpbiBmb3JtYXQgb24gdGhlIGRldmljZSB0bw0KPiA+ID4gIGFsbG93IFBBU0lEIHRvIHdvcmsu
DQo+ID4NCj4gPiBJIHdpbGwgYWRkIHRoaXMuDQo+ID4NCj4gPiA+ICBASU9NTVVfSFdQVF9BTExP
Q19QQVNJRDogVGhlIGRvbWFpbiBjYW4gYmUgdXNlZCBhcyBhIFBBU0lELg0KPiBUaGUNCj4gPiA+
ICBkb21haW4gYXR0YWNoZWQgdG8gdGhlIGRldmljZSBtdXN0IGhhdmUgYWxzbyBiZWVuIGFsbG9j
YXRlZCB3aXRoDQo+ID4gPiAgSU9NTVVfSFdQVF9BTExPQ19ERVZfUEFTSUQuDQo+ID4NCj4gPiBX
aHkgZG8gd2UgbmVlZCB0aGlzIGZsYWc/IFByZXZpb3VzIG9uZSBpcyBhbHJlYWR5IGFsbG9jYXRl
ZCBQQVNJRCBjYXBhYmxlDQo+ID4gZG9tYWluLiBJcyB0aGlzIHNpbWlsYXIgdG8gU1ZBIGRvbWFp
bj8NCj4gDQo+IElPTU1VX0hXUFRfQUxMT0NfREVWX1BBU0lEIGlzIHRoZSBmbGFnIHlvdSBzcGVj
aWZ5IHRvIGFsbG9jYXRlIHRoZQ0KPiBkb21haW4geW91IHdpbGwgYXR0YWNoIHRvIHRoZSBSSUQN
Cj4gDQo+IElPTU1VX0hXUFRfQUxMT0NfUEFTSUQgaXMgdGhlIGZsYWcgeW91IHNwZWNpZnkgaWYg
eW91IGludGVuZCB0byBhdHRhY2gNCj4gdGhpcyBkb21haW4gdG8gYSBQQVNJRA0KPiANCj4gVGhl
eSBhcmUgYWN0dWFsbHkgZGlmZmVyZW50IG9wZXJhdGlvbnMgZnJvbSBhIHVzZXIgcGVyc3BlY3Rp
dmUuIFRvZGF5DQo+IGV2ZXJ5IGlvbW11IGRyaXZlciBpbXBsZW1lbnRzIHRoZW0gd2l0aCB0aGUg
c2FtZSBsb2dpYy4uDQo+IA0KPiBTbyBJIHRob3VnaHQgcGVyaGFwcyB0aGV5IHNob3VsZCBiZSBz
ZXBlcmF0ZSwgYXQgbGVhc3QgaWYgd2UgZ2V0IHNvbWUNCj4gcmVhbGx5IGNyYXp5IEhXIGRvd24g
dGhlIHJvYWQgdGhlIHVBUEkgd2lsbCBzdGlsbCB3b3JrLiB1QVBJIGlzIGEgYml0DQo+IG1vcmUg
dHJpY2t5IGJlY2F1c2UgeW91IGNhbid0IGNoYW5nZSBpdC4NCj4gDQoNCkknbSBub3Qgc3VyZSBp
dCdzIG5lY2Vzc2FyeSB0byBwdXNoIHRoaXMgYnVyZGVuIHRvIGFsbCBleGlzdGluZyBJT01NVXMN
CndoaWNoIGRvbid0IGhhdmUgc3VjaCByZXF1aXJlbWVudC4NCg0KQ2FuIHdlIHNpbXBsaWZ5IGl0
IGJ5IGp1c3Qgc3VwcG9ydGluZyBvbmUgZmxhZyBhbmQgdGhlbiBpbmNyZW1lbnRhbGx5DQphZGQg
YW5vdGhlciBvbmUgd2hlbiBhIGZ1dHVyZSBkZW1hbmQgY29tZXMgYW5kIGFkdm9jYXRlIHN1Y2gN
Cm5ldyByZXF1aXJlbWVudCBieSBHRVRfSFdfSU5GTz8NCg0KSG9uZXN0bHkgc3BlYWtpbmcgaXQn
cyBub3QgdmVyeSBpbnR1aXRpdmUgdG8gdW5kZXJzdGFuZCB0aGUgcmF0aW9uYWxlDQpiZWhpbmQg
aGF2aW5nIHR3byBmbGFncyBhbmQgSSBkb24ndCB0aGluayBhc2tpbmcgZm9yIGNoYW5nZSBpbiB1
c2Vyc3BhY2UNCnRvIHN1cHBvcnQgcmVhbGx5IGNyYXp5IEhXIGlzIGFuIHVucmVhc29uYWJsZSBy
ZXF1ZXN0IGNvbXBhcmluZw0KdG8gdGhlIGJ1cmRlbiBtYWludGFpbmluZyBhIGhlYXZpZXIgdUFQ
SSBmb3IgdGhpbmdzIHdoaWNoIG1heSBuZXZlcg0KaGFwcGVuLiDwn5iKDQo=
