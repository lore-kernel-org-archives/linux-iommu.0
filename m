Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6588B1EB18D
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 08:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740039756; cv=fail; b=UMlFSen2mIlUtw1S99TiciwGYSParWZKKUIz2I2zWdF0DnRdGC7cGtLWmYkb+tCW3Lq+e115cscZDqQCcGNDqMpADwLy4CrjA4ZMmGuWjGIl6NcGsaU58evAGocd/2jojxFU+tymVTuvB0l0lP+QlRQ5vdcMLgkj4Ui5h1RTWyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740039756; c=relaxed/simple;
	bh=Flj6IMYQCShpEsyraff7hs8Hte1h7xRdjFSpaiVA7HQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CuyYgosYGRdySKh89O7TuhcEgFtCYVkdOk2AwC6orQF3Rl0+TWMYMW0GA4xaXeRe9RkcxcckTPVQ4AOvvSdzW56l1rrL10rK+m8PYQCSXNVtHGOpcHpivt9tOKgsa7XCqi1VhaVG621te83sCNE3K4sZL62NEmxqGOs8op6jSK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROpYCoRl; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROpYCoRl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740039755; x=1771575755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Flj6IMYQCShpEsyraff7hs8Hte1h7xRdjFSpaiVA7HQ=;
  b=ROpYCoRl5CK7m1VPaJpHChyTfllFC+Ef8JbVJD3KNlGgaE5y0kXoWivI
   M0lzuz744qMc3QrC9mkn6mZHGJcTY2QAu76geTGOgmn2t5SbnAAzo8doN
   VjsPhMOma8N/skRsPZhOIu4yMcg7CIt+yC3eES/zAbLkNQmUOFW904zjU
   cEBcHSO/s0x8Z/BDCUUwfeo9tXkQHcGmPsOIcxtsWvcffDItyyZfNBOIV
   GJy2VrQ57N34Afa2+DSFwdmVvIB8s3ko+wY3mXF8EtiXJMH4FcfJmXAtT
   UiId4bLa84+Dl92p1FyM3FJ9DVWEdxz5+5WaC8TYcrAkxlQRCPpkVULOz
   A==;
X-CSE-ConnectionGUID: 9u/lJ4kvSEWr5UWhcPgHaA==
X-CSE-MsgGUID: G4WNZue7RcyhkkFZSA4EGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40038962"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40038962"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 00:22:32 -0800
X-CSE-ConnectionGUID: 91Zqlx5QR0y41zQtlI72DA==
X-CSE-MsgGUID: elTDYU/aSGKum+cwPTOVew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="115641782"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Feb 2025 00:22:29 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 20 Feb 2025 00:22:28 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 00:22:28 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 00:22:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MXOFr7eVUQu9pKe5NWRXLmWNhFkSwPeYGg+G8YLsSAgmck2Pxt3bMrXTX0pFo+qzipUoRQkyYuLSgxTW/fk3FvublnPGE0GwS25FCV+rS707vFRlnqPg2IMd2X4oKjmfjld7XCRYtdTHqwQE/rWI9XnlsL2UGf6GTDbjl+KHSlAYbxGBBeDNv80xLl0jbjsqEOQD6e0fHr5SMBdvFV2eJlzCaN+ezDA2AKl8czajDlRKilb/4WMn1qArHx6Ey6wXISVmFBaNo/yNvAX2cl9x0VZZ93sBQlZW6DxV+XcnIXsGiRI2xh9njhNndVrMawa5OQDimq8eUJcOq9kJbvChJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Flj6IMYQCShpEsyraff7hs8Hte1h7xRdjFSpaiVA7HQ=;
 b=qT3NvKNWRF7/w/a5P8BoDXP8PleldgYM2lryLsJ9rHr6bI3nyGqsDEzDDy7U/duzBFOcLHuXeJd4bcr7merLcNUQhdaRVMRuV+XFJimgMlGPKn9w+DTtNm2f/KcsYgGeZi081pInB2oCAgatbJxXS+IUcow98GPzIPWpopK3EG+ZtEy4/cTg5wZ/ljPByANI1+OruB5Xgv61yODUC21azKPGAUbfUkwet1x5dlBL3N52gPK2qhzg8yLetuH83ryWnziwxWY/6O7mdzQmNrEVnMn+1tymTFeiGTulae6faBWL09VRqfr+lU5qqMS2l9iDrJAgXGjRcLX6+OgYBk51KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB7861.namprd11.prod.outlook.com (2603:10b6:208:3de::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 08:21:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.016; Thu, 20 Feb 2025
 08:21:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH 1/5] iommu: Make @handle mandatory in
 iommu_{attach|replace}_group_handle()
Thread-Topic: [PATCH 1/5] iommu: Make @handle mandatory in
 iommu_{attach|replace}_group_handle()
Thread-Index: AQHbfRQpRtGHoaRv/EmUwIx23khEUbNP5rzw
Date: Thu, 20 Feb 2025 08:21:53 +0000
Message-ID: <BN9PR11MB52765C3612ACDE4D0496E0E78CC42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-2-yi.l.liu@intel.com>
In-Reply-To: <20250212060540.261436-2-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB7861:EE_
x-ms-office365-filtering-correlation-id: 61459e35-8091-4c7c-e4ec-08dd5187a202
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?s+klpOOVJSTgsTsvjVuMJIZpLul/5UespipFCWp47wPTSFNOghbCAWGm53A8?=
 =?us-ascii?Q?5Y82TU9Cy6oiHu3Zo+0U6nrOvOmqYhyzxeifGE2NyzXV0YLAEZAdXx91Yeph?=
 =?us-ascii?Q?JkEfQGu1b1Ke0AwWMZjjLuQX312UlHib/lFTRvFOc94llUHjvdPPjuMc1PuE?=
 =?us-ascii?Q?VihizvxKIRfYnLWS0lHAxWrN9X9ylxkHweHD+MLFV7lhsaW2eMJBcjQxEWY2?=
 =?us-ascii?Q?gAZ2WirvqtNNvo4epvsDWFc3zohCBE2JlsxFEsJYrS9AIjNOK3mpx6N+wn5C?=
 =?us-ascii?Q?dMT+HtcAeXTvl6lD+ED4HsyvNpNDvnEDGDGBywun7meihw4HEdUmGqZ9Osod?=
 =?us-ascii?Q?z2BDKW+nP9fZJw7vEPoHdYhqbX+0YydVqF0JiSpcy0UsJAkJFTKW7LB42zth?=
 =?us-ascii?Q?mnX984TgDA5i90CrnrYcihhAh+eEUcqCqTzVWs0QmBadCsgRnrNMK4b5f7UO?=
 =?us-ascii?Q?ZV59jozHoPHriq2IrmyhECZh2dS3RS9cXx/5WXjEXwebx95lE5F226SlbDjG?=
 =?us-ascii?Q?QOuZHDXGNquQypGW8l4WlnE1Bnik4VRQhJ/jI9kNjAqABdep51wGuHwIcxzt?=
 =?us-ascii?Q?z6TnDVOa30Qh7pCFIRuf8EWZkgr9aA9TPrDZnxol7O5TBPx1wnkLJdlR5Yjc?=
 =?us-ascii?Q?0U2jzbhuiiVNnmhx/xhQ+06u35UiPvcWhVawRrbhOjZfCPVTgiZ0HlNszxPq?=
 =?us-ascii?Q?y2tM4ZuAHK/yKs8Z/Aw3jVwSU//d3OiUvr6hmH9JeC9V+LNnYwYm/3SkiGR9?=
 =?us-ascii?Q?HJF+rmLsPvkZmp3d697DmRS93z1YUDPFxLmjzA54AzYXm17my8PFoKjLUN6X?=
 =?us-ascii?Q?DB+T2cGISRKTGkV3fMh+MZh2s0eNHERs9ybKw0d/1z55dfBKvB/ZJflGsZ+e?=
 =?us-ascii?Q?YpLet6xf5l1sEZAF+68l1eqCkdxQh5NRIDSL5yGsElrbT74VAkbZ7ecqe7GL?=
 =?us-ascii?Q?YIyLL64LBp/BQAAK6Dy1x4A6Y6sjcxMlSKMgMatUrFjWUd09a1sFDZGTjnrF?=
 =?us-ascii?Q?LK8rYwKASbVXkcw8Ic3mZCJs30i7/mCV+pcPNPE5Bw9Dawmm3cq2VAQCwccq?=
 =?us-ascii?Q?Sr5tnMmG3zMCOXM4gK6ljxYCUKi8ePzxdNivtlu1kTG7WV/JGtOrUr9BrXGF?=
 =?us-ascii?Q?vY5ntIi8FsjgnspZSoyI4aQPmYvc2ttyy3UpxTSSZqk0YW4RY20Uvc0d/szo?=
 =?us-ascii?Q?uq/QEK9+8mKOJ8+6A1/9T0LR0tj18HWnz/Dm+YEYenGV0+ypBtA3lBE/vqRq?=
 =?us-ascii?Q?Qu2DiiAyKMrjUDKoQV/ivhEYLawsbg+9pX3noup/hdAMp3rF6/xeuPRJ0hwI?=
 =?us-ascii?Q?7kqS7uVyT40ORwqCSxjEGaDeQEIql4eKl+qHVmqylNPczbN0/3Jw21/xwCom?=
 =?us-ascii?Q?7aVZ+nZ+/RcGqkq55lulrA3izHynY+yXwWuum7ilB0HjJSSe1Bp92gn9WTEY?=
 =?us-ascii?Q?CLfQ3n05P4pFVogQCzoRRCVZxVFF+eh1?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZDranI8dot4M3OGbyHj7d0WDtS289aIRDLsosAwZrjKg56t42itcTr8rS4EY?=
 =?us-ascii?Q?sv//u8nn7rgRNoDXRaNO0BhKiWzYHHcESfg0Itlpgfa3gtg6AyCzAkqw6PfA?=
 =?us-ascii?Q?t5G9DTgcENgEAP4bIQG0R6Q5+s5icgxGIO4udrzmgay3eB+AUDmUSWAWcNog?=
 =?us-ascii?Q?JA8HN0bb3QV7Tj8HseJUNesUHgPWojz/Vl0rLsx4l8FJlmTjUe0f87P2bb9U?=
 =?us-ascii?Q?TOArqcoDLVM5+54g7hRVVjNDwapiowE6P+EHkek6iqp496NQ/NpPHwrQhJbv?=
 =?us-ascii?Q?zIGJjVTYy70KFkUSwjM17aID5tW7WObIzn3YjfcVSiEDwkGY9wdfU6hagweG?=
 =?us-ascii?Q?W4r2NibBHGIBItg+SufL8rp0649iaR7xWfM57m1HLZVpfMLKLCB+gAkapNYq?=
 =?us-ascii?Q?+mGIlH0Qf037sGd0ZgAQfTf7FC9OMabXuy7wixs8uYpf7bPMYKj8hu1yRJOs?=
 =?us-ascii?Q?mlafjUlNo45PWfESf+OJQs18+romcAMNStjrwF+Bwbm2Y9IGq8RixAj42CXt?=
 =?us-ascii?Q?aEu8nlV6p97m9viYrMcB88qK31iNUIEeRZm8hXjPPZ8SlC/gCRxp4Gc7w0PP?=
 =?us-ascii?Q?EMLDpWsV+aUj8RO1+uvUXQUbsxg1SKkFCINwFW6M7a2jHF6FPu2zBsjL+7YJ?=
 =?us-ascii?Q?Y6lY55ZQfn9rjd25fKl4BG4vpFqBex2WmMiPrbx9O2s7T8GfU1W9YO+SMQB2?=
 =?us-ascii?Q?t+Y7+xrhJ6CzwSe+aMf9pnc3P950rVCSsScp3uUxlZzN8mxr6Z1aIVva8+fV?=
 =?us-ascii?Q?CXUIyYIJo64o4uc1J2Xm6HOwTwykRvk93N5MzjtpQLyCjCgzR51zjO2sOC0W?=
 =?us-ascii?Q?885Mnk6GDcNVvAvk0WvPrvKYjGJ1yzmU69wQKXmg5tTLZtnnnU7cZPOqRE+t?=
 =?us-ascii?Q?kKqfIHyj2dvSIHR5vN6Z2xwjnzmSmBb60cIDes+NUzTCNU15P0BzES5AK8CQ?=
 =?us-ascii?Q?jf89hTVatMZ7EzYEO9h4sQ97Invr5kR7XX+81gOiPSycHlbRuyiBFzYp0a1p?=
 =?us-ascii?Q?zsFND+MHnvsIoE3GzvnhrQxKruTQc3gnlh+EArtlOHKmbAQiaendW8u8FesR?=
 =?us-ascii?Q?OmgIcEEdSp2jPgPVZeA4JFiF3MMAWPGwxbbURQekhsbWnW8SQIjL1+83TtEg?=
 =?us-ascii?Q?0QCfHVr7IhsMZ879hyAu5bV3UZmzCOSsm+AGCdiOCF6R60i9eb9AyKN/vH2R?=
 =?us-ascii?Q?dxIG7fTdBJdsIzcXmLLkPEtkP3i2gWr214rRNztVTB4xnewYaOVE9B0yi3A6?=
 =?us-ascii?Q?EJKEVDMJ5o0Tv8zfw+c9LKcjPWGyMLKhDI6IsyCe0x67pugZt9d8ycdJJF3T?=
 =?us-ascii?Q?jQj8Uph/MEeBEhuAKg0wGVL6Myib7WLHgQ9dmf5gGNN75CS4WmiEGSnkgT9G?=
 =?us-ascii?Q?tjoXOe+Hb6TcZmjW3r2hur86dGXDAGh2y2MKl3PlZJmoS+d1KcQ/dVNg9qpO?=
 =?us-ascii?Q?s8J4IkOKLYpQYj+FBOOaoqpxBBLFOlXkPx0nL1mrFwGCyWxvYLuA2+tRA6/z?=
 =?us-ascii?Q?vzhoc2Zn/PYdIxoHhYA9AlqJgHBHpamXyvmXRGZgucNl4eaEg/6B3XCLpv4c?=
 =?us-ascii?Q?esXEdiaNXQWrhYQkanBhjLw+D/p58w7ZavYu9eSN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61459e35-8091-4c7c-e4ec-08dd5187a202
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 08:21:53.6615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nb5hDsJuxC9vTzmwLzEI5R2GlYfdv34cZ5D0VbLL+W4rhNEV+2hbMr6J538e7ae7wf2KSRGTLz0TWcNqH6IpAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7861
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, February 12, 2025 2:06 PM
>=20
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
