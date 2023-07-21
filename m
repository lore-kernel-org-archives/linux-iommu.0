Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E255320E4;
	Fri, 21 Jul 2023 07:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689924035; x=1721460035;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5G0AYsq6p3xg73pbEOhKZ78RP6CCmhLrU4h4nf/5GcA=;
  b=g25vw4r8JPTaT3/CCvyR2vy7UE+I55XKHsLwo2ffYG8Oga4yMVIbP9U2
   AC40/fPIOs39Sez/g6EbN1JTRYHN1Q8m3VxkNVEVvh2zODuV/1/EpWH4Z
   k1XXKdjDMsvuKEs8LHJ1Ic87yTVusrEkUE4xnNgjz5huYwKaXqOngDtJa
   bLVnMV9lxMjKnEXjChp71uRPEFZ1IYFuG9rR6AfaE/8YwNYPnWr98fjP8
   4XjmQr8/BBoEM4XuV/R+DGjV+TghJlMjC8FQanAAqcz/5QT1gXuN5nW5n
   t8K8HUKkKchOKa42vMsXDel8+E0xU88wLRwJ9U9PbxQKkTbikIxxxaSuQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="346549888"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="346549888"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 00:20:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="759856094"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="759856094"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2023 00:20:23 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 00:20:23 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 00:20:23 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 00:20:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mWXFfa/Pm0RO7l7hz8v9X2Nwf2dlQPVuPXCSnYKNxU8JSv3yDWS3/SHnuXzE3vsgui789CYsv+EjkGLDDF3N0klTSZyHdpZOfyx29iqqioaanaOg2IgfwwiMRkd6hYkOQSqQQKOyLWKXgK8+XKX2nIo4D3t7sQrHPqTqmKCLs7BcVd0o+MSL+jMFCYRCuITZQ138bFmM22hAbeOTmW0Y7QNwXIyCX4aG7mE2OktOfbdED6bo/RUlWGA/VySh2lbWwvJRkTIHm7dwAXoko8c0ZYNqEkhvp8Hmeaz5g5V+LymkbKE/DfLM5PcSQgd+IUje5CmBgDYHgi+DL5WOSYAEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GT4gnAFDDVCN/QjFBrUCw1nQWkqcc5mtOFWKgH/7IQs=;
 b=nymeLyN0jPRANvv3vSUQ1MDJmXr4cpM6/M4MMatpnyy6dwp3c0MwPhnPcgO/n8Vo5/dPt1ALTZcG6cqR1W6zsa7pHwYCz1JhykQSe4ZLMyPeZbd9wwbEe2GMP5wLkzwzo75dS/WCNGe4yx2YYd1KUaqczgRfdMJNbNq7Yok3fBg3lXz7gbigUU2XXtTwHpq+SYEbaIST7qbLC/Sv3WOfWYsDUTdBN4dOvGOKAcOtQIi74CbTjXh0iRZfyGTBJqJZfg3f1DfLmtxWGmdMO1HAxhvwTr//mdN5cqpCulO+MXqae/PHoT3sM1GEN8EaH51dpfeSn6SuG0k2CReO+O1T0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY1PR11MB8125.namprd11.prod.outlook.com (2603:10b6:a03:528::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Fri, 21 Jul
 2023 07:20:21 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::137b:ec82:a88c:8159]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::137b:ec82:a88c:8159%4]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 07:20:21 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Baolin Wang
	<baolin.wang@linux.alibaba.com>, Lu Baolu <baolu.lu@linux.intel.com>, "David
 Woodhouse" <dwmw2@infradead.org>, Heiko Stuebner <heiko@sntech.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, Orson Zhai <orsonzhai@gmail.com>, Robin Murphy
	<robin.murphy@arm.com>, Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai
	<wens@csie.org>, Will Deacon <will@kernel.org>, Chunyan Zhang
	<zhang.lyra@gmail.com>
CC: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH 07/10] iommu/ipmmu-vmsa: Convert to
 generic_single_device_group()
Thread-Topic: [PATCH 07/10] iommu/ipmmu-vmsa: Convert to
 generic_single_device_group()
Thread-Index: AQHZuar0x7YypMrhlkqbyXjFrIp/gq/D06Zw
Date: Fri, 21 Jul 2023 07:20:21 +0000
Message-ID: <BN9PR11MB52761FF5AA9D8A24C30A12CA8C3FA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <7-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <7-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|BY1PR11MB8125:EE_
x-ms-office365-filtering-correlation-id: 770f10a0-3de9-478e-3208-08db89baf186
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hzA30ubbRHkEzfP5OFqwY7AUZMsw5d1vuQEc0FxeNV/Jxn+A8k8j7jOhY/QlQ1xbSfAokn3has1yjq+mXPb4oGwjc762qMVatUB0x7Rughb+shjyljDFhHilknNpMIGl3Jo8DUbXEZJuK7nfbPALbv1qMaDC/lkoSgQMBoQ++cmg7QRnV0K3bgfwAOyO4L2qMrEAY0sWvYcsYJS6nIWpCkQMGwimoXCxZpfYjs7GI50hug796yCiybcvAp9SAhUbhOXDBanMuUq8EDO1uImz/J+xI9ZFlA2s0vHQQ0956hlcg4tpwGi4IhC2TLzUnRqNF6cJkVYGTgsuPgfhnot+lUeAYq7RvedRJpXjgK4MMHAATkz4+f/MM515ZhNa7n4a4nY82CqhuPG04c2IiKNuTWpPa9Co1h3dzRaQdJwhNFhpCcR76Qi4RQ1PhQQLJng0LDS9eFqceupJWZ7nukpH1JYelku4OpW8rJBTmHMHJFKYGtQOzhJvbML/D2pmh5ni7UcfZ1L8tThe/h53IsI+M3BnQUDWZjqy1Sqq9JPONqwzPrXXyRK3pKtwCgwr4+1N/QO3Bao8duPki9R7fM6buZ4MOSUanCS7NA+R28ewBALdQNZCuQePc6BV1jNgT5Cx/tCfiejUgC0U8yAQIXDaBgbaaQsjSrKhoJEmnvck/uA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(346002)(39860400002)(376002)(136003)(451199021)(2906002)(7696005)(71200400001)(110136005)(478600001)(55016003)(26005)(9686003)(38100700002)(186003)(6506007)(76116006)(66476007)(5660300002)(66556008)(4326008)(66946007)(8676002)(7416002)(316002)(64756008)(921005)(122000001)(52536014)(8936002)(66446008)(41300700001)(82960400001)(4744005)(38070700005)(86362001)(33656002)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Aezsv0w6Vfiq5DOFrzj5dt7K3qNUkGS85IhDDSaCjzR1gL57THcIY7S6wSnn?=
 =?us-ascii?Q?RTW+FfLsaGH1KNZmgE7yXeGLrbEeLhtTtzgCA3Maneij2rwO0/VqfS6bt2RW?=
 =?us-ascii?Q?rMWjAx5+/6AbdhsqHwdc6Ks36ARVH+iCCkGvsLoIbSm+MIZPDoJYHaVjaM9v?=
 =?us-ascii?Q?QFxCSHbBY8GZVQBZfSED7Ebp6P7nNl/mSUKHTN5qeaoHZpolh8/O6/hBnjZG?=
 =?us-ascii?Q?wQpJHLSpd3tb8eF+OvABlgJYEPueBRY7pl19jtMih+jp0By1qV5Ndgps1Laa?=
 =?us-ascii?Q?WeoaEswO6MbHrjbFk0/lqYin6x5Fw8YbNrXQINI2dROt3EQywOkghEGYGydp?=
 =?us-ascii?Q?o7cRBQn3mI4WQ+eH058QtGmPeRMu48RPFrqpjKHuaAXhlEdA/HKsqN8ZCXFj?=
 =?us-ascii?Q?ufSeikFgVkKTdfAmGa+aguVusjVpbubYrNXfMmpEtk5/3M8tbbKTCWiQuNk6?=
 =?us-ascii?Q?UU9+In8ZpUVawljyK80EnJPoVcU6m8vyCrXNhJ4HXZ7oqZNBjltzfnirleuS?=
 =?us-ascii?Q?14yN0pI+3gyPLFuevgVlrvgbuPtNJCZt5oK8ytDpWi1e/O9BSEBgZ7QJhRKt?=
 =?us-ascii?Q?ItR7yxDPKRGNwjOhRbwtd44GqclKZUsKHSuGubINN5OzFxUMej7C8ALoek/t?=
 =?us-ascii?Q?rbw4rGxEKd5jDCbL/iWG9/WnFDgiNzaGG8CTDRY3p+GLFQmRpuwj5xXUE0hr?=
 =?us-ascii?Q?yBnjzhDPec5NPUmR7pXUSEwSDgSNYS+6JHLl6mg6iRf0FS6YhbIse3Unp9c4?=
 =?us-ascii?Q?5NfBOdxAdmKhkg5Ra5M5r4Ss50IzQdM0oUn6G3yqRmeDD8Rt5ELx7EjJaX7c?=
 =?us-ascii?Q?iJkJWIt9P/pFiSUiPML28mdXxAouPreT/AjXVDpUbgqdaXpZcX+6KLo9GHrF?=
 =?us-ascii?Q?DUtA3GsHg+AKf8BFi2mYW2UjDbv1+qZ/xD4lxhesDSX+nB9UcDLsEXonRySn?=
 =?us-ascii?Q?nFd73rxxJVg2N13aK0+khBYrel2/qt1xq6A7Kuibu2w/XONqAwQHmc0YUZQn?=
 =?us-ascii?Q?rW1G8xPa0o7UXZeMTamu+pFwg6PaFMgmxIA1G89FmqBRaqkCgJ7YeZGlN+o6?=
 =?us-ascii?Q?JqUCF5x8GYPF6W+SXvOHdDW8tqdg7zL7ywNnacR0/2HFyjqjAJIT/v1Z257N?=
 =?us-ascii?Q?BlGK+2sNX7rU2HHpX6lzjbaIOZJCnAVRhcU53rAl3mewwbEmLhhru36MV0c2?=
 =?us-ascii?Q?n8qod9aA6RF2y4G7KBukNsWlKsDsFWlewoHSb1qCNJI+22cg/24F1Fcq85W1?=
 =?us-ascii?Q?lZLaP7CGnj9sCLK3qzl+wn80cRUZqjmUCbhJqesIQ0IwrjvG7Rv4xBMLl0nS?=
 =?us-ascii?Q?HnNMYS6rqSYsJug/UWkGUsmthQUTYTR12vTv9WAJMCUIEdpA1RFZzcYVsdkD?=
 =?us-ascii?Q?pBJryvmRg03bt43DI+4XuYfEupMrN2BQENI+OoqqX3O7wDkOpoV3dVRRfO1m?=
 =?us-ascii?Q?2f6TubEo5+PfNER3MstYHGS2CocO9paY1w0ZIuRKR+ofg7/YQo474iGChpLH?=
 =?us-ascii?Q?1PoDgqLJY9q7IqOLAiu1ZBxeu99O2sgk3405hdUHKQo06ENKRMRAK8g++AmT?=
 =?us-ascii?Q?NuY7ASJfTpRRxhSRhPpAJ+qaMHXmCnhwaT349+gd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 770f10a0-3de9-478e-3208-08db89baf186
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2023 07:20:21.1489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZcFkb9KgsPVjQb7EsolEN1bZs8hV1sbVeNTd0oMaE5LRacfabLREzPpbt+g4+aLR9KRbvi45fJd7bpJhmUhA9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8125
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, July 19, 2023 3:06 AM
>=20
> -static struct iommu_group *ipmmu_find_group(struct device *dev)
> -{
> -	struct ipmmu_vmsa_device *mmu =3D to_ipmmu(dev);
> -	struct iommu_group *group;
> -
> -	if (mmu->group)
> -		return iommu_group_ref_get(mmu->group);
> -
> -	group =3D iommu_group_alloc();
> -	if (!IS_ERR(group))
> -		mmu->group =3D group;
> -
> -	return group;
> -}

Looks existing code has a leak w/o freeing the group in ipmmu_remove().

While at it could you add a patch to fix it allowing backport and then this
patch to convert to the generic helper?
