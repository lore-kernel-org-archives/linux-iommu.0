Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918521C3C1D
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 05:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744262489; cv=fail; b=HdKLrFz6fThdIhFFUhvIuDbzLreXmUdIv2r0zb+qCIcjVVuInkRT4sMexDITKfIVNoqbNKyAT9niTwV+xbVuHgy3f0sl4Gbc+F7XLEquT0hAEDqAwf327IWP9eDIsCr9XEe5GEBGRbuWJC0/lFqYnEdoy96exj8lA5YqxXv5T+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744262489; c=relaxed/simple;
	bh=nyWH20CGHnCWyqFSwN4sjks6rjap1imFlMx+cjGqrFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DJ1muxDioE9q0z4CFCl/0vBgellBfnEyYyfpTRQjikwLmrhw6P3tlPETeARm7p5vgeuM1aSt9+Z3eREM43aGWMmowMOrGXtjMOkB/I3ZMd81iuXVHzvrrPVfdQaVaKZwLAKELFoehIjR0uVOwC79WlGtZmJiAGWftenAKhcCZqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FPApbdsY; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FPApbdsY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744262487; x=1775798487;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nyWH20CGHnCWyqFSwN4sjks6rjap1imFlMx+cjGqrFI=;
  b=FPApbdsY9lJ+ZMTNjH25EAKsw/mIFlteTHtwwuUGHz8Sx0rCpWzc/Fx0
   5MddGmGYzMr5OlDsa7rImg3Yf7s2snR3hNi0KbJuGEyUwiMP7UyE/SDmd
   LW1fBlBQRZlFr41h3+p1f6ysLKzUwSnjJ1PchxglrCbJ6pdhmR8lF1Uo8
   /KrsFpKG8Z86V1PXf7tgjApivq3DfvLXpAB7A3P1yvtGDmeoYUaWncjfb
   oEHAgd01tf/CzcSAc8+QUMHmUtLg1fujR2f2e/+vgRNNvO5wLTjxTwwVy
   Ptja8V1mu9W8DIxiT96uK6tTwEbPc2UoGKjo+jUQK60bZ9YevcTG8wxmD
   A==;
X-CSE-ConnectionGUID: NLkUk6NLQE2EqQQsFXq7Cw==
X-CSE-MsgGUID: hfbSvAjnTlet02DRivRI7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="45775073"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="45775073"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 22:21:26 -0700
X-CSE-ConnectionGUID: frTofALhSqS9Qoy+tWsdHw==
X-CSE-MsgGUID: YC/P8aw7SQyP7QKG1boglw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="128752265"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 22:21:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Apr 2025 22:21:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 9 Apr 2025 22:21:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 9 Apr 2025 22:21:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E1XzkELQEt91UKa5iMESYZq261aVcSz5uHfrz7Xfy/lOOGvxfOgKFvk0f7kOMhuWKR9l8iKCPQzkIZdNbhrXmSJzpkkQpd5ekKPzcWR9RSjXO/zBjRJkJbKpDLPGYrYmW4ylDrURV30jUnXN/5JOio9miorSAUNadmxELf4ikZIajlml/4ly2gHLH6nC154waFnJcF4scTVrPVkBflE/lYfZSILl91AxR9/GbLiAq9KpeZx/RUfqwwjqwUi8cw+3lFgemEXhVQD8v2DWA94XmhKwflAsOcMx/JyI/s5SUGGat46WgMQh8rNb3KmWWOjGQrev2kHMj0vvub4Cl51Nqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ksFAs8k8rX+UEp2KM4LV6UOsNaUx+OuRShb8vSx0EBo=;
 b=Sz5DaCapzLDWy/at+iO+oPbhGsmQQUOu/TkW5J2NdCSBOFDA+eJ09FRW0VHMi19nSdwTe+irYcZ6OlEscOkMmANiYc7eCcESr4jS14hiuBlL6bpWpFK0g8CNk0CMFnE7xIhMrc310fHN7Dg2okeCgf6SbhCOIT20ZN6ZmmrShMRfVBAlrLezDGnV0aJLdMqoKSZlaB6WQ2ha5jY1xQRzckFpXjwqrt2aSSfefk4IdO81uV4miLYXeXID6tUOa/R42R33tCw7k3hnqrSoY2XgF7Kfzzr28Aav1MsAwVfrjkUCbkLxp5SZU1+drHj0FQsUQHuNfwFvI2Sfo3bvgl1Itw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB6350.namprd11.prod.outlook.com (2603:10b6:8:cd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.21; Thu, 10 Apr 2025 05:21:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 05:21:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>, Joerg Roedel <joro@8bytes.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC: Will Deacon <will@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH] iommu: fix crash in report_iommu_fault()
Thread-Topic: [PATCH] iommu: fix crash in report_iommu_fault()
Thread-Index: AQHbqM4GgAWYHJWWYkenlrWHmHQS0rOcXvcQ
Date: Thu, 10 Apr 2025 05:21:21 +0000
Message-ID: <BN9PR11MB527618ACEFEBFE79DDFBAA368CB72@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250408213342.285955-1-pchelkin@ispras.ru>
In-Reply-To: <20250408213342.285955-1-pchelkin@ispras.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB6350:EE_
x-ms-office365-filtering-correlation-id: 3a2dd315-f84c-46ab-a473-08dd77ef87a3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zKd4puiURchXmsDwThyEG/OIkdzUV12wyj5yU55/3VPmEc0LO80okgqCUsyS?=
 =?us-ascii?Q?I5rxiI4rFIXYxHVGWH6tsfBnlyIcIA3c+UM247iSvuhEupuAmI4hfE95OU7E?=
 =?us-ascii?Q?WY4qKahws5eg7J6VN7qGCF8FTFNMeUPT16R8gOk4qahNmPtzjpYAjCm6/Qny?=
 =?us-ascii?Q?3ymKhqEIc3JwK7nwnyWhbdqXn9tfckernW0CdxIODVn+WlQoWgud5Dc6qY5E?=
 =?us-ascii?Q?CUcPFD93ZaeysP5BRtPqIpdWnSOyyCIYn2YHPh+GjISNoM7FwcyiCCsH3K7L?=
 =?us-ascii?Q?jQvO4o7N4XPOZlngjQn34GH5aRalDfzcPihWBcj+I3IqPpW4QCWa1Jrwxi6t?=
 =?us-ascii?Q?wnOhkViT5v8e27NNFNE3kvcsplM/5MZfg7lghGQKxwYdau1A94vdp4Jz9I59?=
 =?us-ascii?Q?4kbnWH1G97wzyyb7MR2tdEE988UsnDs6EUABhsz5cuQcjINqnt5Fzci202eJ?=
 =?us-ascii?Q?utwpJundbuGZFF6Y3T9+5+Qzp/HDF/gtRn6v45o1W6risTdwGNAcYENecafP?=
 =?us-ascii?Q?g3tlZnMpKZL3eort7CDI6zpBrNnxhFSf0PaZuSkc9YOOH59/lRhvo9oaYGI9?=
 =?us-ascii?Q?GL+gKITMYG7JYGHl4cKVYOd9Z3eI35msB8quQRufmt7PS8TVEADO1+GILy3w?=
 =?us-ascii?Q?ihZ5yG2QhAmNx1G7QYMqrEbP4mRHo1i7zwVyxclenE8dRGbNCDm+YCQlxlC/?=
 =?us-ascii?Q?TB7uTVkNO8yqkvx3l9Au0RbAUJQ++obtJXvLrUsnq6G70K8DgGEJAFRiQOjY?=
 =?us-ascii?Q?jeOvmfSuPGC0uR1Bo6/M5xrBg10cuoMgpGaig7iP4h5xBn7KW6N85rT+rSv4?=
 =?us-ascii?Q?m2MDsTm3fY0VEM9F/xCRD3zjQz6aCNTs9KqgNQpEDF4bo/fIZaD3ELmZhoJv?=
 =?us-ascii?Q?clnIYENP/zQV3DpBFfVBClNXGMUkGJXnmDoPSa/06smMjPe3ZXpe8Ih/ZWMi?=
 =?us-ascii?Q?arhmD7STm/f0mNwkqJjnBmTlt1ie5BMQre0iI0xefZ8HxCMT5/YM9m/H7vZN?=
 =?us-ascii?Q?PuEeCKqae1buOKrKjWnbKvAkv3O3wXP3KTIqRyj7oTfXPkW5tnWfBLmp6oMD?=
 =?us-ascii?Q?afxgSXN/aADESuHb1ZUnzsgBE2i0CFeEQaSnGGeN+aDzOSCWfJg7S8DUEfT1?=
 =?us-ascii?Q?MR6Lqsh7RVbVBKKmzuFT98ZpnAIYAjWXQAfKx/9+V0ucDvDnmOdy/9diREJ1?=
 =?us-ascii?Q?UHju8OtHCqwbAdJEYDS+HXlZDOW1kRSZIVE8/nQ/wCunFI3iVqwfu7gFQAni?=
 =?us-ascii?Q?MgkZn+O8dptqwsWI7nE/Bvkw2ehhQaKoJZ4F7az1hTRX8BUuscUz2H8o5VyD?=
 =?us-ascii?Q?WF8TaieGM9/1+DQgIAb7zHN49sWj1PD+xrgwGuszDh83KEplPqNRb0hlMWh/?=
 =?us-ascii?Q?ooXdh4G3yhUatX8lkuaq8VGBK/doK6q1ng20tldfK+IR33pRhJ1D4Dl09+6h?=
 =?us-ascii?Q?teBiLo48WlOoKnvx+baBYkMkYRgRS0bE?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jz9TphJyMJ7/TTFAxN4Ec1ZUsC4lKxS8/BPk0aSiUK8ciB63TykCT1O1IWGj?=
 =?us-ascii?Q?qLDODOVvZxVC2LqTR2Qoe/1jJFksYDyYZtPDUtkH5qB95E5U3OkXVo12qQ4m?=
 =?us-ascii?Q?q7bF3g5+FzuUG3N8AtmjaCLckVHCxphg6OwvME/POm28rJ35f4A6x+xAOWYY?=
 =?us-ascii?Q?j6VrntAQqjSWWszSd/4Bq6H13airHyDaTeJLDTU8/l5HhrTU+Uwi46E3x88d?=
 =?us-ascii?Q?Ak8dG5sLjog/1w2kV86Z1RedhIwd5RxuwPpckL+JMYdiRC3QPwHP2eS/eXL9?=
 =?us-ascii?Q?nn1Ft+wKIiauUc5mMegyomxDE7mVH8PvEgH/aF88crf/A1N70akn27KqcedH?=
 =?us-ascii?Q?6SjMs1AUO4BnXiPk3+TMYNRv/QxgrscOF6dniPNSte70lsvmYs9ceAMqEjtB?=
 =?us-ascii?Q?qyahPnUaqSEwqZ3N+iAKp+Wrf8R/ASx4iXN8CNMeCry4DS97NrGOFvfBFsL3?=
 =?us-ascii?Q?bsOxGlXX5pefo7WDBSBWrratOSz40X3f4RuNDjgfVGAtvtuCFDx9XxuIPCwv?=
 =?us-ascii?Q?jlU+JeIIYwEbn/PPwFqcp4WRKosMX38XwU/Ev1L+kdSgrrvQqrqK5ctPPe8W?=
 =?us-ascii?Q?xXqUlIvEQvaQpPXC3cvPY6/CVjT+yR4zAbuQVpXJCOugBhN36bF79L7rtgyG?=
 =?us-ascii?Q?HWq+M4FYx5ZzUDCmXaeRPrRZbf9qtQwU3ch6NJOUaFCdAZ4tDkWeGuH8BrUm?=
 =?us-ascii?Q?w6DJg2TdlE86UmpzZZLSp6Ypp4OPvg+f5wLzvEgEgIfH4VoqDPqKCv9kv4I9?=
 =?us-ascii?Q?vTA4o5u+Sh/xWCyR199qE8lSX9NAD9kt1U8LkwOK0tmFCyV0McX75+Ciju3o?=
 =?us-ascii?Q?lqh0EpnnPgIeQZirNTdT9+Z7FPg2cPyr7glKwa4Z14UysWvzpNtyJGekS3UC?=
 =?us-ascii?Q?S8UGQQfQG5WkKs4XCVpMtysaq6U1UX0c1mbfOu3JluDRFQjFIfq/590h4eU3?=
 =?us-ascii?Q?f+q7X6Cg3AlxPsLylvvGBp3dzgqyVH56FdFXrlMOjix336jVmAH9ju/cIHEQ?=
 =?us-ascii?Q?jU8eAj0tC251UOAkxpjdqh96DqMomolptiY/Ii2/Nffgz0bJDVMXFy+1x9Y/?=
 =?us-ascii?Q?AbwkI0CjVCCTLzAJqjVnAuffdr148xyUC9GnSWF1NU1FYvYwX3txscmrvdzU?=
 =?us-ascii?Q?AMwErhbiQrSwdQpWiiDYT6YERNvmQe32I7NomPAYG7lPqMxLfofXZEOE/vri?=
 =?us-ascii?Q?wLqGY68tjBJ1QCTEBl/aDmHNYubr1DXMHhkipHhQkjwns+Mjo4SZwtoZAB67?=
 =?us-ascii?Q?L+8OpjdlTh29qDjel/d2IF92w5/Gcxg21DYVI/3jlutNOEtsVCqXPCuA6gzd?=
 =?us-ascii?Q?1GFp0tXo9LlNn2Xc6hxpArwIQLRUEI6k/eO6yaOZZlcgA4HfQXSC9sFuL8zs?=
 =?us-ascii?Q?8LjQ7p7ZxD/fyDI+Tv7/Ii7dY/2JLrABeNU0Qe/5lkEU8MFAbdaeb72wxcFE?=
 =?us-ascii?Q?5dfuHH/HydfxJW5McetBeOBddZH/o8jrJ4zmECY0jQqoYOmTa1ijf1WvuZuI?=
 =?us-ascii?Q?qGN8Kdc+v2raRwcb8Vy5I9ot8EqpsxZ2sTBoZaw25MjDfnhU16RqytGIhji7?=
 =?us-ascii?Q?jO+rzW3qUkc+ALtno6Fmf1ImRbhCo3xcWWE8XBrW?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2dd315-f84c-46ab-a473-08dd77ef87a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 05:21:21.2814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXc/9tE9inWrzLj/qt3bbNjeUvoiN5m/AbgzYKQiuWw7+UR+WtQnodtZ3ZzoZDvmTcb0UObvEf9Tl/9oSclSXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6350
X-OriginatorOrg: intel.com

> From: Fedor Pchelkin <pchelkin@ispras.ru>
> Sent: Wednesday, April 9, 2025 5:34 AM
>=20
> The following crash is observed while handling an IOMMU fault with a
> recent kernel:
>=20
> kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
> BUG: unable to handle page fault for address: ffff8c708299f700
> PGD 19ee01067 P4D 19ee01067 PUD 101c10063 PMD 80000001028001e3
> Oops: Oops: 0011 [#1] SMP NOPTI
> CPU: 4 UID: 0 PID: 139 Comm: irq/25-AMD-Vi Not tainted 6.15.0-rc1+ #20
> PREEMPT(lazy)
> Hardware name: LENOVO 21D0/LNVNB161216, BIOS J6CN50WW 09/27/2024
> RIP: 0010:0xffff8c708299f700
> Call Trace:
>  <TASK>
>  ? report_iommu_fault+0x78/0xd3
>  ? amd_iommu_report_page_fault+0x91/0x150
>  ? amd_iommu_int_thread+0x77/0x180
>  ? __pfx_irq_thread_fn+0x10/0x10
>  ? irq_thread_fn+0x23/0x60
>  ? irq_thread+0xf9/0x1e0
>  ? __pfx_irq_thread_dtor+0x10/0x10
>  ? __pfx_irq_thread+0x10/0x10
>  ? kthread+0xfc/0x240
>  ? __pfx_kthread+0x10/0x10
>  ? ret_from_fork+0x34/0x50
>  ? __pfx_kthread+0x10/0x10
>  ? ret_from_fork_asm+0x1a/0x30
>  </TASK>
>=20
> report_iommu_fault() checks for an installed handler comparing the
> corresponding field to NULL. It can (and could before) be called for a
> domain with a different cookie type - IOMMU_COOKIE_DMA_IOVA,
> specifically.
> Cookie is represented as a union so we may end up with a garbage value
> treated there if this happens for a domain with another cookie type.
>=20
> Formerly there were two exclusive cookie types in the union.
> IOMMU_DOMAIN_SVA has a dedicated iommu_report_device_fault().
>=20
> Call the fault handler only if the passed domain has a required cookie
> type.
>=20
> Found by Linux Verification Center (linuxtesting.org).
>=20
> Fixes: 6aa63a4ec947 ("iommu: Sort out domain user data")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
