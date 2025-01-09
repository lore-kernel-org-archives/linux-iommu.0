Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1560021507C
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 07:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409234; cv=fail; b=NaRd8kn+ktXDT+nBDk+w28+mM1O2QXnS4KPV8L38qlqjB4dAW36/g6Z6WzKwgH89wWpK8lvtn+KQC/r9DDpyLT3iSxhfKBRWQ8H+cQkF276oVi16fVVNVquzgw9ntR/s86V00HvxG1rDPQPBn17O0Srt/TjOv0+Ap74LSe4PROk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409234; c=relaxed/simple;
	bh=nyObatu5XD8/sWbky3M8umck3m5zA5j+OXnIhGiEVX8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QqNV5YEDGNu1ofh6mvyr61XZpSuhN+KGSwGn0U33gJRsli4u+1rsksP1tGSjQLoxF2WrvgGEmevcn4rHn79FvrGfOTdsRAwMsJy+u8s48iDed4uEx/HF8vQgzpQqTSIjbc3GEcHpeul+TGz49ON/enuYzAUEIx2RjNRjg/qglOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mejBGUZ3; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mejBGUZ3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736409232; x=1767945232;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nyObatu5XD8/sWbky3M8umck3m5zA5j+OXnIhGiEVX8=;
  b=mejBGUZ3gKJUM8QlrsBSQ4lIKhxnpDop+SWmQltyPy/pGRmLNdkb0wqi
   WVKe1Vy/PiV5XVld4mrNJ47a8FkrvGwfuJh8yuBYX9ojNVVNgv4RcUi+V
   uJiycYc6CwfXPyxI4oQ1HeZ+5CEW8mhWHcs/3t480PijZXLSjsH6dWgTR
   pXx/2Qc8crHHHhaNYYnvPuTY4lWsN/DDoYEcu/6DD4BOS4m43Pg0n6073
   BkFb5l82lDjT4dLEcu8wej6fkoCbq4GQdPrhHHZOJ3gn7BH7UeNPcN8Ej
   xUFJuuvlb82abNT9NX6ihssqpBhBs1Uwd2xfqoYyAiLJyEZtNWjX0TdX2
   Q==;
X-CSE-ConnectionGUID: /jBnHw2LS+Kx0KdllPCDYA==
X-CSE-MsgGUID: oQ9bFHFxS+O5rXDaze0lNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11309"; a="47154678"
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="47154678"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 23:53:51 -0800
X-CSE-ConnectionGUID: OUrowx19TV63Qc6G2luVig==
X-CSE-MsgGUID: YI35bv6yQqe6AbZyuLtSgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,300,1728975600"; 
   d="scan'208";a="103138459"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Jan 2025 23:53:51 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 8 Jan 2025 23:53:51 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 8 Jan 2025 23:53:51 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 8 Jan 2025 23:53:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rM+PFWYqJU+UeE9NB2Yl0oBztdp2Yfpi0DIeEGK9hlshvJ6xRqSPL9xkyfg1G0P8XLtqViBkgB5AQ2cqv3WZfQuRvqLsK9890ZzRlc8JQ/Ie64spEM5WIonypzp5y2hseJbySGItGNUb4KUyeCSm6xY8ejqAkf8lMyALI0TmZ/l7YWBj0YrEawmOx0KDAJ2GXF69qxa1wxgekVcXjTnkwxsoT2h0IiW5l3pCKfaqtvGnI3K6MDjanL4d7YAvyGWeLzwf2NXJiQtO5xUMCYW4uc53dEIVSrMOuqHK8+cuS5Ik45SZS52vnSOqOtMCMhATeDzvzpUArHbYteXdOH12kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i5vMI49sYNk6gJvJJiBNbCaCnqOcbixPBz00aUoPyx8=;
 b=r8iVsJjwFflQONtXSNVfAnn99r+OdHvh7sDtbjDkvRTBtSisS6g7RjzEdPU1dLzlQgqhDLeJoemfnlthmEyPBw5IZv7GrFnqA9FJ9YSK1bsQuiLGSXXAJ6SngMSBpDgd8jb2PBFGGfimInaCpNXYWWuVfs5CZcC0+fDqthiHC8S8GUKR3k169z8ozbVMDxkhJs1iIlwPK41i6GfJcDFYOht/SUsjnwRvztVc1IRjNCYHHYl0C/26vcTxfCk9fJGjWvBPD3ExDpORTsK5VxhEO24vdzDq6LZ4toBlUdtVZKtbKk21XBbMJkgLuA3J8P9xzlax2wyj1HU0+Zgs4kd6mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA2PR11MB5003.namprd11.prod.outlook.com (2603:10b6:806:11e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 07:53:03 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%7]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 07:53:03 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"jgg@nvidia.com" <jgg@nvidia.com>, "baolu.lu@linux.intel.com"
	<baolu.lu@linux.intel.com>
CC: "eric.auger@redhat.com" <eric.auger@redhat.com>, "nicolinc@nvidia.com"
	<nicolinc@nvidia.com>, "chao.p.peng@linux.intel.com"
	<chao.p.peng@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "vasant.hegde@amd.com" <vasant.hegde@amd.com>,
	"will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v6 05/14] iommufd: Pass pasid through the device
 attach/replace path
Thread-Topic: [PATCH v6 05/14] iommufd: Pass pasid through the device
 attach/replace path
Thread-Index: AQHbUhnWrHEFSWhHgkCuA3x/XPSChbMOMeAQ
Date: Thu, 9 Jan 2025 07:53:03 +0000
Message-ID: <BN9PR11MB52767D0A44E2F75F1641ADF68C132@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20241219132746.16193-1-yi.l.liu@intel.com>
 <20241219132746.16193-6-yi.l.liu@intel.com>
In-Reply-To: <20241219132746.16193-6-yi.l.liu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA2PR11MB5003:EE_
x-ms-office365-filtering-correlation-id: 0b8529bb-6614-4a80-983e-08dd3082a53f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?0zQ5GLtBKPslI4bHzDmx9+LpD0MVkY5CaBGAv4ALLxQ0vp2lq1MJnCHmFxRD?=
 =?us-ascii?Q?pFYo749WUdmamYUXCOvXlTgNC//iyN+e3xuQEq90pYtuZX9+cQogdA9czauL?=
 =?us-ascii?Q?Y2wlsmp8Ozu/wvYFke+/Mm103FAp8Q87vHuIgW3wp+AMj/dvimc5NRBkymyL?=
 =?us-ascii?Q?W4kvD+mM78u5loh4THtW84nxuJWiY5X5MXtM2FmkeLZ0dp/azlpzbAVBEomL?=
 =?us-ascii?Q?wQ6EnE/2el1vH5vVaQxte2wJqt+Nj3TMh5HXtZy/F8kM8faMwFBEPTpwBovN?=
 =?us-ascii?Q?JVculMXpHAc3jpODEHmJDcC2BD1Jg4lyHAMIjLJEHKjucJtwfgwnmAkkz888?=
 =?us-ascii?Q?9onBEgEsf9oWheGXtcAUUrecRqB798OJqGe3aUnV0IH8Q3RGuDzN8IDdYaS1?=
 =?us-ascii?Q?RaKLmpffqdEzZbztnxaPeruKmVW1jXGWcXlFYI/SohYS/YG+XrwNEAm0LDSw?=
 =?us-ascii?Q?eBGv6n7lnGkA35FGznHE3i1ZSJNEhYeuCDTUZV3/a6LylLLC8jb5O+kHk+my?=
 =?us-ascii?Q?yqCWXQn4RxsOIvqcjQ3UFxGIS/IYZW0kbjBZlEwInyFomsq8AFbmBgqiSKVX?=
 =?us-ascii?Q?RU6uTxez87hbwi649PCkyDl8WsCrX+GLPGlndOc1r0CqWghSLFRWaGz1I4IK?=
 =?us-ascii?Q?G/uqnxcWKDTA6uJtsV+MQU9YevT76fAsPIza/lyy8uaFbe01nq3i2WWzYZ6I?=
 =?us-ascii?Q?svlbhfpYAHATGAWtG6iyzM1ZXmBqkFId2A993xhiKiObJI6PCLYYWmjOibac?=
 =?us-ascii?Q?mjTKSSmo3ORqhDAXUwuiEaKfljq7SpT7CONXjKS5/UJNAShAklkXOPTEWATB?=
 =?us-ascii?Q?JYJjf1aGVIQGe8qpZncVU42gqC3sXTRt0XLdpFz9EjXZDZioelG99YK1nRV1?=
 =?us-ascii?Q?btbhq0k1LReKLRT602OpUY4TcbkRj8DwI7wBTSJHTRiOmPiLpT9LtckpUtWf?=
 =?us-ascii?Q?XuUJfiE3n5BH0Nvs+iJKZokIl2mR0iCalcaMXtNgs1zD1pO43uylQkWY+0BM?=
 =?us-ascii?Q?PCfNdHoAe5jK3U1193yWNZthRF2XOvMccbR7Y+VI4mzvAJ5X+8gEDSGJ8/1a?=
 =?us-ascii?Q?DVXOqee2rENHadcvMQDRoVpwJ8taPzXP1qe9oCLV69ugY/dsCK3qB1dl9CE/?=
 =?us-ascii?Q?ORCKXXizhQ2kYaew20gvPlVPqfA7CIrsR60s8/lBIkNXzgOsAfY0WTuUrlj2?=
 =?us-ascii?Q?kGXGfw+FHRcbohcnqZYlWgwKCO5zSKRp0Nz4IWBhXR+RCnHCyOf/6f5wcEfW?=
 =?us-ascii?Q?TzYU64n76EDN6ya9xoTWCVJSxlGVuJCLwvFBFpfMhUQfQB/4NIae84ORb5rN?=
 =?us-ascii?Q?G/nLYQyPxkCkGEU83yRU4w6aNvrK53J9WaBZ/iUNSB+PguPgZfpJwO6/FhC3?=
 =?us-ascii?Q?vxWcND9/3RJzRaE50ZtRWWqWmJlrb1SPHL4eTCizO6Vvbg2RjhETQGlbJCrk?=
 =?us-ascii?Q?q2ZSNK6D7NHEci2/3EcxoZ0T4Qy3nXxF?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YQMOSwykuhlQ4sa7K+oFCnH+QXIw0rqXtyFknzJbp12wTXaK0eUm5AqTxq0Q?=
 =?us-ascii?Q?rK3U/LyOIvQXSaYD8mL+/hy05V1aDwaOAb8QwYTeJswP4pH/r9VJ7o86MZFD?=
 =?us-ascii?Q?v3Q4SeA6sEMItWlO0OLKHwoYiRwyO4bk0XwgZFfPs32zF91yhGpNFfeh9XXB?=
 =?us-ascii?Q?6JikxBIFhhpl8ME/VlmLlU77INHDg2ViNPVQTPig7EYfAlEwRGu71WPvNqPe?=
 =?us-ascii?Q?Y6LvaCeNchdVJH873ywj/EzAv3vtWZFEV6QmWDmC6H6QabcpcPdWIA09V9yI?=
 =?us-ascii?Q?mzQT6kt7xacTSeOJeRbkZxncE13KFoYrkWBs4ASw37zDF/egdIAYEZ1NzOVw?=
 =?us-ascii?Q?+9y6tOiybznojOyK7z/FNBCfLAhej1hSUpoShYLfrc7Dp+cE+7bmdAmGW7Hm?=
 =?us-ascii?Q?XwRZFkSAT8CQ7bZpaWwWuTzYDvjqAUIiYCD977LiNRF2eMW3z7UX4P2IjqCS?=
 =?us-ascii?Q?xSEmFzzWTMcL8VfozqTlFZhIDxHY7rRdmyLTs1F30cbw525ZZfd1/orwebN9?=
 =?us-ascii?Q?TfsT6Man8Fsm6rRVvegF3oMUDzANjGe260QE+TyPf8vCt7VP0XLQ5NnNla2z?=
 =?us-ascii?Q?Ehb7syL0fOYbO/p4RI2hvpEr+KgoAEbWfmrY5tb5eJzzsQqq7cYn5LVOKl9M?=
 =?us-ascii?Q?7rzPvySsZ1Sb05lq9j57W5wAea/ZMjvhNxQrh8voW8OM3gM/lY2WCbkRewtf?=
 =?us-ascii?Q?rlxDQA7UR/XSrfPdJw+dQGsWozqR3GU2koSYEFpL0OFWjO0XeQSVHgxWr42G?=
 =?us-ascii?Q?0CZR9WXz8i41BlXuxo8yMFayUpYKOUKQgQnf1+1fCGKggGSPaMT2jf2VhA3R?=
 =?us-ascii?Q?W8t0VQprUAphCSuuMzRPdKbjmCH0UcfrmbFWSXNSIAl6TyUhUnzaY8i6+xN2?=
 =?us-ascii?Q?Q33j5sqlaX3TUx5OlZkwM3jBBbz8QA3ZpuFTBn2E118Niyo6rhwwnaJmrvo1?=
 =?us-ascii?Q?Ri+HXtXBNWFS5BQMyTc0iYxUxBDnS+BpDEcHanYfniWA0gpNA7SqkQT4QjJn?=
 =?us-ascii?Q?AuzgV/Kr1sMj6+46DgD/gjBH0FbFFEC5abvA6BYMidlg6+fv+lShBCDlYm8X?=
 =?us-ascii?Q?7V1i1CxoUfndnsXytso4h3YeMhxu9DwXYSxWNw2uKEcBnIOsave7/h/ab8RC?=
 =?us-ascii?Q?MzKfdM+m4SaOOG9fos3RFEFdkcxq3GadzaKTU1Q/0K4rl6kw5HJXDlrNeAGK?=
 =?us-ascii?Q?7aY9/QH0X9yPjWo5sjsXGOqibZUyT93vNyh2ZslK8BMg+NrDrLuQtua1qGmd?=
 =?us-ascii?Q?xx+ZItJqEyuWxrcTsqoSRpABRy3C4+tpPLGYaE0SI99BS+BRbgn51G3+8FYs?=
 =?us-ascii?Q?kLEQdMSoLNCW5IL/KMOAeVt41gCg/2nQrHtn5bNRMJKstlfdkM/QZJVTw+qx?=
 =?us-ascii?Q?/5TDV0P3gLrmUkryv0b9onoXno19DQ6M4k67hr6IHRwVwPn8+THNh/Yt5926?=
 =?us-ascii?Q?qNHjqEG3auY1L8gQTEm7pGQA/13cQZ3CllA4//pMu7WGuf5hsVZLPCobwa9h?=
 =?us-ascii?Q?st+v2P5fHDb1R328rVgRrAESKE8gyoE0YBCTrmgZEbRbkE8bK/JpQCfvj7H8?=
 =?us-ascii?Q?oi0GsyyCzVm0EBrvwX/jxHKwaCQrnyeBkpL6aaTF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8529bb-6614-4a80-983e-08dd3082a53f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2025 07:53:03.2164
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 52Rgsylk+7VuaSyQxCHp6r/lzj94mH+7Ged3HkEXThe4u0lD7b+rMDea0wJMSwUP2eEmAxxab3PXDO0vCT9ZJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5003
X-OriginatorOrg: intel.com

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Thursday, December 19, 2024 9:28 PM
>  void iommufd_fault_domain_detach_dev(struct iommufd_hw_pagetable
> *hwpt,
> -				     struct iommufd_device *idev)
> +				     struct iommufd_device *idev,
> +				     ioasid_t pasid)
>  {
>  	struct iommufd_attach_handle *handle;
>=20
> -	handle =3D iommufd_device_get_attach_handle(idev);
> +	handle =3D iommufd_device_get_attach_handle(idev, pasid);
> +	WARN_ON(pasid !=3D IOMMU_NO_PASID);

Nit: usually we warn before using it, though this will soon be deleted by f=
ollowing patch.

> @@ -184,7 +184,8 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx
> *ictx, struct iommufd_ioas *ioas,
>  	 * sequence. Once those drivers are fixed this should be removed.
>  	 */
>  	if (immediate_attach) {
> -		rc =3D iommufd_hw_pagetable_attach(hwpt, idev);
> +		/* Sinc this is just a trick, so passing IOMMU_NO_PASID is
> enough */
> +		rc =3D iommufd_hw_pagetable_attach(hwpt, idev,
> IOMMU_NO_PASID);

Not sure this comment helps. The ALLOC uAPI is defined against a device, no=
t
device+pasid. So it's implied to use IOMMU_NO_PASID. The said trick doesn't
matter here.

While at it, @Jason, is immediate_attach still required now?
