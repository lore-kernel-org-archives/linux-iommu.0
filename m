Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F0822D9E3
	for <iommu@lists.linux.dev>; Thu, 10 Jul 2025 08:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752135040; cv=fail; b=SG/9OzKvTbramEWUcxFs1h+xo0dcEbz70rWfUSBFZwnOzwpGP+bGqfDkrzHMFyLEAAdZd5BCqD7sKzOJuuNFgh2pLPOwTfRAhBQsYFTKQbQLCt+657UKjzrRgh+d8pM9QZx6q3L5nUYGCJUxz/h0K6jCbazxxfaIzHt+MI62zT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752135040; c=relaxed/simple;
	bh=CfewKNn9Cnm6DFdW53B8IZd9MkCa8qXYsdNIwkm7+J0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SOqpRelZV9JtgQSYfIvCIf1rjdqsgauDGsMw6UmXgjXMg/tABqNijh9s4CuJUkN+84q9m5Mx3yKzdhz7UlJxtCAKCUo7nvxc9YC3bEMhW0tNhuu69LGrJlnFh1bKLJ3kyF/RCT/Z4v4opktMVktTa9hBA4jkoH4ardws93Vxpl4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPa3EAiC; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPa3EAiC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752135038; x=1783671038;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CfewKNn9Cnm6DFdW53B8IZd9MkCa8qXYsdNIwkm7+J0=;
  b=hPa3EAiC1ibMVMZf/+5+sEomLId5mPdSvRvSWHN28yXLqWBVfcENVatx
   o7YH7oTWZ8vNt4DhcnbTl5cU3Ptn11QZri/I4GaJR/tCv+GsvxMOR+n+I
   3x/R3QkqPcN+byyvgH5jJXS0GkBBG3yCQfReY7laGpJ4mfDP3eswjnuvJ
   9Eq8qe9rUoOm/Ou8dBaxAig4EdlHyGHwEH2Nq+lRzypYoG5+zzURzt1PK
   9RepIEfJbdivUOnSFGpoltN1xQ3bvq0nrVyufxGkRf5UC5eqAYuQB+mmV
   Mi3uIpsBXt+VnO9c4vhIybflQa486YKUXeWZJsi2HtZKq0tUbws21FQUG
   Q==;
X-CSE-ConnectionGUID: Ip9H75XCRd6pG8ljH26tYg==
X-CSE-MsgGUID: mB0t7tUpSBuldqnH61GLVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="71993275"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="71993275"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:10:38 -0700
X-CSE-ConnectionGUID: zLeIrGJ5RyK1529M4jjkjQ==
X-CSE-MsgGUID: Y0+yQ5I7RpK9OVEBM+MlSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="156560869"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 01:10:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:10:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 10 Jul 2025 01:10:36 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (40.107.244.67)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 10 Jul 2025 01:10:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z9351gJtTtORsk5xj0zhr9CCzW6lKrtVpJ1YI2qrkdl20QLGhXZOwKdIkzBzbcab+vavBfbPG1FJpZCCWdoirkrgR5FVpLpd31c6JF/Lqcvu9Op1rp/A2m7sc76loMQvE6hSiX4gmn0kPc+0jull4H9VpLB3hRhsOvmrck4+RMeNd6DmO2dsLztxjLYm0c85zQQ0EiKRY+tAo+/QsX12ObilqIE0Bg7T9gBL24VE41gVFo+B3k3tvCUGb3MtIt5zHwCXsd7rimm96P6gn85Txq+up7dNbIRd1X1b8nmoDvE5Va/4oSqMb27Awrch4FWT7Fn0EdwFqfJxWCX0oqn+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fa5DPCtYvuHAVTsq6vWlBTbkr5jCzQ+0MQwx1BDE3Bs=;
 b=e3gkKGvwAxJw9rIeJNVYstVKgOujAmUTEo7hOituaWKIQCuHy9Wf/BliLYFZ3Cm2GW83Ox/Qvja+BkQrj5vZyUS2D4tBZ4HH474uWHOBngEuxUMaReHHRZZf5aANWHl4TgLOUNhmzDXoz0AssAxcXanATc6MHxRm8tYmtjnhSpJe7qSFjY5E0TpdbOCrK0s3HCFk72QaMBQAaHV4p+ckgLtZieSRyyujvUceOnCrRVza2dwne3/aYI+J3oKLZlxLtvL/mTdp7vm6b/FpN/qfTjbVaygXFXeZAPVmQwXFNJ3Ygz8C8ycb3gWxnGVpaJugs9dxQuS1EatouyjFo0hdGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by PH0PR11MB5141.namprd11.prod.outlook.com (2603:10b6:510:3c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Thu, 10 Jul
 2025 08:10:35 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8901.024; Thu, 10 Jul 2025
 08:10:34 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, "will@kernel.org" <will@kernel.org>,
	"aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "shuah@kernel.org" <shuah@kernel.org>,
	"nicolinc@nvidia.com" <nicolinc@nvidia.com>, "aik@amd.com" <aik@amd.com>,
	"Williams, Dan J" <dan.j.williams@intel.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>, "Xu, Yilun" <yilun.xu@intel.com>
Subject: RE: [PATCH v4 7/7] iommufd/selftest: Add coverage for vdevice
 tombstone
Thread-Topic: [PATCH v4 7/7] iommufd/selftest: Add coverage for vdevice
 tombstone
Thread-Index: AQHb8IeMjjiKawlT60e3cJBUAJDZtLQrAvDA
Date: Thu, 10 Jul 2025 08:10:34 +0000
Message-ID: <BN9PR11MB52764B86489423F69AF617B88C48A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-8-yilun.xu@linux.intel.com>
In-Reply-To: <20250709040234.1773573-8-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|PH0PR11MB5141:EE_
x-ms-office365-filtering-correlation-id: ea606702-b9fc-4c64-fe84-08ddbf893f2e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?NNHdtpjkiR1i3mz1LVnL1RQUF4JSMtu3crvTqKU9oqF6F7C4y0RIcweRfBVh?=
 =?us-ascii?Q?441Sc2ZCxBy5EFRPtxqRTLB88Oc8JOxc+XZ6266i+dv+IxuvdAhYg9x6wPxC?=
 =?us-ascii?Q?21qnZo5gNXEl2KFXRhxWxwwULEPVAAPJNKfUJNcbfRE4aAbCw2psP2dHv3hD?=
 =?us-ascii?Q?bJ6nI/lhwcHz0I2oMLSgqr7zC6486skoZkLo+A4ZgITZleW+dwjRT0pv0jRv?=
 =?us-ascii?Q?raINUaFeBpYf25kCKBpwXILtoAqB4bhQWottCwOV44py7AuLa3JCG1DX7uyB?=
 =?us-ascii?Q?GVI22Nr1t/TNuQZpp4Kz7vxWUyiErQQYO5HOCuKnd/TM9FFJhECJUd0MzwxW?=
 =?us-ascii?Q?pcoNNv1RNG5eVj921tUiBkEdZGmJOG8F9/5k5J4+lLPlYfpmV6cgQpgFGQpJ?=
 =?us-ascii?Q?02F2zpveSvxrrt+FKkRcbcLaFQKV4IVZ+fOA/lempZe69PbCbm2xfk34F4Y2?=
 =?us-ascii?Q?HmdkpHqliEfi1cFYCcpbC8Pl2ZzSrImMVym4CxOgoe9BtgvEAdYoab+9OpWD?=
 =?us-ascii?Q?9+6yRsbJjBx3TNClziyV20mp2rdPsq1UpKPQR6TSy03auH533eZ/lKLJafYZ?=
 =?us-ascii?Q?ftVj1uPgyXQIES8bdGtiM/gYKDxayF/Ze0nYdri2iA/ZHrzQ8kkMjwOreejK?=
 =?us-ascii?Q?3+QOE3OPMEzUMHDPYBt2ybnfp85zfsBDZaJD4+70a+7eOLJOSgex1FuYKwTY?=
 =?us-ascii?Q?hMNHJlSCz0RasyRNgeDknuC3Dp8fKLNfb1l8FMvljya8J7gWMI24Rf5NAYVB?=
 =?us-ascii?Q?yvIkyTIffNDzK48obmL9CxwbtaG5iQRgP36SMWAlBD0hTCI0S8Ra4ZrWc9/h?=
 =?us-ascii?Q?MLh+xbFORs3fSKTVR8a78hVxZNtN26ECoAtNv4bVhrgg6JUGyNsMkkhkApP/?=
 =?us-ascii?Q?X4tzu4gZjyLfS5vm7IYKx60AnOEKOBbmSX/J/sPrAGTZJCr16JqgHbxKqlcu?=
 =?us-ascii?Q?UGqyaA4HwXJYhjO04lp8OxsL7OZ66Wc9rBn4cWXJg5Uq8sHzBSmuzzU1pCxl?=
 =?us-ascii?Q?PhDTJxiZrEVSs+QoY+p0uJojyiqBnPnWUjqCj7IGLkcMuuUy/BIYG6UiGqZj?=
 =?us-ascii?Q?kCPMYrEB7uR+ejcrASXadaRNfwAUU2QLzCHdPZpf1brFFqY1k1N+xiLmPyzs?=
 =?us-ascii?Q?Q7LfxBA771iAUuKcsB70YJO6ZZHWpuw4qx3/GGv5NQDtOuCwOjYevas+T5PR?=
 =?us-ascii?Q?ZS+wiiN+Jow3TKqo7izXKhEnxpjrOJtslYBGBALEaW7P3VLvBroUCn28jG92?=
 =?us-ascii?Q?0VLSossa9AZBKAev0I4rra93z5IIqgLwdOHE4/vcwTRbWAoygTfsACmbZ0ts?=
 =?us-ascii?Q?6CxWO0SXKNvmlKSCngss5i9mIaMFkPZweEF6hIlKltTuNv1Rv1T1Z2j3eGp+?=
 =?us-ascii?Q?cjfKCofacHn7cNZWgVJYcPi4FV2CLW9IDhOnZCIcv+FN9RC/wRrLdosJPPvy?=
 =?us-ascii?Q?7GrHZB5XAiSBECOJOaLb3gpKDyfSSMJKoipEfWPAQHll+w09uwEQ9wNq/I7b?=
 =?us-ascii?Q?IPJay+iGxw3u1dE=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8YrbGAMA/r49uMbtzzQglEP6AgZFlSdxZ5w0lxPsqrhpnJN0FKRYEqhkPKDL?=
 =?us-ascii?Q?YsiJpVwNIOIIuBLa4NbX5g7yHILcraN2MIPbTPrZQ4frwdYtsGLxMcF+ehcW?=
 =?us-ascii?Q?RCI+zNU6g8mlwB4UqKjCzzOvL7Cfur3vubzRzLLxcCBdHUzzANIqwWFrpE4X?=
 =?us-ascii?Q?BbA+2pdkpT1BYjRMALM2nuXusAltM4r3IT3IiWyHhhj9+OS/SRC10gKYHXF3?=
 =?us-ascii?Q?CuSEOIlNMJO7cgB1zU08ZTfCu6I+A2wjzuEdOeI/9XnE1+kJei8W9R7yLOeH?=
 =?us-ascii?Q?XxwFq0Red7szSsCzkqsk+vsNaKrv9mTruHONgHsf5PTj1YnWxQ25Ytro1RC5?=
 =?us-ascii?Q?5z+8ml1yVCZmTOpm+3Bre55P8pVqHhSP8tgC74Gi+KXld9xc1fHdr7NZ5EEg?=
 =?us-ascii?Q?f+YUDNfqMn4KEnTWHg5eTewQH/BkFLW7sMufzmzIdqTFDkZaDS0BiPy8B53F?=
 =?us-ascii?Q?oytA3UnKN8PYpJcVvX/006etkaMXBKmP77hjjLBb4cWZYxK6NAMfPK7LOdT7?=
 =?us-ascii?Q?LfnDgSUbWumuUnjzjCT5LEXfEjIeYmBhSkQXFlMNqdyMGc0ApCOFSnkJ78a6?=
 =?us-ascii?Q?CpmwicuA00qwR5QLyte8oCVlOZMpwpSgIWG0eUrW21txegFd6vjpc4mNiV9u?=
 =?us-ascii?Q?m5IVNdBvNrSMPMJuWhtMlavHzIe2xHqpcMFJF85cAVD/BzaKCIxo6uN6iyjJ?=
 =?us-ascii?Q?EtukUcnFQvfx3UjJuV+Et36pHlgXHy7+wowV55/yewdQZiWSg6S6tEB/rGsD?=
 =?us-ascii?Q?FCmspx2lv8ocnaBZwdzJlxsyPHCs/OQ8zjEX6pEbKNCyMn5qfnn65XCpIVz9?=
 =?us-ascii?Q?q0Y9CJ0mouZtGpvarA+Lky0LOOY9pRkiQyjNlPau3mIvSftMeeMynTiFW2h+?=
 =?us-ascii?Q?hAOvZN1eVK7IhfLxjERhA4w7tg9XkmVFAo1M7lHsoKFEM7tpddw0zvJztIXi?=
 =?us-ascii?Q?KSiIKqgSMxKLfbUrQQy6qwLfcmTcNJIMH+MlN6EKJfiXBoJtx/85+kfLgvfp?=
 =?us-ascii?Q?j8qkTIoxWJJy5hnnFiEt53uF8AI8X4n6Us8O2CafatNarRp00H9joG5nefyA?=
 =?us-ascii?Q?TqZtJitOr7oopaEjgAHQl0Qu4rO/4HEiulaC15/GWPqZfTnj8d3PiyBY6PQv?=
 =?us-ascii?Q?zGaecaZ5/ZvtVObR0vqOnkmMmmKalsTSXVqQfixvBCl5qCheZ2DO2Pm/Y1dd?=
 =?us-ascii?Q?uX1vzYqJ3eGFbxSuacVIgebLtLOqiQt5nj1hRr34ioc8e/1TAOaJghFgtnwc?=
 =?us-ascii?Q?BmDEVIzkIJzrmoJp2cXB7uy1PEEHA10aiNv+VTAwI/uK024BKuLlShwtpEAW?=
 =?us-ascii?Q?6QxEkpZfJVBeqXeLWW5ZapLiG2QOzkai9jkMoUMADc+a6MelteTVok1mWwAd?=
 =?us-ascii?Q?mFj31YMR9fWaFc7tv2lqjSnRTDAE70wg2AB0OPSiVfRJ5rK4u9Gfykz467b1?=
 =?us-ascii?Q?D6RUw2oC+6pk6LyInhACX7wuDkJ22cDuO2FJ8UVAGKdLJR1b0wjQXXFbUDPo?=
 =?us-ascii?Q?t6oMNNUhLVCBB85ReC+YYeHDHXmyaO4K8OcWSkbjv10TfQoeriQ6/lXQTW3g?=
 =?us-ascii?Q?YBx2Rh0P/qeNsbARxyKYsgTs/qXuv6YGurEol9y1?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ea606702-b9fc-4c64-fe84-08ddbf893f2e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2025 08:10:34.7829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nLv6ctK1pWrvj4R5tX+/CmJT/86WjcU2mvNxIieMBxknR1xaoe41cKQSw6GsPMgeMrXRlPU6VSCgx3T2A6of+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5141
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Wednesday, July 9, 2025 12:03 PM
>=20
> This tests the flow to tombstone vdevice when idevice is to be unbound
> before vdevice destruction. The expected result is:
>=20
>  - idevice unbinding tombstones vdevice ID, the ID can't be repurposed
>    anymore.
>  - Even ioctl(IOMMU_DESTROY) can't free the tombstoned ID.
>  - iommufd_fops_release() can still free everything.

but the test only checks 2) instead of all?
