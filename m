Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595F821B9FD
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 07:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763710240; cv=fail; b=Zg+dzTBtFydjMwOD3N0URTD83UT5eUoHDKjqn7+32XdTYd1ma2sSx/CvZt4goJ1gRMEwDgR40ZPZiOM7XiSMprc7rfNDBregwuUkS6YUF0gyNfgPPCeFYZkDotWoM6lTAlsKcxcZKSgJB8voI99JSH/CrTtxy77kXajRk9qgHuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763710240; c=relaxed/simple;
	bh=EeWVUL8/9oDpSqtPWRh3TxDh+44BILQFMSjgYWj99TI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PrL3Orti3L2DS5EuwoUgl/zWBo5IY4M7hd8VFvYEjqzA3MgYASRwh46eLM69Oo4/vyIJ/cpnDbzHRS/AkERVGAgJUA1kCIO4/QjOXKBw/PyuumwPT2HNrxg0CjwizcjZn6pAh6ZXDHeRrEN3O14KdhxDau/nDJbBQB6I9UBGKDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FBw+Izpe; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FBw+Izpe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763710238; x=1795246238;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EeWVUL8/9oDpSqtPWRh3TxDh+44BILQFMSjgYWj99TI=;
  b=FBw+IzpeugqJm3Jc0U5Hjsi/ftRpRmbcMLbiOqtAtN1c4rzm4leBxiJr
   6AbFCdvy1UtW5EcsDiZrBLrEJzy79O71bPiP4vSKG690dQMqiEJpk/umC
   qFTGZWkFUnDcdH1AtXWtL9P9m1M6HEeqUJRYOi9a0LmO+ttnjrahzDHnu
   Vugj7xKBiKfB0pAXsyqdvYsowoK711AEGvTxyC5YKdVYloeF6HNMr3c6K
   kvr2Y8nQmtaRfjM2kPjEIMys6cBs0E+ZjMsVyUPYwHPpJnKi9r2A3RBi7
   Cr+duCPzo7g44y/8YV5lZ5j7vnMeErwrMhhLU/jp685QJIwjuVupk/ddT
   g==;
X-CSE-ConnectionGUID: FM7KMrb1Q0yXXaB9INMibQ==
X-CSE-MsgGUID: KD9CfV44SJSh+jZnwDVA8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11619"; a="65677089"
X-IronPort-AV: E=Sophos;i="6.20,215,1758610800"; 
   d="scan'208";a="65677089"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 23:30:38 -0800
X-CSE-ConnectionGUID: gu6vJMBUT5KNjPZiAJB2zw==
X-CSE-MsgGUID: acxEAE+ITTSkGEKGQ/kbGg==
X-ExtLoop1: 1
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 23:30:37 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 23:30:36 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27 via Frontend Transport; Thu, 20 Nov 2025 23:30:36 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.27; Thu, 20 Nov 2025 23:30:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UE7LOlrjUuHk8u89/Tlr8g8+VNYjH3uqmmmjb4P18mYncIvM7g5Z3EknLV0Wq1hdOBpD0i0IvGxSts5RUoJSrgP2/UOC0kpwOqc0o+1xxD4CwXSwK41xPDFMI2ghV+eCRrxVFWuXmtW7RNeWEt8rMWk8DoxKt5gvWPaDdSmWSZ39Qm3PM9R/jaEg1RAW6ePP+RTzdjLCu8ek8FzJxuhsqaZ8M1meLKvNXd3j6P68VmeS1NdHGK8SnlcCb9zbVPwhX2ayEAoQmgDnNMXBc/azh+7BtGJDXtI8IC2z90MINdHSLlF/+OKyR7LSOjsjiq9tg4OwduvJzCtRah5lUguahg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EeWVUL8/9oDpSqtPWRh3TxDh+44BILQFMSjgYWj99TI=;
 b=J0ZEL5AocXWbTz/EjZSJUOB3WlynkXqMjZ2fxaUdL5R/F6jguu3RzI2gjGzkzcEKjEHThEhTP4yBZyGROgOnHWCb+u1togu0PIkWJM80OOBBrcLIdSWK/RH7lnhvVSkSKk7w//6Ki51KYNNQu5tlE2DtZwdUNhcEGJ5cv3RgLtk1+hSM5WJ3QFBKeQVwtQS79jnzyCsZ5MGlk4WWw1YCHdAZp/1y23Tiz9nv3MHsCMLE69cdgKSG/trwdg/cNm/W4zl0eTK8LszTbY4gxqywSPnlfu4ugcPXoo11icVQQ+WhCN570yx2PZKkA6XeOEfNKEJZCuQILmcVbXQ1JLofnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5029.namprd11.prod.outlook.com (2603:10b6:510:30::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Fri, 21 Nov
 2025 07:30:34 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 07:30:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, "Borah, Chaitanya Kumar"
	<chaitanya.kumar.borah@intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Restore previous domain::aperture_end
 calculation
Thread-Topic: [PATCH 1/1] iommu/vt-d: Restore previous domain::aperture_end
 calculation
Thread-Index: AQHcWe80tpqrbz3rR0GOxJizjD9GHLT7h3+AgADUHoCAAGBBYA==
Date: Fri, 21 Nov 2025 07:30:34 +0000
Message-ID: <BN9PR11MB52766996DFF5A14C6EB560F98CD5A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20251120072524.3218282-1-baolu.lu@linux.intel.com>
 <20251120130045.GB153257@nvidia.com>
 <e5376ae5-20f8-4e49-a912-7412361c66fd@linux.intel.com>
In-Reply-To: <e5376ae5-20f8-4e49-a912-7412361c66fd@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5029:EE_
x-ms-office365-filtering-correlation-id: fd19ac0e-a2f5-4800-66af-08de28cfdbec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ckYwdWVrL25VNWJXbmFBSGQ4Z0N2d2hTU0NxT1lwSjYrQ0hYcmdibkRUWDZ3?=
 =?utf-8?B?c201SzNpZHpKU1Z6RXMvcTlwUGJRWTdhSDhCS2tKN1dTdFdvNTg4NGZaRHRm?=
 =?utf-8?B?M2pyWndtQUF5OWV0TjExVWs5WkgyTDlTVWtiNHkxYzlJcUc4WkNMSnZrK3Aw?=
 =?utf-8?B?MUpBY3dFeGFNTG94VXJZSUFIT0lhNlJGZTFGRm16cm9sTFlGK2RneDA0YkZU?=
 =?utf-8?B?ckV2RUxtU2cvSVZzTU9Wb3dHTGFQRmlTcjNmbXBBWHFZWENDVmJBaUlGWkQ2?=
 =?utf-8?B?eTRrdDJzUGNrZW41MGFFVjQ3SzZIa1pFZWlJNEsxMWJBWkIzNk9LZUl1QjJM?=
 =?utf-8?B?MGpWWTZhWVVWcjZYRnJjOG9WVkZmVlcrKzRjUVNybFJNbndsU3pVYlU3VUVm?=
 =?utf-8?B?YUdNZzFDZ3Z2M3ZINFJESDVtMzlidXBXNDhodkxvTWNtdTlYOU8vZ1BwY01B?=
 =?utf-8?B?bWRXK1p0SHlzakpXMy96aE4vQmh5MXVxNnVwWVR5Y3hKc29uMmI1UTFkaGNS?=
 =?utf-8?B?YUVESWhCQ2drOGtiUlBQUDhQTGRMOTJRZUQ4S0xtYmtYcGJ3UnZ6d1Y5RFlN?=
 =?utf-8?B?QmVYR1ZteVoyTUcrbjJDblg0RkdzekVDV0c5YVo4RjhhQzhQNFp3M1podVls?=
 =?utf-8?B?bVh5Q2h4aDg3RXUxWjBnYVhFdUNHMkIwWjlmMEdUUmp6aU0wN0tBbHliYmta?=
 =?utf-8?B?WG1GaFdEdDdJTWNrdkNQQ1I5Wm5VZytqaVdyaVY0cnQzanhLTTZmbWF6dXp4?=
 =?utf-8?B?L2pLZFJ3aWU5M1BNbjQ3TTFvekNMcUpPS0JtQXh1TU84MGRBYXFZY0FCWXBJ?=
 =?utf-8?B?dEhPa3hxOFdaTVZpbFRmRmJkRHdYZ3hNOEpySzVSSkxXUjhrSUZRbC9nMiti?=
 =?utf-8?B?MXMvZndnK2F3Zi80QXlZcDFGR0hrZDJFQVoycTJYczkzOEVSanpma21BSnRM?=
 =?utf-8?B?dGV0c0RDSG1ieU9NUC94Z0lzVEFBNjRrWUVUd1dXM0gxd1lmQmZtTUU4bDJk?=
 =?utf-8?B?NXg2bFQ2K3lET0QvSFhiMUtZdWpBdUdnV2tQT0YwZ2RYWjFvM09ZT1l5RWx0?=
 =?utf-8?B?MkVDUWExdDdMQ1NET0Fwb1VPYjRCeW1sMjFOclMzZFRVb2JxNC9PaEIrenNP?=
 =?utf-8?B?aDlzZm91NVBvb2ZoRzBQUGFiMkZjcGh0VGozcUhtZmJRM1VRMENKem03MHpQ?=
 =?utf-8?B?dDFKVi9EdnZXRzJicHYrcW9mdlQ0SU5ZV0tlcm5nSEhkNlAvZ3FEeVFYR3NN?=
 =?utf-8?B?UUgvTzNuV1NoR3haVkJKaTYyL2UyakxBVkltS1hTYm5PMW9pSDRHaWcwZzRJ?=
 =?utf-8?B?TFI0Q3dNZVFCSENXdFlOSmYwNHhPZTNBSFRVeFRDMXc3YmQ0V01jaWgzMWp0?=
 =?utf-8?B?TFVvMTAyUnBZNXU3NGFQMlFmSG00YTlaSHlzeVB1SVRVbmhrNFVEVnp5cU5D?=
 =?utf-8?B?Y1d6R2UxVWw5aGdQK3h1T3Y3QkczVkFhcjFxK0kva2orZ1llaGdvYlVWZE0x?=
 =?utf-8?B?WlpMUHA4MER5K2ZZaWhHYkUvc01QKzRMTmNZbDZtUzEvVjJHWTA2ZlhEak1v?=
 =?utf-8?B?SEZRR0hEUFA3aUNwOHoySlVmQ0g2S25pRWN4TmFsNjlKZXlCWGI2VG8xeDY3?=
 =?utf-8?B?MGR6MFNMS1MvTTNYckNxT0RJSmlydXk2MEFCLzBCdGNmUHByanZHL29laUt3?=
 =?utf-8?B?RXBoU3ovSWExNUdDbWxZV3BNait1UkhZSWZKRi9LSFc1Wnc4dVRJOXFuQlF5?=
 =?utf-8?B?VHhmOG1CY21QTHNEYlRGY2ZHZHU5Mk51KytyeDhVSVQ2cGxLZDdmc0F1TldJ?=
 =?utf-8?B?YTN5Y3dYRGwxQ2RaZ2tmb3NjQ25KUjJFWm1BOTFtTWlHanFVOHJkKzFRemJr?=
 =?utf-8?B?aE9OUjZlVHdQVDBOd3VPeGY4eWViY0NaODl4dkdtekNOU1didkRQbEtiZUlY?=
 =?utf-8?B?Z0hQdG83TEZydDNvUnFwUWQwNUNlMVJLdzl2N1dZYSt3bXFZZ09abkFPeW9K?=
 =?utf-8?B?WlN5aWhaRDdxWkJHL0dwRlFZZUZtOGNNOUllVkt4RWxIVSs0MXdEY3cyeE53?=
 =?utf-8?Q?jAkn4y?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWk0Q2JtSXQrUjJzQUw0aTlkMFBFYkxnVTJqZUR6clZhQ2RUUzNnZ0ZwaCtY?=
 =?utf-8?B?dVNtbUdGbEMwQUFvSHViK2lnb1FORGhvV25TTnA1Wkc1bWRIRGNrcGFVV3lO?=
 =?utf-8?B?SlNzekE3TkRkclhjOGkvUkcvVHl1SGlQbVZDb0pzRlBHQTNKMTVCUHdpait3?=
 =?utf-8?B?bGlPbWtlSlpBMGk3TENRSSs4Y29Pcm5SUEJxcW00czJEckE3NzRIeHdFUkJQ?=
 =?utf-8?B?N2k5QWVjaHIwN09neUplZTl6RU90dEF1WkQ1WEt4UlFVMEF3c1NZQUdRVXJO?=
 =?utf-8?B?aml3TFlHb2RaY1ppOU16Q3YvRjJDNVY2dUF4aTlFV1UvV1Z0emRoRmszWjNk?=
 =?utf-8?B?T2dNRW5pa09nUy90eDE5NkFTS0VWNkZVTkZCMUN4b1FRUngvUkVYQUUxT0dU?=
 =?utf-8?B?YXhqWkdpZFUwZ0tsTmdHREZIZGNQZjFiS21BdFRSU24zTW1MS2szUG91UkVS?=
 =?utf-8?B?NXBGOEd6aGV2ejFadTZFU2VBWW1jUkRTTnQzRjlWd3hPOE5BbFVwWHR2NmZ0?=
 =?utf-8?B?SEpTL0VBTUx3R0FKcTRGUnptYkUyS2pBUUpFTlh5N3JGQ1ZrTEpEWmFVWTZq?=
 =?utf-8?B?WnNkQWNYTUpPdjN1SnhVNVFOZldlVEVuY0t0d3Iyd0M3OXFENFlwQkhrRXla?=
 =?utf-8?B?Q1V4aGJ4N2JpRUdnVzR3STlRQzRHNGNlZTdIT0JNUDhVUjVuQURJREhiNDJp?=
 =?utf-8?B?S0w5QjNVSVVQaVQ1M1craE1KYXJJRmxrS2pxT0JqMVE2dUVGK3l4MWZQVTEy?=
 =?utf-8?B?UE5zK2pvZTNZQTNzbkVmVFlpUUpKa04vL2tCT3RQRVc4cmlSMm1QWjlTK3Z5?=
 =?utf-8?B?Y25lM0dnWWlVSUhnbzhVQ2hpdEFSY3k3VnAzTXNZOTdOTmZxTDIyenErbExI?=
 =?utf-8?B?eng0WFdtR256azRRYVRGYW41eHFXTmw3NERuSkJmaFdJSUJRK1c0b1Q3RUhR?=
 =?utf-8?B?TGhKM0VkUk1aMm16NEsyckNxRXZMV2FxSzc3ODg4eGkxQW9hR1lCN0FKOEdr?=
 =?utf-8?B?WmlUTFVZbkN4ZHNvc1BoOEc3SjlUL3E1UVgzTDNibENLSC94WUxiZVJabVBW?=
 =?utf-8?B?SklrRitUQmoyU2lMVFNiL2I2Z0ZCY0c4dkVUZHh4OEsrbWJpL3d4L29HVjZo?=
 =?utf-8?B?a3Q1bVF2dWhxR2FHRUlnaTZiWG1MeWNXNXdSY0d4S3FkRWdCc2xqK0YyWE5m?=
 =?utf-8?B?dlZhZlVIbDhmUXdWOVlFMjhhVkNRb1pibGVDUGIwTVcvYjJJQ29aUVVWb3B1?=
 =?utf-8?B?aDgvNVlRRHNJMm5TUDJNcGdpeHJLQmVmUEwzRVg0UmkzcnBjK2JvR0RUZXNP?=
 =?utf-8?B?N1p4eEV5c1diWGdCSUcvcC9IK3did21UZkFwMTJsNEgvYTU0Z2N1SlRDWGFn?=
 =?utf-8?B?SVFpVkExdGd3NTlZcFp4Y1pyZnh5STVEN2NhbzRJa3p1MEYxNHlvTmdaR05Z?=
 =?utf-8?B?SWY5VWpNVXY2d1lmbVRkczl0eWZFTDc3VmdacnJaYVdadno3bU1WWk92aEVs?=
 =?utf-8?B?UHcwQklDWldUaUd6eUVMNGZBR3Q3V2VDL0VwbmdOUm81eTBoQVlZTU5xOFVu?=
 =?utf-8?B?YmxwUXFtT2RycjNlc1kvKzZITjVubnZDVXBBdEJzazN5WWRoU2lKZ01vZHRj?=
 =?utf-8?B?bVEwWUVtemw4V2g1L0dNR0hsYkFoZnl6VVkySis0VllpaXFHdzJDRVdzWjVz?=
 =?utf-8?B?WGN4T2JyVVRVQ3VTRTJRN1lHV09wU3NmU3hqWFFSV0d3WmRVNG9TaDM1T2lx?=
 =?utf-8?B?RnUza29oQVRZUjFBeGkwOXpGQ1VTZ0wzdzRBNmljblptWFRBMWJWRFFQRmt4?=
 =?utf-8?B?ZUdNMGJZWC9nNEM1WGV2WFVGWTdzMVpYdHFRWDF0cEx0ZmdYcStEOFdiZ3pO?=
 =?utf-8?B?SnFXZjkwaVkxQ1BUajdGVjZXeWhsL3kxYkFPSlpGNUlqRStuS3FGSDRabnpm?=
 =?utf-8?B?SVE1U3V3QnFEdWtrdEI4anN6ODRtVGFYRmtxM2Yra2ttWGtuNDNXYUpvTVVQ?=
 =?utf-8?B?QUEvTDlqM3RsLzhLT1hGQnB3YWFnTkUrSEtpS3NDbHJyUjNLZ1ExR3FBUTg2?=
 =?utf-8?B?YnlnNHFWYlprT3laRnI0YThHVGJjOW15M0F6L2JzWGNGWW5kbWZQN3lVcWVF?=
 =?utf-8?Q?jvAjTMuugjpN1HshPj+jiIKuQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd19ac0e-a2f5-4800-66af-08de28cfdbec
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2025 07:30:34.6123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOWiiRM0cyNWZIYxK7S/0ZSC/FjPj7dmBjEb6ntBJAwwNlr12azYf0g3YsR/WDruR6nIoTKJvAQQMRkl79Pa7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5029
X-OriginatorOrg: intel.com

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlk
YXksIE5vdmVtYmVyIDIxLCAyMDI1IDk6NDAgQU0NCj4gDQo+IE9uIDExLzIwLzI1IDIxOjAwLCBK
YXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gVGh1LCBOb3YgMjAsIDIwMjUgYXQgMDM6MjU6
MjRQTSArMDgwMCwgTHUgQmFvbHUgd3JvdGU6DQo+ID4+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50
ZWwvaW9tbXUuYw0KPiA+PiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gPj4g
QEAgLTI4MTcsNiArMjgxNywxNiBAQCBpbnRlbF9pb21tdV9kb21haW5fYWxsb2NfZmlyc3Rfc3Rh
Z2Uoc3RydWN0DQo+IGRldmljZSAqZGV2LA0KPiA+PiAgIAkJY2ZnLmNvbW1vbi5od19tYXhfdmFz
el9sZzIgPSA1NzsNCj4gPj4gICAJZWxzZQ0KPiA+PiAgIAkJY2ZnLmNvbW1vbi5od19tYXhfdmFz
el9sZzIgPSA0ODsNCj4gPj4gKw0KPiA+PiArCS8qDQo+ID4+ICsJICogU3BlYyAzLjYgRmlyc3Qt
U3RhZ2UgVHJhbnNsYXRpb246DQo+ID4+ICsJICoNCj4gPj4gKwkgKiBTb2Z0d2FyZSBtdXN0IGxp
bWl0IGFkZHJlc3NlcyB0byBsZXNzIHRoYW4gdGhlIG1pbmltdW0gb2YgTUdBVw0KPiA+PiArCSAq
IGFuZCB0aGUgbG93ZXIgY2Fub25pY2FsIGFkZHJlc3Mgd2lkdGggaW1wbGllZCBieSBGU1BNIChp
LmUuLA0KPiA+PiArCSAqIDQ3LWJpdCB3aGVuIEZTUE0gaXMgNC1sZXZlbCBhbmQgNTYtYml0IHdo
ZW4gRlNQTSBpcyA1LWxldmVsKS4NCj4gPj4gKwkgKi8NCj4gPj4gKwljZmcuY29tbW9uLmh3X21h
eF92YXN6X2xnMiA9IG1pbihjYXBfbWdhdyhpb21tdS0+Y2FwKSwNCj4gPj4gKwkJCQkJIGNmZy5j
b21tb24uaHdfbWF4X3Zhc3pfbGcyKTsNCj4gPj4gICAJY2ZnLmNvbW1vbi5od19tYXhfb2Fzel9s
ZzIgPSA1MjsNCj4gPj4gICAJY2ZnLmNvbW1vbi5mZWF0dXJlcyA9IEJJVChQVF9GRUFUX1NJR05f
RVhURU5EKSB8DQo+ID4+ICAgCQkJICAgICAgQklUKFBUX0ZFQVRfRkxVU0hfUkFOR0UpOw0KPiA+
IFRoaXMgaXMgbWlzc2luZyB0aGUgaHVuayBmb3IgcGFnaW5nX2RvbWFpbl9jb21wYXRpYmxlX2Zp
cnN0X3N0YWdlKCksIEkNCj4gPiB0aGluayB0aGF0IGlzIGltcG9ydGFudCENCj4gDQo+IFllcy4g
SSB3YW50IHRvIG1ha2UgdGhhdCBhIHNlcGFyYXRlIHBhdGNoIGFzIHRoYXQgd2lsbCBiZSBDYydk
IHRvIHN0YWJsZQ0KPiBhbmQgYmFja3BvcnRlZCBmdXJ0aGVyIHRoYW4gdGhpcyBvbmUuIFdlIHNo
b3VsZCBoYXZlIHN1Y2ggYQ0KPiBjb21wYXRpYmlsaXR5IGNoZWNrIGV2ZW4gd2l0aG91dCB0aGUg
Z2VuZXJpYyBpb3B0IGNvbnZlcnNpb24sIHJpZ2h0Pw0KPiANCg0KTm8sIEkgZG9uJ3QgdGhpbmsg
d2Ugc2hvdWxkIGJhY2twb3J0IGEgY2hhbmdlIHdoaWNoIG1pZ2h0IGJyZWFrIHRoZQ0Kb2xkIHVz
YWdlLg0KDQpJbnN0ZWFkIHRoZSBtYWluIHJlYXNvbiBoZXJlIGlzIHRvIHVuYmxvY2sgdGhlIHZ0
LWQgZ2VuZXJpY19wdCBzdXBwb3J0DQppbiB0aGlzIGN5Y2xlLiBGb3IgdGhhdCBwdXJwb3NlIGl0
J3MgYmV0dGVyIHRvIG1hdGNoIHRoZSBvbGQgYmVoYXZpb3IgKHdoaWNoDQpkb2Vzbid0IGhhdmUg
dGhpcyBjaGVjaykgdG8gYXZvaWQgcmVncmVzc2lvbi4gVGhlbiB3ZSB3b3JrIG9uIGEgDQpmb2xs
b3ctdXAgcGF0Y2ggdG8gZW5mb3JjZSB0aGUgY29tcGF0aWJpbGl0eSBjaGVjayB3aGljaCBjYW4g
YmUgZWFzaWx5DQppbXByb3ZlZC9yZXZlcnRlZCBiYXNlZCBvbiB3aGF0IG1pZ2h0IGJlICh1bmV4
cGVjdGVkbHkpIGJyb2tlbi4NCg==
