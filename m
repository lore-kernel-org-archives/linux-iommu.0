Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CA141A8F
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 03:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741145126; cv=fail; b=VQnEjOW6kWi1Zitu9snS77f+uSAuC2bFWIMgIyacv51NFu+fnXgURqQ68n+1WM5E4vs32vtpbmr0cfvdEnPJAtNNhJ+fKm4hPUZutInBIBYyK7rc0/9QN9jY+cRoZvIoDs+TDDr+yt20aJWECCKNhkf8c8Nl3SBf+thti73kW2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741145126; c=relaxed/simple;
	bh=lCbfIK+p9kUyDTiGK6HAviAUfYleqyuxZBdaTp2ma8E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ck0yxE0hhxec4P32V+LscVRJN1lqbKUadB2Tny21OOcOizgnOLDerhr69+GKvGELeRy1Ob38ciaoHyACmmYYMWpD9sSjgCSfxK2PDXalBV/N5r4RS1X7VMPUqq8DRr2SSkSBUb47h/4sXywAdCL56/h+MMxuh1ub2INW0ZXBAZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FTannOgA; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FTannOgA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741145125; x=1772681125;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lCbfIK+p9kUyDTiGK6HAviAUfYleqyuxZBdaTp2ma8E=;
  b=FTannOgA8eTXiylQnAVV/Fzz1XubNnYODRUQPcfRXbpJ3W1aHsOgCE6e
   h7uK5ek3Q/8CcdQ+4RxV2ixPjhrxKN7r0yW8KLVWBz98ZKry6w6R2h2UT
   Wr+UAkH6bZsgTAnBd41Kyu3sUdGcYjmtiX2+AmF3qF3M8hLl+ib3Wb8d7
   rRVFo+19eoK7NMjj6hYb3jCRAV7zN7+1prDwaapSLPbB8mHeMww+UPman
   0GCWJkWSPfi/AInazFoVgxXhmZneD7QeMfwRT2bL7CsoBQp5Lp39TNRXD
   JrYtTghPMlbgIDOZwcv5rZmMyNH9KuP4tWT9WVyVuaZOAQCBOFTI6GBCK
   A==;
X-CSE-ConnectionGUID: BrLWUOV5R96oX3Sqfm+1/w==
X-CSE-MsgGUID: EF+GMCU1QIiuKdD6F+hZEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="41339840"
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="41339840"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 19:25:24 -0800
X-CSE-ConnectionGUID: X9bWy1seTj6bQ5zzaw+AFQ==
X-CSE-MsgGUID: zldy0WMlR0edMwC9Gz1ikQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,221,1736841600"; 
   d="scan'208";a="141808716"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Mar 2025 19:25:23 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Mar 2025 19:25:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 19:25:23 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 19:25:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jISEz1dQNjB5PRZIKkuSVc1g2/H8j3CWvluGKSW/4k4wyNWmwFIVlyA8eg/S3CcJfYsbeKKXMm+6ltEcgNvrnGOFDepsAL0v4bDBmoEn2l9s88RyvrcNCWZbun1wxjo4v0bduFKxpQTtv74XU7ukbeDuRzcmezOvzUWMiqHFwOa112SL/mPUSKr5R+p0XpOOIqHRbAbwZkSrbGuwX+8RWD8UNUuetBqhnOPdJW2X2pJUKUaNKBpyAUyBzoVhCeTMhhI1xZktqNkEMVvwe/c/YqNLhI8oZX6qCvm8oTo77zRffWvvBhGTAcLQhc6yARkkd16nXzXzoD2KMDQJhZPeWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCbfIK+p9kUyDTiGK6HAviAUfYleqyuxZBdaTp2ma8E=;
 b=LNUEw1VLYTpAczX1zx3dbrnj7hxYXAd1pN13K4V5hRM//IdegQbJWdySs1f1GH2apACK3yyyBQkOFU+i1/IDj2x61HUOkFJpXyU7v72DcFeMsTEUSe2mmg6242FyMnKFG9phNg/a6Y8AvkX2l4A01JbR83JxNyqb8nxBnqnQx/ZX/LWkSsc/ed2xvwbRKSjBeJ5FzyVh86sp9JXa8aJLENCbZHcb6+W7owuhpud/kBc9z7Hmq2vB4SsU7HlxgGDG9o4In9PWUYdvv5F3lVKkp/qW8hpXMQ8JtRqb5kHsCGN32uJVSGRMhLHkhmA1EgSxkzdlbh4D7w8JLJDWDuI53g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4840.namprd11.prod.outlook.com (2603:10b6:510:43::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.27; Wed, 5 Mar
 2025 03:24:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Wed, 5 Mar 2025
 03:24:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
CC: Robin Murphy <robin.murphy@arm.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAApFIggAAJnQCAABasoIAAQ3owgAIlpoCAAPkEsIAAF6wAgAANLoCAAASrgIAAABIAgAMaTACAAc13gIAClZTA
Date: Wed, 5 Mar 2025 03:24:53 +0000
Message-ID: <BN9PR11MB5276786C4BF482199872BB2E8CCB2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
 <BN9PR11MB5276B3E410FD336A3062FA5E8CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4fba254e-ca47-4e7b-baf3-0228d9605c2b@amd.com>
 <BN9PR11MB52763A8885AF1678E05E8B528CCC2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <942a1a66-5c18-43e2-886e-df38cb3e7258@intel.com>
 <54db17d7-b150-4579-a33d-f1b5cc8943bc@amd.com>
 <6eb0ec90-5859-4605-8a2e-657f6f711d61@intel.com>
 <825ddadd-6770-46b5-936e-f17988534984@amd.com>
 <13e1e1d8-5870-44ea-a800-e5b25bafd344@intel.com>
 <4a0e64e9-57c5-4f30-97bf-00c3eafe0b8f@amd.com>
In-Reply-To: <4a0e64e9-57c5-4f30-97bf-00c3eafe0b8f@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4840:EE_
x-ms-office365-filtering-correlation-id: f4750f2c-5bb3-434f-5581-08dd5b954bd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?VjlRTllMd0dsRGxVWUFsVW1yVFAvUit0OXdlN21SOERkWXhWYTM5QVhsYk13?=
 =?utf-8?B?eWFucmJ2cHNaTWU5ckIwQlhCZVZsZy92RjNYMzA1SWUwVmVZUjJzVkpEdWVF?=
 =?utf-8?B?UEkvTUJpZGdrUElrSysrcmtUZGNxRjJ6WUNGcnpFUEhYQWQ4Wkpxc0w4d09O?=
 =?utf-8?B?S2xzWDJDR2F2L05vRWlZRlBBcTQ5eXdFcGRuaEpma2Z2UEZWR1dOVDhCeUtT?=
 =?utf-8?B?N0NLeGVYR1BYOU5LbERBMTdYM2dUTy9iYnA2bWpwbjlYbUh0aXd3U1Jua2Zz?=
 =?utf-8?B?a3ZkU1ZqT2lkWG5KWStWSWo5NmMyeDc3UmNXVktTNnVmTDl1dHVtRHUrcklw?=
 =?utf-8?B?c2hGL1NXNXF4VG5aOElnZHFZK3h1UVdMQm1sSENGWUVYa25yajcxeWNVaDBH?=
 =?utf-8?B?bEdBblp0VTBWTXpyOEduRHJVZElWK1ZnUDY5VTdpcDRTQUI1OVdZbGlSKzRZ?=
 =?utf-8?B?TWFsYkxMVm14RUxWL204NHgrRnRNOXJYdkpoMUJMUDMrdDY4bllYVS93NUtF?=
 =?utf-8?B?ZnFWSk56N2xJZmpHTFg5UTdSSzZVV1A0Q3VBc0NGWlo3UVVBNGtjU2JHOW1w?=
 =?utf-8?B?VHF2RldrRXhld29RYytmTmJWamJ3aTJITXRsc1ZyYTZORHE0UTgvblJ3NFVO?=
 =?utf-8?B?UlZrWGZxZzJqdmRIbzM3UFl3bGV1dlVGdy9JNDQ5UU5DTS9EaENXM1RrY0Rr?=
 =?utf-8?B?OFJ1RW1ucmhtckU5bW0xbzNYSTlHczBGZVozZXVKZjRzTThvaW1uc2tHMVlN?=
 =?utf-8?B?cHJ4Nm1idXVwbEdOS00waDB3NTZ0NS9ZMWtBMy9CTjc0NUsvNG1NT1h4UVll?=
 =?utf-8?B?cVJJaDQ5SkhSOE54VExWN1cyQW9RZjM1bndQaExuUERMQ2NjbmR2Z1BDR0Rm?=
 =?utf-8?B?NktWRHBMWDU2bVFuYTIyQWpwb24ydVM4Uzd5dng0aXp2MlplRkhQUlpKOVox?=
 =?utf-8?B?bGhWNkxDejVWUEczbGRUdTNsQkdKcmJubEhQNTU4QXZJL2ZxR2VLT1VXSEZI?=
 =?utf-8?B?bFk4V0ZQT29SMHNrVFhPZGVHcXQrL05YTzhUVXlRKzRHWmNIWERNaXZGbjB1?=
 =?utf-8?B?elNNQ3l4TWtLUFVGV01ITDRabE56VW9uMlh4aVJrdjZUMWJmYjM0WHQ0Q1Zr?=
 =?utf-8?B?NzZsbzNBbVI4cjg5Ym84eGxuMFBsbEFtY2xKd0RMd28wTFJuMW1EU0ZaRjlT?=
 =?utf-8?B?MVA4bEd0VHdBOGN6clE3YXJZZDE0V0pNNE1UUDUwaE5UVTZlY1hQOWJXNXpK?=
 =?utf-8?B?ZnUzVDF4NmoxY0duQ0E1NHUyTG81VStsTTVWUGZUem5PYldQM0JIUllKeXVP?=
 =?utf-8?B?bHJCREdDVVdFc3FDUlI1NXNhcmF4aVlBU0dVM3dSWnVTVzloNkt6K2tLSDlm?=
 =?utf-8?B?czkwTHUvU212dUZWY2RkaExPY2hOb0tPUmllMGJoV29EdStqZUFZdVFYbEFY?=
 =?utf-8?B?dVB1elZHbjBiSkl4Q2RGK3dkVHRFNHFqQlV0NHFjM2ZnWWl4QXNOQU41S3ZP?=
 =?utf-8?B?czc0YUV6QXJ2MDlyK2hrc1lDSUVHbmpMN0hsMG40bURiaTRnK2hQZG5LcFZS?=
 =?utf-8?B?NGFLM2xDbnJVcTYzVGl5SCtlUTZwOW9qQ0p3NnVKVmk0RnV3eWMvVXZXam5V?=
 =?utf-8?B?RTh0S212TklFTVF2ZGluL092Q1o5cDQzU2NKWnVCSkdLRysyRnVSZ2JTeEw2?=
 =?utf-8?B?a3ZUTUIyd2wwckFEaGV6Qk1DS3ZUSDdTbkZCVThHcEl5TFhyZmZxRlg3dkNV?=
 =?utf-8?B?L2FuRlRnUlVCSWZGbkc3dWNHbC9RcFZZeWtqLzNnMVFEdnQ5RnNkNmcxT0Y2?=
 =?utf-8?B?emRwdVZPSFVsWlVrU0JuZE92RUhnRHRGWkRRT2w2ZUVZa0RhMkNSSGVvdk1m?=
 =?utf-8?B?ZzRvWWNia3VPS1ZkRzJzUlFxOEwzTzl1Q0VsNjlhaVBvc2pieWVPREZvTDV3?=
 =?utf-8?Q?HHIP2JagruckBhic9WQDWsr18brXWZ2m?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d09PUm91bElTRUNXTHcvcWZPT1I0Sk1na3A1VGhpSGl2Nk9IK0dueXNUSUdJ?=
 =?utf-8?B?RzNaeTJSdndXUWJhTmRBNFBjQW1ISUV5L0I3cEZCRUNCN0YwUTlKNHB0OGM2?=
 =?utf-8?B?YjlObVlRUm05TVRIZG9Ody9tMnJjLy9ENURzQ3ZuSDFaQ2FqZG1tZXJMYkwz?=
 =?utf-8?B?Znkvc0NGK0lJYXphMjYyVjBMb2UydXVNdFlKMHc5c1BxeGF5WUVqUkxGSWtX?=
 =?utf-8?B?WlEybEgxMUFSNVNEMDdwSzVheDZvbGZsWDFIQmNJbmhTbjNEVm5SVTRhNEI3?=
 =?utf-8?B?bHA0bi9uay9SUWxDVzV3VDlIUGprWFd1YUYySzROdmpkTlFsTDVmdW9IeWQ2?=
 =?utf-8?B?OWNIcjBlZ0t5VWVOclVXMFhTV3l1Ukp0d2o1c2d4THhicG4vd2grQ2hUam9m?=
 =?utf-8?B?dlhGeTNndnA0S2ExblJndzVPSVlSaU8yRC9OZmhBeU1Md2ZGUnlkUHZPSXBx?=
 =?utf-8?B?TVd1eU9jUjJKMnB2aUQ2Q3N5K21YUlVXWFo2QTBETVlUaVpuSUp3QkMvc2lB?=
 =?utf-8?B?RVN1MGtyMW9MMlJDeFllbkhNMnU1bVhJT2ZWNXVBUGY1YWVaWjRISjQzMG5z?=
 =?utf-8?B?OC9DMnlNamJCVURTZDczUFlLQUpURll5amQxTWErT3NFUnZOZUFiYXVYQjB6?=
 =?utf-8?B?eE8ySnZFaUh1dmJlb2xkcHVHejlvMUswMTVhZmsvOEt5SUNVZHlZOHZLTzFi?=
 =?utf-8?B?VWoyM3NyUURpUWl2cWkwVmdXOXU5ZE9jNEhpOFVCZmpjMm02MTBOSUZUa3k5?=
 =?utf-8?B?cUFmMXFPTEl1bjBYV3VqQU5SS3pheGR4a2FGUW56N1VXcW0rTVYzTkd2VjFW?=
 =?utf-8?B?NU9kWW5xL0Z2L3Z6NHB4R3ZYOSs1M1BGRU1DckZQWU5uQ3Exenkxc3dMNG5D?=
 =?utf-8?B?VFBaOG9sOGVRL05LWDZjc0NPQWZ5SnNsNjVJK2VPUEFHL3NZbDJEL1BUdnF5?=
 =?utf-8?B?bXBWYXE2WTYzQ2ZvbG5RTnZBaUVVOGIvaDJQT0t5akU0TWIzb3Zsa2NWT01L?=
 =?utf-8?B?N003TlZuUVdaSTBCc1l3a3JndWlGbkNFSUk2b3d1czUxOXJVem81cGZteHRw?=
 =?utf-8?B?ZnBBdXcybjhUemlQU0R4Rythb1J1MlpFTW1XdVBuSjFUR2tyQnpwTVhlVVZk?=
 =?utf-8?B?MFJyQUxDNzFKSEttSkpwN3plVG9lSzRpdi9kb1Vla244emMxaVd1Zk05cXF1?=
 =?utf-8?B?a3hxc3VEWlhkcUQyQXpuc0xTMExMV1RpK2xsMk5VaTlraFZISk1FMUQzMTAz?=
 =?utf-8?B?U0FlSzRHZ1JDTE91eHZPQXFSd09Ec2swbjYyRzBhd09wQVZKZzRSUlZJRmpF?=
 =?utf-8?B?a2tTcTJtbDZncDZNbFp0MytiV0xVRUEvemVEcmltTUNHNjgwdWtBbUwxN09L?=
 =?utf-8?B?cXNJKzUwQy8vWlMzdnRadWhkQU1vekpYQThJZG9YbGZ2eDVjOFhISGdmVkNx?=
 =?utf-8?B?UlFqMkwxKzlBQlVLb1JJTkN2QlJZNU1Tc2JadGp5ZWg0UEdja3FKVlczSkp0?=
 =?utf-8?B?SWE3L2N6UjN4QXBFY1RUcDVONjVET0NYd2RoVFNrbmt0Zng4SWU2NXp3Z2RY?=
 =?utf-8?B?UkdTL0NrV3J6Mk9zWkhvVTUyQWQvdmVVTms2eks4WG50Z3VwZUkyemtEMmJH?=
 =?utf-8?B?d29xOUsxUjlmYVcrTVhQVW0rK3gxbURCSUdnN0lGN3FHUzdaM1JYOVR1TmF0?=
 =?utf-8?B?aDdzTHkzUDZxVzMvbDUrRE1DdkpZOUJGdWZUUUFMRXZwS01JRC9GUzVGZXhZ?=
 =?utf-8?B?THl1elBtN1h2cnQ2V3ZEQWk2VEhZOFdBQ0xkOTJOb3hpTmhDUCtJYUEyM2RM?=
 =?utf-8?B?SHJ4Z1Z2MnhnVHF0b1lkU0JTRGRUbC9PdjNmQ2lMOEE3V2VERjVvREJIMW0w?=
 =?utf-8?B?Z0NCcmxkbkdzdDlWOFFkbUs5bW1ZQlNsVnFFNUQvZkNhUDdpQ2tQU0g0ZTJZ?=
 =?utf-8?B?cFMwbnZDaDd0WUFiWHZjVWtSbVVQVkY3QVBUVHZKNkdnREsrdnpmR0R5RzMw?=
 =?utf-8?B?bVZIYW1vTTMwcUJwUWQ3TmpYRVQydCswSW16eDc2ak5mMGFqdFdEdVBYRDJU?=
 =?utf-8?B?eUhoNWRNcHZhV1ZwenNndmw4bi9KenpUZEI5K2tnR3NkTmY3SlZ1Wld4RzBJ?=
 =?utf-8?Q?bB/+YBJUc/zqFY+d4y4rGat/P?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f4750f2c-5bb3-434f-5581-08dd5b954bd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2025 03:24:53.6584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTv9NEIMxf1Pu4jYGQZL/VSIkblcPyYRv0m7XV+WtJie56Xg5E3pRoLXCnJv9YG3ar82/WXo27d8thrlpJu3jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4840
X-OriginatorOrg: intel.com

PiBGcm9tOiBWYXNhbnQgSGVnZGUgPHZhc2FudC5oZWdkZUBhbWQuY29tPg0KPiBTZW50OiBNb25k
YXksIE1hcmNoIDMsIDIwMjUgNzo0MiBQTQ0KPiANCj4gQ3VycmVudGx5IEFNRCBkcml2ZXIgZW5h
YmxlcyBkZXZpY2UgQVRTIGFuZCBjb25maWd1cmVzIElPTU1VIERURSAocGVyDQo+IGRldmljZQ0K
PiBzZXR1cCkgZHVyaW5nIGF0dGFjaF9kZXZpY2UoKSBwYXRoLiBUaGVyZSB3YXMgYSBkaXNjdXNz
aW9uIHRvIG1vdmUgZGV2aWNlDQo+IEFUUw0KPiBlbmFibGVtZW50IHRvIHByb2JlKCkgcGF0aC4g
V2Ugd2lsbCBtb3ZlIGl0IHRvIHByb2JlKCkgcGF0aCBzb29uLg0KDQpCYXNlZCBvbiBkaXNjdXNz
aW9uIGluIHRoaXMgdGhyZWFkIEknZCBleHBlY3QgZG9pbmcgaXQgZHVyaW5nDQphdHRhY2ggaXMg
dGhlIGxvbmctdGVybSBkaXJlY3Rpb24uDQoNCj4gDQo+IA0KPiA+DQo+ID4gT24gdGhlIG90aGVy
IGhhbmQsIHdlIG1heSBqdXN0IGRlZmluZSB0aGUga25vYiBhcyBzYXRzIHJlcXVpcmVkIG9yIG5v
dC4NCj4gPiBUaGlzIGlzIGp1c3QgYSBrbm9iIHRvIGxldCBrZXJuZWwga25vdyBpZiB0aGUgaW9t
bXUgZHJpdmVyIG5lZWRzIHRvIGVuYWJsZQ0KPiA+IHNhdHMgb3Igbm90LiBXaGlsZSBsZWF2ZSB0
aGUgQVRTIGVuYWJsaW5nIHBvbGljeSB1bmNoYW5nZWQuIFRoaXMgbWVhbnMNCj4gPiB3ZSBuZWVk
IHRvIHByb2JlIHRoZSBzYXRzIGNhcGFiaWxpdHkgb2YgaW9tbXUgaHcgYmVmb3JlIGNyZWF0aW5n
IHRoZSBrbm9iDQo+ID4gaW4gc3lzZnMuDQo+IA0KPiBSaWdodC4gTGV0cyBzZWUgaWYgYmVsb3cg
ZmxvdyBjb3ZlcnMgYWxsIHRoZSByZXF1aXJlbWVudA0KPiAgIC0gRGVmaW5lIG5ldyBmbGFncw0K
PiAgICAgSU9NTVVfSFdQVF9GTEFHU19TQVRTIC8gSU9NTVVfSFdQVF9GTEFHU19BVFMNCg0KU0FU
UyBwb2xpY3kgc2hvdWxkIGJlIG1hbmFnZWQgYnkgdGhlIHN5cyBhZG1pbiwgd2hpbGUgQVRTIGZl
YXR1cmUNCml0c2VsZiBjYW4gYmUgb3B0ZWQgYnkgdGhlIHVzZXIuDQoNCj4gDQo+ICAgLSBFbmhh
bmNlICdzdHJ1Y3QgaW9tbXVfZGV2aWNlJyB0byBpbmNsdWRlIEFUUyBmbGFncyAoTk8gQVRTLCBB
VFMsIFNFQ1VSRQ0KPiBBVFMpDQo+ICAgICBpb21tdV9kZXZpY2UtPmF0c19mbGFnDQoNCmFzIGNv
bW1lbnRlZCBieSBKYXNvbiB0aGlzIG5lZWRzIHRvIGRpZmZlcmVudGlhdGUgZG9tYWluIHR5cGVz
LA0KZWl0aGVyIGR1ZSB0byBodyBsYWNraW5nIG9mIHN1cHBvcnQgZm9yIGNlcnRhaW4gdHlwZXMg
b3IgdGhlIGFkbWluDQppbXBvc2VzIGRpZmZlcmVudCBzZWN1cml0eSBsZXZlbHMgYWNyb3NzIGRp
ZmZlcmVudCB0eXBlcy4NCg0KPiANCj4gICAtIER1cmluZyBwcm9iZSgpIGRyaXZlciB3aWxsIHVw
ZGF0ZSB0aGlzIGZpZWxkIChzaW1pbGFyIHRvIG1heF9wYXNpZHMpDQo+ICAgICBJZiAoSU9NTVUg
bmVlZHMgU2VjdXJlIEFUUyBhbHdheXMpDQo+IAlpb21tdV9kZXZpY2UtPmF0c19mbGFnID0gSU9N
TVVfSFdQVF9GTEFHU19TQVRTDQo+ICAgICBlbHNlIGlmIChkZXZpY2Ugc3VwcG9ydHMgQVRTIGFu
ZCBJT01NVSBzdXBwb3J0cyBTZWN1cmUgQVRTKQ0KPiAJaW9tbXVfZGV2aWNlLT5hdHNfZmxhZyA9
IElPTU1VX0hXUFRfRkxBR1NfU0FUUyB8DQo+IElPTU1VX0hXUFRfRkxBR1NfQVRTDQo+ICAgICBl
bHNlIGlmIChkZXZpY2Ugc3VwcG9ydHMgQVRTIGFuZCBJT01NVSBzdXBwb3J0cyBBVFMpDQo+IAlp
b21tdV9kZXZpY2UtPmF0c19mbGFnID0gSU9NTVVfSFdQVF9GTEFHU19BVFMNCj4gICAgIGVsc2UN
Cj4gCWlvbW11X2RldmljZS0+YXRzX2ZsYWcgPSA8Tk8gRkxBR1M+IChNYXkgYmUgaGF2ZSBvbmUg
bW9yZSBmbGFnDQo+IElPTU1VX0hXUFRfRkxBR1NfTk9fQVRTKSA/DQoNCkhlcmUgdGhlIGRldmlj
ZS0+YXRzX2ZsYWcgc2hvdWxkIGJlIG1vcmUgYW4gYXRzX3BvbGljeSB0aGluZz8gQXQNCnByb2Jl
IHRpbWUgaXQncyBhc3NpZ25lZCB3aXRoIGEgZGVmYXVsdCBwb2xpY3kgYWNjb3JkaW5nIHRvIGRl
dmljZQ0KdHlwZSwgcGxhdGZvcm0gcmVxdWlyZW1lbnQsIGV0Yy4gYW5kIGxhdGVyIGV4cG9zZWQg
dmlhIHN5c2ZzIGZvcg0KYWRtaW4gb3B0Lg0KDQpBY3R1YWwgYXRzIGVuYWJsaW5nL2VuZm9yY2Vt
ZW50IGlzIGRvbmUgYXQgYXR0YWNoIHRpbWUsIGFjY29yZGluZw0KdG8gYXRzX3BvbGljeS4NCg0K
PiANCj4gDQo+ICAgLSBCYXNlZCBvbiBkZWZhdWx0IHNldHRpbmcsIGtlcm5lbCBjb21tYW5kIGxp
bmUgb3B0aW9uIGFuZCBwcm9iZSgpIGRhdGEsDQo+IGNvcmUNCj4gbGF5ZXIgY2FuIGFkanVzdCBB
VFMgY2FwYWJpbGl0eS4gaS4gZS4NCj4gICAgICAtIElmIHdlIGhhdmUga2VybmVsIGNvbW1hbmQg
bGluZSAoc2F5IGlvbW11LmF0cz08eD4pLCB1c2UgdGhhdCBkYXRhIGZvcg0KPiBhbGwNCj4gQVRT
IGNhcGFibGUgZGV2aWNlLg0KPiAgICAgIC0gSWYgbm90LCBhcHBseSBkZWZhdWx0DQo+ICAgICAg
IHVudHJ1c3RlZCBkZXZpY2UgLT4gZm9yY2Ugc2VjdXJlIEFUUyBvciBubyBhdHMNCj4gICAgICAg
SWYgSFcgbmVlZHMgU2VjdXJlIEFUUyBhbHdheXMgLCBlbmFibGUgU2VjdXJlIEFUUw0KPiAgICAg
ICBGb3IgYWxsIG90aGVyIGNhc2VzIHVzZSBBVFMNCg0KdGhpcyBpcyBhbiBpbnRlcmVzdGluZyBv
bmUsIGkuZS4gd2hldGhlciB3ZSBzdGlsbCB3YW50IGEgZ2xvYmFsIGlvbW11DQpvcHRpb24gdG8g
ZW5hYmxlIHNhdHMgZm9yIGFsbCBhcHBsaWNhYmxlIGRldmljZXMvZG9tYWlucy4gdGhlIHByb3MN
CmlzIHRoYXQgaXQgaXMgc2ltcGxlIGFuZCBhbGxvd3MgdW5kZXJseWluZyBkcml2ZXIgdG8gYWRk
IHNhdHMgc3VwcG9ydA0KYmVmb3JlIGEgbW9yZSBmbGV4aWJsZSBzeXNmcyBpbnRlcmZhY2UgaXMg
cmVhZHkuIHRoZSBkb3duc2lkZSBpcyB0aGF0DQppdCdzIHVuY2xlYXIgd2hpY2ggZGV2aWNlL2Rv
bWFpbiB0eXBlcyBhcmUgYWZmZWN0ZWQgYnkgc2F0cyBvbg0KZGlmZmVyZW50IHBsYXRmb3JtcyB3
L28gZGlnZ2luZyBpbnRvIHRoZSBodyBkZXRhaWwuLi4NCg==
