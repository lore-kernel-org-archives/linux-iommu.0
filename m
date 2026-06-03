Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782491D7E41
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 06:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468937; cv=fail; b=n8l8FjGMvG2kM4KgJ/bkUm0vnc4ByBVnYYf1axuvXePaMT7r9ZAXrPLn3TBMlLySKENBgdQGeSIzFX6n/gHpjuUPoWCK3feUOweLDSORP6TKTyJ6Bio7FSpBRH4K1DSFU3zWVrFWa4k/toUrbiqNVZ1YYUoE8dKy610thunRYcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468937; c=relaxed/simple;
	bh=28BB9wpIMdExu3g4+q3cXCSq9gcINdYgHlwb1fCH3EE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RhnlnTlK8QmVXeg87zIJuz5rV1KRD78iDoMeId2s3qmW1C+JDThZjGnljLG9RJBi2xEH5mnuKzTe8dS/Fl736yKAz1Q3HAJMNTo+auKLdToY1ChAXdRm/3FYq4CKzGvKb2+y3LaLAy3p73K75YRoh9LH76suNiOjWhXtXDs6adw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ad2OYXdb; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ad2OYXdb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780468936; x=1812004936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=28BB9wpIMdExu3g4+q3cXCSq9gcINdYgHlwb1fCH3EE=;
  b=Ad2OYXdbzJ28qX/7CralmiU+MIupgIZhIEG5ulRmYFPumkaFrRe+pIdy
   9kkM36xMLEz17x1QiU6LH1YAziwBh2lptoUOnjl/4SL1PVj5WJ3qBuqCp
   KJAXJQCQiKX8BLrV7AWtSblpgpRCWdimxU24AlJk3BbWQ6Ac+64cX4YvG
   kDvtfNAAp/I1rJPDUFKzl/m0ZBLCCqSM9dLplGWE7pGfFRHpRYKLwM33D
   zBjvh08122VOHsPWd1MTMV9cd558oXaocivCPDsBe3Eg7v7YNxLP71DuV
   izbrL3Px4ZfxKj6h3Fjipr/CxCF+hq+xBIDYS7HLZh7TR5APo5EnNPivs
   Q==;
X-CSE-ConnectionGUID: d9PZ+jb4Qgaw5hsOcSzVBA==
X-CSE-MsgGUID: cAmenbYHQU++OFYD/Eggng==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="84893044"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="84893044"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:42:14 -0700
X-CSE-ConnectionGUID: zvpQz7TXSw6Egx2ib42rKA==
X-CSE-MsgGUID: LabmxDi3Qs2xHO25alYPxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="274378605"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:42:14 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:42:13 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 23:42:13 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.55) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:42:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IkUPcSTHluGp4p/3A354uS5uGDOZ/1IbW0E++2glA9zRySLDTfqo8RSSuGvohz82m8peAqJpV8lDktR+KqDAnFXXdBMGWZXF1HQ9cFXyYeVWRvn1m0BXrLKI5cOZVCu0bKOdiWV8LrM3UvYol5F9jZDbB12L1vDoJx+yJXMlEXYKKFVaEbSfDljylYBvPt//IiU6aq1lA8KjLqhtfzMPv5y/gtHNKPOJ97+L/upTen+IsfQoH9cReoY5sXslIpUE8j6Y/bZNi9UH+kjFrF/7up+nWgkihSquFU8u33iIujzMimc4bo2Z66S8KJebfx4ruGeRJtJXEr7ql4ltpZQmaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ILCoYHJJrLcFdygd395DyFofQdff+McP3ExfyB0ahPE=;
 b=sDMdTHSS7s7dEAtS+CGjS61b2lCT1vsFQnbVhvAoRHCXVSEGNTKbjTx0s3SSIYKBMBV3+HQ6KmBpDM3VUxaw0Gd3yrQKWrivhyIp8E/gftwo1uzo8XMaiE2c9WqStJEwKx2Nniq65IQ8/vnZNDr63jldDOD5b3lugvXiI5RNttw0ymZZcEPZL15rx/jP1Ot22+wO6OUEvyslwz1AwKtRbyvBLul/C4xzghJ6Vhr/YxGlGsgXLl002Dsb9oQVVIGEl7f9X2YBDbATliDq9dylZpA8JAUmtUZiOH/jo/m6dpvBsVbX7qWHH84vuQydG/MPm8sH6yEjsys2ImVgorn5oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by CH0PR11MB8167.namprd11.prod.outlook.com (2603:10b6:610:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:42:10 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:42:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Alex Williamson
	<alex@shazbot.org>, Joerg Roedel <joro@8bytes.org>, Mostafa Saleh
	<smostafa@google.com>, David Matlack <dmatlack@google.com>, Robin Murphy
	<robin.murphy@arm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>, Baolu Lu <baolu.lu@linux.intel.com>
CC: Saurabh Sengar <ssengar@linux.microsoft.com>, "skhawaja@google.com"
	<skhawaja@google.com>, "pasha.tatashin@soleen.com"
	<pasha.tatashin@soleen.com>, Will Deacon <will@kernel.org>
Subject: RE: [PATCH v7 6/6] Documentation: Update VFIO NOIOMMU mode
Thread-Topic: [PATCH v7 6/6] Documentation: Update VFIO NOIOMMU mode
Thread-Index: AQHc8xwchTVMO8RKXES4wL0yJvbvAbYsYb1Q
Date: Wed, 3 Jun 2026 06:42:09 +0000
Message-ID: <DM6PR11MB3690D6F330CCEB909CEAAD6B8C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260603054438.2450130-1-jacob.pan@linux.microsoft.com>
 <20260603054438.2450130-7-jacob.pan@linux.microsoft.com>
In-Reply-To: <20260603054438.2450130-7-jacob.pan@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|CH0PR11MB8167:EE_
x-ms-office365-filtering-correlation-id: e3c91088-cbd0-48ee-69c9-08dec13b3cb0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|6133799003|18002099003|11063799006|4143699003|22082099003|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: IDCsx0EHNaP175FnmhGcR6TIkblgiLTX9+TQcOx10Mnrd4HWl74QLkUSfgm8/Gzkbq+y6FoQoFszNCE1keokcGVf07r2nBTV9v+sETo0Sm3fb9QTq+9SQpFuRaY88XbNYdEclVCUKgG8SkJjyU8I6AkFMB4QG2KgNum214cPoRBvcEuAF7MPtEagvfrSI9KVlNygC817Qs93Q0WLEeDaDZ0EaHJXK0I9rru3s+u9L8/o3fP+AzTb5nQvgyTKx47SmHDnulDnMqrPcpjmrZtbDeEQZeS/M5bjfgKtfrjhXhTM+lKCmx+bCom8M+mMf4hAuAv5vezSb1mgL4+BxLcT3ih1yMygnsFcsZVJ03+XcuEff6izNTRZSpTiNE2bdcS9FfeFS+1eRlxRJAOwwp4P5/lLKWjhiFOQJ+SDWFD4iA55z9b4/EQcEkQWnLxBdiQ7rugqo7JXNoxAlWAcm7aiEh1ilydTRyvtfJBM7xpGo6NVRfl43p2TOMwlXxBJQxJFoqdVjn0ouvPAkA9t7CD0+vXc4Jc2ZWN3NMYN8vPEU1Be6fDoctGH8WK3QfB66Cstf2DIdKmhwvex7fCWf4+q8AX5Z9SQGc6ARoIVeIMXZ9rLSMEYOdA6QGcC4tiQ3UQ+jUO3z8GdGbc0FIaqtreTxDoTGmHCiekgw2YMEOWW90KEOE8D89iNP8XP6iOwtlyuK0JcqHjzYJP6E3VvRFeO0uLtJYgSmmm0Qem0tMjYRGj8zWIbIMkvTyR4DR0J2xV/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(6133799003)(18002099003)(11063799006)(4143699003)(22082099003)(56012099006)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EL1b9GN623wW86uMMbOqFvPe2Romq0gSLEeojyfDN9TCLZT9F7Rhh9i+XF2x?=
 =?us-ascii?Q?OW0LE9/8OYVeaiQlcBxdJRGsdJBg+CU35XuUbFD1FkPBv8DkLmFYpKGHOLxe?=
 =?us-ascii?Q?nBMlDiy85ye/l3A2E+GeMOrlDrP+tytTVRpo0+xF0TVMULuZhTmoeTxEsPRI?=
 =?us-ascii?Q?zd8BCaPYxmpKLGhYWbTSRLGB6QUWwa9E+OePP5SX3qhA9bL3ds70clzuuJ5d?=
 =?us-ascii?Q?BeJPDT8JNnR6OYxKUlf6PbAVZyBYv+KsmZKyGeKV8/85pAVimahqaWS4II8Q?=
 =?us-ascii?Q?8u46pNVtIJXpHIXb9x9/LDpeJsgGxQ3+KOdZUYOQsGLlEGZNG7VBIub5QJEB?=
 =?us-ascii?Q?u6ibpG3zj6SYjg0tv+iRrozqzpMUuJmJMUUVeNq4wBsrDP3xFrLHsKm+T/cr?=
 =?us-ascii?Q?+s2FA/B8CcJpxLSrLUGAEC0bwH5rSFbtBh3uArbpHCU6zEWfG3uBGAinEdjZ?=
 =?us-ascii?Q?yKteq8otxYP7Tc/h2zG6PzcuOkroYe9XEAgFaL8Jklmkx2yBmDhHqpmDtQTn?=
 =?us-ascii?Q?ikT8f+cK4cGMT4vVRGx8otuZgIF0K+Oo4ms+WpH22FdyDQGYR+wmvzG36ItB?=
 =?us-ascii?Q?oKxQYXpkWWgyKCG6H5OSatVbQ5dSG88JLVtQmkV00wHEGsgFTx/RN6XGamNr?=
 =?us-ascii?Q?SNGyEThaJ3kZCbaf9XRMLmq3/iWRf3j+OUux/OGDKIaCAstpymQd/EPSt8g+?=
 =?us-ascii?Q?jIbBsZ/2+lO2GFtMq9fUNfYlyTvHS1LT7ZNcLVljGqAqXJU0GYYMjpwDO5VA?=
 =?us-ascii?Q?n6k01FfrJS7m8hWS9N4l1yfh3KTAuXQtkynxYOeEsYhGTKeDNZ9vwKrz2vse?=
 =?us-ascii?Q?Ca3kXTAf7Gy/Bu9SCiMVp7N+CS1McVNmAa4Z/n+E7zbNq35EkXt3lF3I1S0P?=
 =?us-ascii?Q?p3yT0CInb7Hv/OK2bsuQ87PGbSeKZEQG/6eJ3F7BdYAM7WIJbirGKoAEZV39?=
 =?us-ascii?Q?ygWOwxXEtkLU2gT/boBKS9vIZfTUm0bEBLG/dOvsCrMfMr6IZJZV56ju2j2B?=
 =?us-ascii?Q?riailMr4Vuu0duOlsNenlnap+BzUs3+QXmAgyrS3NzzihsFhArEUV1SDy11l?=
 =?us-ascii?Q?+hvMxHCWWs2Zjohfbnm+wfJzKCciSqLMcXY04QbfAk5OFNAtKIuVyIxs4hQY?=
 =?us-ascii?Q?NGofJwgF4nyhbtnFLY7MkxRcqVic7VV2WHHWJ+R7nFLnY/QnILNv6uKpeyRL?=
 =?us-ascii?Q?KxST91UyjH03hjBGAp8OZYhAJ3XkWXMk+IDDHwtZoVuZ5ugaiTFPtQAI5AcD?=
 =?us-ascii?Q?3e5tLrKaRWK8s/2Jxzn13cuehl6U3l6rWR1shd3jB+3IF8dX+2tRlEqPnxCJ?=
 =?us-ascii?Q?JRpVeX5cx2rELWvpQu1QiGovqwjiBSt3ucUgct2qgC/yoOuBraNM+y6jIwOC?=
 =?us-ascii?Q?Xib1Z+LMJpBbffLnCkCRPFk+iivxZV//d08kg3fH1ia8dFKwuufFrhApMcPr?=
 =?us-ascii?Q?lE5RM2jZhagXEA8YtBB1T8BORvx/nw5wjejOxQ9T8iYihbLWgOFvl29bqkij?=
 =?us-ascii?Q?4BXpaeM6CRXS+1qoQ00G+fNt3wSXvaxwk6GM7M35bP3Cu8lStlkvMvm2sQmp?=
 =?us-ascii?Q?73KNUE6P+xk4TUCeLzFiZO7XNlBK6aF5Ec+ezOOQ3YISLzAER1ROnZbApWdH?=
 =?us-ascii?Q?cTpCHjNbdkL9wZQIwJHOiqYcUaNO9SxV13n5aBApJ+0qIhy8gLuAVbyPM40y?=
 =?us-ascii?Q?Bpgu36LblNY8P/BwGGvqqQoK76dmwJYBi5q9o2U+sS0camcMZfsNn5yXhfhC?=
 =?us-ascii?Q?nl0ybF2ydw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: E4xQN6L7KG5yNMxyz1lSM7xrWZVY+iqQgLqKJ45DVPZr1LO4jugtcC0sg+8eazMbGVj9lCvl4d2QCvHHiDCIzw3/WXV9vbmptPGR2KyxG0z6PbW8RsY/HqkaGdEyT7lMNbWcgjgsc4FxoZwvWcQwLq11KWUfSGlrOcW8R6DrRj+GCwZp7HCpmph2rblPXh1k91pSqqksvUXxj/nVHhbNwBC4lCfoF7dkOkfBsDkki/IAylbhe6r1Z4kzJ5VimWqAaj3uAw+xDgQ4QH7jdd+z9LIuNQsCZvKhYSLIicCosyWmGuQ/lBVIdUZMEbfh8z6ocFOfIynojmQkYzhmiCyDlQ==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c91088-cbd0-48ee-69c9-08dec13b3cb0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:42:09.8117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lFv2ZdpOWV/YXWazsGfxxXXB/xxRdLHxFgqd8XHaxAcSJBpdkx5xTfTttn6c/JlDJBqEiFc/tv6YBE3lNeVDgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8167
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.pan@linux.microsoft.com>
> Sent: Wednesday, June 3, 2026 1:45 PM
> +
> +* IOMMUFD UAPI is available for VFIO device cdev to pin and map user
> memory with
> +  the ability to retrieve physical addresses for DMA command submission.

and no need of mlock.

> +
> +A new IOMMUFD ioctl IOMMU_IOAS_NOIOMMU_GET_PA is added to
> retrieve the physical
> +address for a given IOVA. Although there is no physical DMA remapping
> hardware,
> +IOMMU_IOAS_MAP_FIXED_IOVA is still used to establish IOVA-to-PA
> mappings in the
> +software page table for later IOMMU_IOAS_NOIOMMU_GET_PA lookups.
> +tools/testing/selftests/vfio/vfio_iommufd_noiommu_test.c provides an
> example of
> +using this ioctl in no-IOMMU mode.
> +

the test case doesn't exist yet.

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
