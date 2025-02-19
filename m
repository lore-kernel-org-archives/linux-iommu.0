Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B95192B66
	for <iommu@lists.linux.dev>; Wed, 19 Feb 2025 08:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739952133; cv=fail; b=iPkUQosYRv9rXiIlawQElm0ZKt2981vXQFHMDaKB8A+y5FzL3OLN/YULYGBcupegbgKYS557wV23FVpbUpbo8PC1brdNZuaTkTa8ee4V026yPF/ZrLjo8GY3bWnfk7FLenX7k6POuI4C7AfmFURJoDZjrax4ONqHRsDg/2NNd1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739952133; c=relaxed/simple;
	bh=NsJSsQMN/In57RNCcg5yxYIbsURODk1INtT1JPXfewk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eNl+oK0hvUKq+7t/LJnTIyiJ5dRsj9ADYbwHs46nBmuQ6pYG2RBNH3EnPpd2dj2ZGKcpxOqzurRYNTpwlW5zPlTcvC8KbtB1FaBvdeaH+2Ka38VrPTZEPFjotwlFiuJGp5MMMAtaJC64RDUcHqjsWlTAlm70B/KuwVDyHTFqC/8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Or13e8OT; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Or13e8OT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739952131; x=1771488131;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NsJSsQMN/In57RNCcg5yxYIbsURODk1INtT1JPXfewk=;
  b=Or13e8OTbNP1IePql7wwr1cL3y+onXoQKpOnFDvet7ello2DCaldtN0m
   LiXmU13KabDaNGTBCJ+LeoM4U0DbBzAWGX1BJJ9Z+rNrPBN6PaGSWpDTt
   2yMf/tKCFyyeSGsQsi/hXCiSqfIt7VdMPaNehpEtuxuv5TvBi79ikI0h2
   rppN1mqQRvHXFKZPsZRV8Ox3A6KF317yP3OUnAdd0Ct62ZL2GRvdHflfT
   YZRI4VuKc/mKE+bjdYh6jLy6F/SO11ZHd8Yf1GrUpsU4pQLQnW4BI9P9E
   esJZqL1L0uBaCHTGJTVup8sLzclwCgQXOcIqFNCzX/alJJO0ThEf19VQT
   w==;
X-CSE-ConnectionGUID: /wIbqzBPT9qylRxG7XLYsA==
X-CSE-MsgGUID: WXC1P+ECQqWvgluiRuorgA==
X-IronPort-AV: E=McAfee;i="6700,10204,11348"; a="66032821"
X-IronPort-AV: E=Sophos;i="6.13,298,1732608000"; 
   d="scan'208";a="66032821"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 00:02:10 -0800
X-CSE-ConnectionGUID: DgnddvcxQ9CURNNb8FbcVQ==
X-CSE-MsgGUID: jZp53/woR6G0MUPP11tBPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115118280"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Feb 2025 00:02:10 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 19 Feb 2025 00:02:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 19 Feb 2025 00:02:09 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 19 Feb 2025 00:02:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flDRvKF7i5jM5zYAt5YAFer0ODml4CLUjln1erTnoDqxG87qFpYTAG1MtCrhF4XYl99Y9fnWbYQRgOxTG5jCXBELK8pHKVdn/GNFjiObw5e3o58HOk7EOCiC3J63jkLDKGJMYXrgvb+KOYttcLoPpOarNMzsmAA5oc0UGaNccL5fzIg74KGIZCAWJBMGDaVxyw7yh6UtVTiDoriBl8j7ZZjC031GeuNFmtCd1LV6DiDEMJx8Ony5XR/paYR83OBsGLXvuJ07kjUEAYgmYKRNIobhBNdGxUYCxKOyywTquI8hFXNIDf0fD6hNdnKkCq+clVqrFNJ0ojRGe9ZMBfpPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NsJSsQMN/In57RNCcg5yxYIbsURODk1INtT1JPXfewk=;
 b=tyFTg4a/c9laSlXoeGr0M8xvCkTZ0EArEIoEYM6xYkOlUlYX9POwfdmSRbP4KhKVhKg52geGaQVrb6999+5LqFfbLb8iXXFp81jOOJeDoFsO09Tl7lggJKkqXCKV46lKkcavtCChYFuxHi9ikTmlzeBwULVRbErhkXckhPJpzq/XMD2ddO5thWHE2e41SYIDeuo8JbUPP3bJTnQX/htmP7QH7H7oUOL/RZUbrve/8pvRCQjpsGQPvKoWxlIB7zfAnr/COh5d536QLGCDQNDDFzA0oo2jsBLMDUqEB4rq/BktgbUpmFHYWkoL9kCr8WJkJYJJym5K+Hft0niAoHKKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB6861.namprd11.prod.outlook.com (2603:10b6:303:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 08:02:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.013; Wed, 19 Feb 2025
 08:02:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	Baolu Lu <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Thread-Topic: [PATCH v6 09/14] iommu/vt-d: Add IOMMU_HWPT_ALLOC_PASID support
Thread-Index: AQHbUhnPTImkeHGAuE6mCT9lTVfS6LLzJwYAgAIkjQCAAOGBgIAAOg4AgAAtiwCATQv7gIAAVz2AgAFizQCAAAQXAIAJQwtA
Date: Wed, 19 Feb 2025 08:02:03 +0000
Message-ID: <BN9PR11MB5276770D48B7B4C21A2BCB448CC52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-10-yi.l.liu@intel.com>
 <f4c1ca6a-4ed5-49a7-b399-dd148cfb16bd@linux.intel.com>
 <acb2bead-1597-4fdd-b949-26eab2e62b0a@intel.com>
 <38e26d9f-0727-4b15-8e1d-03d262c15c8c@linux.intel.com>
 <c10755cb-6966-479b-b68c-9bc022c894d9@intel.com>
 <5c5180cb-9bbe-4fa7-b109-5dad2ca9516a@linux.intel.com>
 <bd1655c6-8b2f-4cfa-adb1-badc00d01811@intel.com>
 <95ab1ac7-f0a8-4b9d-b88e-72ce0d72ca98@arm.com>
 <deb77d13-5722-49fe-a5a7-8ba6bc370763@intel.com>
 <145b2f93-58b3-4484-b6b5-9216d4d21e1d@arm.com>
In-Reply-To: <145b2f93-58b3-4484-b6b5-9216d4d21e1d@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB6861:EE_
x-ms-office365-filtering-correlation-id: e5c7b74e-8509-4cc7-ad55-08dd50bbb281
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?M05ZbEQ0SUNWaWpJR3NUR3hrbUFhckV0aDYyOEY5NDJVS3FxZUI2TTdQZlJG?=
 =?utf-8?B?aU9wSTNTT2pWK1NJVzBPclJxa0FLbzQxT0U4ZlRlRkp6VmJYbWxIaHFkU2tC?=
 =?utf-8?B?MENVQXZ1RVBVL3BSSlRKb2VCZXJGbnp5djcwZWtjeUtROSs4UzZ3RzFSRCs4?=
 =?utf-8?B?SmVxVFRGSFkxOXZZQUJMNkF2WlpzZHBxR2pvUG8xVzZGUjlWdUdhY00renhy?=
 =?utf-8?B?OWpLQ2trRFhmYWJQTWhoR24zcWNDdzRYWmZSZ3lWeW40OG9GZ08vVnhjQjhk?=
 =?utf-8?B?bzE1SlZSekVHUU9WNWxTN29OSHF6UVJjWGxHQUZhekg1Mm52TVgvL2dGbU1V?=
 =?utf-8?B?dU8zZzVtVVJFdTRvVWxVR2U1ZWRBWmJrWWM0cFhXOGlBbHQ4SXZQVHh4cm9G?=
 =?utf-8?B?a2RQWmN6UTVDcmVoQlR6NTFNS2RzUGljelJRMUlaU2lZdjNpdFJZWjVUTmFD?=
 =?utf-8?B?NFhyaE5GQXdiMlpEditiaVZ4aGlKcUV0QkUya0xta3hjM3I4WUVTZ3Y0YlJS?=
 =?utf-8?B?RU5qbkZCMmZNYktnZVB0Q1VJRW1jeUtoWmRMUFBWS3hkRUNNdDF4NTkxaHBX?=
 =?utf-8?B?aTRDZDRnenZrY21PVnQzUERBeUVwMVI5UkVwdnQ1dVpxU0tVL1lxbE05aU13?=
 =?utf-8?B?a1lzSDhUNlJKTnFVMVZhS21YSXZ1L2hZMjBidWRPdElIb2oySnZRQlg3aUVH?=
 =?utf-8?B?b1lNbUwyb3ZOcHlVbW5neVMvWXkwcnZia1JFUUhJQURRMElqOXhWYjNzOGp4?=
 =?utf-8?B?UkxBa0dYaTQwcXRtTy9obFNzaEtnWGc5VnI2S24wMURROXV0NDNVc1BWYUE4?=
 =?utf-8?B?TU9Tb0t1ZDYzaS90ZmdSS2dGZ2dubEFTdE9sanVSSUNEUjY0SkdMYVBNS3RH?=
 =?utf-8?B?eHprRkUrakVqK2N5dWVackJtVmdmTkVOWVR0UVpzenJtSmdpN3R3ZEFzZERz?=
 =?utf-8?B?cVNSUTJvUVFxNC9MTVNVY0QrbEdId2lVUmhlbFpEVTZSNGlYOTdMV0M0NWFp?=
 =?utf-8?B?bmdrbTFkM0Nub2N1elJTQldHUE9rZUNXbytiWnd1cWJsUnZ4ZDBuN2g5Nkdm?=
 =?utf-8?B?K21obHN4cm85VyszMnIxUWtPeWdGcktOcVYvaVB6UVVEbGQ2NGpRYW1Rc3dD?=
 =?utf-8?B?WDRBOFBWMDk3NnNLZGcvR0hLaFF0ckEyWUZ2UXF2Uy8ySE9OQndQVUMzclN2?=
 =?utf-8?B?OWw4YVRaM21rZ09yWkRPQkdRclBHWVFyK3F5bXBheDVFSmg5QWdTcDVya0Ev?=
 =?utf-8?B?SUE0dEkrMjlKbXZsTkNaUElyeGVnUWVHcldFYm9tMTVjWGRXZytqVm0zd2hL?=
 =?utf-8?B?WVU5YTFpZ0wwck1GbGxHMm1scm1YeU9uNU5KMXMzblZrM1VpeXhIZWV4a3VK?=
 =?utf-8?B?SC9UWlhtUGEvU2NmZlRuRjFYVVNncG1rWVRkK3dFZzg1Kzg4WVpqYmwwazZw?=
 =?utf-8?B?WStPMVdSanBjdUV5TVJzeHJvU29UL1R2dXg1V1JjSXhKNE0xTjEyWkFPRWti?=
 =?utf-8?B?ay9PVml4eG5DbGR1aUgzWWdTOXV5VVBPRFJLcWExYy9yTDZvSVZQeUc3cFQy?=
 =?utf-8?B?cVB6TERaN0RycGloRjg0K2I5MGhoTTM2MXZ0RFVtOVJSZ01RTUYyZnl4YlNV?=
 =?utf-8?B?d1ZxNkJNWWVmUDMyaHg0elBhcmRBTWtxdElTdGF5akRPRndGSnNCMlEycDcz?=
 =?utf-8?B?ZTdLVkdkQXJySHRsVVBQZk5PdERhcW9qNUZxcThBc2NHM3d2c1BZRERmcWlm?=
 =?utf-8?B?b0xSVFRLZTdsaXh1dzN0K2JabjBuazVRc1hPNU1UbGdzQ3pmRUM5YkkxVkx2?=
 =?utf-8?B?SFE1ZENYV3RkcnZDQStZVDg2bUNUdFErbHYrVnZNODcvTXJRRlZ6SjJtaWFG?=
 =?utf-8?B?RkhlY25ocHhuQnhyTW1xd1p6bElBUGtodGR1aExvS1BFVW55aEZRUksvSTl6?=
 =?utf-8?Q?JITruOi9us/dTV2QNDyDOz+oN1rMZNHN?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bzVkVi9xT3FIUU0wU0dDUjBBTGFpT2gwVWdpNFlKTm94YUpDY2JwelZ1b2ZX?=
 =?utf-8?B?ZkR0alJES3lvQW9Nb203YVgrQmU5OTJUNHpVbnZ6WTI4bWVlRzFQUlRnZWs1?=
 =?utf-8?B?QkgvcWZTUm1GMEVVeGlaRm1SYTJUa045alFSQXNPbWJhQnF3Nm9VaWR6QnFa?=
 =?utf-8?B?RE01WGxpYVQ3UUNJMlNZU0NZTGd2alNzc2VCMm5QdEd3QzE2RjR2ZURFRE1M?=
 =?utf-8?B?azBVVDZaeGdKWkpab3JqSE52MGhmejltRWltT0JlVjcrZGVXc1Z0S3RwSVpQ?=
 =?utf-8?B?c21GdFZLZDJFeWl0b05udTc3UXV0ZExBS3VUbmszUTZGRUFRTDBnSU90Wk9R?=
 =?utf-8?B?V1Z3SThJSXh5SzJWeDVrRTFtUlRsRkpJK2dxZFVXTnZNcmc2M25CMHhoeGJN?=
 =?utf-8?B?M09kWll1Zk95azZhRS94Y0tSRTRSc1NLQUlmaGRZS3pIaEZmS0V3cVJaM1dk?=
 =?utf-8?B?b2plRDJZTzVHdTB6bDRqKzRxdEZteHgvK0JIZEN1SHJrNDhzSS9HbUdkUlpT?=
 =?utf-8?B?QUI4WWNmOHpETGs0eDlkTFJ3ejJpNXZWTXZOQURYbXN2YlJVWXFkRVZDTWEy?=
 =?utf-8?B?d2lBU3BkVXd0dHAxVzUrZjdJMzI3WmdMa2JNQkYwNDNNL3VEM2RWN0ZYVzUv?=
 =?utf-8?B?R2w5N3ZvbmtZZWJYMEhhSmQ5Nzg0OE9sRjE3bUo5MzVVRWJrT285TDRXVmFB?=
 =?utf-8?B?R3Z3SEoraEh4M04wc2FRNVdRN3h0TmQwYTlncnYxVHdVa0ZMc2JGTmZ0MzVh?=
 =?utf-8?B?NVdIOVhNSFl0UVVzb3FjeTlVakdnQlVGLzdkd3BYTVBScGR6S3RUeDVSaE5X?=
 =?utf-8?B?cEUvSnhKbUhESDhVa2RMSjFsajF0L0E5RkNINzkzdzVuNEc0c1cyTG1aM09X?=
 =?utf-8?B?d1BpcTJtNFRidThsQkxFeUpsMUpURldSbnJ1ZGlmOCt0bnFSVmF1SFdOM2Iw?=
 =?utf-8?B?QkxaWENJdW05a0V3T0k0eU42b3ZtK2NDSHNjdTNEM3V5NiswdWFleU9Dd0Zj?=
 =?utf-8?B?SlM1Vy8wRnAzSWZnMzlCcWtEdEVReVVqOURkS0U1WjVTWHNoZWIxVmszL0pE?=
 =?utf-8?B?bTRzSFJqY3NGcFRqbUZVamZrV290eCtsQkZqUm11aTgxY1E4eHNJR3hnbk0x?=
 =?utf-8?B?bnJxdHFZQU9sNmZ1ZktnR3VQVHJtRTA1dVJFSFVrdUtTSTlTc0ttT0FlTCts?=
 =?utf-8?B?VlhWQ25kdzRaQjVkdHV6bnZUWktpdzJBTkZtM2RIOXJYTnJaeWZYeEFoa1Zv?=
 =?utf-8?B?cXl2c0xVNUdaQVFmVkxPSnp4QzRkK3I1eklyTzhzQWpGZ3BkNmRtaVNHVmYv?=
 =?utf-8?B?T0I5SUR4UzAybkVEVnhNeUVnOXpIQ3dEZ3IwK2lzcWZrZWU5WFRrM25wZFRK?=
 =?utf-8?B?VWI5eFFMSFdMUEJjVUZGY1VkbVFlaVhDZ05iSFREdEYxVlQ3L1RoSHo3aXFJ?=
 =?utf-8?B?N0hSOExwa29BaHJ2M1l2VU40M2JKOVErdC9vUEVaeENvUWkrcXZyU3RzMzBT?=
 =?utf-8?B?UUlUWlBSem5KQndLSytuNGxibTExVTFlVEFPZWliR05wbmx5bytTaldDaHdB?=
 =?utf-8?B?dGZ1VjJreWtzTFVmQWZvNm9uaW5rTG5Zdk9vS2IrMTU5Nnh1MW92aFF0WURw?=
 =?utf-8?B?VHNTK1pPV1FIY1g2aXZHVlVObVIyem4rR25xT0hmbWxRaHd1TE5JRC8rbC8x?=
 =?utf-8?B?ZVN5cUdvMURZSnUzYW9mRDhvYWhpR1Y3U0UxR0pxN1hzZXVtcEw3V3B2dVBP?=
 =?utf-8?B?S2dZVERhbENLWXU3b09wMFRaYTJDV3RyWE9kSTlIY3IvYXVaVGhlaGoyK1FB?=
 =?utf-8?B?MDVWWXVkNENEeVI2U00yYW91Wm54cHJpOThZbDhidjd6a1kvTEJYNVBMZFNN?=
 =?utf-8?B?aVFMZ3lWUjVoUEV5bmZCVUE2WXg2ejhydGd3dEdvV3BXMndDdFZKSW1aTUsw?=
 =?utf-8?B?bHdMV1FyMDNJWUNjdHFLZ0dvWlVyeUJjMk03U2pCUTVvczgrTjB3d0tmNTVB?=
 =?utf-8?B?RVpYbEFBdGFWZkVpZmNCZE1TOVNCTDZQRUFSdTVNWTVyeXowV2hmUjdqU0Qv?=
 =?utf-8?B?OVhTRm4xWHF1enNsZFAyU1FHamRRbCttbFlHTFMvZ1VJeFhESGcyVkcwNlBz?=
 =?utf-8?Q?0jaTVtGRUKyhIAHKua8tPdFmg?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e5c7b74e-8509-4cc7-ad55-08dd50bbb281
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2025 08:02:04.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: njXyd/vCPyDYxhi6nRu45S+y4zSiYFIMwpd+1UM8eumBGhCtUuXAYWUa15xgkAn4jxRayqF6vxrEGENYKxn7bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6861
X-OriginatorOrg: intel.com

PiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgRmVicnVhcnkgMTMsIDIwMjUgNjoyNSBQTQ0KPiANCj4gT24gMjAyNS0wMi0xMyAxMDox
MCBhbSwgWWkgTGl1IHdyb3RlOg0KPiA+IE9uIDIwMjUvMi8xMiAyMTowMCwgUm9iaW4gTXVycGh5
IHdyb3RlOg0KPiA+Pg0KPiA+PiBZdXAsIFNNTVV2MyBpcyBtb3JlIG9yIGxlc3MgaW4gdGhlIHNh
bWUgYm9hdCAtIHdlICpjb3VsZCogcmVhc29uYWJseQ0KPiA+PiBtYW5hZ2UgdW5waW5uZWQgUzIg
Zm9yIG5vbi1QQ0kgZGV2aWNlcyB1c2luZyB0aGUgc3RhbGwgbW9kZWwgd2hlcmUgdGhlDQo+ID4+
IEZfVFJBTlNMQVRJT04gb3IgRl9QRVJNSVNTSU9OIGV2ZW50IHRlbGxzIHVzIGFsbCB3ZSBuZWVk
LCBidXQgZm9yIEFUUw0KPiA+PiBpdCdzIHRoZSBzYW1lIHRoaW5nIHdoZXJlIGJ5IHRoZSB0aW1l
IHRoZSBmYXVsdCBoYXMgdGFrZW4gYSByb3VuZC10cmlwDQo+ID4+IHRocm91Z2ggYW4gQVRTIHJl
c3BvbnNlIGFuZCBhIFBSSSByZXF1ZXN0LCB3ZSd2ZSBsb3N0IHRoZSBkZXRhaWxzIG9mDQo+ID4+
IGV4YWN0bHkgaG93IGl0IGZhdWx0ZWQgKG9yIGlmIHRoZSBQUkkgcmVxdWVzdCB3YXMgc2VudCBl
YWdlcmx5IHdpdGhvdXQNCj4gPj4gYSBwcmlvciB0cmFuc2xhdGlvbiByZXF1ZXN0LCB0aGVuIHdl
IHNpbXBseSBoYXZlIG5vIGlkZWEgYXQgYWxsKS4gVGh1cw0KPiA+PiB0aGUgcHJvc3BlY3RpdmUg
bWVjaGFuaXNtIHdvdWxkIGJlIHRvIGluamVjdCBhIHZpcnR1YWwgUFJJLCB3YWl0IHVudGlsDQo+
ID4+IHdlIHNlZSB0aGUgZ3Vlc3QgaXNzdWUgYSBtYXRjaGluZyBDTURfUFJJX1JFU1AsIHRoZW4g
c25pZmYgdGhlIElQQS9HUEENCj4gPj4gZm9yIHRoZSBnaXZlbiBpbnB1dCBhZGRyZXNzIG91dCBv
ZiB0aGUgZ3Vlc3QgcGFnZXRhYmxlcyB0byBzZWUgaWYNCj4gPj4gdGhlcmUncyBhbnl0aGluZyB0
byBkbyBhdCBTMiBhcyB3ZWxsL2luc3RlYWQuIFl1Y2suDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRo
ZSByZXNwb25zZSwgUm9iaW4uIEl0IHNlZW1zIHdlJ3JlIGluIHRoZSBzYW1lIHNpdHVhdGlvbi4g
OigNCj4gPiBPdXQgb2YgY3VyaW9zaXR5LCB3aWxsIHRoZSB2UFJJIHJlc3BvbnNlIHByb3ZpZGUg
dGhlIElQQS9HUEEgdG8gdGhlDQo+ID4gaHlwZXJ2aXNvcj8gSWYgbm90LCB0aGUgaHlwZXJ2aXNv
ciB3aWxsIG5lZWQgdG8gZGVyaXZlIGl0IGZyb20gdGhlIEdWQSBvbg0KPiA+IGl0cyBvd24sIHBv
c3NpYmx5IHJlcXVpcmluZyBzb2Z0d2FyZSB0byB0cmF2ZXJzZSB0aGUgZ3Vlc3QgcGFnZSB0YWJs
ZS4NCj4gDQo+IE5vLCB0aGUgUFJJIHJlc3BvbnNlIGNvbW1hbmQgb25seSBjb250YWlucyBhIFBh
Z2UgUmVxdWVzdCBHcm91cCBJbmRleCwNCj4gc28gdGhlIGh5cGVydmlzb3Igd291bGQgdGhlbiBo
YXZlIHRvIGxvb2sgdXAgYWxsIHRoZSBvdXRzdGFuZGluZw0KPiByZXF1ZXN0cyB3aXRoIHRoYXQg
aW5kZXggdG8gcmV0cmlldmUgdGhlaXIgaW5wdXQgYWRkcmVzc2VzIGFuZCB0aGVuDQo+IHRyYW5z
bGF0ZSB0aGVtLiBUaGUgU01NVSBhcmNoaXRlY3R1cmUgZG9lcyB0ZWNobmljYWxseSBhY2NvbW1v
ZGF0ZSBhDQo+IGhhcmR3YXJlLWFzc2lzdGVkIHRyYW5zbGF0aW9uIGZlYXR1cmUgKEFUT1MpLCBi
dXQgaXQncyBvcHRpb25hbCBhbmQNCj4gcmFyZWx5IGltcGxlbWVudGVkIC0gY2VydGFpbmx5IEFy
bSdzIGltcGxlbWVudGF0aW9ucyBkb24ndCAtIHNvIGluDQo+IHJlYWxpdHkgdGhhdCBpcyBpbmRl
ZWQgYSBnb2luZyB0byBtZWFuIHNvZnR3YXJlIHdhbGtzIGFzIHdlbGwuDQo+IA0KDQpJbiBjYXNl
cyB3aGVyZSBzb2Z0d2FyZSB3YWxrcyBhcmUgaW5ldml0YWJsZSwgaXQncyBwcm9iYWJseSBtb3Jl
DQplZmZpY2llbnQgdG8gZG8gdGhlIHdhbGsgZWFybHkgdG8gZmlndXJlIG91dCB3aGV0aGVyIGl0
J3MgUzEgb3IgUzINCmZhdWx0ICh0aGVuIG9ubHkgZm9yd2FyZCBzMSBmYXVsdCB0byBndWVzdCks
IHRoYW4gYWx3YXlzIGluamVjdGluZw0KYSB2aXJ0dWFsIFBSSSB0byBndWVzdCBhbmQgdGhlbiBm
aWd1cmluZyBvdXQgd2hldGhlciBzMiBzaG91bGQgYmUNCmZpeGVkIHRvbyBhZnRlciByZWNlaXZp
bmcgdlBSSSByZXNwb25zZS4NCg0KU29mdHdhcmUgd2Fsa3MgYXJlIGNvc3RseS4gUHJlZmVyIHRv
IG5vdCBzdXBwb3J0aW5nIFMyIGZhdWx0aW5nIGluDQpuZXN0ZWQgY29uZmlndXJhdGlvbiB1bnRp
bCB0aGVyZSBpcyBwcm9wZXIgc3VwcG9ydCBmcm9tIGh3IHRvDQpyZXBvcnQgdGhlIGxldmVsIChl
dmVuIGEgc2ltcGxlIGh3LWNvbmR1Y3RlZCB3YWxraW5nIGlzIG1vcmUNCmVmZmljaWVudCB0aGFu
IGRvaW5nIGl0IGluIHN3KS4NCg==
