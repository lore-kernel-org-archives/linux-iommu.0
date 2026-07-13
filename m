Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7047A364022
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783923012; cv=fail; b=lrBvCWNzcWT5M/RUqN5HngukBzp630Jh90ChoNah8RD4lPmcNv9P9Yf5DNhDkqlAPGef3PGVCUP14vC8ZTyennr1mSI2FmQjkF8eI1gvdMCZf+e33ha8ca1/AMvI6MUUgmiNdFiG2yhbfOqDanago37cPwGwvd+pHGUZTKIVl+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783923012; c=relaxed/simple;
	bh=xmuXSj1z4zGmLdqJHP/3g6AO8IV61xn9idob7n6W/Yw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jdI+E19uUlYFqBCkB26qlnyQr5t76wanS/ryZTqDgq9VGdSrb59A91Nkf4FejdIDYqxo2evcBtEfamLHBvzK5rLwg6te3g2jgzvUWnxs2KLOjzjugDniCupnv03/q7RYwC3O/Okfg7yo/mznssBqrAMAW2EmAekYBxI5Jv7pNO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Eh8Ukxea; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eh8Ukxea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783923011; x=1815459011;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xmuXSj1z4zGmLdqJHP/3g6AO8IV61xn9idob7n6W/Yw=;
  b=Eh8UkxeapUA3sP4aZk9LzXGCo+RCiWoqccuT7NY5IXAa+D1lPPZXb/Er
   SzUPO6Qc7/uoNOsOvV6f7Wr5Dc7uzzxzHACm87BJcKOCy+TnqNTVjHdTP
   4oaNRyTbTbgehRw+zNowQfep/v9pQpdSLpXL/QWYPMsGG//Iv14d/3Bb9
   c0qa66/Lw6zklvANpEAJwJhYNCf3iaJUWrysPYQwCvKf5F/ghqIlJShgB
   kzPKRZ0koD9qZ9BkduchkLU6LtL7l78NV1EPqs4RGhGT/ZiHlnXMF3E8O
   edbSmChRJ/26uiTPWC/tu4r4bNomws0wq8hDwBhYvBIgf4r4XV/IWhqI8
   A==;
X-CSE-ConnectionGUID: crEv+suJTCKzx1Kxyw3bFQ==
X-CSE-MsgGUID: uI3DI8TiR0CcFyXtMHwbmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="84641115"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="84641115"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:10:10 -0700
X-CSE-ConnectionGUID: IxR8h4/oRbSJXDIY/USp8Q==
X-CSE-MsgGUID: oHuzn4U1R1OFEDjuWFTOwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="278718979"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 23:10:09 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 23:10:09 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 12 Jul 2026 23:10:09 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.63) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 23:10:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ngj7FbLOHz10s95Ie8pZtNMcIALud03uL3XWHCAboLEzTb9EuI6/7VWWBWgiZHkeVdN0UanNqDIYirNPSIP1lKXFKL9cwOcTHA09jPblBrj4Ayp1fzb4FpYr52vosspqpOL53rXFc+/tU0JQWwbw5kErrjuGmWpA82CmsX7E9LkHk4dc4qjq/auaKon0234d6nKKfiv3X3B79oescw3Max8babXLmM4FtoC+q1hL93nuNA5S2Z3F1EWNt6s/wjkVEVQHufYNJvQYhZvzldEa4fLYpaRMFh/f930/zTU4vs7RO6GhBbwA43zUVQJh+yDbvOxOw6dI/Ph9bQ4FEX3G7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmuXSj1z4zGmLdqJHP/3g6AO8IV61xn9idob7n6W/Yw=;
 b=nKhxbjcJ2XroKwjdFMiSWoeQpmtG828/7WjGU9VXvtn0dRMTUpRjgIWkof8OUVRna+OpnvNzD3fw50iE5fqNHVmPFjPCtb6bOxWhET9lKltsrNH/YttvYJVAMHsDdjKDyDDJoGeUiC8iSYecx7k1avcbYYkxaqEM/KXLtCNj4yvuD+S4RtHoCWhyM/9B8/igFW4nGwbGd9WHD1tRIW1u4JslRMucAb/S4rMQJiHTAfpLlj6N4Qw7K5HgOHF+r91bhDq6ZoHbljBaaGAFlpuglTRWZVFUbQzOJw1a+T2XGGpWEmOpJTYf5mADD1I6qwG58ABSwJF2O/+z5XPIAtFr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by IA3PR11MB8920.namprd11.prod.outlook.com (2603:10b6:208:578::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 06:10:02 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%5]) with mapi id 15.21.0181.016; Mon, 13 Jul 2026
 06:10:01 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Peiyang He <peiyang_he@smail.nju.edu.cn>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
	"baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org"
	<will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "jpb@kernel.org"
	<jpb@kernel.org>
Subject: RE: [BUG] iommu: KASAN slab-use-after-free in
 iommufd_auto_response_faults
Thread-Topic: [BUG] iommu: KASAN slab-use-after-free in
 iommufd_auto_response_faults
Thread-Index: AQHdDdfQv3K+dY/j2kGnOMh1k9glILZq/vPw
Date: Mon, 13 Jul 2026 06:10:01 +0000
Message-ID: <CO1PR11MB4835631ED64FF285D915CEBB8CFA2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn>
In-Reply-To: <B4F28798E2E784CA+d29f723c-b2b5-4b67-8d1c-4f7b9b0b27cb@smail.nju.edu.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|IA3PR11MB8920:EE_
x-ms-office365-filtering-correlation-id: b39967be-2dec-4b97-5fc1-08dee0a56014
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|23010399003|22082099003|18002099003|11063799006|38070700021|56012099006|6133799003;
x-microsoft-antispam-message-info: KLNQnKL9W5VpwR1/qeTldZnO0rk7AwcPKVsT9xAU3cFdP0vvm4kTUyzmbcAzZShNiTSlfGhZcSaSDm+5dUJ2gErY/ejsTGS1uU8GkXhc+Yae7AojtoC3ImphKPQW9Pw7ItHf8gEm+qlw0udbBYFscVR6XZO+GQKsHokOPVBTsq5hVc52ynFxFPFHsDhN1zbchn7/NkX0OWWYB3VOWVQiGidczNlMajbEKfqL31ty6spHoDY6CQoNpBQWy+G7kueQkiRhLRNAbIZZn3jHcb6MxntWKYeve0io+flbWUfjDptUQ1YWY03Th/dq8M6/ooENNPMpmIfteFuTfBH5iYND3FJdzE4Amz6yIGP+tR7ifK1JY2wzKUsCMKafAYY7HrB3wlXGEB2CnlETU9RPwH3L/HCQvMVZHzKQuVPfWVzvKNyHVa5buw5qxGqCpoN4PmdDMeeid/qiIDHoMxLpziRRwq3qdkERRsjaElLwxWACSsUS8okLkDufy+NX0HPO6xWMHaruY/84J7Hl/ncrhOFF5sneBCR14qzHEv81ZHO0igI5ln+VAbuevIn/DQ+Q2Krps3crVFUfSEWIxz9zcGkvIFj4RocJiSgTBr+F6oFl3ajHHEBWg8OTwhzK2tr6OTlekdxkwLXjDosn6TApKsabdCVVc5kWxBfHFhtIS6qEsj0LuExSWP5ZrvFamVZbPdbHwC7GICV1AHWgjwVMVqdsZWi8eAOnJWZXcBo3pUNpSCI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(23010399003)(22082099003)(18002099003)(11063799006)(38070700021)(56012099006)(6133799003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUxPbTBTMUExdktYMVJzbUNlODVtMVNXRkhWRmdIWSt3eWRRYXc5eEszL1lC?=
 =?utf-8?B?TGQvT0dhclNIa0Y2N3RmY2dXd2dJdVFxVGc4ZjYwQnRYSXNjWlpwQkRBbG04?=
 =?utf-8?B?WHNsV0w4NFdMWXJzcXU2eTUrT0E4NUJVZ2dIMlRsV082Tm12VG8zTGlyczhs?=
 =?utf-8?B?ejBLMUVWdWRJVUlkZGdRSE12Z3JaL0JqS0pJeHZhZ28xTlI0TzVuWUhtd3V4?=
 =?utf-8?B?aEV3TkRxN05YL3FHS21iVVVTUk96NzRoRDNzcC95aUd5K3pwNTlVdUZHRTAv?=
 =?utf-8?B?UjRidlpSUUlPZzJGV2tDRkI5eVR0SjJZelFGWVIreVNQbmtwYVdxblQwKzBH?=
 =?utf-8?B?M3FWb0pnb3hBNmNNVHRiTjFIS042OFJKQVVHTXRaN2szYUQwYzFhZVNDanhS?=
 =?utf-8?B?NmVycjlRMkhLSFdJTEhta3U3bHFiaWRmNHlOeElPSWJVczBtRTFWbU1IR2hH?=
 =?utf-8?B?Tkg4RURJd1dkSFZudXJnb0dPMGNGLzB1dkRKZmt4eXZHZE1FRnVRL0YwUUsy?=
 =?utf-8?B?cjliNGVEcXd3cGpCbUxxem0yM3lkVytZaXRwU3dqZVA4WERFZDZOTWJveUZW?=
 =?utf-8?B?M1BJNmk1ZUlyRmF2NGJDcGJYNWUvMDZwaHZmbVZGLzk2cFhuOEJpV2Vkc1dF?=
 =?utf-8?B?aDYvWlgvVllydC9MQmxVZTN2enhIUFJXRnJmWDhSb2hicC9Qd1o2SzdzT0dI?=
 =?utf-8?B?cytJMkZXcGdRZTlCaGZWdmFkdnkzN3dJT1pYQk91U3JHTFNxa3BuQlNDR1du?=
 =?utf-8?B?clFvRmZXQnd2aEVzN3UrRTA2VzJBeTZFRlVZSDkxQytqeDRlMnYycVc0Y0ky?=
 =?utf-8?B?NVlWamJScys1K1ZHWDdvRXJzU2dZOTRtOVZsUC8rZkVnMG9JWGNjWmt0U0dI?=
 =?utf-8?B?QVdtcEV3b2JmNVh1T1hNZVFyWW1IMEl2VStPUmh6WVMvZm15djk3SEdLOVpk?=
 =?utf-8?B?NFhUSE9qcGhGcW5sNEdYby8rYUxlMzJHRlRzWjlQV3dCdXgwZUk0MmdSTFI2?=
 =?utf-8?B?SUx5RCtrY3JzallEZUt4RVVOb0FlWVI4bjVVVXdST1Q0LzZRVEQ2K3BJUFFE?=
 =?utf-8?B?eXdGUHRsODhPZlFUWFFNc29uejlBY211eHRoS0FCTGw0RlNyRmFxWGU0YjBO?=
 =?utf-8?B?RytldU1JNUdXLzdYQjNsMVhyU21PK01kb3VwY3lSemRsREJ4dXpDVFFkOVpL?=
 =?utf-8?B?dmlVQ0RUNzdvNW1UQjc3NHk5WStaVVoycVdGMk1IVCtqS3hlWHhicmlIdVVY?=
 =?utf-8?B?b0hGcUJObEVmR2lGWkpqVlhla1d5aVVaOGExTCtCUDRWcUwxeUVPSVd1T2ZS?=
 =?utf-8?B?Z0NkS21sdGJTWk1GZC9saVZYMW5MS216Rm85N05mcDRua0Nnb0ZZTGxzdXpi?=
 =?utf-8?B?ZWtub3JLMGJDdzk2SmVhMUpPME5sU1ovZW9KQjlXbDdJdWRmTVU2ak1YeW9j?=
 =?utf-8?B?dE12azY0aFFHa3BFcStOVlRZaFlSOFgvMjRYTjAyb251dHFKTDhhalhWdWdj?=
 =?utf-8?B?OXpIV3FCY2VNd2xkZGY5K292L3YrWmZLQ1lMeW1QY1ZpUy81bHMwQ213Tjl2?=
 =?utf-8?B?VlRUc0hNaC9Kb1UwbVFIL3NtM3Z6WjI1R29DZ0tWbXJwRCtLMGpRSmlkRTMy?=
 =?utf-8?B?UVoydXI2WkhBdVpIRFdLdGhzY1lhaUlzUWtCOVpPU3BpQ2xCNVZPdGFzWlV1?=
 =?utf-8?B?UTNxckdmaDVkcXFwWjV1KzhFM3Jjd05UTklrcklGY2EycUFOaVVWUUpUSktF?=
 =?utf-8?B?N2F5RXNzMEo2eDVNRUw3UURSc0FDT3RpY2VtSVExelBEWmd0VlBiZUNFRDVB?=
 =?utf-8?B?TGRLVnNrcHhIL0NWMTMvOEY4MThwS0tHOEEvQTYxVEIwS2tpbXRydHh5TUJw?=
 =?utf-8?B?UnQvSUVZV1RtdTBld0xFQVFUZlZCa0lOakZiTlR3MVBpRnpXaE9SeVZHZjZK?=
 =?utf-8?B?aXlFMEt0MnhnZDBnRXpFNmVUOTZDdlVVMkcwN0k1QUlXZFU0Q3pEWHBKdGN3?=
 =?utf-8?B?Y2pYNjRnU2FhQ1k2UVNwTlp5RWZzN2JUUVZuRUo0eXRUYm4yREdvWTJ2bGRM?=
 =?utf-8?B?YnNvcFhvT0FOejZzTzdyQk1pZTV3Z1ArYmw0Nm5JTHdiSUkyc01UZXppUnVs?=
 =?utf-8?B?TUF5RWd4OWtiQUZFNWJ5dklXNVU4aWdqZHphVlFoV09saTdPOVppV09tVlhV?=
 =?utf-8?B?UTY5cEdlSFBLOGNWLzFTS3RPR08vWWI1R01PUE9SQTRBcnRlamhaSnRtVG5k?=
 =?utf-8?B?YnVRbEFIa3dxRkllT0dPaGdEY0QwNjFxdWYwcDFOZXFoWUZ4b1oyalNjSkhR?=
 =?utf-8?Q?j4i1ezZ7fN3q4QiYR0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: apjKgogX9cTLXqWoXl9++VCbYkKeJl7MSyYn4DqgBHF96ae4axNgkW0KpNYUKud/dBwmoYI3I/aZyJP0/wk00lZ/DP1tE9+HKS0PaMJvszp5MgiNxo2kboV/9eCQqvDekPtY+hcxSBsLl9cjif5GC50cWGbJTY5PO77X31+RHVnXnnnLg3iwsUY/Y7FxpSWBjb2HSsWpaWOCilvuPQaWWAIt0O1BIKTkopAScxOPi/FZcFROIMK3wpOemFRv+Fkzztb03z65S2i81JUfcrbKV/dd4cQ3RA7ZNPadkaKJXeB/DXwVrn4pNu8IfYlZ5T7auICsh3UHTkhl2fBQe+RtoQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b39967be-2dec-4b97-5fc1-08dee0a56014
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 06:10:01.9111
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R1SKP0Jpu23OrG+PPn1nfnbusKVgEiYrnLZmio1lj5DrVXTlncd6YHM3ATmyA8wxsxXTXmZZz8yrTEW6lzNX/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB8920
X-OriginatorOrg: intel.com

PiBGcm9tOiBQZWl5YW5nIEhlIDxwZWl5YW5nX2hlQHNtYWlsLm5qdS5lZHUuY24+DQo+IFNlbnQ6
IFR1ZXNkYXksIEp1bHkgNywgMjAyNiAyOjEzIFBNDQo+IA0KPiBUaGUgYW5hbHlzaXMgYWJvdmUg
Z29lcyB0aHJvdWdoIHRoZSBpb21tdWZkIHNlbGZ0ZXN0IG1vY2sgZGV2aWNlIChNKS4gV2UNCj4g
aGF2ZSBub3QgcmVwcm9kdWNlZCB0aGlzIG9uIHJlYWwgSW50ZWwvQU1EIGhhcmR3YXJlLCBidXQg
dGhlIHNhbWUgbGlmZXRpbWUNCj4gaXNzdWUgaXMgbm90IHNwZWNpZmljIHRvIHRoZSBtb2NrIGRy
aXZlcjogSW50ZWwgYW5kIEFNRCBib3RoIGhhdmUgcmVhbCBkZXRhY2gNCj4gcGF0aHMgdGhhdCBj
YW4gcmVhY2ggdGhlIHZlcnkgc2FtZSBpb3BmX3F1ZXVlX3JlbW92ZV9kZXZpY2UoKS4gVGhpcyBp
cw0KPiBleGFjdGx5DQo+IHdoYXQgaW9tbXVmZF9od3B0X2RldGFjaF9kZXZpY2UoKSB0cmlnZ2Vy
cywgdmlhDQo+IGlvbW11X2RldGFjaF9ncm91cF9oYW5kbGUoKSAvDQo+IGlvbW11X2RldGFjaF9k
ZXZpY2VfcGFzaWQoKSwgcmlnaHQgYmVmb3JlIGl0IGNhbGxzDQo+IGlvbW11ZmRfYXV0b19yZXNw
b25zZV9mYXVsdHMoKS4NCg0KeWVhaCBpdCdzIGNlcnRhaW5seSBhIGJ1ZyAtIGl0IGRvZXNuJ3Qg
bWFrZSBzZW5zZSB0byBoYXZlIGFuIG9iamVjdCBzaXR0aW5nDQpvbiB0d28gbGlzdHMgYWZ0ZXIg
aXRzIG93bmVyc2hpcCBpcyB0cmFuc2ZlcnJlZC4gU3VwcG9zZSB3ZSBzaG91bGQgZGVsZXRlDQp0
aGUgZ3JvdXAgZnJvbSBpb3BmIHF1ZXVlIHRoZW4gYWRkIGl0IHRvIHRoZSBpb21tdWZkIHF1ZXVl
IGluDQppb21tdWZkX2ZhdWx0X2lvcGZfaGFuZGxlcigpLg0KDQpDYW4geW91IGhlbHAgc2VuZCBh
IGZpeCBhY2NvcmRpbmdseT8NCg==
