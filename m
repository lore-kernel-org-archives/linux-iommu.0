Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4002C274FE3
	for <iommu@lists.linux.dev>; Wed,  3 Jun 2026 06:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468742; cv=fail; b=bu4D6BXJZBqErdNgcYwT663Ds3AG7snQwQ2hj5SQFZgX/3SJVJ1YEjH8ypO0GX0cao87udJtLzhcG2gkD2ZyWPf/mVm8gzBM+oqMkdE0z6Mw6Nmh5XaPcUP+MdANNE58O+OQ/shz0gONnkni1Vex/0HZyKyz7XljNABVmNgnLck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468742; c=relaxed/simple;
	bh=Du5W9DStze6wUWCiqpA+9nValFeG4KtZvzg9cw5xjI0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ch110KxXRxD7TBFyIcDO9H0wWtxjFEJbhhJeSjvWKT7shq8avWGUb1uI0l8fNP2FLBz8qLjA3ZAiZRDYA5Y0PaCuQR6Dg/VePyL+/7H1eesELSOWbmd/CG46pkKYBRwDOlu6VmTxx9+3vXQUm2pwrqMoH64jLao6RfmlLz+HbIM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgEWZiH1; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgEWZiH1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780468741; x=1812004741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Du5W9DStze6wUWCiqpA+9nValFeG4KtZvzg9cw5xjI0=;
  b=mgEWZiH1A9vCKNaFAg2mG4Yxkq55jXRMRN5iB8RABlPquGhpmDeMm9CC
   B36ekmuhZUB8CK6h5u3IldzQLYT0HKBTQxsT4+rJb6mjvpYLX4jNDA+ir
   N6x7rboLZNzf+1FmF3pci4Wc2wCRZkFq2IUWKjpSh4BTTYXDqhgq3w812
   GCGp5My2LeQwD1rCaXaY/llH9id2yKc/B3nmWzotKOMtaQvRkMrQqK7tE
   c1IR0HasD+bokKnHvsmigs7+yYNK25loyWot/FDXFGaEs4c7GoS+4A3c0
   XEXal6+r1lIQBosSvhEp8h2acmvZpkTcRUKmvwHfQ2cp3rFlEduFQcLmy
   A==;
X-CSE-ConnectionGUID: FbWATXrMRqq/rQPqsgWYyA==
X-CSE-MsgGUID: WMfqRjF7RMCe3D8hbjFH8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81168919"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81168919"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:39:01 -0700
X-CSE-ConnectionGUID: 9QsC4FrIQdmfPG/H2O+p6w==
X-CSE-MsgGUID: 3joZpgdVQS2n/hkmIkyWZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="282242179"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 23:39:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:38:59 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 2 Jun 2026 23:38:59 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 2 Jun 2026 23:38:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PLYBml1eUfHfa4mcMH6mEX2Bup55GSuupSK/WuYUVI7nax6JpJTVV/GyPsluI+3zm1tHVKyNDRvMeAqUHqyEyOMZn2PhBtVvOVewm6ByEr3hYyDkYa4uym5i0EsnZMW8qrszm/+lx34sdujwrdfSMgNkjtecvi5uLuhCtVbZzVKkwNwLnhpgxTD4PttO8TQjlTTDBBKsPpA27RbP559cAsBCE4mOG+L3SAO0zQtUriRhkGruCpxsP+Q33gcmgtmN2EERmG1UFHDj+o8hYlUcV6E//OdI5KdcZLkkkbIIV1zhPk8CtMub9/ASHnEkUKKWN+w7mly7QwBs9XVxdZ6ydQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lmk3O0rQY+/wD/QXkUNSN/wFGjbqHYRi20cIXZvnYJ4=;
 b=iw044WOzJb8m6FgEntc+RJQXtnpgBzqKaYPtT6ttd7NU7cGlldC9W5Y5gw09GNogKm4fWmO+q9ObR0BtpZ0S81irjnhwqwPdhw+9cfgfGUtB4yHVD4lqHI3ZYLei0a5FqDBMXAxv6nan6jp+7upU2m6TDdTwYla/t0f6s4Bpklju2bVYsMFsCNyCeHNnqcBhqTqxAY09qmd30ptv9WgYfAK8SnZafVa6vtlBGkYhvfuoNp7pXHdXzrmPX/ZeEhnjONR/HKj4lLHeYYtt+avUXOF1hoGk9gaOLamZ5aiw0W0iRgm+Gqc8jdOLmkSZOFeUu+Xp/pxdS913zHjv4RTZbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3690.namprd11.prod.outlook.com (2603:10b6:5:13d::32)
 by CH0PR11MB8167.namprd11.prod.outlook.com (2603:10b6:610:192::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 06:38:56 +0000
Received: from DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b]) by DM6PR11MB3690.namprd11.prod.outlook.com
 ([fe80::7db8:f6b3:30f8:ee4b%4]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 06:38:56 +0000
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
Subject: RE: [PATCH v7 5/6] vfio: Enable cdev noiommu mode under iommufd
Thread-Topic: [PATCH v7 5/6] vfio: Enable cdev noiommu mode under iommufd
Thread-Index: AQHc8xwbtoBXS/c5+UWiPzuLDFLPp7YsYJug
Date: Wed, 3 Jun 2026 06:38:56 +0000
Message-ID: <DM6PR11MB3690040824703648D2DC0FA98C132@DM6PR11MB3690.namprd11.prod.outlook.com>
References: <20260603054438.2450130-1-jacob.pan@linux.microsoft.com>
 <20260603054438.2450130-6-jacob.pan@linux.microsoft.com>
In-Reply-To: <20260603054438.2450130-6-jacob.pan@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR11MB3690:EE_|CH0PR11MB8167:EE_
x-ms-office365-filtering-correlation-id: 5b3d75b8-0a38-49c8-22d5-08dec13ac92f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|18002099003|11063799006|4143699003|22082099003|56012099006|38070700021|921020;
x-microsoft-antispam-message-info: U9f/jwT9Lm1nRTJVQ45ZALmpNK4+Z1si5dRAtbmFkKpcGvkpBozn4eO2CeMIp6OrHpWCppZ/Qz7ewQo03FwrvWnVIQNE/CyK/B7YxDgwOS+fbSms4pyI3Uvx6xQpaJlcBwRAyUr3B53uiYx+D9oqSp5syy6oYiy1Y8IzsFVBjwxFXPPQyu0Vel09ZZHh48haK7OqVRT4jfHligP/qx5mpc2zS+VsSdKpUEpr6zdMx5aiQbtPf0AOizPVLW8Z9T2GMZrQz53fJmxEz6Q4b6XGdO/yaZUCvvU+TYbi6XukfmtLnKPcfm0mO6Ker+UxvOee97/RXHm1+KfJCzaGefDhyokQyT4p+hduczKkPcpGhUpNWdUSLFGUeHiyZEoA+j0XaRKmhKUxZXzAvS8br1JAHFW3dGpuUFMPWMOM45x13mlxkbZetiIwV9vKq1bNZFb4H7p1RvZXW70HynXOnbm5drPOyejKqPi/uibg1OAbl7JEMKwoE3PBla4EDX49AnJd8DQqDR4ESCfDHThTqKE0ygosHwXYNqOrqXr51UMuq22kM/4PG0YPC392cCDUexdP2Uf4TbniDAdvWxBQ2DwvSJlkcabU02PPQ9DJrO4wGp71wum9FTQ023lMmVfwt4xed1JNdt6qTjChw88gb7f5haKRAUZxRPVLz+26hO6ZC0T0kIb8a88QZFcTqBKwFJItWH21NsP1X4WOkVC530jCzlmDd8Gbqjx1Tcg+h0Ww/0Cs771sK9XvDZ7FA5/Pi5g5pmTbYnmZyMrZJzk7vX753A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3690.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(18002099003)(11063799006)(4143699003)(22082099003)(56012099006)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HywpCsZWKIHYLaCChjxxbf6LHPLclU7r3/gnGP5nuWBr3beB+Njpi4u9R7B/?=
 =?us-ascii?Q?nsn5lD3/BLy4VRnd+SG0wiY0zsOH1QJ5RSKDoVSwjrFiGj4+qkdiBV8ya7W6?=
 =?us-ascii?Q?U5T2fueddYtP2gghBSsOesCUPmv+Ox/YlTkYd6Eyd//RzJvSGwwIyovbmmvt?=
 =?us-ascii?Q?vP/yNEZYFHXMKXLu3FMdJqvE6jN2y9QhhZAIY/OsAMtSDEuhQe6s2CDkyBn1?=
 =?us-ascii?Q?asZxo/aMJU2AS6GMFTZJTn1BMiJErlyAT9kzHKov4VEfOar6hNOjIVLUQNwB?=
 =?us-ascii?Q?lWFMOyWhvLyghRkt2cO5yIf+rWrcCJqpztWQWRSgJySRGJsFYVtYMs3O1a+L?=
 =?us-ascii?Q?yixNF38CvN5A9pvvViY3img8vtEa77amWWanKWRiV5v7RZ2WQijWMlPuFOgI?=
 =?us-ascii?Q?6Yjas58C8/1/kqENlGxq4UF0qOluBbusnnd49iCjdHboTDdu3+eewY3O7GVV?=
 =?us-ascii?Q?akHMlcFiw9waSr8NT/mtGt1vTkR/h1oPgiXmFR6Kx47ZbBhj3DuCeZlx6zG3?=
 =?us-ascii?Q?CaUVg8FtrakjZc0oWP6XY78REq3eOGh2B3UUy7ZH6+RxYJk16yQtY4hVN2gQ?=
 =?us-ascii?Q?A0+kmX20niQzqmeYqeZ6Lo89DafLwEHDRiZD9MW38Fp++fMBBEZT93cnspok?=
 =?us-ascii?Q?myl+vTFxfAOV9XjP2E9t5LN9cFjgAFXhIpVG/IG4JLPHt46XTU86HLfP0bEL?=
 =?us-ascii?Q?krfQpG71qM9L4/cQFe4hqR2LY6McmjFagwbi7ize4p900vxHMvW0iVBKDPXl?=
 =?us-ascii?Q?aunugRGdjs5WmXFwuW2dkIyT9gq/QeLaV6ZMKtyZL0ib7li+WbF1+tLB/cvK?=
 =?us-ascii?Q?0YQP1Ymdj85EPoWSOn/P4Nb2bfZpzC52auf+9iAGmKjPsRfsXi55Dw6We/S8?=
 =?us-ascii?Q?iJgduHwv0EOtRHAc9CUBizBK7wMqe74vtxg3hRfHjjrg5MHGPufq3orXk0hu?=
 =?us-ascii?Q?IIfsTaFSfNfFUo07lyq9MU7GGWmdTPRRqGTs2uXAI7BrYQTpa5OEOS3biDiG?=
 =?us-ascii?Q?1j38lMY3M/sNRDsDgQK0Hh+t3v01RAEo46Lgzty2XytAGzeHc+bvmOI9ct2H?=
 =?us-ascii?Q?XzrGFJawciHZPCTOFNVJvwt+Qguv6yXcIKlncgEu137DEHE9q5eyYfNFO5gY?=
 =?us-ascii?Q?HbPxyLORPWwYz6Ewp4LE2lFO+O2RDIlNPohLfQ21xV2btveZw5dSbxyhThd+?=
 =?us-ascii?Q?t8n8OwXRCMUjt+NdOfIB+D+Rs9DsJhApq9nZtWxT79qbfafAnLbdTZREhdXi?=
 =?us-ascii?Q?hSyd+0gSvpaTFCoFw6xOmOJAmMKqu/2hCMRuzWlZm1ER0UbVCir0yNewzNJh?=
 =?us-ascii?Q?JXl4oMIdcVZ7ZgfP26ieogszl5QVKSUiNmOroH/mWxWvFKVh5gJ7S6MTRgPY?=
 =?us-ascii?Q?tZNI8FFH81Olt7doYxjHZ/WhFuP5qWYE8dhncyo/V35A+93h8RNpUQtz4lPa?=
 =?us-ascii?Q?BdHNLQM6bKhd1koqjgs1dQnKvqpTRx91VcJ4KyijrJqkINIP04hZ0cSHQsdN?=
 =?us-ascii?Q?xhL/zBeNmJ9oUfxlNl7zyAkl+hASMSuzU+e+DEz+RBEwMJIseCqSzCnISGuU?=
 =?us-ascii?Q?UgdVVMeEJTmpHeV54cZDUG/1dOqMRxSlAyQ44LLlnYZDQXwel0tfNf5o9BnA?=
 =?us-ascii?Q?i7dk74Q+DWk916JHhAUlMBigyz1bMxMEXktidq/Tqik9FzKSiKjgjZiIT0Nt?=
 =?us-ascii?Q?CZ5rKjFX+Cxcj294+3vSIz7jsB2f4Zt1m+bG0za+YB7zZXRbtFFfaTorTPA7?=
 =?us-ascii?Q?8cyyvqj59A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: GhAcXZ4re4Znn1rjz0NC8DYEpkZ12+wRNL1Vho9WR4CKfUNp4wI2KnhKHcxtNbnGWNOWEzts/Th1/ipK4NHGM4gUsL1HHdohUT/LecGLz92kdPfCFFvroqid5bmcXtCSKnNKqer2j+xnliMmvM0lh8sxtujxUqVNvGW5SHv26qE1OGoJiMbbknnBNv5qx5QR0ZSZgOFRKxrPZocnmeEPioWTir7j6AxSz3QA38b0ssPrguvZQTdmr/ZyguBp1kkrjPSkp/2Qkz6sJ1EMSVl4mNjzhNfQUo5+Jcb3LiXf41Hgv5NNvX5WSPpIAo2EGVJos9LlTFtDRM8Vxan8e32y5g==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3690.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b3d75b8-0a38-49c8-22d5-08dec13ac92f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2026 06:38:56.0740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ofeA7D3vbIEEm8X2agCg2zHp7mE3tI9aOjr6l0sSQvn+FasJ4/+b1bBt+vQ0/Lc/8zbJ8App1BL8esriq51iJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8167
X-OriginatorOrg: intel.com

> From: Jacob Pan <jacob.pan@linux.microsoft.com>
> Sent: Wednesday, June 3, 2026 1:45 PM
>=20
>=20
> +	if (vfio_device_is_noiommu(device) &&
> IS_ENABLED(CONFIG_IOMMUFD_NOIOMMU)) {
> +		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> +		dev_warn(device->dev,
> +			 "Adding kernel taint for vfio-noiommu cdev on
> device\n");
> +	}
> +

what is "vfio-noiommu cdev on device"? just remove 'on device'?

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
