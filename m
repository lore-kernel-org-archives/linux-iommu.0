Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667301107
	for <iommu@lists.linux.dev>; Wed, 26 Apr 2023 08:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682498987; x=1714034987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RQaiXmdjOZXfT3BS4+ZE4P7NjcMb5RFcFv1ifujgwIs=;
  b=Q3InQRmYpK5UiY6ilAoRT+Y0jzFd9ekA7wpBk/qNg1uIhyGnEt5DF2n9
   OgE6CbZuaO3HxnDoCixgZOeskF8gkl/qzq++rq/UrGJiAuUBz6Dpafkbl
   BHqNbWhsYGgs1xF43g8Gd4E4QnAxUfn1pnJQpcRufMlL0pjNUQmZLwlQa
   Roug75AzwGq2PbRcts5m2DE3C5QEDzIoje1nuDh4W+UCL4WOfIMgt25TC
   1cHRMm7XWodzlc8cGM0Gyqycyztvqauohy9giIBNKErJvZJbEwEIIZJ1b
   tFHVqbRENwzhki44bNOLnLspRKanTvZgx6iPSMlw0j4LB5+WoYCDeRREZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="412354723"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="412354723"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2023 01:49:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="837822933"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="837822933"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 26 Apr 2023 01:49:45 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 01:49:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 01:49:44 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 26 Apr 2023 01:49:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 26 Apr 2023 01:49:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FUmytE+1PmvGDav3TMoEZ0923nWx/4HJJ7reqq17UDQD6r5dZAK291XEbEvYSbTxVZrvYP49stOo233DOmCP/P0zoR/1t0mByp0SKlc7cWhCbDWp67lf94QkS16oNKI4H4IzB+16mRFIpZ1DH2MLXz43RCSOY0r1kBSfGRUR7ghxIHtjDWt4UVL+brIAVKjA0Eo52ED3yxAnUXIc41yihAbn4sFgDQvG5ctvELE6L5pWibyU9milBOuC1eYNkzVz7nxtzOmCjq6MEnrx8irqsX1zZNIn44JzpX0uCxrPCtTP+XPoN8Lzwur8R+DH505Yp9ZgDgYAbSEG78NLXF/TiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQaiXmdjOZXfT3BS4+ZE4P7NjcMb5RFcFv1ifujgwIs=;
 b=C+XiJeBDJDrb8l0qD/qGB3uSBh5TMsqFg2ELFwRIe+J5f97sO2rtzBlO0cPz67tewcVLUcquNKApMOaeVVJa29XRDXa+TXaacQW16vw/njXcHtoIhrx2CA7tIE63N0mAU034ruHwjO51Uf3Gr4XiusIqH21m1BcRSsgWQJpd9KdAHDjDX3VILGa/2cEaBIki9vfnHD9+ZCVxOScGaLafELUHYlHzRx7gqJjojieCLlVSr2M9VNFM3ktoDN2D1kTFUZQUEQwWxvNQPjXbI7bbHNfBOQGh8e/YzMeV7KnnNz5pMLGnFfl3NGpQo+lUmxdQglga0XJmUOaklrRKXyXJBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ2PR11MB7716.namprd11.prod.outlook.com (2603:10b6:a03:4f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Wed, 26 Apr
 2023 08:49:42 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::73e9:b405:2cae:9174%6]) with mapi id 15.20.6340.020; Wed, 26 Apr 2023
 08:49:42 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
	<robin.murphy@arm.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Jean-Philippe Brucker
	<jean-philippe@linaro.org>, "Rodel, Jorg" <jroedel@suse.de>, "Zhu, Tony"
	<tony.zhu@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, Zhangfei Gao
	<zhangfei.gao@linaro.org>
Subject: RE: [PATCH for-rc] iommu/amd: Add missing domain type checks
Thread-Topic: [PATCH for-rc] iommu/amd: Add missing domain type checks
Thread-Index: AQHZd6l3p8YM0rt9C0KhhsrVc3dTFK89SKkw
Date: Wed, 26 Apr 2023 08:49:41 +0000
Message-ID: <BN9PR11MB5276DF8F4A99D757C8C3D7708C659@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-2ac37b893728+da-amd_check_types_jgg@nvidia.com>
In-Reply-To: <0-v1-2ac37b893728+da-amd_check_types_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ2PR11MB7716:EE_
x-ms-office365-filtering-correlation-id: 4e1f166a-3934-4a93-b58d-08db46332d3c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /0O3cGKO7tK3Pu7oHzzdm0hC/C4EsWMpr8Lj08WuUmkSAQYZp4MLdv/wmfbFmp0r+KUnn1ZAYCVqMq5SkZeU/sFJHo6ta/Guy7JHSb8rcUw86tEOeE6ILh1hVjrVjIL3d81bSCaRgTcRthbc/3dSRdfhJD56L3fWdN6mypFhelPdT/G/j0Hie81azWjL5y8wph5LyuiBb4qKFS49x8sk0tkz35oOhqaASQGoo0u0VdDTRa7P4uMwWAe3aTNtrtLLtko2WdCq8t5kt0czXSsJsIfsZslCpdVSdAgWIVs3choWYJCCc9lZPIKHWiiCYU8XYeXe8KERqunV2r3qWfIEfEg8SQZw/lSLLYg+9ieDySc47Oli19ohuQVtUb1joxGSOMD2q4NcXdA2+Dd5aTFL7hf3V/3UlZKvC6ptzuG/lUlI6pmZwE8DJxmmb1DMGAkwOfyhYSIEYkjmDtcomQdH0vXbTksUvimUy1TnOCrEVefCjwhRx8gwafbL6ncEXrLn66/IIz7RzWMX3A1Fzo2Wq/uHsi/LTFg/5LkmJSL9HKisIzgrUEIu0viyQwQslNwekHG9TCdX304QSOMpq7KDA6txnVjK1zWpicONl+7ZOksibHnL1JNb6Fs50Ffgc+eP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(396003)(376002)(451199021)(186003)(41300700001)(122000001)(7696005)(71200400001)(83380400001)(26005)(9686003)(6506007)(478600001)(110136005)(54906003)(7416002)(66556008)(55016003)(64756008)(316002)(76116006)(66946007)(82960400001)(66446008)(4326008)(66476007)(52536014)(5660300002)(8676002)(2906002)(86362001)(4744005)(38070700005)(38100700002)(8936002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Kza3TJMfp8mNvXppXhPIZiI6jJwKM0Ic42ch7EQ0i9InVrvCkWRg9bhk7HHm?=
 =?us-ascii?Q?4k+WOvuFrNmQQFOP7IFJ2zx4QRrwKD+0+1c2W60p6uTEyy+TJAkvDf5/GjWU?=
 =?us-ascii?Q?OyMu0GEKP7T2y4YhrIgNdxrCTO9d3RdNerjGAzZ3Pe4EbosYT0ncR9dVWOK5?=
 =?us-ascii?Q?hE4f9zoV4zwFpQc6kOsG5JscoYufipEj04E41cl+qmW14Qw256sN1RT/VT7k?=
 =?us-ascii?Q?UJyoa6Wt8rXpA9EIcLPkEhUKMEA17lwqcF9sGDFlanCLJhKHyNvm3ms/unRv?=
 =?us-ascii?Q?6+VAMT/ejJ5IYShxuavkKGFeDYGs85T1IPMpCHfPUG0zz9YmaA2mNM+pmTaV?=
 =?us-ascii?Q?9dhjNUoN2cqrakV4nYzTXhtJO0TaMv3IpUaa4rR6/1jmlcwua7bX9p5pWrzJ?=
 =?us-ascii?Q?3s1YkIeuviAXgV3lV3akHaDEsDe0V4mu+88LliMpOKUi9DNxl5gleV6TiAw8?=
 =?us-ascii?Q?v6vg8K8rD1VZngi6mlmfkYlW7/GHrKn4HDrLz9Xw9WYDET2XVJ84n/GGATiw?=
 =?us-ascii?Q?G6hScGAXEekYugqd3vIW7sAgaxDIJIQJsw0zYSIPdwcmByZFNG20HOH+ETzk?=
 =?us-ascii?Q?8ffd1iG9kvuAlJ1XVuUmiK3JGSk9zaiI6wE9SImQUA9rE/bjUKW0n/hijgXa?=
 =?us-ascii?Q?Zqs9nK7l6M75Q7XGFMIDhwxpCUiPoReqpXgTuXBZJ4B4Jjd25OZMH/qBmM50?=
 =?us-ascii?Q?cUQq/hnhXny160wgz7MaAHeoA9Tir0BJ/sgRQUNbaJXMzlOEBRga0gHM+lsn?=
 =?us-ascii?Q?URS5qkGc6oJjuieHymWAL+ek2ju4LI0QgD6LZIXXcCGPnjgSz0HCOv/cj3pG?=
 =?us-ascii?Q?U10EK+2y6Itx//2Wu46GCmMcMZhEHtAQJav1Ohfrla0WxJe6ZyWWaLvIgUi3?=
 =?us-ascii?Q?jm5WrH2TbHQIwbbsuFk8cBUx4uWA6CNCK/cJtthQ1ngrw6fHwpQHU9NlXO7s?=
 =?us-ascii?Q?nctLt4NWesb57ah2Ii9Z5CWcX/Vs0dSUv6wgsXvzP7mPNalS02JAQam6EUEp?=
 =?us-ascii?Q?NCX+T5ZrfPyXMr1OITZVfGDMAe7FTeCTiFuhL//eYfrAmsbqulQbj9va/0Gg?=
 =?us-ascii?Q?98tY7QAj5TRXS5bA+yeM8ldHFJCc564QNwl8me9h2BKmkuUuj2V1WeLBpzs5?=
 =?us-ascii?Q?eY7nptugcH+Xv/WZV+yar5g/lUX+hJyfEg08x0CiKhP1CGKHjpJtSb+IXqT2?=
 =?us-ascii?Q?u4HQlKgJo0tDBUIkxPTTm8g1DPnUhgl2htjQQDqx2t3obn/DGWMM958vGtSp?=
 =?us-ascii?Q?g7PM83LJlxNUEyCdZW4dnlrIv5IWT9fKzx9/GrzXFPZ5hT+Rh+p/3MGxszaC?=
 =?us-ascii?Q?U3OjlMHE3Fx/eUJTXHvWMvQuY1Jn6PXO6hqw2Cj4ILw2BWG8q2dBAjCsOF9x?=
 =?us-ascii?Q?YvPvPZ+E34N3RbUMIgx+96wuvy7pX94xwK1mRR4DQnygT3s0pfaDPV04z9iO?=
 =?us-ascii?Q?86ozNI8AovK8UvDA1tahZ7mDUJpINUliRMQqFajJZeGqhlOb6otMp170Cv5E?=
 =?us-ascii?Q?YxFXGsldqA4VaB/2l1cckI2fhLXlMYe0NAng1ReHXD78ZiLZEo7LvOW28fuU?=
 =?us-ascii?Q?kYR/zXEuAUGb/9XXGFfCchQaxO20TN590vFLxFQ5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1f166a-3934-4a93-b58d-08db46332d3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2023 08:49:41.8711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: enHvgl0Zd1E+kDF7JtkX5B0eAfD38uVM7MiWt1jaLWuualJ1t0foOjzFkDzqgZddS1SCriOKDlpVf+x5J5Z+Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7716
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, April 26, 2023 3:04 AM
>=20
> Drivers are supposed to list the domain types they support in their
> domain_alloc() ops so when we add new domain types, like BLOCKING or
> SVA,
> they don't start breaking.
>=20
> This ended up providing an empty UNMANAGED domain when the core code
> asked
> for a BLOCKING domain, which happens to be the fallback for drivers that
> don't support it, but this is completely wrong for SVA.
>=20
> Check for the DMA types AMD supports and reject every other kind.
>=20
> Fixes: 136467962e49 ("iommu: Add IOMMU SVA domain support")
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
