Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC64379EFE
	for <iommu@lists.linux.dev>; Thu, 16 Apr 2026 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324370; cv=fail; b=cWGy/k6vMRStKH3iUmYbI75KH+aox4GDqrqd/vXpoKpLQhhxoNV9nNZZOgTufCuF7YDj9B0RhvEZKlJvXD9jpGM8xTtmNosx06vAt/z3dqiD9029HQR+FOsKQ9og+IdRN8G/szVoPoN/xd0ghow0TClG1MBxhFZEbY97Iaf2lc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324370; c=relaxed/simple;
	bh=nePFCwaGBJ0kpAVsJISfBl6fY9rEvebORedVOhklOgc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LvVXFmsVWsp3UuliJWpc2BnNsH7WF3m7ahzy57WAy23xieT/EcsEuIB63VQ2UCZNWW9vcccESa0SWqzNC63/ouZX72+W1p0nSxIGPnkXvpgkPQ1n4ysPvomJR/h5e73hE81UX3ioDYKcCaOHnhrqNiLqS9IYUzR7N8hTAP41OOk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O/ztwIDt; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O/ztwIDt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776324368; x=1807860368;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nePFCwaGBJ0kpAVsJISfBl6fY9rEvebORedVOhklOgc=;
  b=O/ztwIDtaZxwGmVaGvzmt2xxTy1VQsCBVL4Exd6nuar1HtJLwXXppVHj
   nXS9L4kYDdB3pm1srO7jD730ckRmdO9mk/ICdh33gHaCigyE8oRaOUK+v
   kBxBB8r3tVZw6fwNPU7o8tfjx+L4eiBC98nNVsIjLBkPsrM7dQ0mDgkBs
   fttF1SedShHc5uydzK2qSPwZ7cuJdhqINHxnCHfIb7crMvVeJdpuJFMf7
   m3EqJtaQ9V1r9lgAtbmgJ5UfUtLBPvGk/8DI/8cHOzaOQ7r72tTX96L6k
   1ldLBhzXxQEK8+clzKE/9RL7eCA2USyHzSTFaAJXZvaZag+NFFimY8h9e
   w==;
X-CSE-ConnectionGUID: iQWN2vB2Sbm5YOGfVfjGuA==
X-CSE-MsgGUID: V7AKGzggRDW20UIc4RVNsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="94884869"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="94884869"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 00:26:07 -0700
X-CSE-ConnectionGUID: Rnt0lXCuTpWNJBBfX/Cm8A==
X-CSE-MsgGUID: n37mtQN9T9aUQDwggKE15A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="225938583"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 00:26:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 00:26:05 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 16 Apr 2026 00:26:05 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.47) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 16 Apr 2026 00:26:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELY2RSjm6M5S8CQ9CMSElax8fdGRoJ6/eX3wP52aZMU+Dx52UbItixw7+6Ns33ME7K3v0Bbl+ocNv64jmOPQmNhR4BL0eyCxxJeGHi1Hvp71kyjEWf6xWEyal9IGids3Po16OgT6s57PJ0gqko3skx115z0FjYGt+OHdwtQiyQjh1w5bwLrlL2ZsPqu2gaXgMnETx1+l+3FKt8n9zX/+Vw+FIuK60YPPkid2xBapKJS0GtDSdxniGcHBEjS+MFXFGA7CwCwdK9/RN6Ikm/zAg/N3lnBNIdXtXp5iOq5qXfTB4rL+Pc71fI/U++MfrkHV77w/vXZgZGiJcTE5icwfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPQ+yxq9jluHhfGnIK2JtDlAEiik+RJOzff1e4mizKI=;
 b=PZTdkPexq/dfUwwCVY/PICoJmMDIvzW2koMf6PMlcUUpVRa0bCJQZmISb26BGXfHh63Da/sNGJ/WgNAxIydJ9Ufd6PhYa/FRZscEL0W+p9hphOe+gHiL7aEKb1tLafnkzY+JOll89zk9pMDfdwkyiJzI6LmXcF9+SN9EFYTlnbK5l2/TAmCnG/Nk06n5pjm9NbynDJZbA29dyGtwuZ5a3FAw++HCn4l7CFBfHSKTxbmLl3qv4ec/H7peXLxj0mAoVmKd55T8ZtIN2qich0zs24En7WYIjJaimUcyyyh44XXmMrYBY9/EmHSkiPSqSdf59Fqb89xOpsW8wvRMt9v/FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SN7PR11MB7592.namprd11.prod.outlook.com (2603:10b6:806:343::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.21; Thu, 16 Apr
 2026 07:25:58 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::780e:4379:6988:f48b%4]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 07:25:57 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: "skhawaja@google.com" <skhawaja@google.com>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>, Baolu Lu
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH V4 01/10] iommufd: Support a HWPT without an iommu driver
 for noiommu
Thread-Topic: [PATCH V4 01/10] iommufd: Support a HWPT without an iommu driver
 for noiommu
Thread-Index: AQHczFOuuqfc0SHbYUui55qaSnKQFbXhSYCQ
Date: Thu, 16 Apr 2026 07:25:57 +0000
Message-ID: <BL1PR11MB52710F2441FB52E2D94D37868C232@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20260414211412.2729-1-jacob.pan@linux.microsoft.com>
 <20260414211412.2729-2-jacob.pan@linux.microsoft.com>
In-Reply-To: <20260414211412.2729-2-jacob.pan@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SN7PR11MB7592:EE_
x-ms-office365-filtering-correlation-id: 66cc00e1-19b8-41e4-8f13-08de9b896748
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|921020|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info: jmtzM0NDaN7ccQeNa+T8DPOpcnFc3VFZWxyeEQHNiVb98ZRBJUQ/1eu7+3iexx+eWRyohFo65AVQsKfid+OqUVt5zAUsC8uFXwafqaghezZ8a7ySLcpESa4oJn4Ddo7quuj0nwyf6G/ho7RrgkqtWtc0YqzUxCw8yyIrzzQZ0GnIIQvQM85Fj0K9Tkv3Y8WhI4qtyFlk+uiH3uTuRESmxNxXtA6tzD5oT4+0drgbIS3lwneqlYHUQHBc7QAN9IK7e89zDjqHHwznatsgQkVctR3cA1W1K6jll2z3MR1SrXZJqu7GfETuzLdVSIoF3ANUljqiudVW+XlGrSS+0XFCnwzKpeCf/pMm5u3MpRGFRLtMtpa8ASu4E0873CAVUqcvWLMCxq6W7vq8hHfOJSY5ZwSe2XRSC0RQXcukKGRgDf3YxzJVkk5ZVKXW/fRmjcfnW+qBbrnpas4H1AXCWITdXmIqYnpcBxqCXlyvojjz51hX90X7TkUnzhiE5/XMr/K79oICQwnTwlM5lcVU3uO7dnhjD1lCPj3gCAAWyJpBen+ETotPsAcV6ETDQfc4vHYjGaBDcP1kcM9hxPwK+4QibwT6Gyb9578jIipapItWPKwuOgmJKsJC+3Bres6b4bJFW/QLd5uNS/tGV6OsbzYKUuuDcIQ8PwNKC+2PJDalqD+fm/Ucfl6lAnbZVR0NYvx0YTMEIirF9cLwdhkNmwyKzXDZ+P4F3huIK8sFaYMeniwjmv91GYj2KE5AL6Fg0rtH4/Ie7iDf9nPIEfv+t60P7Lg1I9sW6NWw56YlSU3Q1z3wVpRNwXxLktoDD29krtZz
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(921020)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y2KUTX16vcfRyYGrXFftEuwsNTNqEdiIcUqyWHuFcOy5LkSudJegjBXWKDvB?=
 =?us-ascii?Q?zhn37uVdM4URjb1QQYgduC0S+9ioqrMIoK5/qTmOAPvrLr0pNCN1PTrjZ30U?=
 =?us-ascii?Q?l6RBUe6T2lMNj4uB/kVn4ejfGEnGhsiKXxScFewbzEy8bOMFFtWN+PvayqiP?=
 =?us-ascii?Q?akJMH0v4b/1WstXnaceUWyQsABPgYrHYek/GiT1sJXWcSTeaZAaeLY05k0QB?=
 =?us-ascii?Q?DCcCJWIOCKr8ewVPaEUJZiNFGThYUqfWxAeXhQqsHdas0heJQq7McBWfIuFz?=
 =?us-ascii?Q?w7ErU+PkeV1HTL6ID0eUR+bd5S854HRpBCtytFP4UqGyTWLIrnc4V7lL1c/H?=
 =?us-ascii?Q?gl4tIUFSo3sU/nTuAMdlRdCB8XHkUfIyMLoNhyrUD9nZ/V9Qw8BETu5qFp0j?=
 =?us-ascii?Q?WtPV6zwD4k6jRhGpKvYH1cHSn1c05Xhz4+MGj/57DibKHdiqRqpbjTuWbS3M?=
 =?us-ascii?Q?P5V4oloF0g1C8fvy6M90y5cz2Xo+Fb+aiRnStM3vdP3IOC3454nm5/pnx50q?=
 =?us-ascii?Q?/gYxblY4PGDiut8eM7sI9xLeI1Ia7adRKwqkuqDHhGH8KI3t3AV6snPP+CCH?=
 =?us-ascii?Q?oMJCRqr7MyvBEWlFGfQzsb1hMv2snsgBxnFCcDelX4hXzmXm3x1TVdBwf0yb?=
 =?us-ascii?Q?aNg553KEChS5KH6Rj0DM2De0qLmHEjwJvelEsVzbnKlHnYsJbrNQCcRkz/qb?=
 =?us-ascii?Q?loHEl+dpag83KtHZ0i3XQuV7cnN3p0zb61vLipGUguKDICfiE5Peg7zkeqXL?=
 =?us-ascii?Q?gR8OpngQb0tN2m0p4PCrf/gicC2fglRelz5z4UHWPRwdA34wgiybXRLgpqa3?=
 =?us-ascii?Q?/QqlVCkKWaVz8o3wKapwNxy1A2r/dVSZqcHTTXJ1CIukHu4OA+kdpnC5oHuo?=
 =?us-ascii?Q?uNTscZaGmN764TKeJfWN0Gmrfb6/yRZaC9XNyT0MOQG8WK5fKbm8tg9umAP7?=
 =?us-ascii?Q?+Vsp1zu+UDIXl2vtaWQfgVmficpGZzvqukWeNKVv+3TGFe1isuNgq5BWQ9A0?=
 =?us-ascii?Q?hPuNqPBikPx+T/eQms8iuOydSNryj+xO82tI293U00ATIMqaZtHiCpD2IzSV?=
 =?us-ascii?Q?fRralXNEdy9EVC3so8AsN1HIQXEvSE7vvVEQjpCFOcsIocSncyDvl5W4Obq+?=
 =?us-ascii?Q?Wj/AhM4gHdH0myae5Ko9tG7I5m6RMwxipKbh7dQjuw0d/3XC6/tZ+eDvfNMG?=
 =?us-ascii?Q?jZi//dXdndAHcgzDJTGGPI7Uf/8H/mGut5dfVeHfT/+wnW3pxU2BUdPTV+52?=
 =?us-ascii?Q?vNbmpnMAsJOBDqZIbnVEy7CifrfFkTJQooBMe00tdMd0geiKQ5nsJSDeBuuR?=
 =?us-ascii?Q?yqz+QWXnrDEdnAEWfwSHlLsC/AhB0vqgscjpndGMeaksmDbwlddZhUvFUar1?=
 =?us-ascii?Q?arnxxNVqdC8o+SD1QGLdohyHX/X+NF1nsUM8tPIC21z4Qa8E1VYh7wJY/XPc?=
 =?us-ascii?Q?M0PcIqsl3cOxj2XNhxSOJDHqeAEWxLczBHZPywxJeM28lZFhX85IKEBODjvP?=
 =?us-ascii?Q?wtu04NrJHbE9yXX4VDwVnlK31ExMbUzAVQQFr3LEXDvF7GeVUSUmuDX3w6gv?=
 =?us-ascii?Q?Rg+BNWTUI7IX6orZDkKFgrv0oW40Wtv60QnseWojktzrLdtCa6QG8qqbd239?=
 =?us-ascii?Q?44uyoq0GGRfpQTpMofugo7cEzUngbPRo0sVZ5XFrSM4m7zYlgI6Mn7NmTBHv?=
 =?us-ascii?Q?IKLL77LyopIk/DsjjSdNDy7uhzcnl8dKhLIps9p/wC98/j1r?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: Ne1IixuZmzQP9RD0xc3mLwYjxR6WVHQe8vrXHYzaaU5LEjQm9fMJf6qnRI1RQcsGrhTdQiaUylEG/DhuvHeY/rc4bbMzx86oJIHRGUT4qSHDd0SAfSzG4dHgVSTdxYQf9gHUSW0r/RGceyazHKtUGbTs3vkyHd5GVUEh7GnERmHjNYjqLTg0ECkps8/jewdKbwKU/pzcqT4+yzvjBEv/dziX30lJThyTTBX1xFfmOkAPwMiVohIjbmA/blkX4vP5p5syn7RBZY/DQTvwLMaE1NU3qKQnzOLLhCG5Rof8u38EbMFatDQ6RFTbcCXLUueGV1CxBm7of4d9CLVDw754GA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66cc00e1-19b8-41e4-8f13-08de9b896748
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2026 07:25:57.8684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6q6hEOrIhs9uGO+oMTYw99yvt8FNIeSclAvztGBeVx9qByHjeYG3WdZjH61xuvOmBzg76oLIeLNteix10TIacQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7592
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.pan@linux.microsoft.com>
> Sent: Wednesday, April 15, 2026 5:14 AM
>=20
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021-2022, NVIDIA CORPORATION & AFFILIATES
> + */

the years are not latest...

> +
> +static struct iommu_domain *
> +noiommu_alloc_paging_flags(struct device *dev, u32 flags,
> +			   const struct iommu_user_data *user_data)
> +{
> +	struct pt_iommu_amdv1_cfg cfg =3D {};
> +	struct noiommu_domain *dom;
> +	int rc;
> +
> +	if (flags || user_data)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	cfg.common.hw_max_vasz_lg2 =3D 64;
> +	cfg.common.hw_max_oasz_lg2 =3D 52;
> +	cfg.starting_level =3D 2;
> +	cfg.common.features =3D
> +		(BIT(PT_FEAT_DYNAMIC_TOP) |
> BIT(PT_FEAT_AMDV1_ENCRYPT_TABLES) |
> +		 BIT(PT_FEAT_AMDV1_FORCE_COHERENCE));

PT_FEAT_AMDV1_ENCRYPT_TABLES is useless here.

> +/*
> + * AMDV1 is used as a dummy page table for no-IOMMU mode, similar to
> the
> + * iommufd selftest mock page table.
> + * Unlike legacy VFIO no-IOMMU mode, where no container level APIs are
> + * supported, this allows IOAS and hwpt objects to exist without hardwar=
e
> + * IOMMU support. IOVAs are used only for IOVA-to-PA lookups not for
> + * hardware translation in DMA.

it's confusing between above "legacy VFIO no-IOMMU mode" and following
"legacy VFIO group-container based noiommu mode".

> + *
> + * This is only used with iommufd and cdev-based interfaces and does not
> + * apply to legacy VFIO group-container based noiommu mode.
> + */
> +static const struct iommu_domain_ops noiommu_amdv1_ops =3D {
> +	IOMMU_PT_DOMAIN_OPS(amdv1),
> +	.free =3D noiommu_domain_free,
> +};
> +
> +const struct iommu_ops iommufd_noiommu_ops =3D {
> +	.domain_alloc_paging_flags =3D noiommu_alloc_paging_flags,
> +};
> diff --git a/drivers/iommu/iommufd/iommufd_private.h
> b/drivers/iommu/iommufd/iommufd_private.h
> index 6ac1965199e9..2682b5baa6e9 100644
> --- a/drivers/iommu/iommufd/iommufd_private.h
> +++ b/drivers/iommu/iommufd/iommufd_private.h
> @@ -464,6 +464,8 @@ static inline void iommufd_hw_pagetable_put(struct
> iommufd_ctx *ictx,
>  	refcount_dec(&hwpt->obj.users);
>  }
>=20
> +extern const struct iommu_ops iommufd_noiommu_ops;
> +
>  struct iommufd_attach;
>=20
>  struct iommufd_group {
> --
> 2.34.1

