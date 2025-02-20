Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6B61A7264
	for <iommu@lists.linux.dev>; Thu, 20 Feb 2025 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040101; cv=fail; b=MS/RA8IGrD9Xcjc5KyhwfOQ9DJS3AnsLoBD628U5607royjtU7tTBflAsd7h68jgX+/WaWjUe4GkDh3I+mSo2UbvmiCmGAR2iGpgzzz5iaXENPPlLCogSX4Gg0R9lMWaoGb5ek8XzwLOidHl6IKPlRvuv+EqzESewUcNTiuvRvg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040101; c=relaxed/simple;
	bh=Hx781LyrJ+5g24p1qibuxMnveZfdLlmQe6BPBKoAHUo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mU2DlqicnkxvgNGVeiNQFZ3DZLd0/XgvfbJMcuqsyc7L6lIerOxfW+kGj/MKmPcxVwLTpmf8+8rQQUIh2ODrafwMs7lq3jlrv61yzGO6jn7dfRb0UVDqeBb4XNYAJ4LczhsLBWcYMRol+waWyANNGmANHyaoENhQdFD9QjSK+MM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mLQn+phZ; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mLQn+phZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740040100; x=1771576100;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Hx781LyrJ+5g24p1qibuxMnveZfdLlmQe6BPBKoAHUo=;
  b=mLQn+phZishqhd1pvQL/37S+kpuW7D9SjgE+fyLcw7qhax4a44n3DgUS
   1vn+cKipL9DY2VcYZcYQm/RXVHGa2Zj3XotimkHZ8oh9Y1a7Gd1UDgDSQ
   Qrk8iRKNXqC6ZqTKabgR+93Qt1Gvky/FLeja6wrU0NmHqQHRjzJyoSnky
   Wg8zHOGHC0t2GL5EURCOAsCvAd5HGZY9GzyyQefnoUiSDFINiGwtalcFx
   /ub50D93LmgIcCMuNiwznZfGGNLBp/v270O4JzroYWjzH0EFQBdyF5LP9
   T7bPbMekLKX0CDDrnDOb0OHLD8+Vm7h5167JkN7YNHNuquKqKHMTOXLZ+
   Q==;
X-CSE-ConnectionGUID: YBZwtbGUQUu8Yf+S3IWl7w==
X-CSE-MsgGUID: On5L0AB6Q1yF+G2uf3Ff3Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="40675230"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40675230"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 00:28:19 -0800
X-CSE-ConnectionGUID: PewM1VaLRTaEsms/uJ8uUg==
X-CSE-MsgGUID: SBnbK8/QRnSKILQXb2Pwlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="145827115"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 00:28:18 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 20 Feb 2025 00:28:18 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 20 Feb 2025 00:28:18 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 20 Feb 2025 00:28:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DU8JFANRtg7QSFqAFnXIH8WiPH4Vkr0AkPyM5EJRWDGgjY26zpX3Efh1kwf7H/0/SgitxHb1bpk9pudnZsoHFmYAuO7LnrJ9ToW0BMJ2VYcfT8xtKBK3MbbSLWy2nuRG19JNxr60VxBnpjhiZ4znaeSY3A002QPl3SJJnfz3xmfCfL6WDPXiR/yZaBWBgJe8+79ZdsJHnRH5OCGRtTxAlfzov9z5FKfHZjCh0iDev+moVY5oYNTNLK/5SLNOrFG/4DJjQLV5k0KD6LKjmSIalsw9pNRLuIRPnQuAts3m4ZPTb0wqUw85Czy6PyZ1WlpNO5RSKNt1VKZ0zh4l3Heu6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hx781LyrJ+5g24p1qibuxMnveZfdLlmQe6BPBKoAHUo=;
 b=BSVLihtCy+7MJP5XA2P1BE0VE8Sw/tIUguyksMQu0SOSG/e2de1hWx+QG2hfJy98Qm5oRo8Si90WToLs0BcE/ZlUPJzp/SxKYHjdnQROS9bEQEZiWSmIgMPSyT3ow3mf1LbXGFeaEqcB46TYXJcupz5dLwvvDIfeMn5qkF+Jgk79hzoYN8HZ+8O7TuAPAYVv9G2KYsCuV3XlBUy5s5pEFr4fv1aGA1MwRiBDHRwplAGcpVFv+8waSzyQJr3+JYRLKDPt/hQddOhr+qv8RtG2D6aEfvKJNwr2ZcTgdd2vDWyn3GTUt/qCvcs8P9CPMu2YIqyvW5nTd7Xr2N66rdU9Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 08:27:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8466.016; Thu, 20 Feb 2025
 08:27:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>
CC: "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "nicolinc@nvidia.com" <nicolinc@nvidia.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH 3/5] iommu: Store either domain or handle in
 group->pasid_array
Thread-Topic: [PATCH 3/5] iommu: Store either domain or handle in
 group->pasid_array
Thread-Index: AQHbfRQttFYattjKSUa6dqsT5v4GAbNP6HEQ
Date: Thu, 20 Feb 2025 08:27:59 +0000
Message-ID: <BN9PR11MB5276DD40F4DD36AD5705315F8CC42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250212060540.261436-1-yi.l.liu@intel.com>
 <20250212060540.261436-4-yi.l.liu@intel.com>
In-Reply-To: <20250212060540.261436-4-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DS0PR11MB7802:EE_
x-ms-office365-filtering-correlation-id: 8fa75404-844c-4079-1604-08dd51887c24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?lKydaQ+AX+xIiI490fj3Jlf82wF1ujA4yIleVxvYm/VKNt3SEpA7h3tQBmOu?=
 =?us-ascii?Q?Ms+PvuaMD9XEYFZgB3J8HTeg0Fo6IQp9AlXqg0J/T00q5ydH+b/05+DS0O82?=
 =?us-ascii?Q?eZl1AX9KaOyVimdnap/I2Gjt/4/q1UBj8sA8gu797GMh1J/1DSoJ5TUcfjDk?=
 =?us-ascii?Q?7J94HrxNRoScZ0auuHBEbWchujkgiK9DDLTaOHq0jsZtMiKbMzkiSqS5I/0R?=
 =?us-ascii?Q?2cCajaZnXQmkFtkX3fvKmAh8aUNkYZMkIAwhYKOGheDDcEQoe5zvHnBaWtaB?=
 =?us-ascii?Q?Vgl6HSfzV4FWFqKI8jF0XgAjTIf8ZnAGN8nIN+jB/Dpjne9fCjMOEA2lsU+Y?=
 =?us-ascii?Q?FvwQFa74qkl9HqgSrkporIoCoQKpmtREPJeHZzv3HvCHv2AcsGgrfjS0IVZq?=
 =?us-ascii?Q?XJuB9MtYXdXiEzpfBzFmExbZ7iOlq/xvzl8/5iQy/NflsgSRB3wR7ty+h1RK?=
 =?us-ascii?Q?hgNIGq3H00Dzq8QfSm+w2Z8lbHQG5kXILMsvEAjNrzmGrRd+XiWl6dj3DBH7?=
 =?us-ascii?Q?HQrGSdpN7R6eRBp0BDro9xYUTRr5N72Yc9Ibvv3ZF5XFVwjzf0XS9LJQ+eKY?=
 =?us-ascii?Q?nqxjZdN+35o7m8J4SvHKgKK7swp5wxsphSVS2ReU5iRUJyrwOYJhWDirdC5v?=
 =?us-ascii?Q?rLmwTMf0eWWCLJSz3UTb4iXQHWEaE6ZzbylqjYlBPq2URf+JNRqe2gAQzCZP?=
 =?us-ascii?Q?Lw7oehB13ikaR5ELjtOgNzMI56vJcCh2PlIE18ytFVZGK1kRzLoykCgnJAar?=
 =?us-ascii?Q?nUoKCtx/ElcVrelbhUPLAiCqiJKcxSk1aQdLZc72Z3P1SuqQSJeSbsbW/l0A?=
 =?us-ascii?Q?Fe60aHUjh85hHZE+WEZy/Cl7fG4KjNW7tSRJp54B6QBCCx3zGQlW/5wdljGp?=
 =?us-ascii?Q?gudvXnPsBh1nozCWN8vvl7N9egyleUeu5w09uwwtq1qnfD/m5iHvUVmsBKuW?=
 =?us-ascii?Q?qhq6LzrkxlsLHbHhOBxDyAfB8aF1MEgnRJ6w+76mEhU+6CTxjBBe/ShMMZiX?=
 =?us-ascii?Q?tD8Yv0tQ+XnyK0UIo8+nZAJ6E2YKPmn82v8OTmoTpM9WPprJmEl8jTp8sUIx?=
 =?us-ascii?Q?8nbqL/Cq8C8q2feNWjSfcYZYfV93dMJKU0x6d2Vy/EdJR6YSwe+H6WBd+E0Y?=
 =?us-ascii?Q?V1X+VvO9MKRopdbecGolR56VSfBH3lYLEszwll29/yTGQVMHv7A7eQC2UWaa?=
 =?us-ascii?Q?QiCoadbNxcJwQ5lcD/Z52QbcsvM6OFGndLMIS0/OAbcJtNBG/3qZJVrjNfab?=
 =?us-ascii?Q?SM5aFujezHtk0OuG2rKDdEX5SniP0n1ZDC+pKIwemuf/pnuPozb+LnfsTm2c?=
 =?us-ascii?Q?XOiFdBEXCO6bi6RV8QNqmm70Kpkjg+zbgaE6GlRhoC5Esl7QEDVf0v9/Ai8z?=
 =?us-ascii?Q?Iir9STHl45jJO61/O1K2w9fOqhqsQdkFloItwalcI7s402WeU17HpztZuqHo?=
 =?us-ascii?Q?ouUTTFM7FJ/ReNHDxY+wbIS1Sh2igIin?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?GOsZmSsUaRM+O6v43I/83tVCRsrNba7XiQzdi9s7TbTe30nC7YSr7y4g/XQU?=
 =?us-ascii?Q?IpJQZGWWlz/IPi3xhimurD1yse3EMuHYsodIV2OjFHUXjUxO+6W2qjibjCRV?=
 =?us-ascii?Q?GPxekS0zY/W6Pccja0FDYfxqZ+Y1MiSnguUukF/i17mV1iNQiDldZAL1a28L?=
 =?us-ascii?Q?4kPNCbaXV3hNP+t9rOR0w6LCB/nueT52xPjs4jbaF8uBslVDmwmB/SZh/dD5?=
 =?us-ascii?Q?f+CPyw/hlunGhbAkysTBcUeazfI7ylLl+kY6Bfz7yhowSrM62vYnbLrgAhMQ?=
 =?us-ascii?Q?kBAidea7ionnUxo+8xuPQdKtNq8K7RCHCZlnSbcTgBy7pvLgCHWvNzYGUP8F?=
 =?us-ascii?Q?GUFX6lwJBz3nNmHKt6ajKxS3+yPwU8WMXEsEZ7cCEpKI84Fkiyy1nKkeLf+F?=
 =?us-ascii?Q?8oKL/lu6jvIz/IYxCjj3QqrY0OPYmKwSMT7poOHInYWpHvV3wcgJF3L1RH44?=
 =?us-ascii?Q?Pu49T33TNG0NOVo+M5migne+QXNnsy0kUfwFqO0E7W9QO8nJsF+l9GXL15UG?=
 =?us-ascii?Q?7R99ZpyEQm5cFre9XM8xDmOlJTZmar4huehqZU+8Y2pftFXnSlVmvlaYpYti?=
 =?us-ascii?Q?eC6slacb7p9cNqxrv5phGD8oG1EL9hBXbyWt7dTA9sxGxD41tQ2S36zpQhoo?=
 =?us-ascii?Q?LbKRQJhyo8hfwoGo5VljeTj00CQ8reeUdQDldARdnMh/SU6A46CYM2yHPM51?=
 =?us-ascii?Q?kgtFeN3kkPaUn59b+TKXFVtKLYMzeKoH7ljezuKm3hWdGdQqpeXorScBXRCZ?=
 =?us-ascii?Q?pe27D56AVjs6djJmMqa505aOfaQCXhUChdSZXGSl4N+HpFu1vewZrWsejGTb?=
 =?us-ascii?Q?eKcIkECTIb+xflO76dW+xz1/BT2K098kWZheZX41H/rrkg0t+Az0S2gXCZBU?=
 =?us-ascii?Q?aUJ1rRXqgkmL6V+EIx+jGAuDlhX5xk78wP+ptYqTMQ+3aoWjDzWu7WzqT7r/?=
 =?us-ascii?Q?GGgvVx3Vk2kOyVr32BwXGMBZjq44z5cYQk0a02nTnAFQavZ4CxAmasZepm4g?=
 =?us-ascii?Q?HPWM0dfrwZUWPR9T5Vb8Zfw3/9ciE8cYElLp43Sx3pwOO7Fl+ApQtpVr0wD3?=
 =?us-ascii?Q?NSzCH4Aqw5S15y5kJt15MgdLUBN9bT0ewcIqs3m2l+CfEyOXhY/ArMweTjTp?=
 =?us-ascii?Q?t/QSg+HlMlCfzt6xx5JDu//q3zHpl5u/ZdMBkhjMQvQ50xfsn91Q/vpuqKAU?=
 =?us-ascii?Q?RbOgKEqIwCfL48BKakVDlyoygQZIPb7cNuMd/FQBc41Zx01jyKHRFa3eP3q1?=
 =?us-ascii?Q?97f7d3qXSFk1lZmQDPqv264a8trC9xB3Ul4gZ9osR1Fg0JMW5SFMvlUt2Mm8?=
 =?us-ascii?Q?BGtHDpRucIr71yV3O1FzOlo7AtH/9+psZj1Y4riuxuo+Je6BmPDq7mrBHraa?=
 =?us-ascii?Q?U89Iss/U7RpVf/k4gqgDI4ARIwkKQFUIa/AibZDmfZD6gswPGuXOQ8ivD0HH?=
 =?us-ascii?Q?IV8vjfNh2mChCqifRq2wVyMgYqvtkSvzbDn9u2Fx83D/6Nt0SfwJCSzcUXip?=
 =?us-ascii?Q?a9DsJTPVPXtGRG1FqnAEfkWQS30jb9imFlTvJhLsxdlljEnVGDlwrfn23meN?=
 =?us-ascii?Q?+gAhZLAfwIisWB3iG71N8l0jYBAQ3gIWF8q1Ng9l?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa75404-844c-4079-1604-08dd51887c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 08:27:59.6062
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8XbMkopxk2MeNKKnc4M8HEHoSgNwiq4glR+UdTmBmdoHPv3Sk4GnkvrdVHnXMvg2a949uo904Zx20tqh+4yOzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, February 12, 2025 2:06 PM
>=20
> iommu_attach_device_pasid() only stores handle to group->pasid_array
> when there is a valid handle input. However, it makes the
> iommu_attach_device_pasid() unable to detect if the pasid has been
> attached or not previously.
>=20
> To be complete, let the iommu_attach_device_pasid() store the domain
> to group->pasid_array if no valid handle. The other users of the
> group->pasid_array should be updated to be consistent. e.g. the
> iommu_attach_group_handle() and iommu_replace_group_handle().
>=20
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
