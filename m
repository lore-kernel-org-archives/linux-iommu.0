Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C34C2673BA
	for <iommu@lists.linux.dev>; Fri, 23 May 2025 08:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747988163; cv=fail; b=k64bNnqPxRvBS+oWsCHGlt6Qe9uev0n2FgseY9olYnxD3TAu1K2F0doFpf6jfJGGMq5FP4UCDu2ir6wK+9BaTdr+zW/SPu17mbIMKSU1mwtBCVlRI5IS8qU87DxpTklabe7hCI73pFWShlAC06rWA09ngcPVakdie+/wRTUFdK8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747988163; c=relaxed/simple;
	bh=9ZAduyIktHIC9imMEczo06Uut/AOUgAiwEKjPPky4j0=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ujF2b+CPYQPcUoINx0hlciD8ppawL2HB5OOKXTaiLoOUfw/PuT6p8ir3ssYKWuvyj+7hSnqc0PN+utF2kozgZl7BJP6qEbHaSqXYw/Vi8+LLLoz4A+CvzODUr2HAnpXMgma2ish0r9f2RYso4SkHWEHac64wwzJLrXyjI5iGceg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ErJFuqzw; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ErJFuqzw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747988162; x=1779524162;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=9ZAduyIktHIC9imMEczo06Uut/AOUgAiwEKjPPky4j0=;
  b=ErJFuqzwxYZag1FB0oMzPZ3MLFWUW9m861oVD+LFoJt863zmv9Jl33LQ
   RDHxnubhQc/ub4QuX25NBxMgOHFbs8iZkH1tEYnZdsJZsoClgu9jxwF3l
   c92cbeZ9sqYm7TGctfh0cn/ee+S51kanbqHun+fnAhtsULYGKxzZTyurS
   SQ/zdm3pBxo0I0gMx30UlXNCfbXfSWYgei4ZiQJKKuHa1jXUsa7K0NzgC
   pU33V8d5K7gWZhZpM930QN0Emcdvi/VKv9K0HFL/hrN7Wy07yGZ/P1qib
   Xs7rv5PJDBzFugZNdmUaKWuUMmuTmXSSu3VbahCikmNfKWzQqWgdhxQRC
   Q==;
X-CSE-ConnectionGUID: PljSipiuS+6uzKAwQx77KQ==
X-CSE-MsgGUID: Ib7jmBhdSgyA3bCA/ou/vA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49741821"
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="49741821"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 01:16:01 -0700
X-CSE-ConnectionGUID: W+jI49/YRMyrBroydvCxbQ==
X-CSE-MsgGUID: SO8vNaanRtiUAt8oxAWnng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,308,1739865600"; 
   d="scan'208";a="172019532"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 01:16:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 01:16:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 01:16:00 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (40.107.220.64)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 01:15:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8k25LslbuLgqqoeQxgOTeZTC8rh8Lr5sihj6DyOcdWeCOo0nhwhc6hXtoriMIyfKMMqy4OWzCmmnBTQVza6GIQ+ZnABW4EbXjDMeHUbR7UaIYZrmxB1H5PFLmXlC59gO6NHJf9J6ILjx6pE0qEgTBfnv9oWYS0VbSlQCuaQvtMNXubNSWy5xGJa5nTyZUGA04iBa9ZiWXrr7bCPhTHNJpU6KU6L7SnoNgqJICnTwzOJApk32ZM8A5HHAD8A58QyzyOYWkIHvEYoanVlBrjwpYz90RpasoR57CBYmNQa5xj0delksa4iexy8Zzxo0f5JWL2rgB+Ex90NdOB0lIrnEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FF4S4nyl6yKxEtpAMq9iHKJhltyXO3GB1VatFbvojFk=;
 b=cE3RIOXW9hrDr+EURib4O0KuU0al6EaXUme2jC2XsF35mee2UKncLiCksMrC2Wsg54rNxZelwOLcbJ5ErKsvxevf80McNz9z+EHe2IcJzEznh0O7pHwHIt9f9rcUfo+Q7CKLfIkjaRSHUMLK3kjXizXQQANvIjvetEkRfGFTICB9APyZQjQkfjT25KtjE6MM4TZaBZ5bxmGXn4JmbQg1JO5RM6kgKP5K+nZL3VCCLXU+sVGKQ/4PEdncoxafrRYMXcBdZdjhPMiPtTrzkxsWbM8CuECIac57+8YDvTA5ZycYVpbz51GK0CNPGYGA2gRto6IcmyZwlISysm7YDaaF6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY5PR11MB6414.namprd11.prod.outlook.com (2603:10b6:930:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 08:15:55 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8769.021; Fri, 23 May 2025
 08:15:55 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"dwmw2@infradead.org" <dwmw2@infradead.org>, "jroedel@suse.de"
	<jroedel@suse.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: [PATCH v1] iommu/vt-d: Remove the redundant logic in
 first_level_by_default()
Thread-Topic: [PATCH v1] iommu/vt-d: Remove the redundant logic in
 first_level_by_default()
Thread-Index: AQHby3jxlypDGlKlcUOjnKODrsdL8LPf3sKw
Date: Fri, 23 May 2025 08:15:55 +0000
Message-ID: <BN9PR11MB5276C8692C706B0BEE83833E8C98A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250523081056.223082-1-wei.w.wang@intel.com>
In-Reply-To: <20250523081056.223082-1-wei.w.wang@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY5PR11MB6414:EE_
x-ms-office365-filtering-correlation-id: b98ece79-cd6c-466f-6ecb-08dd99d20a88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?tfUn1Wm10lX1BD1L4xbqFkCiBOSVXIq9YBLZaA6jRbT5Ui1a19AhZ0VOLSft?=
 =?us-ascii?Q?iYVro6c9M0ixCWadMTQC+F+WRtaBMm23iP2UnHcjmiGF7ILGkSdpN8f62QaK?=
 =?us-ascii?Q?8iM25951wApWeySHPUXjBYb7y8llgNZejO579DkqrYz+RAGlt8gsFopq9MZx?=
 =?us-ascii?Q?AYV+WSTvTwuePPkpBzMsnzfKG6bGOH7CCdd/dQl+Oe7AWt7UJCTSuzmo8uc8?=
 =?us-ascii?Q?KlF8VSvBOOTHJviQCR0oUACFFxCE+yUrzL2wCcnNwploJ57Yl9VIC8hsgZF4?=
 =?us-ascii?Q?5/MQNaYWLlcQcyB4Bkl5Zt+fmnpZRTQxwMTGXhhavOlUnIw+SlI0x/9VGrCe?=
 =?us-ascii?Q?WeFgkNezJOtdTcL50c78wMpiTsMzrKtN1kz3Ahru/W5WseYaFQyN6RPeDi+D?=
 =?us-ascii?Q?CrDTFIuXNOiYieJPXjUUh5dthjrj/W4jhI4sFwJtsel4bEEI972fHwMB4kjT?=
 =?us-ascii?Q?dJifZ8iAMv4S4oM1z3Do+FCNI12H69ZunGnaAZ9d7J1TfWN3RX3D0fzjUBKF?=
 =?us-ascii?Q?0SaDVRmF5gJGDQhm+6+o9FhupzhAMd5Vq7UJgeWxhHhVTCjmjkxlrRjKH923?=
 =?us-ascii?Q?DRf4Cuvrmi1ZJALSaguAdIyQe6TNfvshhfZHrhEZxUD3U+r8amXhWrXeqXJy?=
 =?us-ascii?Q?6tYSLPXnER2VG9nDPot/YIIdGeZgMT1GaMW84liUcbF8MG67g9YAZ5fVUApY?=
 =?us-ascii?Q?G72GU3pYhyrjcKGvt/rijgZE+HsdlW/yxy2lomRxPZuVGYDCcWP4MeMr6xK3?=
 =?us-ascii?Q?KNcM+TL2Q9SVJ9jI2NvEOCswHT/YoyoY4kv0Z1qyhq5zmJtNi2gpZY1WQP1c?=
 =?us-ascii?Q?lkq8Nl74fG+VIWnXCk9fxdbk5lr5FLvKvcITYTyNP1yxTJ1D5L4ZopS93dZx?=
 =?us-ascii?Q?covmJT5Y8VbwPJeD/BTjrrlsa3k0QuD4tEfcRoNxw8BxqEMWA9PmqefVA7N8?=
 =?us-ascii?Q?dkeSpg4FgsH9FO05kkHdtjr85t0TUwegA7wxHD0UclZewdKDHPvLZsJovUKC?=
 =?us-ascii?Q?KEF0QRK+pAePdxOUhksKt5IFTFoq8KmAc/Bh0x1cIHtxogzao4zvO3T2mOi2?=
 =?us-ascii?Q?wqaOd+gPwq+fHQp2u3JnViP7muiV5YlqEIfNpZdiewKwQ8rusupZ5Uo+a+/N?=
 =?us-ascii?Q?V4YAv6YGTHO20OxWeW2Ursp0PkWrwamnefWFEym/RRUP9ekWaEcAX9KWJRbQ?=
 =?us-ascii?Q?7MwaWANJRWSS9zc1hCoG6nSi9Ky61Y2bAHdPZh/rVp9KXESlGlgctTnlJOBJ?=
 =?us-ascii?Q?CxPEXu51BDckSphQCbTRbIv1JoMXJyrLaGf8WrjfJsW0giFz7PWtooGqgDIf?=
 =?us-ascii?Q?fRtcZS6yIgSjiQWbuJqOluA5/TJdR8MBa637mEetXrvnCmy6NdEHI8K3Sw/j?=
 =?us-ascii?Q?bR1MgocErr6W7uyq0ah+LgC5alGT5VacnXUuGc0+uBw9FBKjrMCD7HLD3E7F?=
 =?us-ascii?Q?WsfIvgI3RsaTac3yWYSWeiUT+mO8s+LKzHhkI1UERizyTN+VsiKDTXWBW0/q?=
 =?us-ascii?Q?CSRYL+uqWvhLcHI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RS3Joi5pDnQSZ3U0nHdYsVgQ8jwGIj8fXivLSjiCljBSAhmJivueJVewk5TC?=
 =?us-ascii?Q?rSo0e8sAPwocR8uJRv50fRFJv+xB40j2tWjDQRs8CyZRGRZqWVrjYo22MX/8?=
 =?us-ascii?Q?6JLL7rNJIchbcrPcm7clKJr4qYOdet5K4HUAoUjCzdL0J4DameUL96Kdhbtk?=
 =?us-ascii?Q?bY++PtesV7z6JWapl2SXN5s+BXkJORFl6zMyuGYzaTehhRFYbRiMlkEYzbfn?=
 =?us-ascii?Q?YKgsuvTIDk/jeYVHMhQFLpz6TfY9aRLyH0IzhZV0e69yhmPB0VnLE05Wl6Wm?=
 =?us-ascii?Q?MKEj2lC8+P4P2RTVwmwnnykc2sISucaymlWQ/X+PkevLmcLqPK/2zB6RElP4?=
 =?us-ascii?Q?hlS7wzRweVGC8qoEa84nexnKz7uWKO/piSARLA1KqMXUAjKRKjc9ck4WxvHZ?=
 =?us-ascii?Q?tYSO+r+tCKZANkr93wFVCnBiD42fKEDDimvfZTahVnKFticTB3BU7qbq36T+?=
 =?us-ascii?Q?1wARmu5wCOZXFiFNVqN20Ql7pZe2HVuzMgIs2VLKo2P3GbOB36ZrlX0n7A7N?=
 =?us-ascii?Q?hxjpAen8l/Xjpt5fwJ2UwEgRtYbwy/pjJHFo0fKZPeoaK5g6vK3dM5iZfJR8?=
 =?us-ascii?Q?gwyHF3wnqqiA7D6FGcjuwNQfLleUiq+fZJ64CrKillTb0xsEi0J6WZTIuo2s?=
 =?us-ascii?Q?1DEHmMcQqka1S1pjn+5He64BoPsa6iTz3JIfNrYXWVHKhbaRCey+NmxPQ6wG?=
 =?us-ascii?Q?XhbEStRrIIYgBSB2fS5iID/n8AKlKoLqvGn9lvS9AySH5IzOuY+Q4QzLwoBk?=
 =?us-ascii?Q?8vLt4tDfVRdRKSHLygIeXq+3DzMYT/yUaGfuf0T52Xrn7L+Myh24HpuCs17m?=
 =?us-ascii?Q?ecLn3MGfTuahG6O7yEB5fA6D54bnaJDI3/s2Y7Y13/JAJwuFWgq/QIDUWv1I?=
 =?us-ascii?Q?Zj4NTyFcr4zRWEy2ObXuw0oNs0iwuEmcSh/THE+oWPrwZWlEAz2QUdrccqap?=
 =?us-ascii?Q?084te5ZJM3/4g0XFgZyAySRaBsUPXPXvOnoTKwB+yeEG8HxnhkZSpG1uF2Cx?=
 =?us-ascii?Q?NtUmVhXaM7gu7GR+ayJS1vg6k3UazjNjOQTiSanle0BrzncxJ1K+4Bm09tag?=
 =?us-ascii?Q?xbXqMnIBmL4buhnJM5aaM55Z/B5USmzeqfjf4AEO0R9zOUiPs/JpcDnoAFuO?=
 =?us-ascii?Q?V4t0yBqFeQVFE1C0f7+wy8YDaqLhIVOFwUlwqvu3ai+ibx4lkIQyngpGYdss?=
 =?us-ascii?Q?gMyUupkvOZgf9HiDO9VOArhB33Q7+Fb0ypup+ZwUOGRiw3LEf4M/0eH6voXm?=
 =?us-ascii?Q?lkp84Rkuz33UcTPVLQloFtFzKlFaH2g4lzUT7xYNVghRSF9qQ2sUZmYN22BA?=
 =?us-ascii?Q?Z+/hEbPUCqZnSEjZBs37IsT/EOb7WZ62nmd/kxmXBMwD4APnq4sL3SR+iuzM?=
 =?us-ascii?Q?S/bkVmAuqHsqWdc6v4A4h7EEm3OPUrJo4nZFirI7GmY4cq9PgdmYlqcSTwwK?=
 =?us-ascii?Q?qDCiKIuQYtISSISBrdBirjBWDcJ7qjSrORy0UdN36WrJOKzVrLADML0z8iFv?=
 =?us-ascii?Q?G+770/8ieliI7s/urYB9AcZEAy/puXWr6vLYNLxZcMXDFTTjpQE/ldENCxwA?=
 =?us-ascii?Q?0UyqnAsm0TbIh0RZUXMUhRg69T5pI9OukkXsxQgu?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b98ece79-cd6c-466f-6ecb-08dd99d20a88
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2025 08:15:55.5112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SUUpSAPe+HKrRdRBddAPBkJbqOa/F9tdUVQOXoxGDB5qQvZ9ywAJi2wTRl89Fs3MmFxb67w1opmKHpYsuc0vrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6414
X-OriginatorOrg: intel.com

> From: Wang, Wei W <wei.w.wang@intel.com>
> Sent: Friday, May 23, 2025 4:11 PM
>=20
> This original implementation included redundant logic to determine whethe=
r
> first-stage translation should be used by default. Simplify it and
> preserve the original behavior:
> - Returns false in legacy mode (no scalable mode support).
> - Defaults to first-level translation when both FLTS and SLTS are
>   supported.
>=20
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
