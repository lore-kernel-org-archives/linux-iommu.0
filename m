Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552AB277C88;
	Mon, 28 Sep 2026 03:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790567715; cv=fail; b=KTE/JOveBpH8zHAPhjAeMvhU5B2sHi7Ll+bCYkOiKbZ8wstjL2M0bQcNDoNN4UGtAb5BI7Ls0VDdhw9SeZkYGdJwm5hvzod5tFRY0gnyVtsQLnVZ+Yeiy/MgJh2w0u2SSjPYntdfQ1X9lf4pupA/edpTWDC94kiNt5x81RXs6K0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790567715; c=relaxed/simple;
	bh=S8wUOIITyRW9MGe32A6wwFaQ77T7rIW9ipLbk1IDT5U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pPorbF43Lwq/pTh1lYbxytFN/Gw/QZ+QuJjx8JiPegM/68dlIw2rE68wTpTjkFBoQ1f9afWzC9Y1u9cFBokz2N/T7jfzinoh4aA3T6qRaFhm9BMTGofS2AsqijEFzsh+ZfhpRFyxllcilbqPnw5ogilj+ZEbS0TOuJ3uE4ErZos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B7fsOdc8; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B7fsOdc8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790567713; x=1822103713;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S8wUOIITyRW9MGe32A6wwFaQ77T7rIW9ipLbk1IDT5U=;
  b=B7fsOdc8Crsg+S0oI+xQgNJ00cfiXmt6B//c0OzAGNvOzK5HbkETra9u
   RIkioYqjFyjU3AWzgXJaiFsUobnyRpcCKbXAg8DJYl5NJh/sm5rGV4fzg
   69CnvRMdaKdmJdOxeONzz3FcxfgpuaoPU/dgTD2f+mPAxTF1rRgkzQZ04
   74eF7KkG/1xxDWAf6He46UTXi4AF0S1GlCjQqq6fr7+Cmd5CuGzh+8NJ9
   9YBzeUJiRXH+I4b6+6vO4DqZfoRWvZdGFCoLvjM+wzOaEZ++Sc/8mnDO8
   ZUVy1q1zuwwUDuAKFKZ5ivCjmgOkwHhUyCaDjR1IhuLsybpILRqB7b7kO
   w==;
X-CSE-ConnectionGUID: oh1KBt+dS9OJ53SNvAnOPw==
X-CSE-MsgGUID: 0j/o5HsiQD2x3d02V4hFUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="78820250"
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="78820250"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:55:12 -0700
X-CSE-ConnectionGUID: cQGM5ApaQYmL/xyvay3TJA==
X-CSE-MsgGUID: /0pWgvn6QaOq472MS7Mahw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,127,1787036400"; 
   d="scan'208";a="273549442"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2026 20:55:12 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 20:55:11 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Sun, 27 Sep 2026 20:55:11 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.27) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Sun, 27 Sep 2026 20:55:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bW4EhQw0B5YZvOT13Tjr0SbKb55FF1rhmFVUvhih297lfj0JM6ULyBe7/5euGCxEtO7FrDHs+C5u/shzAd97XTPnIVffRmUEnMu3uMHVLV2R1yMGzddzhGP6+mWQOEMqHNAtnDeUTIVf2ZPP8iBXkui4qrwLahCOIWInBcO/vNZoawo+cpND9oXaYDWyVj8tbjss6OA6t+Rxw1RL4eq0bxRFu03q/lEBUh12q2Whhd8a7K69NJ5hAVGMvmpUKQR0YeIxikgruAQNlAk+BtuX7NKi3ILChl05949+WAKk5jCk4wB513ihBsEPTa3ddMX+cqOUxFEtoSPg51JHvuZBPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S8wUOIITyRW9MGe32A6wwFaQ77T7rIW9ipLbk1IDT5U=;
 b=bamAqIhFQRxqkmQ3BG1ii+VBqaSdNNryl+KxnsLn9+D0OAnE9yi025tIQT5YN6605SDyPTozD28wI7iix6Uyb9X1gn01D12p3rLgMRHIYN6HspxtqeM4EtO/zAW0zBKUExobx+1/NC1EOMcmdADBSPHdWvHfG91cw93eUNpdyNq36LzJqJLqjyiN8550RejU+s0HWrQvn9/vGRpEoyQrEwyv0Z8UImD0xYq8gK4sNB1Fif4V6HR7ne9lDzXwTOZ4Zl5mlr2Qhsi4CpUVAH6+r6mAg9Q/bPhIqbSNGoxLfCAgFlHjsiOwpmtUZt1RHqG3kni2fQRmTzeY73bWLxyPLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB4835.namprd11.prod.outlook.com (2603:10b6:303:9e::22)
 by IA0PR11MB7744.namprd11.prod.outlook.com (2603:10b6:208:409::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 03:55:08 +0000
Received: from CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225]) by CO1PR11MB4835.namprd11.prod.outlook.com
 ([fe80::d051:d948:c209:9225%4]) with mapi id 15.21.0451.022; Mon, 28 Sep 2026
 03:55:08 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, "linux-coco@lists.linux.dev"
	<linux-coco@lists.linux.dev>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, Alexey Kardashevskiy <aik@amd.com>, "Bjorn
 Helgaas" <helgaas@kernel.org>, Joerg Roedel <joro@8bytes.org>, "Jonathan
 Cameron" <jic23@kernel.org>, Nicolin Chen <nicolinc@nvidia.com>, Samuel Ortiz
	<sameo@rivosinc.com>, Steven Price <steven.price@arm.com>, Suzuki K Poulose
	<Suzuki.Poulose@arm.com>, Will Deacon <will@kernel.org>, Xu Yilun
	<yilun.xu@linux.intel.com>, Shameer Kolothum
	<shameerali.kolothum.thodi@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU creation
 for confidential guests and guest TSM requests
Thread-Topic: [RFC PATCH v6 00/11] iommufd: Infrastructure for vIOMMU creation
 for confidential guests and guest TSM requests
Thread-Index: AQHdRq07BOB130WWqEurUaVXxg4wX7bdXiywgAGkk4CABGTTkIAABK2A
Date: Mon, 28 Sep 2026 03:55:08 +0000
Message-ID: <CO1PR11MB4835427396755B996E325A058C8D2@CO1PR11MB4835.namprd11.prod.outlook.com>
References: <20260917140159.1163281-1-aneesh.kumar@kernel.org>
 <CO1PR11MB48358E3116CC6CF34E6437658C812@CO1PR11MB4835.namprd11.prod.outlook.com>
 <yq5a33uxka2g.fsf@kernel.org>
 <CO1PR11MB48350079E4B431ABAA358ADA8C8D2@CO1PR11MB4835.namprd11.prod.outlook.com>
In-Reply-To: <CO1PR11MB48350079E4B431ABAA358ADA8C8D2@CO1PR11MB4835.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4835:EE_|IA0PR11MB7744:EE_
x-ms-office365-filtering-correlation-id: f3e46fbd-63b8-441f-f90d-08df1d14498d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|23010399003|10067099003|11063799006|56012099006|22082099003|18002099003|4143699003|38070700021;
x-microsoft-antispam-message-info: ZETm4EwAEarwcSxl+spQpykx5akvoMp7TLBoGeyj/j8G35kUy+aUcxGkQ04xNG+OGusvWekbf/NJO91usqqZwWMilqKli9fnO/fU47cqvtsUmLpvUxOfPkwc0TcAwR5r51J4sriNRGjf0eF0dFoA+fVACk/XFFUdt7NUl/7FE6pV5UCKbZfGWCb8aCMxny8dUGLAx72ZwDnv4BumPD/N/zdZVVXrW5XRJyOcfHmt+u530DpYwpdzqXjSmIhjUDYRRK3RogUNBSIfMU3SVFPigs8PfgMO3Jw675ZWEeVeVgcSTjR6cZ7kaduCvJ0w7h6Vg+mMNdY6tsh1kZOh9q18e8JMMSta+FI7Ur/oFvyKng8s60FoBkjKUX5B97uhKPBKXVQGF7peRv09rnBpDb75Hy2uKYdN+qiBtdD5zm0DTi6Wz8c7WGqdu6/4IexzcxHDOH84bH+Q9xLhhR6p50TmVMSlT/aCY8jsAB0iBBlSlCp9xAmL08uTTQDdWGSIQ1loQkOaVTwMaSJODzr2lWjErL11fsOeM89sAsQqJAbKaaXNhswaJknBcCQEFS4PeQUSCZ0itzMumlZKfVcLtZ30pvgxcrmClO5utBHKVuCYUcAaE39ZYkT6AvGCF/Grx7fEeuRDPxhr5ou2UqEE6ocipc6srdOFkH++1UKdNaM8Xas9OE6GWhNYpOXQeLIoiQPqh29o/XlxDv9xNk6zvnxskvYAjXG99wMESpbVPviq5H8=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4835.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(23010399003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o5fsX+rbTtG12oRw+PYpjkCMiEb+0NedwLWNNF22a2EjDeeN5HOIC9W3+iAV?=
 =?us-ascii?Q?6Xf8lUzp2XRwaXoLAeTc2tZ3WsuUsPizmYHuUOtDQjBMW+t0FSHf4YHzO6LB?=
 =?us-ascii?Q?RpOpZI/i3mXAvNnnvawO7X2N0Gk+y0CEWXK6nfRPwacvdj1EQqcR9jd12hfn?=
 =?us-ascii?Q?46c4qNuiKM1YqeoqGCG4a3DExi7RuVWdoaglwB6HU0DpRqEven2GgUbmB/uf?=
 =?us-ascii?Q?A121XB5XE9buwI4GTZ8GzdNudDNdeoQoQghIhXGdEjlIr6qWtNmZ19Ptw8Ss?=
 =?us-ascii?Q?CdXKhzES7hKlqha0b2xRMvPimO2EJsMPKIkIJXWsRMs88HABcfwyhI3Jln5y?=
 =?us-ascii?Q?JDCxyEB4q0JXSScPRcUCOHFCszZT4pUuSpKCXJ4K6BjUgeK7tsX21XbO+bv/?=
 =?us-ascii?Q?FgWR6xJArztrtY6aQ4w/5asoxDJwTTv4MkyKD0x53+fVq0Tx+oeEk5+sHEOt?=
 =?us-ascii?Q?z6OY71rgEGtfCK9T9fSR/BqjAdmOTqKLUTaqkdDt8NEC2mBKsGc1wY1BKVcv?=
 =?us-ascii?Q?fRVrKo7KtV9dlhQf6ZNZdiWPFqV+OCBPfho4pjLgmC82zMsOWaqMo5pvMze1?=
 =?us-ascii?Q?1Dq+jFqBfpbwhhUrt7uCZdaGGpAtsUuO/wVyHqvPtEyrRr3BnHiK3kGa+WBa?=
 =?us-ascii?Q?WG7hTVjDg2v4YXUN2SYFXzDZxTdVUY5zjd1qnG6tBcFZvFr/9dj97+Ejghib?=
 =?us-ascii?Q?5eVGGAntr+sjYEmurtBHD1zTcsrmLD9sWJsvDs3/as0qlVHpL560vdI4JFPZ?=
 =?us-ascii?Q?GadNl6rfU+Drfnnevl6KLGlgWiUiWt9l9B07A7gj8H7PaQZy0M+XF+hPMXMl?=
 =?us-ascii?Q?Ow2oUeDpPilz44sZ9qmjGyj4SzMANY3OoSMWm0uPHkjeaXFP89WiAg6pkksO?=
 =?us-ascii?Q?Ld/RlnY77OcPVsJkK/5Hg0HJesLhSSRVwzvAm1YWZB/tX/yDupY6vrsdQwvo?=
 =?us-ascii?Q?tH4IgehHBLaINaxSieAVFvg4Tl4le2KzM6oFIYDViye2UFXv+kz6Ck9EMCxR?=
 =?us-ascii?Q?90VMiTpXpxH8HM2ZCoX36soxsTDffWENi6aNOX96XZVhJ02d7V6FDYl43Gry?=
 =?us-ascii?Q?t94csqaa656cXoJpGoezxs8rlmEK9z14AvqIqylO+3OUtFLUd9kN5+yOb4/S?=
 =?us-ascii?Q?sarWGG8OzqxGI5LaSVMszUgWGFYbYAwT/vL8V4VlOEQSiwwPb4bT84Z6nRmt?=
 =?us-ascii?Q?BKv3nJXUADMT0j81FtzIqI1qu0EODhHNU0Bsboclgi9OysVyCa8ivN+sdyPs?=
 =?us-ascii?Q?KOdLyan3f4UIizhn5+Z4bl2NLvAZVuZb+SlXIx/VT+mfPyej3H/OTSWmqAv7?=
 =?us-ascii?Q?t00PmJaWGV7rNAg3TuCuCf5Ors7LwRal9aAtMjSvzFHOqe+6x6pAwB/ajIGJ?=
 =?us-ascii?Q?XCnaAINz+YCrCIvsZQ1+blwUFNHv1AAnAIhudPAgC32/r6I28xBCajlidpFo?=
 =?us-ascii?Q?tB7YrYgvEh6vmvP6sm9nQDzwwpJXHjV2cbwe97/hkt1ka02qOOg7nrbcvjY+?=
 =?us-ascii?Q?oDHz4taf+apLb0SCKBXRXdIC9ojNbFnt2xIU5KDwz5sJX23e+rxCIxhKKM4l?=
 =?us-ascii?Q?LPIlWo9jnKXAnRE0OLDf8aFOJR5KtexA+NT+4OcrmeFYXA5EmjlMffRKe/Aq?=
 =?us-ascii?Q?L2BnymC1LGcur15yy0IA6Z11+YranuH72pCVuJpcz7nWV3sBtRc8/9LIeqh2?=
 =?us-ascii?Q?1LBlLeEKtg/JmxjCMui6CTLXtYEzQubFHoYjSCznsBO4yk0k?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 0QBNNf5V9EMiu0soYKMOoesp/v6amLLcCaKF+zQ1xdAYINiWE+9rlrI1kxwQVxlE/bi33oSuJVMkhRrKk1R5EfcEWZpLw07JS4EDGnHoEI8URYhVX/+WwM1pzJNjdHmZFh261Wik9uskXZgOSuqbx9S/0tpJAvxHvBWIdvZNSRc6HY+DLtr3xYFi3h5rCzNRCo0mudyJhc5NY6+BQ11ANjW1zUDNbSv9YE0lNzBkQ2c+cGKVHp+ETchHMglFA31UVBP/8zmxtWhburXiv3oQK5YJvJQSfDonHjYYxgyQDJdq1EMOQeYN1qENRmKOOtBd1f++VNnl8889LBBhpNDD4Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4835.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3e46fbd-63b8-441f-f90d-08df1d14498d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2026 03:55:08.0420
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: deTDPIjiXO+H2nE2dbTcLJ6Ibp/ra8Pjrjh2rylwIcyxvw/I+aq6U4Zq5TMG5t5No+klifKejema3SPjwII/Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7744
X-OriginatorOrg: intel.com

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Monday, September 28, 2026 11:41 AM
>=20
> > From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > Sent: Friday, September 25, 2026 4:30 PM
> >
> > "Tian, Kevin" <kevin.tian@intel.com> writes:
> > > There may also be further vendor-specific interactions between
> > > the IOMMU and TSM drivers.
> > >
> >
> > This is an important point. Can you identify those interactions so we
> > can determine whether an iommu_ops callback is the right abstraction?
>=20
> will do. Hopefully they are all about the TSM driver calling some
> IOMMU driver helpers, then would be less a concern to abstract.
>=20

Correction - I meant "less need for a general abstraction". :)
