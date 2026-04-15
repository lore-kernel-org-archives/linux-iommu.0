Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FEA237648D
	for <iommu@lists.linux.dev>; Wed, 15 Apr 2026 06:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776235946; cv=fail; b=UPPga1IHQyaq/LFUxxQOXOm4Qy0bt4/SvK9fQtzxbi4rmmrYoNm5jawhPgZamdiIhcI+RIHEz8KCuyqJFZ13s72hwRSK20hJrelCW+RzgUq1baHBVsBsONB2l1AgPXjhueYYmdMULacmUXTlvaftEcIrxlA71cWXIVmKoUAQB6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776235946; c=relaxed/simple;
	bh=b5a3VqDhqjf7cI585esgP3i86d9AOYTce20VqK0O83w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dT4Y8qkV9aGdk0SEp027eK5EbY/6cojN+0d9v0iM2XJFz1luqSoaZoo6YyQe/Zzxa0j02hc2Gso3Ty8vlo0bw5Yffwrhsdsy/dNtTDF8EjtT06nnuIJHB5vP+29ynsxFOrHqrYRnlrmHqeEFcI/mz6agWPzytR0vptnMzj+6Jqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IvA7dn4j; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IvA7dn4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776235946; x=1807771946;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b5a3VqDhqjf7cI585esgP3i86d9AOYTce20VqK0O83w=;
  b=IvA7dn4juW3L6cu43fpXVgi/UZdH850wa8Q9vI/cvitK8RFFAP7vAQPw
   89NWhjrkaGccq2qcwwiSoXbQ3aovUyC22WGkb+KmMk9xQoL3rQLLWbWVy
   dRKXvhqxd6Xxot1ADBcE06AGEw1asUitDBvcAh8oau5BtQIv4CE+iHWcl
   jIJSslG8vjRI0L8ESUMZPk0YmergjK2Fb7XXLdQNnfZ1FmplLaYQQzG3t
   dXR6CRr03E1XF9ZgdQOn16E8c4hIGoutg2IjBl91xoXyioBNNnJ01g/Ug
   VbnvVAlsJJPnudU9qJ3Ayja8crs9h9LR10VSIpec7hB3TkzC9sP4og2d4
   Q==;
X-CSE-ConnectionGUID: tbac2zdtRXyfKCrYN87uqg==
X-CSE-MsgGUID: +ObQkgmHTfK+mQF7bm7QTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77385115"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77385115"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 23:52:24 -0700
X-CSE-ConnectionGUID: t5NHvNJrSeuK5fdqlBvjQA==
X-CSE-MsgGUID: rlVt7eEcR++bvsj9yBdeJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235264216"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 23:52:23 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 23:52:23 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 14 Apr 2026 23:52:23 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.24) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 14 Apr 2026 23:52:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RyGwyhotvdzPHKX4LgExHEgjAqFsXSWd3FKndiX8JJaovOOeSi3WHUBE1DJ7+dF3gGEVMat5GdmWSNlHYYDTNRWWloGMOelzvCDGmbIycMS5wC0F89gsPVBNM9jXVOhPBmmkKLndVdOgzNAxWEvF66aYlCEbUhzg7s6ocubGxLDjefWuwFSAMpF2ZpaXqkCAkQpDEUCPE7p4K9QryH+W0pzsOREOnrdULiHP/Bdjeyk0qDU4duJwXH7XGQjTbziGhwFtHkXplRD4nox9IuO6WB4RqHHI/FynwW3eLvjH8jPf03c1qo8ccQhKw0G9zUFLRYaN6HVFq1uzN3DiaaaSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mPBoup2MAgbaRyQq+57fnmvqdiqjFjeOqnQuLRRgi7A=;
 b=McQ8BnmEXTRlagc4DiqACje/zJ/Zi3rypa4drBVK3/rM1fhcdiZICiyCTj2XCds5TYY+HYLs9thPBUP2zGeA8oaQ6OfCyo+WbYr07l/1SBaS5F61QnSAEb0vIIqatK06RZ11RddIO870lHAzc9bvRlo1otYGGCGMf8iBPTfs9zm9K4OMTrY6idQVsO3MLxWHydUy/tfywgAYTFVxE9XccIEE8N7fObbS5mQd18o3cenN0yrQvCWeCqt/3AojciPid7mw7KmKIVKb6Qr2HgBO3P6N3nR14PRczRuOBhYn7iYFkE+I+kHpI7FFkCvbVxJp/tEhvHoe3EHZxu981lxFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB4856.namprd11.prod.outlook.com (2603:10b6:510:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 15 Apr
 2026 06:52:15 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.20.9818.017; Wed, 15 Apr 2026
 06:52:14 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "fangyu.yu@linux.alibaba.com" <fangyu.yu@linux.alibaba.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "pjw@kernel.org"
	<pjw@kernel.org>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "alex@ghiti.fr"
	<alex@ghiti.fr>, "tjeznach@rivosinc.com" <tjeznach@rivosinc.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"anup@brainfault.org" <anup@brainfault.org>, "nutty.liu@hotmail.com"
	<nutty.liu@hotmail.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "guoren@kernel.org" <guoren@kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "kvm-riscv@lists.infradead.org"
	<kvm-riscv@lists.infradead.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 2/2] iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V
 Svpbmt bits
Thread-Topic: [PATCH v2 2/2] iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V
 Svpbmt bits
Thread-Index: AQHcy/426CfvNf6EM0Ke4tEywGaYprXfsL3w
Date: Wed, 15 Apr 2026 06:52:14 +0000
Message-ID: <BN9PR11MB5276B545712B0A3C73193EF08C222@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20260414110212.79526-1-fangyu.yu@linux.alibaba.com>
 <20260414110212.79526-3-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20260414110212.79526-3-fangyu.yu@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB4856:EE_
x-ms-office365-filtering-correlation-id: f5702f34-81c5-454c-6b6b-08de9abb86e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Y/jRztQVlcWuDq7nrKFvYRrKNXk0gGcMXWdHlOM5edYqUGWYC7kv3qUuIZaZw+VNOn0n7Do+0I9rPz0E7mMYuYhpGC340pwhqWKZSma/gPoS9G78jhIFJWpyRJOhV37cN9AVR1O7zIMe2vZ6NpjBWL4LVvkpuwYttTL0AJXg7ZEFTTX/qLyrgpo1eHtZwwj2imLezgwvvZrPfFndlusWsjH2fb6QxKUxgPh0AVGZr3YTe5Zhf8tRJx6MLjgA/8ipUpP5qtsGYkLRnrEjZPqkjLxfFjYTgOCGmdEQeFKk0/bKXJEOd7fJHAQa0Yt9iYdnLUxbx0hQCFCgX+JIvrkmieGiPlYybTkEVRUsiNnx2NuOjyUoMUpODuUvwzTpMykXe84x5wv1Ko9xKsvE7gMAL+mBIl54Do6zZqjFhaHaeOc4ie8pVnyUNUhaWso6R6FgCbol5VYDuqmOCmoaIFBWq+Jk6TMKDCS4OvsVncMssu1jow5z4+NOSvBBCNmWw1jpLLnaEwAgft3GKMjaV6c7ZhzhDt85h4n9GG+49tev8Of/U35yNQPFv5ACtUcbHrFAh6USt4LgMCelgS4//hN5Q7nliydoRLoM4xXUA8REds0eTJXEgIZzK0DrXYzQP1YX75rZSov+aRgwpYgbFo7qvIrvyjCk1sDMf602CBuVlMAGavG06rbPSMjZB4W/Ojr9VPn6UDdCIQoy6pJeBz+HHOEqDN4IqEV99lseGPpk/Xjr7BhUoD68j8qnPF4BP34g54srJAynBSGrC1OoEGtCY2pjq5a2F/ua/amVwPYu7TBeK88o2kVEETtD8MgoqO8g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(921020)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?j2wCOMrAt2PLnbdSKVfiS+f/WHST5pV7Rb9dEl6567tX163G+qHbW9Za1Ic4?=
 =?us-ascii?Q?vWOce/3huEjQuUbpM5P1c0BYvZvCWkNQMzma8MMybboF/Oypg0SBAPNREkL7?=
 =?us-ascii?Q?KLrD/tPLj+HbPRAF9+581k5iIUVxU9xnQtA4+E6yY+QhX+zNtKEL2hKjFhPi?=
 =?us-ascii?Q?UD3q5ACpcyDc792Tq1dL/S0exB+CKGnjscoBCwG/GsNmwAQ2NcKEzLc/ITRv?=
 =?us-ascii?Q?Sx4gcHXECgjxbtHnrPpGh7mmB+zJvcdkR7JfunjPDrHLTiLE8r6npe0Shx5y?=
 =?us-ascii?Q?4Ozl/xNwufJfBH5t/NtuTJSNqPUNpxVyMBx7B289yxyziEabwld2hTtzTDoZ?=
 =?us-ascii?Q?y7iwNYQb3937MnwC5jHiSq3i0JWOMy74P0BUlfsazt1993XC53asDR5H0dSK?=
 =?us-ascii?Q?Xe0rg11umRIMS20rCZebFhLeqto59aTvZy8HOLHd4sZMvwWo3wzVOzt22ghQ?=
 =?us-ascii?Q?u+yeomSFQGnxEHmXqPBWDhbmlIF8rkYxkeNHsvJwm7ysru7j3TnrreqVqmpD?=
 =?us-ascii?Q?EVtkqZfYgStbxoj1BZnKFrvm1vDJYDNrF16BasJBunAMxpprkdfFblfVdxbX?=
 =?us-ascii?Q?utq93zU0t/ef1r4VaJUgzAaCfvtNJy4xIxd8OekRSIetKlOsCD3gsyaFkfKg?=
 =?us-ascii?Q?7OhfMQqXB9kx1Xy62D2KCmtM9iey2S2ZuWGOTcTZPRjZnH5FBYItCpmsR6KM?=
 =?us-ascii?Q?mqEHnIjmymL8LiQol+cPlTD/XP5ayr0ItI75zoWuHpuktRTY0CU3QRlsv2Yz?=
 =?us-ascii?Q?t863pkPS7UtAlZ+oj9NRSdCyyXMY9Kusm7PqHZmnp2WceR/0OGBF0D/wcsCY?=
 =?us-ascii?Q?Jd7L/cQU6yMSCDgEPsQRYg7aoXR9Xo8Q0T+L4pGjJ8GMEwhByM84j/47Gfot?=
 =?us-ascii?Q?HV6hASan2TuxRmJotVIIe4qTxL7jhBMQDpzYDFCTeqmPR3WX4jqoIbLuQqsM?=
 =?us-ascii?Q?KYCo0EXJYoLbBm6Jg11pbcz88SNsXdREsW4w1MY4hDpLAvyInJC/whqGLOw+?=
 =?us-ascii?Q?MnmZePJ7NWu0C9XQ99CL7XNw0uZbo8atK0/NOjUXzt8Lzj/kGeglfv1qTiGr?=
 =?us-ascii?Q?NzQGz00+CCpVqEi30B2ie+uysK60xMcEpQKdrRfJGezjRZsUfK+YFwJN+bFV?=
 =?us-ascii?Q?L5Sp5t/UiJJtRblTyzJCbDAc2hKiwOyuNcUr4Xcbdd0JTwCCyHWLmKNp+tRs?=
 =?us-ascii?Q?dvRt1mtlW9skqEBRY5fz8ctUx6wPw5yqyKmU3s5SgOwrWb6W8jbeo3FfnAJH?=
 =?us-ascii?Q?NKC8hXGat6OFpInL7un1B4YaIYusvVbtj7mkMLmfBc2L+5/onO3HvnXBbj4k?=
 =?us-ascii?Q?YooXASWtcWuXVGE5tEvij5mx9adl3355mVUmv/QYd9v/HUqA9pvUzOhfT1kI?=
 =?us-ascii?Q?I4abk0JUDSzodzJhzJGDzgDzj7P4IthQ3XFca+qDbbj3BDhxg9OUW0xU57M4?=
 =?us-ascii?Q?QbPtxAuGOPmjtS81S4869tp9pSVHhwONd7sxkOwQ6aJt03WpdWXs3ey9w2a4?=
 =?us-ascii?Q?i6kUtcDJxWaSE14GFiv8LhjoY7xVPYSxlOVfHdm0qF5iiaVcrT1NfPbmDwzZ?=
 =?us-ascii?Q?03yX8Xyp7lwubQaNnByIh2TzH+JFnE9DmLkbcFBoMKK6XMDpnFUit50noclx?=
 =?us-ascii?Q?wOwAuwdfedmN+P4tNRHUT3cgpogYC/xgBl44sAVj7MgusvTFYw2JYXoHskzq?=
 =?us-ascii?Q?SXPlv2qU0hmDQnyOoqoHWDPqtyg18Czm2IMBgJjHsl79Dsn7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: iMpKuqz6ZEq7lTOqT5NV2mc2oFSGge8vpmrt8kyTBCQlUZDLaI11swZL6mhqlxJKHoY51h1uWyOsF+4UF2eYI8wpGtGXwverlDKxFAaHqmFfiWK5VJRWnKx85dagtBsKIWk/S9trT+Fiy7U9ThYaMFEsMROaYoMQua2KlWgxd5DV42hvRQUKQJx5SMCE3f5ZvEmi88J4q4M2tGzjc2McgTRo0IaT0qfQ6Fg5KZFF7v/nvSansOPYgBQ3YUMt/i2TQI+Gdha9PU4+rlvXrU9j0tFkrRhpW32Cwa0xYtz7UDx+bSJNAFNfLqpn9jAtTtc1lJ+gUQLtRwukImyiECzZhQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5702f34-81c5-454c-6b6b-08de9abb86e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2026 06:52:14.5477
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YjI/RBSrntJTsp3J1Zs7c2y8lp6pO4TaeL1BIcfkBc22zZf8HrHFXck2xIMs/LzeM3vBFMlNCJ1zEXiuQvitHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4856
X-OriginatorOrg: intel.com

> From: fangyu.yu@linux.alibaba.com <fangyu.yu@linux.alibaba.com>
> Sent: Tuesday, April 14, 2026 7:02 PM
>=20
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>=20
> When the RISC-V IOMMU page table format support Svpbmt, PBMT provides
> a way to tag mappings with page-based memory types. Encode memory type
> via PBMT in RISC-V IOMMU PTEs:
>=20
>   - IOMMU_MMIO   -> PBMT=3DIO
>   - !IOMMU_MMIO && !IOMMU_CACHE -> PBMT=3DNC
>   - otherwise    -> PBMT=3DNormal (PBMT=3D0)
>=20
> Only touch PBMT when PT_FEAT_RISCV_SVPBMT is advertised.
>=20
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
