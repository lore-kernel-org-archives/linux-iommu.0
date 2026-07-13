Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4865CEEC3
	for <iommu@lists.linux.dev>; Mon, 13 Jul 2026 01:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783905537; cv=fail; b=IFRM6GAbzI1MQ3802jmwDMdUe52kvRkKUMyYj3VUx2FFc836mPQ6hlRVO6AoUOvkVGtIYeEZp+ngxhmfY2OmWiJUQaWSUScgg5vl67BKMDHdbe5i0KUeKCnJFtLwjXs1uyqTeEPxHp4YIIIfqycq/wcktBcOwGNsqmapsa7pD58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783905537; c=relaxed/simple;
	bh=NmrPaKSYQHoZ6677Cn9uc1iP3SyJF8GPmwZjnnHC/rw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NpiamcimBOuLJ6rHYvMa1h3csiONM5yl4MA3Oey6wfD5sgZRO+3xqev3tlnxogv42MLnYeyLPNVMYbCufaBEnCDhoD6ZO5Jy3ySzBly74clhh77OxcF0c1Swgb04TsB0HvQOf/eJlmhSvFGUgceVhkCmZ5cEZqi/P8xMOj6R5Ic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z6XXkH94; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z6XXkH94"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783905534; x=1815441534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NmrPaKSYQHoZ6677Cn9uc1iP3SyJF8GPmwZjnnHC/rw=;
  b=Z6XXkH94OPkA/FviLX/eob0VCR3BrfB7hl5l7/55ZsAJ61xg/Bus+xys
   hpHqaB3yigzT+Pl3n2kh2qscXJweVExNjjuwBEn5gdt6MXxmWHGxW2bDH
   FQAegrLI1DcdRH0WJcH4QU+bEfAxJBUJ/bykUbzzBvCkuwDrIPgYMiesh
   vBM2ec6EQS907XynVuEj5niT73yYGfS7CnqnG5yvpS8MIcYED0JkfOi3N
   c4oPVK9mBt3ALTQuhK7yt28adkEQmqjelVBWSkgVnFfWJiGubkNOwKyDd
   XzVAZTlVRzVHOq4B24KPhpbuSwRwQ/ynw02u0zglHh9yaL5e3f3MjnVw+
   A==;
X-CSE-ConnectionGUID: bT2n16gtTh+6LwEmJU6nuw==
X-CSE-MsgGUID: BUqsBQcHSGG/wgx0QVOIDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="102061882"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="102061882"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 18:18:53 -0700
X-CSE-ConnectionGUID: XWD6RV/iQLCGWJOsTB44xQ==
X-CSE-MsgGUID: DzFEW7YhTo+sFS2FmrLYgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="258985868"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 18:18:53 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 18:18:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Sun, 12 Jul 2026 18:18:52 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.51) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Sun, 12 Jul 2026 18:18:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXRF9FdyiV99xjxB0QvXq7IHL8IGEd0l7tIHGXhOIlpxdSKKk6IVbVrq+sto3N3F1Vx0Yu0PjDCg30+S06qw7xQbpBS0XG/+q372/WeuxGstay//T8fhhbYxmL0u39xanV34zTX4hh/1PpxwJDdlCJtBVOuweGK6Sv/mDvybE137K9c8MXttM1/dmSvQszVQaOXVLI3Bm8V7jpqfB85kLu+/ZeAJGzvp9DBRqHyHov2DpvHaT3i1SBFsYXfiKVztuHjOihCNd+obbhNr7Dc4jQyvT2N5kjawgZrQhPFQBKtpNNGEWx+9W/ApRcxm6ShDPogkmqhhPeTPxmzGdRzlTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h26SCrM4+vKeymB5HiF8n121qP8XtIVQgSyt2r78Dzg=;
 b=DFnSDlT3JPlz5n8gRrZ/GqBFdT/nLWBmppTEUw+gpNldnHsU2ctEbgpwJSOY8sX/HZ2x08xEOlpOxUVCE95Wafx06SGqDxWi/zUAqv8Kipdj0Xu/Yz2MRHKtkX4jKdadHJILr/QnwIbx6QWyuqmIX8hF1LyzeJGbXNZomVt4J6/c+eLWXZid6SK7VK71cDTarik5c0GKs2ef7u3N7Xct85Ahule1eIRKPC9NDHaFR30h2Pcm/AfLDieX9oONonHBSjPq8rv281D/uEhOXuHO90R1yd71boubrQs8yrBt2XxXldSdCtwxV1D5UmX6DTjakBMsPrgVciKzSHND5gcj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8498.namprd11.prod.outlook.com (2603:10b6:a03:56f::12)
 by DM4PR11MB8227.namprd11.prod.outlook.com (2603:10b6:8:184::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.23; Mon, 13 Jul
 2026 01:18:48 +0000
Received: from SJ2PR11MB8498.namprd11.prod.outlook.com
 ([fe80::8db6:d449:e492:308f]) by SJ2PR11MB8498.namprd11.prod.outlook.com
 ([fe80::8db6:d449:e492:308f%6]) with mapi id 15.21.0181.008; Mon, 13 Jul 2026
 01:18:47 +0000
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
Thread-Index: AQHdAkGVG27dVNXNe0yyBQUhGJEOBrZLbVMAgANqNeCAAJmZgIAAr8IwgADkX4CAAgQt4IAALWMAgATJ4iCAAnKggIAKfgxQ
Date: Mon, 13 Jul 2026 01:18:47 +0000
Message-ID: <SJ2PR11MB84988252D0631AC0C296058D99FA2@SJ2PR11MB8498.namprd11.prod.outlook.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
 <SN6PR02MB415757A3F56268BE3AF01D35D4EE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498277BE45D32A81ED07D9D99EC2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157761C37193172603E6AFDD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498300801245B279182EDE799EB2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157AA96B686F49F0800A39AD4EB2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB84984BB3EE01F44D466EE39E99EA2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157CD254526EE6A93FC5B28D4E92@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498E2E9F7D8ED129728C97799F62@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB415705E3CAC5BFA8EECDB881D4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB415705E3CAC5BFA8EECDB881D4F52@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8498:EE_|DM4PR11MB8227:EE_
x-ms-office365-filtering-correlation-id: ac7b227e-4c9b-4337-9d7b-08dee07cb08c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|18002099003|22082099003|38070700021|4143699003|11063799006|56012099006;
x-microsoft-antispam-message-info: NiRArd3M5+1lcaePpGwqeu2GRddo3OeTTWgCToKsDK7vmjAIftwmbljykz1qF2ugHfZ15dDgOR73Bgk8My+PFNqL0BzX1XW43J24CC3mTqAUMWC3mzeI+0CRtVBJJsL2J/QNuRTk9+6cFkUITIg1ZD1aG1rdaNUdf8Hgo32DWM36RNV2+hOczLhwIHuO5lAlP7sfoMxcSn7+7nyKlOpS/HkZQve0SVz5iSUchouTYErCzpADWLXEUfcPEEfHKFHIgoNanT/Lw+5iIxUhQz3t4Tc1DTnpYXGqqwoXx2PdhOJn/6zw9vgGigLm9dNl1eR2DIImv2B+StM5vt/YKsJKs+Q2LKLHyZN0/zBfMwvxi+P2R4nYZWCPpGrMIlJd+jNDuoQN6+UHEKw8DONtOdCfHt4yTDcYE010/FyjleG/2eSTcKKDQkkn//tfmf5W4GS8rtaq87xGQMms6c9PiolH5SuC7tkdducvAUcZEddOppK68mcPuEYSFOyZ73GrPpzxFaQt4X4eNPNJi9IqefdYlBQzfUbC36cY93yEuZ7Uyq+8V9eCd9fdeu92eWf1Qryr0q42dIUKgpWsBattsHQmSYYoIJqChnvskFhpr7+v+ibYxdabD4kIkWfgQuY3ZTdF+Z+ooMStJN1K3fj/IfNO1i4f/+pkevqgR1hwKaWjh/Z1dScTTzz7vBeCNUKnJriZW+HlQmCvwEjtLcJSDQ4en4ftYL02P9VfiYbuQ3HHmHA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8498.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(18002099003)(22082099003)(38070700021)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?v9VhqHwc/5K3sJ/NI4bkvxH+NKrrnva8dOgJN5heHBNCAXqOQ3Fhfe28zIA4?=
 =?us-ascii?Q?/dXZZDQWft0u9JpGm+OtnwQdagUECF6hIWftaasWuHDPuM2D97lFGjemHgOz?=
 =?us-ascii?Q?z5jWZqcKbQwOrAmPko6zLZRd4L6pcBlnzvYyO+zNWaDL6Y9fofXuuQvfzxdT?=
 =?us-ascii?Q?6UPZSZhZuPj92yth6XPvaXfp3zdNG2T23VbxPVu6e310HNb1ZI9NBfLoTAr6?=
 =?us-ascii?Q?nUA4vsMPMRPC4BM/K1+AI5TtpSui7u9JOS1N1NRrDXW5CQMgpmE2GDXNNoB8?=
 =?us-ascii?Q?UfVG2t7fvA/Gcvf+Jqm83Dj2lxShJwlpzS6UD58tUwSOCF1qEPuHzmxy6mkE?=
 =?us-ascii?Q?JN9Vy0dsUnCrubGgCSF0LtXLvN2fjjnWvAJEUSu1oIttBj9uO49CGqIajBdc?=
 =?us-ascii?Q?NDf7IaQLnNt+2G+9Y927vC1O67ci8KV0+0yj9WDRl1cuA5K9tW2D0SQkaVKb?=
 =?us-ascii?Q?2iKnhbJHGUw6onV0MLo43e7L0TYVUN7jkcxEHKesTyFERAQI1NyR1h1EKz0X?=
 =?us-ascii?Q?6TVLsH5KpCgqV7ajgVIRIW3OTzViQEJOpA4quY99sGRZ9nd2e+m+QL6vcA6h?=
 =?us-ascii?Q?nr6AG1+EbmQGSKUFy3+CiMvlhFwxUEA5UpoDkTpoyWIx4xmBOlTxWFZLDP+i?=
 =?us-ascii?Q?AC8eT8ZhSrfUebh0zU79dbwcfTDoVGOpUuVr1jKM+SPCiY9IScy5rWrSUBTi?=
 =?us-ascii?Q?HhsPafeh6zN1RcxhQ3DMNYUth7uoebcjJuNhxiaqsLNzrsJzO+3Il74fhSnq?=
 =?us-ascii?Q?Kgy36/lIALZDyo0unAJbBLl4/3xs1+XGNL78IQIEM8JPXmYU1ujbCpG49ZYk?=
 =?us-ascii?Q?RFmBuHsVFiuHcMbD0K6AtOWWgLx36TPnBXqFjDOYuGMnxVQPA3CIoVlDBWwi?=
 =?us-ascii?Q?qmOocX1CEQXKMfzr+/KDYTs+PrIGRzUQSCeG4np7HzWznlpfVtnEFPIcnPh6?=
 =?us-ascii?Q?kIlEaTvJOi4elY8oNpj0JjXMzTmWDCUP+i1E4IWkNEG/1uBkyS6Xpu/BNG7r?=
 =?us-ascii?Q?jdrBHJmuFj5AkG9224BWDq+58SpD/hKyMqvOR3iut/il1KsQKZvuO7Yui35T?=
 =?us-ascii?Q?6YK7xkWrg/dImZfZMthEv0GPh+4iU4FOn3Fww0yvIVMQiXu1F0FQsELxdSWr?=
 =?us-ascii?Q?gsKcx8tTUb+xuwqvun3N3Txsmuqjn1FfsATfibEc/R2CgnkfDSRoLbVYeaJg?=
 =?us-ascii?Q?pxMgLSwdCTaIoaEQtLWoFFzRfuF49YLER3Sc20KjIA+s7J2Nsz2x00C7o6E5?=
 =?us-ascii?Q?pqIRrU6A4k70b8sR76a4Ccwf3wl30/qrko6f6MTRip5Vn9EObqybPD4bxWlV?=
 =?us-ascii?Q?XtVLKFeCLX9gGBYxnyO7P48O5EC5cOHg1RKbnql8th7KmyRC627ahJG07rAU?=
 =?us-ascii?Q?wFoy2fx3W9g9USbLOtCzR9K6t+dpPYJ2ksfTT5qeP0I2uFN0GqyM2GcrQild?=
 =?us-ascii?Q?2mmvzU+Coehmg0zC7ecQdY2GURgvxa7V+AVa3uGfEX9t1kHQGoDfsxz3DTsi?=
 =?us-ascii?Q?di5+RK5DyJie+wFI3j/qGdMn12bz+fiNF/jsg1uwMf+Jix97KIejLdPhqsLV?=
 =?us-ascii?Q?QKvJmu5Ko93xfp7MWft0wtQIOdkz9BymCeZhB/B1vEE7SzZPpEHwfIFxsiP3?=
 =?us-ascii?Q?rvap+9E7nDx+KT+yaci+Na4vk3BjZ1l2LI1IgW5XjfAuibdo4OHkdwiXbJjN?=
 =?us-ascii?Q?GLcQrCKlS4L4aEnLMh8mZJoWcoh9hWynU41XU1RSpyST53xR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: ijfCmwgT/3SGl5lPLojpaDcb5thDvY49TD9eln5eibVE2itxD316H35npULRzPGivZx9W6j3/n5njbB/QlDNVjjF/PTt90E+571bSm9ERN2HhUN8lhyad0nFcq7NCjzNXswtqg5rmFTrQIkZqJnvMmKCSrODE8lhb+lOwb9wm7xBD+p0IbC/xU1ly/D7Kdl8bPUu/W+0fNcPUfgCtMuPzlthLLClSvHoIE9SPOwgW4mheC8nAUB3UgO/x1AMm2ia1wzkl7GQweFtY7MRGy59kkyBuky3Ijt/K/guMh6I2aIvbYISWiQJ6PjAqPIjDgZpbFaBW6uM9sgNzkoqlp9GJA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac7b227e-4c9b-4337-9d7b-08dee07cb08c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 01:18:47.5141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mb0ZSDPm5/F/7JdzbStazw8BrRCiejHOsJXmw0YWP9EXn08RJ7S54zrTd3/cLySUbiPd62J+5a49otivgSR6IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8227
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Friday, July 3, 2026 12:01 AM
> To: Du, Fan <fan.du@intel.com>; Michael Kelley <mhklinux@outlook.com>;
> Miao, Jun <jun.miao@intel.com>; m.szyprowski@samsung.com;
> robin.murphy@arm.com
> Cc: iommu@lists.linux.dev; chenhgs@chinatelecom.cn; LKML <linux-
> kernel@vger.kernel.org>
> Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
> used/hiwater tracking
>=20
> From: Du, Fan <fan.du@intel.com> Sent: Tuesday, June 30, 2026 7:54 PM
> >
> > > -----Original Message-----
> > > From: Michael Kelley <mhklinux@outlook.com>
> > > Sent: Sunday, June 28, 2026 9:30 AM
> > > To: Du, Fan <fan.du@intel.com>; Michael Kelley
> <mhklinux@outlook.com>;
> > > Miao, Jun <jun.miao@intel.com>; m.szyprowski@samsung.com;
> > > robin.murphy@arm.com
> > > Cc: iommu@lists.linux.dev; chenhgs@chinatelecom.cn; LKML <linux-
> > > kernel@vger.kernel.org>
> > > Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
> > > used/hiwater tracking
> > >
> > > From: Du, Fan <fan.du@intel.com> Sent: Saturday, June 27, 2026 4:21 P=
M
> > > >
> > > > > -----Original Message-----
> > > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > > Sent: Saturday, June 27, 2026 12:00 AM
> > > > >
> > > > > From: Du, Fan <fan.du@intel.com> Sent: Thursday, June 25, 2026 8:=
12
> PM
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > > > > Sent: Thursday, June 25, 2026 11:54 PM
> > > > > > >
> > > > > > > From: Du, Fan <fan.du@intel.com> Sent: Thursday, June 25, 202=
6
> 12:30 AM
> > > > > > > >
> > > > > > > > > -----Original Message-----
> > > > > > > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > > > > > > Sent: Tuesday, June 23, 2026 10:35 AM
> > > > > > > > >
> > > > > > >
> > > > > > > [snip]
> > > > > > >
> > > > > > > > > > +	pool =3D &mem->defpool;
> > > > > > > > > > +	for (i =3D 0; i < pool->nareas; i++)
> > > > > > > > > > +		hiwater +=3D READ_ONCE(pool-
> >areas[i].used_hiwater);
> > > > > > > > >
> > > > > > > > > Let's ignore the SWIOTLB_DYNAMIC case for simplicity. The
> approach
> > > > > > > > > of calculating a separate hiwater mark for each area, and=
 then
> summing
> > > > > > > > > those per-area hiwater marks, can produce very wrong resu=
lts.
> > > > > > > > >
> > > > > > > > > Consider a 64MiB swiotlb in a system with 8 CPUs. There w=
ill be
> 8 areas,
> > > > > > > > > each with 8 MiB of space. Suppose the workload putters al=
ong
> with mostly
> > > > > > > > > smallish I/Os, say between 4 KiB and 32 KiB. If each area=
 has 16
> I/Os in
> > > > > > > > > progress, the area hiwater mark might be 256 KiB (16 I/Os
> averaging 16 KiB
> > > > > > > > > each). Summing across areas produces a hiwater mark of 8 =
*
> 256 KiB =3D 2 MiB.
> > > > > > > > > But then suppose a 2 MiB I/O comes in. The hiwater mark f=
or
> the area that
> > > > > > > > > handles that I/O will grow to 2+ MiB. After the first big=
 I/O
> finishes,
> > > > > > > > >  another 2 MiB I/O comes in that is handled by a differen=
t area,
> whose
> > > > > > > > > hiwater mark also goes to 2+ MiB. Pretty soon all 8 areas=
 have a
> hiwater
> > > > > > > > > mark of 2+ MiB, and the total hiwater mark is reported as=
 16+
> MiB. The
> > > > > > > > > old algorithm would have reported 4+ MiB, which is accura=
te.
> With
> > > > > > > > > higher CPU counts and more areas, the discrepancy can get
> much worse.
> > > > > > > > > This is a somewhat contrived example, but the problem is =
real
> enough
> > > > > > > > > to make the reported hiwater mark be unreliable.
> > > > > > > >
> > > > > > > > You are correct here, I like your way of thinking.
> > > > > > > >
> > > > > > > > > I'm sure the contention for the total hiwater mark in the=
 current
> code is
> > > > > > > > > real, but it's in the context of a lot of other CPU work =
that is
> being because
> > > > > > > > > of the bounce buffering, including copying lots of data t=
o/from
> the bounce
> > > > > > > > > buffers. Is that atomic increment operation a bottleneck =
even in
> the
> > > > > > > > > end-to-end context of doing DMA through swiotlb bounce
> buffers?
> > > > > > > >
> > > > > > > > Practical benchmark show case the highest IO performance fo=
r
> each TVM spec.
> > > > > > > > even if a few iperf (4)workers would cause the contention h=
ere.
> > > > > > > > My guts feelings, yes, the real workload probably hit the
> bottleneck here.
> > > > > > >
> > > > > > > Just curious -- what is the NIC in the TDX VM? I'm most famil=
iar
> with the
> > > > > > > Hyper-V case, where the NIC is the Hyper-V synthetic NIC. Tha=
t
> driver
> > > > > > > uses dedicated send and receive buffers that are allocated an=
d
> decrypted
> > > > > > > when the NIC is configured. Most NIC traffic goes through tho=
se
> buffers
> > > > > > > instead of the swiotlb, so I probably haven't seen cases wher=
e the
> swiotlb
> > > > > > > is the bottleneck for NIC traffic. I do see the swiotlb as th=
e
> bottleneck for
> > > > > > > disk I/O traffic, but the data copying tends to be the gate r=
ather
> than the
> > > > > > > allocation and freeing of swiotlb buffers.
> > > > > > >
> > > > > > > >
> > > > > > > > > Another approach to the contention problem would be to ha=
ve
> a separate
> > > > > > > > > CONFIG option that is narrower than CONFIG_DEBUG_FS, so
> that the
> > > > > > > > > computation of the hiwater mark can be dropped entirely i=
n
> production
> > > > > > > > > environments. Or the setting could be dynamic at runtime =
via a
> > > > > > > > > static_call, defaulting to not computing the hiwater mark=
 while
> still
> > > > > > > > > allowing a sysadmin to turn it on to see workload usage o=
f the
> swiotlb.
> > > > > > > >
> > > > > > > > That's counter-intuitive from my perspective.
> > > > > > > > With global counters, the observation, which itself impacts=
 the
> performance,
> > > > > > > > wouldn't be able to tell the practical characterization, th=
at's
> commonly lower than
> > > > > > > > max performance, in turn breaks the semantics of what's it =
for.
> > > > > > >
> > > > > > > Agreed. If the global counters affect the performance and
> throughput
> > > > > > > significantly, having an accurate hiwater mark loses some of =
its
> value.
> > > > > > >
> > > > > > > >
> > > > > > > > Even without those global counters, if user wants to know t=
he
> hiwater value,
> > > > > > > > snapshotting used value(sum of each area as current behavio=
r)
> periodically would
> > > > > > > > produce meaningful value for workload evaluation.
> > > > > > >
> > > > > > > I'm a little skeptical of the value of just summing current u=
sage.
> Doing so
> > > > > > > tends to miss any spikes, and the spikes are the problem. If =
swiotlb
> capacity
> > > > > >
> > > > > > That's current design when CONFIG_DEBUG_FS is off, and used as
> swiotlb
> > > > > > shortage indicator for user.
> > > > > >
> > > > > > Statistically that sampled value is approximate to the true val=
ue as
> always.
> > > > >
> > > > > OK, yes, statistical sampling could work. The kernel queues a wor=
k
> item
> > > > > that runs periodically to sum current usage across all areas. Tha=
t sum
> is
> > > > > compared against the previous sum to calculate a hiwater mark. An
> > > > > experiment to compare the statistical hiwater mark against the cu=
rrent
> > > > > exact calculation would be interesting. I wonder how many samples
> would
> > > > > be needed, and hence how frequently it would need to run, to get =
a
> good
> > > > > result.
> > > >
> > > > Kernel doesn't do that sampling, kernel only report the sum as user
> space requested.
> > > > Take a look at the flow when DEBUG_FS is off, and essentially it wo=
rks as
> vmstat,
> > > > user set query interval.
> > >
> > > Agree -- the kernel doesn't do that now. I wasn't clear in my comment=
 that
> > > I was envisioning that the kernel *could* be enhanced to do the stati=
stical
> > > sampling and report the result via sysfs.
> >
> > OK, thanks for the inputs!
> >
> > Based on previous discussions, to keep backward compatibility, how abou=
t
> keep
> > hiwater as it is, while guarded by dynamic knob(default off), and expor=
t
> used
> > memory from sum of per area as current design does, then user can still
> have a
> > chance to track the overall usage w/o visible overhead introduced by gl=
obal
> atomic
> > counter?
> >
>=20
> Yes, that works for me.  A couple of points:
>=20
> 1) If doing the exact hiwater calculation is dynamic and defaults to "off=
", that
> dynamic config would replace being under #ifdef CONFIG_DEBUG_FS, right?
>=20
> 2) The mechanism used for dynamic config needs to be one that is
> selectable on the kernel boot line so that the exact hiwater mark during
> boot is easily available.

That's what in my mind too, will post the update version, let's have a revi=
ew then.

> Michael
