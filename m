Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244983CC9F5
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774597905; cv=fail; b=GhIU3UgIUz2AVcoUS+N3oboS31aCIVVnvcYv9qBMwxuaa4iPTWD7UmtVYd4KzBveaIz0Ck/CHKXIj/mSLc22fYIEMSYiG6S/oh2TBwK3sKf8yLAHqOTh2cbuf+xLQ+S+x7PlbAEQqp/aPp3/D68iXmEWHlYcUU3kDHnE5NquYCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774597905; c=relaxed/simple;
	bh=5f+olG4kSrNX1NG2hH46p1AuKtel3xboUrGjW+UoKQk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ICkUdIbvC59o2nwMce0N3yCsPH9O10XZs/91cuD3fzJBhmE+g/TpQ24Ocu0eiFZRt6FcevTqX/pPWfEtK4eMH6WHp3GvtnoU9+jqCuxtiBmP5r3kW62VXZ+4DBy89sL+btyup70Se+ehgPimAXmtKKUR+d8RsXYtNhSqoMhUG3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViYnJ0oK; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViYnJ0oK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774597897; x=1806133897;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5f+olG4kSrNX1NG2hH46p1AuKtel3xboUrGjW+UoKQk=;
  b=ViYnJ0oKJSpe9KMhDiFlE1WZ3It5agTpObVlHrbNNcGi811A9p9WlJOS
   PvNOP6S3kB5VJqNchfSAqN44tVq1fPsNtFicocBfVfXT96iO4vr7EDLvK
   Mwt/b0R3EW690N/u8e01JPcFPc9HOvwQYY9iwU1xMN2NuuS1BicQuEI5G
   KiJLnO4Y3sWQwx+e71vq7+uy6IpJSRbvCPET2RUsE2/inF3UCr1fjnO8g
   QTqVdilO0hrGn+FovNL6DNMsFK8BqS8/9+1y+hqKHl3MoO9J4jueafkoo
   dO9kGntexaJXhhp7lhupUXm6dazYY6tg1ToQlu36knY2BySbOFTMLhlvA
   A==;
X-CSE-ConnectionGUID: hGQrNdUERQqdfmMNUbyG7w==
X-CSE-MsgGUID: 6/6SjItsTq6igGwXnQvjoA==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="87142340"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="87142340"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:51:36 -0700
X-CSE-ConnectionGUID: 3wupuZN4QneOK+kgJNY+4w==
X-CSE-MsgGUID: 4xQDoTONQ4SX13c+SI3Vkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="230174337"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 00:51:36 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 00:51:35 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 00:51:35 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.25) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 00:51:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y4UvqPpP1OwAhAg6/5HMHV/CEtQWascpcC/Xp9z0MQyq7mcMGk0SQKM6wz0kPwWzEi66SgTDUzEQONw+Lm0E6NenbL4M0D0ZWAnPymppCa8a7Wx4amMU9EP+Tty8/tZi9YYISwQbe5qmv8k10GvbAQ75UlmPU3ia64CdoqV0MkF3TngHqtOe9M7M6HNwZ1z4sOXTaWL0u+30kAtPe1F3aKyUxsmSkALG52W4K7BBjvWsalo131Oyza/M7HpLhfIWWFJ2dk0OlGSdnhDgZ82/4mcqIPytoEQqyYyY47ufyH4fLBtm0bBGBtJfdnqYorJvMQYpfxaAzwlLIRBsDsIRXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f+olG4kSrNX1NG2hH46p1AuKtel3xboUrGjW+UoKQk=;
 b=YJjAkdfi5nIC+CJSijyk/FR+fcFsVOegszYFv8550VlNBknODaUw8reaCGlZ3alaDMZF1J1a/z3mDbE5r0NjeZ0FKfgeshSHt6xCgLnlsk2qz4lWwjoB/M+ZVNUUUcyFWzunSTiskRf0zL8c+H1bcelLZ2fggbj7GR5BORX90blM1/3WFTBQpgnIolbzeF/njEGbNeOlT6G4d73bRPGhEApOu16vwGEIeNYkE6IMyUQgIt0eaCz9QVFQJ4+fqWlqyVVInuqhJG5wr6ryNVxgRXnH0V2uLsljSnKdsoWJfcZZwV9fannEM4HnRjLPQuHwqi1du4gfWOqu63fCPeM8Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB8369.namprd11.prod.outlook.com (2603:10b6:a03:53d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Fri, 27 Mar
 2026 07:51:31 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9769.006; Fri, 27 Mar 2026
 07:51:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC: "dwmw2@infradead.org" <dwmw2@infradead.org>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>
Subject: RE: [PATCH 2/3] iommupt/vtd: Support dirty tracking on PASID
Thread-Topic: [PATCH 2/3] iommupt/vtd: Support dirty tracking on PASID
Thread-Index: AQHclkf1+BcH0VI8sk60p1zRgtt1G7XCUAJQ
Date: Fri, 27 Mar 2026 07:51:30 +0000
Message-ID: <BN9PR11MB5276C8A77E8968F8E0C1E6E98C57A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260205023405.41583-1-zhenzhong.duan@intel.com>
 <20260205023405.41583-3-zhenzhong.duan@intel.com>
In-Reply-To: <20260205023405.41583-3-zhenzhong.duan@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB8369:EE_
x-ms-office365-filtering-correlation-id: 70d93674-e324-4e81-749d-08de8bd5a8a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: i9OcfWak9ma18C8lIxM/fqAksWfrEmcWiJn0soTk+Bq3rJUDHRb90678U+8dmdqjkKnrknh84uWsgmryHkx9NSvqBUpopELPvi1zBBKs/C8GHyrSCXL0vNeppGBsDW+y88KoJDxNjJ2zHVJ1gym/qf9vkSYth0EeUQJ6ywCaToG8d6J65ulPN7XXK/ulJtPmVgpy/4LkIp7QQeH82mAfrxm8WNE0vDUOhIJfJEyfUhtDiKT398GcppwoJW1G4RC/8iMGX/j1qavF8eOiAS6h51YU4PIL+5/jVdm+H9FGhAThQio0glS0mJ3g7yTWARPvmIlPNVKdElxAogo1o3NtTrzHv/53X7IBu0pJPWnYfhxxADXXCJ81VfmI70u8HNQby+lE+Imi8JE0nxsyy5pGnhMkKS/XPd0YQLuMC5vS0fLWZiHZ/WxIRQ8xyNMIjN2wEDftPCja2jWESlfZsic2/LnroGPYxBxG3PY1sgKqxKp+/v6b+lRhorymRDKIDDaN0gqe5t3xz+4Fxchrn2jQJxZ2Z+53HmyD7B7tz2eiXMFePcmyTo3Fxn97Fq4M86HRO8TbSEmMrXujDCNUnn5yB2mb5pB+4cIk2/5vxz5a0M4db2w+6+wYBGJgc25AxrXFTJJdrUm5mFv0In4cYwTi/8G9gXXa48qrRLzj+dQJ3kycZ8LQ//exvwKl55l7xVg7o3WqDI4Gp3XEohudu++WVRbhLt9h7mrw3ahnkSSr00FCVo9kbdx+UhpkZL7jUtynHPeCXT3zkOo0v4Bd1cLLbEU5c7Zu58C3KWJM97sDjuc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?01UY+UCYNGTLtUmBMTDwN4YwLW0S/zt56mVv1fNQGx3vIKB7gGijkLNAAoC3?=
 =?us-ascii?Q?9XxjH9w3ICtC4vtLKI7nVCtei4XTJ4dN6byzlJvinkNzYLwKUotE0bK6eJly?=
 =?us-ascii?Q?7fVGrM8juqxEFf4qy23rNY9R51tCeyPtc8qww0N47St0lggwV9AJxYiqj+3F?=
 =?us-ascii?Q?ezxlqiXySsio0H4SicTzPz3DrvtBwwL8q0at+hL+3geyC7XnxCU4X7I2UzKs?=
 =?us-ascii?Q?KnBTg0B8Cjw2GsZLOCFRovLtgwKX0ddyYtavu9NlEHh7AzQ5Fm4S4WhEXDHN?=
 =?us-ascii?Q?5oQvxr87pScmhnBMfSoneuZlGaG1bUkEHCeZHYJXR/VZwP0NNBhLRGhaTR/Q?=
 =?us-ascii?Q?xqz4Tty9WwHxy1fMmYg3FkK8Xg7yh15kMV4ldjFalqNQ1ECXCyo/RbE7x4ox?=
 =?us-ascii?Q?c0nXk48gIQ5wZ+2gUADUJ7QpxfBCN2RhmSZk6lCpyBPRistQbF9CNJOl2XH4?=
 =?us-ascii?Q?rEffCDMeKHDiLyh7PMEV5wdH2JzQdva2uH6SFboN1m0Qp1V1lR+1QpYggZZ6?=
 =?us-ascii?Q?35Mxt9T3RuOXBAKXCC27I2jgNa37wymJo5TebDd2AOEdoOEi+MiPerDRsK55?=
 =?us-ascii?Q?wQmLwBeuWRwkDxjHWbWXntfKT0nEwQC9Rgo2XVlgbjQDH9Tlc0W9p29go85f?=
 =?us-ascii?Q?HFmoZCWblc94fq5TDjCRet7BLC6q1ms5Aza0PTfE3pv6/Ux5r3vNeaXP0tJr?=
 =?us-ascii?Q?Q4gNTH+83y195JFWgAAV8FxGHmKXQOavAStxo2BOyD0CVSgXDP704a7Dk5zb?=
 =?us-ascii?Q?lNQ9a7xhj2+Lqt2pE67zzm+xiUtEWlFqH27qlkIYLpj4R2wADWKLgK2Fsivw?=
 =?us-ascii?Q?JhN+herxeNnreEhiMeMwvLhqYPHOfFdLEi97D2WjCFjBs3hO2cRBqmv9TY5K?=
 =?us-ascii?Q?mmJSOZrs2GSD0kXQE6stwZPlSCgNHKsxHWZtBK43vhKHh36JGQzpCRGfYKBQ?=
 =?us-ascii?Q?55KfkyqXLIu/MTeKp9tDvEmxjSgvLTXzgCQKoi/4IfO7OYMWxo6cp0FUMwNa?=
 =?us-ascii?Q?0p9ZsvRezd71fvvPaoPpAEAiNYhjRzjM/ZvkMaOhIpVY7c/G5T2fh8PEbq5t?=
 =?us-ascii?Q?iZC5UilYfbX2mQCykDZpL79FXCGfuaEc8vUY4pN5tRK93tOM1ePmlOgHTLFe?=
 =?us-ascii?Q?yx9QokaPfo1Cn2mprrwLA+aZEDj6wN2Sjss5STRL7MH5ItPAUeY/y0y+mZxj?=
 =?us-ascii?Q?og6A7Z3uoBAlu3nhGWKsjCT2ShHBorH3gI2M40YXQ9TL7M6ntxl0zGfNKS/+?=
 =?us-ascii?Q?HWZcNitLMlklsDzHE4bbElFx2P/9PWY1G+54lQe5JlJYSoi/vkAMkbBmUXOw?=
 =?us-ascii?Q?CG1fA/fvS0pfnk6uKldPYpJLLhILi36WpTThq0h73VOUEJNsuq7Xg0j+QTgO?=
 =?us-ascii?Q?Ry6Mr/H7gArx0Y9FvUy3VCu+njK4J5oFmya7j9iXMp/MktSYcjHYPk09onmk?=
 =?us-ascii?Q?3lRhWuptLIdahyhFOEeSRviIW8evny7XMPLRXOFKT2DUdPvBWMKQiYWmbIbP?=
 =?us-ascii?Q?6pRS1nTadIg4yNyNieeETlXn/2A3/2Ai6SmacAJdcb6DCFA3Y0EYDWUKYAH/?=
 =?us-ascii?Q?B/cwNCdehoQKd97XwIfE26k+A93Mvzz6X2H0ox4Djrl/ndoaexwuN60r9Rcr?=
 =?us-ascii?Q?27CCvE9wsg9bA12yX9rxnuc51Pc9EacItYJp7GvLpUTWaLO7L3uJbHZmnBoK?=
 =?us-ascii?Q?YvF94WkvKiqRsGyXFbQwGqTvCLgPKHn2vOBpJUl+9/Zd5hxA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: c2R2OEDu7OBDKJ/vDL9FMvmljrR4yxjY4KjuJAStIFperDafVsjbrB06ahlR86087L0r8fHIAA90khmoTnWdzW65gaj/hoqu73+mX6890alDB1/wC6G94I/ITk2rng/tNRXhbS0yeSg7fTrIZnUZGiu2enMRsNd14Ktwub7vkn0IJ9LTQC7PkRkkbYJqkfi8+YczPeofPahyGl/eOR2eEh7ILo1ydzisjVuUhXano7DBnDDLIfAWHMEO9ie5kskMDiQm3QzfNu3bhJ0K4cM1OsddvqkVCRTWKPr9GoIoAeAcJTPqV9yHt87k/OWgPvsICzC1oiEB4fClJ2aSFqa8GA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70d93674-e324-4e81-749d-08de8bd5a8a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2026 07:51:30.6635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bLIOOvF1xv7eyeYtDdXqOpj3VVxBNBIsvfJTqqEp0zpLVYbp5yZNDwTUvijR+Hv7ZQbsujaxXag6RbVTV/UzDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8369
X-OriginatorOrg: intel.com

> From: Duan, Zhenzhong <zhenzhong.duan@intel.com>
> Sent: Thursday, February 5, 2026 10:34 AM
>=20
> In order to support passthrough device with PASID capability in QEMU,
> e.g., DSA device, kernel needs to support attaching PASID to a domain.
>=20
> But attaching is not allowed if the domain is a second stage domain with
> dirty tracking, this is the use case when guest configures 'iommu=3Dpt'.
>=20
> The reason is kernel lacking support for dirty tracking on such domain
> attached to PASID. Same for nested domain even though there is no such
> checking.

no check for nested domain is a bug. We should first add a check and
backport it to stable kernel. Then have this series to allow it in new
kernels.
