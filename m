Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BA61362
	for <iommu@lists.linux.dev>; Thu,  6 Mar 2025 03:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741231316; cv=fail; b=qiHkXYd9lutwlMuQWFOEs/wQ0GesZW97ocmEcGRY/R+i5i5RmDFNLjss9uOg5DJ42gvVZkPEdpM2/CpD6ZbAB9VmgHl3CSs0KiIk3f2mMrv2hcYJL48iNFj1JpMUcDB/m0cWde4Rg1xVdLRUjwYD/jrqrq9iU3oC/JJBaxFnKyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741231316; c=relaxed/simple;
	bh=/ufj37xei49Poo99IY1rAL5rLd6rmMUkroeLw6ay0DE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IplLqZwM3xcmsxzhYBbPqvAoZpGdNuEk+IVRsn42g5BvIKKjNbHhbBABtFtYCb8IsksFdvxkfF8jHkpdB4XgBGdG91wy1qxZFmqm32KFajiaXhQ72+dLyj0K4fsITQv1l19zeayVFbHGFsPqz5P2Sw09PYsCavSCmH474mTwqys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lzgRTIha; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lzgRTIha"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741231314; x=1772767314;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ufj37xei49Poo99IY1rAL5rLd6rmMUkroeLw6ay0DE=;
  b=lzgRTIhaVt5GeQlhGW/Fi8/yt5KWTvBr+fNZJ6nRiVdi/9rvj42snoIo
   kH20wjir2PAuTZYeW+kJAdBBOf4aZWjrGji40hC9EQS2bB2zfbstMBeJh
   3GD2fSea3Q37IeUDMYOnf6XRptE34IF0mF81FwwLD9TnHmIWDWkkX+rTM
   1ac3m/r7NB/SX/OOvFl6I8J3stQC91ZS+Or/OjIEdcwXv+7436s4G15aH
   DmQXRs8PVWB68rM16q1qa8N9nO/+NE43hyDKyiCDlaSmXonaVzibB3m8W
   wrtJ3Eb7TNfXx7KMqBYB8cRmCsxQM7LzgqffboFnKl2Qy5FLG1qp2pCab
   A==;
X-CSE-ConnectionGUID: HTPWR0z6TRKLuWynVaMo4Q==
X-CSE-MsgGUID: SmrbmUWDSeKBUG8VFTOPJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="53625567"
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="53625567"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 19:21:54 -0800
X-CSE-ConnectionGUID: 9me4JedIRf6IlNBrSzfOlA==
X-CSE-MsgGUID: SL+apo2ARneWekbsu054CA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,224,1736841600"; 
   d="scan'208";a="118607817"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 19:21:54 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 19:21:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 5 Mar 2025 19:21:53 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Mar 2025 19:21:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ior7WssLOEVXKSsMG/DwTWfd7vgoyuJv4luMQYx3U4zeAjhJ65Oy+SZ+cO5EVvJYnGnRJYq6ZYSgITkgsKvCo97mWu2rq/GFKDiMfBO6PTPiAOCb1IALTBtKIb6SApUjPr7ltBk0n+ItyYpcBfkWKWGnC2GzUfzNrjHObrUqeh4tViP63i76IjDYMENNxRGZCbJHxFdV43RarRqRi9K23wtLuC9bfJCFFURzXePTWoNwq7K4mjKKOaeGbWE9N2ojfFJTxO+1D79DWNeav7yGNxTEfVUrVFJ2PVNU0Kfk0a1ssz9+yVr4oQzxfuSvI6OnzulC4BGj4apfxDmcG+cA2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WIoW7Jt22jzk/LT7OuSajEV5mrGyki9dxKPcYjGtmjM=;
 b=Rn9laOfF39/Fqo6dQcIoAAMTVG4ugnRY3Cf4zbxaEs2TXFOFwdi5XFgLIQHRdcC1Xewl+ahrYUswhqHZhc9CKO01X/85eyVLIQdhZ85DWOdkAnOIUuxCmRXabubdgetGfj+zACDHzT0rJ+02NUqFe7aZV1z5Pcc+SM8/AqBXc3qWYQc2xMEWjWIBOtUb9ogIqKvb23LfE0BAAJckDghXk7cqbqXfMhjH6hDfY94czSOYo8SP5nhP1mR66NqoFpCehUBCz8kzDDXE/zBj3fHHQ59hb7uSHWmSS786hEwJKebmVQY6MNOjWAT63UHbiC+aNptzETpo4+NzVYRkVKsqkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by LV3PR11MB8484.namprd11.prod.outlook.com (2603:10b6:408:1b4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.29; Thu, 6 Mar
 2025 03:21:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 03:21:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "ankita@nvidia.com" <ankita@nvidia.com>
Subject: RE: [PATCH] iommufd: Set domain->iommufd_hwpt in all hwpt->domain
 allocators
Thread-Topic: [PATCH] iommufd: Set domain->iommufd_hwpt in all hwpt->domain
 allocators
Thread-Index: AQHbjhRS9nBR3plzaUGUgMqPhEEf1LNlcVTg
Date: Thu, 6 Mar 2025 03:21:03 +0000
Message-ID: <BN9PR11MB52766B3F3ED1F7F14EA3B7B48CCA2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250305211800.229465-1-nicolinc@nvidia.com>
In-Reply-To: <20250305211800.229465-1-nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|LV3PR11MB8484:EE_
x-ms-office365-filtering-correlation-id: 66bbf0a3-6fbd-49af-5bb4-08dd5c5decf2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?1TD3Ty+Nqw6g9rUg86rBJzLfm4nHH4FNCvGH/2qFJvfmfQB0xCQSHKMuTjpp?=
 =?us-ascii?Q?UC9akCnUu4X2HK9qS+38OrFcuH8Xj9Pdzw7oFBaGuPNdH4Rnd8XqZ6SrTYc3?=
 =?us-ascii?Q?KTRsHbqd1gyeSMLgk0nKy4GSUc5zodEfz6xVp4QveawBSPQuWgMgm4L+FA+X?=
 =?us-ascii?Q?QH/6FSyirlCFKJdl/C3llgfKo9xaxEVrQQT2wCT+VuvfmgIXdUNuVU3Y9Eej?=
 =?us-ascii?Q?Vr1OIXQsaINQOyCOn4HKXL7ydVwicomuOzfAnM81gTcUnvi3yDEXEsvop7xn?=
 =?us-ascii?Q?3/AoeLqUjgeKbKM2yTP+jRSt8Qzd0zoJ46vY7ASGn4YNUWKMmObVBVnFcrmN?=
 =?us-ascii?Q?wyQq+LWQ+KbSgNqVM51yKuvIOANZD8Xtqlpl8UvQqb/vZ6edAza1MxhV2MzT?=
 =?us-ascii?Q?aScWOsS3vXAhMBN4wecEgxkcdp2qzk7hW8zl54WoKRjFKFUA9UiUptmoeujg?=
 =?us-ascii?Q?SPb/Mv+O+qpUF0na2eaPR2E8nvz4aBqajYdnzCr7eJshs24kbzi7rG0phjaf?=
 =?us-ascii?Q?TX8KR3HMUDQV+FyRB4/1n66fledbIZXL1FBWc2clQeGo7c/Q1au2Pt/4aTLU?=
 =?us-ascii?Q?eLgQGE4VaJPbgupcJT3OCN4/O+leFUoM2YaxXVUlMDdea3HYic+3iBM4Kmue?=
 =?us-ascii?Q?W11NZAfSwgtNtFQO2wSxjmn9lFB3dRkAS+T0qFGi0naLQd4FBdmD0S7PWDBA?=
 =?us-ascii?Q?7Bggr9YpwSpQmZ/21YKuEjR1gv1ytkxx7VY4h9IqMdW4wpU0k+nZ/ndZ210V?=
 =?us-ascii?Q?3OTAF7ZpvTDU4nLqSDSl81qE1I3fufGRFqcxdP+9+FaPNI08XcMd5ctUVOmH?=
 =?us-ascii?Q?SZBndfIfYT/r0bErgyCJxsxHLDKQAMe1ALpwdBfkXoe4DBDej6TnG/8jBRy6?=
 =?us-ascii?Q?PZbJFdDUoASbnNGQbQ3aUQCm8THK3hHE7Ix/HCv+K3KLngwWN4AfiESD4Cru?=
 =?us-ascii?Q?EHzHUyLn6SULvr6UADmpwRSzO7qlI7vrCJh0NkUxWn31ZEOCTUDijmzBD4W/?=
 =?us-ascii?Q?pXgJPvrvTggFI5up6T29uUVW8GNkslrygRhS1cGXc62R+nIeLWFa7MsWeGwm?=
 =?us-ascii?Q?Bhf+2xBNvdVhdM2UcwjA4sCWnXNYX4YmekRB+pW6o3xtd8JzPFq/oqhaokl6?=
 =?us-ascii?Q?+thGHe8yWT2TEYqTChkEz5cqYN8B4ijXXt2kUJNRhKmf43J0E3gQfaQZ7iLD?=
 =?us-ascii?Q?Akbf5urokIA0KnwKslsRvlsDVqP2jE1pz1f5WXKWnWsPNd+3eaoctPAuxhqc?=
 =?us-ascii?Q?PGZxAcMY9TglK7ZNJB7Q3N/RUvK6vIMN1fqeYIuxmTHwD0rocXwcte0qY3n4?=
 =?us-ascii?Q?qGlRToK3r3RuOgY166PTmPs0ec3isrPFeiKYpL+79SX9Dsarjm7buowNHDq6?=
 =?us-ascii?Q?OYNYVVIVPG5oCJSJokQ/EP7iGvCKoMsEfODAnEiGVGB5elfj7DC7P7uHUD1Y?=
 =?us-ascii?Q?daIdlIxNsPzOE2K0cZfkLXVVbo4Xf9ou?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sYmKu8oqcPsoGhiCPOF4/cAjVfcEgajy4rxu/DP6UhbsYjWdO+DhCVFyulUA?=
 =?us-ascii?Q?lrAHWofFVoM+E2wDxCn9NhD1BIKdgWNiUL5BsN9RsQwEnwEgRr/LTdpm6vmm?=
 =?us-ascii?Q?uzSQcuqhRfzUc9JNXWbEkObFNQ4h4f62gHk65wrvhMlBazn8HqR6t6V2cTDI?=
 =?us-ascii?Q?Tu5MtQ8IXfO+ZwbESOuduf934HLR2WOxNduzaMQmEQuSbc+rRhuZOUwBo8WM?=
 =?us-ascii?Q?bFfr1rzTa8He3dqUvf4eAgXAY3AoCY/aZx2tcGax3ekPg/5fMRp0E2dC/112?=
 =?us-ascii?Q?O8CqceR6Rv0NeFrbJ05nSslDou5eWSoOdcaTxdqMsqId80fURD5tq3hSKvJK?=
 =?us-ascii?Q?EKndRMIUFLxeUKrGForPDAe+99d6dWQij58rAxvQ9eOz9q+iB7ye+YXatnC/?=
 =?us-ascii?Q?Mhftw/ysm4onXChe2IjMqvh+/BkE/c+oD1HffbsNhI1iFPVBEHufFV78OXfs?=
 =?us-ascii?Q?I2lrYFAQCYpT17LK3vg6ALZ58sMe/eEbwazv3UNLefAf5Oca50fGKwbSXGmj?=
 =?us-ascii?Q?NmrwJxbIvFxexGHweW25RH62ccaxSYWLoSp09M5XMpS8UuqHtKWQnHVgNujp?=
 =?us-ascii?Q?bDLya4UhntcA6oS4EzXkaZA5iYSPybN0pUHz5NgleP8Ijqzwz7IMJNqRZwCz?=
 =?us-ascii?Q?LZQolmd9f74Lkc/X8emJDG7wcZKxq7LLjvx07ATtqRct8TD9sUIfS4rENaLY?=
 =?us-ascii?Q?PewuJNaXpqMm1PKp64puSg3qzV8cUr+Bl5cBKEJA+QYW/AuJ920HjefjEn40?=
 =?us-ascii?Q?dwL+6qQDdyIja8RJSrFLIEhfpYN9IZdqSq3xbm1rWJ1vpz/Vskc/Aswp8HSo?=
 =?us-ascii?Q?M0ylKHP1iEQJVw3eKARG+ESMeZSslo2JwZS5PplzXhGOqZhVb61nGncURVBe?=
 =?us-ascii?Q?OFvNG8EnOk+TaX77xggYyZAlSKg3GSqcsgAcUjAQ5Syxnuqi9LYyQmqAKTup?=
 =?us-ascii?Q?wEQx/OFkVfisnClo0XINOhRNKMVXvekVS/krR9E+xASxqgtBPIRsSewUHMCM?=
 =?us-ascii?Q?eXyJBCl/lD+7WsQI7DG1erEkCjNfluGMIkkqDtmiYUtGtYzmTN0CIeAuVk9F?=
 =?us-ascii?Q?TNnd0k1lwJtr9cBsAwI4c2jnlEmGl8ZInZdUmRoT1kco4LLunbEL2nuAKZFb?=
 =?us-ascii?Q?94UreQYH8NSCG/UKBh3SVhO/e0/XGg+wyLX1uxYHdcfidhDixelnuXGo1YX7?=
 =?us-ascii?Q?+e/zAWSgd7Zj29EyjL8Rg95zjcXegwtm9LxE9pqE048tXavIdwGnvio93y3w?=
 =?us-ascii?Q?p5SoK/6Ze3KBk0b4zd+omrmsWiZdpzWGaHOU6t2IabODbXAeqY42t67hX5F9?=
 =?us-ascii?Q?ozFWBKbAgH9BjromMoacOy/5l059c5rmkyyGzME0GXxd3l1sK7WRu7pILkFI?=
 =?us-ascii?Q?+4/Gn7apIA0hnhDC0B50YpPfAK5dGnmH3drTl7yfyfc2dm/3mhkR6VY6+sC0?=
 =?us-ascii?Q?5yF8tM0Cgv39HGGOUKnwgedUSUS2QPDZIXj46BYgiGtPEtWSC3IpbBCT7nM5?=
 =?us-ascii?Q?27up7ji8JfN2vkWWOO/s7M5iw2ZRM3UWQL8RK15yQnLZOqQUz2zOHF+GU3FS?=
 =?us-ascii?Q?9WaTbnT0Ujy8Q6KiUMyg7Ux15/g2OtfTtuPaR7Sq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66bbf0a3-6fbd-49af-5bb4-08dd5c5decf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 03:21:03.3024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cUyvCIP7oaCOslswJeZmqXtxS2PMTma8XWIY184TD8m8w8Bm4mg0MJPJnB1hS4YUpjATk5GbI1A+LYYk5S+nQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8484
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Thursday, March 6, 2025 5:18 AM
>=20
> Setting domain->iommufd_hwpt in iommufd_hwpt_alloc() only covers the
> HWPT
> allocations from user space, but not for an auto domain. This resulted in
> a NULL pointer access in the auto domain pathway:
>  Unable to handle kernel NULL pointer dereference at
>  	virtual address 0000000000000008
>  pc : iommufd_sw_msi+0x54/0x2b0
>  lr : iommufd_sw_msi+0x40/0x2b0
>  Call trace:
>   iommufd_sw_msi+0x54/0x2b0 (P)
>   iommu_dma_prepare_msi+0x64/0xa8
>   its_irq_domain_alloc+0xf0/0x2c0
>   irq_domain_alloc_irqs_parent+0x2c/0xa8
>   msi_domain_alloc+0xa0/0x1a8
>=20
> Since iommufd_sw_msi() requires to access the domain->iommufd_hwpt, it
> is
> better to set that explicitly prior to calling iommu_domain_set_sw_msi().
>=20
> Fixes: 748706d7ca06 ("iommu: Turn fault_data to iommufd private pointer")
> Reported-by: Ankit Agrawal <ankita@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
