Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDB42F3C0F
	for <iommu@lists.linux.dev>; Wed, 16 Jul 2025 11:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752664841; cv=fail; b=irC1qQh9SRpD5ceq1/xil0jMr5PS/xXpaXsZuXXqIYCj2nh9pcUspfuSdhELP8Hjfaou9expVna6OE86GbgY+BbwH7qswU8nXUef12BySu/9rczCHRvDQeo5CKkBdBA2gOhTLUAcZJG5ntSmf3W9xYpWVg0fXbYQT0Q86/Xhkzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752664841; c=relaxed/simple;
	bh=tuv5L7N7pjmc+epwR5j6wFMqx/bYDfTTQHGGUTidnmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d9rVav3+5AzsJkTIx1uzwCbCUQrX+pQoEJm2SUlZReDEnPXTR6z/7nL1Z6MMbVzMTSnzxQcxS/7ObECHGQW0BmqH380EVU7+LGFmcRSTewwc1n1T5jBJqkEPGaqwVBeHBs2UP03aNg5lRG2/9IZnPQ8p8r8Lgv7s4HB0ncpNFn8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cwc4CFLj; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cwc4CFLj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752664840; x=1784200840;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tuv5L7N7pjmc+epwR5j6wFMqx/bYDfTTQHGGUTidnmE=;
  b=Cwc4CFLjY5uq9clTslm1Rjcmid8rfDZwGzItEqILp1wJKcvo9g67uTtH
   Jf1DMTuiPBVwzxyW/qFazdovKPFUF5IRQemhDUt9pdIIUyD1FEFwKuJeS
   tn1CvC9x6c5rCJ57X53bWKUKMiMHeNm5Tt639Kpl5G5XU4eUj1sLuVa/y
   7wo9ms2OE/69kXDLXiTzrM4VYK0iXSgIcn1XfUAe+zbGWPKDaGECL8MI0
   6xh+w705GEFIwL+ux++/C2t44kp0L32KkraFW9Nh2uZF2ICTTCqXci8Jc
   KI/5Z0PTTaVE5CIEsGwct2oMbxUl0fNbGWkEQ1/SoxRVe7nYU9t/0V0oR
   Q==;
X-CSE-ConnectionGUID: vmwDUDYwRKyXl+Wea27jMg==
X-CSE-MsgGUID: o0Y4iEpVQ4G8LdDQKHCnSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54845435"
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="54845435"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 04:20:39 -0700
X-CSE-ConnectionGUID: b0RxoOx7RaahP+MG8tuyPQ==
X-CSE-MsgGUID: R8TuW40LQX+HPl1rhr6jwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,316,1744095600"; 
   d="scan'208";a="156879566"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2025 04:20:39 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Wed, 16 Jul 2025 04:20:38 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Wed, 16 Jul 2025 04:20:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (40.107.243.70)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 16 Jul 2025 04:20:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkeH/g93+jFuUZP4Qw0SX2arXYp0EJBA+H8z8JcFQ/y1+/331CnRv1k2laf9M+Lr68DWUr290fU3kY1X0lRc+wrIqBDwQe3g4UsLWGYdvRMx7RdCh1wjG9DLqv7RWZLVHBND7eBICmYFg9u6r+BXVC4oJZ5BXvvG19AU6C6hcYDVLK5Xnq77UYX4ouP+kzhK0wLAolBIGwkEJJYHucXeXUiittEYWm8mTyQa/aGDhvVXJQszB3FnAqMeZS8Vx/XXawvUiHFksLVyqDqLYIkJbuP9RMV7LGHcs9ynzyGIYtzJvkk6P+lnmYRROxuFezvlmxux8gAp0ZgU5iWzf4p0MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuv5L7N7pjmc+epwR5j6wFMqx/bYDfTTQHGGUTidnmE=;
 b=ZnQ6c9eSOh6OzTnGx6wYwdv5iJ2pTUDLKCfq2CNwLNnU4SZljR/iibWNUausrp40shwLrpvfSm/sV3xyws3R0EJlWJ2HHTy+eysx4crBtuV8R6Wv6/bP3oaqz9WyrBKorXZHi9kqDSxFOFYshwHASm4uhUaDHmbgVxGFJ2Zgu8gpR2NKKqBJzWxS1TPg8/9Fdogq9ZZ5JAOzMAg/R3nkbLI0SR2asI73ZbBAAwcOJL5HEjRz1iOQfalvghY101rWCs2WnAqIEsF48qr7qKqoP04a45ibkErqzGZYqxYeojoEfMqyT1aS1goyGn607c0uvZD7s9UfGbULtmxy+DTDSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW3PR11MB4681.namprd11.prod.outlook.com (2603:10b6:303:57::14)
 by BY1PR11MB8056.namprd11.prod.outlook.com (2603:10b6:a03:533::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Wed, 16 Jul
 2025 11:20:32 +0000
Received: from MW3PR11MB4681.namprd11.prod.outlook.com
 ([fe80::6561:fd02:e89d:5b06]) by MW3PR11MB4681.namprd11.prod.outlook.com
 ([fe80::6561:fd02:e89d:5b06%5]) with mapi id 15.20.8922.035; Wed, 16 Jul 2025
 11:20:32 +0000
From: "Temerkhanov, Sergey" <sergey.temerkhanov@intel.com>
To: Jason Gunthorpe <jgg@ziepe.ca>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "David
 Woodhouse" <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Joerg
 Roedel" <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: RE: [PATCH v1 4/4] iommu: Notify requesters of IOMMU fault failures
Thread-Topic: [PATCH v1 4/4] iommu: Notify requesters of IOMMU fault failures
Thread-Index: AQHb8aCKDb2q7kDp10Gg8Qrig+ZLpLQxvNSAgALjtwA=
Date: Wed, 16 Jul 2025 11:20:32 +0000
Message-ID: <MW3PR11MB4681FD69CC7DA5276BC68E798056A@MW3PR11MB4681.namprd11.prod.outlook.com>
References: <20250710134215.97840-1-sergey.temerkhanov@intel.com>
 <20250710134215.97840-5-sergey.temerkhanov@intel.com>
 <20250714150031.GI1870174@ziepe.ca>
In-Reply-To: <20250714150031.GI1870174@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW3PR11MB4681:EE_|BY1PR11MB8056:EE_
x-ms-office365-filtering-correlation-id: 1778203c-a7b8-4eb3-548a-08ddc45ac75c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ngD8ra5Iq8LVUtXJdUd/qHvqIYLgUUvoGFq7eApA+Pp5YKOQYpSGXRKsb5b7?=
 =?us-ascii?Q?E89gW2zya+FjNa6pk4BA4O7Crx8BIdd2Xmw8k6C67z5nwvyYraBXxt4+y0uA?=
 =?us-ascii?Q?OX5tSGOYJE6k14DoEeamSCy7kZoKnjq8oLvzC36x40GfiqSw0yCP/Rq7zHVW?=
 =?us-ascii?Q?B8BbSTCsUivixOYZbIyh09fOKPpsAPckF9AhIgnYu+MmhiJiiAB0nIS+pKIb?=
 =?us-ascii?Q?84L88pBRM2+sZvSJtJL9hAy78RhrtJ08wbCRHL3bddFPDy7biCeU+T7aTGmr?=
 =?us-ascii?Q?bHOdQVoY/3BvY2ijHqltRWGWxvuYex6Nihm0snwjUCx6O3DBHa/uaIwpBCC4?=
 =?us-ascii?Q?s1WxxB83SbxrKy4L36V0IQ7XmVzaZuqeUT/+KU7Xx1bi0r55u+Luv0BpzXx8?=
 =?us-ascii?Q?Us+lKTwW+lMXKOA1t9qKNbIoveckpLpjaHFvc+iT2zpGVz3ZlgOX2yYvv7MV?=
 =?us-ascii?Q?3XfKhYOubN/qZuoKiKnwBjnOB4QWq5q3UCzaT7Ha7+qg8M13HNixs/vGOq6h?=
 =?us-ascii?Q?JflwssRJMiQ4SlQmK9+dPPRQzI2++UvfdrqpOiiJ7xIqvZGvA/44hpBtcqfi?=
 =?us-ascii?Q?2HnEOhyi90zWX+FN22+GlytJJHdNecax2GZTJL5t9k/jWqhXC5i7l4wAPhRz?=
 =?us-ascii?Q?FCyIros9NN7lAtRizbrhawNgTwZCuCM5KBErYZJ7JWjgl0u5VC+Ux+ny0zOR?=
 =?us-ascii?Q?2WPSfRSvRtemoEWs41Y0cOeiMyelKY45oATX4m4RBdkckSwz3sAveRRDt2kV?=
 =?us-ascii?Q?KljChW1YCuEbhIv8hfK0dTTHBY21Wv8yhBTXJ9CuO5D0uwyV4R/2w5Gmfe/f?=
 =?us-ascii?Q?Afp3Qk/Ose4IadQA6CXHPlAOvfVrmIH998zotnbBj2QcbP9BWcjYDrY/+doe?=
 =?us-ascii?Q?2gyhpSLe+ljDz6azy41brTHy5HVGKDoRtE9xDzwCPIMo74aafMjFTKct+9XC?=
 =?us-ascii?Q?VAdaPTpsHCnCru+cqoIQNjeq2LIjGXPZFbkd3kWLml3KEuKHAaQznUw0jmag?=
 =?us-ascii?Q?pU3uNyqx7aHdiAL1VRV7aUur4IM9QcXjFHsRDsH3XKVdo3PZWOAcTAuDO/VZ?=
 =?us-ascii?Q?IhA5IhTyaM2xwCvIrZ4K5laKG0dfD5GvOD3LwPJk6ucJCt/Xo9y0F/2blf0A?=
 =?us-ascii?Q?d9gQUTLpedFoYYkEJ8SchduBleMKG4sl+ZdXrXrImyMY307Rdv4Vsdz/DuMT?=
 =?us-ascii?Q?HMHC4TVLxkaCyu6uy7rKgpQqA4ERcIWzbKsYONmP7jFFHMckpUh8SowJN0mI?=
 =?us-ascii?Q?Tbn+NsxWZ+1TPZ0N0LVb/qrv84AmwtfMYFSEkNy3wAbr47ROAtjQiGT5VsJX?=
 =?us-ascii?Q?iPA91IKnXMJnuoJuNvyUo0XRCL3tLZRn62tsriL2E6WlM8vBZ02fLf13CsEm?=
 =?us-ascii?Q?pK3L9WSiMa9B/PC83eP1GRuSPGP7NS6hczqJ4yWPzQJlG96HHsTYMdKa/WWV?=
 =?us-ascii?Q?nmXrpHXMy3rtHmn8TsvgIZF4P/RZ6kIFFqRuXd16li1zBc9tU+/L1A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR11MB4681.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UIzZgT2wmuoSXiCTNk8T7kPGUf1jddWd4DTRvSsELeFR2uWXqPQG7pHfVgCa?=
 =?us-ascii?Q?3N6uErbGymPk8Re57CIT/HhquYU3OkmJRaM+uR6u8c35UrwtAW+S1wUncCds?=
 =?us-ascii?Q?brswBaJJAu+d5Nz2UB8n71JjeCGAouHt8R2O+fvvhQT1iDg2eIpevs0+ssRk?=
 =?us-ascii?Q?dAHQE20rl9gPeLVUHC7U48TyVgJq6BBXL77oNAASyep6JykgAQAqEWCxveKS?=
 =?us-ascii?Q?i1tOjYM8UXNp/9a/Ec9MDkAt+xXpSCnYxnB5aEzko4A9HxfyGoxDcdrsjMUi?=
 =?us-ascii?Q?nuCUTxCVmtkQPf2sW3Y8RZyeF7Z7YGXiMClyC5BjGhQJX1/Z8fBCX1pkrSS8?=
 =?us-ascii?Q?3IS93bci5WEveEYjQG9l34EUmRvqfkH0MSqjNCQ/WttRzyZ7ggpdMyP+QcvN?=
 =?us-ascii?Q?kM9WXkXoBASeKSqA9Z3pJ3hlsOBvrYtCVOGNY00BAcRp8ttje4uQub3PmJTC?=
 =?us-ascii?Q?lnpkC+XjAv/SkkBrdHzKkiWbsyqEpD2p56H1ppiuzV4G97w8hAdk7IA1ixty?=
 =?us-ascii?Q?JS6PTS8RGYTp3QwiDdxbEkxJ9O/1pA9WAFPG+3i5gnAEae7PE2ouxCv8J4R8?=
 =?us-ascii?Q?cdcC7mX9+PrGWx6LmbLTwhZc7XPL8xVLHihxNOLIjTJnQlpWnDxADS0NU/QD?=
 =?us-ascii?Q?GbceG6P16plgbIWW5y9WLq4PMeSNUQy3rA5eNf74rHC0cph/YxgKlAa55NZM?=
 =?us-ascii?Q?pwDxtxPZ6TRx96KtIVOAyplYwXMt5qFb4TokRqtSuoBrmNwuuVWNK7yWXyyR?=
 =?us-ascii?Q?6kj7ygNlu2Mny3ddwbkWZWbY68Xvf3runE+nrOWYSkaSKfYSbBJAzZb1A2dr?=
 =?us-ascii?Q?paSAVK2UuP9NuVPD72pkt7aIco9xfma7buIZOts0i72VZyiaHKV1LPHxOXoT?=
 =?us-ascii?Q?v5wRc4FtsZf/N/jsqbcO7+N0JEwlahuVZiBrQ/Ao1O6sNg6Ku9/lQBscfyS8?=
 =?us-ascii?Q?6T8aZm6PB9jKFDoB8bkyVrD2BUnRIOIB+4UCZYi6TBo5ZCSxF6tigJLs0Ghm?=
 =?us-ascii?Q?+SJVq1ERfO+1bSIc/t4ufanrDaqSKWr5WAEdptjx9mdsXudHd86/UhQZeAKZ?=
 =?us-ascii?Q?OJnmW+UXMIHXIuOojfybwiMkVqAGsXCN+9Fa+3lquBFYwm9UfxRW2TvfqMbz?=
 =?us-ascii?Q?9HaYKNMLTdsIiWVCH2L5S70A9gE3+gNWBmVMkiqKSRin9urtJCaBjPfF7Lpw?=
 =?us-ascii?Q?NxB1+Etd+ajIZlfw+jVrEIzaN+8CxrdiB57Z19OrGYQtxLmDB3l3HEpFHUlZ?=
 =?us-ascii?Q?DdAPfuyJBwUoQ2yIVsJoY5Apr8ExRZ5ypzobqC+2v2r24HwZkzFCRKTOlJ2M?=
 =?us-ascii?Q?WqyuJtcHMcfMsCXhI3BOdd7kSyXmciLyTrk4xPLa0Q1GzuGqcMjznp2GwZfo?=
 =?us-ascii?Q?A5estfj6Ulx1Ml8jo0qkVnDQm8gRzIiq2JYXiOPeMPAIeW6JMacB0vQ4je6D?=
 =?us-ascii?Q?rGKE1dysGYBBFuhsxVmYXg8LAIY2ycTEAglkEqjTYOxy0Q+HHkv6huluvTpo?=
 =?us-ascii?Q?S5ji3AzKGj+lP9AeEuy4Ib5uusQklWXCYqOwT40W6KvQE3d4YBeKF8wskY62?=
 =?us-ascii?Q?O+c0AmmNcb7wA5mKwMNj8jZcy07iAC9svRXMv031?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4681.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1778203c-a7b8-4eb3-548a-08ddc45ac75c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 11:20:32.6737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xYNZY8bNV8+35HbqnaD5f26pP7QcXytGO+b/SMs7+yYqUKmKganjIQ9O4SsmNJQV/oKUofiZSES1TvRs9qrbbAxxR1kGdBAkYsp/r/hT4nI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8056
X-OriginatorOrg: intel.com

> Look at how iommufd already associates faults back to its own struct devi=
ce
> structure side-structure.
>=20
> I think all you want for this problem is a way to hook the fault callback=
 chain
> on a domain, and that should be local to the domain not global to the dev=
ice..
>=20

Moving this to a domain sounds reasonable, however the main goal is to reus=
e the kernel
SVA IOPF handling code to the maximum extent and only provide "feedback" wh=
en
iommu_sva_handle_iopf() returns an error for some reason.

Regards,
Sergey
