Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1748B3AA9D9
	for <iommu@lists.linux.dev>; Mon, 25 May 2026 06:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779691818; cv=fail; b=SVjQTvunhD9wPzh5Hv6qZDehWj7GvIB9HraA3Tc30y7yQnk10tjT2q4RyI3vk/Dt9gMrz52Q7eec5X9BdpdNMW2t9CAQ9IMyALjOiMr756FAgjx9WtebTLa38W6daetVQTe9xY7UggWiu0ogd2ykqt4sWH3GITV4rv/J1kssnmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779691818; c=relaxed/simple;
	bh=t7gAnHqAUPh3HELS6LofFyUjP7fgemD/iGKmiOdVlYk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OVx/eo7M7NAFr2u584HE0A/gnWmqMR9mpXnIUcUi2OUufJyBLLlQTiIdn2KG1XUZ2/9LNqNy65aQ4VZD9hicU27Ir8GGoumWjSHfEjMvgHWCMiX8ARGol/3dw0z8ES7zzJa5SyUKZzmXYQYiJql/Gap8yuY9kY227goxMrtOySg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3bmUHbB; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3bmUHbB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779691815; x=1811227815;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t7gAnHqAUPh3HELS6LofFyUjP7fgemD/iGKmiOdVlYk=;
  b=L3bmUHbBXPUVWDZDqyPfovwn3Udjb4AHxYQDvLaGCq73IJ8cP1CxWvDg
   y1fIcTZckQFlxBUplns+zDbr82guDyrfEVoYorrlfE+Dt/okFEg9FEVWc
   nuJUpprxkd03g07Q4OrJiM/NJGAqJi9tl90BnFD/EljkQlMWbXrwMrfka
   9uJcI9l9fTI0fs6Y911F/0Dx3A+nqPxvfsemsrMWOlLoB/nassnEo+rKJ
   7CsSNtC6hGxopXB46RsLqmgz6OLyrO8IFnVm6p47QsD6HGLV1AveWrIh/
   k3RXykMcQLkpweV1FbJs0ThJ90eH54r4RnR1LaFG0MsVU7tq+4Z7qwlwX
   Q==;
X-CSE-ConnectionGUID: H1cHBRv2SnKgXHMNP+iVDg==
X-CSE-MsgGUID: TPuzwtlbT8+E74PXOGXlqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11796"; a="79541939"
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="79541939"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:50:14 -0700
X-CSE-ConnectionGUID: EnAOBlfpR+6+aXvsgoOfBA==
X-CSE-MsgGUID: XsjkJzxFSP61fWIKegGInw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,167,1774335600"; 
   d="scan'208";a="265086169"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2026 23:50:13 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 23:50:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Sun, 24 May 2026 23:50:13 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.58) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Sun, 24 May 2026 23:50:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E7z1QBAm44H2CkNydXJkb+a18/tWksszaQ4ImKY9hbgmocHI4Cmvt4uS8hlQ5HTxNE10mw4TURVv0ep5S4StSTf7zwp/0gki8KTZHSjj7zYc6eyiAiEQ+8FfHb4nlTTzFoxymznn9yZWwSKhm2NIFF1PqsxwTJ4Sc0Mym1V+uzKJlwV9eyDbFLssKqOBF0B2Wg+6sxclzLq7jM7llubLxE6+FM//tTa8o6n5zeiOBMmc2dGoQ4Uvi9xib3795Guofn9/led022OYh1NtRPB1xAKL7rhIOih1i2mzKVLNJ9gWmaAFPoIvFwudHGLQUiSQevKFvlfXlNBes+SK0yl99A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7gAnHqAUPh3HELS6LofFyUjP7fgemD/iGKmiOdVlYk=;
 b=UNCr2F6beNpoHmTEVee1Uwq6MFZfQXpR4DeYQ1iAI3WewDfUUseOPeLTEyXFdx4UJtywEOSUfzQzo3WB1vV5j3ZgzcuuYvGq/9MnfAKzQLeagfXjxtLaZ8xi0H4UCd9BtnmNTd2kAjLrRnxlfIn1kZN8bIk/HWdtCLGlKTp3olkdbPd2lLptUpKn6SqFLgnsZ1Rcg7FKpc7BT8etLSMy9mwWbHCuCDTaGPk8oAOeXaTUx1GaHGlf/hnp2sc74Ud3rzu383ZcUkXoeM/fRmN9acYYq9KtxNkwVRFrTMOHcrJAt7enkFjhGP/SULLBFIRONxLg8lIpunAl1Xw1haGGFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM3PR11MB8670.namprd11.prod.outlook.com (2603:10b6:0:3d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.19; Mon, 25 May 2026 06:50:10 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::f997:762f:f079:134f%5]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 06:50:09 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Nicolin Chen <nicolinc@nvidia.com>, "jgg@nvidia.com" <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>
Subject: RE: [PATCH rc v2 2/4] iommufd: Move vevent memory allocation outside
 spinlock
Thread-Topic: [PATCH rc v2 2/4] iommufd: Move vevent memory allocation outside
 spinlock
Thread-Index: AQHc6YMkbF5Yk+BJx0iVRl2AF7OkmrYeUluQ
Date: Mon, 25 May 2026 06:50:09 +0000
Message-ID: <BN9PR11MB5276B8B0D9C158B51684B2A88C0A2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <cover.1779408671.git.nicolinc@nvidia.com>
 <5ff36b5d80f7f6299f851be532a5195c1d2f1dae.1779408671.git.nicolinc@nvidia.com>
In-Reply-To: <5ff36b5d80f7f6299f851be532a5195c1d2f1dae.1779408671.git.nicolinc@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|DM3PR11MB8670:EE_
x-ms-office365-filtering-correlation-id: 11f7389c-a835-49d2-a8fb-08deba29dd22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|18002099003|56012099003|38070700021|4143699003|11063799006;
x-microsoft-antispam-message-info: y+swsim3hutk+xRgPbRQh1aSvbvybupnKOz8EAmh/DpNU3j2qD2cky8hX+P2e0J3m79VcT/RaH+JeBo9hcmSW5vAxLY4kay0Xfe/FC/2fsgkNTgtMLSJ9SSSRq6d9tuIHnkE9Otol/P70rIo0yLTG1w+YmRJYx414EHOWHxtDCWKJrnI9v0MKhQhixCYlERNKauQFV8vsI1CHHsZV98o2KU1wbh4SHnM2TinqoH7X4ULLlI/oZFcTB/Uvh3dTGk0UHA7Upetl3q9lJPlDewpi/xtlhxayFJIMQ6jNfXVRl88MOav833Hdc5q3kOIdjljg5A/15ltI67zuYUsiq0oVPB1wh9nn2Q6+Y/4AMQ5IlWsq4B2aeIZGKA8TmkgsbTaXkXa6LMMB1SDB03AEjtVolcCiDZKOC3V8n+4w6IqqR/5dU1mVjV4oBNDyLE+YN6twRQ5VTTweYXDOBIuhczBVggBmjN/PcfrK1g/GUAvB+opawNb6oT+hR8DkaBj0keWVA1c7pbt5q6MPz/s8cWGJswn+Uf/gw5FYhj7EpVhZUqdmDlsI0jR/DjFyA8ZGzCQGhIyvzcmE+aomjQFglQxuKUcrOjimWhfzLCZPXuZSO11Cq4Lst9WvVNk7SgceU07EA6iDdCe8Buq+NEfX99blL842XOaZ9NPJVpfIf9ENFTZf2HDGAmu1KkyPf/B9ifZyUREAkOguIqAy4HPhBKUd92szaZCfA0weeJ3Gx56AyhAhIH6PoGaP7foXCFGZBxT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021)(4143699003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a2YW6rAHcctJ8V76ZClpm+DXgc3v2M75bSbRpo2IvOQF+kiQhNWRr79eXpYY?=
 =?us-ascii?Q?yJV8KKr4ql5C3mlvKke0Rj9+tbNg7KkBCPhy2tgOD6qRDb9G57SFlR0py48w?=
 =?us-ascii?Q?3b6MeChuaroglCcACO1BLoz4RsV0kof+K0hApube+nfoHGBunau+jIQeDRUR?=
 =?us-ascii?Q?kM9iCny/NnF87dZiKjHCJL/9zmkYXT7V/JX8Vxctk3GJPudjM/XL8Bj/93qJ?=
 =?us-ascii?Q?OPDXJvOnexrRp+T3Wt+HRxn0l5ifu8GDu4OVyYppw8cy3+2F1j2NaSj+hvOf?=
 =?us-ascii?Q?x5ktF8YDcdjs2sBMmCP+lcfDgKb48ByDTL5zkRFTre8HJMHDQxl+ACyVJD0x?=
 =?us-ascii?Q?CZMsrjl15+oGa0OOHQeuoBsOcj0ZIcdWYEy8QV0RXcC/dFB6lsz9pCiyQEQH?=
 =?us-ascii?Q?CfmBbas2Btu+Zso+Pq2LITZalN2GwM1jhrl2IKU+gBZ4EYRHlBHBmYSdmtaQ?=
 =?us-ascii?Q?A7ykXfg9q47JOPlitB1CcygUYOYgb9ElwJR7Y+tFaB5nTCc//vnrLpoNvbm6?=
 =?us-ascii?Q?Ppq8zdrbz4ZvOhUnTGwR0dP1W7VPIDuAm6AV95HTxsliEQSJWBCgvvKeswVg?=
 =?us-ascii?Q?CkDJnGwiKcJH+UBsO/1ELyEn1GZYSZOaxUdu/uudiq9w3FTAHZfuUjlwdUeP?=
 =?us-ascii?Q?VfaNy4HqBfBlmG2UETJ/Zb0FKcufVOtu/oT2cALkivSpiA4P+Snffd8FI3az?=
 =?us-ascii?Q?fdM3jweN+RqtXqlwrgJkQF8Z0OrrOCm8HOT03ltZjGUGlq13d69/nHpUGQCu?=
 =?us-ascii?Q?Pbh11T0u39Ikg7V77Tay28wifsWiDOw7dq/jHl+p1CLHK+0tMLucj5fRvr51?=
 =?us-ascii?Q?hKO69vQjMpULRm22DjM54lbxsFlZfQX/T0MRiUPcAeAUPk67RsErT1Emg54g?=
 =?us-ascii?Q?U4mGvge6+QqgcZBSvzyV9oxlaeGTmKk66WdjVMlV7HSO6puBCOUj4Fh0B4I5?=
 =?us-ascii?Q?fgSfqGQrnUs/ObwI5/1Lw7kF9eiq2W5ErhMUfyMLXY/GzXBTZZi7IY0GXnYK?=
 =?us-ascii?Q?WxxM0mQKeXpwaW6aP5Nn09729tScOV3+jn83+ZoB9uP6lDvBXUpSDhHEZnYw?=
 =?us-ascii?Q?a9Q2YZTj9eaASNpJ54Tm+uJXoowwIRBYdoRMVr6nElSqXkDnZ/DoOpR2HG48?=
 =?us-ascii?Q?97Gmn1QAb4HcV15IceYOC6lgRxYliQgpwT6ZRP3KoFCzbcv4lscEETyXvM3m?=
 =?us-ascii?Q?UJWECw6uZZnzw5E5+u9Uk4ZpaI/RsSFKOlqOs5FFmIURkGV0bPe9Qil11C6E?=
 =?us-ascii?Q?UofI7qi+ZaLw9tMfXLMjSUyLcq3bDkr84mYu9ApSZPu2a3igVKPiAtYfRXBS?=
 =?us-ascii?Q?B8M8JH/T02ebTKEtww6SyHzi6ZA+bfcIQKiW0zRzInSsmamZXvERh9QeN7fJ?=
 =?us-ascii?Q?gHSVbJzQ2iXp3t2Rxfsc6sNQ5TmndEKg0UF6fLXb6YmGFCaDZp5WMqcKWSxD?=
 =?us-ascii?Q?Nl780dkMW81HX/sur0aDq/9zl4P3NK47V82BdE/zShWy68ZUby4W3bx6dlQt?=
 =?us-ascii?Q?7+2WIuft2x2FPYk9wCrDtyC6YGW4V1ouzKS0n9XYHsqPKku7uKhDrvsozXAn?=
 =?us-ascii?Q?kJrkA0ItBDnmRIoPFb7m8RS+wzOtYsJDyVAzwPOzD/hZXeKdssBQ4Wt6Di5t?=
 =?us-ascii?Q?9DmOCmb6Fvir19cbfOw7YtPqkW6hqAy6/KKdAzZ6e2ifoBgTgRl0Jr5tTvaz?=
 =?us-ascii?Q?+S7kHDuqNwA47HJpr+R68I1Q+List2rM4THJe/NPFArDXht2IB3tD4CWwQt9?=
 =?us-ascii?Q?cCQqrTXL8A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: LjVSg5hNqHd6nyw6OLqZv7u4n5z+tlNtyRdJxHWLlAiVKO/s65mRoTk/7bbVaDFLuPFcfraJV4nXJURnLgBkUy51pEO1T1xQOT/BuUo8471yeOshEEV+UBQyw42kOBwW4fqvRGzV58eoBLC7p/dbM70Q6gT1JsZpnehW3bmun4Dn+BuP3AA6lmoBC0mRzoziYcXyuoGa1ePzIsskqXFe0xhZ5M8wFEk7YPdR45r4YU6WMkoyuKT4XZ+B7A8i389Div3/FPiWple2pVgRFzXoMx6VKeo5AZyJnTETLredrH4cjmJ6QCFzIy2WGkR6HsiQ4SoiRQHZiaIvSI8kzfHaGA==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f7389c-a835-49d2-a8fb-08deba29dd22
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 06:50:09.9615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GlZVyCjE/BYyrzBnzFgFSo1I7xIG+ER2bExvgLOcnJfHKChWoUd4Got4h8b68oRNhipX3sMoJfbfnQA+zyM8XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8670
X-OriginatorOrg: intel.com

> From: Nicolin Chen <nicolinc@nvidia.com>
> Sent: Friday, May 22, 2026 8:37 AM
>=20
> The veventq memory allocation happens inside the spinlock. Given its dept=
h
> is decided by the user space, this leaves a vulnerability, where userspac=
e
> can allocate large queues to exhaust atomic memory reserves.
>=20
> Move the allocation outside the spinlock and use GFP_NOWAIT, which can
> fail
> fast under memory pressure without dipping into the GFP_ATOMIC reserves
> or
> direct-reclaiming from the threaded IRQ handler. On allocation failure,
> queue the lost_events_header (so userspace learns of the drop) and return
> -ENOMEM so the caller learns of the kernel-side memory pressure.
>=20
> This is intentionally distinct from the queue-overflow path, which also
> queues the lost_events_header but returns 0: a full queue is an expected
> userspace-pacing condition rather than a kernel error.
>=20
> A subsequent change will cap the upper bound of the veventq_depth.
>=20
> Fixes: e36ba5ab808e ("iommufd: Add IOMMUFD_OBJ_VEVENTQ and
> IOMMUFD_CMD_VEVENTQ_ALLOC")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
