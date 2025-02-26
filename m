Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107B918D626
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 02:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740538368; cv=fail; b=nPbz4Zd/GzT1VJB2WI7UrZY8wI74Ndzf/e5wJqbT5KHuBShd1BAEqK4jVHlyhdlsexx2FvgcnWRcfDH/T4LtF17NypPQnkgCoCQAhqUoeww9+y6IwwjxMhFkX13soI8Walnwp+CXMHCfQxqZ15a430Zq8ui0vENe8CC/y36cKtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740538368; c=relaxed/simple;
	bh=T4FOFyviJcDSBw8664o4xpmrGz1gMbCItXP9QpMUgeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iigixqetTe6sSa27gxp6z6cKy93yMAZeQBq5cwhzPHB9AUc2rp4KVtIVqqfkAVU0lvmQB/vk6S0Ro6z88JsvnNoXRSECZ4Xrnwj5CrzhuTdn/DmrWjDwaJHsCsx/V2tZ/i2Lz32t4xCg3StbpMF7K6e4wMy2TJv+QWz8aXC7Wds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m3byuAxA; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m3byuAxA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740538367; x=1772074367;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T4FOFyviJcDSBw8664o4xpmrGz1gMbCItXP9QpMUgeI=;
  b=m3byuAxAqwyRux90rQPK4sGKYAZ/PfLByfff6/wOXL9TRDqP5vmtyuQu
   GXNQlHvfyeLoWE11IswU8f2jmFAC7iVBYpBmG8I/29+N+4YOHY484HkRq
   GRSRxVnk0I4ODsYM6cW0y7uzyyklWp3RRCG6NbvmoetGtXqDgag8M6bp5
   jSerJYRKSUZfqom+ap9dNWux0iluovo75jtNqSoqOs96zCsOLPPQXJb5n
   vXqZn6/ZpgzkKu3+y/3tmZiXp5svWBlXBUj0x2W2FY0zh7npF9HTFzV2m
   GE6w2Bpvhaw+Z1lPGKSkocpJw8DQoL+UK37sAHZorilsf1EZ23YwWZiYA
   A==;
X-CSE-ConnectionGUID: c05E+WbiTCWrlXJy6U3dWA==
X-CSE-MsgGUID: Dw6kqClVS4yR7ju63tGpFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="58793858"
X-IronPort-AV: E=Sophos;i="6.13,316,1732608000"; 
   d="scan'208";a="58793858"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:52:46 -0800
X-CSE-ConnectionGUID: mbVQ/yyaQjKyC79sxXBvsQ==
X-CSE-MsgGUID: dYfpdgwMQ82UW9zu5a2TEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="147485390"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:52:46 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Tue, 25 Feb 2025 18:52:45 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 25 Feb 2025 18:52:45 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 25 Feb 2025 18:52:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lHntJfirv8PwO8ubHbWabsmlVpjBMLL3ctnDLIuQIqfXXgFS7w43W1vSkLcvKDfP57nN1TI8gtPC/oLs4JoJ8iRKxWqzIPH//qoz5s/UqHjFQUG85V671xS5ylq2pBXRdtm2EzR71HxGLWcW7wsS2NZoU6grZACeWLneF3H43/o1fImQXx0KiD9HQhg+UbQHm7bjr9LR0Z+MIWigU5rv+OW7Nlo5whKlfK4Rr0F+qIAP1wN02G7XwxOdu839syPRIlUa21w+PhR5Wpgn31pZSFiXnECrWMcU3jFs6BBS9T8+z6B/vPwcEDeeMOtIZlM8q5gBsd/Ly4eGXK8rspu+OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T4FOFyviJcDSBw8664o4xpmrGz1gMbCItXP9QpMUgeI=;
 b=oWlFLBe9pJ1e/fzUzJ+qDdmcU9zhGJ59JKbwwpOjJb7Dub2fWbagK+b4W3OZ9RGWFHbwE2iAvrVrVQWbcEacP/v6fg1P9f9okoRhJWGuQMl/38PQktVN2jKfiGcBCyfYs9Lult+YYVeUY2JPCfy1ncDh26D2W3gaURcR9Ju4r7K6ILs9tk05VznVxa/xaVmTTRQ+xp0rX57+W0tkMr8O4KWejFruadyNV/ByJ+3oMpCQ+ZV/JC8B6XxrJbqnTqVhafZu9RQBZ4wyaZnJzz/npEUXAa9VIyt1J/jW6xhhjYRBpysMFX19TU2PzkEZgmG4DZXPSDJTDuDOIq385zq00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CO1PR11MB5057.namprd11.prod.outlook.com (2603:10b6:303:6c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 02:52:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.020; Wed, 26 Feb 2025
 02:52:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, "Liu, Yi L" <yi.l.liu@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, Vasant Hegde <vasant.hegde@amd.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: RE: [PATCH] iommu/amd: Add Secure ATS support
Thread-Topic: [PATCH] iommu/amd: Add Secure ATS support
Thread-Index: AQHbh3UOCMVRgdan70yjYJFDyKuOHbNX8z2AgAANboCAABr8AIAAq5qAgAAA/4CAABtz8A==
Date: Wed, 26 Feb 2025 02:52:42 +0000
Message-ID: <BN9PR11MB5276598CCF3015A70FA793A08CC22@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250225105829.52223-1-vasant.hegde@amd.com>
 <be9d2ad2-0f9e-4d06-952b-4cfd6ae53447@intel.com>
 <ce86ff90-377e-49fe-9c4e-d2ad7abeeec8@arm.com>
 <20250225145518.GJ545008@ziepe.ca>
 <baa35632-eca7-4779-8862-b032d56f82e1@intel.com>
 <20250226011303.GA5011@ziepe.ca>
In-Reply-To: <20250226011303.GA5011@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CO1PR11MB5057:EE_
x-ms-office365-filtering-correlation-id: 14c26e35-8e85-4048-303a-08dd5610a3fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?bNRtTvM7M5CI3UhdCbqmTzp0NOKpvEKDh6tlmyKIeHB9l27y8fCOROISJa4R?=
 =?us-ascii?Q?CZEOrXOy9cTA1mEWL2ZKyTrv3cmnzSxNHpNbqD4o5BBBnBQjWWX4thDQ6+//?=
 =?us-ascii?Q?bh0KJUF0ayco6uXb3QbzrkvXmLL8z1GljDVL+rQ+KNepAbcsqkfhpVTqvTsI?=
 =?us-ascii?Q?jHoAsMhHEQdSzRtuMzLSEjGnUNIO1FPJ3+IhRvc/TGgiWhHGJzYTax1h/0wq?=
 =?us-ascii?Q?7BYVyqrfkCo/BUx8FZ/kaQGD+g7sHIubvJfS3fTqjXVlCo+u+wuKOZkzOGxr?=
 =?us-ascii?Q?wze1h5Tuqn4cSSKvyreUThnRUKg0ekcR1JtPLl5WIsINPma5kpr//iNsAO4T?=
 =?us-ascii?Q?ziK5l0jNz1CysZDXiJ08OOKPR0H5YYbidAhhKMbW3r3zq5mKlDgMwz/neZsp?=
 =?us-ascii?Q?g2o/IfZ5tqNfbdHbgShTc4eBf61GUlEF0xbEot9PddH4y+QHL1qC8kgx8g2a?=
 =?us-ascii?Q?5/mhfi/bJ3IIbZB068kMKp8jWGq2iEmNmEdRYGZhvLO3HUqmR2FNQvZcz7jK?=
 =?us-ascii?Q?TisnBBLaVxztRbuAT/uIM2rsDURhJeVkH7V9JZ0oDLhQhnEa5ZEKWqFWpQHy?=
 =?us-ascii?Q?5oxpDJhaKhIL2AyJee6UrOSKs2xMPqRwnp9TVtTa19EX6xRKY9WCAWm8+7FG?=
 =?us-ascii?Q?mqaPv59D1h6JrR7epXVMitL0EoIOj0w+9w0uX5KS8qzTofTh5ZexwFOiMO5J?=
 =?us-ascii?Q?WO4I2n+PyQ8Ihx+1FYM2QVZQVEhpas41mSy/cXecYIDNXgbczo7vSwo2fBz9?=
 =?us-ascii?Q?3Nqeyrt0z5yDJOlstQwoblmESL5Ty8VjjsaFfDzK+k/wG98XLzimVu9DndXA?=
 =?us-ascii?Q?2+u13X2niSnTfc8yIOsY5o0BIe1BGCU7d9pqW5zjYRq43Ouyt989qPHqsCHi?=
 =?us-ascii?Q?qKjsgyclIfWmCksqojkcYTmgPcl4Ys1sYqYgsV35+G0K4VQfg2ejfSEPALpV?=
 =?us-ascii?Q?WYPauHhmN5YBggrWngnrCwEJQkqUIT9GFyiaQkjPG4PFcH6X7eGBxNa3ccYn?=
 =?us-ascii?Q?qhE1RSsTfOz4pOLda0JIyxb/Udt8kE4bT6xNpAovRtNHXL7O3YGCNU1o0SHf?=
 =?us-ascii?Q?EuZAKGdFXs7ncqxOADFZZtIfA86tN0wZGqrb2JYicKnqOI9JkXD0ugfWewlT?=
 =?us-ascii?Q?Vv+l9hZAU7EjQBphhGrh0aGXL40n2UsQYsu3wMbRgIKlm8bxgFvXOxJWntDF?=
 =?us-ascii?Q?A68qgWQGjvInvWALi6MQ8B5vbVjdhrRAogXn+Cr+5kTnPvyzNBtjbdj9VCPn?=
 =?us-ascii?Q?9jktvo8j7Nvj0N3cjo/qntJwbo4vwcnyQ7f7ExS5S9037r8JAldW7UVe7BdY?=
 =?us-ascii?Q?GDbeSmvUcZy7nqSNdXjCTAQjICmrjl15U0lJ5ksHoF0VNY6hki+YC+6eZa1K?=
 =?us-ascii?Q?NyeeGg1xZAsE0hnD3Ny5+kEn/LNgNp/wyal5iEqb2C35+T7lsCwjz9fLFQDF?=
 =?us-ascii?Q?L/CB6ovTeQQv5qG1IHc7l7QDuNEJdbUs?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2Gc7P1cgzRVKZ1ZYdqEPmjH4hyBYKvLqnyeerjIjIY7E7j9PwGtiWGWavIvQ?=
 =?us-ascii?Q?VJ5YPtCyBMQ27tJqiIhwZg6SKXBGqbsbm0Ru4Sep86K7ZM0prKQcYlLQdG//?=
 =?us-ascii?Q?jaIF9Ge+kD2cdoUtZJFsKsaIEtsyGML3DdY5LpWK8G2XqOfgG1pnH3lJaHgg?=
 =?us-ascii?Q?++ppH3YxFuOTdAn8VtzbUHSDUwX/38XB31Xx+7xZneXwwFiJ2cXNYC0WwsIu?=
 =?us-ascii?Q?p0V4w9JVnWB/0+43C14OM8yNxHIcqhXWQDD6kDcr0zRL2ZD4//B4XNDrR3OG?=
 =?us-ascii?Q?kH/EYjc2R7mu4Vycf9/UuHfI9DVo7wX8qvfRx/9DaAarvfrIGT0jmzA7Zood?=
 =?us-ascii?Q?scNuTEH+YGu8gtlqfllSSy1CGjLEN6KyoGxMmP21iyCKVHiYSASY2fviINSE?=
 =?us-ascii?Q?gqhs50Sq8cc4cULs7FfLg5IOFVT8zhPFTElh5Nu0UxehXorClj1mX2tuPo+t?=
 =?us-ascii?Q?I1EM9maVaU0vz1pBDT0vk/0AHONlVITw5RQDr6yfw0uwBwIKdNb3YpFQcLVI?=
 =?us-ascii?Q?lhk/XFhA7TEmzTgpaszS5jRZKwOhnOk9P53JXOZ9M+yx/iQe4FQbxVciwz4I?=
 =?us-ascii?Q?es+66I4dQMmSynIiITDZ7Bj5iEU4dZum6Hurhsj+yCsFI+4e2iGiNV1SzVHy?=
 =?us-ascii?Q?EK5yK916z8CUSlhd5W+plzhOW64i0t3T8O4InT5omlgm7n4ds62WdYwrI/Kq?=
 =?us-ascii?Q?GDjon9quIKFRGdK4M4aw15pwKhFeRy3+PKpNi/4VgPqxG4sHWQyKEF0QWhru?=
 =?us-ascii?Q?qmk6+XB0vESGzMzT52opRCZgkvcAKFQddF9d++yyDZJmQyAtaCtclsBT587s?=
 =?us-ascii?Q?XPe8KzT4JsWA1A572VAKPOEFokN7DjhfL7ilmvGnv9qMOMQqAyjGY03TOhXx?=
 =?us-ascii?Q?cbWOIxHIWGeaiF9iKXWy2OEgGMDL2oiNwqUkuB0Q11iYQ1mk/HQOA2vq6ORv?=
 =?us-ascii?Q?ZUzpnM4sGCBakIcGrHD984Qsa06yqhMx6HipMr3OQB/Zm3Gibv+GUHanBdDw?=
 =?us-ascii?Q?doW27p4qoswJXhp+8RueAIYnigr70Ye9RAo774r0HE8XKcH28kVRsCzzg1wm?=
 =?us-ascii?Q?EttXxkpVk3bBbXbj9GNaHDRG2cWhuZZ3PVaMkG0naPdU6+XuXMpyvdY5Wp0I?=
 =?us-ascii?Q?rcvkiJp4EdnbawCuPdvM7a/STl2iJJ5J8CfKzgIkmXgrYLeGWSRtnDxoi/CU?=
 =?us-ascii?Q?7auNGgQ360euZ9YkuCgKUZ8ToIINR2RDCYe7xnkDEqLSVmvc9fLy6X39gMTT?=
 =?us-ascii?Q?/6o+D5cT3/LFkGzCGsohw2n92HET3jAaQWaGnSOEhubE5pseTaiTVnN/yqa1?=
 =?us-ascii?Q?UhyoI/j+h7aZl2RQXpmjOzGoijeV0QNarDoWD0h6cPu+gusCq7RD2/K/kBII?=
 =?us-ascii?Q?31021CDYkCUNYWorsb7o0WC65cVQBi1rxPRE4odEi5QVfr6Jn0ixCxiHcFRV?=
 =?us-ascii?Q?BLc1Xn56zlykqFSeRlfdWeMM46OwhGLjrFhsdEHbsL7It+yL50XxtpzA/51+?=
 =?us-ascii?Q?3qe+WnRtlV9g5q+xQ3xYVIHDQfdaKcUxiBi1WWlZHlBC0uM0KG2+c+Wsg38i?=
 =?us-ascii?Q?+owJgPc3P2d015yWYOZhmGWv+yO5OeGA7vuGwEvp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 14c26e35-8e85-4048-303a-08dd5610a3fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2025 02:52:42.6675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dYp9SA+/aq2cwNmqWWcyjbEYF27UCvIIKAHTaRK04YfwpT8CPJN2YirZzfplxt87pMF8RPWQ3nrUqpO7tu1Gcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5057
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: Wednesday, February 26, 2025 9:13 AM
>=20
> On Wed, Feb 26, 2025 at 09:09:29AM +0800, Yi Liu wrote:
> > > Not sure how to setup #4? The core code also needs to detect coherent
> > > systems (ie CXL/etc) and refuse to do anything other than #1/#4..
> >
> > The DPT and the HPT validates physical addresses. So such tables need t=
o
> be
> > programmed when a physical address is mapped in I/O page table. So the
> > choice may be associating it with paging domain (e.g. the S2 domain tha=
t
> > converts GPA to PA). If so, a domain alloc flag is also a good start.
>=20
> Hmm, so you imagine doing it as a side structure under the map
> operation.. Maybe, that will complicate my effort to unify the page
> tables somewhat, but maybe not too badly.
>=20

might be OK. suppose some hooks in the map/unmap path allowing
the driver to register for updating the permission table.
