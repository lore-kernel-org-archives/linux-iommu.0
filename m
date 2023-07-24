Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FBDDA35;
	Mon, 24 Jul 2023 02:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690164708; x=1721700708;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0az+wd1nPjdfqRZ3TKl4vvXhgw56frkpzHox2IlzmmE=;
  b=ccWEsCbj+svU60Huzz9hvQLj5u6WuPVYL3+uEk2Zj9J8YynN1jw0sjWW
   cmNOYSdxghKwPL+b6nkuu53wErxkC723s3YAMcJMYXLOvVLS0wbjq6asP
   RPj1lB/vR08kfggAsjaKEdq75B1YczveIL72zMq2HEhTsAniLyKZ4C8dh
   1s7rwb3hhiqpu2dlDa/fJ3K/E3FOA0b8rnXmHsGTIYlUDSTUZEaM24dAw
   LIIOw1+5HEfSX7ASbWmRy3DKAaYaN5yffePTtVomuCI4WN1mm/0S4Gb5X
   cDjyqg11/wwY5wbEDkrb8YhSFfs9i/1tD6haPIkEclPW9M0P0C1bGrink
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="370001999"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="370001999"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 19:11:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="972092627"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="972092627"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jul 2023 19:11:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 19:11:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 23 Jul 2023 19:11:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 23 Jul 2023 19:11:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOUZ3OOZXZtr9dS6+w36ZqQKyX9hnSwwk6LgpQOukcI4Py4voIBFKGiDxsoi+b7+smV7Kro2hoEsk/NQLZDo64FiWpigMa+yajS0pX2QZSXoL9XodMNwanctLqLFJ9MWrvd17Li6J1gT6c+ih0Y/6iTWU0gLR44X5ez6SpY1EUJA60C3N5reiz+ZiZJhTaFN8s3HSCPWV2BnXQ0vBofMMOs0AQQoe/DIC7Vv6ds/trI7zeSA42ON67ZqxP4Gt/pEZlEemezzrZJsD+kZcQbG60gsSZC65/ck2UMpKyeM3Bo5aMHhG5Zr37P3oH0ACtcQtAwimpLq2PcmLFktAke5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dAJxYnIFWZcaSOSYgRQ1II5ZSiKMa8s1nlxR1KONXgM=;
 b=IBJX6w4v9F4vptf84wS3eJqHmkJV0FxIRWbT9VhLWtrhfEbM1L/YWFB0S1+0nDI5g+Vh818o3v/pd2IFB2uFKkhYnn5iIcrjHtL4DqgFNsdDr2BsPgEsCL1UBh/P6rdrVg+18IEa5TGtbO9gocyMyiqki7IQgCrq4ekXQr9mFFPamqnXUkf/eJK7zC+8EOAKCUpjEs7bvSo5H4J/wb1YFmQl04ua1zxLFUG2kc1/T3PtK6gInriPPyQ2w8ldJvLX9+aPQ3Fs6c3U9pttNn2mFm9sn73s4mHyr0x2TKGA8fWLdbOFio+vC3UkgKBFH3zWsU3TmZuZMNkSsViXBVdwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW4PR11MB8267.namprd11.prod.outlook.com (2603:10b6:303:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.23; Mon, 24 Jul
 2023 02:11:44 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::137b:ec82:a88c:8159]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::137b:ec82:a88c:8159%4]) with mapi id 15.20.6609.026; Mon, 24 Jul 2023
 02:11:44 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Baolin Wang <baolin.wang@linux.alibaba.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, David Woodhouse <dwmw2@infradead.org>, "Heiko
 Stuebner" <heiko@sntech.de>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Jernej Skrabec <jernej.skrabec@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, Orson Zhai <orsonzhai@gmail.com>, Robin Murphy
	<robin.murphy@arm.com>, Samuel Holland <samuel@sholland.org>, Chen-Yu Tsai
	<wens@csie.org>, Will Deacon <will@kernel.org>, Chunyan Zhang
	<zhang.lyra@gmail.com>, Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH 01/10] iommu: Remove useless group refcounting
Thread-Topic: [PATCH 01/10] iommu: Remove useless group refcounting
Thread-Index: AQHZuar/8ffxdhgup0+jp6oCKhjoRa/D0M0AgABSGoCABBHlUA==
Date: Mon, 24 Jul 2023 02:11:44 +0000
Message-ID: <BN9PR11MB527621E6E7D464982B8730118C02A@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <1-v1-3c8177327a47+256-iommu_group_locking_jgg@nvidia.com>
 <BN9PR11MB5276130E7AE8B0BEA43FCC6C8C3FA@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZLpzqVAxxLGJp+L4@nvidia.com>
In-Reply-To: <ZLpzqVAxxLGJp+L4@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW4PR11MB8267:EE_
x-ms-office365-filtering-correlation-id: 6a4af6c7-50ea-49ee-b7a4-08db8beb53b6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Yc4/BbdM3uuZN/CQWbB/MCjlnR1lwcP1luEkfpyMuC4b95Lg9y+vcSUg1ZkUPuEh490m8S1o6cUaKCHs7c1AiS32AaxWTZNr4uRYeFpR7bNjgj2HvoGnezGprL5KfjQz3BA3sPyVPW3jvtH3b1jY/SphogPmGpuauFZFGL/jhhlQnz8z/a2Fw5E27PkiyQWm8w7G5woNlco0v0zGvMghbHz1rm47h6ySX4H0zYTEyC1oHjrb6l9NwTUG88dmqqBIMqh7mIxPMAx3pC7L5hniKvGYjiSfhS7S16Adx3cQXMvOblCcQvXuuJHxpoyruAOR3oZ83O0850oUkTdAYnD+kMuVkYOurViGcm0aqgDE0L0LNp+oIV02TTT7zW44xgoIMKLVw3CFsqwaagtZBIidEb4g7rX1vsP418r9mUqBugYHl653+YV08kGI+z6DeMd3b4KQ0/K6cskz+0W/dhozyiHGElUbTHgmYLs9UMJLtn462LPajbjPhncu7qPBZdRbD0JA9x/GfEis6DOocZtJHJhIDm0rB/zDw3ues6Hxn7HKKEjBLeekjjQWJt0nFQouTjqZlNeYDf/IDol70Uen7aznPoHa9LU3TMgp3bWItFYL7J2xhEm4EQWyn1oWHmCH
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(136003)(366004)(346002)(451199021)(4744005)(2906002)(7416002)(52536014)(66946007)(8936002)(8676002)(66556008)(6916009)(4326008)(122000001)(41300700001)(316002)(66446008)(478600001)(5660300002)(64756008)(66476007)(26005)(6506007)(7696005)(186003)(76116006)(54906003)(71200400001)(83380400001)(33656002)(9686003)(82960400001)(38070700005)(86362001)(38100700002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?rE3rX/dW3JhM/iBjUWv1SHN2/WmPdTJ96wxUZbCOfmfteOy4q0Ohm/BKk5V9?=
 =?us-ascii?Q?6RE9RD/g+SA11ot9VOxD8/ExVu1gSJs/WVOgjhHiPx9d8mSG2JB/CVzuQ6HP?=
 =?us-ascii?Q?5mY3vDf2YlncHSn6RqT0Kbfs9iRw5hxGfGMC5+G+O9nWF6Cie0lyZ7khD8vg?=
 =?us-ascii?Q?MsN1lc/Ma0uUXNgBEOIg1iOrM5H5U5LyLs3+IVrB1hJ55Eou5qsGp/zF6ofR?=
 =?us-ascii?Q?e9eNN4ajkHknhfHfB+mGPvC/pWwLuAly35E0Lln6ayLpYfpXBOA8VXkNGA18?=
 =?us-ascii?Q?tW30SzcZeUP5Rq7MwhreSkrvNbGYOuug1PnxAbJlKdVD+O57yoriKNvqETrR?=
 =?us-ascii?Q?U3RocIhWWSvBy01oHuSPhYc3noq7yDZ3e9sOGh117Ev2aNi6vzsgfcc5tnmi?=
 =?us-ascii?Q?oV1r9amnyP3TgYBQONJzFMsZwD1ryyN3g9vSee9KJ8WDlRxuuWcOKzB5eG79?=
 =?us-ascii?Q?tStfu/SLv7F5hm2THWQW7l05/ebzfYzmNVijSgnTZWW9nwSDUrsZmKPAH+mz?=
 =?us-ascii?Q?c0IVq2sZLVJhQDaYZLydPg9AJMH7re0ZuWurzBEC/jQqixVTaNFu/haH1zpR?=
 =?us-ascii?Q?pyRtKQjJa77cUDjXrw0/xG7CikHvax5kbWVxFPPJd7eZ4vXYx4yCf8MhDKam?=
 =?us-ascii?Q?t3OUCseiOSBma0uVOxXFwg2Z4sCw4ji8QpCE8h/CaWllp7n6UwfdIMJAZRdx?=
 =?us-ascii?Q?m7ZCcqKaY+ZGoVysfN5+ffXrS1k/ym70x9c12tbtpG7YZ92Srx62cHEZ9hTi?=
 =?us-ascii?Q?2UVCKkEWDV2bxbzWRF04GlhD9NX10g1mlCZUf2qW8K9SEzw3V55O6Pr+BBco?=
 =?us-ascii?Q?fltvEDu9MUvai5PY9GBhzbo2teaue7HQN5blxK+FfqBNuiwrtqDQPNMstUl7?=
 =?us-ascii?Q?5BZN8sqNr7rDzHsKSYxOTLShKdpRDYIgLTdrsnSbSc6IIpRG4V4sA7N15CTI?=
 =?us-ascii?Q?TQXm1/o9BNfT1NRLusiyoPqLc02QaJrgOp9hb7wm/DMhSLYOzPhPb5nnjuV/?=
 =?us-ascii?Q?muLWSU5ayL2KRfESJzeDTgn0vvzLRNWTabRJkPJzBEeEn/5/VNjvUqfVK4Ie?=
 =?us-ascii?Q?z8C0xYX9mEh61nt1P1PJ+kN2a2D18hOLk8IaCCuQj+4QV6Br66jNGw7p10Ij?=
 =?us-ascii?Q?OtQx9o4+TUyCxXYPqgbz7F9cqnCPexoIk+RsuDOQpYalMysh//Vk8Dg+aLL1?=
 =?us-ascii?Q?mHtKAAMIKGN52KQHXAR+/e0UucZ7Y32QZiQbpcHl+q00ub4vkgPgvL/nP96q?=
 =?us-ascii?Q?mMBPTybgOOGd/lsgMhrhiGuhZtmzVAyBj9SruSq7M8fPglt/W9Fv/b5cDlW7?=
 =?us-ascii?Q?zVYDYTEw7MjS7BgOIAno9KS9/kmn2Du/Gt5NvZoSp2xkZ+RK/4Gw8fDcGK9s?=
 =?us-ascii?Q?IjK3tnK7ZOoYOaLknhd1RYvf5vqHS6czlJIRXPAaCqvmUTcMHjJjY50S9EdS?=
 =?us-ascii?Q?QaTVReA2lTU/cDyyfWx43DC5p5uhBWiBmzpTMh8kbjGXI1Az17z/XoPi5dN3?=
 =?us-ascii?Q?LrjscKt11D/MPMaT2WwebMhEbmg/GAkxrTRSMfmPmMuZCA/0692MCY6XTSj7?=
 =?us-ascii?Q?2BE9HKYLU7XcqcSfCHv4yuIpk1mfgCCIU0twSBFn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a4af6c7-50ea-49ee-b7a4-08db8beb53b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 02:11:44.0745
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VeT7uuhoGPHlF9mIWmhggwRtVBmtXIX5ybdNi2PyLcGLcVdPPFhyzPUiQ6kygfBcsoYEopFPU7wKqr8mdQli6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8267
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Friday, July 21, 2023 8:02 PM
>=20
> On Fri, Jul 21, 2023 at 07:10:57AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Wednesday, July 19, 2023 3:06 AM
> > >
> > >  int iommu_device_use_default_domain(struct device *dev)
> > >  {
> > > -	struct iommu_group *group =3D iommu_group_get(dev);
> > > +	/* Caller must be a probed driver on dev */
> > > +	struct iommu_group *group =3D dev->iommu_group;
> > >  	int ret =3D 0;
> >
> > this is called in the probing path by .dma_configure().
> >
> > the driver hasn't been probed yet hence the rationale to not
> > refcount is due to device_lock() instead?
>=20
> At this point the driver core has partially attached/detached a driver
> so I'm considering it part of the probed driver explanation.
>=20
> Really during anything protected by the driver core probe path is
> assured that the group cannot change.
>=20

Probably this worths a slightly different comment then?
