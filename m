Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC332571DD
	for <iommu@lists.linux.dev>; Tue, 24 Jun 2025 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753338; cv=fail; b=CrNmZM3nmTo4sESuRl45eEzPQdTdESaYXYx618HN5eXUrOMN6YYGsokGfsi20IgeMJTe9ADeVfe6A7ixTcK3TWNANJZ1I+AuQ7JqrNCIDxLCb1gHXV5bzNH22Z9QPQD7Hhd7p4YWiKVYER1+jhr5WkZk+KlTBP73vy+rGN9CCBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753338; c=relaxed/simple;
	bh=qIyHm3gJIJXrRW+sal36/6teGgY0cu9CKrX8AnXOT6s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XjszyWvjasFBKxaL3Nps83oTN+3dAdamOBTQovkfK6h+nCbGNjJuhWgKQWMjQPqrpI8iKdkWEhBBrDkOL1zEE9PzBDr00VJuKgCs/sEQURJqRfA2nALaBsk/ykAs67SwGGLGViYwUWvbQqVlJvGGJ6EHhriL7KvBR9YhYTo7qcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=flRjBOV2; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="flRjBOV2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750753336; x=1782289336;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qIyHm3gJIJXrRW+sal36/6teGgY0cu9CKrX8AnXOT6s=;
  b=flRjBOV2P1qN7+ljIg6vMp3Jv8IUj52woE3o4Z5EyQYrHMkwuszNH4GC
   fvT+M6AkdQGtpY6M2LFA611P0AcqQ0P4M1hNoCL1jVmK7Hpwxb2pPZpF8
   nr6KeqGcEVSoGKKu9XYEnbruY5CYThXL47VZhGzWCUiwahTKA1RwDQcbP
   lpzoEhoEDibeUjsVnKxlbNxqaGtTZ/iAuRoFhpLytMBSWgx1x0VAVv3Rn
   RagJF+9QrVRjzZbKoZdWEIWNmolYrC6LPbetWTf3p1phJ7abWc9TJDX9y
   L/v9K76nMq39sCaCnoRzMn3m6bE8njZ3NWMx1QTXuxqKyGpJhinsDank5
   g==;
X-CSE-ConnectionGUID: oU+25a/xR7GG9AlQN0D/gw==
X-CSE-MsgGUID: 1efQT5rJRbO/NxxGfQpahw==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="56787614"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="56787614"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:22:15 -0700
X-CSE-ConnectionGUID: ISmDrx1aRgCzI2AVQ5SJ2g==
X-CSE-MsgGUID: lIFAnbKhSguU8aPOB1arbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="189047515"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 01:22:16 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 01:22:14 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 24 Jun 2025 01:22:14 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.89)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 24 Jun 2025 01:22:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqMJYENkaakqYNG7DXLxrLVvTGZ3QRFvKq9SVT/QfynRhGwP+vwFk8ah+PjWd/CaqjycfSU3azPqXBnpDfa4eir8jPSKJ4bOjOafddB8NKeSoHUt2rSGDl+Hzq8zprINvWTwYjsNAJxt7dRWiDnyGLXhilN2bjRBP2w/QU6NdUUHBglcErDknOKM4CWedASRZXHgfGjHR7ubD2Rak//DSga57bxLOdjMYpLfGXu71+snKqyruJr1ZR1BGH8Daf9PUpso5gmgQwNFB8VRabG4jP3lXd1aWg0dpJ+dm/qbCPE8g2adff/7LFmquf6SI1n0czEZfAfjpZmr8fqs/MMz1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BX6uStjGZbnWI/srIfRKWE2GgzoOsI0HEWpNIgX7sxE=;
 b=r7FxX9jVuv8qHn0PlL9vac/Y130vdlZfAhTcAmYz8qHvQoBq/EiUcQB8FoHDt49XqRywUc7WvJjoYOkz/x+JXg8nLOf4pJWZa7EiXuO7pp8jf3d/ukyVc9xoazmVOlY2l/8qoQpiYe/0iliXD8Jq+3bfrZl2EAeqtov5nZ+MFexvqeiQjcuIeFJiMyniIMRCFs82sUp+fhkPatXJ/33EBlHVpgwUTvCQqpL4mRjE2vt1n0SfGqj5om5jXY9Aj/J82aPoyLE7HYKeq0NtMuXVKP3zJi+CgNRGmZwSB7RtldvXhYK1sr5y52kLGj3lHb5C0JAhICM7eKjr3dBKGShjQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by IA0PR11MB8354.namprd11.prod.outlook.com (2603:10b6:208:48c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Tue, 24 Jun
 2025 08:22:11 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%4]) with mapi id 15.20.8857.026; Tue, 24 Jun 2025
 08:22:11 +0000
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
Subject: RE: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Thread-Topic: [PATCH v2 3/4] iommufd: Destroy vdevice on idevice destroy
Thread-Index: AQHb5CVFBE31qd5pKk69rn63g+oyeLQR9yeg
Date: Tue, 24 Jun 2025 08:22:11 +0000
Message-ID: <BN9PR11MB5276DCB10B6B08811206C3A28C78A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20250623094946.1714996-1-yilun.xu@linux.intel.com>
 <20250623094946.1714996-4-yilun.xu@linux.intel.com>
In-Reply-To: <20250623094946.1714996-4-yilun.xu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|IA0PR11MB8354:EE_
x-ms-office365-filtering-correlation-id: 5dbdaee8-3b28-469c-bdc8-08ddb2f837dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?fRBIzDcfgFhC0JfQhvVm6ScMnhQsLll33GEn9dww1vrap7LNrIqp3dNImEi9?=
 =?us-ascii?Q?LvxHurdqobR6pSljG6iEGpRTi83DaVNaN9/K+X5y608WFvlzgkkq3RD6kMY4?=
 =?us-ascii?Q?tlW373v5HIN7oxlGO55bon8fMdxP9JYebdqC8wtF8rzS7pacvoqSlpZ9e0VS?=
 =?us-ascii?Q?itPuwtXjvs0PXnK2VbgZhony9ecFkALDCmOAGVT6ENW4Gvpxl2MQ/22t7TtA?=
 =?us-ascii?Q?QOw0X+ddxXEynZrxAsapIOT2czd4/cIZFcStp2dPZYsK2yRsuaOaIXcHZB+f?=
 =?us-ascii?Q?eKxHFvYCaMpIkkOlPZDL6eF6VLn+HC7NlIZkbrFDbEVHJlzTH3Gd/bRJb2Bg?=
 =?us-ascii?Q?yLOrFswNCIuqOfRYRD2G3m6L2OXC36BE9hQnEFihkPFSypPVQLFS5ReN7q3T?=
 =?us-ascii?Q?9ZbYzW+pRp+iqQHXvohWMfMEI+sZTt2FKX6POyKcIVL7yvKsE00didTgmZqq?=
 =?us-ascii?Q?V2pFKGuOB0J84u3nZUx6DNQd2ItetQmD4VJ4tJ9NE7H+0tb5A8Hu8VsRy+Li?=
 =?us-ascii?Q?ANPitvYQL7VvA9ZThWda70MEwYxL1JUvp5FxZvPKLYZB0sezH1FDXM1b6jSf?=
 =?us-ascii?Q?yk/XXT28fFw/VaPISYopBf6CKaWKTk3EViKAPm4LSQnRj9CUZGZvkg+cNtZs?=
 =?us-ascii?Q?p8rRhlwGG0LevOyzOsYgs5Xhr+H8Pcuj2RA4DZQe/LT8HCfwliuD2g+tmfVg?=
 =?us-ascii?Q?teiFax1vLrD+jyBghyj831AziBXibq/vQF2s8SBMEuxRMMpk51caSLFRGd0r?=
 =?us-ascii?Q?3woL6qvRLvdcC3Qlcn9qE2oemRibeGsHKLuGu6BDqGApUgUVH8D/Z2XJvLW/?=
 =?us-ascii?Q?e5GhdFu6xWtAdEAneLl4Z5C5YaTDffZSIMA3wm8VErMUZOMHg3WbB7GKrbz9?=
 =?us-ascii?Q?gsVjMigtwnxEbDoVECtvce0ob0UnM0HRICp8u7H9bqX31BA1ynoTjqWnSkUN?=
 =?us-ascii?Q?RSN8xTbpkre9rcpxg7MVenoHuX7xqSDUS4+T0xYulSCUAUSsI/+LMxnXsGI8?=
 =?us-ascii?Q?Zr1hVBBX32KLd5rmHd5hCWjA+Bj9hAMzpmVmsHxCrhOhljog1qShvO9GcCjF?=
 =?us-ascii?Q?8QE+HFOVOVfWa07z4Sut4jybG0e5W03o3DpSOypz8z9Jpvi3PE3rQoWIMgna?=
 =?us-ascii?Q?a0O591cuEGpMPJBn+Gb4zej2o767XAY+xbcwXodqGKQ4mgXaTdBjogAu8t46?=
 =?us-ascii?Q?t1azy2Xcyp4MF9D0dOC0HHnIr50z10iT7SOxZwahKg0+aPfIk8I2C00Qv3s/?=
 =?us-ascii?Q?BGwfKp8HD+8ywV2bmpcyJhfzv44x5gKQd1Raiu5miuX3F4c8tjZtHyG3ZDPn?=
 =?us-ascii?Q?UJWjvzq/q8Un05ltotWFLiWXS+8fWW8+/Exstj094dK+MZ2aLUt+7T8vDD8F?=
 =?us-ascii?Q?x8DK3E8a+BJCgnHAUd8Eu08JlXzrrVRNptWOSpSLuptvgGzx2xMmtw7lP2IC?=
 =?us-ascii?Q?koLOn2AquXi/V99WH335489u4IfR9Cqt8Ag2thhCFX+ck4Ep5kVJzA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?VhfRmaHsYErH2GVKpU9p8L1ZQcrPCpy0tlpSzWTd3nL6jxKXrfNTvk05n1pD?=
 =?us-ascii?Q?g2cC07qzZEqqwsd8sOnncUV3+krsvJ/oDQEy+L7solWt5InTj2L45Sb5mzVj?=
 =?us-ascii?Q?PCXrFZTUwKlnRrz9VoHLVFSIBJB2HSicWlCfk8uI0QxVWFwEvFYNSgNXJ0u2?=
 =?us-ascii?Q?Bb1B2kmrt2MkwNJRvAuAi9nJdaV6Fi0zSIvzHaz4kXrLtZYE27LBWRT1l0YJ?=
 =?us-ascii?Q?RmMvIFRevYrvX2v5+x9dHOx/5ZXZeR+pCKQWedU6FjBtQqrVHfdN2MU9oVGk?=
 =?us-ascii?Q?VX2/i073ix+1pfopeOd5y1Y//75HJsCz4QDj1d2y4uhFEPG7OR+oG6AZO1dc?=
 =?us-ascii?Q?ybTz0EdZY1CmqOiXnV5Of7pLarjnktw++vBQ8p3KWu5ax29BK6ln6yodLb/6?=
 =?us-ascii?Q?SNWpUT2pSSpwUc9p30pG9td2SkbeGzMcsN/auAgOj92yxkD1F8tqXf+ujtAD?=
 =?us-ascii?Q?S4yemQHpJiNqopuFaNekXmQUIZdwieEJtKw7+wiXHtKcJeNH7bORoNVFbOey?=
 =?us-ascii?Q?BRDuor/GqurtuCZSnm4gCwbWSJMk+z+7PYNp6HIHMCWB6o25JVUO2PiPF45c?=
 =?us-ascii?Q?Spk/di+P+1gk8BexZzLtVd2wF+6kBq9f9oTVgyeGXYm/0ttd5iLk7UfmUi61?=
 =?us-ascii?Q?qXq56h0AtArACZ8CT4IxjPCtDNuZ9uCsoVDx8Xorqj1G5CeK01ZfATGItZqq?=
 =?us-ascii?Q?kF1LIZ6PU1zEfFOyE/QBBwo4OyOulgRXWSEyeSJVkUEoKn2ez4Qk9TCjPjVw?=
 =?us-ascii?Q?h+dho6OCTMl53V70cYS8kAdPDz0enQWYCutp5yjtPAnPizckvYzLiX4SDuP+?=
 =?us-ascii?Q?sC1WT7PvP+0YuLIVldw27PakeV30TeyadrsNDbJtdA8vekGI5DhYQJXVfAzr?=
 =?us-ascii?Q?vsc6RUGLzjAVboh/v86e2waY8nXa36Jg+dtgOFELusoJR0J9sPtQXIhAni/0?=
 =?us-ascii?Q?F9C8QbzrMy5lw14K64SUtMmFBgQYkuPKwvcUp+rg/xfZYx22NKoMzqikFVCE?=
 =?us-ascii?Q?0ImqwKn5WMNmkhK/Ph/O0uRpmkCiwkHbEhMioKrAm2lKqSfHSLO7ZEZ11q+S?=
 =?us-ascii?Q?5dvg8ayu6vl0ZX9MyQdnk8akYtLjafHHhidP/P8Jh/TauxKapFXU0w595YtG?=
 =?us-ascii?Q?A2PaMTVU/U3Gc3SCmjXNJzwnS5bR5fRalnAREb+YgG476tzLPWRskALZjRtM?=
 =?us-ascii?Q?a1VwjfBQ3gvk+xpoT31ueAqOxhEmjpHU2C9zbFl5iJdS4ioqvXI7LXcc+Ah0?=
 =?us-ascii?Q?exKTGuhmPWJFl8IuIc6D+QHffoB9qXXndZXERCxWZb4L6jJRINNNK0LIiktL?=
 =?us-ascii?Q?qZ2N43sCaU947N69myvIsAveMs8HpkuA0g9rW3y6elURSBCWSuP0u1SoAEeN?=
 =?us-ascii?Q?CoEU7yJjIGH4TXd73QS5kV6a2lSH+4utm+w0jGTCyN7Uv5PqDt67b3UDaU37?=
 =?us-ascii?Q?O9FzndQWsTJrPBCzSbLbOHB/+oswF0usCtlPbN3xmwQDpYDYZKQqBq5eICtU?=
 =?us-ascii?Q?SUrna+D1ncdo9KbdCPq7AftQ1BnX2/gvClHnjmUnwMEoBLK+ZSRg7gM1QRPZ?=
 =?us-ascii?Q?qy1eGisj5ECKQBFxuQWtkDnbhX3ZvF5rFE8TA23X?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbdaee8-3b28-469c-bdc8-08ddb2f837dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2025 08:22:11.5039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXPzRW9L/F+bOrh2JGLQVexaTTeZe5vxbI8KNjtMWyO5zveJJANZoKaqWXvNU8hXBIOeOpLYK1UA9GeSSwgyAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8354
X-OriginatorOrg: intel.com

> From: Xu Yilun <yilun.xu@linux.intel.com>
> Sent: Monday, June 23, 2025 5:50 PM
>=20
> +static void iommufd_device_remove_vdev(struct iommufd_device *idev)
> +{
> +	bool vdev_removing =3D false;
> +
> +	mutex_lock(&idev->igroup->lock);
> +	if (idev->vdev) {
> +		struct iommufd_vdevice *vdev;
> +
> +		vdev =3D iommufd_get_vdevice(idev->ictx, idev->vdev->obj.id);
> +		if (IS_ERR(vdev)) {
> +			/* vdev is removed from xarray, but is not
> destroyed/freed */
> +			vdev_removing =3D true;
> +			goto unlock;
> +		}
> +
> +		/* Should never happen */
> +		if (WARN_ON(vdev !=3D idev->vdev)) {
> +			idev->vdev =3D NULL;
> +			iommufd_put_object(idev->ictx, &vdev->obj);
> +			goto unlock;
> +		}
> +
> +		/*
> +		 * vdev cannot be destroyed after refcount_inc, safe to
> release

"vdev cannot be destroyed by userspace"

> +		 * idev->igroup->lock and use idev->vdev afterward.
> +		 */
> +		refcount_inc(&idev->vdev->obj.users);
> +		iommufd_put_object(idev->ictx, &idev->vdev->obj);

s/idev->vdev/vdev/

> @@ -124,18 +139,28 @@ int iommufd_vdevice_alloc_ioctl(struct
> iommufd_ucmd *ucmd)
>  		goto out_put_idev;
>  	}
>=20
> +	mutex_lock(&idev->igroup->lock);
> +	if (idev->vdev) {
> +		rc =3D -EEXIST;
> +		goto out_unlock_igroup;
> +	}
> +
>  	vdev =3D iommufd_object_alloc(ucmd->ictx, vdev,
> IOMMUFD_OBJ_VDEVICE);
>  	if (IS_ERR(vdev)) {
>  		rc =3D PTR_ERR(vdev);
> -		goto out_put_idev;
> +		goto out_unlock_igroup;
>  	}
>=20
> +	/* vdev can't outlive idev, vdev->idev is always valid, need no refcnt
> */
> +	vdev->idev =3D idev;
>  	vdev->ictx =3D ucmd->ictx;
>  	vdev->id =3D virt_id;
>  	vdev->dev =3D idev->dev;
>  	get_device(idev->dev);

this is not necessary now, as idevice already holds a reference to device
and now vdevice cannot outlive idevice.
