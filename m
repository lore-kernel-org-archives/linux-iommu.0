Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DA8B5339E
	for <iommu@lists.linux.dev>; Tue, 25 Jun 2024 03:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719286801; cv=fail; b=p9Wplmlf+6zpkm752cwtmcwmChPorzyU7rXCXudY69a3qrvtNO3i8Fy/FUn0417RzxtqAjyymLKHvCcvYRs0uTUUpnTbwl9/Q8BnHkPo6llzbHjrFBS2SKkb9FG4mCFarYwnT+2lP+EnMGmjcrxEn01zUTi3xc9ydkoiPQgfvbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719286801; c=relaxed/simple;
	bh=fCNgBzmlYImSBmTLJiRGXI9irYxbufLohkOjD7VVsd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VkBFEbWdS2RKGBGjo1C3JBVGu21Jr1PCZ2wX4bKuyhLdJUuVw9Vso0hO0TWEGPL8Ypdlsvcz58rxN+o3Pv3f6aDI0g+tVZSEBEhCKcP2Qp8UlsQ6SE+fo8SGj8gxzG/GcdcwDyG6c3yAEpiA2Gt0V66jpARw/TDmF23NKsBJezk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUueOMqS; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUueOMqS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719286800; x=1750822800;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fCNgBzmlYImSBmTLJiRGXI9irYxbufLohkOjD7VVsd4=;
  b=kUueOMqSDHdh8qBNpSaSckJ+2o1lovM97L5iES983m98trYSW6FmxcJc
   5V88Yvd8cKQYXzstR/vakrTlEnFl9+qdDEhYeTxOqbF5qiyC35378V6IE
   Ip9tHmw6oNNNEDYC4/F6o5at1E2zvPt88JVNuuKBv2MwRAaQ3iYR8WgKq
   HucjBNe/MZSdtBpzz2al3YAzIXhmq6kLLvJuGYI3phgyDXUNMQDggI6DA
   vWIrahpU1c5ZptHG7Qf5Q8/yzPRCGJJqNwfKtYVJdr/L9UcXr04V22MTm
   WCHqSrYRfLA4ebK5WD6BAiJJ/0vcmXIRZ3n3atLEsvyn9jb3ABwuvHphI
   Q==;
X-CSE-ConnectionGUID: AZxRq71nST2fjjvr3O5AXw==
X-CSE-MsgGUID: RA6JYHosR7iyv+cEFNlZxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16413969"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="16413969"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 20:39:59 -0700
X-CSE-ConnectionGUID: TkyUPi/rQy6b8KSgRAQFtw==
X-CSE-MsgGUID: PZupkPUFRimbBV/tkQHFmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="43602929"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 20:39:58 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 20:39:58 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 20:39:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 20:39:57 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 20:39:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0oQSqNyKE+nWQMhyN3E4ZFDmxn71yyeJlgcD7OZq+VRTgLFQPi2QsoqCGrkQOmxUrFEDJRCXcoWHYC0c71wQBBIt8skP001At+VvN2iC14JWcYFQi37LIPmOn8UMUnLG01tFnJp2ILkm83BnliTg3ApXmIUdTavkyEBxgBiPqtlVxlqFqoPuXL99G5nDIsyfS1AG7trcntATEN/AQtcGcQ1gWSkAgWyv1CyBD23LBqMSPm900EXELLaVF7NIUU9marzoZRmod+eKJslEoiBcbky9MVyeDu1hxF6vl2RMpFgj1FDhcP2NSUEq9fzcOcC0fH5T1KFu9i0JGLVFriPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tg7rIIQFD/Ggg7FPWoNO8cNYWxD4b0KQZleJ2nkR10U=;
 b=cdRRhoTuc0RRClKi0gVeSc8PUsOaDSwvppysYeEl8k5ar2yujgvIzwpPmLp9ZA83kRHSE7RS1OdIm+XOYF7cXYMZGCfsaAX3V63rn1uecz1/njQ189w2bkOD1/82rwnUhy7+pNjtvtZLhEHL6mtrXKK0Ug1/PV0fUINIJwnxez6SXVGYXjawYEVldX80IaxSJC8Lx8WQLXGYABk6nXbOCgalg4e8SPaH/vzpvgM6MVAj06jHv2OqR/k3hbROrYWV8v2tKFKJ+z7mjPaw3Q4vnzrUFruzvmMKWdCK842xvZMBPjXHNc5wMU++uSS7Axnh3ax2Bdnyeja03joS/qNEJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5148.namprd11.prod.outlook.com (2603:10b6:806:11e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 03:39:33 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 03:39:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Jason Gunthorpe <jgg@nvidia.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Lu Baolu <baolu.lu@linux.intel.com>, "Avihai
 Horon" <avihaih@nvidia.com>, Alex Williamson <alex.williamson@redhat.com>,
	Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v1 00/10] iommufd/{iova_bitmap,selftest}: Fix dirty
 hugepages tracking and selftests
Thread-Topic: [PATCH v1 00/10] iommufd/{iova_bitmap,selftest}: Fix dirty
 hugepages tracking and selftests
Thread-Index: AQHaxArymWQciMw3zkuIG/wNFyVFlLHX2jow
Date: Tue, 25 Jun 2024 03:39:33 +0000
Message-ID: <BN9PR11MB52769389B602CFD5B11DF4848CD52@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240621184254.45477-1-joao.m.martins@oracle.com>
In-Reply-To: <20240621184254.45477-1-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5148:EE_
x-ms-office365-filtering-correlation-id: b663ccc3-822a-4ba5-bd1d-08dc94c86da7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|366013|1800799021|38070700015;
x-microsoft-antispam-message-info: =?us-ascii?Q?fMxPYC0RK4P5c8lDk2E7lbLKkVM0oezEGLb9fmCqvrm3AqMTKiTd6wLsZPjS?=
 =?us-ascii?Q?Q91OIIelfmDmYLddWcY3kJsgXYeJjtSXndw4ec+zqCOmGgVGHU2MYk+RD9e5?=
 =?us-ascii?Q?D67JFOAg7b4Ry/bx6a6qVwQLJAipiSoqF8MtwRQkXAlcVX8IXymeIFC5pn+m?=
 =?us-ascii?Q?ENugCI9IC+gZn/pXtCNoNm3L3456SItfkSQa7epv+5ubsogY5+f7DnMF9FxS?=
 =?us-ascii?Q?bUgF2LNym4l/DP114gF6Bidx4aaCcCb0h1uZ9cEfGynucBQWmhQQhbPY/sSW?=
 =?us-ascii?Q?5fdEai9JL0zy3rI4g8BsCbPoNjrLw+lJZ8E4o+Zwj8j7ZX2zvb7xx62qVz1U?=
 =?us-ascii?Q?x+pBr2khiT0lPXnhSn3E6OlFC8YKckzgQnxXntQBpDLLUF0r1FyLhoRwgqoj?=
 =?us-ascii?Q?QHmtAnzHk9oXWjzD5dUkRUItWsiDuWr1l2E2QTQD0WLc1eieIuhWyqPmLwJS?=
 =?us-ascii?Q?ffv2wCywqZcGcVeID85EitishjVKhXcbl/kGkMTURM4wY9aSIMxjjxV8UbOu?=
 =?us-ascii?Q?rjAKz4PqYiuoyXwT3x4Ywe1opXpj6xbI5S5LTjHXYmuzkHLcnkY2YrRBD6tq?=
 =?us-ascii?Q?0ZB2sTfkmLegR+BbuxryT4XK+ihlzHhFjJ2ospIMBmzlvAlTtUDqIC4q0o0o?=
 =?us-ascii?Q?rPH2KFLrxU/T5mDav3cRcXNymCobEzDifkJhL69Tr0Yf4z9Dpy7hNfZY2vRU?=
 =?us-ascii?Q?NTqAJN9nIE3oZEd7Fxet+EMalJawAc8hcmZoFj1V4l34EsyZwHjYDR88y/pc?=
 =?us-ascii?Q?b4prVBGBpFZj5PBYG821wSphMoWxB1Afxg66sMq5qLM9aQXWMFimrB78CBxW?=
 =?us-ascii?Q?14f0iFtL7luNGmNZVdYDVRm/lqTlVROM648/0pljWoYfRwj0QwdifIWOeAfT?=
 =?us-ascii?Q?yA74DX1++w1B+2sorGCrrgmXS9h8eq6MorgWWiUx//SIIiDlTn26353zBPck?=
 =?us-ascii?Q?LAAEqTLdZcKWqfA3N439rPo08BWULyuzc1ILTsFtEQbFOYY0hhqTiIPfsmRk?=
 =?us-ascii?Q?srdjCfSv/Z/5rbntsj6z/ksDBbipcfr/Z7agCELN3Wp6NmvHHt1iamtVCnvQ?=
 =?us-ascii?Q?ECwnSf1G14Z8Bq+b8fe91fea/Z35+JsWvmuGLrkJZyFZeUhDszONuT36xaLi?=
 =?us-ascii?Q?1LVkQFH44ptoEffX0juxj+J5wUs2jyMA4EvAhwycLYIAKKRJjN/bk72kRovq?=
 =?us-ascii?Q?UrjuRirjX6MTm4QXwcJDJRvWTSnp54qnqMrWnfERrTtvFCuSUHdrymS+54VF?=
 =?us-ascii?Q?D6HwfxZfAQ9imqnEjbgDTSOnE8Y9rwMlxq9zkgeazDMF9co5Otfsji/ur8Xj?=
 =?us-ascii?Q?XACFMEsN32TQT93kWpcDs9xTOR39bC/2kspf6DW2MMMTb1jFW8PhgGGY6/b/?=
 =?us-ascii?Q?0AJKkJANioP5IeNOfddeGbyJIFYwljmm6SRBcgpVZ67Ip5ZssQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uRFgQ3KNoW25gjowMWUxiaM5wCYjH2fZjLDxmqdBJGmpRGcIJDaRV8qFwV8M?=
 =?us-ascii?Q?DhetmN3dlOtcU66ixXu7zMgt+MRE4z/oNogyn/LJLUHIEq+H7UIWQpH8jeDw?=
 =?us-ascii?Q?hmjeTh+etOn0X1zZ+Pz3U8dwFYVbF7ajcEWpH+1c7ucM7P83nxZt4Yn9aCCv?=
 =?us-ascii?Q?4InwIwEzoHPoqDUksjJGEo71XvYNmp1xs4vidjvbHaGlTsr7Pat4K3g//B4u?=
 =?us-ascii?Q?lFV0imN1UebAkDAB4byBC+dqQfWgASxaTG+WmpQK83M1zn3dUvfRhf6GVKgS?=
 =?us-ascii?Q?b1RCVYDmq1ItnxsyKaprUJ/i8XCK8q/ozMYUdoX5PISbBdGPr2iVDVlpqUlc?=
 =?us-ascii?Q?HcG4lTiMZxxKHY2Uxwe3UoWyiIJAcDCGwIPZNY97iY7mTr6I1iCLhg12W3D3?=
 =?us-ascii?Q?bS8PWc9Kw7ZbJAIN5eEJxu0EoX2fUL0Qbg3oqBnGVUzgxQsHf18pi/4JuM61?=
 =?us-ascii?Q?pgsJ7YSgP0CdhCanlbjKdEgi3ZQfeNs8OEKtwY4UgbdytwKnN5SgUXcKv8P+?=
 =?us-ascii?Q?WdogP7h2AUoDMyBExOvG57NR9GtQT8kuLNKwKEtjNiiPZBTUwmW2AkQ6tOKt?=
 =?us-ascii?Q?G/TfWZio90VVTcpaFTSH6+HW61Bn/xlglhwwsHNjOWt33fDJqQ5ekKNIMm+F?=
 =?us-ascii?Q?g13C+rqOmeDGRgJ8kuzWsoYYYj5+fJTD99sno2qGimEWbKmMTvIdUnkskXij?=
 =?us-ascii?Q?OJ1PKccIyXeV6diTjgvPWfubAmsbWUAkMMlSr/BBaxFRPR506D5NKcWQoCK/?=
 =?us-ascii?Q?rYWwkmD484AdbFxkylldzjzCbbpxpFjw4M9dyDRlRyNAl0XVkNO7LOd/Z8ai?=
 =?us-ascii?Q?lpwnsVj7XXcD9kvDr5lRIilb3JiwY4Sb10ovYWoRz1+eh+iJLTGNc6iJpD/K?=
 =?us-ascii?Q?Zx92lEqcp2x5LiMSdYMNM1OLqMET832gc117+0GbF+ShDqLsUdWSwoMgfbCv?=
 =?us-ascii?Q?z0oB/X1KpW2hU2B7YFTq+SjkpWC/1+OMgH64AjPSosdF8Ldm0NN15nZOI6wM?=
 =?us-ascii?Q?AGHrKpEg7Ssh+OU54HFfUdhug9lne7xyCDBMx+L/N6tU2Er9+3rlSSURPkeh?=
 =?us-ascii?Q?eFi3M3hBT6xv1jppzMJ8/1+5bLqahR2hf0SqPlxRuNDucYRDzpm0+3MUfuPg?=
 =?us-ascii?Q?dAjGhCPoxXCr0KEWNRrOa7nHP5wCN0ySnc9mOjAUn3nSuyVRTAGlWZ0uvJ5n?=
 =?us-ascii?Q?jnhrPDlua8s/YHcQGihS/K6EFf7EWOJ22KbCG0vwLl1MenX5JcLKMtsqkef6?=
 =?us-ascii?Q?zhUfnZWoU5iDYi0pRHwpRJS8gEa38/iZNxjQjBYbucXHZ7xq5lj+uKMRyc69?=
 =?us-ascii?Q?OZKL/yuW/ZARbQEi+Nkf+hzra3ysp57H6F+ISaFel1+jGh2SYlYxCR4/iFVl?=
 =?us-ascii?Q?B0W76BLdH6jfH4BGQ4dOrS/kyCVzcgwQnwepO3828UfJTROZMhbWFSetbvGw?=
 =?us-ascii?Q?XWdrZDeNJvAhUxQVr8U1nsw0DopHWLrAwaqc1QRFqf8OdczV+IATx2KsrZT1?=
 =?us-ascii?Q?h6QhQ6QoWUNWSJ5fLXz/ioZPtj6gjrepSN0TMCit5m29S8F2IjhQUXH7ejnS?=
 =?us-ascii?Q?DhXTJeI3CEYNrruYNlDwK3LoKJiMuHcSqdWNe/rg?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b663ccc3-822a-4ba5-bd1d-08dc94c86da7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 03:39:33.3485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a+kikboOf76svMWYwpwsZxGBYP0QwkGqJCBe++bpXKY2GlT7mOQwom5ws5SocU5dxkGO3TWqr6oyyJDZxmexOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5148
X-OriginatorOrg: intel.com

> From: Joao Martins <joao.m.martins@oracle.com>
> Sent: Saturday, June 22, 2024 2:43 AM
>=20
> This series survives 1700 migrations of guests with applications doing RD=
MA
> (which is roughly 3-days spent migration back and forth between hosts).
> Additionally like the series in [1] I used a set of changes/tool to
> exercise some dirty tracking tests but with real iommu drivers. Finally
> tested >=3D64G IOMMU page sizes using this tool but with device-dax memor=
y
> (to generate >=3D64G contiguous RAM) to tackle the case of patch 9 when
> iova_bitmap_set() gets called with enourmous page sizes that surprasse or
> is equal to the maximum pin set of 64G.
>=20
> Comments, review as usual appreciated.
>=20
> 	Joao

for the series:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
