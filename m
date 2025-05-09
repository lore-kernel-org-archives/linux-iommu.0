Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CC9221D94
	for <iommu@lists.linux.dev>; Fri,  9 May 2025 11:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746790792; cv=fail; b=DS01TAsw/wyxwU1Y2F1JbyC4r+gyeAJJfsK15kkQnyJvKkjPdQhcyiIRUFVT89+Uybd6y/c7x8yaFF8kr2q1YLqclytHuFJ3sfKQp+gXX0OzQAz4/7KsglPcBAUikTH7Ir1pnEzz4j1Yy1CYV/S6IhhV7zK6kP+qtDst/VhWO/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746790792; c=relaxed/simple;
	bh=H7NncF/W2HJwkLpIUzCknKc5wDqKd7zKmAPZVX4DEj0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rY2NYW0bb35xGLI3WatkjrHbGn0d2D9JtT+K7SrPt+7VP2+q59ST1H0U9wQxc/RucIZ6BgT2ZpaxT2idPrrPfCmZG4FSbES6W76pPxeg6USp84PU/KmZojuXvUx2Gil/P2xYyfZ4PLZRX1szZxjPxosWgu0U6aAQYJc+KzPiRVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jmJ6CUGq; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jmJ6CUGq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746790790; x=1778326790;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=H7NncF/W2HJwkLpIUzCknKc5wDqKd7zKmAPZVX4DEj0=;
  b=jmJ6CUGqBBxjiWT0tuficxSJxqFSt336Q2RjFM/IF397iCj/JJ9PglpC
   aBIKz81I2eDGSVu4smBUfkEzVRJbpzOFrKJwUTOgxaHvWTJfSti/s3ScD
   d5LrKaDyyW00y4EFD9a09FugeuNlfCagaUDmYjkiepcM7V6q46JkI7etX
   VLqZNHOMd//W7RR1zuCA6KW0MKm2O/M1Qppn4ndbInd5iNJb80flRA6/y
   dnATTwf1bXJ5ObHUzB0adhy9vxPpOtQXLQVsJ1i2V862gMcN9ceaxdgal
   yK5wYEZUnPDJqAEtTop1kk3F0eXJGKrKCUmEJ/gfQwnRClXse+nJPS35x
   Q==;
X-CSE-ConnectionGUID: TlTW9rGJQlWGR6ZGiI8ULg==
X-CSE-MsgGUID: CccZzHDPQQKtuQv3ejTSNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="48773281"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="48773281"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 04:39:48 -0700
X-CSE-ConnectionGUID: uVq7jevfRxiG6ZkVkA5ZBg==
X-CSE-MsgGUID: 1D8hEaKQTWCA9S0yK66QcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136474463"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 04:39:48 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 04:39:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 04:39:47 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 04:39:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6clAShxDawZm5dR/KHX1EpKDlYAXRcMm12afkM50VjBU8ypb+HmhUa34jTxHdCsR0ry8AnLrd/oorF3PGtPo4OPUkY+S5H1Gmx285ym3GVSq3lgelIU6RQLN24zX1r2CXpr7+LjDOSPJNw41UdTh5mXwaSXESagcylUXqjL1BTqp3/2/ffGXmIRAQ7+WueUIF8ZzG7tGa41iWkbloR5vWcwLOGHzG73syqZlCOpHGpDnmSLAsynry5BgcCnxhewwVqA0KIl0KWjM48Cnhg85gk3z68wr2AsdRHIYLAtrdc6p5350jiEBsoeC/aFwCWav2dpuRUbtT76vOeWB0v4qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/z58JXmcIFAottJ2Kn2ro9r0xg/SJMfYGeqvHW5wp0g=;
 b=ZKJTbeOxj72ALYS/eSQnzQgbwpUoyWsj+yX+Vnin1P8zvTC+bDMX4pN41n5DV7caogYLrfdQGLL4Qr3nW/jpNOIRv+LvaAD8loiQ8yiXXPl0PYWS21HKT5udvlABKU2ZvUFj0vuWvWddbZTZqT4ymIEupC5cUoOKOHlqWgWra3+0mG4v3boXcn6czzSeKfVD4i75c3qwMSbVAzp26riAVmVvFz6536dHVv+qE4bzQygVJBu915OlhedCf8EQshNfZhrR9jpLjRojo/L4dBJtYeinlxvfJu/9HKM6ZqSQUU+rE1AcONuFeeU7e1/aM3MVfefJ1Xorlvjhryyp9Z4MwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 LV3PR11MB8458.namprd11.prod.outlook.com (2603:10b6:408:1bb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Fri, 9 May
 2025 11:39:16 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%7]) with mapi id 15.20.8678.025; Fri, 9 May 2025
 11:39:16 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, "jroedel@suse.de" <jroedel@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v1 1/3] iommu/vt-d: Eliminate pci_physfn() in
 dmar_find_matched_satc_unit()
Thread-Topic: [PATCH v1 1/3] iommu/vt-d: Eliminate pci_physfn() in
 dmar_find_matched_satc_unit()
Thread-Index: AQHbwKlWrEBKPcjlWEmyyFYMUSaQVrPKBJOAgAAg50A=
Date: Fri, 9 May 2025 11:39:16 +0000
Message-ID: <DS0PR11MB637371E03056B47148533BDDDC8AA@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20250509140021.4029303-1-wei.w.wang@intel.com>
 <20250509140021.4029303-2-wei.w.wang@intel.com>
 <19e39263-e408-4867-a080-d5f187095159@intel.com>
In-Reply-To: <19e39263-e408-4867-a080-d5f187095159@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|LV3PR11MB8458:EE_
x-ms-office365-filtering-correlation-id: a2c4b73e-92c4-47f1-3444-08dd8eee2142
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?eAK+aXYB97AkIeJtdUKHt8oxlfqOjtxOQAM26CItLMKE4TCTKRrxSv+GCYLY?=
 =?us-ascii?Q?PoYUB1BsY7HLuA+dMEiMAEesVrdKJDuYCWWxhgHEKXe1l+D0IqMLQpxCUSNF?=
 =?us-ascii?Q?kCs8Dlnq3U5SKEWZg0YDMzDUe4DYhzGj4xZRX08kzq8OaUiLFOdVBv4YV9Ii?=
 =?us-ascii?Q?Ln43VN9FBWLhFTf89qweZZ9svy12wRLh9Pco8A0Q/r0bMfZO8FXN2yPN0iHQ?=
 =?us-ascii?Q?fXDERtQ5oF6I6/SajFU05pxzG0rGepkNReVsA4nCs2k7n4Lw9UlSYjWwV8Gh?=
 =?us-ascii?Q?mge61E8AsYUTpK4ESjrLJXSYJT+5uAVlpDxL+Em2nAAh+s9lhRUOQiDpwTCx?=
 =?us-ascii?Q?ZcNxGGU+j46qXXewoQkHz1XHs8tfthD0SonbpcRp5qiILYkxv3zBM2ViexGa?=
 =?us-ascii?Q?c/NozCpvxV996hzGA2ajNPHzSDPEX1nQ9ShkysMyH7ZtacIgSmrlw6JmjR/b?=
 =?us-ascii?Q?/3O6+2JRaurIOupvE20zb/NfkiXeIXiv4xZ7CZlde5sj9kugmGmSyH+qgDUc?=
 =?us-ascii?Q?MV4ofPxtY7It1X7ZJPgp6BjzHL4rrb602ssO1ZXoCLxpQraNHZXElmC0Wv0M?=
 =?us-ascii?Q?+PmIw2/g3Qmu9cOL+2pWQ5D9ZcUsUGzBG8T7u5FPWdmgnvrMw6dVVt9lLeWx?=
 =?us-ascii?Q?x5o3DrfTZnz8XTnq/6CHFf0pSZoFLF/nqRsP2ZG//uR4lRmN7T9M8xjwtoNd?=
 =?us-ascii?Q?fS4Rvt9gIuGbUoaGVh33uMVrV9n9hZnqP4C6tcsge1n2Z+/kSAGGhVaX/ORu?=
 =?us-ascii?Q?y6V5QrDKG2TKm3ECYWWd5XVxThDLlFqrru0OSKHrLMdKvClyXkpsuHbQavEC?=
 =?us-ascii?Q?bylSsGqeDA4vYoZmI1MpFzAzu2n4cX326zhknZxH6x7E9ffvvHUzW9A8f5yP?=
 =?us-ascii?Q?1S9O2amychXKspc4jVKRQKTIk7DGh8kMaZeXAO4I1lvbvOF1FVP+Ba2KBi/e?=
 =?us-ascii?Q?8A/efp/DOLVq966skeublb9qmVRgx4L3/QhjKuRqOmGmoo0UmFaI3bSF1Haw?=
 =?us-ascii?Q?qiKW63D/lOi5xADy+X7fNumUh0PqPfnRKsmDLjPcjEKcc3wgBZLPKQ+fmU0G?=
 =?us-ascii?Q?z6vCFaDO5uQsymtXFPqsojgMsAplvfsZ/D+WgPtw8uxuza54wtIeAWeEt5r2?=
 =?us-ascii?Q?Xj/+Q/DtdIFkkPFssyfl67mpGsvei32yhcA0eepJctHXF6tnNpgKw5akvHmI?=
 =?us-ascii?Q?4mw5wpI3lwVaN7mzOUO3YsEs+/ukgk+GK/+R+n1xKvgF8GDiBhrg8z4WDjDX?=
 =?us-ascii?Q?F5zNy6Qy4uldtp9VjBokYR6EybVGFkgr1G1SC3Mv5z89AQu73z9XJiaPvWN0?=
 =?us-ascii?Q?qnA6awhT+ChHUmCaH6qn7ukvKlj0q5c0FJHd0KL/ChbQBH4xWnKQuFx7nbYk?=
 =?us-ascii?Q?H743zKDyQtkuwFrlOd/OvBUtJmXrlojzLL9cqUHZRFRVZPJ4ZLSRG/KB5h9V?=
 =?us-ascii?Q?f5TqDUv3+411ju6Sa9bicOS6yQvTwY8qptCCgedaHUwRMMDxsDADz+U/B6nV?=
 =?us-ascii?Q?ohZ58zY+iQlfAa8=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?69pAR14UAnPNF6Sotr7Dz4ExX+Cwkc4O3GdBg9/jiMrurRuGz5sXcFixPljc?=
 =?us-ascii?Q?H+DfJDpN4imUj5d8S/kEDMf3ruEpf6LyglsIlXTvuc3nHinTSLMUlhiBTzNY?=
 =?us-ascii?Q?ZVigBc6TJD+elVf4wz0EEtJN8IocBAqm0BCbcD+LKrC/uVjw6Flozyr5jBni?=
 =?us-ascii?Q?RYXJwlF0GiAu15Z2lYne2y7pIJu5HXp9o14BBNm1OMUqgwXS9ZDHbIY+09Dd?=
 =?us-ascii?Q?vqiN4Vs2BTbhFm/TXT84huPYK3ZJMvKHvTRFs8JKRcUdEdyXsatyIQ2o0l5p?=
 =?us-ascii?Q?eMssbnAbV6Ks5nYhXfTvLGQdhFufWsWNxQUlJQaT7vpSiDgdvv/D3sTh6ajv?=
 =?us-ascii?Q?q34CjkBE5D3caM0BsMpdJbBoEAsPMmWLq3MMMrqtBTWWSrA/M5Ul2LXQATGF?=
 =?us-ascii?Q?HhcmlyCWXMEYGNbRD4OR5/B33vUow98a8Sikr0Wjmgj5/yRdCL9ELL8wAuaD?=
 =?us-ascii?Q?pBscLTubjeuhyMPrKMBJCTISDB6SgTNSDMAU7dz48PqD1a5vvFQyk3G3uKrv?=
 =?us-ascii?Q?CSJ3ao4GiYR7b2jzULzex81ciRtnuO1x+GveZY+rjHFadw7quYW4dEKhF40e?=
 =?us-ascii?Q?B9WdMLUbk+qUcx/kNeP9GQkMb+4ZFVZXFrway15yC04Hx8m/KPX+9kYhCKH/?=
 =?us-ascii?Q?FN1Sc7UaunUehmbRyw4egZjz14+QUyMoFsI5dwc0KCfEHO7ZpZeO+5IJt3n0?=
 =?us-ascii?Q?B8RERe90poinMIAibrW4qjHNxY/t0akIPID/HDYOGuMoZDJJcf0edrLzacQB?=
 =?us-ascii?Q?gt7wIPYSSlYdKYmVjI2jCAZYX5aduZ/0uxrSPae4MaJAdCTDvE/J/7Rkc5hx?=
 =?us-ascii?Q?858iEjCJ1wTiRYTZiD91xePfBpMGzu9lSHsZg8p9+yzgrDiC+v1ZOJ1tS1/Z?=
 =?us-ascii?Q?FdRAdopDgEccT+1FV9C3IFMjO6UImWwEALFlHcgCLW9lUndLiNWn8Y3h+zZs?=
 =?us-ascii?Q?xdELbhZuoxt1Gquz1bkWNNNnFBQtbQE84dXLjh9d+J7x+Qp6gkZ3LL8a595M?=
 =?us-ascii?Q?giYTvgVlU5qO8jaoewZIS9TRr9XfBIX5Ckjmm7vGtSD/YA1ln5xWYF1hUZxd?=
 =?us-ascii?Q?+urUn5N47X23yzx+Q9RZRNC9emiLu25hk5gKeW8+1V2DYjhkVqTB60yIjghu?=
 =?us-ascii?Q?d4d6jQUWQW9zyc22YDuUPhECUh8NgoHzFJoHDfWsBiLdT/mETbpduRuvB5Dk?=
 =?us-ascii?Q?td9VPIqBlmNqWYHRi7anlCZIk6g4DjTYw6QYu1tDDZHk+kA/HNSqk89AfdvN?=
 =?us-ascii?Q?rvPxjEUgPIu5ZOWygiMR31w2AGsd0TXjT+J0UFK73mTrBZFHO2RuKz6YZWu5?=
 =?us-ascii?Q?3bHGUPKGhhQ5/1h4+GTL46NnI0FKMwHNi2yGDz0X8eNV8UcKoq7/sCXgAsL3?=
 =?us-ascii?Q?wPJJ0vtwgDy0xwtdpay7fn3SqUw5RBxykTrufXSb6qgBqACdiLmPqoI+NlBz?=
 =?us-ascii?Q?5FKk/YvPgaypOw0R3yVDjA0Ui1ix6dYhamHP+TAePP22dnXdg2i/2LbLLInc?=
 =?us-ascii?Q?DqF/4gjjHJ9TAmiLCtoZWQr/gsuW3FwHWiur0BpKO+deUHnl/wbwVfActCIV?=
 =?us-ascii?Q?IcVou1SfviqwNEMJHJzoAb8jTbWpQjL0Uj1iAfPJ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c4b73e-92c4-47f1-3444-08dd8eee2142
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 11:39:16.7346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Wlq9n3XRHqpt35Aew9T5d1NRVxXfvTreksE61N6aI/l+yS1zbW/AZ9bXqzPx2WEj2yW7gBkg62tgEjJ83OMNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8458
X-OriginatorOrg: intel.com

On Friday, May 9, 2025 5:16 PM, Liu, Yi L wrote:
> On 2025/5/9 22:00, Wei Wang wrote:
> > The function dmar_find_matched_satc_unit() contains a duplicate call
> > to pci_physfn(). This call is unnecessary as pci_physfn() has already
> > been invoked by the caller. Removing the redundant call simplifies the
> > code and improves efficiency a bit.
> >
> > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index cb0b993bebb4..d8aa71305509 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -2744,7 +2744,6 @@ static struct dmar_satc_unit
> *dmar_find_matched_satc_unit(struct pci_dev *dev)
> >   	struct device *tmp;
> >   	int i;
> >
> > -	dev =3D pci_physfn(dev);
>=20
> better have a comment to highlight the input dev should be PF. also, can =
add a
> WARN_ON(dev->is_virtfn);

How about changing the input to "struct pci_dev *pf_pdev " (like the one us=
ed
in device_lookup_iommu())?
This way, we probably don't need extra comments, and WARN_ON() might not be
necessary IMHO, as this is a static function with only one caller currently=
 (already
clear that the input is a pf_dev)

