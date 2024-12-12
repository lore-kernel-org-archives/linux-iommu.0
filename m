Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6BF29A9
	for <iommu@lists.linux.dev>; Thu, 12 Dec 2024 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733982417; cv=fail; b=hqkSzXGdhDf7vZtFlZ5z5VoiESU21uFpgO9NtvZEW50N70Y6qzjV0KyrBG+bAXV/70uPyMsXbvy9LdiKSqcJ/Dtk8jtQiZrl1bBTz8ATIWpl1nWAa13GLi38LpNRrZ5sRS+jnXwLAtlYcH9Rpd1H7Hs9peKC2mFESrxGdq8P9qw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733982417; c=relaxed/simple;
	bh=dvEj600LiKDyYOaNwWKdg/cW3gf5pd6M3QD/7vok8X4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sHUhek5vwMQgK/htSvTSLC566tyAOr7ls7r8e81IbIp0DXefJofzOOckJ8sfQD17EbibpulCjsDjKpmOLVqvBoGNyiM3YrHdaXyaHilG5lHaS2ir17rCcK/dJGNsOnTRb7fst8jK6OvcJsPkXIrSX1peWwS8qoEgWH1OxOCbMx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kJtEKnXO; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kJtEKnXO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733982415; x=1765518415;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dvEj600LiKDyYOaNwWKdg/cW3gf5pd6M3QD/7vok8X4=;
  b=kJtEKnXOGBdYCDNqgNNdYOOE0Wiok4qMsL3Syzv90TDe36jXNIKShcKW
   O2aBG61y+tPZ0ZrqjysZMClFedwSju+POyXaes2bPtt3iBT8bUauQOl8b
   DFSdBRfnB98oztwQ+eBmV3sQzC/kE9PS1SYMtwyX33V8u26JBLSQxTmEn
   XOvZxYxQyTjsTEo5KCKbVynETzbvAM5vh4DF6+DCphiENZvwYMUu3P08S
   OYkgNg0SbONRg27OczoVbY3wefDt9DrNjo7WR7OiuNEUXcKQOdG0HIjIh
   uxNwvgKb/t5WFmgjDUZT+jmVYfuBCbYRM8OiBfFx3eaYbVUBnYxeukqSu
   w==;
X-CSE-ConnectionGUID: RZDTsb7wR/CvBrliNTyBtA==
X-CSE-MsgGUID: nlugTJo/QA+F6/ExhRFWCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="45792915"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="45792915"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2024 21:46:54 -0800
X-CSE-ConnectionGUID: MgFzSOD+R3eIrHeLeQyZhQ==
X-CSE-MsgGUID: KEXMDvkTS4eeIo3HuqLSJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119350835"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2024 21:46:54 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 11 Dec 2024 21:46:53 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 11 Dec 2024 21:46:53 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 11 Dec 2024 21:46:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wz7NqIreuII/HXNVjqqgl96Qsk0FTVmFTupenteZAWYvX+6d08gKScaEh+r+667nwD8VeVMzZEsxfAY7UgAD9xdhXWxRGv4PUUN35N7HH5YIIVOb8xZHDM21er4DE+s4yGYDIhH2Or4vXzVlz7dgsUWecdZECtkYZ/y++qNfRAsjLsJrHR6PBcEtQy2oHyrLqvcAC7tVE0eO625R6wKQNNarI2zS1Ig7gFG2r3XqClkHvHfCH8FuNCzdH9SsTin6e+P4+hGIXD8txp24+34m0R7c58qzQ2EIlpxMf8cDTvHhkdjr9XhdJ43uTXvWQKIg4DifwwJSBRnOHNCUXE5m2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dvEj600LiKDyYOaNwWKdg/cW3gf5pd6M3QD/7vok8X4=;
 b=PD3RYJfLADaTt+7+345jS8yhKklJtDAuUR3/qXsUSnkoeqfIlQZ90J1bcbsQ/ixBxE19ZpyuDrvMXf1oeckI3eDZBCKsV7Bbw0dcv8y+iEhlEAxKYPPlm3d9DXUvGZxjkzBr+D738RqzFfUto0SKNhbhozJt9G+hWpEeQGnBjOD7xjlqTHWczpAjBajuRKKhNbfYrEsGVkshTySDEbyMjJmaD2ugQVv3ixcJVT5s8LXI5y0dnToXQTWLJ+dpPG1DvTXoL+kxxr23L3H3G/G649z8m1v+7QziQJS9xwtaxMWVDemj3kE5m3IDjC9GIIG1ChZRvFMuRkWco/o4NYAmSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB7132.namprd11.prod.outlook.com (2603:10b6:806:29e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 12 Dec
 2024 05:46:49 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8251.008; Thu, 12 Dec 2024
 05:46:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>
CC: "chao.p.peng@linux.intel.com" <chao.p.peng@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v2] iommu/vt-d: Fix qi_batch NULL pointer with nested
 parent domain
Thread-Topic: [PATCH v2] iommu/vt-d: Fix qi_batch NULL pointer with nested
 parent domain
Thread-Index: AQHbSwPq5ChM9YYSNkeNT67odQk8MrLguE5QgAAPUwCAAVRrEA==
Date: Thu, 12 Dec 2024 05:46:49 +0000
Message-ID: <BN9PR11MB5276F5B100BD155B371533238C3F2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241210130322.17175-1-yi.l.liu@intel.com>
 <BN9PR11MB527673D307E992D5D69CDDD18C3E2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <c031213d-a86c-4f7c-81f8-235116638291@intel.com>
In-Reply-To: <c031213d-a86c-4f7c-81f8-235116638291@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB7132:EE_
x-ms-office365-filtering-correlation-id: 0272cf4b-95a2-4c79-c030-08dd1a705f4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YTlzUlFqMUgrRlpiSmRrY0JHcjlDQk9uWkd5a0dHN0lXNm9qYUcwYVcybDRV?=
 =?utf-8?B?UkFweDV5UDlCQW03UC8veHlaQ0dRS1d6eTIyMlRmMWNmYWlOeHViazV0czBE?=
 =?utf-8?B?OVE2dU80R0ZGZUE1U01SdmMxaXF3R1pWdWw5bnJtSEo0K25vdkREZUxLTUpt?=
 =?utf-8?B?RlNMVzBUZVpLTVFiUHZRaDlYK2xNYmpOWnFUb1NmSGNBQ0NmZENvZlZwWWly?=
 =?utf-8?B?TnpTelowV2VibldPM0p3aGhNSFVmNmZpNlBlSkVEeUxzcWZQa3FqY0hWWTY3?=
 =?utf-8?B?bTlwNWxDT2t1azlZR3dLdzRQdnJwQVZxNjBNc1BVM2NmYzJGTFU5YkozcmxT?=
 =?utf-8?B?bTFEQy8rSzgwZXhsY0xSYm1ISy9JbkU2eGFTa01hamVDRTI2Z2hRNXl3NE9W?=
 =?utf-8?B?RnBpcmhqNUFjRUduOXM3ditTT01OeThJblZyTEFoNXVTT2dMb05IUGZqa0Nl?=
 =?utf-8?B?aDlRSWs3RGJZT2hBcEF0T1M2dWdnaTJKbHNWeFdKYVp4T2JNdGNMZzd2MlBv?=
 =?utf-8?B?K055dFJTejh4ZlM3ZG5sZEFaVmZqT3ZOVGlNZGVKZlRrMkE5VmgrRE1DczQr?=
 =?utf-8?B?Rk95K01mWitUR1UzZE93eThCRXdRU0FybC9VVEFYTENmM3JtMG9TdTJJV2ox?=
 =?utf-8?B?cGh4UWhWY1haa01xa2J1MDNsVW9FcUZGWFVkOUZub05Ma3FLUWhUOGdTamRR?=
 =?utf-8?B?aWVORVpmZ014NHpYWUdqVS81VDhLZnJ4b1ZVRXBGb2JwMVo5VVpjL2JHWDdC?=
 =?utf-8?B?N2Q4djVKT0VLZnQwNVU3ZUF5NmZndzhGVFVtSWZqV2xZU3FOc3VUYlM3SWFu?=
 =?utf-8?B?Y3NwYXVIVVVVM0JvQkVzRXYxQlZYamtKaWVmU29HZlk1UHlSTlQxc0hJejhE?=
 =?utf-8?B?aTVPQjNxRTRzMUxRS0pXWG1HY3krcXJ4ZVd3OVRMTEhBWmNUOWl0QVNZOGtU?=
 =?utf-8?B?Ry9PN0cwUmYwM2xtbUovZHpVVHhhTzNvd0pjK3I5Q2YzNXlTQXNKQTdkdzgv?=
 =?utf-8?B?dVlTMEcxaUdnVUpCa2ZxL0s0Z2RGMnV6V3U2TWFjQnVNS0preVVxdlZTSjht?=
 =?utf-8?B?bVVJUVBpTXNrWkJ2RFBzQy9sWEpESGllM0NTYjI1V21tU094a1VUYkVFbWYw?=
 =?utf-8?B?WURid04yMWp1WE9kc2VtVTEvNTZjeTRKZVF1cW4wNUU4RFFvWU1EdkJoMmRl?=
 =?utf-8?B?NEZ1cTJrMXFia1VWUjlWbGZ4TXVDbnRmR2ZCTlF1dkdvZU00cC9MS1hkU0lt?=
 =?utf-8?B?a1Q3c2FTTWZySnNaKzV0V3BMbHMvT3RKR1VsTTB5djh1eG80cHdNWmhyYmN6?=
 =?utf-8?B?cU15ZkNxcVJrYUowNzV5cEZ5OW1OT3Y1dUdBVHIvajJCck4reDU2Wkt2c1JT?=
 =?utf-8?B?Y2hBbnZlVVR4MllkQ004QSt4d3BIak9zWUQrdCt3MUZNN2w4UUlHVGhKdlFB?=
 =?utf-8?B?bE9BOEhqNWFSU3p1RXRBc3QzbGVwUEIvd2pTbHM5WkRRL01RQ2lXbzNRTThZ?=
 =?utf-8?B?VVl3aC9MZDVSbm1UYjY4djVmNTRVNzA1dzNVZzZ5YlowbVR4WkVGSmhlQTEz?=
 =?utf-8?B?VVhVSzJFd0gzWW4wUk9WcUNKZERMVjFvSGIxQ1d6SjRaSytiVTA3WGU3K20v?=
 =?utf-8?B?YmNGYktoRjZyVUxqTUxqQTFhVXRqZ3M5WTBQQ1FrYWpHNWZVcW9pem16aStK?=
 =?utf-8?B?L3ptM0JJWnFobEkvWHRBQ0NoVHJ3OVJuYlJDZnE2NVYxYUc5TUhHZFNZaXpj?=
 =?utf-8?B?U1hGSjdNdEVyKzg2cUlDd0ZERjlrTExSdzJ5TmF1Y3d4YSsxV09qTjdndmUw?=
 =?utf-8?B?cHhqTmpJT2pKbVhGcWlrUzRoVDJHUUFUL2R3bjVTY2thVzlaeWZwTjNzNkZh?=
 =?utf-8?B?Vk9NT1BaOHhWbnU1aTQ2WnEybGhRUzZpMVFvSlpENHlhSHc9PQ==?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dDlRWVJhTytTcDRmTDlDcExXZ1U0VlMyYkEraSs2M1hkQlBzM01BSVo1Yyt0?=
 =?utf-8?B?R0N6UUFwZWJhbEJmOWREQmNZOTRNQlo4anM3MzNuQ1lSLzZTeUhTKytoQTZn?=
 =?utf-8?B?ZzNycys2WEgxV0w0T0xFaEJvQlgwTXhPcHpISDFOZ2pQaXZGWGw0Q0lXdmxL?=
 =?utf-8?B?Uk1UNDU2cHkzMGNKck8vUktmcVdwcVJUM2k3aVFVTnJMVWhNdzloWkZRM2Vz?=
 =?utf-8?B?dUxBMnNQZmFqVUZ3TEFpUW5kWlRRck9aN2Q2YWpHcmFqNE0zLzVYbTdhcm53?=
 =?utf-8?B?Qlc5UHZGNTdDTXhtbnJBc0pYSWxubUFBTWNTSzBlQ2NhZ3IyS0ViOW5rZFJ6?=
 =?utf-8?B?cTMxRklrNDBNTDFVMnFrQ1pRK29VYkVzL3ZEdTgvZndraThSc3h0b2lIM29V?=
 =?utf-8?B?bVFkS1N5YitMc3lwTG1VUUV4ck9HekNnVjBDMXAvS3AxeGh3WXhhNis5dE5s?=
 =?utf-8?B?UVl4VzlDVituV0V6U0lkQkdaZ1ZBaGJOc2NhUCtIZTBXWW13dWdMZ1FHaXh6?=
 =?utf-8?B?YUlqSjh6cnFUTi8xUFBVd1FhOHNldXM5ODNRc1RNa3NXejlQcE1yS2xWS2w5?=
 =?utf-8?B?TXFnM1RZTU1GdlBQQ1lKUUtrMnZlMFZTZXBZMytDODRyMjFFcm96SGVTbDZ3?=
 =?utf-8?B?Y1Q1VDdEK2g0clcvajJPYkxjRC9xYnJobUN6cVprL3dpNm1GMnIvdDRJS3hL?=
 =?utf-8?B?bzcycTczd0tzWDNzTEZWRWdOWFFXYnM5SU96MFoyek1pQUdMRmZ0SDlPN0k3?=
 =?utf-8?B?SEFXcFdGQ0l0SUhpMXU3U25id21PajVQSFNqK2NnUWxHWTVKYmdvM2Mxd2sr?=
 =?utf-8?B?UVFyU2hINWtQUnQ1a0d5UHdUeThMMFFQTUN4K1IxOThGMVg5ajdDVi9FL0ZF?=
 =?utf-8?B?NVlpbGJMM2R5VDdud09PL2lDV1JiZHhBeHFiaFYxTkVJQU5IUDZqdWZrZ1pu?=
 =?utf-8?B?RWlmbUFONUtXWFg1R3RRM2ZmUXIvNUlsRnJlNk02OWdXNlA1YmxZYy9FK2c5?=
 =?utf-8?B?RHNOMlRGd0U2OENFZVJNRVRraU9yM1BZU0lxWGFnUytWbE9VaGxLTG5QNnIw?=
 =?utf-8?B?RHFBVG4xcklIWEY4d1lMRWgvenVXQUYyTC9QL293cERVZ3ZHR3pGZkVpWnFY?=
 =?utf-8?B?T2tpQVY1SFZSQTViRXQ3dmh6WGE4VjVrM2loS2ZKaGJOaWJqUTFsZ3VveXlF?=
 =?utf-8?B?UnlXVWZKQmE0ZzJnd0hzb2wxdEVxcm1CU1lBZnNhR292ZDQ1VE0ydjRaemFy?=
 =?utf-8?B?VzBrRFNuVjZKdCtmbmExVTI2Q3JSS2JiOFp5WGJmUG4xUTJFcWRqTTVxZFhY?=
 =?utf-8?B?eW5DSnlvWEdVYjAwZUtFd2tHUC9sSmJ2TXhQWEdZSVJlUmpZd2FkQWVQL2RR?=
 =?utf-8?B?d1NUZXVqQi9tK2wyOFlGWGFQZ3RvNG1ZRjBYVTF5TlRHaGRVK2NVeWFwZDFp?=
 =?utf-8?B?dGpETFBXR3MzK2tRcHY0MjlLN0lZMk5VMEwwc3Rmczk3b3g1bHl4eDlISjRv?=
 =?utf-8?B?bmlqaU5yck1XcVdRNXJKYzlKWUJUcUZLZ205MklhRExLTHRtSnJySjBIc3JO?=
 =?utf-8?B?ZStiYUpKc3lyNnc5aml2OWF6SXhnY01ReDN3bVJDRk1Lamd4aEg1T1QrRTdE?=
 =?utf-8?B?dUtlckdBK05vNCtNaEx0NnhzT1RVRHg3d2lMUlBHRkFqdDVvU3Jicy9tYm1N?=
 =?utf-8?B?UVpEQlZMWkNOUDJzSkF2RDF3d0J5dnIvcmoxZXoxcGExRE5VdVFKTjJmMmZB?=
 =?utf-8?B?ZzNiNmV1QkQxZEppV3Zvdlp3U0s0Zm1BL2NKczJUSmR6ZzRxN0RqM3l6czZz?=
 =?utf-8?B?cUdhVzIraDNBelVLY1RKMmVDSEgxeHBiMzZtVE55QVY0N01ZSGhWbnZrUUdQ?=
 =?utf-8?B?c2doM05WakxuNWg0ZzVkSzA4aExBSnFxakJQNFMzdWtJNnpyeUowWVZSKzVP?=
 =?utf-8?B?eWRNNFBkbHQ5a0IxZGZPYXpQRjNRWmhEV0JSbU1va2ZlSnVIYzRWUFNteW5H?=
 =?utf-8?B?ZUZOcm1oTW55Nkc0aFVNV0s5ZDFwQnh5QmVReG1lUE16eXhCcEdUa0xQOGpW?=
 =?utf-8?B?d011cG1MYnd2Q2VCcFpUck90a0RHSVVEWmtPM0h0VklyN1drK3ljQ2syQjhu?=
 =?utf-8?Q?Lp7aAHGeErTDp1wABKUXDggkO?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0272cf4b-95a2-4c79-c030-08dd1a705f4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2024 05:46:49.3699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n6EKXYO+C0AxIprlZpYngixoI3zHREHma8N7Q/Rto8tf2FczImPkXPJgJNU+bGaCBFGj7gWEnH+KvzPFGKxtCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7132
X-OriginatorOrg: intel.com

PiBGcm9tOiBMaXUsIFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5
LCBEZWNlbWJlciAxMSwgMjAyNCA1OjI3IFBNDQo+IA0KPiBPbiAyMDI0LzEyLzExIDE2OjM1LCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTGl1LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5j
b20+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIERlY2VtYmVyIDEwLCAyMDI0IDk6MDMgUE0NCj4gPj4N
Cj4gPj4gVGhlIHFpX2JhdGNoIGlzIGFsbG9jYXRlZCB3aGVuIGFzc2lnbmluZyBjYWNoZSB0YWcg
Zm9yIGEgZG9tYWluLiBXaGlsZQ0KPiA+PiBmb3IgbmVzdGVkIHBhcmVudCBkb21haW4sIGl0IGlz
IG1pc3NlZC4gSGVuY2UsIHdoZW4gdHJ5aW5nIHRvIG1hcCBwYWdlcw0KPiA+PiB0byB0aGUgbmVz
dGVkIHBhcmVudCwgTlVMTCBkZXJlZmVyZW5jZSBvY2N1cnJlZC4gQWxzbywgdGhlcmUgaXMgcG90
ZW50aWFsDQo+ID4+IG1lbWxlYWsgc2luY2UgdGhlcmUgaXMgbm8gbG9jayBhcm91bmQgZG9tYWlu
LT5xaV9iYXRjaCBhbGxvY2F0aW9uLg0KPiA+DQo+ID4gT3V0IG9mIGN1cmlvc2l0eS4gSW4gd2hp
Y2ggY2FzZSBkb2VzIHRoZSBWTU0gdHJ5IHRvIGNoYW5nZSB0aGUgcGFyZW50DQo+ID4gZG9tYWlu
IG1hcHBpbmcgd2hlbiBuZXN0aW5nIGlzIGVuYWJsZWQ/IEkga25vdyB0aGlzIGlzIGFsbG93ZWQg
YW5kIHRoaXMNCj4gPiBwYXRjaCBkb2VzIHRoZSByaWdodCBmaXgsIGJ1dCBqdXN0IGN1cmlvdXMg
aG93IGl0J3MgdHJpZ2dlcmVkLg0KPiANCj4gVGhpcyBoYXBwZW5zIHdoZW4gdGhlcmUgaXMgbWFw
IG9uIHRoZSBkb21haW4uIEl0IGNhbiBiZSBlYXNpbHkgcHJvZHVjZWQNCj4gd2hlbiB1c2Vyc3Bh
Y2UgYWxsb2NhdGVzIGEgczJfaHdwdCBidXQgbmV2ZXIgYXR0YWNoIGl0IHRvIGRldmljZS4gV2hl
bg0KPiB0aGVyZSBpcyBwYWdlIG1hcHBlZCB0byB0aGUgSU9BUywgdGhlIG1hcHBpbmcgaXMgdGhl
biBwb3B1bGF0ZWQgdG8gdGhlDQo+IGh3cHQgYW5kIGl0cyBkb21haW4uDQo+IA0KPiBJbiBteSB0
ZXN0LCBJIGp1c3QgYWxsb2NhdGUgczJfaHdwdCB3aXRoIG5lc3RlZCBwYXJlbnQgZmxhZywgYW5k
IGFsbG9jYXRlDQo+IG5lc3RlZCBkb21haW4gd2l0aCBpdC4gVGhlbiBJIGF0dGFjaCBuZXN0ZWQg
ZG9tYWluLCBhbmQgcmVwbGF5IGFsbCB0aGUNCj4gR1BBIG1hcHBpbmdzIHRvIHMyX2h3cHQuIEl0
IGhpdCB0aGlzIGlzc3VlLg0KDQpzbyB0aGlzIGlzIGEgY2FzZSB3aGVyZSB0aGVyZSBpcyBhbHJl
YWR5IGEgczJfaHdwdCB3aXRoIHZhbGlkIG1hcHBpbmdzDQpiZWZvcmUgY3JlYXRpbmcgdGhpcyBw
YXJlbnQgczIuIFdoZW4gcmVwbGF5IGhhcHBlbnMgdGhpcyBidWcgaXMgaGl0Lg0KDQo+IA0KPiA+
DQo+ID4+ICsvKiBkb21haW4tPnFpX2JhdGNoIHdpbGwgYmUgZnJlZWQgaW4gaW9tbXVfZnJlZV9k
b21haW4oKSBwYXRoLiAqLw0KPiA+PiArc3RhdGljIGludCBkb21haW5fcWlfYmF0Y2hfYWxsb2Mo
c3RydWN0IGRtYXJfZG9tYWluICpkb21haW4pDQo+ID4+ICt7DQo+ID4+ICsJdW5zaWduZWQgbG9u
ZyBmbGFnczsNCj4gPj4gKwlpbnQgcmV0ID0gMDsNCj4gPj4gKw0KPiA+PiArCXNwaW5fbG9ja19p
cnFzYXZlKCZkb21haW4tPmNhY2hlX2xvY2ssIGZsYWdzKTsNCj4gPj4gKwlpZiAoZG9tYWluLT5x
aV9iYXRjaCkNCj4gPj4gKwkJZ290byBvdXRfdW5sb2NrOw0KPiA+PiArDQo+ID4NCj4gPiBWMSBk
aXNjdXNzaW9uIGVuZHMgdXAgd2l0aCBhbiBhZ3JlZW1lbnQgdG8gdXNlIGRvbWFpbi1sb2NrLCBi
dXQNCj4gPiBub3QgZm9sbG93ZWQgaGVyZS4gYW55IHJlYXNvbj8NCj4gDQo+IEFoYSwgdGhlcmUg
aXMgYSBjb25mdXNpb24gYmV0d2VlbiBCYW9sdSBhbmQgSS4gU28gd2UgaGFkIGFuIG9mZmxpbmUg
Y2hhdC4NCj4gV2UgY29uZmlybWVkIHRoZXJlIGlzIG5vIGxvY2tpbmcgaXNzdWUgdXNpbmcgZG9t
YWluLT5jYWNoZV9sb2NrLiBBbmQgdXNpbmcNCj4gaXQgaXMgYmV0dGVyIHRoZW4gZG9tYWluLT5s
b2NrIHNpbmNlIHRoaXMgaXMgYWxsIGFib3V0IGNhY2hlLiBJIHNob3VsZA0KPiBoYXZlIG1lbnRp
b25lZCBpdCBpbiB0aGUgY2hhbmdlIGxvZy4gOikNCj4gDQoNCk9rYXkuDQoNClJldmlld2VkLWJ5
OiBLZXZpbiBUaWFuIDxrZXZpbi50aWFuQGludGVsLmNvbT4NCg==
