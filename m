Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4935176ACB
	for <iommu@lists.linux.dev>; Fri,  9 Aug 2024 08:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723191812; cv=fail; b=oX09qYyO1F+wmlR3e+WdPAYa1LIk4BGm1bULeoqFJZXEgQTcqTSW+bmGGoMZ99Fj2J4zFz7Mydj5D6CWxy/iUweB6DeUmKJMBHkFEILNhRqrJzvOHerPb7DNM9L80O7G/I717X5rDl1XQJ9Dan33x0ZW5DROKZFDDyqkqQZsCug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723191812; c=relaxed/simple;
	bh=CVz6BIl6Yn8tsubHLNkjphv+5s0X/nIvA4/1SDYknpU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HfYKQ+mJFlxD7VHGkLcU3VXBKsFUfQocbAh2w2NbaamMteuo8v2kKmWDdWsrvP+BMtBTacGTotG+P9ScfoGuhO9TDxkQnLo5Z50Tjf0imwoCiU+i6u3Y8GdcL7wk1m/iO5BgmLTyN31aQ3BHeBGEl0oO2yRzPLhMoJua1fZttlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBj7qSvX; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBj7qSvX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723191811; x=1754727811;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CVz6BIl6Yn8tsubHLNkjphv+5s0X/nIvA4/1SDYknpU=;
  b=BBj7qSvXJMesLAXtL13XKVDyUsBrjmlVGCwO49hmXZRp/ulMIjih9DjZ
   x3oxhe1LfzlBjJte/RPkhkxNMK+SLl/zWHQ/pvyAZeCKN/7fjr563VArF
   EFaBVn6KEZ2jpnTu9jY0s4hWONLnUrGm7YPA//JG8Jfm+Fq6OLlxsL2GH
   qv6IrQy+InstY6GoH89m4TrBgrFmV6uwuHzIO0Mn1Ph4GJqXUVAnZD5nM
   MPfueM2b5dILkt2ZlQs/4RndM+qIfZAV1cW6TQIU/tr+fdWxqEReDDUTc
   ezQnMiz+vnyTD1TSUbfKttrq9gMhMfElICC3jB8IsJM6iwyrmqSigCYuj
   Q==;
X-CSE-ConnectionGUID: YoYzs/L+RTKVG1RCzH5arA==
X-CSE-MsgGUID: 7i+suhfTQmCZxlmo7h4UYA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="31982369"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="31982369"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:23:30 -0700
X-CSE-ConnectionGUID: t8ZoYhC6Sm216Mu0AkO5Lg==
X-CSE-MsgGUID: LIQNJCoSRgiWAq35qO9QgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57407107"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Aug 2024 01:23:30 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 01:23:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 9 Aug 2024 01:23:29 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 9 Aug 2024 01:23:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 01:23:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BZzFJA3c7BiZ0YfspaHnt8zFKuLLqnfRlNW2R3dQnV5ErVpXUyz1C1Rr/sV7vCW8M57TOVnrYKun2pMLuR7kZ5OfBuiZ+IWaL6BJ4vi1EYtHlJQlbFncUfGzEqjcg86PV8W9VflD+oWW1Epg9bW0uoTxqHdoHBEwnxUZNlN8HKcgIP5ZO5oxyUWdmSJtumsHew5XelnUTelNbg40Y1BKNZcT4TjiW0BUy1RJjMWMwZbvUNVhBpN4W1GNhKr1MkwXKH6tcylzrSuq6c+qv1YDoSDkvBsVKtXjvh1Vvkmsj7RaXfiQiMF2vDpJIR8kSMriL3zjpyTufUAFlHf+wc3OZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CVz6BIl6Yn8tsubHLNkjphv+5s0X/nIvA4/1SDYknpU=;
 b=Gtv4z6jKDV+TpHwhgSPcl2fhdPD0/Nez0Ax9KoxhmhItV5yZt+isJhi3lkXaKuBLMdIn5ZMKDZoiYr0f09xKdHnkq4t5AfmOPUSx5+jskMor3Iza5IqxV+HbKklDgGCVikwgeGDq5Ktu1Fq9UI2La8XDyCg/k7ma6rv7/tu8PdMIKnZ2MDr6Zqt+hyQzP7xp1wNriNEbymfhJIpe7XKHKpBs57o2yqHa0uj18gO9h2mfz8vp3A6TAVjMYuWsqyNa5aVHeVcIpls+8sWqx1d31fdUEpl+5U9FVB9KaX27M1MZ2arx/LVCcQ9v2tMpg0JZzAV0qw6pBECcibkIEELK+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7333.namprd11.prod.outlook.com (2603:10b6:8:13e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.29; Fri, 9 Aug
 2024 08:23:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%3]) with mapi id 15.20.7828.023; Fri, 9 Aug 2024
 08:23:26 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH v4 2/7] iommu/vt-d: Remove identity mappings from
 si_domain
Thread-Topic: [PATCH v4 2/7] iommu/vt-d: Remove identity mappings from
 si_domain
Thread-Index: AQHa6iEiuavlhCzdik6rHu51F2W3qrIelnVQ
Date: Fri, 9 Aug 2024 08:23:26 +0000
Message-ID: <BN9PR11MB527686792C84D6F7916096008CBA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240809055431.36513-1-baolu.lu@linux.intel.com>
 <20240809055431.36513-3-baolu.lu@linux.intel.com>
In-Reply-To: <20240809055431.36513-3-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7333:EE_
x-ms-office365-filtering-correlation-id: f8830092-e152-416a-fde0-08dcb84c8ad1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?N4/tmKX+j0uxsED8CNgEnJEYMgN/nPGZKhCgcPQ4yingAYab7ZgwGYDnSsUV?=
 =?us-ascii?Q?1XLW2kRu4JA4S2g2sVfhPGTKgke7EbuDIosS3eo7mdKgLu6c8rRaogOUcDrz?=
 =?us-ascii?Q?Zs8T5kSTVK0iUOEzq4X3dbJxhYPM/vUiGk4BUd1Lp3GWZ23H/ry1eDjN02Mv?=
 =?us-ascii?Q?YQgz475EdFz4EL+vvHsxN4FLwq+0NZTY8/cwg6lFdBUs5Gwd6lGLoBhFInmX?=
 =?us-ascii?Q?hToyFxFNPNSTzPGxsBY6CAW4FhO2t46bsSa56nqETFx3xQ/m/qIBiPn7ZCo7?=
 =?us-ascii?Q?Wc6QNYhAnqZma2OunbgFOx4lzjRkrtL94cjibWJ3IMwtHIpeOWaJVqBFOBDZ?=
 =?us-ascii?Q?xy+dUkbav08XHUVwxn2uw+mJ6Z85t8cUdIyAETuRt83D9bLJhGRiogiJcCNU?=
 =?us-ascii?Q?vT6Z7VpRBJbwAYu4o6pqpNO3GsIK154DLRRUYfP/HJNrVc+m7AJyLsii4UPR?=
 =?us-ascii?Q?cNqSL1X1irfuImg3mkAHWadaOuCR3WOjU/Eq9Rz118RetavO4vf1slNOvp12?=
 =?us-ascii?Q?IfVZZvja8+6ww64jiZ34Z3IzVLszbBmqWR6BelX2SDTCf4l73VF4rGceHnIx?=
 =?us-ascii?Q?b0chHD8zq65LhQhZHTvj8Tp4mmpz7TCYLJqodjOCxTdBnHVwo9TUi2YbouUV?=
 =?us-ascii?Q?ViMpkAbUfk3YaRSux+wQoxtYB/xn7ZzmBD5Hsv7Wpu4MJD72H4GAzkFpTYGY?=
 =?us-ascii?Q?nX8+zdo1411F1/KJ2KZCdEQK+Y5PMqvw7qDzJ7Q0yddikTh/P562Obgh+/zl?=
 =?us-ascii?Q?7lTvmAs6Strl7XTTHokrOK7PmIcbgD5YGNhLWtksXO5bCN5C9uwSYcijnHrk?=
 =?us-ascii?Q?/aSh2YgobP1lBrQtJ+fEWJRJZwHPxGvqgzJtOvPu+bNLqPzQi4LuA6/1tiqm?=
 =?us-ascii?Q?0asKFOH05bWaEjK4I8rf03C5Yt76G5nSKhZatIA2TTgs/TicmqBKezr8rM5+?=
 =?us-ascii?Q?8NjNoaSSF2pNIId8jkJqnzKGbvfEyi7Xei0tmXrDf/E4D5PltXlDvv6I6bfz?=
 =?us-ascii?Q?HDAMmvHfuicvIdAeDLwaZjyCZigveORzicb8yJhgYwyeLkj0jo1z4hA8cYlH?=
 =?us-ascii?Q?NL6PuSRmAFNERtZqcTfiqGSgCa41eGsMxvCuyMIHD7S+sE32qCi4d6CpMz44?=
 =?us-ascii?Q?4E9AuKoj5iDjoxX3L+bIIprEQLwLbxjBCJJPMfmQbphyQlHyK5JGFwjmGySB?=
 =?us-ascii?Q?CruyZ4wRM95B051531YYIcp5uYSeCTAHSNOMy7WGVoE5ObmG2K7yNPldWwdH?=
 =?us-ascii?Q?Zw7fBM5QxQLSDjMdbUgzTUxTAzaHIEMC9kPSD0zlKB07BegEFwyAX8OB8NDI?=
 =?us-ascii?Q?y1AOu76qvBbFhDfxzUFO20V1SqUYP8gB3yvfCbdmbxtmDF/oXx9RV3Z/hHYU?=
 =?us-ascii?Q?Oro1bNZqNNxUdcrKhryfNGVmsbdCIh6qB+bNiv94VavBL5MBxg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hKEN9Olso9CtWg2Myi5MDB7jjD+ND2Vx7w8n5s5LC+GOwTwegKUJcnKm1t8Z?=
 =?us-ascii?Q?qYrFBKKIuje/bOu0GHrq2hDznvHQ70hUeESuQ6x+FP5phqi00b6HsA8r/3qt?=
 =?us-ascii?Q?9vxPBGdpuFMTARl7RL9/9XDHAFDq1c9GTCmtdhv7ox51hTOWZL999jyajIPP?=
 =?us-ascii?Q?tZLpVS15Gzlx4hsO8UqlD6zjaZEPzAvY+zmjkKDUl3Y1S0z9BV0EgucBHOCR?=
 =?us-ascii?Q?DvpSfVkLiM/ffweanx7MEeKqVje9GDWCpZHpa/UR24Sm3AK/7+xYxSmafOxp?=
 =?us-ascii?Q?GpcJFPw0/Sn0j6/WRQ4J4cm40ypQpy4YBsNzaN9ji+ESwmz4WqKaJ/X5+BXK?=
 =?us-ascii?Q?oja4hyGInoBYm3xPUSGUGLAwgw7yoQ7hpBLkVh3xowNvz3jlkMEJGtX2AhhS?=
 =?us-ascii?Q?1z8x/J8uFYL8WyfCqpFDGrP6VV5T62UZ8GN8KuYeprVdRabo8zSTtgFSxrJl?=
 =?us-ascii?Q?+CWJ7xILOFerM8Es36Yu3lR91rlMPKWbrEccRj4Bob0KoMF88flzH97t1EMX?=
 =?us-ascii?Q?FF5vAbOBEnHuAZk4V0CDf5RsJ6A2U7UsCngWfjFNXbd1j3Tk304LMquuZ1KM?=
 =?us-ascii?Q?uu6d6A+fAgW2P49nb6xvYgkols4Fyiz1BJ89rqGyb5mwqq9vkA22JSY8VAOz?=
 =?us-ascii?Q?g8jpnMH/53U5GJcgYw1MT5tg+otTrdT0K270XhxKs6fn/2fZLlf+waX8ApEb?=
 =?us-ascii?Q?DqBDEIrZ2xbXf1PKqL/NDMVjrHht27y+eYrcwz5jV164Is79wk9N7rlqtGJR?=
 =?us-ascii?Q?LuNMc4nqbZHbsqwbNmt2wLC/4SXc31Y5iEwo87puCbN7A2SHDn/lrEPJ8DpI?=
 =?us-ascii?Q?Ai9dRIMliAsfOEAIQGPL0TV8XAlLInlxEvSq7AEZlV40GdkDAFD/r0ZsovGS?=
 =?us-ascii?Q?L85a4xlzXw6RoJ8Jgy/U1qhZGJEUHpDn+XP3mns6XnrKCf6i6zPQ+NnTbbPW?=
 =?us-ascii?Q?JKzI1ItNFTP6m6B4Dqsmegup6VHHchadp6FppYPHt85ga+RwQ6h0AXX6JIhl?=
 =?us-ascii?Q?yxYtVJa+oPGZxmssXG0lPG4WpqUMjPQDaK8crT6ZFGjp/SGnanrMOxcd/9+o?=
 =?us-ascii?Q?VpHdabGkgmsj+urDfLH8NjKOH6S2WSx0hk2l6s1odjlUavGMdJQbp0Alh/D2?=
 =?us-ascii?Q?wnD51i8ocaBDf+jOGA/0Pk5o9K8JRQm/hhpO1tmEEi2HlUemBHQ/foHZYRhl?=
 =?us-ascii?Q?0QPv6YsuIgx/dY5IRA3HSnpBavZ/eAXj0be7fFNB94Vq112Uh4Gfk06jdqqR?=
 =?us-ascii?Q?bvt4+GrFBAVnM31yhHOiCurYIDFjsdOzo1HXg4u3CuQMvUBhw8iFxxdG8agc?=
 =?us-ascii?Q?8XtkyEdLFGzF35j+/ksANvu8N3YxD/tDVEMdQ7VJffjEfIsrYnjpjNgVDdQK?=
 =?us-ascii?Q?zDRbrs5l0B0Urxi6LLDNDh9sKB5FiFN4yL7xaZesnlUguLeqR4iTEmM+jol/?=
 =?us-ascii?Q?sWZ/Z7+zRpTMBA/Q9SbOeSask+3SZGLCOrezDIr6xA58zOBAs2nfaj3AF3I9?=
 =?us-ascii?Q?o7zaCRel/Ri9uAIrMUR6lQiLzcD01UTu2eHTeq4noxl+OiJjmsdd2ehVyZGY?=
 =?us-ascii?Q?72oecHwC2a7HEQRMdT+IYsXq+4XUmGn92G5an6rD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8830092-e152-416a-fde0-08dcb84c8ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2024 08:23:26.5542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MCGcdLze0xqAZJnAOzjt7OtR5gdfXtMPigzuJj0hIVCI2nTLUcnQpSBmQU1qSXG6ULd4FlnQISojxiPM6lpcqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7333
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, August 9, 2024 1:54 PM
>=20
> As the driver has enforced DMA domains for devices managed by an IOMMU
> hardware that doesn't support passthrough translation mode, there is no
> need for static identity mappings in the si_domain. Remove the identity
> mapping code to avoid dead code.
>=20
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
