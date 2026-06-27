Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9F8347FC0
	for <iommu@lists.linux.dev>; Sat, 27 Jun 2026 23:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782602454; cv=fail; b=iqbblCV4bdJgiTlzpSyP7HNuJaJbbMN8OBiHXUQzamnN9mhvh7xSHjbgIVkOrXRv5O+FBxYWujJoBV0LMBs5y2oFGhpeR0gM/B7L9ZSy/O68MnCyZqpEQIELAxkhQ7NaWJLGRqBzsmTD2CO3Sf+7U6XyHnbK9lyPj7A5VUpwLKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782602454; c=relaxed/simple;
	bh=AmtokBUDpLhSJkAHdfFdnaPKMr7Gz8weDOkv7A/g7Pw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cKrZwQdxyxzG6AVOdHIHLnV03FiIX0FXhqb5DLLYjX9Bh009P/9f8/79eFO/7l6VKuTicWo92S5pvQgBvq/i8lx+5DYyxkVeXBS4bSdCL9R6CMHciDcB41pZ0cf/lRLcl3fQsdZsqfbK3CO2gBVhsbkbB4s6k233puOrVJQYnSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Afm7EIw+; arc=fail smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Afm7EIw+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782602452; x=1814138452;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AmtokBUDpLhSJkAHdfFdnaPKMr7Gz8weDOkv7A/g7Pw=;
  b=Afm7EIw+bj+o6sGOPICslDJTy2z0KMVKx0CnsHvn2krDOTSFEVnfeNKe
   YqtbSxWTlvxM5ViDoFr1/1FDTnrtQoMkaNnThHvjOjG/cUwci6U8VjBYb
   ILusfCE8WGoDwDfw3nQ8unlLeL9rDyBcZMdXbra9oZL/FASVsMkP6F4yh
   xHggpxdTU96gcztnE5ACKswuqEjoAwvZyX6/Gq2znIxBfEN4+qxVWmwFV
   mvvf1MbBOOaoaeHuG0VXxvwUBCKvr694/CXvfZtVvynQvyfK5Gsl00i+k
   +MRX+tWHC4heqXkHlMgkSnCfq7X3k7piHjL5XiAbrLPlz1+AUvKYj3t6o
   A==;
X-CSE-ConnectionGUID: EJxONCKoTrqZwtfUb2iWMA==
X-CSE-MsgGUID: PMbTym6USB+j17yzYbEB6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11830"; a="94001270"
X-IronPort-AV: E=Sophos;i="6.24,229,1774335600"; 
   d="scan'208";a="94001270"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2026 16:20:52 -0700
X-CSE-ConnectionGUID: uWBHFjpkQBy8xcbdFU7kEg==
X-CSE-MsgGUID: bZ5A3JHtQI+zYsmNwCX48A==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2026 16:20:51 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 27 Jun 2026 16:20:51 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sat, 27 Jun 2026 16:20:51 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.20) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sat, 27 Jun 2026 16:20:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dy8h5zg3ar5K0cAOfjVrcfI04l9McWN/SyFncJ7VVlvzYT1m3f7e95XvNQC5adLW1DZ01rhYejlIhV5TFOyArJFKfG1TLTjq6+eaG924092NR/JXVyk+oFBgLM6ilmhZ81Sy7/gJwCO5gS6m+sJDSRN0WQgo0/3bBVmXW3I9WN5CzRsaNrvH7P2jYU6kWmX0Fy8kgZyrfPOqP87irQbkW8nFfRvqrjNZE6K6ScwJM1r08wGDMetr2NGO3Sg0QVXq1adiWcokfGhhEf5ZEFDa9gmV1TXedC5QPKYPzOZxaBKMIE3Qs3gRFxDFIRgvS4F82aJqOdxvefJBqWJ5XKKz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWPbU81VfXiZWBi4DlXD6yFBo/P7N9Ro1V32eg10IaM=;
 b=xFqCBVO3QLQWw9EAM+Gp+LZi6Zc0xN2vKQESZxvP0DXQf3liW0nSJG8Rk9EbEiVOwQjZZzmAXquVkeW6w72jrK62z++GVn9E6njxgjfpvwnf/jkUx0jJGObEj4ozSrPvzm/i4oNAZUde6Wj5DJnEAZf6rG8D/XLqQC0x3aPU8IUdypd1RCjZsT+RwcZsZOKaVxFR91MU7qb5dgJqfY6OQwLyQX0KNJOHpaA7hhk2k8AQqqvAwuGR0O3Eg96SckFSBeiNXNvhFWI5Y6sCnV4HZQVjij6lOt/tKJEr6r6B2FYS/Y5jmuu+6NI6dDcsQWHeS+4zM1a7X17n8susTWjCcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8498.namprd11.prod.outlook.com (2603:10b6:a03:56f::12)
 by DS3PR11MB9819.namprd11.prod.outlook.com (2603:10b6:8:364::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Sat, 27 Jun
 2026 23:20:48 +0000
Received: from SJ2PR11MB8498.namprd11.prod.outlook.com
 ([fe80::8db6:d449:e492:308f]) by SJ2PR11MB8498.namprd11.prod.outlook.com
 ([fe80::8db6:d449:e492:308f%6]) with mapi id 15.21.0159.018; Sat, 27 Jun 2026
 23:20:48 +0000
From: "Du, Fan" <fan.du@intel.com>
To: Michael Kelley <mhklinux@outlook.com>, "Miao, Jun" <jun.miao@intel.com>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "chenhgs@chinatelecom.cn"
	<chenhgs@chinatelecom.cn>, LKML <linux-kernel@vger.kernel.org>, "Du, Fan"
	<fan.du@intel.com>
Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
 used/hiwater tracking
Thread-Topic: [PATCH] swiotlb: eliminate per-map atomic contention on
 used/hiwater tracking
Thread-Index: AQHdAkGVG27dVNXNe0yyBQUhGJEOBrZLbVMAgANqNeCAAJmZgIAAr8IwgADkX4CAAgQt4A==
Date: Sat, 27 Jun 2026 23:20:48 +0000
Message-ID: <SJ2PR11MB84984BB3EE01F44D466EE39E99EA2@SJ2PR11MB8498.namprd11.prod.outlook.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
 <SN6PR02MB415757A3F56268BE3AF01D35D4EE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498277BE45D32A81ED07D9D99EC2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157761C37193172603E6AFDD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498300801245B279182EDE799EB2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157AA96B686F49F0800A39AD4EB2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157AA96B686F49F0800A39AD4EB2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8498:EE_|DS3PR11MB9819:EE_
x-ms-office365-filtering-correlation-id: 735a1191-4ff6-4e52-aa95-08ded4a2b8e0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|366016|38070700021|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: RKP3V3XsawAxRB9NyYuLL7upD1PQL4PQiDWVUIjcHqsPX8nGwrPusdsIM+vqOD+H+iwuTuNgZw0UhtuYfgJ9uy20GwLiryq6QuBDHpOv7GDZ5qsUWh6W9FdEzjbwtSLSCD/2mWcTN4PrsBK98yLVhiAhxnGLFpLwSyg+yLiPu6m8D6NdVqE2H/Z1DJP9ldlH60G+VtP4443vuUSV9dCKCy0T36/kzRi6ddbrHCEnGigElVo3lmDylFa4NUTrzy4vmMlfPUe2kJa4B1OYJJ0gl3uUIUerPj3sCkJaA6MCGQ5g+CBHgmmCJj7mFo3u89ZooxBzE3nJ2szvE3bt35A3kZy2QW87UYUxKH6EsXTTugUgOr0tRg/32Jwvgp67MWYj4TeGEj6umz1U1QayCDp51CfJ1rG+uGqgYIEnivEmaHInidT8DsaoDuqC1WazVc3wQifmsilg2xC9dLmxBYhI+XoaM4Z8Ui+Ar28zxppSBvL0yHWEbcIvdM3zlhPU6RJ7MCOvnpbfQQ1rev0rv8Zge28ffviy//EbxQbASbShYlR8zTgi61bi3xm0chd7uNO83KdrzQ9RmmHuQkZu2+DBvHktmA+s4GjkzPUNNS2V0wX+si8/cWg8ia6lIVxUaT+wnDRqUaNDOZUeLMmHQv/mRqCubxqPskFmTiXl4UhL0CCtfHDlXuMPlXpHKzGdQpbA8zsNO3hZlSi51fzaNcTXzR6OpnDUpPU9RHGoGKQlrrw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8498.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(38070700021)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w2tleR6cc9MTzAE2b1RIO7v6EJjhKCenkjO4VHSTS7hm5hbx3XxdKzKvQK1D?=
 =?us-ascii?Q?Qyyus274mJORn+Z2M0qd+wJI7+VHDEIYGilEEHgARd/93yvNTE91PlfFW3QX?=
 =?us-ascii?Q?B++FnbsuXaMw2qPSrOQ9ZcdDFTi4DJ0pqbTQipOjljhf+XrmdyGMcXG4jYSH?=
 =?us-ascii?Q?u0imOgZGLrhHkUowdJJDpYqNkYA4oX7gSiSOkpK9HbgRysXukIW/VcyZryHJ?=
 =?us-ascii?Q?LrHVg0+nW/LtoUvyi68ykWNjdNpW7U3fbneRYYBsV6yO5cj0YNQmFw8Y4Xq+?=
 =?us-ascii?Q?9M/fQ9RdhFpjF9JyXxtR/MJAI6yDOeeYvgTxV7xECvUW9l/G86CCLnYENR4t?=
 =?us-ascii?Q?ZFyeRMGDhuQHAts0vR1qSh072b/QZfEwIN+f4CymBcAaD0yKYInVmCxiBsSt?=
 =?us-ascii?Q?DZsQVONRBkbMkimyVNp0p6zAr27IThwjsQ4KpwVQMYMk6kfkePoyHWIrz+ut?=
 =?us-ascii?Q?oEKY1MI0amhhJG3IBBKrOl47Pd37GQentmatFLTq0yPfqumHGwLSuo9arBAG?=
 =?us-ascii?Q?9rl9dIKVPSEnnq0T9YijttiOU3h8DzGSQrjBoGDg3LT3n4KvMJAwhFhzHXZ/?=
 =?us-ascii?Q?mI7fW49LSh3e0hFLyyz7ZdSuZgJOg6RLyG/3zIKDMlH7z5QR80zPtA6RVZIJ?=
 =?us-ascii?Q?iRrQloCuVAK18tizoXJPoeGRPTwohwBgAccjcUjw47NqY2A4NsOIeyi3Uqcb?=
 =?us-ascii?Q?9jVSzB96gS86xxevHQIA0eHU/iU6SzeosvMI3E71yGgDTy6ly35VLn2lBPGN?=
 =?us-ascii?Q?bW7hqGS/1X6sIE60EYZtfK8s6KbQH2sF0Ug6q+pZzIBypMX7gji8rPfAjVVB?=
 =?us-ascii?Q?GmGm/SvuxxT3Eard9tLmJCbynoDKT5XHOgTA4XCfVjqhtbpaqq+3gV3siF26?=
 =?us-ascii?Q?LUZ9olbLVal7BcbWKljpHxHhDYcSr79GGDPitRfrumqMJ7A7NbhNrYhv3nGp?=
 =?us-ascii?Q?g/VtZJ0wnIeQDaZXCjzCEhU90NI17qTL6o5kCXi4auw/VkdQLEg7b44LGznJ?=
 =?us-ascii?Q?HO6XL4WEH1wPLF6/unjfSbLBBUGnsTSb+mKCo0ZgTh6t93kkiwREyXxdPwAU?=
 =?us-ascii?Q?YT8CPygzeFoyLrFVlSiO9YUHOH8cKQrjrBHfq5cw+XBzyDVxO5g/u+GhomHE?=
 =?us-ascii?Q?40HYS3rYz66yAvRrmHCJO6p5i9vGt86hlh58QysaCVDE3AZ1BZAjtxbnVxbV?=
 =?us-ascii?Q?IWM5m2RiI44SBKUlOhHqqU426oRFdaLifA/kOHFOYcmXtYDaNgcKEkjL9X2M?=
 =?us-ascii?Q?sFU+bJ/qpr0V+ZmZN6MOFmTpKo1Q6D+PagB/0TiY3SDrMLxMDBHCAFogPtNs?=
 =?us-ascii?Q?gkZfaMRT4+AvKuKBqxp+sCA7HR6N9yquLycfVqPiZQJaeO3fymNR8p4hS8FB?=
 =?us-ascii?Q?RujqtaWM5HCpmo0b7qCGIi4SGl+eIoCidqILDW6ZLlBy9MYkDJ56s6VsoRaI?=
 =?us-ascii?Q?2NQa/0RhyKCjk7aqXipXpj/zuNifFazhwyHm5lL/rX+8FxbWpQEf+blraMZv?=
 =?us-ascii?Q?RLBnH0rnqUEn7RFraoRqBAQR2+AeHjj8a6SJTs03yOH48dVdhONzwd1DEtuH?=
 =?us-ascii?Q?urvRpfpgeru5FdrsUKDaWiLV/92Pc0d31+AL8qcENpv+dJXXO0fUkjdTJeKP?=
 =?us-ascii?Q?s5AQzHTpgVTiUfI7v+vl43mvRlUJ8yl/abkDz0Qq4OUttMb9s/xAwwh/VBBN?=
 =?us-ascii?Q?hGOAqodKTppmqxYFCEXr3l2+5A1Ku7f9Vt79YNSNrs0Hx7KH?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: sa31ByWykGcUYiQCcfiGnXLYoR/ltYlSHKqIaoUsz2JKxP53SYY5YHIInuSWtCZ0O8azG6dj1IFPftHZ9Ks3ajfsMWqzAyDNJxkxzjFudcsaFJh3shy8cv1QRISNGvIBI2tc6Tr8GS1ffSiBySBpn/DUXA5gB5qPkREef3sM+oAJAbabfM/XZ7qdm2Ck/jx7NjAXAz9J0qPhjtQa2i97id5yNKLlPB8Bv73zj61STLEudC6Vvhfk4pPE8U1p1bTGzSM2+EGVnYH68gg+73ueK98K+aDpdOPzBKc0pfAkRr+HiyDi86ntDWEgT7TeNmQ16QGmP+IXvI85d+OlPufJZw==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735a1191-4ff6-4e52-aa95-08ded4a2b8e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2026 23:20:48.4683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C1QSTxBdSWWJ8F4x3CPgWvcWIheEpXLfUSZKZvqhx+9lEDRevUE472ZAaVZlJ+Rtywu+cXvYnOBHJaJ56pV6mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS3PR11MB9819
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Saturday, June 27, 2026 12:00 AM
> To: Du, Fan <fan.du@intel.com>; Michael Kelley <mhklinux@outlook.com>;
> Miao, Jun <jun.miao@intel.com>; m.szyprowski@samsung.com;
> robin.murphy@arm.com
> Cc: iommu@lists.linux.dev; chenhgs@chinatelecom.cn; LKML <linux-
> kernel@vger.kernel.org>
> Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
> used/hiwater tracking
>=20
> From: Du, Fan <fan.du@intel.com> Sent: Thursday, June 25, 2026 8:12 PM
> >
> > > -----Original Message-----
> > > From: Michael Kelley <mhklinux@outlook.com>
> > > Sent: Thursday, June 25, 2026 11:54 PM
> > >
> > > From: Du, Fan <fan.du@intel.com> Sent: Thursday, June 25, 2026 12:30
> AM
> > > >
> > > > > -----Original Message-----
> > > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > > Sent: Tuesday, June 23, 2026 10:35 AM
> > > > > To: Miao, Jun <jun.miao@intel.com>; m.szyprowski@samsung.com;
> > > > > robin.murphy@arm.com
> > > > > Cc: iommu@lists.linux.dev; chenhgs@chinatelecom.cn; Du, Fan
> > > > > <fan.du@intel.com>; LKML <linux-kernel@vger.kernel.org>
> > > > > Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention=
 on
> > > > > used/hiwater tracking
> > > > >
> > >
> > > [snip]
> > >
> > > > > > +	pool =3D &mem->defpool;
> > > > > > +	for (i =3D 0; i < pool->nareas; i++)
> > > > > > +		hiwater +=3D READ_ONCE(pool->areas[i].used_hiwater);
> > > > >
> > > > > Let's ignore the SWIOTLB_DYNAMIC case for simplicity. The approac=
h
> > > > > of calculating a separate hiwater mark for each area, and then
> summing
> > > > > those per-area hiwater marks, can produce very wrong results.
> > > > >
> > > > > Consider a 64MiB swiotlb in a system with 8 CPUs. There will be 8
> areas,
> > > > > each with 8 MiB of space. Suppose the workload putters along with
> mostly
> > > > > smallish I/Os, say between 4 KiB and 32 KiB. If each area has 16 =
I/Os in
> > > > > progress, the area hiwater mark might be 256 KiB (16 I/Os averagi=
ng 16
> KiB
> > > > > each). Summing across areas produces a hiwater mark of 8 * 256 Ki=
B =3D
> 2 MiB.
> > > > > But then suppose a 2 MiB I/O comes in. The hiwater mark for the a=
rea
> that
> > > > > handles that I/O will grow to 2+ MiB. After the first big I/O fin=
ishes,
> > > > >  another 2 MiB I/O comes in that is handled by a different area, =
whose
> > > > > hiwater mark also goes to 2+ MiB. Pretty soon all 8 areas have a
> hiwater
> > > > > mark of 2+ MiB, and the total hiwater mark is reported as 16+ MiB=
.
> The
> > > > > old algorithm would have reported 4+ MiB, which is accurate. With
> > > > > higher CPU counts and more areas, the discrepancy can get much
> worse.
> > > > > This is a somewhat contrived example, but the problem is real eno=
ugh
> > > > > to make the reported hiwater mark be unreliable.
> > > >
> > > > You are correct here, I like your way of thinking.
> > > >
> > > > > I'm sure the contention for the total hiwater mark in the current=
 code
> is
> > > > > real, but it's in the context of a lot of other CPU work that is =
being
> because
> > > > > of the bounce buffering, including copying lots of data to/from t=
he
> bounce
> > > > > buffers. Is that atomic increment operation a bottleneck even in =
the
> > > > > end-to-end context of doing DMA through swiotlb bounce buffers?
> > > >
> > > > Practical benchmark show case the highest IO performance for each
> TVM spec.
> > > > even if a few iperf (4)workers would cause the contention here.
> > > > My guts feelings, yes, the real workload probably hit the bottlenec=
k
> here.
> > >
> > > Just curious -- what is the NIC in the TDX VM? I'm most familiar with=
 the
> > > Hyper-V case, where the NIC is the Hyper-V synthetic NIC. That driver
> > > uses dedicated send and receive buffers that are allocated and decryp=
ted
> > > when the NIC is configured. Most NIC traffic goes through those buffe=
rs
> > > instead of the swiotlb, so I probably haven't seen cases where the sw=
iotlb
> > > is the bottleneck for NIC traffic. I do see the swiotlb as the bottle=
neck for
> > > disk I/O traffic, but the data copying tends to be the gate rather th=
an the
> > > allocation and freeing of swiotlb buffers.
> > >
> > > >
> > > > > Another approach to the contention problem would be to have a
> separate
> > > > > CONFIG option that is narrower than CONFIG_DEBUG_FS, so that the
> > > > > computation of the hiwater mark can be dropped entirely in
> production
> > > > > environments. Or the setting could be dynamic at runtime via a
> > > > > static_call, defaulting to not computing the hiwater mark while s=
till
> > > > > allowing a sysadmin to turn it on to see workload usage of the sw=
iotlb.
> > > >
> > > > That's counter-intuitive from my perspective.
> > > > With global counters, the observation, which itself impacts the
> performance,
> > > > wouldn't be able to tell the practical characterization, that's com=
monly
> lower than
> > > > max performance, in turn breaks the semantics of what's it for.
> > >
> > > Agreed. If the global counters affect the performance and throughput
> > > significantly, having an accurate hiwater mark loses some of its valu=
e.
> > >
> > > >
> > > > Even without those global counters, if user wants to know the hiwat=
er
> value,
> > > > snapshotting used value(sum of each area as current behavior)
> periodically would
> > > > produce meaningful value for workload evaluation.
> > >
> > > I'm a little skeptical of the value of just summing current usage. Do=
ing so
> > > tends to miss any spikes, and the spikes are the problem. If swiotlb
> capacity
> >
> > That's current design when CONFIG_DEBUG_FS is off, and used as swiotlb
> > shortage indicator for user.
> >
> > Statistically that sampled value is approximate to the true value as al=
ways.
>=20
> OK, yes, statistical sampling could work. The kernel queues a work item
> that runs periodically to sum current usage across all areas. That sum is
> compared against the previous sum to calculate a hiwater mark. An
> experiment to compare the statistical hiwater mark against the current
> exact calculation would be interesting. I wonder how many samples would
> be needed, and hence how frequently it would need to run, to get a good
> result.

Kernel doesn't do that sampling, kernel only report the sum as user space r=
equested.
Take a look at the flow when DEBUG_FS is off, and essentially it works as v=
mstat,
user set query interval.

> >
> > > is exceeded even for a short spike, you don't just get a performance =
blip.
> > > You get I/O failures, which at least on the disk side tends to be fat=
al to the
> > > application doing the I/O. Maybe the networking stack recovers well
> enough
> > > and retries, resulting in just a performance reduction. But I've alwa=
ys
> thought
> > > of swiotlb exhaustion as a fairly serious problem to be avoided at al=
l costs.
> > > That's why CoCo VMs allocate so much swiotlb space, even though most
> of
> > > it is never used for typical workloads (at least in my experience).
> >
> > That's dynamic SWIOTLB is designed for.
> > Only when the IO is so intensive, transient buffer/DMA pool is exhauste=
d
> quickly
> > before new shared memory pool is created.
>=20
> I don't think dynamic SWIOTLB in its current implementation is very usefu=
l
> for large CoCo VMs. Exhausting the atomic DMA pool is one problem. The
> dynamic swiotlb also can grow in a max of 4 MiB increments, so if 400 MiB=
 is
> added dynamically, there's a list of 100 entries that must be searched
> to find space (and that list is currently searched linearly). Furthermore=
,
> the pre-allocated swiotlb gets 1 area per CPU, which mostly avoids conten=
tion
> on the area spin locks. But a dynamically added 4 MiB pool can have a max=
 of
> 16 areas because each area must be at least 256 KiB. So there's more area
> spin lock contention with higher CPUs counts. And that all assumes that t=
he
> memory allocator can provide a 4 MiB contiguous area for the new pool. If
> the swiotlb needs to grow after there's been memory fragmentation, an
> added pool might be limited to 2 MiB or 1 MiB or smaller, with a
> corresponding reduction in the area count and increase in area spin lock
> contention. Overall, dynamic swiotlb in a big CoCo VM results in complex
> and messy behavior with new failure modes and bottlenecks.

Fragmentation indeed undermine the requested allocation size as dynamic swi=
otlb
grows by default 64M . In production practice, for large TVM, we see admin =
will reserve
majority of needed size, and let dynamic swiotlb works to add additional bu=
ffer.
Current dynamic switlb doesn't support shrinker to release unused memory ba=
ck
to buddy yet.

> Michael
