Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F80414830F
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 02:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538278; cv=fail; b=PZ9KRXajoP2p2TyHqmSDHxZq2w2Y0iDmd9qaUAC/3ZL8NgNM0EXd+qKBBTwACFQqfTuAtJEso9kEn+1cGCfDd/5uxIuzJCT0FQhH/qcDzPTzNsNHaYlQaLstkYi/wqMVuaVfuH/DuVJVzx89Wi9CMylP8Dk9dYcMXIYX/qX/02M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538278; c=relaxed/simple;
	bh=z1JYhsZLYVKBf99/awvnsY9Sl0v7dQURBCQVIgTXIS0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OFJQP3vLxlIILwP2gx27cNISTgTbKTcoYxMDld7iRn7O0q2ujVSOYMYVmx/2R42B8mSP5RvW1IYS7uB5Cc5f2zQ0VcfAUPR485A1ZmMRd0dDbpxxQh/NsUXE9282kCE89zdMsGt9M1zLEzKHH7yn5GxtYpBjapy4GtmSsIr6b0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXeRlj5M; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXeRlj5M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740538277; x=1772074277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z1JYhsZLYVKBf99/awvnsY9Sl0v7dQURBCQVIgTXIS0=;
  b=PXeRlj5Mo8BT7EvATKe8uyZW26iXdQb+R79LvuUHlYZlA9g3jJ+TI/UH
   WsSdIOpI18aWm1opoFdZ+xkf2a64mpL6TDm9fSi7mZVRy2ivfSXOS5Alc
   iQuzjU+pphe8QrW2Il8n8B0rlMsFD9013iD9QAbr5G5bQwNIklCL9SLmI
   BrikBKW4v0jzgj9QIzEo9RfNiSvG5esklb3kAH3QXNwr61G9WSVp8GTux
   HNak7a3f+Q317OMv96qXvICrKCdQhae0JVMYqcP/wz+gaaIHxnjyxgKGE
   HIo3z0qZi0wJptlKZUFmEwGIH6+f0Tfd+3pY2wgi2rO+37W/qL1DtSbks
   g==;
X-CSE-ConnectionGUID: 41+DlSXzQCCtCqbi5PawuQ==
X-CSE-MsgGUID: oaGRj9NaRlK9hMYoF6iV2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="41502506"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="41502506"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:51:15 -0800
X-CSE-ConnectionGUID: F+o9kkRxTsWRfHrI3Lh5mQ==
X-CSE-MsgGUID: J/zAbvyJSYul4tteDmzaqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116430435"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Feb 2025 18:51:15 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 25 Feb 2025 18:51:14 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 25 Feb 2025 18:51:14 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 18:51:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3xCkT6LrNW13w7VoQKZMqFZbe0n4hK71/28JU6UWSydkofGANlK9ijCBnV5WDY+y8tsovQu9t1TmeJGs+5REP26t+LXGke4hoWqgtMBLBbfvcD9PVUuhTQVig18yA/mcswsG6tk3Cd5mC399B4yGIbMz9fJVMCmtDbY+zJSUkelJ37SUlXUsc7nUKv4pv+O+9Vt0NOSGXEWUexplE0M+m9p01+FW1trmeG7ElakYNzk5LSJiEb8WoXs6Kho+OaLaY5GzvhkGlIzipCLcSIjFJCxD9U51qu3H93PRHCTa2HAcgAjkw9oVVs5V+SyOX+COU0Ur78l7Wg96EOx4wn59g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1JYhsZLYVKBf99/awvnsY9Sl0v7dQURBCQVIgTXIS0=;
 b=HREXqeM8QTxu+FoPZ9ZTVWN4GSt5o833vV4FrP3ZR/HN9+vVOkWQenH3eC/7KXqSCEdxUv3RguMZRN99saxE1gSvB1lPk8bPE+iWzezajOQN3dVvLeBxMp80nRlRe0y+T6Z8m83FXAAKXjq0zc+keBZRxaRM+OeYgABHmecfwcN4VgGgDwMqF2e3PWzN4ahFYZ3hXyYQVduiSKDbCF0RQrAT9eXqRUEhslA79J57RCTY0RyqY/A9wFFvG30H6ou6+qjTaWJN+bA5I2lx3kznnirObI1pBqflIUiOH920met5Fg+EMm9V0VEhHHIF/mmM/nVF32yvoZutg8/gCoo4FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 02:50:58 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 02:50:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	Vasant Hegde <vasant.hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAApFIggAAJnQCAABasoA==
Date: Wed, 26 Feb 2025 02:50:57 +0000
Message-ID: <BN9PR11MB5276B36ED43DF6289EE6C3C38CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <BN9PR11MB527624C1DED16B3C049D13438CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20250226011750.GB5011@ziepe.ca>
In-Reply-To: <20250226011750.GB5011@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5057:EE_
x-ms-office365-filtering-correlation-id: d459e385-a445-4dea-ed50-08dd5610654e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?Ghck/6tr5mRlGS2lZt3V3v7virgmXZ00Ymqy10FrdWkNCrDGeoJ2nYKp1U5j?=
 =?us-ascii?Q?vm7LzJOp2UE7BWmzwfr7BWNwdomAc+Zrp/GaFfzFj7RYKd7+FPuQvWxULPuK?=
 =?us-ascii?Q?bfMtWcL1NLfTs8+nm2F2pjAf1EinEcZ/AQsyWK1PdPVkEj3n3JwAxeL6Y4qq?=
 =?us-ascii?Q?hHSR7WjTGnaK6iEOVwLvMyydZqZQryFSA0ozW6xnQPeLf00IEqsH976QWwyL?=
 =?us-ascii?Q?334E1xfD7WBgwwFftOnA8A1OTmx4xZzjmh29EOtQ0KOYw4hlFUzvaRdIQ7AY?=
 =?us-ascii?Q?kI2m2UUXGxOUDR1ENViiEmnX5BmNGZfyeKaZhKYxfVDbncM935IGAv1bOlmV?=
 =?us-ascii?Q?1a653yx3f+rVoYEccCmuMqzTZOae1w9dMqAhWO7+Q+oXkdWXTXqCy1ZGV1w6?=
 =?us-ascii?Q?Wefz611J/NhGePF9oI0EFMlOseY4J0la0pT6sG0/+mEErcat6xqfXFzaaWm7?=
 =?us-ascii?Q?S3bL/OpkL5WaYf/bEEvuu1Xrc0eSAJEtkrxCZGH7Mfu4oCwco/59FushOW2A?=
 =?us-ascii?Q?p8ueEF0xr9N2rnJIPEexwcy1jA0aMumo2Wk8FfxNA6CWHro+Cr9/xru2igoZ?=
 =?us-ascii?Q?xSeZ04pI4x5WBbg36as/hxX4HT+TVHB4G5tSPVAHSJ2iFwqTHrSnuReuNSqw?=
 =?us-ascii?Q?8Kp5TE5cXXGkJOuoT/2WhVUp9b9kLDnsn1L8iXeHXBkz+qCe4YdeI/ZWuGYZ?=
 =?us-ascii?Q?OLtV2g2Y2cxalfbjlJQtMU834Eg9arX1nUEayWVDkkF1+cGsH1t58lG/lree?=
 =?us-ascii?Q?gW+fSMRssdWyWmM3Ewhj5p95zMRMwoUoX6T+IAvdVpE2Peuot1Yhj3g7X+pb?=
 =?us-ascii?Q?kl0cVC0XD0iI3aXApFonr8VlN5rPE9CNULjiK5ytjU2zuuWhKQ3m19TO8wF7?=
 =?us-ascii?Q?xvaHrpPSoNVy7x21FuNggEFr7Z+923ctkAcR6OPxwnIN6+neTUtPjuwI2ANG?=
 =?us-ascii?Q?BQnf59gNl4an4kbr3dLT1yaVwfJPbt+WnQqrVGuLgsvwT3PdGE36+1wirxzG?=
 =?us-ascii?Q?D8WvtCj+J0g700iE+3Qr4jQxUvhVsjczeCv85zRPBZi0eX1WgHeyr35q+A1e?=
 =?us-ascii?Q?GZKw2J0rM1Y45qmdYyo+OfRUWvkBnkdQgnDSzi69w14iNRDBUHWzhkvROJbO?=
 =?us-ascii?Q?2/4KBJaRS1epePvqzb3ihqmf6avj2fDp7vPcSZ3twD7XEvAnny1noMNtK8JE?=
 =?us-ascii?Q?+OM8mQDMmPgN397dlqr+QIKTGZj5Di2JoCKjYRg9y+EsDC8jhe5KBlYksyP8?=
 =?us-ascii?Q?KJ/XNsS7MsvqkDHn36RIt/RMXMycXebvegw7iGizaFER0lzRjaI+8PVeRzKm?=
 =?us-ascii?Q?DzFCgIs7sgKb3qEuevRM7Jgri6Jc9IcIHOyj+HBKsdn6UGrsdDnt7vbGPDYz?=
 =?us-ascii?Q?9YfjHjzMk0DCc2yPK7BmDYLOSGuufBdH0iqIbVgkNNWaWQGYiDKoOFxD6R+n?=
 =?us-ascii?Q?5GQHsIjswVSm8Hj3VOUvnMWPFDGvy22q?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ha5qGv0/padlaZqEQVw/rT1b7vz4BqPSGULxizNBVIfVL5vPfloYvwJJyhe/?=
 =?us-ascii?Q?vQvKPx0wW5lIROYWhoF+BCeMJCyE/FH3EwEeyQFk42cee28cUY+joecm457D?=
 =?us-ascii?Q?tpY1HMXWm7ZqNtcj0Q0y7L9nXSgx+nDWUGiSJmFY9lGwzIlyEBAXJAjNFKrg?=
 =?us-ascii?Q?eswUQZEzA6alEq1WuMJ1i2NrjkoRK5oThbVxIOaEtYTSzygOobP3mU8uFWa6?=
 =?us-ascii?Q?Q31Ya2AoCvuFXtHiCWvtOstyMQQJSPfjtTQJxbLRsv/bEFAIU/6GsmFPdZI1?=
 =?us-ascii?Q?S9vllLZ39OXs/9QoNpN2upV7x2AWp9KqCH9sb7LX1U7Vh1dGlTEWF25AG82T?=
 =?us-ascii?Q?HbrCyEM5nVWDReE0/XhIrcN0ajMTha83YkEci7ZuX0pr97m4GMLbhNCEitfQ?=
 =?us-ascii?Q?mXNfGo8naIaTMihF4P4WvDhlcwhFcdYmN4CDcJXUQtm3EcbVC2F19YJYhmP6?=
 =?us-ascii?Q?LQrqD1+U5iEhXp6XplqgpA0t0hBko8Nin+GGgxPExHKdbnAH7aElmiNRF3z5?=
 =?us-ascii?Q?8CAlSiVYr2kdfQVuBLyMFk7RaO5id1CNmFF9kArvDDPtJDyGQsIgcYdBFBLp?=
 =?us-ascii?Q?U3HmSfPUiVQ11aUgqQn0iHKtsNaKoD3Ma0/gnfsBkTbI8MmxBWfuspg5kChj?=
 =?us-ascii?Q?tJDnVKyhr2y9AtdxJL7/MTjBTQ5utqROhGk2vqNeqRf89rRCHbnVV7ZNjwwm?=
 =?us-ascii?Q?4wgQAkX3tCEC9IvzcVw4P0I3QfPiSYM/sbVj3oRFUiHDGUYFptU6gVO8n56h?=
 =?us-ascii?Q?9MVWeOUE6F4WVgGPe376MGV77ie1maSIJKMS0ojKHzzY0dxCxFa5Pl05UMTQ?=
 =?us-ascii?Q?k5ri+Apck4siteQPr9F0gcgj7WC+rfBles/q7nJY5+jGhU+VXnZ+OU8MGzqn?=
 =?us-ascii?Q?/9DnB//xlvIyCVtIUyD7141uMLQDlW7YMP3iMg6LJssmyvoOJSKQX2rDxns6?=
 =?us-ascii?Q?37upftdGR5+P2iwq/uQ5CskyYQN0St9bywOnnx/rjO6mPC2rUi3Q0vw0SILx?=
 =?us-ascii?Q?ipGagMC/WwSqBnlH8qBMyyyuEL/FHvOBDkJjTwPeWOuh49Qbb0+kSYPpqm3E?=
 =?us-ascii?Q?FgaN91637KZCWLJt9AHZ6jXAftomPSFR6c/qzVdxKd8kckPmCOv+lSjY4EJB?=
 =?us-ascii?Q?MUHdDwOiRze1yMPcghxZlkSoepBYeenxHzTtpoVz/39k0ZFfLYndd+gl782w?=
 =?us-ascii?Q?IJdmZeaHmnnKXpduWZzzs0W20RTxkmB6BjDmMs2b92tL9OCoVHf/52G8kwQ5?=
 =?us-ascii?Q?8HncGucDOJZ5KftRYHXXBPp627hmCypjJofz4A8DXhTZRXB/GETlhHrNdA0c?=
 =?us-ascii?Q?1Y4uzux/hMVTn3AMoR5ddjKrDdp6x7w/9IILnxL2g+TfPO42DonCTg7TRcJA?=
 =?us-ascii?Q?bw9IcdttDr8y3kgZUfxKul+y5k1Mu8+yfEfVlmTCWnUfgaeagQotMII/vxyv?=
 =?us-ascii?Q?ZttR0ZMC7DgA2y7cjDt+kCKZ5r5m9+ww3lEQUmdLKdsjqxh2RRSp9RY0DimA?=
 =?us-ascii?Q?2OXdKUHqnTektl+a4iXXIIcLQtVD4ElEWwjSSxbMr1TmHvlgHU0Oa+30FfI4?=
 =?us-ascii?Q?CFbuLrx0Zc0JUH5xzA5Pk5FSX74U61uCWlxLPEz4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d459e385-a445-4dea-ed50-08dd5610654e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 02:50:57.1231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9pS30S2/+cSXl0JlhPHOttLukOapCVCHmyNXju9vwUM5jZ/h8Cn1Zh+rWL3CJtASrLinSA+c0tfS0GIjd2M9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5057
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, February 26, 2025 9:18 AM
>=20
> On Wed, Feb 26, 2025 at 01:12:38AM +0000, Tian, Kevin wrote:
> > > I see #2 and #4 clearly in the SMM spec. Is #3 a special case of #2 (=
a
> > > STE with a S2 and S1DSS bypass)?
> > >
> > > I think AMD is doing #3 from the docs.
> >
> > my reading of AMD spec was #2. also backed by Vasant's words:
> >
> > "
> > With Secure ATS, for ATS requests IOMMU return GPA to device instead of
> SPA.
> > When receiving Translated DMA from a device the IOMMU performs in-line
> > GPA to SPA translation.
> > "
>=20
> Maybe it is both 2 and 3 if the GCR3 PASID 0 is setup to not translate
> but do identity?

yes but conceptually it's still more a #2 thing from host p.o.v. The host
still sees a nested configuration no matter how the guest configures
each GCR3 entry.

>=20
> > If above understanding is true, my preference is to support a sats flag
> > in domain alloc (nested_parent only and PCI/CXL.io only, as the start).=
 For
> > AMD it turns on the sats bit in the DTE. for Intel/ARM the permission
> > structure is created and updated according to the map/unmap calls
> > on the parent S2.
>=20
> They are functionally different things, and have different
> requirements on the PCI topologies supported (eg CXL.cache vs no
> CXL.cache)
>=20
> I think they need to be different flags
>=20

Not exactly. They are functionally different but serving the same purpose
to the user. From user p.o.v. it's sufficient to have a general flag for sa=
ts
when allocating a domain. The underlying driver decides whether such
flag is supported based on the domain type and the associated device,
just like checks on other existing flags.

If necessary the driver could report certain restrictions about sats to the
user via GET_HW_INFO.
