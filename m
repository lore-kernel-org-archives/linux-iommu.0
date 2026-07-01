Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CB53612F5
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 02:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782874441; cv=fail; b=LzskmksHTHo/PSvhwYcL1Yo1/WO+sY2ht/X13mIMN/Ps+IfRw5PwcBThyxYPdCFm6htw2Ex9ZAZYZnbDIpyXrrT7VMcG26nK2J5WRWKRj6hB0dn2XmrorUSDrVesRQBB2qAS6PgPsJI1AlJbR440jjzWdRqaUCnw7KGTEPpLMK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782874441; c=relaxed/simple;
	bh=kvtFsHAkMi3H8k797wrTs6bZ2+QAT211RpyvFbrZT7M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ALtLH30N3UNYZ5oDQKPv18H26lyHT6Ko+gFDgMQp8WlJUNXPGTDHjuAAJgd9S2kNSJAjp4B9qQiJThMLUT6HCurQXmtz4mWAnXexaZmGuBK6P1Xf9p+UZqarWxmEVRjHjrXItqEHA4UdaA24iWhz4g4TiEgAEB4sNmWCD++38Jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPTHhzUI; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPTHhzUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782874439; x=1814410439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kvtFsHAkMi3H8k797wrTs6bZ2+QAT211RpyvFbrZT7M=;
  b=MPTHhzUIpHIfz+ZdVSz2YRxBcmNtKeTUMBz0aOqCAJ4P8A0rNgJd1vdV
   KWNtBuL7ZLXoQdqBei1maGCpf2x1JZNOAsPI6K1v8nFdU9qDzdsZMqAc8
   pdi1YaSW1Xi5gtAjPq3nj/XUTOzu9Z1QJogXdSsxjYfqCStQWN6DYaYeh
   WAW/Y36YgAW4WWTDjtB1O325D4cLvAS1lf40a2lohBns2uZTWmMQ+rRVG
   rQghpxhk9JHedCUjhRFqVjlLnk3DR4kCdeJLTTTSXbgBc2ZMKcCPPeRPb
   fQWUtVhxubRRLbEgCkCj6l57kQL8zhjbimo9iPo4PpUXOzpFTE285V6xY
   A==;
X-CSE-ConnectionGUID: JyESLepTT5GzGQTEeS3AOA==
X-CSE-MsgGUID: BqN0cbYHR7GuiDH598rhYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11833"; a="71121738"
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="71121738"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 19:53:58 -0700
X-CSE-ConnectionGUID: 0IRn6REmR/CeubmZdSAukg==
X-CSE-MsgGUID: +MI8Ax9HRaGHgF4+QELmUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,235,1774335600"; 
   d="scan'208";a="247960609"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 19:53:58 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 19:53:58 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 30 Jun 2026 19:53:58 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.68)
 by edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 30 Jun 2026 19:53:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/8uiSY3hxjZMqmGfxwcIUeJECIjwQL0VmJcv/aToVHJ389oTFCkIMMYA1fnHIVMN/xEkQWCHoh2gw1G7rwmVxxhwB/botN9ySLc28bmFsoHeXbDe0s4tGNIEWErHmwNaRHX6exIYFNz20JvYIgdamk9M/0dvx9+DjhEhfyaGy/eKV8Qx8pdIdLX6UeUMNgt1LH0n58pU+sxQtMC3VnJOkqns6xTrz1UeD914NxIuiDg6KnPZU9fGkSHmCEeg9MeGe8ME6VHqL/FlAEzXq9yGNC8lBhMqURLCuW9masl5CHbhC/FZQQUMA87AfI9R/VxuW02QJMfPPQjkVHFePp/cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2HZ4OOWtw6cZO3V68/tQBnjkAiUK2aTpAaQ1KqSUNs=;
 b=ZRpgLGo+JoT509j12Gt+kSmy1EK/Zeeh1Dn/7UVDhsF2pWoKJdITHrbu2Kgq9ssZxQSlFnz3IIu/HbXHYQ5V9bDUH5vwr2yu7UBZQdwPPkGLItV/O5ldY5buCOthWYJ2LegeYv9Xwb7sSmbdRzmovK2NCZ7TPU1OhV1d8c6tme9yMPiD+9c2ZwjsuLUO1ECOeO21JfLuSDu/GquDLM4o7qXV8T8zH0Oj0FHGLMUU4y38pZcUdDQUMdvAkCWe43EgrjoAip3EHxs12L9P83byOZv+zdo6icwnZDEMBW59rw2OC4w9d1vZgnFA9YAwSy4x5J7MnoeMLNKWCoDizzbZ0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ2PR11MB8498.namprd11.prod.outlook.com (2603:10b6:a03:56f::12)
 by PH7PR11MB5886.namprd11.prod.outlook.com (2603:10b6:510:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 02:53:49 +0000
Received: from SJ2PR11MB8498.namprd11.prod.outlook.com
 ([fe80::8db6:d449:e492:308f]) by SJ2PR11MB8498.namprd11.prod.outlook.com
 ([fe80::8db6:d449:e492:308f%6]) with mapi id 15.21.0159.018; Wed, 1 Jul 2026
 02:53:49 +0000
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
Thread-Index: AQHdAkGVG27dVNXNe0yyBQUhGJEOBrZLbVMAgANqNeCAAJmZgIAAr8IwgADkX4CAAgQt4IAALWMAgATJ4iA=
Date: Wed, 1 Jul 2026 02:53:48 +0000
Message-ID: <SJ2PR11MB8498E2E9F7D8ED129728C97799F62@SJ2PR11MB8498.namprd11.prod.outlook.com>
References: <20260622122114.2563254-1-jun.miao@intel.com>
 <SN6PR02MB415757A3F56268BE3AF01D35D4EE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498277BE45D32A81ED07D9D99EC2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157761C37193172603E6AFDD4EC2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB8498300801245B279182EDE799EB2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157AA96B686F49F0800A39AD4EB2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SJ2PR11MB84984BB3EE01F44D466EE39E99EA2@SJ2PR11MB8498.namprd11.prod.outlook.com>
 <SN6PR02MB4157CD254526EE6A93FC5B28D4E92@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB4157CD254526EE6A93FC5B28D4E92@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR11MB8498:EE_|PH7PR11MB5886:EE_
x-ms-office365-filtering-correlation-id: 783128b2-5f47-4e43-4233-08ded71bf9e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|38070700021|3023799007|22082099003|18002099003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info: dsMGovjhlD35SI2Ao5km46f9HTkvpXvHU4E6MmxopvFxUVmQuVX8rK8KD2pUwcHlpZMhyiw6PLRCtg2U9EQoKj4w+DH7B6JHtcil2WUmMXnG8aDe0RFiS2jsnA3d8PZEAuLwLWtfX+iYvrfh9I633TcLFHhwdHauE8r/5y1ppRH3QVGKc0o5FCRL0UpBVDavhI7FDCpQ7yVFpxm7+ebCQVzVzwrdtW87TWpTuasad3JiR/TbgMwHV0m4Gg+O3Krnv0vKAkb18UtE58I/oldKlOGoEqwHmdedHTPTWMj429IbxkssY3CTzxAEDokDUZz0UIQBFHQsVb3ueVoO8RBIe+SN4Qag1xxPKGTZWHaPYYyICHgAq+2B3wcRy+eCboQ6wd4elpc/67IZZbNuADiCToFZpf8l5S3EwsQw1noOyH0We15GFVV1bnBugciLY7gZij7zdzJIzfTLVqy62DaRAKx9Z/DBaSxthk28O1IOz+Vy1QYvex18AmyztFNRCFCdoEt++AdyBE9qYhdTiZpFANp6SnFaa2SHVN/Qk6TrIU/CLpVNdoRXFbYfcB3zWOa/TUNZRFEuCZPO4pfo+rTBgf53F93ktsIdVjBUD0YOjx0Q2NJV+bfNcNiC0Mcs2kNDLRSXldUTqAmeeVsyzVH2jsI3cTDpWPOettf2lcLvYf01dIZH+GJKspnWdfezzCKoVs0J3Ygv+LrIg0Z4dYjWTmO1eqP1+sDTpV2THOZowV8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB8498.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(38070700021)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o1adQGbIbaOeYIVHusbuGjhU+AvXQxF9Wp+DxIZh279kDVNQ2lXee0ZnwEWN?=
 =?us-ascii?Q?9Vz3zl3REXQf+nZjMa95jigeG2Aq//VaJ7sNRXUtgCsduEkORCSW2caumVLO?=
 =?us-ascii?Q?c3URyogvpXpTqC0yVfFDiHUQA9/EE1+8aW8+0X++JJF0+3hddAkbiMnV5q6K?=
 =?us-ascii?Q?/apx6yRmjJEIYG9VZJlSJwh0Zc+qPQB9DlBbd0TO+Hzl1mCsnHs/SCAVQAdb?=
 =?us-ascii?Q?Mrn/l8i1D1WJETQm42bRJdpwZlb6fZEsXjEdIovy2JQlfvALFaJQnE0ej1h0?=
 =?us-ascii?Q?nCKWVsbrx+fmWxop3sOJXp+E+FhP+fcPtQnw4GXfuSpWTMrp2O55KsrQnug2?=
 =?us-ascii?Q?t9x3Fk9WENZXdKHp8lixtywPMQ48Y0r9pWcCb/S9EiiX73KJEqvyfnwYVfTU?=
 =?us-ascii?Q?BIFMXeYPGyX3xVe8eyZB5Df1LDwsXUXhgwOoybGzpdS2lMv+2TJTZUB+QJsG?=
 =?us-ascii?Q?jBBKxW5TS+vmQyHZ5bgRuztGcctiEB4T8LQ4r1S4GZ2hTc2lA4FkJfyJGe/5?=
 =?us-ascii?Q?+cvVbzSn1TudApn201uASBnzdtQyHP3ArzZ5aZ2lqA5Ul+9sJFvnquyYwacp?=
 =?us-ascii?Q?mVVue1j6gqj4cv5CfM62pLbysyggoEiZWSLnjDVYmNLYRmgQmI+PZdz1ok4S?=
 =?us-ascii?Q?Jv7IGFTPblkrOsZNlZRIBv5eHPOZqQhjvEE1vobgB3RFQ2PnkKsdE3ZiXUc0?=
 =?us-ascii?Q?ZcIanYN/hsFDcqfwjPCUhp05iQeqjVewUTqDWrM17RRGUZB03WA8G+fm7b/3?=
 =?us-ascii?Q?BJb2Vy+e1qsGIqGXfigto+TG8JAshrrejkfyZDXeSWo7s1xOC3aWBgwc3Av8?=
 =?us-ascii?Q?i4hKAQbdIxbSMRG/V3SN0yCT6PUd7bBWTD8DYmCX/5XD+G3sy6N5SEnGhL8M?=
 =?us-ascii?Q?SEfzumaUWoEMtGBQ9ph7C6ZhPIHDvsuCCrqViHpKrvQ3NsjGox4oY1cIPuc4?=
 =?us-ascii?Q?uSgh71cnUOesf9Yyp/VsfTo98aC9cA0ROJZa4OqR1qN8fsvetptHYD1qtXws?=
 =?us-ascii?Q?Nn2HBzvaEWwhU5PrcSij/g+GOiyo5WD1Ok7aw3nYdnNAffA1ngob4ai45uFZ?=
 =?us-ascii?Q?SHB2dsKtvHvWh+KZBsAS8PIex9bOluzMNcv4+yX40xYWg95Y58RfpjNlR4cC?=
 =?us-ascii?Q?NWElI639Zu2HFvaRMqhOEUv2uH59M2S8lAKF4erodhmIbyjxICsj1Kk9WMHS?=
 =?us-ascii?Q?EEtK9VDp6bFTwaiP8PkIxdCWA+z8g8tsESdkgEjDLFIvv6ZFJdF2XhiQTUe1?=
 =?us-ascii?Q?OzACnnU/TJrwWfc4gaOb0Lyf81zComhmIHSfkxKoiuc4HndDdPCJLpHlekfD?=
 =?us-ascii?Q?gJAvPJZPb839xl5cY2Q/Pl4ICXH4OuPA/liuOcrqYe6obeUKB4Z3JGs6ex8Y?=
 =?us-ascii?Q?156HRfxM+4aO1Jj4MsH0YikY/4trGywk7edLTttrikK24TA+cucwpoKx5/Uu?=
 =?us-ascii?Q?52RoTSdXbNLprRrvFIOdX/3QSOTPJMsmbV3aJ/gzKeTCbQf9yFsh1JOwPqp7?=
 =?us-ascii?Q?vSe2YPfbhCjiembQfIoKQEKhogDTEbxZZLR5p+N/mhtdsH0VS625KsvL3Ef0?=
 =?us-ascii?Q?vy/yRyLfo8U3SWpT8glATCRI5LUxXZlv3jEpBSKMlGObb2djTcZK3JcGRvLV?=
 =?us-ascii?Q?8e9pdPg0XE6VCZBq+UXVFYaukWywebFa0mQZzBhmqlos4ScwbI9N3+IFoSyc?=
 =?us-ascii?Q?XaBBJoBw/VxTFrfm+RHI17offpU+jYvjEzV/I8gv8B3TlJud?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: o5cUgbEomOP66IhwAu9LGSjT+KfMVQW58Bnvw41Gq84HJpk62jeyOxm+KVYefJsMg7jVhzBt0VHiirGd5cvhrA4e10/hxmJF47+XspKcDLQJU+rePavOa2M/usG4EE4UqNcp5wEJYwntzf+FhyhDWyZc9Q5Aj4MB6aIfgTZzGbxElYPDQIEkdjanpK2TtMJh/bdGSsHiySL73wB9jladB7+xBwQuVaUkarD78yATlWZZdBXi0bafaF+AehkmV5XvbKRpaobIuiYErNQk6qY9XPfomlTH4dC4W/2JGE/Nhv+PTFcH646QdOfskfMEIw1twZQ7Xkj7XaeLydh4PAlnGQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB8498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783128b2-5f47-4e43-4233-08ded71bf9e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2026 02:53:48.9358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aXdFyVcmk4c9GwlSWiLHQEDKTRHOEEEgWCHwqTv8OrsUbnUgvhm73rs0xOA5nIanbDyjof534fmj3DCo85p+tQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5886
X-OriginatorOrg: intel.com



> -----Original Message-----
> From: Michael Kelley <mhklinux@outlook.com>
> Sent: Sunday, June 28, 2026 9:30 AM
> To: Du, Fan <fan.du@intel.com>; Michael Kelley <mhklinux@outlook.com>;
> Miao, Jun <jun.miao@intel.com>; m.szyprowski@samsung.com;
> robin.murphy@arm.com
> Cc: iommu@lists.linux.dev; chenhgs@chinatelecom.cn; LKML <linux-
> kernel@vger.kernel.org>
> Subject: RE: [PATCH] swiotlb: eliminate per-map atomic contention on
> used/hiwater tracking
>=20
> From: Du, Fan <fan.du@intel.com> Sent: Saturday, June 27, 2026 4:21 PM
> >
> > > -----Original Message-----
> > > From: Michael Kelley <mhklinux@outlook.com>
> > > Sent: Saturday, June 27, 2026 12:00 AM
> > >
> > > From: Du, Fan <fan.du@intel.com> Sent: Thursday, June 25, 2026 8:12 P=
M
> > > >
> > > > > -----Original Message-----
> > > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > > Sent: Thursday, June 25, 2026 11:54 PM
> > > > >
> > > > > From: Du, Fan <fan.du@intel.com> Sent: Thursday, June 25, 2026 12=
:30
> AM
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Michael Kelley <mhklinux@outlook.com>
> > > > > > > Sent: Tuesday, June 23, 2026 10:35 AM
> > > > > > >
> > > > >
> > > > > [snip]
> > > > >
> > > > > > > > +	pool =3D &mem->defpool;
> > > > > > > > +	for (i =3D 0; i < pool->nareas; i++)
> > > > > > > > +		hiwater +=3D READ_ONCE(pool->areas[i].used_hiwater);
> > > > > > >
> > > > > > > Let's ignore the SWIOTLB_DYNAMIC case for simplicity. The
> approach
> > > > > > > of calculating a separate hiwater mark for each area, and the=
n
> summing
> > > > > > > those per-area hiwater marks, can produce very wrong results.
> > > > > > >
> > > > > > > Consider a 64MiB swiotlb in a system with 8 CPUs. There will =
be 8
> areas,
> > > > > > > each with 8 MiB of space. Suppose the workload putters along
> with mostly
> > > > > > > smallish I/Os, say between 4 KiB and 32 KiB. If each area has=
 16
> I/Os in
> > > > > > > progress, the area hiwater mark might be 256 KiB (16 I/Os
> averaging 16 KiB
> > > > > > > each). Summing across areas produces a hiwater mark of 8 * 25=
6
> KiB =3D 2 MiB.
> > > > > > > But then suppose a 2 MiB I/O comes in. The hiwater mark for t=
he
> area that
> > > > > > > handles that I/O will grow to 2+ MiB. After the first big I/O=
 finishes,
> > > > > > >  another 2 MiB I/O comes in that is handled by a different ar=
ea,
> whose
> > > > > > > hiwater mark also goes to 2+ MiB. Pretty soon all 8 areas hav=
e a
> hiwater
> > > > > > > mark of 2+ MiB, and the total hiwater mark is reported as 16+=
 MiB.
> The
> > > > > > > old algorithm would have reported 4+ MiB, which is accurate. =
With
> > > > > > > higher CPU counts and more areas, the discrepancy can get muc=
h
> worse.
> > > > > > > This is a somewhat contrived example, but the problem is real
> enough
> > > > > > > to make the reported hiwater mark be unreliable.
> > > > > >
> > > > > > You are correct here, I like your way of thinking.
> > > > > >
> > > > > > > I'm sure the contention for the total hiwater mark in the cur=
rent
> code is
> > > > > > > real, but it's in the context of a lot of other CPU work that=
 is being
> because
> > > > > > > of the bounce buffering, including copying lots of data to/fr=
om the
> bounce
> > > > > > > buffers. Is that atomic increment operation a bottleneck even=
 in the
> > > > > > > end-to-end context of doing DMA through swiotlb bounce buffer=
s?
> > > > > >
> > > > > > Practical benchmark show case the highest IO performance for ea=
ch
> TVM spec.
> > > > > > even if a few iperf (4)workers would cause the contention here.
> > > > > > My guts feelings, yes, the real workload probably hit the bottl=
eneck
> here.
> > > > >
> > > > > Just curious -- what is the NIC in the TDX VM? I'm most familiar =
with
> the
> > > > > Hyper-V case, where the NIC is the Hyper-V synthetic NIC. That dr=
iver
> > > > > uses dedicated send and receive buffers that are allocated and
> decrypted
> > > > > when the NIC is configured. Most NIC traffic goes through those b=
uffers
> > > > > instead of the swiotlb, so I probably haven't seen cases where th=
e
> swiotlb
> > > > > is the bottleneck for NIC traffic. I do see the swiotlb as the bo=
ttleneck
> for
> > > > > disk I/O traffic, but the data copying tends to be the gate rathe=
r than
> the
> > > > > allocation and freeing of swiotlb buffers.
> > > > >
> > > > > >
> > > > > > > Another approach to the contention problem would be to have a
> separate
> > > > > > > CONFIG option that is narrower than CONFIG_DEBUG_FS, so that
> the
> > > > > > > computation of the hiwater mark can be dropped entirely in
> production
> > > > > > > environments. Or the setting could be dynamic at runtime via =
a
> > > > > > > static_call, defaulting to not computing the hiwater mark whi=
le still
> > > > > > > allowing a sysadmin to turn it on to see workload usage of th=
e
> swiotlb.
> > > > > >
> > > > > > That's counter-intuitive from my perspective.
> > > > > > With global counters, the observation, which itself impacts the
> performance,
> > > > > > wouldn't be able to tell the practical characterization, that's
> commonly lower than
> > > > > > max performance, in turn breaks the semantics of what's it for.
> > > > >
> > > > > Agreed. If the global counters affect the performance and through=
put
> > > > > significantly, having an accurate hiwater mark loses some of its =
value.
> > > > >
> > > > > >
> > > > > > Even without those global counters, if user wants to know the
> hiwater value,
> > > > > > snapshotting used value(sum of each area as current behavior)
> periodically would
> > > > > > produce meaningful value for workload evaluation.
> > > > >
> > > > > I'm a little skeptical of the value of just summing current usage=
. Doing
> so
> > > > > tends to miss any spikes, and the spikes are the problem. If swio=
tlb
> capacity
> > > >
> > > > That's current design when CONFIG_DEBUG_FS is off, and used as
> swiotlb
> > > > shortage indicator for user.
> > > >
> > > > Statistically that sampled value is approximate to the true value a=
s
> always.
> > >
> > > OK, yes, statistical sampling could work. The kernel queues a work it=
em
> > > that runs periodically to sum current usage across all areas. That su=
m is
> > > compared against the previous sum to calculate a hiwater mark. An
> > > experiment to compare the statistical hiwater mark against the curren=
t
> > > exact calculation would be interesting. I wonder how many samples wou=
ld
> > > be needed, and hence how frequently it would need to run, to get a go=
od
> > > result.
> >
> > Kernel doesn't do that sampling, kernel only report the sum as user spa=
ce
> requested.
> > Take a look at the flow when DEBUG_FS is off, and essentially it works =
as
> vmstat,
> > user set query interval.
>=20
> Agree -- the kernel doesn't do that now. I wasn't clear in my comment tha=
t
> I was envisioning that the kernel *could* be enhanced to do the statistic=
al
> sampling and report the result via sysfs.

OK, thanks for the inputs!

Based on previous discussions, to keep backward compatibility, how about ke=
ep
hiwater as it is, while guarded by dynamic knob(default off), and export us=
ed
memory from sum of per area as current design does, then user can still hav=
e a
chance to track the overall usage w/o visible overhead introduced by global=
 atomic
counter?=20


> >
> > > >
> > > > > is exceeded even for a short spike, you don't just get a performa=
nce
> blip.
> > > > > You get I/O failures, which at least on the disk side tends to be=
 fatal to
> the
> > > > > application doing the I/O. Maybe the networking stack recovers we=
ll
> enough
> > > > > and retries, resulting in just a performance reduction. But I've =
always
> thought
> > > > > of swiotlb exhaustion as a fairly serious problem to be avoided a=
t all
> costs.
> > > > > That's why CoCo VMs allocate so much swiotlb space, even though
> most of
> > > > > it is never used for typical workloads (at least in my experience=
).
> > > >
> > > > That's dynamic SWIOTLB is designed for.
> > > > Only when the IO is so intensive, transient buffer/DMA pool is
> exhausted quickly
> > > > before new shared memory pool is created.
> > >
> > > I don't think dynamic SWIOTLB in its current implementation is very u=
seful
> > > for large CoCo VMs. Exhausting the atomic DMA pool is one problem. Th=
e
> > > dynamic swiotlb also can grow in a max of 4 MiB increments, so if 400=
 MiB
> is
> > > added dynamically, there's a list of 100 entries that must be searche=
d
> > > to find space (and that list is currently searched linearly). Further=
more,
> > > the pre-allocated swiotlb gets 1 area per CPU, which mostly avoids
> contention
> > > on the area spin locks. But a dynamically added 4 MiB pool can have a
> max of
> > > 16 areas because each area must be at least 256 KiB. So there's more =
area
> > > spin lock contention with higher CPUs counts. And that all assumes th=
at
> the
> > > memory allocator can provide a 4 MiB contiguous area for the new pool=
.
> If
> > > the swiotlb needs to grow after there's been memory fragmentation, an
> > > added pool might be limited to 2 MiB or 1 MiB or smaller, with a
> > > corresponding reduction in the area count and increase in area spin l=
ock
> > > contention. Overall, dynamic swiotlb in a big CoCo VM results in comp=
lex
> > > and messy behavior with new failure modes and bottlenecks.
> >
> > Fragmentation indeed undermine the requested allocation size as dynamic
> > swiotlb grows by default 64M .
>=20
> Actually, I don't think the dynamic swiotlb ever grows by 64 MiB, at leas=
t
> not for systems with a 4 KiB page size. Yes, swiotlb_dyn_alloc() requests
> a new pool with size "default_nslabs", which might be 64 MiB. But the
> memory ultimately comes from the buddy allocator, which can provide
> a maximum of 4 MiB (unless MAX_ORDER has been overridden).
> swiotlb_alloc_pool() tries 64 MiB, which fails, so it then tries 32 MiB,
> etc., until it gets down to a size that the buddy allocator can provide.
> The most it will get is 4 MiB, and perhaps less if memory is fragmented.
>=20
> Michael
>=20
> > In production practice, for large TVM, we see admin will reserve
> > majority of needed size, and let dynamic swiotlb works to add additiona=
l
> buffer.
> > Current dynamic switlb doesn't support shrinker to release unused memor=
y
> back
> > to buddy yet.
