Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1171714B5
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 06:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750485; cv=fail; b=Pzss4oUnyBWhMoD+jE92IcMZC4oNMp/1w04PZA61GkdfuicTxnQtsFgcR0GOI6w7JXasEybbBgZkppW8HmjXxC3LmDfWU8HDJqnxtgn+bl/8n4b3NeCG7SwAmNJOvblWTW0LDlLyIOUYvaS7gwCSmS3ty/GLV/yDeG3kUnfxtZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750485; c=relaxed/simple;
	bh=y+l6OD9ADfCJkdFxEMxjdOaiTzv+0e0b9JMYCCTxZGY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hAVPQqex2jYqzUh+QvF4rsYAMq8Ay+kX7w+v5RtRp6dtz9gS3fQLmsWVo4S70tMe4b4K+sH+lpteAvrqYPui3+hXix4WQFit9AYeb3m+Ob4VIN5/yZ8zNDK+2vZuqRCLfQJX/q/oJ2cIWnmm4EdDDiUC7fNiqop1GOKZqJXRma0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ve174n6i; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ve174n6i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729750484; x=1761286484;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=y+l6OD9ADfCJkdFxEMxjdOaiTzv+0e0b9JMYCCTxZGY=;
  b=Ve174n6iUyON5EsffzGW6I9tBTkSeKxM/vTbm32EeP15tj5OI2n2/LSA
   +lzP/TElnmqgRzV2v13PBpDpS/8hRC+Vve20aFhHJQ/urSGx+ADeBGE+/
   kJIphIzBk1kNEq4C8NO02AlbE/C86hqvGVd3ElMq5k/GGAcipawrJZiZP
   YkGIFODXjSQbIK5VJf8G3Rzr+V4+S25MDyhDl1dfCWUiYitV+UraSv4YT
   wDtH7z7pvF7yDJyeJA1WTCAiDuE346Gd3pBW3v/DMFUaUYU6AFNGQAEt3
   uh6wNDmQ1obuiCwmG3m7EfXCpuvtV0HoVH9yup4KllPw1o2EIBqEj4Dqm
   A==;
X-CSE-ConnectionGUID: PugGzsoKRGSNDzvRDxjaDg==
X-CSE-MsgGUID: KMnwJZxESBmFNxNz4VYApg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="51905251"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="51905251"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 23:14:43 -0700
X-CSE-ConnectionGUID: 8SWqpgj8Sdiru2OyC4/R5A==
X-CSE-MsgGUID: xW9E6knmTouFPGb9v5y5xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,228,1725346800"; 
   d="scan'208";a="80495789"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2024 23:14:42 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Oct 2024 23:14:41 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 23 Oct 2024 23:14:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 23 Oct 2024 23:14:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DsjHcKad1thZmzSMKhUXVBpMr8QPK/b8zWwSNXiPE/OCVrpaRfnDZdj3qgdV39ZalZEOraA7+o8b6pdHsn8svooAYUjHwEJlQHUnE2FMMD2B+y/wznRlqeeDykiJvR+vLx2aUiwJGc+vZZOP6GI6YgCksf8rAv5DOyoDynqJ66Yy4iGinOi8FvK82O2Vmgc79woeKmLkLqa9+h7dzPuCPV0xDyYWBlGSwG7sghpstPgtW7kJSneqdoX5owmjo+AJOpZ7BUHdbHoxrYTt4CYMlDJeki2SQhZl+IF/53j1AcFLFXMoRzCuRmfomJICDz0Q0xdQaJ8QeOKqoAuV/V/oXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVtL5iWwGeNDyu3LwAasgU5VkXvJHr1AMUDYortIVrk=;
 b=g+2a4rNCk5wfBxIi3+a/D9u/rpkwQl3tdOhQxdPfzDm4Ges8HIvPWKOryo7kVFAZrSJFIFWCtCNcDqnL4GrDHd8L0DAITJOE6EArFDBVdoqhT4iNKX7LBEbVbs4wpCy/F9xA5b7M/WdL0g4bO1aNQPAVXhP0ku4JBDjZ/f+DjFvfJxVIirLGkEUEH6gbBSx1hkvgVhGnYdDp1n8PrGjOv+2kGi/NEULdwtgwtXE88g2+CKV0+ZNQcfNOnatD32J3OAesVYTbmG4o13963I3WmmDnSHSdJgZ4/v+9yWFK0xRm1Nsn0j/paHJ1b5FNTHqVuTfrXkSmW9iMMALRCMy+pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5002.namprd11.prod.outlook.com (2603:10b6:806:fb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Thu, 24 Oct
 2024 06:14:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8093.018; Thu, 24 Oct 2024
 06:14:39 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Steve Sistare <steven.sistare@oracle.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH V5 5/9] iommufd: folio subroutines
Thread-Topic: [PATCH V5 5/9] iommufd: folio subroutines
Thread-Index: AQHbJMWJ2Ao8SRUSfkq0gkDLwqJNfLKT7ZDwgABg7ICAAR/BQA==
Date: Thu, 24 Oct 2024 06:14:39 +0000
Message-ID: <BN9PR11MB52766BD07A48AB7EB683CE938C4E2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <1729630838-24586-1-git-send-email-steven.sistare@oracle.com>
 <1729630838-24586-6-git-send-email-steven.sistare@oracle.com>
 <BN9PR11MB52763A8B95B982399E62EE108C4D2@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20241023130355.GD864191@nvidia.com>
In-Reply-To: <20241023130355.GD864191@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5002:EE_
x-ms-office365-filtering-correlation-id: 8c2c61f8-4c7c-4060-ad45-08dcf3f32450
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?WGWK7NF0OetO5BHCFZuolHfo95vfRzBmMv7wPaop1ow/gBWXnmw2nAj451VK?=
 =?us-ascii?Q?+zS4+a4f4ZteJhzktrbeLVsXN7bxKGrbCZuKcgHq63FKGzPeaV6RdtYTvEZL?=
 =?us-ascii?Q?j5hyezGHYPgdoNZmSmmG+z3DfbuF2S4S4+cW13w6FOR7Hx4GB46f97fQzC2l?=
 =?us-ascii?Q?moBkVUkmelmJXgNQIzBDQ0eFbKitRuT4r4iRtzmtvigrhnTXZorg01OxEfQ9?=
 =?us-ascii?Q?LrA+i4AYf2Y+rYGCovbpIbbEGBMHg5+V1gdqg29umc5V6Zf+TFms65YO1BaP?=
 =?us-ascii?Q?NjJ8+r8yJBv+aMzi+mZRuTpqz50yMJPy5QYsrgdTYhqZZZ0NKuSOeRPobayi?=
 =?us-ascii?Q?0V0s4/r6inRjkNYdQ81UjmTJF8dyIyLmArKHMffYLBaU4CD1Dsg3DosN5cDB?=
 =?us-ascii?Q?XP+pZmTlzEzLDLHERdKr3sZn7EKEDPPIYom3W5ppHzY6EDcyxRlvDgbHJBFu?=
 =?us-ascii?Q?qZ0F7vCAjZzbk4KCFfN6wDubwt6NFG4QJNH1HY2X64ypjA4CuqX+yCIA8UgS?=
 =?us-ascii?Q?sg6dO45HBdJ69QZ1k47hblyJa6ZMscA80goF11wGCZknccgqwjc4Ouny1ISI?=
 =?us-ascii?Q?ze1WytokgCTa3rFODsd0aNmdO+I9Gxr0kSWh0S/q8vSa3oxrSt5eieTVbEHp?=
 =?us-ascii?Q?A5sDUokQ0f4QOC/Q/RUORbHg0+g25I5X4qs5Oq1ByqvTvg7O//ZtFw4186vd?=
 =?us-ascii?Q?4IwFJENJ2W9nfZVyA64h/Mc65PL06+AH2d8jvtCTXIpWlJ3ppnfolo3jc4Yv?=
 =?us-ascii?Q?XdqsS6N3N1cq43byhqbky8DDlOCfmgqLBjqTAvyc0BZKTe572dwfwiPPbsu+?=
 =?us-ascii?Q?t+FMuBvDb9crrzKW12JGeFkcvVRWuTIveLXO2QL+AvkXTLhHlz4i8pgxosKp?=
 =?us-ascii?Q?/WjPmoX/zDEarm/zFl1Sqw/JbL2Rks9TQw9bbeullaWSARFkUhXH7FaVj2Yh?=
 =?us-ascii?Q?r3bLCwjYyRNBBIIT7A6laYrSmCfjlAM0HXnjZhl0i9MuAYJZO+rE9Nz4kVyX?=
 =?us-ascii?Q?zYJWjGCFv+ub7pcJ98mweP3Ktobbj6nd1Mulhp0AGCETKV8Zn1u16Rb09bmU?=
 =?us-ascii?Q?ymPKNawDpW/PEDxrxs7tCJMRU1Trb95xgb5ifdQVdHFc8xkSxoFttCHCRptB?=
 =?us-ascii?Q?56HvuBpJuEpm7YPiV8HrMthdd/JVe4g604AgyUoe20h84BFJdJpqbTrrQfDP?=
 =?us-ascii?Q?1UaN2siwNzk2YOBfifk48x9RBVoQ5vnYvWcLFiV+rOCqeWEacQR1WJZtyByx?=
 =?us-ascii?Q?82q/xqCJAcaQ5zHCW93U/jzYeU7g3vi1TfIGSUrpK4rkQXfomTQp7njgWaDp?=
 =?us-ascii?Q?KOxzowemf2nVCQ7xx6qpTy9lwmRweqjb5c6irhlXDol74AVV1hRHxiFze2j7?=
 =?us-ascii?Q?Bhve2FM=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J5VVqDolA/3cMkwyXw+MEHWrtMEKEHTBw1iuw1NgAknGF5Sl9WiAISNFCDx1?=
 =?us-ascii?Q?b9wpNSjqGrJmny1RgXjOPZxbJa50XebDnDmZed7zcH9TtkUWv4gi+UH1mxjq?=
 =?us-ascii?Q?oz8vcYKzh4AM3TV81MbaHTxTS7e3PII6RKNyh2EKfsCBuxAMK+4ouEfRSPia?=
 =?us-ascii?Q?uRdl3f7XBndUxR9VtvrILq1N2Lwku72YhdLVDM59Rr1yBRLRFwmvIAR7oUFr?=
 =?us-ascii?Q?UnfJDfgPTge2xEV4woLgGqef0ugyXFXnG5IOyV3NuZGFx2ztrIMA1b5535hA?=
 =?us-ascii?Q?WLRoXNdSp15Y1KqA94FUyzOUsKFg2h0AIovMpK9/p9J1L/aNRHBu6huin0Yy?=
 =?us-ascii?Q?xObKxPN76cIOfoIFeXJ1LF9XGYyEkXG89jgGgWevBJWSBI80SUP8kKT2WG0v?=
 =?us-ascii?Q?IcaYdj4Sbl3xphesH3F6ne69m8ZpzEsho6T5tOn1VhMVeqfgTy1WOrvz/qeT?=
 =?us-ascii?Q?TkYqbrV2vs351TD1GEGQ1GYqqKXCT08SiI1quyXEeOimkCz72GkUGhcLFdKi?=
 =?us-ascii?Q?ntkA+lBJcmYZ1IGAB5ik7UyWebXJCNzt3Rq/AqF14uDHc+qyn0pB2NhsLFEW?=
 =?us-ascii?Q?EKEjLke1uU1HD9GWNqlHB6QeYj+/HJTqAosx3Ed/sC9/kWmnyJgVxpTuXwL5?=
 =?us-ascii?Q?F3u/XQMvYCcWniXTRtCL3jZ8VOT/mxPKDzhzc+AqXgYNazTPJg3p4OU/8nYP?=
 =?us-ascii?Q?8fOHaoTKDfIA3lhB089r6S7Ezys/Wi3X/4XEi3saUuUXQ/GQHAr7ogGdrRzn?=
 =?us-ascii?Q?GGR87NxXbYL3WKe0vZzguHT3PrG6kvOE2kkFOx+93Voss4i78tnTZjB1/wGk?=
 =?us-ascii?Q?40rUvMipHkWkuWW3SEHSsz+tPzJQfov9PeSfYOQY3cDkJA+tAx23v+YNqs5N?=
 =?us-ascii?Q?1MBned8zCBjORggFTuSPdLx+YX9DXNcmRoAy+IW9U9cqRyXTaeFfr0dc3CfY?=
 =?us-ascii?Q?0Lnp6rVGJNDlRxjuVRkVQkDgptP1t2+RL+vzmsUDYIg8/ht0w1OeuQNewTB4?=
 =?us-ascii?Q?LS+ThW0cLdcRkWdsK1XVZRlrFVFhCidUnpNniuowDC3bIYjFHSRUmCCPIDuW?=
 =?us-ascii?Q?2RoBX2YOqEiGOzFFy9ZJK5ZYCmknk6vus3cocKZVpc4DOp735/XO7OZ6EYJw?=
 =?us-ascii?Q?v0oLOJGQNGZPm14PGywETYgi6DaKbws4F1NlaEOEgtlYRvD4ntMBY2XjonNa?=
 =?us-ascii?Q?TiiQqqys6KjVhOnLIwIavDPS3WPtU3G829YK/7brGuf+YxSiYp9OKw7VA6jJ?=
 =?us-ascii?Q?d8aXiW04cDpo7TEd2pkMEWxkE2WbNCD7sySA8RDP5KW++DDoFfHr1Bu3nWq1?=
 =?us-ascii?Q?GvY3Yqh9oov4ENP7FKmeoBQJQ6hkP5WGIlmsMQOxrf2PLcvXCQ6Wa+zCEMXZ?=
 =?us-ascii?Q?EbWvg1tuqer7Ettb8I4MVaK/Qf7sCt62icP7/NpeeIOPPQIhB2HclMuzUE03?=
 =?us-ascii?Q?+/Vb0/kkA7y6qL2elfr1uQc4vDR10gv4F3QhNub/CZ16MUhvx0xbL3f1Ar7K?=
 =?us-ascii?Q?u6DS0ZjfDOi3SMHHy8LEKbda9nBUmN0oFAwMcdZ3iPdN7MgJEKtSBLfDe4cq?=
 =?us-ascii?Q?cy18oe9PcTec3lVVsv9XKg4R1uUEx2ws0b9GqHMz?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2c61f8-4c7c-4060-ad45-08dcf3f32450
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Oct 2024 06:14:39.1268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RBK0Jthp1CX+hN8i3HFP896HzD14Qtp4fh13636vb5OoIcmOE+zM2Ww4r7PCP5fj+MzzNASvgGHE7MuIlXxNEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5002
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, October 23, 2024 9:04 PM
>=20
> On Wed, Oct 23, 2024 at 07:21:05AM +0000, Tian, Kevin wrote:
> > > From: Steve Sistare <steven.sistare@oracle.com>
> > > Sent: Wednesday, October 23, 2024 5:01 AM
> > >
> > > +static int batch_from_folios(struct pfn_batch *batch, struct folio
> ***folios_p,
> > > +			     unsigned long *offset_p, unsigned long npages)
> > > +{
> > > +	int rc =3D 0;
> > > +	struct folio **folios =3D *folios_p;
> > > +	unsigned long offset =3D *offset_p;
> > > +
> > > +	while (npages) {
> > > +		struct folio *folio =3D *folios;
> > > +		unsigned long nr =3D folio_nr_pages(folio) - offset;
> > > +		unsigned long pfn =3D page_to_pfn(folio_page(folio, offset));
> > > +
> > > +		nr =3D min(nr, npages);
> > > +		npages -=3D nr;
> > > +
> > > +		if (!batch_add_pfn_num(batch, pfn, nr))
> > > +			break;
> > > +		if (nr > 1) {
> > > +			rc =3D folio_add_pins(folio, nr - 1);
> > > +			if (rc) {
> > > +				batch_remove_pfn_num(batch, nr);
> > > +				goto out;
> > > +			}
> > > +		}
> >
> > forgot to ask one thing here. Could you add a comment here why
> > additional pins is required only when batching more than 1 page?
>=20
> Something like:
>=20
>  The unpin path during unmap can unpin slices of a single folio, and
>  broadly does not keep track of where the folio boundaries were. Since
>  it treats everything as a single page transform the refcount on the
>  folio from a per-folio ref to a per-page ref. This makes the unmap
>  path uniform regardless of how the memory was pinned.
>=20

this is much clearer. Thanks!
