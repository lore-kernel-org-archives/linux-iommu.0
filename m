Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942052F7F02;
	Mon, 28 Sep 2026 03:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790566870; cv=fail; b=DkcJzQe9s0V8z6/4T2BTbLgMgP79HQqm6fihnfHIoW/h1dQSBo6vhlgNQQDFvhjYLCzWkeRkBmP28NWOLcJm2kZAcPwVCOzLB8fRzb/go7hnAHwcUP7Eh2kvA91YNKaoppEnycZE6vlqUXSkGVtc3HgjPatfxbhCUNM8cxONZi4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790566870; c=relaxed/simple;
	bh=9MsIuCTjoC8S1KwjPWlI9pYG4l8LXAGw8C9d8vr7j7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HcqLixzrq34pVCgqgk4mMx/TWB03BStw6cbHLwg+nLtBoWWkbMK0XXWUaXXuGkkG40zHmi3yWgVlMiwDhJUn0Tov5WhlwG4Mv4pzv9FdhiMaFqA4riuiQz1WIUs1rk3Ue3Zyj+8ET3OYes1H6LBene4BDunxmC6Z0pfw7zXupX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h3yVzLz8; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3yVzLz8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790566868; x=1822102868;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9MsIuCTjoC8S1KwjPWlI9pYG4l8LXAGw8C9d8vr7j7g=;
  b=h3yVzLz8Nlb+8KdhBgzqclvgBBQV/+7xTLZGzEOyNBCuI9cbRf1FgFEg
   DdMEXIjU8PQEUV8U6dLwZS0l7AymsUJsQUo6/jfpzFsdijAIU10/HvvEp
   viqTKBK3W6EGll4No8REzZWG6vFdcqVFBjUCNSgFBtpr8zXYEZiJhh6rS
   owvDXCCeiQqssstCtw35QIhudvbnIydOts+IeFQ8PQ/jyeKxNW/9EQid4
   grK9gkGlopK8S8+M2epXMu2JQiUbXAlh1LMuNiepxRxmL90vGh6/1MIPG
   7m/LtI7z9wtfFZZ9X7ebNf48SnVuHSXbm2OLeAFxYsPR/Ye3PnIbHXXWB
   Q==;
X-CSE-ConnectionGUID: cl04zRErR4Cg4O9guX1azQ==
X-CSE-MsgGUID: CQDH4uqGQUS5YHNcVqkVJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90023727"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="90023727"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:41:07 -0700
X-CSE-ConnectionGUID: e24bDrhXTcmZuiygFFHljQ==
X-CSE-MsgGUID: hQkvX4/JQOKcRW0xfHBhug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="279657759"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:41:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 20:41:07 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 27 Sep 2026 20:41:07 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.15) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 20:41:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fBGymkD0aAuHI1OovYYwuCfiKicpBipWS+bxOoN1aezZ0KUCRIoeOXjcrxueGCZrs/zDU+EyxeLCvJ2xBze2EOtPb0R7JMwntJG6iPX+DPxFFaoXQtx6DOVYf1gxQLQsCLgvKEzN5NGA6gGzmPGj4l9qUxc8oYKDmREwFPsDAo1Lps+bGtYq3S6ipZIv4XsM/dQhHCLA9fvj19w8t06kNd9+a5oo4KiTjxoZ+erjxTPtu6bHrDFqt+3V471pvJ8THekZx7AN/KYbh9paRJZ2WAkL0atqQK7nqkjtM03qYnzB1zvJ27Tcwss8CkSVIwKWC44D4PaOlZll6xZF3qNFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9MsIuCTjoC8S1KwjPWlI9pYG4l8LXAGw8C9d8vr7j7g=;
 b=SsTAbhjTHNv0N60VcuiAYWtOSwzxX7w66EE0Tqj3vjOzzmd4lqtjTg/44XSGQO+mApRQCBQOmo5aTBB9gw+4UmEoox3I69QqWgO62GtybEjoOfmCEymrtr8kzTseT49LiOconbEfX/86Jaqxy81qCfW0BRCIhmAo3wYh8zRYJYHPtTLhJSfrCewC795EJTeP5H0wJPPJTRj/cLEnyARuOvHKsQnHUAXwXICPTTFQlTggP9yk5sbgGdQpoyENlfj2KeT6lNP4s2PEwnr/k3yHoRq/fp3YV+M1PMHGY8QKFmgeiU0y0jANNToJYrk3BUB8irN5FmE8WC4pIOocWovcSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by PH8PR11MB9880.namprd11.prod.outlook.com (2603:10b6:510:3c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:41:00 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:41:00 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Aneesh Kumar K.V <aneesh.kumar@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Steven Price <steven.price@arm.com>, Suzuki K Poulose
	<Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU creation
 for confidential guests and guest TSM requests
Thread-Topic: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU creation
 for confidential guests and guest TSM requests
Thread-Index: AQHdRq07BOB130WWqEurUaVXxg4wX7bdXiywgAGkk4CABGTTkA==
Date: Mon, 28 Sep 2026 03:41:00 +0000
Message-ID: <CO1PR11MB48350079E4B431ABAA358ADA8C8D2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <CO1PR11MB48358E3116CC6CF34E6437658C812@CO1PR11MB4835.namprd11.prod.outlook.com>
 <yq5a33uxka2g.fsf@kernel.org>
In-Reply-To: <yq5a33uxka2g.fsf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|PH8PR11MB9880:EE_
x-ms-office365-filtering-correlation-id: 87440cd6-7607-4146-42bf-08df1d12506d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|5023799004|11063799006|3023799007|6133799003|18002099003|22082099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info: W301/2oASIhB4Uv7Eh+RFxMqi8zY7QurfQJIMyHPuEUENZV2mirPDgy+9QvH4tG+ePlkCVWK8nT9iLsBXtsPe926SLJIQcKLSb02EWJeWbR4x+/+7JQwvR0kyl2vFWZnxgzQ9jxdExfrElicc01SNB48KPX4nWDD7zxrew7ZVicD3SCJAnW71VNKojIwoHOCTrtV1z9PTnPGE281rHtyOJRX/6L3jUCjC0+f7xU1i5sqVh2x+VYuO1TdvaQkizTccjJJzvaAIxkX7/H6z+At8gj3dYrBxSUackXr5YxUJrkHzstva1uN1INFqFjNajy305jsf0/UiON3Xfu6OPtikFZihRsfb3jmlWeSsXahF0OjcPW0YH8E/d6QTBAlWZAkqVa5ObsFrEFN20XgWxAbV8r+jsQOsZ6aeMP0wcJW92Kyc95AGvq/4cO0JUFgG1yRIvxgZomgqgG6DPa47fPGuZeCUGhUGrzkOleXAX+sIv/bK35s5B7/Ba92TlPNaSTZZL04WomP+U6PjqNhVQQ5pCmvmENDPplEGko8NML7JSp9mMo0aNWdj6Asroq9XPEbCAoHaKuKaKU9brBXVmiaVpOQAFEeLK7XPiHuKdMFQ0X/jogK4mpG1Dr0sILp1xjXJKaRTLcruiahIF7LZfPF+1qsjmDOiQdz8CR29EZhHxmVuBoLq059YGfIqf/jWNJFdy9xFBllfGVhCRqbQ61iFBN3pbagLEPHsGwESnoh04Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(5023799004)(11063799006)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dflEy7etKDgfbGMj2EkBHAvxTAdrC5Jcla4B/a5Q3lciDsxe7jYiAKJcInkZ?=
 =?us-ascii?Q?fQSzRJM+AAR5yQzhngKnZw/Rm0OMMwG7qxM85pZgR9pI+nMwYL4G3rgJMr0a?=
 =?us-ascii?Q?J4QVnWrF9zIbSCXAlaeg6pYL5HY0B5iLY4pdDYpEbbt2L4YeVRfyIXCkfvUd?=
 =?us-ascii?Q?l47cTI7pE36qGFU54uldAHooHhB4fKtOot922n0pOHoRKzLYFm00oUT2MGOB?=
 =?us-ascii?Q?PcNdO1ZXOJIfMeSZvvxSlqZ6auEVc5zYYNFbtF+2GmKfpplDz4W1SLCRnuXn?=
 =?us-ascii?Q?dtZp84DTi50OaEyqzJkzTKUpd+RtwGwsn/4+z7IdWPuORjTXyVqYiFSAW21Y?=
 =?us-ascii?Q?rdkT3LL6+fBunySbt7JJ/U9MakR/bTpylxJqPBaj7dSEAIHfwtcV9CSYCCQ5?=
 =?us-ascii?Q?ODf+2zAJPAr+jY4MxuMbQ2Hjc3K50xn1QZhrFrqzqIPXF4D+Tf3WF2+finuz?=
 =?us-ascii?Q?Os557dyjAe9h3yDs+KUTqYqa+HLCad/QcuLrslmziWp70vNnzlZTwfVJSKCu?=
 =?us-ascii?Q?MT0pxeMOwmIxq56hMEm/8yCvO3p37iVC0yohvkdnDe2Ks3hcqls6mOUPOT6f?=
 =?us-ascii?Q?1ZQmjWRM8JsTy843Z7kvcFs0mVGwuEN6KR4GOsmAmsHHymmnfYYr2fiSRJPh?=
 =?us-ascii?Q?09/qmZOqNSHQagxYk/taSfLQvMyCUkirFpEbF9m0FiO/9tkfaEdoqIFCBcyk?=
 =?us-ascii?Q?YwsdP2RWcKUKfuamDIM3YqkuwhbGjoDf9vwEw5bjL/VxJw+YamXlVVEXs5z1?=
 =?us-ascii?Q?Rlo0HKBDjdiEWU19FDnpoYEUmVUIwi5F7i9EAlIvfbJhNuB/bDfQDlgyQezv?=
 =?us-ascii?Q?lk3dUD/7rB59/uIznJSTHhxaWK2Fp4foM4SXI4XNhJk64l8qBL/haEWlFfWz?=
 =?us-ascii?Q?mUfRE/BZaBZXvA9ADuWIvudt93rFyTIKS4foq8NL9lnI2L80pJ7kDhbZMp5n?=
 =?us-ascii?Q?U430OyhoxiQkMM3kXeCXq4gF1X9IY/b9zksuX+Y5Tvvelr7VYcoDYz+y1U8k?=
 =?us-ascii?Q?izxlVDkzRVg6xlZBNjz0kVYmcFoFTV0Nb4ui9bVqbCly4K91eeTmkOK/xsTp?=
 =?us-ascii?Q?jCbIyTaOtf0JiAcFkpsaiDdvefH6Uvie1zTHXdYXU5LcjSDORKxzhESN90bU?=
 =?us-ascii?Q?UQxxnWCcZc/p9vXdbpe8r7C/rPuxEnXEIgt/qZJRXT2udwnDO+aWCBH8ud/b?=
 =?us-ascii?Q?NmpPWIGGodh+E4FlgyWSvAGGl2d3ELkaMgJiYB2urxkFG3azSWJcKgzNZb0i?=
 =?us-ascii?Q?aWkb6hU0VZRHgkDKN8z2PtFhxmxxj9Pi4dODKJjEYUTufx5axPn69EniTQNa?=
 =?us-ascii?Q?p/jWnHBPnrNQYmOR9Cajl3ZVPGreZ3lzDEEZ8Z0k1vH0wyEjAxJZ2I+SKwnC?=
 =?us-ascii?Q?vcZNY2z0eGgMg141eo4RC6BlvhlVCBDcso6qNQXLiICYcIoDNb5SZoFuSzho?=
 =?us-ascii?Q?rLxu5P9cKApt13K7NNpNQ+rM9xAA+BS/yKhP4ZvnPSEF0Jtfs6QTC6wFuwMj?=
 =?us-ascii?Q?jl/jNeXjtEtOPQRq60/y50XV6vntlBhuPH95uqRQK8zc3qBe/5eLFtuspDX3?=
 =?us-ascii?Q?TKaJYExhwa6AbvLinZBy31IQMeXt2ZG8vkEPjxbUlRp8nxryuY6gjIxSXa6w?=
 =?us-ascii?Q?4LIT7h5Y0lREDf14LEED2p7ogLJQHtp9vhnLap8NzbgoY1Ztapl/atuoBihp?=
 =?us-ascii?Q?KDaBT9jtd7XQJSorCRVux1M30qGToTqImmyXU1r7IIFKvckZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: gf0C+6RFfd71Wi7/oGZFOoHpvU+Z3RerWv9lNRkUq91IOVPbDz1M17pdKOcdGv8Nr8kv4LNS/EacV6lcy/nxxD3a2Ws6Hugw2zhuGRhtKkAoQ7wJnufguLwqJUXBFb1kkILMgII9ScZMo96g6+WDAIYT65tAzhoOdKl8Tp/aBoI+vYIhItRmWVQtc5MGGIngst6ecay/dhp9gAW/ZnUGoI04su9QgugH6oaRER2+io5OsgVgUNCN9qUBqGxsoF8GmAK0/uKAKFCVvzpBWX9cNsihSFnbbBy/j6KMINml1Jw8oA77Gck4npwXXFAQQnqFF2DdoyHvjEPSGYagHKFwew==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87440cd6-7607-4146-42bf-08df1d12506d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 03:41:00.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: chfTI9dGFyRjrDaWhWOa6w7ndURQCZeIGr4BVXvmZCdkbq3BSahBqL7EaPjZDK7ciEdVZaHVM2OyZQu9aRdYZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9880
X-OriginatorOrg: intel.com

> From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Sent: Friday, September 25, 2026 4:30 PM
>=20
> "Tian, Kevin" <kevin.tian@intel.com> writes:
>=20
> >> From: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> >> Sent: Thursday, September 17, 2026 10:02 PM
> >>
> >> This series adds the IOMMUFD and PCI/TSM infrastructure required for
> device
> >> assignment. It introduces an IOMMUFD-owned vIOMMU provider registry
> and
> >> the
> >> IOMMU_VDEVICE_TSM_REQ ioctl.
> >>
> >> The series adds a vIOMMU provider abstraction that allows a subsystem
> >> other than the physical IOMMU driver to implement a vIOMMU type. It
> groups
> >> the vIOMMU operations with their module owner and private data, and
> makes
> >> that implementation discoverable during vIOMMU allocation.
> >>
> >> External providers are selected by exact vIOMMU type. When no provider
> >> matches, vIOMMU creation falls back to the physical IOMMU driver. Once=
 a
> >> provider matches, its result is authoritative and failures do not trig=
ger
> >> fallback.
> >>
> >
> > I wonder whether this abstraction is necessary.
> >
> > The underlying IOMMU driver still needs to understand this vIOMMU type
> > to check vendor-specific compatibility and provide the relevant hardwar=
e
> > parameters.
> >
>=20
> There is an iommu_ops callback, viommu_get_params, that can be used to
> check compatibility and return hardware parameters.

iommu_ops is provided by the IOMMU driver, which implies the
related knowledge is kept in the IOMMU driver.

>=20
> > There may also be further vendor-specific interactions between
> > the IOMMU and TSM drivers.
> >
>=20
> This is an important point. Can you identify those interactions so we
> can determine whether an iommu_ops callback is the right abstraction?

will do. Hopefully they are all about the TSM driver calling some
IOMMU driver helpers, then would be less a concern to abstract.

>=20
> > In that case, the abstraction risks becoming
> > little more than a connection between two vendor-specific drivers, whil=
e
> > making it harder to maintain a clear scope for its operations.
> >
> > Would it be simpler to provide helper APIs and let the IOMMU driver use
> > its own interface to delegate vIOMMU operations to the TSM driver?
> >
>=20
> Does this mean that the vIOMMU would be created by iommufd, with
> the TSM driver registering callbacks that iommufd invokes for
> TSM-related operations?
>=20

I originally considered to have the TSM driver register callbacks to
the IOMMU driver. No change to IOMMUFD. But Jason's idea on
connecting it directly via tsm_ops is cleaner.
