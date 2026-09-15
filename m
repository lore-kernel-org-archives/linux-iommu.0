Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA1E44C51C
	for <iommu@lists.linux.dev>; Tue, 15 Sep 2026 23:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789514601; cv=fail; b=r81T8FxtdQXWT5QPqEgXcwLykYZF2pqgVcKwGONzlv6rtHdT6e0yihOzyHlcjyb8EVXWwC46+fYN02t3Npbhfo8lJtKl6WgLB6vzGwhkrZaYFcWrBmgAjgcWrIyuVsPhHXv7MiCjF073dfFJ0M7EZoPxJ4gugJHyL4/hHB6dB34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789514601; c=relaxed/simple;
	bh=bOIVyjF77hKhJIP81BQ2mcXPShcJGwfF+a4AgpZMN/M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eiJbM57nzPPiSS1loA6KskuJxBeQ3pUG4YBNM8yf2EFqUcLpbElsnEKaxIMtyNkNPXaYcHeLQfGTpMs+SONGsgFHb2Q8weoFGU0lAlCN8XxBDjKuUcT4HXjRcebtT/22DttJalYaXjRCjhq0cQQHj09XUHalyETtMdRaW7uSyyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HF4tkl91; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HF4tkl91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789514598; x=1821050598;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bOIVyjF77hKhJIP81BQ2mcXPShcJGwfF+a4AgpZMN/M=;
  b=HF4tkl910kX0YE6nNCAKr8el/0DcougQwZP2o+IEFROEDOYTkOaizbfR
   NV0dCrbbfrgu4SSVOoUeBIb0pHh9tcyMvHl/7iRbkILzSODnQa9vNmpMq
   1Kh/NdX7Nz+S7PMOX9r21qtq+/O19tFQQQkmSN2uLFEOJBNlamLEXmm8o
   1j9OiSDRO+Vr1cyNWOfZMEt5wfyvKON7vbHcgcC+VSfnR9bIivoyqiFRn
   KJg5gA8kzolYBdtM7KCJGb9mSYh4jtwOO6PXp5jLo+dWFnxGaqTuXT9kD
   74+4yIKH/wMEYbrPeWp9eeJIqnMl6AtHfWPHgs49VahofwosMgeazSD0e
   w==;
X-CSE-ConnectionGUID: ddF8+5IuSr+2cuPsqOhTYA==
X-CSE-MsgGUID: /0ZbRi0fQtSM82Lo2LB2ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107259015"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="107259015"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:23:17 -0700
X-CSE-ConnectionGUID: zndaCA9nS8SpwRgUzdhS6w==
X-CSE-MsgGUID: TTj0g64RTG6FfRzWRo2JsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="269897860"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2026 16:23:17 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:23:17 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 15 Sep 2026 16:23:17 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.54) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 15 Sep 2026 16:23:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cEha+7EKj+YUR4yXLvZeWNNcW9DaS/TO1956xJJ7cZi6S+f0XwlWpNrGFu50/4hv+34H6OChi08txzYslftrWj76gPgrDioaRY6lQll8OUeGnLxtz2Ty4QwWqTOgL6A++SlG/1DyqH0zvW3yVggrlwr1HEiNf9aDWi98ggBcgVNjHV3dcI9IUMH2SCObXQ4EfzCr3/f79cmoruDai83z0WTSA01/5GNo4cxmR+SEFf71XqIP/cJLbtM+5ZhNIHOZxtuRiwu5IGsYxcxkJUKYBjQMwN7JNA3c2XZO6y+8efSBzd873zDNrhEfQiTaeAlxwdZ5KOOVDTFZRwuAQx0tAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s0F/Hi/9C6pwMW4q1oIkWV3eLhDHtLOu4wm4MZ/R6fs=;
 b=iKfg1XJ55+eEm9g4+QIS7OaQ9MkzNPeEh46VJyt6+79a5QVJyftMQsk9Ua87m9ilgn7knGtatrfMe7BTBv+wXcal9zXU3P1HacikPlZFZIvx9yt0FO+iGZ6xi9An9pLg5vBqtpnL6ANmSMmV82otuT/V0vVF0QGoHXoOliMTCmkfMEVjMV3VOAkPvMnrXbSKlj4tpaiEqIBZfVK6DrFzCsS2LqVVl+S5JQYCktqkTxVtKHxhyYcGCNugyvzFc3wCEvd2GM3wAjeXlF5yf+LgZEeN18o48WfleezoKVnc4Z2xvzi8DHszvaRvrCLEg837UeHq9JCn7Ey5ymQEdmCdXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6878.namprd11.prod.outlook.com (2603:10b6:510:22a::7)
 by IA4PR11MB9249.namprd11.prod.outlook.com (2603:10b6:208:55f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Tue, 15 Sep
 2026 23:23:12 +0000
Received: from PH8PR11MB6878.namprd11.prod.outlook.com
 ([fe80::1b78:2633:3b3:e4ca]) by PH8PR11MB6878.namprd11.prod.outlook.com
 ([fe80::1b78:2633:3b3:e4ca%4]) with mapi id 15.21.0406.007; Tue, 15 Sep 2026
 23:23:12 +0000
From: "Sun, Ning" <ning.sun@intel.com>
To: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>,
	"Camacho Romero, Michal" <michal.camacho.romero@intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"tboot-devel@lists.sourceforge.net" <tboot-devel@lists.sourceforge.net>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Mowka,
 Mateusz" <mateusz.mowka@intel.com>, "Pawlicki, AdamX"
	<adamx.pawlicki@intel.com>, "Randzio, Pawel" <pawel.randzio@intel.com>, "Sun,
 Ning" <ning.sun@intel.com>
Subject: RE: [PATCH v2 1/2] x86/tboot: Add support for parsing DTPR table and
 disabling TPRs
Thread-Topic: [PATCH v2 1/2] x86/tboot: Add support for parsing DTPR table and
 disabling TPRs
Thread-Index: AQHdREvCoY3GvcQw6ESeG2X72z6lgrbQPWSA
Date: Tue, 15 Sep 2026 23:23:12 +0000
Message-ID: <PH8PR11MB6878FA66E30AC9A4E01B60A687BA2@PH8PR11MB6878.namprd11.prod.outlook.com>
References: <20260603114500.2771319-2-michal.camacho.romero@intel.com>
 <20260914131953.669975-1-michal.camacho.romero@linux.intel.com>
In-Reply-To: <20260914131953.669975-1-michal.camacho.romero@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6878:EE_|IA4PR11MB9249:EE_
x-ms-office365-filtering-correlation-id: dac3faa5-a528-474c-4f4f-08df13804fbf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|11063799006|4143699003|10067099003|22082099003|11062099010|18002099003|6133799003|7136999003;
x-microsoft-antispam-message-info: 37T2+a5UfEQUcPW/y8/NVyz3vAwzH3WFMDczK89Ft7VSj0fNljYmhOnzOZEvWRvF5wBIdyjX6jjRxIzynuDRy7N2GpsEXsKz/TepdlFLaYgvo/GO2XgBN+ogImrNihdNb8+2h1k4AbSSDFAzl1Y2XQZEjHx28Cv47VutXBsZ5Z86IDhM+1tbZ6sZsD1xNFPm5y6VTAPWlMfmn1tAXzI/TNxuro3ca8ek0XYaDL06fnZyz3x7eMnxHCE+3HEWEXWBrx1+oTcVaLJboJG70Bgz3sFCVPMKlpoAfX65+QBv6UBr+GUOneC/Ny50MyUsh+bDbe2lGfpiPujFPBpMO1VxjHH9VTTjHF2UJmOKVbTDyN1xSuX7/l5mojvXO1YYGIbRkXw4kfmeHqVBOYIGsC7tT/KewQ+UEeGAfyFiIhsyEQqWmlTxpBDLm4w0QPfOPPerfUrxo+HndCrpd8uwf9616PMcO++/JBCIADpai2WMQmisFi1ySalFyI6InvbuzZDsmiDGf0T3LoD0WHLm/raJdsXxb0bDSfRs5NDUe5+kjK8cgrXt/VihMDbyMF+Lpra3yBnLIblhdGdk/kw/k8pjz0lseKEyJGnjtoHQGiO/bX10Ys/1PQWo+L01xTkbSlunTDJOw/7A7rqVsqLuK4MPq99p0jX/l8uUN1fk676rGHI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB6878.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(11062099010)(18002099003)(6133799003)(7136999003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3fw++9CyJLLA7gN6EyeIWBi+K740pDf8Wopt9osp///r5Oc5RGLWUdAHPUbp?=
 =?us-ascii?Q?jOE1zIPM6hqhls+MAafvgzPr3HKwF6NSWiPzGy2/WSPZqGpVLGLrfUr4fLsR?=
 =?us-ascii?Q?DBeZeCKcQl8kKUVkITdTYE6/+seULyxBZXabG69K/rF1SPKEr/j9Pfa8ZWqn?=
 =?us-ascii?Q?gz9lnAqlIFZDCK7AHh9vk+5Z9dRUGM9Ezawtdv/6ifrQQVF/ck2tsTfvBrUu?=
 =?us-ascii?Q?EJq5X5i7ZyZid/PojxALoCV6qd8s45MVImDqJU2slSuJXxpMFZSmPFpJe1FY?=
 =?us-ascii?Q?2rsI6dfKPC6+Z4UfMZPdGKWThi30zojcz9YO6IG9yZ9ljw+z0wdytVKmjNWd?=
 =?us-ascii?Q?VV3KpUXGxo9tlCaSIjtd7/5KFa+yHq/QISvn3rbhX8SdTocaFqAa/6PIOTbP?=
 =?us-ascii?Q?gBNG0x8E4q7C5Z9i1E6uti0g/KbtnHkVZ52VWejzLM54JQ+HzhzDDTsBHBYR?=
 =?us-ascii?Q?1qcVCdF6t6vMcHDHX9WYfDfwuKiocyd/mjdnR2fbRqbO9grmfMEqXLL6eW+3?=
 =?us-ascii?Q?K1MC/OchzFDbC5RrxupAy6yze+7p7tjGt8wFpuN0Ls1rzoGkl/gTjMZgi6OI?=
 =?us-ascii?Q?EcwhpgEcC7Fz6on7B7E2o63HPxtnVuvAb1GM2WOb3f4B+M57QXHLCRX6CI/8?=
 =?us-ascii?Q?4zCRXT5gMn+oFNnQxadp6Vs417SOWCf4rvdCQGACiNHKRQ7hI+CPB4KBaqDD?=
 =?us-ascii?Q?v9qLG8TwaZYBMJ9oTiCBTDqexV4XMPgzkXXx9sY/iaxQPLcieNucpZUGT1bS?=
 =?us-ascii?Q?okKSJNNlL1sRJwD3GoI5VoiiXa9pIRf04YwP3KRWvr0eecbGryroXMkyqD+U?=
 =?us-ascii?Q?gEAVGuQj38LVv0MfNiHPz/IqeZn5pL8fhIGOdoGVcJCfpSd3mrGaa5PLwCi9?=
 =?us-ascii?Q?Nnz6li0g9nOgSvS2/B/3zCKzBVz0Tfk3NCH4g1sPglopZ+XjVGe0W8yBljXE?=
 =?us-ascii?Q?IRlxTrZskGrIddv2LnTkq/RKYEWyN1I/SbLJxrMsVN1K2bg8EvuAP2TO4O4S?=
 =?us-ascii?Q?IQCc/aTeOTV2Iaphw7ps2/FZeyksFaG9jm4IufgpTGru5MFKeD7m6Ipg2owi?=
 =?us-ascii?Q?hAb1ozapQi0kXYlZK9OmKAdbe6RdNx1+haBovTMMOtKCUIswZf37wTzjMXaG?=
 =?us-ascii?Q?bpdx4/CDLYNWu31cfzrQYh7r3EHZoPiHvMZxGgbWSL9dZ47RpuZHp30NR1BI?=
 =?us-ascii?Q?C75nNLmwhrlDvf8BMA4CimWfbXGhb0WBPpZOhZbxzpWJiMtCQnTqSeNrPeCy?=
 =?us-ascii?Q?FyQm9nU0YXw9ti/bOe9mI4Fx+odQf8/dt/E4t8fD9p08X/qsEERbKRkGtmUb?=
 =?us-ascii?Q?KeySZ40gAPRkOgxJdfMxKi9RiObGaTTqZLKUta/quFCYtOk1k3aB0YINNVTq?=
 =?us-ascii?Q?Pl0y7SQgqQqOFc/fsrTcpNUBlrbaN6641l6rLkKJhO/decUOL1LyUKx+Kewr?=
 =?us-ascii?Q?AYUNmRox7Tt9PS0AFd/j6NSewS2nEBLv2yW1CsPx6DNc5GmG4UxGdGF7TLF8?=
 =?us-ascii?Q?4+dnGlkt9wgzPpz/zxij87jEz0VYd4nANQNXEfJi93K/RHDQ7LSm+aM8d24e?=
 =?us-ascii?Q?KEAiC08y/s1Mpa+oxN5X5HJKW2spHNjaqVPHa6Z8oJe6idYO1Uhsg/3oEWzL?=
 =?us-ascii?Q?u/dEvXBy5ZjcfG8SIKRHaq4DPbKrtQoSs3iP3ZvsyN1l0fl2WvNQHRueCuOW?=
 =?us-ascii?Q?ozcQRcVmwqOZKB6DGfHMwYOt7AvWNCo7x0KHjfhKKw8J3Bxh?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: 5w4kyrs+YsGXCMA2F1/7Rb4+ZQntAIZGog5CtxvFwSvHuVKQW3C2r0yan7fKF60+n4GKCPlKff+OUpIx0AN7CL/h6i9MNIsv45UieuNB+6mrou9SpVE8rJK4/q1t2EPtLC9c/uuRyLUvZfIDuwJEy7d45Y4PbjxQD+BdJDEpYx5N5i3IDlwDNz7BLJHAKqnE2GN/uegryxGwpKf7xP8KHx7fPFJTyC0JxISq7Zk89J+Da6ijIMugF7p1REC0a9RHIkVboCTdKENPb3ezhgw4rZeC26gTpA7J+If3jdkLa2FzzCZVu8Q5lrnPcHX+VX90VqgFwCz0pqtElv7Yfyxn7A==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6878.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dac3faa5-a528-474c-4f4f-08df13804fbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2026 23:23:12.4306
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C0bok/PyZDdASedyHiDwID0aiI1vy35XfGhuCe+9vQSmPyO/RSPQvyLsCaSn41MyN1df5dsfNMLjVEBEEPfFcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9249
X-OriginatorOrg: intel.com

Hi Michal,

The overall approach looks reasonable: reading DTPR from the TXT heap copy =
in SinitMleData, requiring v9/ext-data support, and disabling TPR through B=
IT(4) in TPRn_BASE is consistent with the referenced TXT/DTPR specification=
s.=20

Please find inline comments below.

Thanks,
-Ning

> -----Original Message-----
> From: Michal Camacho Romero <michal.camacho.romero@linux.intel.com>
> Sent: Monday, September 14, 2026 6:20 AM
> To: Sun, Ning <ning.sun@intel.com>
> Cc: Baolu Lu <baolu.lu@linux.intel.com>; Thomas Gleixner <tglx@kernel.org=
>; Camacho Romero, Michal
> <michal.camacho.romero@intel.com>; x86@kernel.org; iommu@lists.linux.dev;=
 tboot-devel@lists.sourceforge.net; linux-
> kernel@vger.kernel.org; Mowka, Mateusz <mateusz.mowka@intel.com>; Pawlick=
i, AdamX <adamx.pawlicki@intel.com>; Randzio,
> Pawel <pawel.randzio@intel.com>
> Subject: [PATCH v2 1/2] x86/tboot: Add support for parsing DTPR table and=
 disabling TPRs
>=20
> From: Michal Camacho Romero <michal.camacho.romero@intel.com>
>=20
> Add functions to locate and parse the DMA TXT Protection Ranges (DTPR) ta=
ble from the TXT heap's SinitMleData extended data
> elements (requires SINIT MLE version >=3D 9).
>=20
> * tboot_get_dtpr_table() - function walks through the TXT heap to find
>                            the DTPR extended data element
>                            (type HEAP_EXTDATA_TYPE_DTPR) and returns
>                            pointer to the DTPR table.
>=20
> * tboot_parse_dtpr_table() - function iterates over TPR instances and
>                              disables each TPR region by setting bit 4
>                              in the TPRn_BASE register via MMIO.
>=20
> Using these functions will allow the kernel to deactivate SINIT ACM-estab=
lished TPRs prior to the Linux OS launch.
>=20
> Link: https://uefi.org/sites/default/files/resources/633933_Intel_TXT_DMA=
_Protection_Ranges_rev_0p73.pdf
> Link: https://cdrdv2-public.intel.com/315168/315168_TXT_MLE_DG_rev_017_7.=
pdf
> Signed-off-by: Michal Camacho Romero <michal.camacho.romero@intel.com>
> ---
>  arch/x86/kernel/tboot.c | 230 +++++++++++++++++++++++++++++++++++++---
>  include/linux/tboot.h   |  10 ++
>  2 files changed, 225 insertions(+), 15 deletions(-)
>=20
> diff --git a/arch/x86/kernel/tboot.c b/arch/x86/kernel/tboot.c index 46b8=
f1f16676..b745683c1ed9 100644
> --- a/arch/x86/kernel/tboot.c
> +++ b/arch/x86/kernel/tboot.c
> @@ -18,6 +18,7 @@
>  #include <linux/mm.h>
>  #include <linux/tboot.h>
>  #include <linux/debugfs.h>
> +#include <acpi/actbl1.h>
>=20
>  #include <asm/realmode.h>
>  #include <asm/processor.h>
> @@ -223,6 +224,30 @@ static int tboot_setup_sleep(void)
>=20
>  #endif
>=20
> +static bool tboot_check_txt_heap_section_bounds(const u64 heap_end,
> +                                                void *heap_base,
> +                                                void *heap_section,
> +                                                const u64 heap_section_s=
ize,
> +                                                const char
> +*section_name) {
> +	if (heap_section_size =3D=3D 0)
> +	{
> +		pr_err("%s has zero size\n", section_name);
> +		iounmap(heap_base);
> +		heap_base =3D NULL;
> +		return false;
> +	}
> +
> +	if ((u64)heap_section + heap_section_size > heap_end) {
> +		pr_err("%s exceeds heap boundary\n", section_name);
> +		iounmap(heap_base);
> +		heap_base =3D NULL;
> +		return false;
> +	}
> +
> +	return true;
> +}

This helper is a step in the right direction, but heap_base =3D NULL here o=
nly updates the local parameter copy, so it has no effect on the caller. Pl=
ease either drop that assignment or change the API to take a pointer-to-poi=
nter if you really want to clear the caller's mapping.

> +
>  void tboot_shutdown(u32 shutdown_type)
>  {
>  	void (*shutdown)(void);
> @@ -453,22 +478,30 @@ struct sha1_hash {
>  	u8 hash[SHA1_SIZE];
>  };
>=20
> +struct heap_ext_data_elt {
> +	u32 type;
> +	u32 size;
> +	u8  data[];
> +} __packed;
> +
>  struct sinit_mle_data {
> -	u32               version;             /* currently 6 */
> -	struct sha1_hash  bios_acm_id;
> -	u32               edx_senter_flags;
> -	u64               mseg_valid;
> -	struct sha1_hash  sinit_hash;
> -	struct sha1_hash  mle_hash;
> -	struct sha1_hash  stm_hash;
> -	struct sha1_hash  lcp_policy_hash;
> -	u32               lcp_policy_control;
> -	u32               rlp_wakeup_addr;
> -	u32               reserved;
> -	u32               num_mdrs;
> -	u32               mdrs_off;
> -	u32               num_vtd_dmars;
> -	u32               vtd_dmars_off;
> +	u32                      version;             /* currently 9 */
> +	struct sha1_hash         bios_acm_id;
> +	u32                      edx_senter_flags;
> +	u64                      mseg_valid;
> +	struct sha1_hash         sinit_hash;
> +	struct sha1_hash         mle_hash;
> +	struct sha1_hash         stm_hash;
> +	struct sha1_hash         lcp_policy_hash;
> +	u32                      lcp_policy_control;
> +	u32                      rlp_wakeup_addr;
> +	u32                      reserved;
> +	u32                      num_mdrs;
> +	u32                      mdrs_off;
> +	u32                      num_vtd_dmars;
> +	u32                      vtd_dmars_off;
> +	u32                      proc_scrtm_status; /* version 8 or later only*=
/
> +	struct heap_ext_data_elt ext_data_elts[];
>  } __packed;
>=20
>  struct acpi_table_header *tboot_get_dmar_table(struct acpi_table_header =
*dmar_tbl) @@ -514,3 +547,170 @@ struct
> acpi_table_header *tboot_get_dmar_table(struct acpi_table_header *dmar_tb
>=20
>  	return dmar_tbl;
>  }
> +
> +struct acpi_table_dtpr *tboot_get_dtpr_table(void **heap_base) {
> +	void *heap_ptr, *config;
> +	struct sinit_mle_data *sinit_mle;
> +	struct heap_ext_data_elt *elt;
> +	u64 heap_end, heap_size, sinit_mle_size, heap_section_size;
> +
> +	if (!heap_base)
> +		return NULL;
> +
> +	if (!tboot_enabled())
> +		return NULL;
> +	/*
> +	 * ACPI tables may not be DMA protected by tboot, so use DMAR copy
> +	 * SINIT saved in SinitMleData in TXT heap (which is DMA protected)
> +	 */

This comment is stale. This path is fetching DTPR, not DMAR

> +
> +	/* map config space in order to get heap addr */
> +	config =3D ioremap(TXT_PUB_CONFIG_REGS_BASE, NR_TXT_CONFIG_PAGES *
> +			 PAGE_SIZE);
> +	if (!config)
> +		return NULL;
> +
> +	/* now map TXT heap */
> +	*heap_base =3D ioremap(*(u64 *)(config + TXTCR_HEAP_BASE),
> +			    *(u64 *)(config + TXTCR_HEAP_SIZE));
> +	heap_size =3D *(u64 *)(config + TXTCR_HEAP_SIZE);
> +	heap_end =3D (u64)*heap_base + heap_size;
> +	iounmap(config);
> +
> +	if (!(*heap_base))
> +		return NULL;
> +
> +	/* walk heap to SinitMleData */
> +	/* skip BiosData */
> +	/* get BiosData section size */
> +	heap_section_size =3D *(u64 *) (*heap_base);
> +	if (!tboot_check_txt_heap_section_bounds(heap_end, *heap_base,*heap_bas=
e,
> +	                                         heap_section_size, "BiosData")=
) {
> +		return NULL;
> +	}
> +
> +	/* skip OsMleData */
> +	heap_ptr =3D *heap_base + heap_section_size;
> +	/* get OsMleData section size */
> +	heap_section_size =3D *(u64 *)heap_ptr;
> +	if (!tboot_check_txt_heap_section_bounds(heap_end, *heap_base, heap_ptr=
,
> +	                                         heap_section_size, "OsMleData"=
)) {
> +		return NULL;
> +	}
> +
> +	/* skip OsSinitData */
> +	heap_ptr +=3D heap_section_size;
> +	/* get OsSinitData section size */
> +	heap_section_size =3D *(u64 *)heap_ptr;
> +	if (!tboot_check_txt_heap_section_bounds(heap_end, *heap_base, heap_ptr=
,
> +	                                         heap_section_size, "OsSinitDat=
a")) {
> +		return NULL;
> +	}
> +
> +	/* jump to the SinitMleData */
> +	heap_ptr +=3D heap_section_size;
> +	/* now points to SinitMleDataSize; set to SinitMleData */
> +	sinit_mle_size =3D *(u64 *)heap_ptr;
> +	if(!tboot_check_txt_heap_section_bounds(heap_end, *heap_base, heap_ptr,
> +	                                        sinit_mle_size, "SinitMleData")=
) {
> +		return NULL;
> +	}
> +
> +	heap_ptr +=3D sizeof(u64);
> +
> +	sinit_mle =3D (struct sinit_mle_data *)heap_ptr;
> +	if (sinit_mle->version < 9) {
> +		iounmap(*heap_base);
> +		*heap_base =3D NULL;
> +		return NULL;
> +	}
> +
> +	elt =3D sinit_mle->ext_data_elts;
> +	while (elt->type !=3D HEAP_EXTDATA_TYPE_DTPR &&
> +		   elt->type !=3D HEAP_EXTDATA_TYPE_END) {
> +		elt =3D (void *)elt + elt->size;
> +		/*
> +		 * Check if the element is beyond the SinitMleData boundary or has an
> +		 * invalid size. It's size should be at least 8 bytes.
> +		 */
> +		if (((u64)elt > (u64)sinit_mle + sinit_mle_size) || (elt->size < 8)) {
> +			iounmap(*heap_base);
> +			*heap_base =3D NULL;
> +			return NULL;
> +		}
> +	}

This is still not bounds-safe.

You dereference elt->type / elt->size before proving that the current eleme=
nt header is fully within the SinitMleData bounds. After advancing elt, you=
 immediately dereference the new pointer via elt->size before proving it is=
 still valid.

Please restructure this to:
1.	validate current header fits,
2.	validate elt->size >=3D sizeof(*elt),
3.	validate (u8 *)elt + elt->size stays within the end of SinitMleData,
4.	then either consume the element or advance.

The ext-data list is self-describing and end-terminated, so the parser need=
s to be strict here.=20

Also, please use sizeof(*elt) instead of the hardcoded 8.

> +
> +	if (elt->type =3D=3D HEAP_EXTDATA_TYPE_END) {
> +		pr_info("DTPR element not found in SinitMleData\n");
> +		iounmap(*heap_base);
> +		*heap_base =3D NULL;
> +		return NULL;
> +	}
> +
> +	return (struct acpi_table_dtpr *)elt->data; }

Returning elt->data here still needs more validation.

Before returning a struct acpi_table_dtpr *, please verify that:
*	the element payload is large enough to hold a DTPR header, and
*	the DTPR table length fits within the ext-data element payload.

Otherwise the caller can walk malformed or truncated data.

> +
> +static bool tboot_tpr_enabled =3D false;
> +void tboot_parse_dtpr_table(struct acpi_table_dtpr *dtpr) {
> +	struct acpi_tpr_instance *tpr_inst;
> +	struct acpi_tpr_array    *tpr_arr;
> +	u32 *instance_cnt;
> +	u64 *base;
> +	u32 i, j;
> +	u32 ref_tpr_cnt;
> +
> +	if (dtpr =3D=3D NULL)
> +		return;
> +
> +	if (!tboot_enabled())
> +		return;
> +
> +	instance_cnt =3D (u32*)(&dtpr->ins_cnt);
> +	tpr_inst =3D (struct acpi_tpr_instance *)(instance_cnt + 1);
> +	ref_tpr_cnt =3D tpr_inst->tpr_cnt;
> +	for (i =3D 0; i < *instance_cnt; ++i) {

This still needs table-length-based bounds checking.

As written, the function walks variable-sized DTPR contents with no end poi=
nter derived from the DTPR table length. Corrupted ins_cnt / tpr_cnt values=
 can make this walk off the table and then MMIO-map arbitrary addresses.

> +		if (tpr_inst->tpr_cnt < 2) {
> +			pr_err("TPR Instance %d has less than 2 TPRs, further DTPR "
> +			       "processing interrupted.\n", i);
> +			return;
> +		}
> +		if (tpr_inst->tpr_cnt !=3D ref_tpr_cnt) {
> +			pr_err("TPR Instance %d has inconsistent TPR count: expected %d,"
> +			       " found %d\n", i, ref_tpr_cnt, tpr_inst->tpr_cnt);
> +			return;
> +		}
> +
> +		for (j =3D 0; j < tpr_inst->tpr_cnt; ++j) {
> +			tpr_arr =3D  (struct acpi_tpr_array*)((u8*) tpr_inst +
> +			            sizeof(struct acpi_tpr_instance) +
> +			            j * sizeof(struct acpi_tpr_array));
> +
> +			base =3D ioremap(tpr_arr->base, 16);
> +			if (!base) {
> +				pr_warn("TPR Instance %d, TPR No.%d disabling failure.\n",
> +				        i, j);
> +				continue;
> +			}
> +
> +			pr_info("TPR instance %d, TPR %d:base %llx limit %llx\n", i, j,
> +			        readq(base), readq(base + 1));
> +			writeq(readq(base) | BIT(4), base);
> +			if (tboot_tpr_enabled =3D=3D false)
> +				tboot_tpr_enabled =3D true;
> +			iounmap(base);
> +		}
> +
> +		tpr_inst =3D (struct acpi_tpr_instance *)((u8*)tpr_inst +
> +		            sizeof(*tpr_inst) + j * sizeof(struct acpi_tpr_array));
> +	}
> +
> +	if (tboot_tpr_enabled)
> +		pr_debug("TPR protection detected, PMR will be disabled\n"); }
> +
> +bool tboot_is_tpr_enabled(void)
> +{
> +	return tboot_tpr_enabled;
> +}
> diff --git a/include/linux/tboot.h b/include/linux/tboot.h index d2279160=
ef39..39fb2e3ba80b 100644
> --- a/include/linux/tboot.h
> +++ b/include/linux/tboot.h
> @@ -24,6 +24,10 @@ enum {
>  #include <linux/acpi.h>
>  /* used to communicate between tboot and the launched kernel */
>=20
> +/*TXT Extended Data Element Types*/
> +#define HEAP_EXTDATA_TYPE_END   0
> +#define HEAP_EXTDATA_TYPE_DTPR 14
> +
>  #define TB_KEY_SIZE             64   /* 512 bits */
>=20
>  #define MAX_TB_MAC_REGIONS      32
> @@ -126,6 +130,9 @@ extern void tboot_probe(void);  extern void tboot_shu=
tdown(u32 shutdown_type);  extern struct
> acpi_table_header *tboot_get_dmar_table(
>  				      struct acpi_table_header *dmar_tbl);
> +extern struct acpi_table_dtpr *tboot_get_dtpr_table(void **); extern
> +void tboot_parse_dtpr_table(struct acpi_table_dtpr *); extern bool
> +tboot_is_tpr_enabled(void);
>=20
>  #else
>=20
> @@ -135,6 +142,9 @@ extern struct acpi_table_header *tboot_get_dmar_table=
(
>  #define tboot_sleep(sleep_state, pm1a_control, pm1b_control)	\
>  					do { } while (0)
>  #define tboot_get_dmar_table(dmar_tbl)	(dmar_tbl)
> +#define tboot_get_dtpr_table(txt_heap) NULL #define
> +tboot_parse_dtpr_table(dtpr) do { } while (0) #define
> +tboot_is_tpr_enabled() 0
>=20
>  #endif /* !CONFIG_INTEL_TXT */
>=20
> --
> 2.55.0

