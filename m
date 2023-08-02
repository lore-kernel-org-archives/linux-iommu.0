Received: from mgamail.intel.com (unknown [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC4C7E;
	Wed,  2 Aug 2023 01:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690940248; x=1722476248;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EjMvBtjZ3JczADqj5Ti+I4XnN8D3V5JUBIzB0SX8NhE=;
  b=WqEYXYudthkwmdpLKYkHo12X9Za/ktBYFX+OG5CXud/TsUOyXVS0vINL
   4jy70SJq3f1nEdMPUbeWwvQ6pqNca5I1y2udxUR27dUBnEXK9UAWgokdR
   si/1rpN9aeSr4IERAPk94pp5rNuDmHMbkUvMiwaMYKw54keVPgNPC7/zd
   /9U4uouzhoMGq3isOxLs+jurxC8rSgv3Uo72iOJdHb8D5sI0dqeXvyhS+
   BI/beSfoSsRSszBAwteXSJ/orik15ise5nhtPOYTg3aQRXyRbRNEBxP5v
   bbZW3qF+X2R5dFIQZyYrKizqpJTHIwd68VkUrcuQbCAThBZCayw7eeAWw
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359494425"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="359494425"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 18:37:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="842938497"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="842938497"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 01 Aug 2023 18:37:20 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 18:37:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 18:37:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 18:37:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f42Ti71JaCvun+73VctsB0kSnFpEWhI0764QdBkMRWZ2FZtfo1ZnwEGE46GqSvUUtz+TMYNnsmKdGMK28PildPG9nCo1p8cCcVIYJh7MmlYoLrHzQBs6G7/8I8iNnZySkT1rEWCa89UNg0LO25U8PZYGiPCalydM6yNqg5O+GesIsqTqUNeXjVoxCnjj7300akY7MjtWs4chnE4yL9bzMWy8ZnjujcrnMf2DkTTen/+Gg3dZqp6lDitfrcWWATdTrutMRepcEYMXCuidH2qo7yVNIDqdrs1IFbd8nqwF1uTu/dhziE40SmWbjGpkg4gheBkbDuUNd5ED4HGnamACRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjMvBtjZ3JczADqj5Ti+I4XnN8D3V5JUBIzB0SX8NhE=;
 b=D7TNNCLN513hwC1CDjR8UygLe73lbtS9VQCYbB7e8qyCd/K1whc+6UKs1xpZMu2Dy22PVf48VjcsT5ypcP+R1JaH5zxFm0oVlypLIG6nXEULaOh2e6HOrhrVan8wZx3PDR6UtEpvQxq6PIKPYSkI3p/lX8CnWSBvXsduwH3mPz1/ZI33H7drhBCBjv6c8lM7UAIEvEOMbJqQFx7sufs+UWNABQkFsGg9Km/JsgSDPs4oTNchz2AecHwWFEkBnZejUeYzsLx+imzC/9KPbJyPiYnKRhLsdFnU/JHFCYOKaPLOdNuwEx9zXZgAaydNUg1Emw/L9p/pfk4uMx/ef7jNaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 2 Aug
 2023 01:37:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 01:37:18 +0000
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
Subject: RE: [PATCH v2 10/10] iommu/intel: Fix missing locking for
 show_device_domain_translation()
Thread-Topic: [PATCH v2 10/10] iommu/intel: Fix missing locking for
 show_device_domain_translation()
Thread-Index: AQHZw9eYCOHO5vLAOECr9VoYKayM3q/WO/uA
Date: Wed, 2 Aug 2023 01:37:18 +0000
Message-ID: <BN9PR11MB527653368F916F01BF80CF948C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
 <10-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <10-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4648:EE_
x-ms-office365-filtering-correlation-id: 35bccb9c-1187-4ce9-4971-08db92f90209
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EhrjmbSVNUJPt0MDtLQ/V6Slwu7ey1ABh0bN6mG0Yz56/ZgtGaQauFL1fV1ilk9/5cfmmkDqdljSxekRRRDW8Xxj3EqPToL5DGJ+BHj6lQLmrDpEWo1qmg4WYODgt4IlI4vtZccVvndLcRGUWhhxJ/2VdNrihMBYwHJUjZoeTutqGRDRu6u32y4mtfuYZXqMWvZWjqDE5Yo6B8RlRAX533DIehjdLWT1s1+GDgTPQnBFfn0GNoiqEWBy6abRY5ZiaB3Kdl4MyqhBl1UVUL3NWmVwcIEJ7vsmkYz6QgZswOvkJVLNRhXouzvMNZiH4tL9XVDnM4Bbx48n1VVwxZ73Tm8rQ8gHAe5vrVEFTIPrZfT2WOs4+TyrlGUojbd16ar7qgWbeUcsICM25tYJ3Z7xjUprrGkyjuox+Z1EUNol5IP9pUZ9QkXcZGyLb1jq4e5P1icVZRbZ+8R/U4hz1CFdScMNmzemFSashffPOG55ZXTskX9q/EUJYxp9HVkMyvOOiUdNFIJ+J/kHOVapWZzMNQhs0YrMBGP89bSJ0hu4T2b+awte5rtZEEYyV/StDd00JngP/JyZQ93MuuGVS+kCHLIDjkuRnRuj34xw/LojUsip+o/J7nIDGFQPECTQ3Iqcm9h/lhB2QZUJ+vt+ddb3Dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(86362001)(38070700005)(122000001)(558084003)(33656002)(82960400001)(921005)(7696005)(41300700001)(55016003)(2906002)(110136005)(54906003)(38100700002)(52536014)(7416002)(5660300002)(76116006)(66446008)(8676002)(71200400001)(8936002)(26005)(186003)(64756008)(478600001)(6506007)(316002)(83380400001)(4326008)(66946007)(66556008)(9686003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?imKr1BxPpwPMXwBau1Lf7Yqj59hVzosqYaa6Qlp7WPxgjb2J8PP2v6XvqIOi?=
 =?us-ascii?Q?1ochq0CqsQA41V1A5IgS9CYUuvQh8phHdYqBKrobhVcmMLsiTelnJ3aFDpBG?=
 =?us-ascii?Q?iwk2rb041vHbN4fesydu3NoYatU7Qm+RJjVU4mkolJSoKS2PICCFcL/EuoJG?=
 =?us-ascii?Q?Ni57W52pUjGON0U6IlERlyedkPYqe2nLzjzL1jq7snRRCu28/1b1m9mTNZId?=
 =?us-ascii?Q?HpJraSqMACUjxTaPVwvKuQketCLsRNf0b65fvA6wqD+x/ScDLBK+xIerkGHk?=
 =?us-ascii?Q?WtNPPwpv/Hr6uODLMSrQwYbA32Fq7O6y4n5uhdZCg2cglf8F1CNjg0eAYjNj?=
 =?us-ascii?Q?WGsdNfh6g03Xn+Pvrv9uc8ed5XAMVeXDzU9AoML8JOkLOoU/ugvbMXbsnl2L?=
 =?us-ascii?Q?tJLRnXpIwUj4a0s9IHX6zN6LgrMUzWGbnkhYWodb0NuoeLC1qT/g4p/qocZ1?=
 =?us-ascii?Q?A/DkoTNy2Jh6sf9oDvUby+oGO+cSdq0ZuzS99fDxlAshTnUDJwQH4nV0SD0o?=
 =?us-ascii?Q?BnGGhfXKX7291l1ZRkVD9ovmX8WfGcDHOYrU41i+CBe2XTBY8dfOrBdY4hdp?=
 =?us-ascii?Q?OV6i8Aj0XEPMLlFyRB//v/AX9beiohRHBZx3cx+bHA8LdaEiTKa6sn1kPs86?=
 =?us-ascii?Q?28E3aciCanTq55V+p9PIbkW5c+/5geQsIwm/F/0hftZet5IGopV6wVNFQzdd?=
 =?us-ascii?Q?1tY37Dvn8baAqWWXcLCwvXEXV6noS98fTWEeMI/qGn1LAO2S7Rb5DjafO10y?=
 =?us-ascii?Q?ogdcWjfJo5QBdB/GYlZIUm4y7knc410xqxi1jBY7ou6cvSQzeeCRFbgcF3dh?=
 =?us-ascii?Q?H2ovUrtze9Hje2TSiNlaaW45jhgmj+T627hIwCvynWjyiL1vNeo5CXIh8A60?=
 =?us-ascii?Q?GojAjVLhagcqjcr47s5W5zhEl8FCVyx/aSJ1zvYFGy/nyaVWVxWaeVcVtH2O?=
 =?us-ascii?Q?EN04TiA8PT3CyScCg/ZSAJT5OdXTKN913RXTazBmm6EFGP/uMAXU0hGpLMKd?=
 =?us-ascii?Q?PL0vDArs7JPRDunlHN9E5EYfcXD157wW0XNG64Bogy9KtkErRiCFjmOjvCIG?=
 =?us-ascii?Q?KNnLUBDDRPP7XRm6BXRFz0E47HDpg5RvZ/X0wz3ZOBE5rRLbfTQn/ocBmMHg?=
 =?us-ascii?Q?DNEQyhDLWcwRDpRWqyADWL5+SAx0NM4T1DCry8vO/NvzAuvv65LTeKBjCCyx?=
 =?us-ascii?Q?iYmUEJSmiYCy/ZDnx02WEH5Sxl9W3kfhOfubl4ZfSY2vFILrmtx7OY/hOP8l?=
 =?us-ascii?Q?nZ5DCVM2lskGE/y9h75oKgqmZHzvMNwoQWsVnCYydwytu+5cX0Z1TYPjuWU7?=
 =?us-ascii?Q?9GS5y8cxOpt4oBosOVUVi7DpQH4CQ+Y/A7ZXOGfNDor9AcdeA2O7gZTXjXbV?=
 =?us-ascii?Q?SqBITLZRyTBMrw8X5KtwdPRIiadyHH+siO3dsOZ/qNF/0frVF6ihpMZDc/zb?=
 =?us-ascii?Q?oWAMFemLhpbifESZ4Fd6TqWI4eOKd/MW81H4r1hr3+hymNpMhMG15VGAO94X?=
 =?us-ascii?Q?y+WVcTi2rxTkaXPFu8leQJAaX9ir1XfwhKKSomMQv/y35n23MOrgbZJA/pLH?=
 =?us-ascii?Q?MB2Fu4Y/nZETow8k5VMa+LL9Ph/gBwa0HtHEvoD0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35bccb9c-1187-4ce9-4971-08db92f90209
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 01:37:18.1729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2hhQ2VdM8ObE01gQ+VYjfiaYmb7s41sfuV9reT0y9rKDSJEV6umskA/TBnGGcymZ36xZJ/ItS+k9SVpxhKvtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, August 1, 2023 1:51 AM
>=20
> This is called from bus_for_each_dev() and must lock the device before
> calling iommu_group_get().
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
