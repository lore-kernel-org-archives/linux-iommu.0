Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01022C21C5
	for <iommu@lists.linux.dev>; Fri,  8 May 2026 03:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778209961; cv=fail; b=Ouc45mnwilVt2urbhN6hs+1TcDyW6jV7czEoRuhhU2veb2pDMZUyponMu155rBllL++erucgiXnheMiPSy6WT8psGeu/6tb3pRgV4siGyO6p/NcHQb9dMMxKZJDy4oG3V13s1WdUFXa7u84tK2TPNAI3pSIIru5ThjHo5spBN2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778209961; c=relaxed/simple;
	bh=hjOCnBpltSQcUfRjwzHVBemOg7tB8e9yB16b16ebQzU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f1sEgLYYNZABjrPp9XXK5N80viK1OR18Kn2LXv6TJnQs+z0Df8ER1cPQiALxCUawoHcOBTNiyj9ebXzyF/CYh5hqQywXaG96GTjvzZ1nBcBwkIOT002hKxmPH6mOB2w+H2ego54D7AvALtN1tDvmY7i19c5y3ZpmmY4Gy7JHPL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lYmV7GrQ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lYmV7GrQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778209960; x=1809745960;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hjOCnBpltSQcUfRjwzHVBemOg7tB8e9yB16b16ebQzU=;
  b=lYmV7GrQKaegk1I7MMD5PJtIxQ6cjGpBmRo0nDsek6nLDzZtuEIZz9DJ
   lIIEfRAps3xrST2D9xMSNh+VW9ZLnCepJS5EZo1RyamVP/TumKPKFZNai
   Z/YP1Io+gz3/8MP9WahwSpuWfjW95AGBTC2DE+4onq6ovcpNqfxPbLUA0
   YUjTgmF1ot3LJIMlcPnYuaNHLohzyVyvleGCNlUrM3FhtG94kWwwvXlcx
   k1kCIpjDGoXF6z9ySG4wxp+LryZyizlK3ReDpUvbe9viyu9yBzxTuImK1
   +nV3yjztgrWrG2tc9m1nQdPXU5pim37u4gXMg0WoMrL/c4MtQadmOB68v
   Q==;
X-CSE-ConnectionGUID: 4pQ9+pM6SqicOr7j4J0iXw==
X-CSE-MsgGUID: Y4/yEwb4TlGlQ31gaA9s8Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11779"; a="79027523"
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="79027523"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 20:12:39 -0700
X-CSE-ConnectionGUID: xmnoT2eJTX+QI+1V+FqoSA==
X-CSE-MsgGUID: 6YQ35XoSTTmT2xJqnN9krA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,222,1770624000"; 
   d="scan'208";a="232112859"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 20:12:35 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 20:12:35 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 20:12:35 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.66) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 20:12:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XbMDN7p0PzxFLBwimQOmGPy5nfSx9O8w3ndrcalUWTPeKx6Xrlcb+L8S8IjGkpyoqOhw3rmsjB0KFDi6D9YJ66psd1VmOBw9PvIvsIIj8TYbhx+k3TsmHstHr7dSik7244CDZnGYJnjbtXO4NR60uilWsh+ZAmvhu8LETgUq6/dYUGKJZ7ifMPsoRALSLs/f/n88YrwvmdN7ycVoqxdlmNhexW+hJun8GCKOF2m3xlXs+InXQ6FinvKpRExIcGZOHjOzc2xo6e4rpuoG7B7BqoDpasoepI4hYSF5ulqByO4n1Dth8P2WKzc9ysIc75UEcwKvu1EBOgYtrUXF78Kqfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjOCnBpltSQcUfRjwzHVBemOg7tB8e9yB16b16ebQzU=;
 b=fnjUKQGfbk06cFXldJqQ63J/Q5BajKjA5WAxjh3zDBIuSbpXXzAASM6ci+nVxdEn09OJi34eRRMtpbHnVMbyt9uoFqBEugWhaPiZ08rZHjJogfM8Ippc74Oq9UZTDz17Aqd5DLu7JSddo2mR2VlOvYPsjhKXykhNiWhPEzwjdq95+nsaLqxLpyOwoU5kqoNpc2Lthr7Niok2RNlHc1bVxQcSULHXrJBYVZNfzW5TL1qN9bR2uKBTJHpB2qqlEcmVdsXRiL50/8QrLNuu00x1mtMMZWLJtnZ8qpnO9gpML18K8bFMO1E9/u7adq8THc3sz6jd0TMEtybaCZhHyIe8VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BL3PR11MB6316.namprd11.prod.outlook.com (2603:10b6:208:3b3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Fri, 8 May
 2026 03:12:30 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9891.017; Fri, 8 May 2026
 03:12:30 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Aneesh Kumar K.V <aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Alexey Kardashevskiy
	<aik@amd.com>, Bjorn Helgaas <helgaas@kernel.org>, Dan Williams
	<dan.j.williams@intel.com>, Joerg Roedel <joro@8bytes.org>, Jonathan Cameron
	<jic23@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Steven Price <steven.price@arm.com>, Suzuki K Poulose
	<Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH v4 4/4] iommufd/vdevice: add TSM guest request ioctl
Thread-Topic: [PATCH v4 4/4] iommufd/vdevice: add TSM guest request ioctl
Thread-Index: AQHc1gyeP6Te99Bs4UylXz3smwD02LXy8cGAgAFy4YCAAAoCAIAPFcjQ
Date: Fri, 8 May 2026 03:12:30 +0000
Message-ID: <BN9PR11MB5276EA9139255EE49B56AD718C3D2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260427061005.901854-1-aneesh.kumar@kernel.org>
 <20260427061005.901854-5-aneesh.kumar@kernel.org>
 <20260427140539.GE740385@ziepe.ca> <yq5acxzj1dwu.fsf@kernel.org>
 <20260428124854.GA849557@ziepe.ca>
In-Reply-To: <20260428124854.GA849557@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BL3PR11MB6316:EE_
x-ms-office365-filtering-correlation-id: c9ffed08-4aca-4123-c793-08deacafa426
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|3023799003|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: /61Rzbl5KTsPKEJv3SYvfzpCVjxqLapBChdzEfCs2TMjKyjdFwx9Z8eI8OijzfFyLQzbqqYoIh13rLHJunTtPtbhhTpdQq81OBdJr2jgUYPb5hWZ5m2c70QmgxMaQmwXNaYkMvEImfWWBG9etBMT33+mq0PjDtJEgsSngRhseirZy7VBoAXJ+PbjC+VknY0nCl1QzqNKnTCd5xWurt3Doc3OgSR+KKUPdAv/t5+DSh7+hbi6W1c9ObL+0nAIVXriqsaqfNZsR33Xy2WdleMy3luPyyfd+HZXZdo/DnMyC6KqDqblvlfnXlJWH5CI0/hOBo1jbO1LeiJ2HI8baWUNZbV5mf4rJqY3rQLkJmAoAeJqiX/dQ3Q6mMEu4sJimlLm2CS9hZci9AtMzNAp2Ec2UBvAJx1kZzoaYdr7rIzNVTkW734x1xJ7PGuxZDCUpNPLuNnoojRZOgHk+QFid1boiwUjkcweDUPL4+cl6wuM9/tuznIsWQqFGqQ2dLV1sIo8jUicr4ALxycbz8ZGFmQ6kbJe3HU05I9ts7xwSnJ5yzcy4ADPeoprESffyBYNpUNdmz29KoFzuSVlWXmQtUlFkmqnCoyBv87EqskJFo0ghk86+fWhXCSixRrmWb/iQdmAe1c/00bWaMfxY20CaSNWe3MUfHqtkenur0ZkakH7GDog8fk1ODV24BBhaAjSgE+ItPH0Srvzy4PSdzZs1qJAg4NgNbQ4dgkTzDJwjWfehSTt9inScLt5NoK+OfIEUp/U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(3023799003)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/jF5sbDsbkLbTB149WQnJM0Pq/IhTi+6SP3QKdPvqp4a6r2yZ/XrLHPs247e?=
 =?us-ascii?Q?s6n3by9LSFMP+siQ1glYYAER/RVv2PcK28ljH0wgN4En2wsx2AJU2fITIS5l?=
 =?us-ascii?Q?2gx4qtPT2YSzRX7ln9DGos1SwY4+WZLHnzTH40EPz4uPfFWdfvW/cfYmj32P?=
 =?us-ascii?Q?dWWJa3vWz/BsbMRI0MDbzIuLJgl85OS0bNbPKCjw75GaquMm8NuFcsdqVdHN?=
 =?us-ascii?Q?7NxzsBhKCkVQgoefTvJBMK/XjWDY/ppwmw7LI8S7bNK4UJJQng3vhIcI547U?=
 =?us-ascii?Q?QP2150U3h3+f9x18XS/wdPOiWxh97VhrsmC767dApGYXSQQmE9slUQPk9psN?=
 =?us-ascii?Q?phjp//u4o0ACl0726LCQ+2uTdSyZtB0l3AcjeyG4Z+IbTO3br2C1s17DLy9W?=
 =?us-ascii?Q?Dbl1Qilk8H9dZYMSj2RZbiyyZx0MFjgTZkRRUfKXAoY7W3ohE6qiDPINlifj?=
 =?us-ascii?Q?7dfA+dZQGkTdpxv0nW1fGtKXzWruL+JC7zIzdnT32piX3kvNrDleCoVzn2kv?=
 =?us-ascii?Q?9wK/J5Tkuxn66Fa+fGhf9fwpOb/wh/FKqTEv59D8CAjCZHRkzAIhTsx+95Pt?=
 =?us-ascii?Q?srxP9OtFFhfizLJ+B2RGrbjsYM4rvs6e1EYpR8OX5R+dda8DomewRPURDGuK?=
 =?us-ascii?Q?vV2kO5oajWWU00W45CnKFz16goPEoGhsCSe3lnbajAf/P0eBGPJpcHaPRCZx?=
 =?us-ascii?Q?/VBFt2SetFv/hyA4j4Ra0+pA0uGe4TL2+orzoTn+p+O8VzwWGQ90xZpUCJDZ?=
 =?us-ascii?Q?SgdKalax/i2DwsaWknvxAHPfxaISkn4fqoZiKluzp05E4eF4uPM6YKMELSsc?=
 =?us-ascii?Q?4BdNLizAP3TICSX0Wdp/1RYKRtfnXcF6C21n7SoFCxjqx1s+0Sx9KoN1qK8e?=
 =?us-ascii?Q?86EOtpDX7OPTARAz5fYAHUb9eGWtdc66iezDGc5KxIRjk7T9C+NgmMwzSP+h?=
 =?us-ascii?Q?3Ydsg9SqsOEUkz7Nm9t6F4Fm8zeX45km9Aeodw1KXS69UrshX8BtplajkhGZ?=
 =?us-ascii?Q?WKzebbsMDcfLPgw1YCMOumiWMVyYQPHNIFMItttYfYAOea3pOmDFvsWfkuQH?=
 =?us-ascii?Q?Q1Ety3Z4bCC46ka9mtifq6pjkLR4trObXBbHhLCpkdpI9bKHgc5tlXiZOs9m?=
 =?us-ascii?Q?XLRW4pNl5gv4feOcqnuPSVHAolgIOHhtgsbMoOco2dBf/G//eDcCSTVcXm6V?=
 =?us-ascii?Q?OPteNLkt5L+nLDE9NgwkCqSzC3tSYq7ZhT3Hb2rzkdyEe0UQYSJFhCKagPsw?=
 =?us-ascii?Q?YM7FDL7n3jZDC6PhP7JoE+5abDYg+j5HZSBNLQ2ZZxjmWAmQ4Q6UXm8noB8g?=
 =?us-ascii?Q?d6TzJGspdCD7j+pvNXKzERw1n1+Z6h/m0dTEGNgCZCx3FmuhWUaPcMu9FoNR?=
 =?us-ascii?Q?KKtnW0n7BG2JVoeIxGOZ9dMEhGD11ch4tLsRN6pe4/kafzftQT84f1sZaMu7?=
 =?us-ascii?Q?kNDtnwUmlttmONCGEm+RPp9dzkASYH0KNslNoG9FE2MlsijBLXb/PE2MJ8DZ?=
 =?us-ascii?Q?LG9fBSd0ChX8M37ci0iEsQYPNzAA21hiB3VyhXsnEBmIXhvpb7qE8GI4muba?=
 =?us-ascii?Q?MhEspkbM6/mYmoPUxkUIGPzkdnYP96BWYTiShNs7p6SvlIN41gGs/ezBZZly?=
 =?us-ascii?Q?PggCCUq+yrSiUp9F2+OXzFs15J+zMDOl/hAY0A0VM+DKvokvgQMqOgZg1xtt?=
 =?us-ascii?Q?JEwqtCXpqsm+hVcGMtzaWup45pc3tIxWyIZqjLc06Q2h489kMGPBQWRUMRl0?=
 =?us-ascii?Q?2y7Bi04r+A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Nc9CM/0bppyp/iMn1nUH3xsBSbRBkP8u1kY8QBGM5WXvIW/Nqp7pH65qYW03tI0coTKy3I/vcQlXVZpdT00hNDb+d1hxtzSTMFISFx2i7QhJUBPk7mslNPmjC4DQKACtuG0MDDzKkzoHYpWbA/BJXGlUIv0vZ9foRzoX29OeBUg9wm3NXrppfsk5DcaWFaRtuh2m7Unfj9WCjTfR7ff3/BJEXm4jcDJU4DavX5wgVNXvkAwBKVTk7+7Z4Kqux6Iy9qUeWhCqQOseAGYHkd6kBMHkL9rBr/FaeuWEzM717+BXw2zVOPTsJMPCsElumP4NNvxWtx51zW9B5+UoRk3dwA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9ffed08-4aca-4123-c793-08deacafa426
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2026 03:12:30.5895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2C8pIyGeu1u9o+OZLjoZYM2DcWNa/92ueAs39vB8pzGLJl0FcSBYOmhDVCBU13dDvTyFf5IcN7sQIg0e8A0IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6316
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Tuesday, April 28, 2026 8:49 PM
>=20
> On Tue, Apr 28, 2026 at 05:43:05PM +0530, Aneesh Kumar K.V wrote:
> > Jason Gunthorpe <jgg@ziepe.ca> writes:
> >
> > > On Mon, Apr 27, 2026 at 11:40:05AM +0530, Aneesh Kumar K.V (Arm)
> wrote:
> > >> +/**
> > >> + * struct iommu_vdevice_tsm_guest_request -
> ioctl(IOMMU_VDEVICE_TSM_GUEST_REQUEST)
> > >> + * @size: sizeof(struct iommu_vdevice_tsm_guest_request)
> > >> + * @vdevice_id: vDevice ID the guest request is for
> > >> + * @scope: Bus-specific scope classification for the guest request
> > >> + * @req_len: Size in bytes of the input payload at @req_uptr
> > >> + * @resp_len: Size in bytes of the output buffer at @resp_uptr
> > >> + * @__reserved: Must be 0
> > >> + * @req_uptr: Userspace pointer to the guest-provided request
> payload
> > >> + * @resp_uptr: Userspace pointer to the guest response buffer
> > >> + *
> > >> + * Forward a guest request to the TSM bound vDevice. This is intend=
ed
> for
> > >> + * guest TSM/TDISP message transport where the host kernel only
> marshals
> > >> + * bytes between userspace and the TSM implementation.
> > >> + *
> > >> + * The meaning and valid values of @scope are defined by the TSM
> backend for
> > >> + * the device bus type.
> > >
> > > If you want to do this then you have to also provide a way to discove=
r
> > > what the TSM backend is so userspace can form the correct numbers.
> > >
> >
> > These guest-driven requests end up in the correct VMM backend, which
> > should already be aware of the scope value to use. In the case of ARM
> > CCA, the RHI calls include a device ID (vdev_id), which the VMM can use
> > to determine the appropriate scope value.
>=20
> That seems kind of indirect, we technically support multiple TSMs in
> the kernel, how does it all get reconciled?
>=20
> Passing overlapping numbers here without any way to tell them apart is
> not a good uapi design.
>=20

Agree. another thing is, as I replied to last version, what about userspace
providing a wrong scope value then what would be the consequence...
