Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A421D9592
	for <iommu@lists.linux.dev>; Tue, 17 Dec 2024 07:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734421202; cv=fail; b=alXXM4bDS9ciX0VcnWxduOSI5hoxtwyTD9lSof9RIvnXe1PB9Y4JMwbuF52rwI1XbYw70+g3ah6UGpOUb5tobbydJvq7aOmdvWX6HC3neiHzwvw5mGoxVUl2JA5/oAKB4/VwJnz96566xXaJ5JsyaM7d+vzl8PnJ+iYDiKxureI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734421202; c=relaxed/simple;
	bh=7kb4af+Gfx82fdL/469IMY237lpPbDpOByctHlSTy44=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sYdGIAHkfw/xSzerUqIN8d/n0O/tUKWKHUS2EtIiL9V5yKIHL25+0wGSnA3j6zSR/gCh1YjshYqf+DMD4Rne5VZtnu+ZrmHTZlLBagGND0WbIHasbCTCb9ehnoGyORafDuux5iA5ZAfny91GnJLujW6ISFiVonmXBe5ad0K9njg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V3SomdFh; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V3SomdFh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734421201; x=1765957201;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7kb4af+Gfx82fdL/469IMY237lpPbDpOByctHlSTy44=;
  b=V3SomdFhaC52hpqekS3lZx57js4eLsfkCbhMv9qinFubkatB0iMlxt+L
   mGwEryxeADsGaXsvZ8sBii0tENMz1wDPq0T/kFuqYqQpL064BdM+ox5Yu
   aO1p/bEZWHkp/dB0rYcFRUzf96qnk2qTHfgPq0Cj3+GD6pQdOFjIK9t4R
   0//Vw/D//pFLhqYDQ73OqsV0l9IgA2lbGwoqWQqYWvf6sKXYg+LnFbo92
   M0LHiCadeuEnj07T3fhjwkniCJsZTBEmZMBjWlCwTQDRvA6tnWTYahZcV
   kvitI3vkS1Q/CfzcUuFRMgOMz/vz6a+HDMaj1lbck5DgeC9Ri6y99U20N
   Q==;
X-CSE-ConnectionGUID: SDxOexO6ROmzdnG/PhdI3g==
X-CSE-MsgGUID: Gr//6q25QXC9tZXfr0E+xQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34711237"
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="34711237"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2024 23:39:59 -0800
X-CSE-ConnectionGUID: C+WLEEdWSTSsHCLfmMtP6g==
X-CSE-MsgGUID: CItGMt3qRZ+AB40KOSFfAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,241,1728975600"; 
   d="scan'208";a="97897966"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Dec 2024 23:39:58 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 16 Dec 2024 23:39:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 16 Dec 2024 23:39:57 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 16 Dec 2024 23:39:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YNRlceVIC65Z73CsD7/mtYOu41mcgwT5eB1Q2vfCSSU3eN9mtNNER9kmhQZyPnZVspSgz7CCo3cpPu0knGHLtsEb0DlBBa1GoToTfutEPntG0Qb3zWC8cvUeWhV6RB4SFhkWGe+ol0OFaoaOTJa4BghUWOfx/tRltF9cxWg+mTDgdjyTJpyj6K1T4o5/8knCT2t6iiE6N9XuxHXFEfuKa7DG02T1/kF29KtsYHphe9lRSTu27qVSrudIOCMKGlGzcdptWIdZFaCA1pq4aDO4iXo0AK+c/fWxLg9p0iEjb/suIF+NwG5HAKjwnckFr+2+eXPQ7/q8HLjImEGqx6nG+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kb4af+Gfx82fdL/469IMY237lpPbDpOByctHlSTy44=;
 b=p+CpbD4NxiueSaMcTFQBxKfp7rikYIsz/58RWak/foWcFZTZaCiP/h7mXP4pGb9bQvz/JPHTYsfldseSGwccappn9LSoaMOVquUHJohfeqVqdLWIylPubnyaguqTD3Ai0KXHs1LCv9spW2C0JF+NYv0uzPauSm0XXvrUCw+NUBohSmm32rdMey4wDF5o4m7f4HYzSFUBaIpbr6TaNHN1TwHD/7VduE7ClKBlRKTBn6Fmr0bX7Mh/iXe5rwLD1R2pgcl1MNWBYDnZiuzCCsRKvyVkyhsYrZV1bndMf4Lez6PavOvDRa2Nfm7jm9BTJYgqVqAlAGtnP59AHieG2Yp5gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by PH7PR11MB6770.namprd11.prod.outlook.com (2603:10b6:510:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.22; Tue, 17 Dec
 2024 07:39:49 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::5616:a124:479a:5f2a%6]) with mapi id 15.20.8251.015; Tue, 17 Dec 2024
 07:39:49 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Draining PRQ in sva unbind path when FPD
 bit set
Thread-Topic: [PATCH 1/1] iommu/vt-d: Draining PRQ in sva unbind path when FPD
 bit set
Thread-Index: AQHbUC2Z+axe6rzpZkS3uQKyLRevQLLqDSpw
Date: Tue, 17 Dec 2024 07:39:49 +0000
Message-ID: <BL1PR11MB52712961A13B55ED1DDCCFE28C042@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <20241217024240.139615-1-baolu.lu@linux.intel.com>
In-Reply-To: <20241217024240.139615-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|PH7PR11MB6770:EE_
x-ms-office365-filtering-correlation-id: fe76e987-88b8-4490-4301-08dd1e6dfc61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?zL3tkWw/Ig0N7/5WIFALp7Ze8RM6jq6YQ2RQTqdzTH4JUDEaN3oaYdXVtR/m?=
 =?us-ascii?Q?/Gj+DeEQP64dTzVPYhAtmv0l2utJ2K2IRtuvrsulmNI4/PvR4fxJWk5d4yy2?=
 =?us-ascii?Q?kL8dgORSvwWy9iJdqX+Psf7ayF+o555KTnvJtKSjiSefLHIW3CAVkADBSLV3?=
 =?us-ascii?Q?jg5bwu2dwCi6AiRWs00soyLmCmyV4Bta7/98j6fmF3m1FT6mrU8X02QwICZ9?=
 =?us-ascii?Q?SQnTv6Ho1lYLwuoV6IfYDkwMOcEwYLKKEgl7n01wgC/tNcLPLHBA95QbUBpq?=
 =?us-ascii?Q?fY24DlUnZwGAlDFCK+AdqgBTHxHFTxN9befakfU8vhKQ1W77HWr9M1xUGrZ7?=
 =?us-ascii?Q?V8qB1zBGp7v5K3JnyibzP+MTbo73Be/hZC5XjxykU2GgePLOYS/32jNta4gP?=
 =?us-ascii?Q?jfOnjOLvhits4dXLnZMKlHG8k3Hr6GcGIZlW9uX78BkPAVE1Q8aj9VmF8z1m?=
 =?us-ascii?Q?7PwKTAwDQdDnwO8uQFLtJ82qx6vPgOm2a2sGNsqYhizKavdZdDmZduGWc0Oo?=
 =?us-ascii?Q?EExTi8tirpi+Z06f/J/bGdo0aSZcaKi6JQpsdl7cXvkhOI6jzRkTZBaaBph2?=
 =?us-ascii?Q?Cn8mJI2mb7fIIkGsLdj0e1HeLkpcZTM9pdhg6rcGnKsGtzoNrcle2jd3Ly60?=
 =?us-ascii?Q?L4jnDKmdM0ufChQ2g7wHjMA5gAfuFcZIOsUglD9JlmtLoGuyf7bThimGFbcw?=
 =?us-ascii?Q?E2pHts3aJRHYBsR6FPAp0/Kknt5gaQI1gVR+/CZQz7+uvcL8MswgntJwZfOU?=
 =?us-ascii?Q?ozSxzM8Qf4mljl2GSvcLXqqZ054DShCVraKQ6lV+kVEq56DAgYiA5FBHwEVf?=
 =?us-ascii?Q?xs2yv+dF5hTpekldE9QYvZvfY2WIjcmcUx9sHuPqZL0RGQSmgUjRdQYzt1gi?=
 =?us-ascii?Q?RoSJBOkMh9zUax++M6ePB877d42rQZX1XNnhodYCWAfbEeAx7K8vEJnO0bx7?=
 =?us-ascii?Q?Rc3+MFciUmtdpwXfwQpVYsz2Ea9ZRnusE/Auy5n1HbvONGjzc05rReVWPbcx?=
 =?us-ascii?Q?DzFvNfSoW1DSqaNFsLIKLZiKoBdCBppKnH75SdODe5vf4SHYRVkWsGNDYB/s?=
 =?us-ascii?Q?MtXdp2+NOyvJt0Zxhfkfnh0OyN7RQ79j91AQWnqt26n2Z6mLy+JqAJDFfh1u?=
 =?us-ascii?Q?GazcrJSxwOi8xAOq1dgMloR6dXA4BnBiL/kP6S10Cka89OWQQPA6VcLFc/rp?=
 =?us-ascii?Q?oAQ3AxDG71lpmIwvsTfMnmf4K53SGEVSMFPKfZoVbvJH2Y5WQ9SuOK7WJcse?=
 =?us-ascii?Q?s+d+LyHTEQeAi3n/LPo81a8U9FleL7tls3FBz15jEZJPtyioqYYDG6htdwNC?=
 =?us-ascii?Q?K8ONj7YKHAfhNEHcXSJ71EyA2Z+nK63u3W9sZ1+kOcPEaCupMS68dhGY+zla?=
 =?us-ascii?Q?AEtsNsZF6/Z7L/BNcZtn/LJ+3dN55/bIgGDeI7MXSiCv6B8JykaCnTRUAEsZ?=
 =?us-ascii?Q?sflu1vFz4wZkLInbx1poyJ+Qe/Vasdov?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HUhSbl8RyBHV3lfCQfv9LSsA1m9bHk0yNgjkmK/oC0wPpeyNmfYc1e+ijdX2?=
 =?us-ascii?Q?9axf7k4FQV6iIRqpYJ2mRyg8OfqTsJ0m537OQKQYQlJPlzSz3W+qwa93Z98G?=
 =?us-ascii?Q?DHzTwkN8KVMg6n11xEkaUu6gTb9sJDqF7WrThue9L4h78tHJef/BqPwyxFkE?=
 =?us-ascii?Q?u7rAjnqb3jJKJPplY7zrbGQHd6u5+GNdiPL7wKQ7uK9C4T69p+OMQi/SPHxr?=
 =?us-ascii?Q?OeNkGxODXNHmgJfc0JF0jDcZutrF48Hk5icW0ilkT0LurBx0QRUD/TGFt5HV?=
 =?us-ascii?Q?PFUGFKeVJM3LaBNRuT+l2QT1UF0nUI8T/DICv3JCw+EkcE3e6g+aj4dNvH7f?=
 =?us-ascii?Q?yw9D86F+6iivKKm4pfgHGyBnX/oxQb+S1qfHa3hHgGa5/BAOYdLEtvUfOHum?=
 =?us-ascii?Q?ByAn3SrXulw33OoRqvqKo1H0nnhODv8TsOHoAOJfOmVDF+sk0lMolKLXGhmc?=
 =?us-ascii?Q?Qei/16cv7JCyiB+9gBXggzqa2bXaGqdF72s6DjKpCFj1nRqzFCqzeV10Qzmq?=
 =?us-ascii?Q?ShdB19FBFn5ABKcudulmwzAarVE6Cvi6KdYZdCMtHca6xSjDwOixog3xiuum?=
 =?us-ascii?Q?sSJ7a6UwOy5vZRPQM5vnBi0BXtGSRuCgrgJjFqVjxcwvFSVmPWoYMJC1m+ed?=
 =?us-ascii?Q?VSBITswLICiuIYe+luj3wXa7DxidBMbc1zriBwrE8ADhIRQDmNV3dInpOXWs?=
 =?us-ascii?Q?1NGMrmInsW2HmOaINlBXeLss8NeDigwvIE7ZtKG1ek8ZbVrJl768NNUfBR+n?=
 =?us-ascii?Q?mfo6aMCXOlDSMUz4qp60BCAqgme4iNpude+xZ9QaqMpQxEqQSR6gSYkdPaA7?=
 =?us-ascii?Q?0+5qZzlm+eQywuQEh12zjiUTnJaTlpJ0gqRrE+JFAmu46fSC68tU+hYMAA9f?=
 =?us-ascii?Q?DU9s71kEGhuc44XM3sriVU//jyAiP9oxGkhk5Y4vhpRfdqyEqtGSLwVBzhb4?=
 =?us-ascii?Q?vRLwpIt7d5T+WB9WYngilnbJ2tZmFbnaeGUNE5ZKfzMqBSISAqVQivSTveVu?=
 =?us-ascii?Q?4DTR/6u3V0qUxSYFNufpyqpzozcu+v5uHKIDyA9zwhaPYCfwFjzvE+Gj714a?=
 =?us-ascii?Q?ykFxsCMD+VY9g5z7pdvjp7z0dUgplqBUgWQlYNNzptoa7vQI+tu2hLurwX9Y?=
 =?us-ascii?Q?0akX7c5QsOZ2E05iMdCaBKrhaQKy9H1eDawfnC9qgamzu6F/2JIan/i0sHuk?=
 =?us-ascii?Q?84lTq3xwECv5tSa1Qs7g2RU0iZR2t0P+ORZpKgKzWjTalak+UzB+trwzlD2F?=
 =?us-ascii?Q?DhW5AppBn82NbUXubGwZm5V9NESnAHdPNu/dOdrs0TlWyO5OlE60ZI1dkOCh?=
 =?us-ascii?Q?0E4rmY3qyASW/Cxd4WRmDI+jrBFDOfufMjfRAUXax/Kbv6bs/aztx20k0G7a?=
 =?us-ascii?Q?loZEd5WBu993OdUFXk5fkkUf9/3ig9tjAC8dnntetU9gEDG5bj70cVuqU9Nx?=
 =?us-ascii?Q?rr4i8rEwvf5EfeAMly+DEkFbRpr8/0Ca+VXc/tmF+nJqgKjDFqhOQ6MDbpic?=
 =?us-ascii?Q?leJW1LMkVrk9KNuBr2ykGJAE6XhLd4ktUZi5L/2mCrqgo9HqcKGUN8jJjXgv?=
 =?us-ascii?Q?Og3oylPRuNxnq3Fi+8b2GvP2yn6Z+9EYueaFJfrG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe76e987-88b8-4490-4301-08dd1e6dfc61
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2024 07:39:49.0382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CrHH2cEW4bYrej7iQRZLippAJD7JvaudB+xiq/QnK24yXDjDGZn72O87qEYDdWNx6x11SXEhyvIfYgaFqp0l4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6770
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, December 17, 2024 10:43 AM
>=20
> When a device uses a PASID for SVA (Shared Virtual Address), it's possibl=
e
> that the PASID entry is marked as non-present and FPD bit set before the
> device flushes all ongoing DMA requests and removes the SVA domain. This
> can occur when an exception happens and the process terminates before the
> device driver stops DMA and calls the iommu driver to unbind the PASID.
>=20
> There's no need to drain the PRQ in the mm release path. Instead, the PRQ
> will be drained in the SVA unbind path. But in such case,
> intel_pasid_tear_down_entry() only checks the presence of the pasid entry
> and returns directly.
>=20
> Add the code to clear the FPD bit and drain the PRQ.
>=20
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Need a fix tag given the old code doesn't work correctly?

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
