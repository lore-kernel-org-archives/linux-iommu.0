Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25DB72AEFD
	for <iommu@lists.linux.dev>; Wed, 29 May 2024 02:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716949695; cv=fail; b=e7pXa2eJJLnJpb6VVPRvQgTlgBhOsIkPUC2vP5Q1Ds79E0/Rs2Y435IMFGrRoYi39t2GiRWP3RF4MRN+N4yE3OLrq2XDZJwysroKMcbFaKY5IOYSxY/bj7D+rt8sLIZS/qkR4LPd4pgEOapqzdtqyIWRfX+do2d4ERyHXgkYZ7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716949695; c=relaxed/simple;
	bh=6KbHKF/8s0D/x/tMq36eUiqvhuivmZkgR/w9TaekHAA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kDetkUZmqsgqeVld85EQ8AUrkxKEXC7cJdXH1bqklCwBzTRsUonz+4QVpiuNzHTmgITtL9gXlsWCpdYohJNPe9EaQL7d4TDmBC7G/RJlgLSbDG0ehW9W1jZbo3rhASCj2fyfvhtBxTO6aBKHb7hEqZaVC07GJl/UHmGUeUZqXSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgBs88rB; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgBs88rB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716949694; x=1748485694;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6KbHKF/8s0D/x/tMq36eUiqvhuivmZkgR/w9TaekHAA=;
  b=mgBs88rBaBxliA9IzEAh+/mCovrXw0QIImi4VDCS7tX5td8PCG342k4p
   HVX+QyQqnYfR/ixSpSDqEctptKGcjyg8KVz3RS2LGnSm1AZI99geCjROE
   cD0f8ebHYuRZXXYJDRbwX694bNpPrdYvRJixCWRMhzCycozOaVCVdJ1NB
   FQne08TE7D1ryz5m/NxLi4iQPgAVBO5e/uyA1nYnfrZh18snG835t0n2+
   C+WBCuKN94HOZJFNY4VSCQ2WvKR1QHe1YDe5UlI2XRvvIYqXrv/wValPb
   eoZg0A8hqb5nzQ8bnQVpGNgzkS2p9qJNX9lNMRjtVX7yBP0uQ24Ujn5tm
   w==;
X-CSE-ConnectionGUID: 0cNkyKApTnSO7zUASsgo5g==
X-CSE-MsgGUID: LxeWsdS3Q9ebonTfiEyDNA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13497413"
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="13497413"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 19:28:13 -0700
X-CSE-ConnectionGUID: 8S8YuYnpSGGXPlAqWHaR0g==
X-CSE-MsgGUID: rVBtGikHQluckVmTR7vHvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,197,1712646000"; 
   d="scan'208";a="39710144"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 May 2024 19:28:13 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 28 May 2024 19:28:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 28 May 2024 19:28:13 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 19:28:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ajh4UlM74bdM7KwILkX2+8HksobtN0He8PlikXk4MqZ/LZN8ytNhpt7P777HOQkfX0tUeJJdBC6Oab2o4aQbgf1UjoGqaV7N+FJrUDWrBPvEI952ofaS3vUebk5qlG5MuY0FKiQdkKEEm24BpOTR01emKFeVrl+z5DOW7+2OafIdmXms7XM+6yMB6q1acTLYi8QBPcxsLJIK+qxs9/CnaUJpXzeQqmllR/9um8tnJ2tRM6FaUVogYXac7YRcqYq35wMsRjYliQE7clDzkOPwx/cVR2fRHIuYWjKfFUIG06/1mDi5N23Ck9vTcchrOZcvgTf2D/SmIxR9BRX0SBl7Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6KbHKF/8s0D/x/tMq36eUiqvhuivmZkgR/w9TaekHAA=;
 b=gSQcdHyIfEfArh3rVLEece6ucWCeAjdesKjYza74GGtlhBEqS2zBQIWXrrbwAkT5iwFqx/r/Tl3vk3MRhx5nDaSh1lWfhWDuofwyfMd+/yGlGd0uhEESrPL1SdPiSslbXTU8WE1153kYhdtFsxSE1Vw3leZWw9mexfSvM8wxB+/oPd0e2c/Kz9hsRL0M54iTjU5Dpz7cf5tpuFyzUHKvzDPWHzG8nbU5sQnbKPkIUOmAaaY/fyERQgPjb0ATnofWNhsCZUqXBlsYdigd7c7q9vBo6KyWiM7iONVkEvK+Pu0vAjQKPEo+1M0f17CaKdIWqmMw0PlkJibYfzt55V4CRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN7PR11MB7092.namprd11.prod.outlook.com (2603:10b6:806:29b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.29; Wed, 29 May
 2024 02:28:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b576:d3bd:c8e0:4bc1%5]) with mapi id 15.20.7611.030; Wed, 29 May 2024
 02:28:10 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, Jean-Philippe Brucker <jean-philippe@linaro.org>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu: Return right value in iommu_sva_bind_device()
Thread-Topic: [PATCH 1/1] iommu: Return right value in iommu_sva_bind_device()
Thread-Index: AQHasLduihaQeYMyCUyP+1BFuevGQ7Gtfi/g
Date: Wed, 29 May 2024 02:28:10 +0000
Message-ID: <BN9PR11MB5276A259D0245515C5AAB4F38CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240528042528.71396-1-baolu.lu@linux.intel.com>
In-Reply-To: <20240528042528.71396-1-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SN7PR11MB7092:EE_
x-ms-office365-filtering-correlation-id: 0349dc6e-faf0-4dea-2b7a-08dc7f86fbe4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?zrnQTr8UcFInjDw65YKTRfMuzZrYRsvl8L7ZiF/wAtCb/IRteR6fFh6+dHA8?=
 =?us-ascii?Q?gN9NdC3fEApOXX90P8D8wVUJP6FiFMaBZzFslMf53MgAiv8JimNaEejDJapT?=
 =?us-ascii?Q?6o+4EMc9oIrIbQ/MJC84bs19MuTLrrck6T1c4I71Y4AJEbI9X3+r1FLaUSaN?=
 =?us-ascii?Q?jYjjyrtxH8x4BSVaMC6jdIiZef8x9hpdqlpy1nIi0Us1pO7+5L/VmeAvwHXy?=
 =?us-ascii?Q?jj4vQkie8ylk2veB5n94aNsc8xkRWsb1gSPHlCR2T/qfA3nw8wgPO2QDcpYC?=
 =?us-ascii?Q?2bzoMlTvquwK6UEZryjX0vozYiE4MNiHatahb/48I+erh0uXPzYV53k3mxGb?=
 =?us-ascii?Q?AQwwtpMyeKRXTnJ+R3dpEqOrwmdQanRjTd0Zm8Msi8457l4ZUJCpIiq4Qu9K?=
 =?us-ascii?Q?HVdWX1SpXmxFIIny5NzMiHM3BR9FsXUPh7P8KZqm4zKkrfAiyipptIoOcdaz?=
 =?us-ascii?Q?uERUtjNckAbhBzF9fgDr37z1c4nLiAshQt31RoslysQCAaFJ1Pb8/SoAHAXa?=
 =?us-ascii?Q?VxQD5T6e+b7fHud4rrmPmFoLOp39BSRN6lx2L2X6KyS2PezNaAfbi304VVK7?=
 =?us-ascii?Q?46dzVoPoaDDiyh/FJg+L6pOyRDX3UtAmduudqJM5cyzFfEhccOK/i4TFDlbZ?=
 =?us-ascii?Q?YX4SqkFAqtq3bx6DLwWN9DHxuggoHyBI3TefVH4zZ6GrpASIlky66AwnTw3Z?=
 =?us-ascii?Q?7Do+QFcfY+gQERAL4SQiD3hlUkWMoKRL8vASLqTB7hT4tEDj8XGTmIGoQ6/C?=
 =?us-ascii?Q?Ho5xjCmomeVDTac37+GSzEdVZ3PsFbvOT1GsvvEkWVuy6FD3xsqXsz7/3z79?=
 =?us-ascii?Q?4X7lqA6qRHMu8+TAIcEAmqVQQvJ9SSCmDaIjLvkJuiizy9zCDIFyPi2nHpQh?=
 =?us-ascii?Q?qaMD1Ga0KkQX2WqKnFEPda4PsC8Qqn53tXoWlBNMuEm7+JMcZW7jAl7l8LlX?=
 =?us-ascii?Q?4VGf1lqQ++1utqepY6jIoSV4n7tM2srdc9v1ng33nKRwN8+ToMi01hyAy/yW?=
 =?us-ascii?Q?1kbkPSOHaHLUIXGHNWpjZmUrSOsHQBNSPtuDnSa/B4uuG75sHWpQfakDqk85?=
 =?us-ascii?Q?JgKBzFBLdQs8s4xhCWU5SaJbp6d7ysnLvpYCplO/jF08duI5tF2XijbfIL+4?=
 =?us-ascii?Q?OIW/n2HZW9gv3QmaZ1qcjMg0OpSI5NPunQ4Fd9Ok0LwN2ZCjNjbqLSEIwR84?=
 =?us-ascii?Q?t8/W/BcCJBqA4/S2X/F63SajA2EzqRPlZ+XkhijnQxyNpwBmP4kGhKhs580i?=
 =?us-ascii?Q?Qh9a3PUNwTD4mvamIq+d73Cr+jQtgMWMugLE7/k5lfgWznTMVoQGCIfIm9Ur?=
 =?us-ascii?Q?GOhAxIigCkPegm3+PyYzde0GSZ1fcCM/2hXSbIxLj+LnZA=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ixpKAiOsq6q526H+XovNviBZCwvRctgZRjuBffo2yzG9WJeBQcSxd6Z+sSRe?=
 =?us-ascii?Q?xm4591hzj5FEg7lh88m89yTlZwsEga/Vn13pouLcSN3K8TOYQ1U8kbIHMWjP?=
 =?us-ascii?Q?80LmsFrxsBwWiyghwkDQaRK3B8tMbTJhLqKqvvvh7MQ7DPUzkkz29e7hqqvx?=
 =?us-ascii?Q?RCWFnttwyUt6Yv1yLzRJpr4DQl0AeqOVXjGL2RTJJC6dqVWr/3jC5QPFZGIH?=
 =?us-ascii?Q?zdNf271Ysrk/d5m/6AC8aCiLs06EvvX+SbwUIal8MH2kw9bSzCs5S3ZUddOE?=
 =?us-ascii?Q?Z7gf57iCQ6c/Dms5duPONwMuz/YlIniaoMXCj0YJTVdpw/NpxCgaJBhBLo99?=
 =?us-ascii?Q?tGH/itN3wGThCtHiGKnnGb8YsZ54z2hprOb+vnqrUCKMHPUykGISuosza2Zo?=
 =?us-ascii?Q?tBX5g+DU4rtaqONkhTlNKekWLyoe4fH7eyUtT66K+YpF0NTklfeKsWmISubX?=
 =?us-ascii?Q?nwOwfXitIeNltzQLqlX5ebwQzysg0P00QxVQLS2hEYSLhaFJO3I9MFNkKh2F?=
 =?us-ascii?Q?glVLqQWV8aBwT1aqlrI8/UfMiz5mIcX8DuiXakOKNAo/TyC6EvmaCtSdQJwi?=
 =?us-ascii?Q?4DOEtg+1PB04GAQB7eOZByAc5iKMwP+YZpWnvMwLM4GAeZ3ciVT0WISblSU4?=
 =?us-ascii?Q?uA7iCGP9PntcfLSqM82+SZ7BJolZ7FPfpcj9lq/HvKGFyLdWMHhDOq+sgYD9?=
 =?us-ascii?Q?MYOx2XXE15Tx8GFswI5zWtDgdA1lt7dpscoQqDY42vYqZImSo0dXqhrYR9xk?=
 =?us-ascii?Q?kqsGs/Pt5EP2Uqoh5RgcLsc21m1SUuEU2/gohhdBnA1pk5kdwR480YB5jgmA?=
 =?us-ascii?Q?T2NaR8d5AI48BwBA798+hdwGeODEdt39N2oVc+Gl/NxIB9SFT8fIjfX31JIA?=
 =?us-ascii?Q?/JxGsYJ6nXBjo447gfb6Dow1CgiqwN/uxQNKk8c9Z/2pqRsshFOtI/GXDAPY?=
 =?us-ascii?Q?J9Mh0rKY+il47wANpaK/y+EXQsbQdFOX5Tn+aOb/J94Liy9yBdeVAr7sq/iL?=
 =?us-ascii?Q?pWq1g1ZPzwPtz/sSxLB8SEj4NB8P8QOrv1bVvQVv4RpfZPehls2RBuhbZ2Me?=
 =?us-ascii?Q?EvGQndZuyfWIGSpnwnyjSR4oqnrcBeBQfqxO5xCw2ZSfGqr3Z6j/EsDQmzBR?=
 =?us-ascii?Q?UZkpYSF/RKj+iobV4cpeTwKJgviUKQB3ByjMqddrffUxPGMpmPdiU4u3h1Z/?=
 =?us-ascii?Q?W++E+/IU55LDcC1tbkN8RrXARcSELTWOC1JlKCig0ZTw0ZizRueuriQaMSF2?=
 =?us-ascii?Q?OTybZjHthwjYnHVSXEQjJGd+eV0lIE6YnwNuIvZnqN8tr7tXHNICFi+kM6Jl?=
 =?us-ascii?Q?1FFL12YMg6V2u3RW0BLlkWMp769nLHIAj2lNY6ie3pMUFSi5LKoJIduJeH3r?=
 =?us-ascii?Q?sJP+1dAaffqx6934QpyMF9OiRjoCVatdKWHpRKgsNpUC9I6LVlZ5gjwq/+O6?=
 =?us-ascii?Q?UodAviLMmN1knLxyxiUZ8AwBfEnElP0BezvCQjXrx2mG0ZSM6evmwE6aVUpB?=
 =?us-ascii?Q?R3e5VYYmOGitG1XK1GS/BAERVlgH3+0a7tKSNIjqOnjt9J9bVe5SOZTlR8PY?=
 =?us-ascii?Q?/pg1vbhw8Q5glLqB0H4P8+ePIvywS3mnmPdxaT+g?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0349dc6e-faf0-4dea-2b7a-08dc7f86fbe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2024 02:28:10.7630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wsTk3+T9DKiqv0lK/s+TctPYjGF/BEVgtaecjI5gnXmTwY7RiDU1IliyUI1h1whwlDkT14Ion7Jc+1rJHOpYoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7092
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, May 28, 2024 12:25 PM
>=20
> iommu_sva_bind_device() should return either a sva bond handle or an
> ERR_PTR value in error cases. Existing drivers (idxd and uacce) only
> check the return value with IS_ERR(). This could potentially lead to
> a kernel NULL pointer dereference issue if the function returns NULL
> instead of an error pointer.
>=20
> In reality, this doesn't cause any problems because iommu_sva_bind_device=
()
> only returns NULL when the kernel is not configured with
> CONFIG_IOMMU_SVA.
> In this case, iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) will
> return an error, and the device drivers won't call iommu_sva_bind_device(=
)
> at all.
>=20
> Fixes: 26b25a2b98e4 ("iommu: Bind process address spaces to devices")
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
