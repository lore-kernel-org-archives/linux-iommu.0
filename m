Received: from mgamail.intel.com (unknown [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4577B7E;
	Wed,  2 Aug 2023 01:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690940177; x=1722476177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QtOPJCgfZCoNxB0FecG5AomAtN2BkOvW+h/vxq0lJEU=;
  b=i6T+8pt4ede1mjR3UglNNB9WoBK2S7jSExO3Ibv/N9s7L9XbIbietKFF
   o6bdUjL/aNqy7AxR5p5Vvamyir8tYEO3GDUlah9JxOOoMFKpzEUrBukvZ
   dPVlmrH3yopBMzszZPr8LuA++RjmyG0c/i2pZXOl1U2FRT/wAYFoI6zwL
   37DMd+maoVNjQ6GX/Mjh++pihoAZ/567C2077yrUj0Cge736Z/WpZ8xQd
   ankFN9dr3lwN2uIL3cmDzyWpIpEyTZCXzObPxC/pVQ7aUFn7hAdjzhbxr
   yC+4UoYt1w/0rFZJDCxpMLYR0Cf5B5tu7QMys+QZ5MXiZyJkZQDj/AKzy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359493878"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="359493878"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 18:36:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="722682589"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="722682589"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 01 Aug 2023 18:36:16 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 18:36:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 18:36:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 18:36:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mNWVYU6ymAhu2WTdXOFhNJIztW9nEX05jiutClPGQ006lAtotNyYDVNsrMwUccLiqrue1nDcj/foXH2mIFoDe9kntNEQDOWGCdhRD2N3cMnr6xemAhmOhrUmnM9s6F2GbNyZDeQZqVYqcyFlZev2DgxZV26kQAvIxEIitg3TRboKKQlbWNfa37Jju6JioldFQiE3cV1gwVbSU+XhkqIu6mURIOZHOIuXWVI57Y7nGZcZKLW7Z6SrY3NNLA7x0v/8BNgtPkPGwDGmrFnfhFDT97qIwZmkqOV6WZChkTcBD5aXLHZn1Cjxq5EOMmEn7OSincfsY++phxjQCGc4UY8uMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FVmVFk9qKhTgi2fD2+c39/Ouoj+2eOwQK57pYLwUtOE=;
 b=hR3xiC+HY3K2D5MvfmnqrKghgn0AMGDPKeVu3QxLQhMmF9kX9S7Mt9Rbzf+wbpD/YGxbyenmDf3u5DMlrv9lLodI25uWysUtIpYAbXIEcJQ4M2ncczFGxYOi23ztUOjxrL4w9itl6qDxgSFLLIcNXc+Df+9yuzxiO7uOxW6z3ktJGs88teHi61GkYCvF/WVzA/RK/TpxVZwTK9GLcuLNMk6CXLcNeAHU6ONHgvlSC5Q4d4iaR+T0V+L7dXb67MgzXdo+NpRqbzPSissglrZYNTt4o7A5STkifcg5ZMlbIkUTiyfF6bgmKs2QFHOvG0FWSXSRl+rhsiREuhrSlogp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 2 Aug
 2023 01:36:04 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 01:36:03 +0000
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
Subject: RE: [PATCH v2 09/10] iommu: Complete the locking for dev->iommu_group
Thread-Topic: [PATCH v2 09/10] iommu: Complete the locking for
 dev->iommu_group
Thread-Index: AQHZw9eVOGHae5CbrkiBRDxBZ9IMyq/WO6Ew
Date: Wed, 2 Aug 2023 01:36:03 +0000
Message-ID: <BN9PR11MB5276C07FD764BFCCD4537ABF8C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
 <9-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <9-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4648:EE_
x-ms-office365-filtering-correlation-id: 459f2360-9f6e-4bb1-1fc7-08db92f8d59a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /GS8OfUZ9LizOEfVAR5/htjuuav8rPZO2uoSxHcZ6+vD8/Ur3RIloPiHwBP09xbQpmGrZC668IRtwigHWQjoS1VMvvw8Jz5yt7JRWPWkK6LxdWlm+wueN72S9f28Q09Vr5XWVXzfIOvNqh4wZmqHW698WPq3nvsshh+c/ObEmO5yfEJ5O6MqiZAKqGVQ7YLHhsR5zo9uvpHXmEzix1UJ5LZWER9E4iZ8rjBJcB5lEFhPT4BMS+hfWRtFk/Uo7sJCD+JYHY/cUbf0lOlHKsi9F9isjdmimfbeXlSAggeqA5gIKr/BqDqGxJ5XvJkhu0s7UZ57kTKQgd4WMFQNd0HycDE8dpId/omfovDy9V5krj89XH5pyWYCXq+OIMdw6pX9gDMi4o2uCd1wwLA7DdH9zk5rC2XTlP7NsCwAPSN7n43P2+POtaRuZ09j8rIWkSMzAq+0pAG26gFTikL5XRABIJtJBiXSzV7QdhvD6F3V75VfIKCY1YFKruJb49sUk8Yo0TvU3Z14k+qLSsO5e2ayNIwMqbI5oZxopA/o04+sVVaFxz6PT5x8FWORWQBLEPUKhZ8heAj9ndJMN7BdA2TEoxkXXDurb64alH6slER4mfA9rpoxAO09o7t2pS7w2+uoHkGTNB+b8kFxZGKWUILVhQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(86362001)(38070700005)(122000001)(33656002)(82960400001)(921005)(7696005)(41300700001)(55016003)(2906002)(110136005)(54906003)(38100700002)(52536014)(7416002)(5660300002)(76116006)(66446008)(8676002)(71200400001)(8936002)(26005)(186003)(64756008)(478600001)(6506007)(316002)(83380400001)(4326008)(66946007)(66556008)(9686003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LAPzG7f0yORj/+MoyoE6IycejCdF6tvp153UqzvvuiJvZRRq7ZWo7M7cHFK9?=
 =?us-ascii?Q?+Ve8EKilLU065chXn34VGdEYNRa7ikxU7e8nmbL7oTNNjc4uvM20qapZ+oOY?=
 =?us-ascii?Q?V5rml2K73vzWajPYMz8+rI8YZK76vq6zUwJcvmohvw/SRMlJoM1D01b+ODvv?=
 =?us-ascii?Q?9nHolp0wbVGnUoNYpFH+NiF+6lAZOq8dAxw7lrlosUUlejSrkkPBsqLjHnOy?=
 =?us-ascii?Q?apv58WLelZ2WzWiJBk7GwU5MqORa0Ra/EeVxYhc95nhqJIpNQwftgZH+CDh0?=
 =?us-ascii?Q?R9Jv6ocX6H0a0SctBU3RADc6RepI22Pub3Ye4U2YEKEkcTUEEIcSr1DSeU/l?=
 =?us-ascii?Q?FTCnYndPmVK36yUoi22U0QUq+Ca5+U0laZibmNhLDzK2P1d6F0Lwj2iAQH8m?=
 =?us-ascii?Q?RVUVF7DclbGFKNg0z2Fw5WlkfoPZqqOcZR0rlhou9veLhJJVPbrKzIUEpyuB?=
 =?us-ascii?Q?Fd58rfmYgyAqNZ6L1CYleMlqf1D9zoirlicHhzMBpqMlY8C5HpQZMIuphJ6g?=
 =?us-ascii?Q?87W4g72uEs+G+kVpxkO5Rr2ONFK5tftQw92OACvQITehppYpw9IWbg0gDkcn?=
 =?us-ascii?Q?FiomMf9EuLTEkJl07+rZzTRMXGQpeR1mC+aEfj6q0+2gx3qymYxVJ+y/mVvZ?=
 =?us-ascii?Q?GiknJud1pLiKYlpfJnu6Igj+P2HtC939ZMEuZaBl0pI/a7/MnaZ5Eu/1Biyb?=
 =?us-ascii?Q?/huKLzqYfgV7qu5fQpqdpCMfhjLqDriDr0xRSDlGpDFnZ7onSjVldbQtyVbK?=
 =?us-ascii?Q?0ZN4nhqmlFugM4QWiiVhPiGOLJHvE2+v4YZyR+uWuHD2lPNoNFV7/+11PzD6?=
 =?us-ascii?Q?MvkzVxyerD0Q2IbsJiwlowaXgG/kbJL6Yuq0NUrBJssRlAli0nd4omu4Pg5O?=
 =?us-ascii?Q?878NUpbjlLLInnCenumeYTx6fXX9gF6/CjkHVF4gWWrJU9RBm0BDb4h4AT0q?=
 =?us-ascii?Q?jIIcu83OtA2DK5Nj9xDcbVNXr+PuPbEK7eh2JIQI8XuDJ5Mdn2B4Cz1i3pXg?=
 =?us-ascii?Q?r/gphFeLIU+ERX4UerN/JHhqgdulpeuzzV5cJGOJFL+VZIC6N0T9Ceb/VVB8?=
 =?us-ascii?Q?6QrBcFtbuPTXY9MQyYo1F0hnRCnx0Y/mujbsQP4uDBRfDDPiZoNM+Vfdbhsa?=
 =?us-ascii?Q?XlBGdDljp3rkwtwTWIq7nFqGlLuFw4LZQlP83cBH9QN9tSA2O5Er3LKB5L7M?=
 =?us-ascii?Q?Z6mKJISeXoVPxFDdRkyan42j8Dz5s98ytyX68ry07CisCc0acPRZHMLGuWi2?=
 =?us-ascii?Q?rv6KVJHWspbHAgtjAgX0yVCFacfvPRMOvCKQed6Lpb9Sn9xkUNk3SXfpLzdH?=
 =?us-ascii?Q?32cbLMKLTwpbJQnoi0d5AGZ6Za4ed/3YE64hJSwDPQtjaZ7WE+Jn5qJeLJic?=
 =?us-ascii?Q?ePFdEDX/4is22o6UCeIvC7rsTMV0n/6ZNaSC7ENqKBYHn51GHNhMPB8libjQ?=
 =?us-ascii?Q?3PMdEJQvdKnsquLTsP2RBZzpvksMHcO5blxVR4BTAg7guUBtD/ISSwAR32lo?=
 =?us-ascii?Q?GutP/o8Gdvl1mFdFYotRbA/eWC1aakrkIM4ULIDo7a3prev4r8ccWqxYb4N2?=
 =?us-ascii?Q?NUPvNP4XaUcxs5ZQ9EXkOXYh+HLvXrQ5SZqGt1e8?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 459f2360-9f6e-4bb1-1fc7-08db92f8d59a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 01:36:03.5789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jbST5OZr2YcT3OVm1yCekIFQMEakrJA/abO7NRM+6D9VdBPiF+F4vgpwG5/OBp2dX6cyvjcsrt04GCNlmseoog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, August 1, 2023 1:51 AM
>=20
> Revise the locking for dev->iommu_group so that it has three safe ways to
> access it:
>=20
>  - It is read by a probe'd device driver. So long as a device driver is
>    probed the dev->iommu_group will be guaranteed stable without further
>    locking.
>=20
>  - Read under the device_lock(), this primarily protects against
>    parallel probe of the same device, and parallel probe/remove
>=20
>  - Read/Write under the global dev_iommu_group_lock. This is used during
>    probe time discovery of groups. Device drivers will scan unlocked
>    portions of the device tree to locate an already existing group. These
>    scans can access the dev->iommu_group under the global lock to single
>    thread determining and installing the group. This ensures that groups
>    are reliably formed.
>=20
> Narrow the scope of the global dev_iommu_group_lock to be only during the
> dev->iommu_group setup, and not for the entire probing.
>=20
> Prior patches removed the various races inherent to the probe process by
> consolidating all the work under the group->mutex. In this configuration
> it is fine if two devices race to the group_device step of a new
> iommu_group, the group->mutex locking will ensure the group_device and
> domain setup part remains properly ordered.
>=20
> Add the missing locking on the remove paths. For iommu_deinit_device() it
> is necessary to hold the dev_iommu_group_lock due to possible races durin=
g
> probe error unwind.
>=20
> Fully lock the iommu_group_add/remove_device() path so we can use
> lockdep
> assertions. Other than lockdep this is redundant, VFIO no-iommu doesn't
> use group clustering.
>=20
> For iommu_release_device() it is redundant, as we expect no external
> references to the struct device by this point, but it is harmless so
> add the missing lock to allow lockdep assertions to work.
>=20
> This resolves the remarks of the comment in __iommu_probe_device().
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
