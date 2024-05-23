Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D91187F
	for <iommu@lists.linux.dev>; Thu, 23 May 2024 06:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716445300; cv=fail; b=rExxG37RO1T9ep8Tqy1A8zwc/5km++EJbd5A9TBhbWHTjaSQ1H553BIm2UBzYJY9CWogadVV7zeYyiwv18Kv4VuP0yhww+MXTG7rdLSWEqU0JQ/2+jVLiO00+lZp2pMHgXjXfKWZBPMIr4yI7Uj7I0gmsI75iMrw/F27mcx2JkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716445300; c=relaxed/simple;
	bh=9lmtPcFjxdt69CuifmnxmJbPby1m9IVejdbSzTVnSNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9jmqJjaYRrx/mQsnity8gGzR+GlfhdDKoBHxuJqoK21quAuzzWkJaoo5+1qfatcbwF4Mqhxz2tR2CJiw3fIoXhjUG7pOr/O8FlRKzTGShTwW6j8ZiFoaOGsSpg77qZ2/CqMhHxEDooe+jMUX/tPd6gyGuERUMiJStnTG72qG4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B8OVuohW; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B8OVuohW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716445299; x=1747981299;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9lmtPcFjxdt69CuifmnxmJbPby1m9IVejdbSzTVnSNM=;
  b=B8OVuohWm5cH27kMUapvMxL0wk70ZBSQ6BjCjwZ0xrSn0LremBFiQrXu
   XpLQvvJoTZ0uK5uXG2tL+uUJFNZCr2s40W/TjxQH/XGwjYqxmsxPbloWL
   IIgr0YF0QZBy35GBcBZ8TqFZOHfo1y5g4rHcef94Y9HDzqS242CbG1i2v
   CyXN4u0uQ+fAbdy8hySS1nq/bfC1kOaVGrYYtm33Sah/AG4mVPxvR3oY3
   LmhGt91ycCi8tHFhZBRKqcqej/cGZY8dxMqIwc29JayGgBP8/5+gWjMkL
   ffs90/Mw6oAhLacMhObCiwc8jyKSZ3o+5V80rH5jwCeQhqKlAMNv3DxeS
   g==;
X-CSE-ConnectionGUID: LkdXxymeT/Kqbzd+KjyEdQ==
X-CSE-MsgGUID: oDnieF9ZRFCo0dF2Wql8Dw==
X-IronPort-AV: E=McAfee;i="6600,9927,11080"; a="30240575"
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="30240575"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2024 23:21:38 -0700
X-CSE-ConnectionGUID: V6zeDXGqR+CQpHovrPv/hg==
X-CSE-MsgGUID: WxEGV51NRQ2bIqzkl3JqCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,181,1712646000"; 
   d="scan'208";a="33561801"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 May 2024 23:21:37 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 22 May 2024 23:20:50 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 22 May 2024 23:20:50 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 22 May 2024 23:20:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdMP+XwcLaM4dLG/aACSlgNwNGXT/lk7/gIu7ced6OzdP/YZK38Y+9hDVDKfe1G2TTJN0j4jswZLPzuAwB1pidMDghMUfgYntMNSjhsOLL7r2nyX/PuFBmfdyL0jUIvdZfZ/yjFxDpxhy6RZLOKAoarj4pxOGBqvUL1pd0cz10E35vuqD3FhG/yxqead/PHbjgrvATGVGD9jMm+yHM2SAVP0YKDAb/9rSpiSs9bIhkqBKNJY+F9PbDxgjegFzTlnOrQT8aytt+P66hgmlxPTlcxyz/cteimQOWgIVIq5EeK4OdmOJpODIxkMwYg/Kvhy5pS3kK8xENAg7/+355pfmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lmtPcFjxdt69CuifmnxmJbPby1m9IVejdbSzTVnSNM=;
 b=FzD2CkFhLJ1e3+rf1H9zPMEUenBvBlF7GYU/S7aS8XZv+MHj2S2hBs1n+jRd1u2OMPD5ACFZ4WIurzBzcu+ZHnYp3IG9lAwrXNI3mJDI596x3etbPezoY3oUbmX9E81lL8EKGHNxdJUTlpvPeg+0AysGyx1PwR2LpAnYeCQtSfz624mfMVvYvr/ons+Eu5MovMmujJTHktEJRwEzZLqtgqw5RD+7j47ep7irQar05GIu7BoINQ0/t1+KbLYr9RbxXmVt1eG56HTcsJcanzhhWHT60zaF2FxvC3T5mwH2+Jn1LG+Xm0al5BvkWv0+o2eDe+iOJ0vMDSGxXqnEI/QB7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH8PR11MB6973.namprd11.prod.outlook.com (2603:10b6:510:226::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Thu, 23 May
 2024 06:19:59 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 06:19:59 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>
CC: "will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "suravee.suthikulpanit@amd.com"
	<suravee.suthikulpanit@amd.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-tegra@vger.kernel.org"
	<linux-tegra@vger.kernel.org>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "vasant.hegde@amd.com"
	<vasant.hegde@amd.com>, "jon.grimm@amd.com" <jon.grimm@amd.com>,
	"santosh.shukla@amd.com" <santosh.shukla@amd.com>, "Dhaval.Giani@amd.com"
	<Dhaval.Giani@amd.com>, "shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>
Subject: RE: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Thread-Topic: [PATCH RFCv1 07/14] iommufd: Add viommu set/unset_dev_id ops
Thread-Index: AQHajVVq/X0HjqCDvU+a/LkdwhCQ/LGT28sAgADojoCAAk6vgIAAqT2AgAqBYwCAAlS+oA==
Date: Thu, 23 May 2024 06:19:59 +0000
Message-ID: <BN9PR11MB5276EEC2A1DDA9C92F96737C8CF42@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <6e57d7b5aa1705bdd547b1cd2aca93d3bf70dfa4.1712978212.git.nicolinc@nvidia.com>
 <ZkDWXnPW7CaX5TtA@nvidia.com> <ZkGZc5dvLigXcWib@nvidia.com>
 <ZkOI8ztR1mUMJ8oe@nvidia.com> <ZkQW6/OAQ8MzN6Go@nvidia.com>
 <20240521182448.GN20229@nvidia.com>
In-Reply-To: <20240521182448.GN20229@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH8PR11MB6973:EE_
x-ms-office365-filtering-correlation-id: 8d0d8809-63a7-4e65-2d28-08dc7af05f7b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|7416005|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?3BiZtaaShjhcABsuymxdarJHQ4aNjbrcsqV2OR1sVn2cbtmLH+hkVfhbuQ22?=
 =?us-ascii?Q?hXUbgKIvPiSRknjgHIvPEikcYEf1PHhT4DxfjhSJYz/J/58mWhMIsyjWG9xq?=
 =?us-ascii?Q?JBwRAALrQu4J97nz8JWS6iVvfTGdRuHWNHj+yvZK4coh/MhNGQsbNY4BgAGr?=
 =?us-ascii?Q?j3xkcS4cdUhE19nYUd41QEU7GgbjE7NYtfXkMa3baDerCoqghJjxNF5M2REs?=
 =?us-ascii?Q?kEe+7mxdn1+Eoct8oykfHvQZLxqMQ+wlCKJfY3uZjqI0+bCtyqy2zBBTUXOm?=
 =?us-ascii?Q?bLgNDLQP6fTvHPEAG9QYSXQiKfvMOli1hNTUGEQJE3qTP9Yxs96jo3mQFH+u?=
 =?us-ascii?Q?8oUOVIvDKenYR83vsnF2fnTXqrH4frvbmvklQ02JnWoniUAF40PDDZjgAxt7?=
 =?us-ascii?Q?IWaYmdjxP3zO+tP7ER5DFUmLvx2GAE9exIP9KWoGl97/rK2SzF1OFK7a1SDO?=
 =?us-ascii?Q?vJVMgVApmpOdq0Owd+KWvXt1YsBb3tQX+5YVoduekx1z2sremQScM4JZC3O8?=
 =?us-ascii?Q?Ik27GGvIRf0G+1qzcrGlvnY4xKyTQk+6RJAW4Y2iopOkkz1gUh7F6KNyBg6j?=
 =?us-ascii?Q?5z/yoMcJLRQDx+qTyTV7E+uqeOOkY0zgwhUbBvjIMTFJmEKLiI1x8lq4FZoV?=
 =?us-ascii?Q?TecJR7KkeC5VPqzELPSRNS88CeFawTRhQMavBafHoMEZcaUijBcQzFc6e4Kb?=
 =?us-ascii?Q?DCLeVaeMv8zGtpXiGHGE750H62u0MB9hNdi6VAHwKNjn+hk2z5Ojo1YPeMhX?=
 =?us-ascii?Q?9Z9Oe+Wk1QOIrtX3tPUAawn977zQbM1osf54QrbminTCPkQhknnx2DIvT4th?=
 =?us-ascii?Q?y//EEmZqkHYeka/XPs+q8o+HKbMxapa34yNlccmbTPExiWqpUgurHIDwtV5s?=
 =?us-ascii?Q?T8G5W7M59tIBdc8a0g7/S1Awc/3yECTlqFQYoVz/vkXBZJIzfGKRIXFzX+iB?=
 =?us-ascii?Q?600vbNo4n3qxglFTWL8c2p/Te9Zu+rDoSOubxuBW3D4Df4nfV3JX2zM9FSEr?=
 =?us-ascii?Q?YHlpFY1EpboWpI9YMrnyGTds4VuuwS8FanL+WUmoMkrEjpG1KN7d0jlYywcg?=
 =?us-ascii?Q?bralupTJ+suEfmxjZDk/VaThWre+1XMvEAOOYd3af0SRG+qcVX5Aj8yEef4P?=
 =?us-ascii?Q?RTEwzy+K+VC/TY0biNafxYZNUXoFIfwvvFZPcRH+54toT5OzQbCI8hftlgfb?=
 =?us-ascii?Q?WaUiapJ8T7Ihu+tEzmVmbe2T9H3IChwKaeSINwY/k6UZuZRGLo/Xpyif13dK?=
 =?us-ascii?Q?czdU3MvIohd1xttt4Bmyb2iXtadvmsxmrDg84GSkZ2/SZKtu/Nas1P7jt1z9?=
 =?us-ascii?Q?EfuJRVS1ZScTtvQ0mW0+GgDdtX52AtwD2uHT5CADPVvgfg=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NWcgwnIZ4BeocKoZhOkClL2K3hsWL5qr9lmpp6Ylcw9b/5xIfiz4OzUhC8md?=
 =?us-ascii?Q?4mtoweno9G59HfIxvk5XTm8hvYs9oJRoI6Zc8UXHzqUQNYKJh3/Uz3vu5lfx?=
 =?us-ascii?Q?zOateqbY7hXGVuIbcJ49pkQtvrkmjOchqZTxU/jU/rFgdm5yWxFjZZorZLdn?=
 =?us-ascii?Q?zr1IE92Ji568qJB97Xo6k6TrZlVFJUguDbhoz0WWNCHq9l8di4QogLaF0DPW?=
 =?us-ascii?Q?BU2GkgAoLV14j82KOUVJfDEjLOPOLw/9J+STDdAhF2uIVtl29bRaAT9+tZde?=
 =?us-ascii?Q?hFMDhQUhgFKbPaDksQGAXS3zBaT8f2AlsMI9guvnlCRUnwzGk3GlyvUTuKLP?=
 =?us-ascii?Q?zPC0WV2DEkc7I+vJpUh5Wto9E71SZyCbEBnHY8y2PbH8OhvunDvBYK3LKlb1?=
 =?us-ascii?Q?9mg1u1Xj07xQEvXIX+3epw1h6ALFabxEGPCO13M1orfPGIO1Cxp2TH7Agsg4?=
 =?us-ascii?Q?EXg6epF/OzEjf+9+et6a1Eu+GSQzf5PQYXuxAvH5kGTewlQqwz/JVrWjQBBM?=
 =?us-ascii?Q?uaXyZtRrr44qqYb4Y79heNUfG7LFA2yTV8I18KZCglujBgcc47zVRRYpFGN2?=
 =?us-ascii?Q?rE52Q8Xcvw6xcCRjLLBjbq7twCi8hMYpxu9Iy3DmgMze7+AzbENKwOLoLHz/?=
 =?us-ascii?Q?LLqrXH2btZNmNSa86p7teH7JWGEbPvwLM/Qrw+TPD97h+qDB3Lqxcis9C2CG?=
 =?us-ascii?Q?alsl/58z4vkyaopmiBLrylKBcF6bkHk0eHOL6xxFn1UBYZtYWBoV+KJC/4uw?=
 =?us-ascii?Q?m/Gn8bLaFg3gcCear41sl+EzBtVTCKDAiLsozAhiFDgQaRST7fWNA8vAk+BC?=
 =?us-ascii?Q?D370ECfNT/DWHZPUscxOBbHBz/hb/qKl37RG3rKM0abaw1KBBV263kS6rPwj?=
 =?us-ascii?Q?XwlAsO4U4TxXhiN+O8ZXmrKlvOhwcC8ZHIZ+bu33eqnujnB9/V+3bKB5qhUO?=
 =?us-ascii?Q?PiyGAtpHnS4jTl8Hh+ZnDC2wT8nN9YtXAeuTHyKxzQQpJGA3p7ZGqDtcsLDL?=
 =?us-ascii?Q?8cYDFPlvygPyTT81u1VRveDuCBLTiUEbx4rGKNn9XbvfydJIaQAhaJdZsrQ4?=
 =?us-ascii?Q?dzM9yff09LkNDw0wgRHBrPoIditz0JiH4b5hBaM+mOEF/gNg21l00b1d4uWf?=
 =?us-ascii?Q?O6KTkrbRPRyQqYmEH/GFG7zBi20Lxy42RrkrZtFZRcnCScLuS2njq8WMRqwu?=
 =?us-ascii?Q?qPmPS5ztyDe3bOTp3fkJpphR8yA2EPXeGJ2fAvCNeJETavUWYY3Mf89diquv?=
 =?us-ascii?Q?sQ49h2Q8/RApmMLc13eaOSNxU27OzEfeEqHBQw5tXgnfDo/ToJd5FmvRqfPm?=
 =?us-ascii?Q?NhEJFt2ilwaIeQJdZJ4I/g5LykfP9rU2z1Ko0ujKwN+sarnlkFlfKdguLVxw?=
 =?us-ascii?Q?bCj8aAvXTdT95dG3OoYYDKUWhKlVnH/jMuTcSBg78BNntz6QzVWEvGxAFdDY?=
 =?us-ascii?Q?zicGWHtG/yuUwqGoJN3n09vtu2N+5fh/b7AAznGpOAzxstdn5bneaPkXs7Aj?=
 =?us-ascii?Q?Usmmhw4VCw3jNw3Q1/p8+UXMYqWydEFwca6vEDMwa0NvbHuqvl2AQKWFHhJ5?=
 =?us-ascii?Q?azpJjKaFhGto2cJ5t5Fo0qx8E3UL9M4k1dq82OQy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d0d8809-63a7-4e65-2d28-08dc7af05f7b
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2024 06:19:59.2076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wmqunNcCzeuAgWTwQp7NfUfrRsidt3QRaElTcx0xw44gctaJ8CY82Cv8710BL7w0/3ur2lefZleBwPo7JTaviA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6973
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, May 22, 2024 2:25 AM
>=20
> On Tue, May 14, 2024 at 06:59:07PM -0700, Nicolin Chen wrote:
> > So, you want a proxy S1 domain for a device to attach, in case
> > of a stage-2 only setup, because an S2 domain will no longer has
> > a VMID, since it's shared among viommus. In the SMMU driver case,
> > an arm_smmu_domain won't have an smmu pointer, so a device can't
> > attach to an S2 domain but always an nested S1 domain, right?
>=20
> That seems like a simple solution to the VMID lifetime, but it means
> the kernel has to decode more types of vSTE.
>=20

why does ATC invalidation need to know about VMID?

Or is above talking about beyond the discussion between DEV_INVALIDATE
vs. VIOMMU_INVALIDATE?
