Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A0C34E74D
	for <iommu@lists.linux.dev>; Thu,  7 May 2026 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778140155; cv=fail; b=onVZY6NaPeDsNTC4FYJdlJ7UOE789RWMUlttklZuU5Xt7V0M/Yxx2oF/lJqmCwlsfCk2dJpuQFCZdDZf1oz4snA4FTIsv3WlpU6VKtfOvKQ/ePEn7NlDkGwknmAqgEJeYnj5tJ5rijl+2MF+xMXf8nNeRRrDsoVHZWKbb6BmPUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778140155; c=relaxed/simple;
	bh=wu7KPFeyBjT+g6A3Cxkxt5dxii1nvrYOg/4eY8wT5jY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qC2+hwWOW+fwsKFNYk18iRix7Y7HdP8FSK+diNPdNrtp20UMt/jzjtQ5yFMFrpIM6IL+fe0DhGjNren44ZEcrITNRZOQCUSjwkeDNfv1BXf63jNZq8PTp/uFI0dL1hvTyG2FDjFbhMzS2mFfyn4ETaQ25ZxFOjv/T7rSlhSSQHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R97rfJV0; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R97rfJV0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778140154; x=1809676154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wu7KPFeyBjT+g6A3Cxkxt5dxii1nvrYOg/4eY8wT5jY=;
  b=R97rfJV0H+r38iCX2iK87d/wjVu9YQ9d9w4JjaKT0alWRTGenAxSG78h
   pEstViLShZITBkaLkST08Mkiapzz0uliicha+S/+aGUVHuh0zS4/Ul4Tf
   Y8fGIOdPPlvjMtpbazxm4d/CPKBFcL25fpPAUctLYyGB7NTemDZLk6ZQF
   qwa9FnnpiuQXUYBdw34TThZtWcTSEMMME7J7wBt6pnRhXXIKcV6C9tgpe
   cF5bB1Q+Odl0vBevdn2DrxlKs4rcmTpCiaQkN1kNWLFOc5gA6Y5OtD4Qh
   t6lBhXFBPowdJAyZncLO+fARUXq67e6gfFR2ebE9+xQU3IWCaRTY/IYlB
   g==;
X-CSE-ConnectionGUID: VevOw5AxRg6UZFhgIpc/rQ==
X-CSE-MsgGUID: fRFQ1wYsSkazJmkHpImjlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="101758630"
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="101758630"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 00:49:13 -0700
X-CSE-ConnectionGUID: jKPqt3cmSwiJc0ms2TSbUw==
X-CSE-MsgGUID: EB+WHf44RKK+OV7+xL5r8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,221,1770624000"; 
   d="scan'208";a="233301664"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2026 00:49:13 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 00:49:12 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 7 May 2026 00:49:12 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.37) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 7 May 2026 00:49:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KhVAUykpJOJ6i+Y1nhx6XRu1Q5qsq/q2gDu05+hRF/bX9PrZanbV1uXW6sL4CwxVOCj/JfO8HYHwpwk28ZGM6UIblOcrgeCXSs8FxUJS91KP1lYA2BOt6rp1sPLhwkXUmmbxX8wVi7yj+IDvS77Bvn5cRt4n6nKUzAIuaF64royryM6ruj4QSBhBFbaAvHD+tX6rSgXn/wUJfeWHiUqNztU3F2yuDkOsROZ43SEx/yjKLk159KQ1vRiX+Vf7Sjo4L3fX9q5Kt2xUfWZ46z1artofgfMUJ+N2z625c/5lciraRs0fVhVV4mX1zho+zNYlvv8Ji9CKS7IWVt7XG+kjVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wu7KPFeyBjT+g6A3Cxkxt5dxii1nvrYOg/4eY8wT5jY=;
 b=heFLX9QG0wspQuf9QUHBD9F4UWK6pSv8wUxDZbIFoX0xyUEJdHexS3U9JXO96O17/24ZQfS9STiiOIHmwSz4lqXCcmqGA8V6msb3aIDgU5+EJgwnvUghLMqrR7XaS9hP8K3JHCeVHRf3J1PUAc23IM5jyd9bHlUj6YLWbEXh+cvzUgCXUtj4ac5givq0zJ1HvYQ5kf3nMaC9L2pBYGYMae9ccxHiisHVvb6Zy73L9NpphcjqAr+AMGMbB0iy81oZTQBJl6XYb+ZQ97cxXApIE8Idlh82nvnQGIRlrGcnnpqAFgtY9pXu95u51gMb3I02YamvVlJFsY8TEfHBmVuCpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS4PPFA58A7783B.namprd11.prod.outlook.com (2603:10b6:f:fc02::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 07:49:05 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9891.017; Thu, 7 May 2026
 07:49:05 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>
Subject: RE: [PATCH rc v8 8/8] iommu: Warn on premature unblock during DMA
 aliased sibling reset
Thread-Topic: [PATCH rc v8 8/8] iommu: Warn on premature unblock during DMA
 aliased sibling reset
Thread-Index: AQHc1FEdnAZNec70eEyfEb4a1xI987YCQz1w
Date: Thu, 7 May 2026 07:49:04 +0000
Message-ID: <BN9PR11MB527657D2816CFA125D3E4FE88C3C2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1777074513.git.nicolinc@nvidia.com>
 <ea7199ab155d4d0d8c9afbaa23023690d7d8d4a7.1777074513.git.nicolinc@nvidia.com>
In-Reply-To: <ea7199ab155d4d0d8c9afbaa23023690d7d8d4a7.1777074513.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS4PPFA58A7783B:EE_
x-ms-office365-filtering-correlation-id: 0a9c4e60-8908-4fce-a0f7-08deac0d1ce8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: OeC9vKpTZKFXrOeE1IqEQg21SEnR4SlafcGtB56AeUlCoiUAbUJnF4SSchEzG8f+YZ9QSsYKPXDdCUiEsPAgCWKKN0EJnepioSkci+2Rn3y1K+R6gMb1rcFI3ieHRXTGS/02JN7HTsSEGd2B31TQ+da3mwIOdTvHsM5H8MysQAc81kDZKTHUp/L53p3WZwCOp+v9r/69shZR1PkU6XdOwMX8OKogovC+4c8HghW1cdsL73z/E7olDUHS7rWkZ+pT3o/1R3/AYAY8XnJvMWT4OaXP3UlauAtIIczOOji9wA5rsqZuKhc07rU80ZK5cv3NyowvD4awl4q9f0Kw7Zyf9DPXJ1gR0efimgdoM62C7beJRYT3OerHC17NgxuCbx5ZzlYTZdaWInpMjNUoa4laYUqBSb5etek/rAjPOUDsjcp8tAXw4vpGzIRu/I+jvSPLYPNRYstsvFBT97qEL2wLRrnocOoXbjiHPVL8sScoYSHSJrodDIF/KdZ25gcmZkTfwduWSdbBvq8xsa93Mg1RGrTBefSWWl8rQPegOU6i4y7e71OEKnIyUExW42QY2EKXqV9qV+31EUM4Q3NyT3mOfsWFnMSXVtrgILNLejd5k+5GJGEzABI5OxIWWx/tlK2i7OYLp7E7l7eoKCY4xyIe29lp34x/H/jGYDLa5/cs6MkhxXqNifXpR/H22sCTTF5+fnRT3KkMDFHw9Dcq8zjyDBg0NL+Oon4OwZBA79Z5LOB3SHyc/dqwFF/hBi4mq7G6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mdczpb4VpGE8UDTyf6mY/7XxZa3YRyq+XJMG0yHWHFJdFgiPMhLHqu7VKRbi?=
 =?us-ascii?Q?CMCvZzIU0r+DwsVUSe8cUg7X8dVdjeW//Na1Gz/RUcMZBpX5sujoE7HL3NJT?=
 =?us-ascii?Q?BPEAE922H2ZyTJA9SWErFjBJl6nqvyNbz4pwlIShVARV4U3rv/3q6yUmtOJG?=
 =?us-ascii?Q?OHjPilWp3n6Q4J0jCef+ApgWIm/sN8Z4peZvLNrPJhPCDwVbw37gnbixEQQc?=
 =?us-ascii?Q?3y6D/FJu5Wiu2xYG6Pn0g/lgg8DyAHbs4JQ3J9UnTEBlHe9EwIe4Vh4ZUl92?=
 =?us-ascii?Q?wV2fR7GcqP5pAhtj0lvKmJ6ASLFiIldQzSZkFsboLoeUMR5qrUW2Wb0pn5cI?=
 =?us-ascii?Q?CkoN0Qm+6g0fO/Pzz2CXGcFfta0zRf/Cx4y64YtXPZ3tIwXIWzbm3a4Aij24?=
 =?us-ascii?Q?OllF9+6Il4rVbnbp2VmbBGNj7SO8ONoxv4J3Xw5laje4sSmb//HhKU3MnR4c?=
 =?us-ascii?Q?bY6DYV+yWh6kNISn980Tb/DYolLEvZJQ4wySdjD86J8zOIg06KN7OXL2SVk/?=
 =?us-ascii?Q?cRZQXPaPDIaYIdS5YZvTT3jFAIqa0EwqB+RPemrwx70Or2vzjUULwWEnB14g?=
 =?us-ascii?Q?HAugzKfHXlQEarz+Ndqr8G5eDwcSzDPLBGP6jH++ivzKIoLOzz3W4NqqR9lj?=
 =?us-ascii?Q?4yCRS3P0glPzRuVxClRRokhk7CQy4Yrov3COj2wZwmclw9AXDM2jR2IBj3HI?=
 =?us-ascii?Q?XmRMeTS6WSjdTtuqEb8LuT5T6b51qRXu6EtHnFCiIOpxbQqVT9cVrNYmu+Eu?=
 =?us-ascii?Q?FfifCVKx8Xoggncx1GbzOo3wrGoAPDGQd6jz0vOKhtHReU92lNLUAV4pP35y?=
 =?us-ascii?Q?PZQHpw8wKjLruCcm4CL8uqD/we+k1FosNuxlvtExPc7uDRe+T1Cu82tykzOa?=
 =?us-ascii?Q?4rhceo5FL4k9VUGwjfMPiODdlEYkRZm2KnYJ2GqoD7Mx/vX3byntQC3dtmzf?=
 =?us-ascii?Q?fY3/JqDLWa8o8jS5u++eZqn/ZdCGpl/rxmKaPpWn/UYkTRDBHNibR/xnHvBD?=
 =?us-ascii?Q?q8d0tzq5n+/wAMBqCSkQcLiK6HghQDh2e8w3A/r6Gkc+Y0MsImzyWDjlKigc?=
 =?us-ascii?Q?09NJX2fFe/ciuojHV9TdIz2uXD3t27yKLpk/5sxfwMF4yM6tIn5ajfKgT1CI?=
 =?us-ascii?Q?wX8Nx6Bp6wa+9gbr/hkvvfkDqq5l0dF6JZlnOLK46uNt9A0D9838qVeBeVb4?=
 =?us-ascii?Q?fiWaQKbyTPtJWdoeuPtGBqa4HpRp6x2GhgxGbx5xb9g7XvB5nX09sPFiNK9U?=
 =?us-ascii?Q?Zr4oYlZCOB7wH5obqTXHM70y5fJbB7QTqh47rVUqzS3kU08e/xd32On2d979?=
 =?us-ascii?Q?0/9+C8EhrvOSxnL+s2xvbLrYs2F31Dwp/V7v5xPJUk6mHWUPVHKkZgH7pb7B?=
 =?us-ascii?Q?rEaHG/VAcs8z60Ow7C3jRbNLwJFZBt9cue48QdxH4qFm4KiVMxOq4Jhdn9HR?=
 =?us-ascii?Q?7R17KAq4Bocf6t+9TOKShdn6ZdIZrNyvxxlKfIq5GD7ltAKJ1ayl8mHpAWTp?=
 =?us-ascii?Q?MVxlWC5ZmJShKJravaNBxpr4eQ8+lmXUfjEhVEex6L1BnokFc+KQ0OhnhdGy?=
 =?us-ascii?Q?+qGZhUdIrEl3Y5Yy1aZyGHizWnbgI2kB+Wz5yWOvd7cMLC+r+MO6/r/zKEIv?=
 =?us-ascii?Q?zD5qjzfKJ70j/Zm/s3OYKIxiTbY14tDYgh5dnoX0PX/TJRrmAPOXX/zf1qn9?=
 =?us-ascii?Q?oDWCyOoWl8RgjzPo98MVxJsSMizUxVCw+I6TpPc5K2dFt9oPXud69IZUoLpd?=
 =?us-ascii?Q?fDxT8XIReA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UyxlEJGDfKET7e7JHcn2kwonNgPTHKBtA2zeaQ0K9bJjZ6SCiiCK89GG12WY9Z36bbOhA4RK8EQd5TZlW2jaS4hnGanOmOtJvFUqOWNaG1ybpRjtZc15WP0wLnai/W7KLGQbb5nRVq2ldXVxPkSFSOtiZM4TRS6/XXsQ5nypexndfZEJbEvkZ4aYeT0YFYfOQrQljdzYi03oIhEQ4ajT1yZ+Z0/DvotJrrB4LZp4BScxJdKOEMdupUPtMlhrgNbXWIHQBT7VODtJNdC7y8jknuUIVOoOJvjRy+d9Uj2C1S/BvT4VAPr5tILi/qSmHPshYrrnIkO/kdXNLZMy7bBBmQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9c4e60-8908-4fce-a0f7-08deac0d1ce8
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2026 07:49:05.2213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yr+eZ6iF/GFNjpqvQaw2DU3iYs/Is+x8vjdXDVocs5WoyJ6jzxa0236f47Kg+k3u/TLaePA8O564CSSrqiwxog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA58A7783B
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Saturday, April 25, 2026 9:15 AM
>=20
> When two aliased siblings are in the same iommu_group, they might share
> the
> same RID. The reset functions don't support this case, though it is uncle=
ar
> whether there is a real case of having an ATS capable device on a PCI/PCI=
-X
> bus.
>=20
> Theoretically, however, if two aliased devices are resetting concurrently=
,
> one might be unblocked prematurely in the middle of the reset by the othe=
r
> sibling who completes the reset first.
>=20
> This isn't a regression from this series but it's better to spit a warnin=
g,
> so we can know if such use case is common enough for us to make
> subsequent
> patches for its coverage.
>=20
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
