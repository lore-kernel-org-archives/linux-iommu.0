Received: from mgamail.intel.com (unknown [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9247E;
	Wed,  2 Aug 2023 01:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690940088; x=1722476088;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YDZHm3wzcoIKcyfCNUiRjXTVUuR8emXBIacergSH4BY=;
  b=Dyy8EyzvJLjGsHL98SPNe4Ko0ShR6pkbTUoe5909WndCyXplCyRy/IbY
   fV5HcFD+micxERXoe325he99Y+PFT5wuDj3VI1jhUh1iA4e+SfkMGneee
   5ifDupePaZkALEWqQNwXYCUCe5MBckaomd1kwYr5Niczx0eBNTtmZs/l7
   yAkdNy5iFSblrzDmTb0AauKm6h+Er1RgTEC4EZKACr/Oxc4ZHbAE4VfXN
   4mPnoprw9H8oaRFdQ/aqVNTmwLGZckSc1wBzJ9IwBWP8xZ4P82m/235Nw
   HBhpt+KHdEOhk8lGUVYVWi3sbCgqo8D3YWzyQdF4RhkNXIB4ANTif4r5o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359493078"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="359493078"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 18:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="818995192"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="818995192"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 01 Aug 2023 18:34:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 18:34:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 18:34:41 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 18:34:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KchnUCPUgwIZ9p29kbctqziLlMMymmsZYhcC9Dzw6kiqQJ3psgAGmMwtOVlPiIO0tERjTb+l0kcZ8s8aeD+UfCf45QnyMtFwE7av8fb2pl5X9eREhrh7M9rNbDtJqdWvf2hSz43Heg0FrgRCl5kobR8q+1qXiE4rYfjMlLEi8RMfo4OwLfICP3gNdq06Jj1HH0CTfSQUC2NL/mndZk3YgWxgsblZDQ2YCEUsbOMZKIkABXvnKl64O8gEQe2lmOF/vFhG6OMmQFSbl7nE6/GvzgYEvOusjcqbhqVXcBV87rmTa4Rh6exsHN/ntxIYqLscS4t9cbu7aCj1516wq/anvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YDZHm3wzcoIKcyfCNUiRjXTVUuR8emXBIacergSH4BY=;
 b=nRpziOJAntiaW5Vxbhc1t0P2Rrez9JSbFkX++jpQ+oqmQ4Xn4+b6wku42JNqhzDk9sS1iNJRlkBw/smQZaCNFw9VwU1rZdAy/2/MrM4hSqoDmQIMU/HRFw5r/XHGVgrDaUVLFkPF0V9ImoR/2OvabR6f+05+hefZ5xqzVcC8jwnsDuJF7TXer6UqAdLSsycYmAT4GTwmzMKsiovodWtEXTQK+X4clOM4kWrGtHzT140AKCT4Md9sqyy5xR+Q2FH7oyGK4ncK9whZqiP060b3788mEHNDHPBeIr9dD3DWMUTblB646DUNJYSIenevYkT96C7c0xyvg1z75ySPb1RUkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MN2PR11MB4648.namprd11.prod.outlook.com (2603:10b6:208:26f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Wed, 2 Aug
 2023 01:34:39 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::dcf3:7bac:d274:7bed%4]) with mapi id 15.20.6631.045; Wed, 2 Aug 2023
 01:34:39 +0000
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
Subject: RE: [PATCH v2 02/10] iommu: Add a lockdep assertion for remaining
 dev->iommu_group reads
Thread-Topic: [PATCH v2 02/10] iommu: Add a lockdep assertion for remaining
 dev->iommu_group reads
Thread-Index: AQHZw9eSX/INCQC8GUKZQqS77WF8WK/WOzyw
Date: Wed, 2 Aug 2023 01:34:38 +0000
Message-ID: <BN9PR11MB5276393B475A573E70A4AB768C0BA@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
 <2-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
In-Reply-To: <2-v2-b0417f84403e+11f-iommu_group_locking_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MN2PR11MB4648:EE_
x-ms-office365-filtering-correlation-id: b5a2f597-875e-46d5-4c52-08db92f8a322
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3G8if9RhSUUYDms+4N6I6/lBWXNBJXbiuaihYp1X1WrCJxfSDSpp6tLrE71f0ciIFDNDOX1ij6Qe2N+YFNHaLPKFzIAkssm2XPqKQXnMBtd4K8oXwR0JsbEUYRlOr0GOHIeCL/MJEDzBvbltqVXYBhusOFuvPt4vW4n7rFk5sT/fpl/y9DPjRrTc3xLX5mClWyuzRTLRZvtH0zf+XY8pzephZI6O+WjzJEE9Swdi2HmAOezhy5fxgQssbShVyLqNgU6glCZRGnYdqOVSsAAiPbgWrUpFCrYqcZ9rVU5aRWjWEbaxECTp7Mmv8IQ502DWT8ARDiZFPebzt0qVWkviLAPW1PQ8jG5u0mxxYDsRmFdsHI6VTcWLJBV2ObbZzsoGqAguQPVTLR7tUKNs8BI8B2V/yzr02v8Xy8Qjba90q+bzaUBZ14BemhD3PzQ6hlqrXBXI0BqMoDQLkLYyX3bP3MaQ3K+augUwUZ9giCvRNFARwoaTB5nrtWJpFWuDf4zz/Z4pEd+e3xBqOtDN/0UWKtiahca8b1UZEmZQmAW0ajNrG/rJtG8YdZl4EhgELbMtUQbEG2zfnZfM8JHbxy6T6pG7YKjnIu+UDLRcrzK+xe95ZpnEPwrzrzzs2ERT1mQQ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(396003)(376002)(366004)(39860400002)(451199021)(86362001)(38070700005)(122000001)(33656002)(82960400001)(921005)(7696005)(41300700001)(55016003)(2906002)(4744005)(110136005)(54906003)(38100700002)(52536014)(7416002)(5660300002)(76116006)(66446008)(8676002)(71200400001)(8936002)(26005)(186003)(64756008)(478600001)(6506007)(316002)(83380400001)(4326008)(66946007)(66556008)(9686003)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3m7mDF35kNTQS20YSF2ZaQSAVreDydnOyVVSycT3V/jES1lE5AATy/T9tads?=
 =?us-ascii?Q?s/zP0EUgTvMFq5QtpuSo+Aoxf2kLbYyKQalhDTwhGJIfLtkyXb52OtoSoR5V?=
 =?us-ascii?Q?wyRfD9qruDany2RMNWr7WfHILt5kfT1+fHAe26fuVw930gNsBMd7L5CIZGGl?=
 =?us-ascii?Q?nfvU1S15LTCEXKBRolMVzBTaAxSCTmhbLp+uUqHC8OIDWUWG+9szw0U+aV0H?=
 =?us-ascii?Q?lbMGuItLJiAJGFdPDy+8l/zo65+eV1VpNfpP6vD1iHXwamn3VshTpgjuUw0U?=
 =?us-ascii?Q?ifw3WDqC5t7Sh7TdU48TV6TE2Gs4v7CN7U7xAZmlfyno8degxQx8XdE7B6Np?=
 =?us-ascii?Q?s8D9XYMUqISZdY1G9uOqphHFQo2FDTv9nzaitUaMG9Ew1L4xcF+X1SeRWuSk?=
 =?us-ascii?Q?Ay8tmgxAoH7YV7wwVAlT3Zh907cRH38OvUf01z/YevpDfW+d65xl7esVsWLA?=
 =?us-ascii?Q?rkAJg5l9oX20VUKqF421ZbuPAeF1c1Zxi3+0H8mY4va1YGvm5uVG6pR7J/Tj?=
 =?us-ascii?Q?qcWT35uMAjuTV40l3dfDeAiqTFklnMRBC8fJ4zJvW31thYeM6BjSeXE1REwB?=
 =?us-ascii?Q?pKBnXc8zYiLSsYWnhazzhO5ioNWRTz/o1A4tO0zsfFhMNa8InAVfX71cbbto?=
 =?us-ascii?Q?2OnD4dAkGO+5+OixUdTpQgxwrrnkQCSVcEkC2B1BEbsq8ZbIo2qpbItFpox6?=
 =?us-ascii?Q?Kp8aE701AWbZHYSSpm1nwJngUAIbZNI5D7ZFTpmsYaZWVH9wKoNmziAnavrH?=
 =?us-ascii?Q?BwB4EKOnqqrj4nvjigz2+SYi4X0899vD3VDRWzocVG/nBT/m1vspJownf4dC?=
 =?us-ascii?Q?6v4P7/eNUJ2q8N7F9++p6yyqQg1bIP0fBg3QsxjqREgH6Bi1N5AO6L8DGk9P?=
 =?us-ascii?Q?4e7A8w2t5X6aUak1VFAXpWgNEQ88o4RNjFqkx6mJogrXJrqPMN1qjA6XGHJR?=
 =?us-ascii?Q?50YzIKa9pwwiW6vIyrnBSMh9zkUt4HPunYYtCkqUESa2lg/DgaOHBJgGbuTt?=
 =?us-ascii?Q?s/7yrLlKBtXafPTgKXqOFcsaMpx9L/hXEigssIGpLoD9EbBAshWaKYCtOXea?=
 =?us-ascii?Q?2Cug9ypGZaJfJq+FeO7LZzUEdFW5YRxYAJinCOkseiMmP8R60cVdEBa1qFhS?=
 =?us-ascii?Q?eGi5VHdyUUsFZcc29ADxUpIBZ7P8GH726SGgP25UmReUXdK7SeVD11zRaC9O?=
 =?us-ascii?Q?tSKZrLmk6RtAxHfLOyL1mx/SGRyS8Q7Afpta97KHiQd+dd61nFJwXjCT8GhM?=
 =?us-ascii?Q?tErTWgRnZdHx4gfT+hGR9yn+Y7zoT+MV6BVDkyzW/ctw8qFt1J7q5znPufQ0?=
 =?us-ascii?Q?27D1CQBOORaFKPkPp5M1dEylzZrUxYiYqOtbjWx2UVdwr1jNHGv+oVQxTbe2?=
 =?us-ascii?Q?a0OEL0uNNoYseMbNB1hr3HjrfHV2fPB67E0HDI/Lh7SW3DtvEvGTfsY26Ku1?=
 =?us-ascii?Q?0XVVM7bgqUOYDedXIIGBtuI4cLGtaxV6u2LSroTCADxEz9djTk404xFk4p0b?=
 =?us-ascii?Q?Nsfq8HWk9fkfdLEPDX0mRWSvHWB3LpDOk3afe4tlFGfbcKDzPi5xCQ7YenQr?=
 =?us-ascii?Q?mihbDjv3T+M5vZhmaC4PcklAl19m362kvpE81E+0?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b5a2f597-875e-46d5-4c52-08db92f8a322
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2023 01:34:38.9302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LaOCW27xHd0F0D/quI7PEOIl6HyniP6uh5ontrUSp3ZQlA/od4fKcuGzXhUd4WmqivUb/ZBBsW+BK9BOPtKV7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4648
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, August 1, 2023 1:50 AM
>=20
> The remaining reads are all in functions called under ops->device_group.
>=20
> Broadly these functions are walking around the device tree (eg going up
> the PCI bus tree) and are trying to de-duplicate group allocations
> according to their logic.
>=20
> Since these functions don't hold any particular per-device locks their
> reads to dev->iommu_group are being locked by the caller's
> iommu_probe_device_lock, and this explains why
> iommu_probe_device_lock
> needs to be a global lock.
>=20
> Rename iommu_probe_device_lock to dev_iommu_group_lock, make it local
> to
> the module and annotate all the device_group helpers with
> iommu_group_get_locked() that includes a lockdep to indicate that they ar=
e
> special.
>=20
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
