Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F35B1F5829
	for <iommu@lists.linux.dev>; Tue,  4 Mar 2025 08:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076399; cv=fail; b=cI8nol7jc7lmbIHUG7xvhEQrPh1zsnWc31IlZvrGCyv0EFK497GXj06yE4Qzh29vxne7/+ku46GDpQPaE4Kqk5WNV7TEz56yOXxHb7+Q6DnuZeqkq2ZwkDPTHQP3QGNr9lisNLA/PiZqvfk5Igkjq+kcjeAmGrYMpajYl1I515k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076399; c=relaxed/simple;
	bh=LOh79029OpX7HTOxwq7dg9LFpN/gmVD3ra3R/MbMd2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V9WQ5NRSnzP47PAan9bq9nJJ5ZAOb5YoOj4aNFI/q66X8DTrMpNmGtaVdE7EqLlEeoc9RQGkGh0DHULgCkzrBrxYjx20/WmKC8ZU3N6w2jR2645/oKkA5mTCZT7swKWM8OF+SWOdfGHW5vHNZf6PorwlOkK1vHIUa+k4Gl/gaQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mclj8waM; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mclj8waM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741076398; x=1772612398;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LOh79029OpX7HTOxwq7dg9LFpN/gmVD3ra3R/MbMd2U=;
  b=mclj8waMJm2Pa4ifjiWfZQhHcsowHOUlKDPqbtagTnLZtLhPiVsi577A
   v4kUTrIngs90VXXUKRsY0DOmtc/MFpo5R1NvmGbP1gGZdtPrRAixVOE9H
   KlZIXk0KTJE9MOdJVS34W4xBTm7XrbO5AmyuVqIUJKC8lxFASmyccKb5s
   i9r+Y4f8lspSqnpmlMzOhXddKD9BJUogLqRTpDRhGNMlUW47/5G/Qc/ua
   JEd5VsU1SnS4r7r0KPTu54V7J4bxURyUjZX+oPGIP4OvUAyBpQGLisFgi
   SHGRQcSqmg6gKGy9HJC+f1rO1YmNFb/uYddhlUcUi4CDzRBSSMtxI9PnY
   A==;
X-CSE-ConnectionGUID: A9q9X9uEQ5OW+Iz/Kf12/g==
X-CSE-MsgGUID: hI8PWSreTPacbEZQFUrnRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41891478"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41891478"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:19:57 -0800
X-CSE-ConnectionGUID: qM79Yib+SSCydu0tuYEFXA==
X-CSE-MsgGUID: wclggYtjRoq8LkQgHordFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="123424874"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 00:19:56 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 4 Mar 2025 00:19:55 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 4 Mar 2025 00:19:55 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Mar 2025 00:19:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K9LacSSgGF6PQMNr/AJi5QJRYSzGmcI97kknwm7yEypPDC1Argw9blRurhI7a443lq1jGXJbIvkcU4F1XOOMD/VqonHX5joF8wJCR9ZJeZkWENttQK7nf50vwYjX/ZNvhHBEW8uG5sAkM/33nrKcoUncPlTz2Z2ejZUUNmFj5NgDqv4JupxjRhZNiYsHhsjvhPgsSGPgnP0CZTOw6OUjX2tVgFV+u+8j6vV/JgSetoeV9Or1oVfhssPgnQx7lhm+TmgK4AfUpRDLhZyepXb6mH/oyGmNs5bnN2VXztJzma829W0Dvbmc4kkf5G40kqlAqPXJElcco8s1BjNQp57PYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOh79029OpX7HTOxwq7dg9LFpN/gmVD3ra3R/MbMd2U=;
 b=P08p6mj6+6vuMH44ZhyTKpRzBek7D5Kia9KDqs45HiD/2EMcNOG+1xIg1UfZIoi5BrqAjkJirBVmR6liqG7lq2bf2z7l4Z5Bc9gNws/aFYq8RyBs+YXX9by9NftVOKKlWDpgabsjbiYivQVfNJMQ1nqxO9dPzG5zc3sxPkEJQ2SmUPBThMtaxCzf7vLv8MLDeYpjJfaEEDkYdHeP2PdMwDAhY+IEJleNlVMbRYmo+tNkv3/kS5fVMgj702rniiodm2MHQn4wqnPsCpqBH2+FF3CSIuaYMgDph8Ah8UD6iT2iHslHqsMM0rPNODhXRc0HvIdaOI9FO21QM3y3rZH8AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA1PR11MB6171.namprd11.prod.outlook.com (2603:10b6:208:3e9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Tue, 4 Mar
 2025 08:19:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%6]) with mapi id 15.20.8511.015; Tue, 4 Mar 2025
 08:19:52 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>,
	Fenghua Yu <fenghuay@nvidia.com>, Zhangfei Gao <zhangfei.gao@linaro.org>,
	Zhou Wang <wangzhou1@hisilicon.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 05/12] iommu/vt-d: Move PRI enablement in probe path
Thread-Topic: [PATCH v3 05/12] iommu/vt-d: Move PRI enablement in probe path
Thread-Index: AQHbicLiHSmkjwLikkGgRHi0bBGkY7NiqJwQ
Date: Tue, 4 Mar 2025 08:19:52 +0000
Message-ID: <BN9PR11MB52763398A77DF773335BA0AE8CC82@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250228092631.3425464-1-baolu.lu@linux.intel.com>
 <20250228092631.3425464-6-baolu.lu@linux.intel.com>
In-Reply-To: <20250228092631.3425464-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA1PR11MB6171:EE_
x-ms-office365-filtering-correlation-id: cd0a16f4-713e-4042-8683-08dd5af556f6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?IjP3vijBAHosRRj45pYE4yUWL5FVsU7KHszvuExLUCHnHs7yI5xT5080SGI1?=
 =?us-ascii?Q?8OOlQyv1PZ7CmEExyvX6gXHPG7KmmjcrjQUmomohjsYTHD3WCiI6KU5blPPc?=
 =?us-ascii?Q?Tt1I6PGH5vqelXOxx0InPjqAWSkv71jFWInVbHGQ+X7icWyu7COY2Av6ikJR?=
 =?us-ascii?Q?BqECuzhukDz9lju5n+tR6ggZowRfb0Z+RFbJ+7M/U06BRh1M1jWiJrspsxzn?=
 =?us-ascii?Q?+jRl79Ux4VtOAELsVudu+s2mVLKSQP8Fwp3VGxo7m5yYxV8q7pQh+FfAUZLR?=
 =?us-ascii?Q?dI+MNQd9Dn2dvu0aGODGSiCN1ZtpUaWF0NscNSCBCoWnD48ZStpaU4cn91CT?=
 =?us-ascii?Q?ag+c/jcZ87IqpKammrbXr9u26Bs05zUUrmvknU3/XPEnGQngJIpHlhaCsmuS?=
 =?us-ascii?Q?1nBmDCEY9YBPhcHCMomHtjlzZqaFWjVuXx3f3jqH2OspnV4DnR7bqDL88vLt?=
 =?us-ascii?Q?Fd/63PjqT8c6toVsKh/geW7H1ZxtdYk/wItXX2KqCR3YySIpEjy0m1tI9xhO?=
 =?us-ascii?Q?W+/l876E2Y4t5QAnEuNEnE10DlfFl6uwFsnNpYsA+YFNTSW5Jko4qhzFhOYr?=
 =?us-ascii?Q?zv+R50vYJLeNQHEaF5BMF/h3kL5sHP7YbvNXukkjR6CldbHEv7+fhCfjGKWR?=
 =?us-ascii?Q?KyXlFpzlsR0u762NDy4044d4l+k09JeZyBVZ3lfFqnEDVORgUTNdLV4PT7so?=
 =?us-ascii?Q?yvykMe4cr9BXfyQczIWGLmOgxCt6E/Fpuuq5/K5taLvaFvPoW8nH/D3YjMpy?=
 =?us-ascii?Q?9Vb+6erIimWojZy1qKHGZh4455sVHTddyXiEx9Vr0AD8Uiip5l6OicZTlBt5?=
 =?us-ascii?Q?IQXdketVjw6ig4gwug3SI7jsqikJfHYrNAgwYbOzAX8V50ZollawjyFNL9pR?=
 =?us-ascii?Q?sx49mqFz/8BWoxYeWI0Q2hAiuWkparOf7IAKd4+d0DMwtADpDGTVusNzse/X?=
 =?us-ascii?Q?WAHf+2fL9o1uA+zjhj7HQHTtVDyzUAHpX866NDeE0dpyjve+s+QBRup+bgvr?=
 =?us-ascii?Q?RZSmmAYMDVcwXadAwYUtY5tWg4aaiB4doCuoD0T5ir0JNfH3WAOUFnWmpIYq?=
 =?us-ascii?Q?t2hIFtRBgDCHKeUfwS30IWrNmlQurY3yhCUg4l14S7Be40AphlmGStflnIY5?=
 =?us-ascii?Q?D9a7Z/JmOKJ/GRbhJucvEfkKFcdECD0cjZc+RE2sB9XnHi1pY6pGEq058jOJ?=
 =?us-ascii?Q?hsqtQqPWhqx7quSlFZU7Zp3T3erP3AbS5l3KaRjeF6lcc8cFIBCPch+84e0y?=
 =?us-ascii?Q?asB/hJ/fbvbKeFK/vj15xPF4kTydI+3W2WXFC8Sk5xNjp1L0T/Fmn5rwo+H3?=
 =?us-ascii?Q?JZ9qhwiGFQdYaya3HL9QQF+3Wx4oyfLxp3x6Uh3D0XingckX9s5rD31o+E3s?=
 =?us-ascii?Q?yB3P5KA6XPGiZ2J6otOEZ+A+e6j3KcWDUh6CMPeNwikyMheIAFFIP2k58AvZ?=
 =?us-ascii?Q?6tXDMOQBWPWJlMy72mlBCha4tS51E9mt?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?D9EoQ0wZIcjbgNtXl5eW1Vog2FwzuhMITHx58wtZIGtxrOfalZmHom+Slfoy?=
 =?us-ascii?Q?o3l8TOrWje0MkHJ4TeHrAQY/lnx8vpRppv7OEwWIC9tmCkZMWfIQEbifNsK5?=
 =?us-ascii?Q?I39vcr40kovFatcSny4XBtHtmyAvYUzkCrOVOuTPpslnSluU0gvdcPtF5tv1?=
 =?us-ascii?Q?VuTJPAvRKx0r3vnytxn+7gwCjpiyYMpkO/5yaLwdcld7xguljXCI3xDAHmk5?=
 =?us-ascii?Q?97YHZWZOuPJaMVuCnjCA5AL/4gYYZ1Tp5/anIayhMCzThMYO36HT8uMQOuTP?=
 =?us-ascii?Q?zQlHFycgFQoXosuiQszDVkadbQFZpApXDsKzU5AJIfKK28YSQ7NgQPmvIbTM?=
 =?us-ascii?Q?UEozk+iGxdsoTVO2S6JmXgA4YaF7YCsEONk4UQ2IuvkVmRbXTJCmmw1ltZ2G?=
 =?us-ascii?Q?PriiwXqCsW7MWIilD3r/5qKWYcvFa61CLsQrNymRu8wNQe2SKOX4akuZ98pr?=
 =?us-ascii?Q?M6fKOLIuS3se+SdfXQRHwQFQbRhoxdd45Dw52Wmcxonrdefz6qcvLnN0QFrA?=
 =?us-ascii?Q?mqyqBUQhBfrmSZdeKQ0UDCtyvUzwX7r4Iw/xyNdeYnHTK8CoBt0BJaZ8l7ml?=
 =?us-ascii?Q?lnitBbUkCZcvIB3QE/SuvUusOoqvstwYkj6FGpSG/Z+2MgVJH4MkuGPpYMxw?=
 =?us-ascii?Q?SEde5O9yZOXNHhkIc/5yt1XzGlFNyCTTpZFPnreAubVKmT1rI/VYRV4gv9Ha?=
 =?us-ascii?Q?x9/DSc1nrCsIy3q+7ooTa79bm7FzdLQy0FQmFvMK+bQefnmlQ3TkgCEVqf63?=
 =?us-ascii?Q?sOXXp0dn3cGz/04Xo2wJhE170QrAt/FwfOctPSMgok4VI6IasCfsngl8yJTg?=
 =?us-ascii?Q?NqvRgHkHzNa6PMzjuqGcjZKUbw0e/NBjd+nLS3Mc6JQ4IF+LKD32MYrP6tj7?=
 =?us-ascii?Q?X6wg5YoVTvvupoRZ5ELDSzuR9mhDF2goRO7Gq+IaeMIbKQ4g1NhA0LVUaSfR?=
 =?us-ascii?Q?Nzh3DPlBbFCvJEdk7YemkC3ZOpv5abe8dr5FD1wmgJkFRVsHYlBQD5tYpn2J?=
 =?us-ascii?Q?XptaaBhbM2OMOl3x6YLbqm8Zz5SIe8ksNobAeuCpPQuLt32v/BEk4sgRlek+?=
 =?us-ascii?Q?+wYVfxJmAkurZ0/M93DJJtU8Up/89gI3lFR109bNPsOmuhyoreAu5iYGj5p1?=
 =?us-ascii?Q?mcFpHOcmbrPWsZkbBaBbT5d1WOharGKP2YOJVCTYtiLPrU63ucSug1UNOg6w?=
 =?us-ascii?Q?6xpILZtrLUmyA7iTf6Y7451l+3vCi6VKnv3ZEhOEt68avPKggV4cl3hAz2bS?=
 =?us-ascii?Q?PXIm3QTODTBYs9iWO+Q1hBe/UbHeWsNuF2PWVoJFWDIlmZZoBqJplkI7yQYU?=
 =?us-ascii?Q?8oNHLEnq3d/L/W/oybf67zL5JlsiC95O0kmw0dAG2TWYI8Eql8H9PeMKmZTD?=
 =?us-ascii?Q?spTsoR0QDSas5v9Xw/653CgAcTou/EOZ/WovPxjpA1r14ThYepNd0i2nn0vs?=
 =?us-ascii?Q?PgS7oG6j090FRQ+p8HQS9+7wbAo7C7qgUKfTHDB/aJyV7xIUdQEYSPq8KkH0?=
 =?us-ascii?Q?L3JReMC0/AaWpQTl11AZRiBrkDNvy+m9WFesHOMBxJ8aPufE7vqjHrNEgWye?=
 =?us-ascii?Q?7743s2XImVvmE9GnXU33dEHyMGooRg6c4XyZKBXD?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0a16f4-713e-4042-8683-08dd5af556f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2025 08:19:52.8485
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ncwDNLx4/ltpsZnuO+NgNI/3ngd00BK+dH1/9rny0jCkcLYm86ii8C2XTzFpti0N3cMAq1rTH1+dXFe8rEZgWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6171
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, February 28, 2025 5:26 PM
>=20
> +static void iommu_enable_pci_pri(struct device_domain_info *info)
> +static void iommu_disable_pci_pri(struct device_domain_info *info)

no need to have '_pci_'

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
