Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3E3629
	for <iommu@lists.linux.dev>; Thu,  8 Dec 2022 06:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670479648; x=1702015648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/jhZaQc5zBB7VWlq9U8xqHEnNtAmc5BoT9WBfowxrbk=;
  b=KRQ77xDjoVU5TcTA1pJg/D9MRfRrk511xohVmMW+66VyV/LfuJuPC7UE
   uOIv8NUbAvmmIP48qEBvZreqXEEpgHu8Q9vvDy1P4699qXasHgT3Av6Ya
   tTc3tIT1OfmHzW7G+QbJB2YEUjDN6FEoeUYdCtUyr/7tpX71eo7Ra4nqg
   XJbVG6i2s9odmu5MY+n/VaRmq7Mmj+dsY3XfFe+XO9GMkR9LAiJHDJyyL
   2yxn/aUusMPgo+qnVTPrKeVHV3EoWg8cmw1o1deiTebDFBFnwWfwb/kr0
   IQJGG9/sCFuxgy6hVs/2DTiO8aDRtAdXecowBRo6dLtKEv98FPTfP/5b3
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="344127693"
X-IronPort-AV: E=Sophos;i="5.96,227,1665471600"; 
   d="scan'208";a="344127693"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2022 22:06:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10554"; a="753419322"
X-IronPort-AV: E=Sophos;i="5.96,226,1665471600"; 
   d="scan'208";a="753419322"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 07 Dec 2022 22:06:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 22:06:36 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 7 Dec 2022 22:06:35 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 7 Dec 2022 22:06:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 7 Dec 2022 22:06:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LEaBuwtQ6RYRN4qfpD7QjAP+iIt8YFIKtcqrJ5CwzPkxCksEDK3H8mh9d/GuJIh+XLkNn6+Qak9iFam85gSzK76TGfq2qUyFUVXmqvpA/E+fHLTABwpVbW1WeA2ZYnopzZnBPXubnGWe10w1NONkm681AbQ1ddLyQjZy71nJbu3jmYXBJ+LaFtFVsqOvBfmeXUNZCWtnYYd8V5i8708QyQjaC80DRz9IAkwJZK1YZKbfxXO4RIc0gfY9hWkNokQrtJiXU42XkIAWJf7p1H6FQH52snB2bOD/VWFRoavoFOdmetyF4VaxLFi52KGWn+7jgnVULnP85U8blB8UFXoQ9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jhZaQc5zBB7VWlq9U8xqHEnNtAmc5BoT9WBfowxrbk=;
 b=DDW6MfayHYGgvyA8gzOMDP9oqbpKXf2K6cJyOKvfb2p+nYFy5uRGe75wPX1nRwXi8Gie97Iakfp6sMkFjedVXj3lRcEGBWPPGmJ67j02a3mPMuk+3ZbLP1iTTJEmsP7FlzoAnbBoXKoV89wJXuNKna1SFXF7SoD+R6yrZh6Dn7zL+6xrLu11ECUeNkiWfLmRVV9CN0enCT5R4zjzC1SkOHBvZvvyeBiyVHeQK5sRYpWWqh9dR6CS1VyBleydj9gkuHQDtK8UqKosRyUM+8Ck2F8JRqXTNuzi5u/rIHUgupL8UT8niJ3g0aiHdy0hTUV5r45n06n0aDsxBVo+dv6DKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5271.namprd11.prod.outlook.com (2603:10b6:208:31a::21)
 by SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Thu, 8 Dec
 2022 06:06:33 +0000
Received: from BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::1db7:97b6:a988:9a9c]) by BL1PR11MB5271.namprd11.prod.outlook.com
 ([fe80::1db7:97b6:a988:9a9c%5]) with mapi id 15.20.5880.014; Thu, 8 Dec 2022
 06:06:33 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: Binbin Wu <binbin.wu@linux.intel.com>, Eric Auger <eric.auger@redhat.com>,
	"Yang, Lixiao" <lixiao.yang@intel.com>, Matthew Rosato
	<mjrosato@linux.ibm.com>, Nicolin Chen <nicolinc@nvidia.com>, "Liu, Yi L"
	<yi.l.liu@intel.com>
Subject: RE: [PATCH 3/3] iommufd: Change the order of MSI setup
Thread-Topic: [PATCH 3/3] iommufd: Change the order of MSI setup
Thread-Index: AQHZCnzJxV44gI473UuM7lbtgzr/2a5jgLXg
Date: Thu, 8 Dec 2022 06:06:33 +0000
Message-ID: <BL1PR11MB5271B670EDF3977798E931178C1D9@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <0-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
 <3-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
In-Reply-To: <3-v1-0362a1a1c034+98-iommufd_fixes1_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5271:EE_|SJ1PR11MB6201:EE_
x-ms-office365-filtering-correlation-id: 6ce3b329-5288-41b4-250d-08dad8e25b6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VEnnvuRSpyHLQiy1MJjy1fvqtuGOc/savYnimQtwxcnUK3N8PkYYeEzGeQBE0rcV/rg/WdHI4Fbf3ZMLBuHVDKMlyMl7ouQRHB0dzSTtn09wTvi7wMikBkIExiOFnRoN+KtLDZi5/7sEn2bFE+dsf/2BvoXYgyOhVOCArYSmW18/FRY+7d97AybkVhHkNfb1E02QGj4QGUGUZ5q9F7H4jEnp2+K0gXbBosm8dlvcsi1BNfdjQMSgdkvQkbDjxwCrD+Rb0Jkf2BxIY3tpavP8dsT9dIjV9WRoC3lqbtaPYJhsgY5WHswaKRC7Y1166H8BruI17ur98xszLjxsp/LbW7SgWzvAdfvexiyBtOb70eFocw7LTDPBCYkYVTlI/VW7R3mCGjrYA6RHgJCrGA+kqcjX7dNVUeXmEbn+dEhNhUz+YyM6EiU692+n7ERhx0XhfBfa8uB5JCd5t8vR9EUgkwnIfOTRLjBzzPyQAPJHN7sFmFBb+M4BXJW5PZIrmkdhbIHhxlEzk3ILJUvOUmgDJvmYeg0XxF6pQbA0u7EW1cDENEeX9egtmGAnvAXbzNQxpmAN4gzJfv1pSJ8rCUGDSyEnN6QaYtO1axYRGyEeVQajOJIJA96AVOWGwtZm42gwVv5b+rst+dYmbvZdn0d3ZWpvTB4l+6+BldJRPXQn/mqI+27teSBb1xrz5jQ8DoOojfKm0Bl6xWlJupYvrtw89g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5271.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(366004)(346002)(396003)(39860400002)(136003)(376002)(451199015)(86362001)(9686003)(76116006)(33656002)(64756008)(66446008)(66556008)(41300700001)(8676002)(52536014)(4326008)(66476007)(66946007)(2906002)(5660300002)(8936002)(4744005)(38070700005)(122000001)(82960400001)(110136005)(316002)(38100700002)(83380400001)(54906003)(55016003)(186003)(71200400001)(26005)(478600001)(6506007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?slsBJj6e26PqjJ2Aha5wSGcYE6PA7PHQUg4vtr5k9f83FC7+twoaaKxtzSqF?=
 =?us-ascii?Q?8ABSjFaVzc/hEcKjfB7EPT5uoz3qRtJ+mKPXE+bKIVkDeUaK6oHSxOn/1Ehl?=
 =?us-ascii?Q?89K+tqG2pkSxsDgnha/Oa4BVJq6KazIJ5TILjSxSZHwyZvZNusuEpz4kTzYP?=
 =?us-ascii?Q?mUbfCPWK6XxcztV7sspBVAtP5W46BY/wfhS+qlmh/7ftXTnZoG5Fbn2zk5Jc?=
 =?us-ascii?Q?RfY4s2SRpg6I7cp33gYWSIXjowl0R0xkoQWUjNO/odbNMCZ6+qG4quSEGebq?=
 =?us-ascii?Q?0WrWep8yeEmpQIf7QQbl+oA5iUrtBK4JXCn3dFtvg/VgwuoH5G11ZPg191Np?=
 =?us-ascii?Q?NYsnMCGBqQP7HrMOaV/4MtDPKhZQzUuSEpqGW9B0XYzGNzyrGQMlnPrChlQ6?=
 =?us-ascii?Q?BSM6T2/GFn4CrA9gsOEbeY2mR9qi20mZMhrl4m18ZQ6hueaPOMsJPGaMczX8?=
 =?us-ascii?Q?RA/K8o8jfiowkM41tfs51H7oUuV6ZFepuCK5RteYi8g4XA3cK3E8BmTEtLLX?=
 =?us-ascii?Q?vdVMgQE2pMzfGCAa059sO75CaV0kZLko50izobi8L0p7EirVhh8lCLorEoBg?=
 =?us-ascii?Q?YXb8vTFbK0cC4G8h9MGaroFk859Il01TxLYtE40MFlE7PHOsd8mFebSjraBX?=
 =?us-ascii?Q?1SSBB0wEuAAyeY88uN+y/ebLCAvG9DCOgcRUrJqjv6ZU7Dn2hHuId+f3WeGz?=
 =?us-ascii?Q?zg5kqJjsDCNwgsy7sl51vjQvT4QmHbWJ2el2zKaaBc1RfmSJj8bgcTcG/xVa?=
 =?us-ascii?Q?IP00sULkGjLYaDNSuy7BZr8Mujmx5KDveBhuOSByUb0QrmIretYbMC6bpofy?=
 =?us-ascii?Q?1aIfb9SzvoUiWqcm/7/X3EoJ0JbwFD3yveB3HHJzihpIpWfBDOZ5y5g0VfJR?=
 =?us-ascii?Q?oQQJxEFWnI1v7R6RE6wOTd1NrvmPhOmRbqHwqOBesK8rn1R6eyL5AQp3JBBR?=
 =?us-ascii?Q?fS0cPdW3FJh48D1TzZZ9TLnvtkapjn6SLb+2X6pv0r3uzJ1ZGWmY83wcU1sm?=
 =?us-ascii?Q?KvE6wGwNo6jW0+8nESYRk63eHdogibsauFfMDbVPtgndJjUjfYBxeO/6ZOOC?=
 =?us-ascii?Q?RMZ3ghynFiuUuKco3mkbq2bVyzpvTCGyaExCjFL5ZtR3o8j/PNDr56mTblPO?=
 =?us-ascii?Q?fEAs/N+SqNkdRl9haWA9q8MbKIUkMsRlgy/9YylfJhD7EhdWmuCuK6g5wOMQ?=
 =?us-ascii?Q?KJxVSElxqT/dMc8L6PM4DRaQlUgyGgk3RoGf/uahpHFEpx3wlEXCuqSwU4eM?=
 =?us-ascii?Q?oWGGXNwwWU4QHX9/xcmwDDOWgZIbA8LOLsdHJWQ0zNCV7Zn8E9t6JCGcKgPq?=
 =?us-ascii?Q?1WUAc6O1QP0lnG1KUwfN3GU9YPCF5WIpRvEtThpJ2tX93bz3FLVtedsrNSM7?=
 =?us-ascii?Q?CM3XruOUD7dW3JA/wC4jGEFbHgHePhzoKpTpvOyngss6mxbVlsVAAHioRUnX?=
 =?us-ascii?Q?itNI1B8IuSm8rvU7rmhpbdRnrm9/dXErZr2eFdZ2pP6HXs/CMfk5/JGW5QKw?=
 =?us-ascii?Q?JtGYon3KgFp7E5LdaL3jZHA6jx2Hen3c+Avdi/HNzH+YvagPMDDwmL8RxeCV?=
 =?us-ascii?Q?d2l7mZ/ZW23d9FgVsG5OzgUm4uPZD1M8JcD1K5MU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5271.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ce3b329-5288-41b4-250d-08dad8e25b6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2022 06:06:33.4343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TmlhDMsxdhx/X6bAa0axiTqvsG6dSqxZqxlHHNT/ty/wk2fpyF0/QGnTFOYuGYSk0ZY/j6vxDG8bSyx8ne/Dlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6201
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, December 8, 2022 4:45 AM
>=20
> Eric points out this is wrong for the rare case of someone using
> allow_unsafe_interrupts on ARM. We always have to setup the MSI window
> in
> the domain if the iommu driver asks for it.
>=20
> Move the iommu_get_msi_cookie() setup to the top of the function and
> always do it, regardless of the security mode. Add checks to
> iommufd_device_setup_msi() to ensure the driver is not doing something
> incomprehensible. No current driver will set both a HW and SW MSI window.

"and have more than one SW MSI window".

Should we also change vfio with same sanity check?=20

>=20
> Fixes: e8d57210035b ("iommufd: Add kAPI toward external drivers for
> physical devices")
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
