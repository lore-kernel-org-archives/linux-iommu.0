Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680493C1403;
	Fri, 18 Sep 2026 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789698644; cv=fail; b=SO5i8TWgAC01q/G/3+nhTwyR43WvwsvUq+uZTDbNNbiNq2VU5PUwT6GtrA0xdBO5oqDkqyKo2kGlDihkmrxsDN/kcnYrpNOOB5tYXcD9XMCFiYEueYfyxIN4lsRIEW05+a+r2LrAq+0oN3RusaPpgOmf3ck6/9YD6+TQGKkuzUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789698644; c=relaxed/simple;
	bh=giw15jFZv3MEgLhVN6AZdLvRxoZLprv/yyWR4YGpxV0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uM4AOhyJ7Ppd9Id7oKEtdswQaCkP1pEjUGjlN/kpNwj0sWBrH5Ic1UyeYgHoyCWqmLwp7jImjZlAtk12alYcOzkA2GmckXaW3LpRtFSA55oQciEpGURTZexfxtwhhiA1lgFQ4m8HFlYmYZyes6dIscE0+G8zuKXgU6k01ipgF44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cehaElI/; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cehaElI/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789698639; x=1821234639;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=giw15jFZv3MEgLhVN6AZdLvRxoZLprv/yyWR4YGpxV0=;
  b=cehaElI/mYs7QByuRV3XC/7W5gm/fSUQuSPxvNsaxGvsS6hw2yRuehWT
   /LreCUiW2JfBjTGPLWLJauh/i3vjuTHfzlsMGi6r/wwoMNGtLlOMjKxPq
   ElCpt5XM3mfnxlvJX9vOZ6h6MN8tcfr7w+iQZipaRh41kTyKSP8UM2zmU
   /66sHh6qpA3MrfzOkr1KyFlzLA1KxYqqHRUIimMowCQZUzqj/HvBpsoKd
   VQgZQVsSF88XCo7jUoCslH6M+Lt7SrPLeVsxX9cZVYc9eQhd6fUuvX7kQ
   wqnEHXYYzbBNMCzZCeZjjul1njOdh1rKmJCT0aOUcuTFQw+k3WM8W67z5
   Q==;
X-CSE-ConnectionGUID: d6XKC9KsShKJt+bVv4ClIg==
X-CSE-MsgGUID: +4KWySEdSieuZvUHpeKmOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90040926"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90040926"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 19:30:33 -0700
X-CSE-ConnectionGUID: jPAOAD3oRXOSP/fmipaweQ==
X-CSE-MsgGUID: GXVSXe2OSjqkExZ4yhR+5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="2354058"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 19:30:33 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 19:30:32 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 19:30:32 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.8) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 19:30:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQrrDgPK0VIijwocqw5X2fNywzglBQL1gv2oDGPyk6Q04fm8MEfUcsaDKEmfwegshVzbFtDAw1bZVQ0UX0rmG5ZUbrYyKUmEZhLPQnRQT81jOCn+Ve2phlGm+oICUGz7EZzzAxA77lwEN6Zx/m495pdeR4XoHxVgIUS+8rkeNJronzLQcD5a0crCEin+XIzcf3Q1d81fbfVl472qHilSX/wczFR0pgWwQ7OvB6sYR7TyXxVmExz8A3Qc9q9uNliGatXOBsAJxoBoOlSf0e92QW8pX2Fxj6zUM2M/rv6t+pWyu2gTQOp4TTSnMmLIpI7fSDlql0ao7U3wLPQz1Mp84g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cksQpBehesMncaQLVo3ma7/trTPEQp0fk2JYuSqlsMI=;
 b=B12zwX/7S3vY5VzL58P2SfYH/zq3Nd3kMDyO0NKFhERbl3E7rlplg9Zss+pe+Iom94QXr+oZJFNObjLPbs6Rmwn4SuWSVGhGo4lxOFWBjJsf457y4P8BysePhevQdk92HqZUo26jnNYHv7noPJjXy3PK+1csXVG5dpMj77t2oGjzsJijcBq2b5j9tXwIkYzUuXfNmfpiBsIYkDKJkw1OIJvO9wkgBS8wBeS8YX7G21pX9ISg/49/A/NpVL26/dRWjZkUHwHuR7BnKi38qJnaNyfe8aGWLm8dHX9E5xkRb3FvGPBcn+5RIeKCOJgs/67/EQcb2M30FMQajyMbImxeIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by LV2PR11MB813179.namprd11.prod.outlook.com (2603:10b6:408:416::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 02:30:30 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 02:30:30 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Dave Hansen
	<dave.hansen@linux.intel.com>, Kiryl Shutsemau <kas@kernel.org>, "Edgecombe,
 Rick P" <rick.p.edgecombe@intel.com>, "yilun.xu@linux.intel.com"
	<yilun.xu@linux.intel.com>, "Li, Xiaoyao" <xiaoyao.li@intel.com>, "Gao, Chao"
	<chao.gao@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 0/5] iommu/vt-d: Introduce trusted DMA initialization
 support
Thread-Topic: [PATCH 0/5] iommu/vt-d: Introduce trusted DMA initialization
 support
Thread-Index: AQHdROd8qU6nrZ50F0Cb3pQGzMlJWbbToMag
Date: Fri, 18 Sep 2026 02:30:30 +0000
Message-ID: <CO1PR11MB48351B13F0143DE043EF15378C872@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260915074235.1219183-1-baolu.lu@linux.intel.com>
In-Reply-To: <20260915074235.1219183-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|LV2PR11MB813179:EE_
x-ms-office365-filtering-correlation-id: ccb2213f-fa5e-4ff3-7986-08df152ccec4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|366016|376014|7416014|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: OJvRaNBd5NhAg4UtqhHSiCDcu2+1VRNkyP38GXgDzpVqTWdqtVLt1Y73FIJxg+0vtRu8WoINkHU6s+321FqQHN0e6Pm3Qm84GI5J0/Q2NrzdJiFB/yWO9ISKkhBPVcFG56cNjwKwEcEYtqhc3MqyO8c5vcVOw2iraPnmH5NFV00NTZX8tD3Udcr2IPZWqfS0XbJZ6qLf0BW0ECmp10VcjNx4KGdyGrv7FsULHfrOO+tLIySD/LCHUQJbBGGKNnHxbpC+rzji3P+G4bqVTKKJeEkaAY5nJrxXwD7hEcNEufhZbToEDFnf1L0O1kYRUXbdHEX8nAp2/4jdM8DfrU22DxhlQpybzsRGjSF6zFyB91P3MNKasNOW02QEdtAf8jDg4/xqb6UKECVcLBemUp0NgkqG91R8P/xEwljBVDp4txZNjXc5ag/Yuf39myR05EuyzhMdt2cBhawKsBfR8GuHLOTdAUeoSYYkaEeiOrkRlqZNKgdpmt4zNzbCUOpJti4q9JsDtsc+sYZsX1RUTF4PFL8aEdEFam1gYPn41X1o5ImY7ki6y+VhclpoguZvHjGje/U4+WmbzZZ4FEwVXRxnoKKQ70NMZBs+/F5vgN01Y/LpSgJJtXCptJpFL3ud4MhLAwNQIoSAqJgpPXEgSzv7krM1LXFwKpocn5BPO0wUMo88/P+jXMjCU5uC93YsOXtI5xLxaUXU7rsnQdf0dVX/T4MlJW1plV4tCUk384lM0LU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0PN+av4WcKUgigx3Cp5yNYLUW9SkQm5UsIbZscZ6sTzchn3IqjdZXOT3LBhc?=
 =?us-ascii?Q?IFSe+OLYxdqdD9TzQMhf1yAT/EsFRXq7YTHx3Usk1ykR6m2vMB6G+yeJCrVf?=
 =?us-ascii?Q?8pLcHnQfSQshKWFAlMFH3BXSpa6w45A1zZtDZUYicpeQWYtTUUpuGqpCfQ7A?=
 =?us-ascii?Q?3/XlUq7yf0DH7CM1/aK09CDML6dGMo/jO1BBjr0WWCq9QmROh8iZeVCMllch?=
 =?us-ascii?Q?Jmv+UouEN4v5Q4FsYSeX5xuknlWRpvTZbnVMMO0+nKVXKmMCm1/Qox9uBVYj?=
 =?us-ascii?Q?OyFP2Pv9MPHfKB9xdjkdePeFRr5WuuAGaSDMOUUsTbJniDq0eM3ki92ChN0+?=
 =?us-ascii?Q?HBljVfJ2iw3DFKQoXc1Zg0DYuDqCaSPzrPy5/VpC3ABjV3P61/TPpOU0252f?=
 =?us-ascii?Q?sw7/ED7pp9cKWp8W5p6CF+W31O2gssF64T0Xq/FV1uT2vZ+mV6Zd59nvP/1B?=
 =?us-ascii?Q?qXeUu8OTinIEWkXysbFtOnAnHssQc8XVPNc6hoQ1kJwlrIDsAVS0w2tm+5xo?=
 =?us-ascii?Q?gt3SKjDJou5HuUY4UUjL6CFJ1v1SY8r4FciKJ3PHD9eG3JIyEeTtAYrDxNUN?=
 =?us-ascii?Q?tJ5/NMGQ+R19S0VfHyTfO4TgJETR5CSS3yiLE5Eam+DYSVM+qGklfsbAulcR?=
 =?us-ascii?Q?8ZKdo1WIc+i+Cr0t4OIkCGOCFGqCAt3r3JTVc+4zQtxaJ5qYLL2WB/WlIiA6?=
 =?us-ascii?Q?xNIsSZHynfkYR5oxpqFQCbfVjVTOPYwgarBlv4zPmxJqP2nDtsB03YS5hV7w?=
 =?us-ascii?Q?OYA0R+NWOwlmTjQJSIyjcfI5gGgxnRCyS4+1c4VyVnnGxboB1iElDURqwGUe?=
 =?us-ascii?Q?ke4dpI8eWnkZ5NX46QDzH6u39ZcsXRE/KU//HP6eLosGFQRIlfPtc6ktX5qw?=
 =?us-ascii?Q?0jyPGHMdhJgurhotm/LLiwiZP/zruRA/LlkPpm7wsK27kPP5tpZYELI3m/Vq?=
 =?us-ascii?Q?PuhznqBd3cjR9kT6H+1QWewcy5mtFTB5lwdnkWwLC2+sUlxoX5Q+HYcqa8m+?=
 =?us-ascii?Q?PuvN2royF0iJWbdiQDaHKObxtjqbCJiAygJhJwWlhnsGjnH8vLXy7sOK7pUT?=
 =?us-ascii?Q?bBhXScphydnncyH2ohODyGcB21Yglnt3MLAD5WO7e+w/IMherjHkQbsmGzXh?=
 =?us-ascii?Q?Gf33UQaIzYwPTqsHpbURNg49t/rYzl42jxBiuMEldkXurgugmHaBN1qsCxoZ?=
 =?us-ascii?Q?8X/uM/MQS24DZy//pWjWeYWUNGwGqiFg/Ji3n1MGv92u/yUFW0zp8xSyB0J0?=
 =?us-ascii?Q?CLDOT1OTwHfOcnevGR1/AOcvyQRYIADDDEjDlY5k+G/huGHDPZoaTaysqJCj?=
 =?us-ascii?Q?a+ogYLXB7JiZHiXKlOmvO8b7Uq00Ol6DvCS6/CEQWACFfR4P9B8NGSwY5Ega?=
 =?us-ascii?Q?zDt77f1cfm1v5YX1O6To7bkb7W+c6S+4Iwx0Iet1eBDKN6rolQCQYh5Tsqpf?=
 =?us-ascii?Q?mkgwWauRGzM4RA99tGsdJneRX/9qlKCtdZIgoAkmfp8zZFrddPxO6XG09MZ5?=
 =?us-ascii?Q?EC96YTNE9ieBEnRPhyfONjFjKWi5SLnAZo+k66TRze5EybfzBJGvh18phlx1?=
 =?us-ascii?Q?EuznBH4uwGYwukjqexPpzZoULF3KvnqIiXnmgWD2n6uISeW+vjuk+Oyirvpk?=
 =?us-ascii?Q?0pYGMu59eURaeAMg7JYX1nNMUikwj4CwOFBxeGaUfkBUO3LjGaPaq4Of3dCp?=
 =?us-ascii?Q?ugaSoM6W5Sqoeje9Nns/9+HpgXAwQs8KUZ/vS+LgVpIAncRqhvLcK0nFDaBc?=
 =?us-ascii?Q?GemZCSbNTg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: NZe1H8noXcPoSSgoBo8F9A5uqlsol7XmM88wRx+un6kwGq6opOc5+MLDUA7311zoC7ZuwDo4Q8gnasvVQSRHzn3Oa8dKVty+s4w9j7HZ4rC39g3ifBfxVxM81tKJjAtBtCdyrN5i8WFX0wtMiIm3a9wh6l+o6bUeZRL/mlmWNM8jH1YNdYQGYf8vVUs8Fkg+pKHmcOuqwC6PQ3l7JbD+CU6itISGzz410Ovr7BmgJaDqcgfH/ou4QrDL2icMu/i4bH+GnXI5hzNGvti7HKPtnCRgzNQwlusVbJUXE5PLdoe5KB0Nu04ERNSejzRakuZ3TrDHCqf6eBVijVoY6Xmf6w==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb2213f-fa5e-4ff3-7986-08df152ccec4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 02:30:30.1252
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jLhb9OrbOMA76H6kzsv1URNvXOzW0WGst95UcuBGGQ1dC1kVSQlCqiSxNBEsnweTP4fjvY7PJT7+FCxa0sbyNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB813179
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, September 15, 2026 3:42 PM
>=20
> Hi,
>=20
> This series adds Intel VT-d trusted extension support to the host Intel
> IOMMU driver as groundwork for TEE I/O trusted DMA (e.g. TDX Connect).
>=20
> The trusted extension introduces a parallel, extension-specific path for
> trusted DMA assets used by confidential device assignment. Existing VT-d
> functionality remains unchanged for regular host DMA paths.
>=20
> From the TDX Connect architecture perspective, VT-d is enhanced with:
>=20
>   1) Trusted DMA translation root table
>      - A second root-table address register, restricted to SEAM SAI.
>      - Programmed by the TDX module with the root of TDX-managed DMA
>        translation tables for TD-assigned devices.
>=20
>   2) Trusted invalidation queue
>      - A second invalidation-queue address register plus dedicated
>        head/tail registers, also restricted to SEAM SAI.
>=20
>   3) IOTLB / DID isolation
>      - When TDX Connect is enabled, VT-d restricts VMM DID usage and
>        reserves the DID MSB namespace bit for TDX-module use.
>=20
> This posting focuses on VT-d-side enablement only: it enables those
> extension-defined resources and control points while preserving existing
> host VT-d behavior for non-trusted flows. Higher-layer integration
> (TDX guest/device flows) will be posted separately.
>=20

Jason had a comment on this from another thread [1]:

"
Okay, so I saw the driver posting for basic iommu support, can we try
to rework that to be split out like Aneesh is doing so everything
about TDX calls lives in tsm and intel iommu only provides a small API
surface to exchange whatever details are needed to bootstrap TDX
module?
"

[1] https://lore.kernel.org/all/20260916123954.GC3196566@ziepe.ca/
