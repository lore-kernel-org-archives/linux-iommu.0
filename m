Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15FC28F92E
	for <iommu@lists.linux.dev>; Fri,  9 May 2025 11:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789197; cv=fail; b=L0ANpoGVx5AJ0RsBMVlgg41LYs3zC1NV3goCmBkYcxywzaoCdAcl85hb/ht1p55BWO1KzLYmkmjRPGhX20i/5odnbiGfdo5VBsDMEyBpB/BwvGEozjJqwDbGEiQagJ24Yisf7oBEhXks2mMz6O16GsID7Wf+QRH11RB9wZS9Qt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789197; c=relaxed/simple;
	bh=/eNh6hPjn/emNcmMjoajnBDrE6LQa7YmB2w2ANvPjPc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MgNE/Kt4UV5aRbujLQN2O6Z3ArPu2FlOOKYGIXUkNVKh90nEsXz30dfKT6qo9OyzB2muEzyr022uj+vB21VTQdYepEEJdQdA0UUouZdnd2WX51yW2JEHxwCk0iljSp4lyojiraZUI3PlftBy1N0MGvnitChRTiRdV4LPcGM4cHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l4HuvpCe; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l4HuvpCe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746789195; x=1778325195;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=/eNh6hPjn/emNcmMjoajnBDrE6LQa7YmB2w2ANvPjPc=;
  b=l4HuvpCep0y8KzwaUuNpQpbJM5u9R63fS/vCGmwE33++tydfzQrDQLzd
   2PQNDKA4snF6WyiAxbyEVklCLWMZC6INj1vDPEVe87ClX28SLFbwUCIk7
   wOUFYNNLUR+TTQXC2DkBwcEZxRher1mVZnYZeZxrWOuGoNzMW3J2vBS3D
   vJ25vRiVtbhJIN+yOxRlq+f2su2N7lQgmO/wc/yl7oWQam3jlaVhVp5Ir
   YjoUtdlwZhr0PLXn4qpxIo0KqfzD6yaKh9itCfBYfmn96QBIMlXwgk6e6
   3bpNlYF4KRQLACFcraB15O1adGL4DdnvHnRR9GXG/VEiML3sgCh9qKg7E
   w==;
X-CSE-ConnectionGUID: LlE2eVkLRpam+rxvJbzNSg==
X-CSE-MsgGUID: LTdaaKFzRemis1yKAVaH/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="58832793"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="58832793"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 04:13:14 -0700
X-CSE-ConnectionGUID: YBBJqbyhRLq3/kB4hUKWZw==
X-CSE-MsgGUID: SVA+w3n5To6xJUoOnZZj2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="173758627"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 04:13:14 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 9 May 2025 04:13:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Fri, 9 May 2025 04:13:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Fri, 9 May 2025 04:13:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SFXwIEB8oLOOIDyAy9JntVtpl003UCE/oASRfo986eHtQ5fIZV1KskRM+LtsrpBM+RffvIgSxwyHQDv9Wi4qXF1Wjpzm9Qsk0fb4jfaCVW2XFnj0M1THZFXu00/34/c5lER4yRWib4OvzYawITtD1OwQ7QUTSaerVIzzntpgAi11UFm+rQosxBLaR6lBZwiS3Rqybb7k96gAhy1QBfbcLW0ElJwVuRfVv1a6fxHDV6/9R/QIsnKAJ5prEE7OeF2i0JOOAb/URwBsE0oadtSxqgE1+VCktE2kWNngKsBLpWvwa/ZM4MfLToJw0rBx7QV2nxqJ0jQ1kykxIvZoHP8e/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fpHo7AgXjmsvxbgy8qC3cwdZXlZFgH8OK5SR9EQZ58U=;
 b=YgsRO1fsx8XSbOoPOLQQ3ajaV6AR07cPWOILd28ryrFGw3WxWo0OaRgEiYwQ7SRktXNs70vgApGhI4s8QyxKojJg/ThEsQn4g3e+5HuaKj1/YeT//PVJjTCBSnVYVc2KBBo8MvlZexuyQjqzXZDDLBUw+QouUlmcsQeRIm2JrZTC31yR8QDgkqlDgX0oIn2oO4QtNwRMTbO5pWimUWHvHswW7+eUDHggKoLqw+D80+fl3Zvak5FWaUWV1k0NnQMiH2xLMZLTtjdvS9rFaUt4X4v/dUbxZD3nn+STrqEXQu5b7+UiYNNLsddL0Zy40HusKwL2hPdkfItp68bnwAsTzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 DS4PPFD24E991EC.namprd11.prod.outlook.com (2603:10b6:f:fc02::52) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Fri, 9 May
 2025 11:12:44 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::2dd5:1312:cd85:e1e%7]) with mapi id 15.20.8678.025; Fri, 9 May 2025
 11:12:44 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "dwmw2@infradead.org"
	<dwmw2@infradead.org>, "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"Tian, Kevin" <kevin.tian@intel.com>, "jroedel@suse.de" <jroedel@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v1 3/3] iommu/vt-d: Fix ATS support check for integrated
 endpoints
Thread-Topic: [PATCH v1 3/3] iommu/vt-d: Fix ATS support check for integrated
 endpoints
Thread-Index: AQHbwKlZwkA0/SyYsEuLvzUKxjoFibPKCR8AgAAGRVA=
Date: Fri, 9 May 2025 11:12:44 +0000
Message-ID: <DS0PR11MB6373F96B334179FC4C406D04DC8AA@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20250509140021.4029303-1-wei.w.wang@intel.com>
 <20250509140021.4029303-4-wei.w.wang@intel.com>
 <802eacfa-b29d-4589-bad8-a9665909cb1b@intel.com>
In-Reply-To: <802eacfa-b29d-4589-bad8-a9665909cb1b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|DS4PPFD24E991EC:EE_
x-ms-office365-filtering-correlation-id: 7efacb7e-1569-460a-52b6-08dd8eea6c6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?ZlgfBLqaq6enfYk6YlVcdYDFfHOoebA/BPg2afqZ9MCRi0Km/Wvzy0qoa05M?=
 =?us-ascii?Q?QDpyd76m9I54Quntia/8PAlMQsPVeHUNYP07bPw42zlvF7uKrRlcU+puQftv?=
 =?us-ascii?Q?rtnOud5JW/LyhsSoXlz5kOzTu6VauFsMBW2m1BcqP4KCMSof9vaodd+TR0wP?=
 =?us-ascii?Q?j+c17J/gFIHLAGdQ0gNacrVh0q+D3Sc8shwSS7Al3Jlx31IjYFMJXGxzsVtM?=
 =?us-ascii?Q?b5mtFEaydBcmiv+4n7Nw/s0YhHiKomIJWaWwP9JNkvPQJ1E6rbEddDW+H0Ds?=
 =?us-ascii?Q?EX4rTn+8MkmK7CaU+4Jiyh2Fxn3ZTHZETA+3GHEhyX87FLiUwACE+1LaeQIe?=
 =?us-ascii?Q?guV+gzAph1uH6U3x0BKEkFtXqZrUO002emAbkcy7rECku9ZX+NiK/rF6Yrpt?=
 =?us-ascii?Q?YLVjuw3TyOw/qA3ST5DIpMZfE0XxVSsN84FPjOrPOM2tqluHWGgdaheinmNY?=
 =?us-ascii?Q?nLxzcsx9d9eI2LfFlNYYYmtMQ2Q7gQ2UizNMCVc2vMUg1nhDNi72Pwc1rkO6?=
 =?us-ascii?Q?WlrsGI1i2iGht+QmiENqj15iCjgeDE6Nh6NyP7CJ8PyvqIA2rpLUmN8RsxL3?=
 =?us-ascii?Q?04Minsg7FVbeNz/g0IztKOvnY7+PPYpFg1633tgpX0Ot0nDqb7kCxb2ouRgj?=
 =?us-ascii?Q?H+0Xu/XoqwjaupqrRYsMDF5qPyipKNEhXM6blsuG3eTwWmcSQQDHcrJILKcz?=
 =?us-ascii?Q?2rWoPr167GCibtiJ8SgXl5FIM2RtARLtzFyu4uLQJhFYnzUiDM2N635wdUAP?=
 =?us-ascii?Q?+KnbhO9SMzqcYRx5KCBQLc3XdGibPQWcNdbFf8kL/cpWKpb6/CKfjlf4gjWw?=
 =?us-ascii?Q?IkVYFDsBCdoIh3BDRIqZSZdzz327OyYypZ3dXQqpUpvxclilfAU5dUNjG26R?=
 =?us-ascii?Q?IVO7c2xgDBwp8QlF/DQf6iiJnGenui+u9ZVcot8+Y1Fv6gQjnQBxfN7CUOPJ?=
 =?us-ascii?Q?yFqw6s/Ehklqt8ut+BhT5fY7tyhu8rDLu6x+tx9MXsHYgffEugbidiO2VNWe?=
 =?us-ascii?Q?Ylkl8RXSOyVQ5IX5XUZH770+3RCPih/UnmSigz+JuzNt8lSP4OkKeJzMjICj?=
 =?us-ascii?Q?3XKvHAVKJv8yUBQX0qnxWlSM/vv4DLMIdofuitDYWtBkJqAADjn2FRxp+1Je?=
 =?us-ascii?Q?RAY2SLmNzyXLYkhOVyIaVTlM4b6J4Z7NGbfN4EIk5k2zR0YKI7RdxrE2wj/T?=
 =?us-ascii?Q?v70SzGM++1J+MNl7rDWqq2L0STVr7xzsjDcJuWHXUIOmMaopJGcplsYn1i40?=
 =?us-ascii?Q?9GU5ncn/bGIL4GAzNbLA43EaxbkLGz3jcmqqYzuTae8QY04cN4P9gY8RHmth?=
 =?us-ascii?Q?OjHcezY8bHHj1PWnPN8n5DVND72iRIUaVkq3moVRotxs+J8IbV0MDXZdZZxm?=
 =?us-ascii?Q?HKCKlBi2x7ojtCHiFxa4DS6/AQlYfKDzkidjLYAwG01IzvbyLZXdq2tq96Zg?=
 =?us-ascii?Q?WMUL/s+QibSTjKVucxIkkYkrCNQfZ5xeoTMJvxxckGAkdUwVSrLP7S6gmzOj?=
 =?us-ascii?Q?ulWmOJ7zq2BdFP0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6373.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yyw1cjRdRor8/jopBr/pqUYpoLLvHS0Cb25YEXRS28gojZMWeGAC36ahNGSj?=
 =?us-ascii?Q?iqsvXJbek+Q8eTZgniRYUDaAjqy5fO8gzcE36s28eRdID8o0o4Uw0YHcDR7o?=
 =?us-ascii?Q?t0ZcP5zs32xZJbp8xOvaNZEvhnRugrgu5Ejpuc7Z389ekxTFff8LwTo0ZER8?=
 =?us-ascii?Q?kO1quZZCsODcnjMYJ3UwlRg2yEA53Pr/h4njYg777Fo7JAUAwKjJtO34jQ0J?=
 =?us-ascii?Q?bafHMqS3t/ux9pqm5DIgeOxrnl/M8TCpgx6jWIN9lGlJ0yZJMVz625K2kyvt?=
 =?us-ascii?Q?J+pFp/Nbtzy6NKfPgVAA/+PJz0q6hwYQ2oUBPy9UaRjGAbkg8xotP41dUQh7?=
 =?us-ascii?Q?bENAgAQMgtF6Wqi+rZMa+6BsiTozKLANQ/SkrwgfAW+Ot4NkLSKUVaGCoPN/?=
 =?us-ascii?Q?BvNtmXgjBCvsWI6WTftRemUj9qjZ9CiEFmV/ScW22NgezMcbpUcRvmjtcWHI?=
 =?us-ascii?Q?BauEvGdosiha3z9xCyi4njgIfBnHcqBsWVydxIvlnDjbOP+ep8pa5Cc3CltU?=
 =?us-ascii?Q?dmYhBULMRMkC57FdhOgy3TvPC312GcquC7xX4H9LP9hBhCGLiqo2WYqOYxGh?=
 =?us-ascii?Q?QQo5qJoXyqn10Bc0b8XB33mzryljn5ghzGJmXJATBfVyGCZBFKfdurNYlFk8?=
 =?us-ascii?Q?4x/4zAiwYB5V8AYgnzz+zfMeuVPDmXSn7qNp+bBXrRY38sQV0hw5LiXHKiSl?=
 =?us-ascii?Q?B6VAr8eoozSN/kgc7PczeNO8m0NcO25RKcimN4cJS8XEQaGmo9Dl4Nc4S7zH?=
 =?us-ascii?Q?i/qmfAMWWSxtNS+nauFzKTU+BTB3kcEEbM0aaCa9RZfQLFoxmjwFUJNKa4sN?=
 =?us-ascii?Q?sntyhuL4EWAtjHzYqVzhNeMYtV0S6YT5cCJkyUM8E1CsONBK5lpezghkIV8X?=
 =?us-ascii?Q?5eu9XKomt/GBlBFgIsvgbOj1hMDFv3uVXN5evvKvF+aYO0PHTkKUnjdniTeh?=
 =?us-ascii?Q?2rxxXIdNUKHo/ST6bjSRn5LAPgz+A0hoLABoSmgOIGCoWr965B2X5YhpLALB?=
 =?us-ascii?Q?ZAyF63YHA8eLrxS72CPLbQn/PcUWhxFAe2ox6BCdlOtt+iplyLdQ7+bs/71+?=
 =?us-ascii?Q?ak6/GwqiG4kUzySYnp6vwEkmnmrxFebtVa6PXtaNHaqhdBisZH0rkZdFnzKM?=
 =?us-ascii?Q?WsLZSY4WC8fHQT0Kn/YNHPy2KRW+m3KhZZGkR8teaW1JYbZSScHRbcMLR3w6?=
 =?us-ascii?Q?tGCacdgbNDjVRtDPX2lRuUAzmriw8lEe/vNfZ41x1NbUNbGxgK4VUvO/tyvC?=
 =?us-ascii?Q?CNIxe5FXGdevwFhgQvXr5UIHXjMQslohzH+OPH1+CmYH36/FgEuuMqZ3+qPk?=
 =?us-ascii?Q?KWCgiMn1y5trdhym/npocy3KaEfPjCRAH0V5VgV2rd0GzBg8B+HfNIh8Z5PY?=
 =?us-ascii?Q?sU046R/VaKO4v0RBJIXPqQ8xQNyTq8pgtsavHx0J1eZl1ZA7Q8x+VHKLpWNY?=
 =?us-ascii?Q?w6+9pPqh6Gna6K9BGpp153MCo/bM5G1bvzRdXzFR/FOMnYYraHl4JqIu6C+m?=
 =?us-ascii?Q?eFoQhk48BsHyN3RUxtgn9x7OZG3BCXZ9fXQ+Wzko8olT62Nnv0mUdiEFJF0m?=
 =?us-ascii?Q?vQSXHruEpsbfJCh6WlHcGEbla/SyghonSIn7RK8K?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7efacb7e-1569-460a-52b6-08dd8eea6c6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2025 11:12:44.8563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +QM6/oJhoc68OB528urPyWQAA9fPp9dCfyCdliI03KkNZMS5QIKbvaQMKeq5UNT2Eoj1VSMdPv9V5DDB1+t0Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD24E991EC
X-OriginatorOrg: intel.com

On Friday, May 9, 2025 5:32 PM, Liu, Yi L wrote:
2025/5/9 22:00, Wei Wang wrote:
> > The VT-d spec states that "SATC reporting structure identifies devices
> > that have address translation cache and that is validated per
> > requirements described in the 'Device TLB in System-on-Chip (SoC)
> Integrated Devices'
> > section. It is recommended that system software enable ATC for this
> > device". It is possible for an integrated device to have PCI ATC
> > capability implemented but not validated per the requirements, and
> > thus not appear in the SATC structure as recommended for ATS enablement=
.
> >
> > The current implementation checks ATS support for integrated endpoints
> > in two places. First, it verifies if the integrated endpoint device is
> > listed in SATC. If not, it proceeds to the second check that always
> > returns true for integrated devices. This could result in endpoint
> > devices not recommended in SATC presenting "supported =3D true" to the
> caller.
> >
> > Add integrated_device_ats_supported() for the integrated device ATS
> > check in a single location, which improves readability. The above
> > issue is also fixed in the function via returning false in that case.
>=20
> if it is a fix. A Fixes tag is needed.

Yeah, will add it.

>=20
> > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > ---
> >   drivers/iommu/intel/iommu.c | 42 +++++++++++++++++++++++++-----------=
-
> >   1 file changed, 29 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index 2778bfe14f36..39abcf4e0f8f 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -2760,6 +2760,34 @@ static struct dmar_satc_unit
> *dmar_find_matched_satc_unit(struct pci_dev *dev)
> >   	return satcu;
> >   }
> >
> > +static bool integrated_device_ats_supported(struct pci_dev *dev,
> > +struct intel_iommu *iommu) {
> > +	struct dmar_satc_unit *satcu =3D dmar_find_matched_satc_unit(dev);
> > +
> > +	/*
> > +	 * This device supports ATS as it is in SATC table. When IOMMU is in
> > +	 * legacy mode, enabling ATS is done automatically by HW for the
> device
> > +	 * that requires ATS, hence OS should not enable this device ATS to
> > +	 * avoid duplicated TLB invalidation.
> > +	 */
> > +	if (satcu)
> > +		return !(satcu->atc_required && !sm_supported(iommu));
> > +
> > +	/*
> > +	 * The integrated device isn't enumerated in the SATC structure. For
> > +	 * example, it has ATS PCI capability implemented but not validated
> per
> > +	 * the requirements described in the VT-d specification, specifically
> > +	 * in the "Device TLB in System-on-Chip (SoC) Integrated Devices"
> > +	 * section. Therefore, it does not appear in the SATC structure. Retu=
rn
> > +	 * false in this case.
> > +	 *
> > +	 * On older machines that do not support SATC (i.e., no SATC structur=
e
> > +	 * present), ATS is considered to be "always" supported for integrate=
d
> > +	 * endpoints.
> > +	 */
> > +	return !list_empty(&dmar_satc_units);
>=20
> shouldn't it be "return list_empty(&dmar_satc_units);"?

Right, thanks for the catch up.
