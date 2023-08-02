Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD057E;
	Wed,  2 Aug 2023 01:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690940022; x=1722476022;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gJ12rHNlY3lW4xMVIYqHcXwvtCXjc0VZhdFOH3pwkuk=;
  b=HSg2m8QemzM0GDB9RT4TQqG20ivay9c0BWg7tCxNVy9fo3oR6tPpV5eA
   ciPbn/R8YFXYAsDXg+fOgG2Bdf5CJFGH6Kuz8EJpdf78Q0XinmwRkLqrw
   68ZrhRh4FZAUfZNeuzNAqMWxsMqit2PRg6dSbWjn84g1EhRuknv0fLTXw
   2/d1eubcDUgY1bPi1mYuZBvazaMaDs27W0Nde+N2L8YCtSOzV5csvnQqv
   zeoKoH7WbFyWgkoFv2Cl9fBOvgo2MFhCbkTWavY7DfqUyMR/w2JbQ61Ym
   l9TeQPL936ZFCD/bT81CHjpGWjCfqtZRiDV9HBrRt9VXsn2PMqs08B6YP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359492754"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="359492754"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 18:33:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="722681987"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="722681987"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2023 18:33:40 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 18:33:40 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 18:33:40 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 18:33:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F2/MHIda9sldDLXfeWm92+AFAlycab3Em2hKWc2nQJlvoySLB/PUgUXku2ewNV9ygJ/dYAxEkM3cNW6IcyN7ZO7eD3NYsk046j1NyLHiccpoOdhz7+c2JT6EPWD8RFN7H78sCmzBLviW2wXVr8ZkuX9Z4yMTi3pEmdWUKbPEPXvgHw7oJzU6hDK9KtqF+lAZ4r9/Oi6eeMjDJfRKp0GrxKVx3pAxom309HRkd+CW+pRTyQFw0T4o0m+c2YO1lecVL0Q/A7bb7S7LHUAwlEeQeYR8cM0uiWjhvQBtth8ObQsYbSFV2F+yFsqic0pLh++IY7wc8tt5LuxaGPa6IutXWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gJ12rHNlY3lW4xMVIYqHcXwvtCXjc0VZhdFOH3pwkuk=;
 b=U53tfwFZrfBR+oM6fbeQX9zGW2pwXjDMmUr3f+kRiHVJgWry6L1t4X/6sesj6DeDYAWmwDMCdxLuRX0Onl9bpFvkRrFsJPcqMmhHuSkU/dDUYYBMwd0oGYFPTfPEel/qGPM5u4w4wiV1x5vsyFubdlh4uzPQcxN8mghSgN2Ddq+jJqmrZVSaT3KC+hKR6bYVHY2N59xM7AsS6LXg5LCo1LnvjBJ+10P6deyzfUjVvQq65dzkBkfV3Ba09x3hA+h/fL2IgXVHV2o74pU8ZYt/spfXnnD9s7Pet7b95qJmgrtmLaoLkbz/kdcSpc79LbtVUYmUfi71c9Tt1hYEWpRshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 2 Aug
 2023 01:33:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 01:33:38 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, David Woodhouse <dwmw2@infradead.org>, Heiko
 Stuebner <heiko@sntech.de>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jernej Skrabec <jernej.skrabec@gmail.com>, "Joerg Roedel" <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, Orson Zhai <orsonzhai@gmail.com>, Robin Murphy
	<robin.murphy@arm.com>, Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai
	<wens@csie.org>, Will Deacon <will@kernel.org>, Chunyan Zhang
	<zhang.lyra@gmail.com>
CC: Alex Williamson <alex.williamson@redhat.com>, Lu Baolu
	<baolu.lu@linux.intel.com>
Subject: RE: [PATCH v2 01/10] iommu: Remove useless group refcounting
Thread-Topic: [PATCH v2 01/10] iommu: Remove useless group refcounting
Thread-Index: AQHZw9eSo/0MHu2cdEaWGD6zMVPfqK/WOvEQ
Date: Wed, 2 Aug 2023 01:33:38 +0000
Message-ID: <BN9PR11MB52766E8DA3D094ED66AB1F988C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
 <1-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <1-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4648:EE_
x-ms-office365-filtering-correlation-id: aca9a968-d95f-4966-9279-08db92f87f08
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Qgbgmh8RC/vIV4iYrBonX/1dW0KjSMCU+aunnitf8EC/xYdSNUqcmAoXIQYkUX1zgeggVYvJaD3/lu5H+gp4t5TyFH3dU12fHWJkZHDJM3zsAO8XdG2HhCsVap1qDy/D4q+2+kQnAvLg7Vf1y39bBnRKvFxyH8WxkpPx4r2VCn8O3HjJOHWXB5AcuDfZ2Q8rIXfVReWx6r2ecsYzln8lX0AeYRBf2LZNftkYON5xz5uwfZj0b9A2zQM/OY3UFnvREGxfqsToe+gDrYxrW2+u9ZaJN5tLlCRf2GZFlkIc3shQVzpswMPCi3Mb0NC8PTBPykWRttABdm9ak0R1oqtFhTJaFqoSSI4/ZjCznl0IXxd4KZaJx67fR9+UpIkNedOS7djIS7vxawURqyo6Iz4fvfiFaLmQGzSHQAwxoGkRaQtSsvx+vkUUsFZZGU/l+25TF2pF9zsQLu31Zauf0zyv1W2PpZABOYC27Nm+s+QftV4udUrqTIkfzPqDNzLwnHQnrdMoFtmf6TnmLVEVJC/7E71b//HaUFBOL2xAfhyEWPzWSE6h+GzogUAtHS1f2h3C93x0uwYKjJLGIOi8Sya5kxBDeqdi1UvxmvkZIvO2ZVfz4rWJ7jVlCdSczr3cxqK6zLpe6bxcvxENlTLloWT56Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(86362001)(38070700005)(122000001)(33656002)(82960400001)(921005)(7696005)(41300700001)(55016003)(2906002)(4744005)(110136005)(54906003)(38100700002)(52536014)(7416002)(5660300002)(76116006)(66446008)(8676002)(71200400001)(8936002)(26005)(186003)(64756008)(478600001)(6506007)(316002)(83380400001)(4326008)(66946007)(66556008)(9686003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KIqMCxFr7TqwAvaHGkIDtDMxNM3jm/VJPNe6aBBJEz0/yBFSu72n8d5DwpOx?=
 =?us-ascii?Q?ga+nB8vVqYR009zh78nbk+3cEZjkzNwP0XyMK7x+tvM2SayBFxkIMPMfqOAz?=
 =?us-ascii?Q?4WLF2cavpMQpDBBsUCbnR5BmIKDwhgd5cvgCmPToPtOu2WQa+z2kyeBtxpR1?=
 =?us-ascii?Q?/LMl7j/0NIi8rDF+CYD2bnFSJLbHwifd+dLc86DxiPwLxtH5mDlCAqxosctr?=
 =?us-ascii?Q?/lK3j9AeCD4KYt/YWyquGVa1WPBkJziFycT1EXC4XqNo1q9q73N+9P+nemiA?=
 =?us-ascii?Q?7Q2tbjUCWuMRuOxGGTM95vvVQWQ7mwzYBLL/jGVDpAAK26FUUvPRv/CHgRQl?=
 =?us-ascii?Q?fZFL4JiQ29+SCx5xNzLVzHRI9T0jXQW0I/mf9Q9AT2qImCG+pXb5XlewLIvD?=
 =?us-ascii?Q?huz1moWOp6TZigMTvhwg9wdYXY5RZF3BL0qdP5FmvKh5nB4TLr8rIpB7AFQJ?=
 =?us-ascii?Q?lCQpTo8gwMC5vQayEZ2m9+CSS6axmhPTJxbXF4d3QSJXALUcYxQ0UieMqqX8?=
 =?us-ascii?Q?bpq08kx1QN0B9jWuJsNUQvjM1hfMC6m3xu08vSWKonAngL3iAEe0rCLzgrac?=
 =?us-ascii?Q?k7rAs44ESXtP7rV8QTrL1SkgO5j1ZNfT065K1xh+1MNYP5mqtIRA1BXwT6rl?=
 =?us-ascii?Q?0/MO+PKnOPULILj3LhRDlNjw86FELAyg7pzjoJJdTJcgcOBNJOrLrGtkER0e?=
 =?us-ascii?Q?lzTU6Fs+PETy3eNiIKVtAgeqEzOxGHTQK9NnvkjzPSQ0tgGKtGiMgPrbdP6v?=
 =?us-ascii?Q?ecalonkqIZeHVUuPjJCJL9hxiLaygeP220jz018a7Y7kDMysnoLqhApLlfjm?=
 =?us-ascii?Q?LFFKio5cXAyy9vNGINVY4/kLqXpfYm8y7aFYEjuDwvspZtqMlZ5Ef6jdUziG?=
 =?us-ascii?Q?Zs8rd+8RU64jF6c2q3TMk79HACOJOIL0Z1aWTKsSG3Y3P6qM2+/0R9mrmXhA?=
 =?us-ascii?Q?pC9sFLuPN0eowT2GhJxD32t2Pv30EwfBDrGGzJpk2x0lDPJW2WR3jmHMNtMt?=
 =?us-ascii?Q?8GFnac7al+/m9xFjsK6bTD3N+Ifyw2nods3rFDdLzVEPrvLcbO9r8BtTozfs?=
 =?us-ascii?Q?CdQ0eu/Y7d4/yzXSWMA2Ya9YPMGdP3/AhxiCMDjX8KxIwK7Ur90gGBVbfquc?=
 =?us-ascii?Q?KeSGfVnYAuf38GGcUU3ml/6ZXQSqULvOBkpu1elI9gljnIYh4ewosiA8SW7d?=
 =?us-ascii?Q?vpRBk1VbS2doDob82rBoEKpF1559on1AxH96URNbJc6w8oizGHS5KYLNI8T7?=
 =?us-ascii?Q?LOEGzKOq5UJMu+MU56XET2+BHBcuCgI9r/v6jznqnv/m1KiLhQL9bIQC/P9w?=
 =?us-ascii?Q?QtM7AAO92xzZYQBhZTUOnDWO7JbKVgclnt+1gG+ZLO0zmvB1cTWzC9XBCy4T?=
 =?us-ascii?Q?zXyoS4PQ0fbZhuHVQzyucukDK/gAc9db5pvpFhBy8k5c4mMphVDROdVKhBlk?=
 =?us-ascii?Q?xJl2KPMcOdeigf84zLy2gL57157xf00RmS0XKGT8aqTvyFlSp6uJmKwmDnmr?=
 =?us-ascii?Q?K0J0YZQueIrmSYRqfuBbv+A2jHL3mEukrhKGpBKJ8nYOWM9VetM9RpC+x1SR?=
 =?us-ascii?Q?1EiPzaXLOdAd8WPuj2O7OsI3tcyTuQn0JutkaYFy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aca9a968-d95f-4966-9279-08db92f87f08
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 01:33:38.3668
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6z1Gh868kXxbsiLh1y13hpDf/TLNqILnfdCBKVBwo5a7x9HZhZRVCc7UYyiVEsq8EzUVAekXkjVNDpe0U3AO4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, August 1, 2023 1:50 AM
>=20
> Several functions obtain the group reference and then release it before
> returning. This gives the impression that the refcount is protecting
> something for the duration of the function.
>=20
> In truth all of these functions are called in places that know a device
> driver is probed to the device and our locking rules already require
> that dev->iommu_group cannot change while a driver is attached to the
> struct device.
>=20
> If this was not the case then this code is already at risk of triggering
> UAF as it is racy if the dev->iommu_group is concurrently going to
> NULL/free. refcount debugging will throw a WARN if kobject_get() is
> called on a 0 refcount object to highlight the bug.
>=20
> Remove the confusing refcounting and leave behind a comment about the
> restriction.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
