Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D7715AD
	for <iommu@lists.linux.dev>; Wed, 15 Feb 2023 01:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676425194; x=1707961194;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=u1z2QpPf7rT1n4CUl7Zb4XBeHEHZiGQSHF6LMb5509c=;
  b=nDHZks1ouhBT9kJdxWUi0kaHBI74DkW86sRRdtRHsRMMWWBKJnYKw9Cz
   sPMlXV14l6jv/4pUwAzM3U4h7hqbCAKeeYkBGuncZNPW+OSa5reaYunfH
   zLUJB+lIWrCBK3V6uEpuw/v5ckwvuxRrHfjsVahFrH8pGM2MU5Pi8wQVe
   IUcbyqX13vbadBqf+9I4ylIJj+d3JlI8j5pn2AKo+w+EVaHwj4ZmJXHK5
   xxtCblmFf+fpHWe8UhCbzWuGxGLLZrwT0YH35oCcPgrW3qClJOB/dArNW
   cDm5ROsZ5iBhHFxeFvi9nXMFPUj+KC1YLvqMiNjmZeGDU0DC8lp2/sZmM
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="329036050"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="329036050"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 17:39:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="843381347"
X-IronPort-AV: E=Sophos;i="5.97,298,1669104000"; 
   d="scan'208";a="843381347"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 14 Feb 2023 17:39:53 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 14 Feb 2023 17:39:52 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 14 Feb 2023 17:39:52 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 14 Feb 2023 17:39:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAoBrFk9eaoJaT+RM5Qt0CDKMaYWRwt05kz1b0fT+Da/cBVVKWpx7GCkC0WOVIEBY8iP3xkU9HkLrJsm84ZuvBV7ldnM39SbyKOwnYQ3HkoE9s2alMrTvWVwNIPpe02DXZYwdtYUAf+gfuAyqtkYpUxaVmO91kjvwkPjYsreKM9SDlOteBBvvMc3hhmMHlChFRpxQSz0lSmEBYRv6JmMuBDbp70ccAFWMSsZzt61/hjdeT69L12h6dCWNBObU/lxakNGaxTGSHluxe4ubOTV0PnkQJr6w0ocYrRh/VURAzqPIXhnOXr+0Wv2c/2ogtr/qBhtmu3386R0XwQOxsfbgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u1z2QpPf7rT1n4CUl7Zb4XBeHEHZiGQSHF6LMb5509c=;
 b=NFtMRYytz5dhiXV3d/duzqTtXOYsqtXep7Lk9MY0UCRf1Ux1hkILskyOhB64cSyz30/0cCjYtKambcf4OUlavrDPEQ/rOmdTzKpMb0uCDYAdQAR1bZz185C3ZpEzv2ZbpfyCGfkxcY0viL9EWVF3aZhoLC+jnkdIEEKUoRj0wKas465IkVBwVB+1oTBHYa9+eOK/mdkIXevFbp3KJZR5nuP/4ElmJRzgQwkcnVYe+ihNwm5eTCzV/0r9cw5JA4Djjw/2XSPnDFGulmdIkQecv6EEeksG+7Af9AUQuXv2kQ0L8rDcrQiR7VVKILfikVN7uiTz0AZBZQJ1bCI15VHk+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5868.namprd11.prod.outlook.com (2603:10b6:a03:42b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 01:39:45 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6a8d:b95:e1b5:d79d%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 01:39:45 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "Yang, Lixiao"
	<lixiao.yang@intel.com>, Matthew Rosato <mjrosato@linux.ibm.com>, "Nicolin
 Chen" <nicolinc@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>
Subject: RE: [PATCH 1/4] iommufd: Do not add the same hwpt to the
 ioas->hwpt_list twice
Thread-Topic: [PATCH 1/4] iommufd: Do not add the same hwpt to the
 ioas->hwpt_list twice
Thread-Index: AQHZP9Vw1cvK73P82kuHZI3iF7tx767N7kHAgACgOwCAAK5+8A==
Date: Wed, 15 Feb 2023 01:39:45 +0000
Message-ID: <BN9PR11MB5276DCC932A5CA3CEAE740CD8CA39@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
 <1-v1-4336b5cb2fe4+1d7-iommufd_hwpt_jgg@nvidia.com>
 <BN9PR11MB527654AA7B3BE05FCD7A12108CA29@BN9PR11MB5276.namprd11.prod.outlook.com>
 <Y+ulaEHbx/uHqx8B@nvidia.com>
In-Reply-To: <Y+ulaEHbx/uHqx8B@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SJ0PR11MB5868:EE_
x-ms-office365-filtering-correlation-id: b99cabf0-358f-43c2-31f8-08db0ef58459
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: szQ241cLb5tcpaqmswTFL6M5CF/tmyJE5EiH6JCgNGqLM2lkgPK0giLB3ZpV2fX3D8FDHrN7tRfzrQHVvZxz1EC9LYIllWvNSzGFxodmHaOlSVZhncEptz0x/9kDahBfkOcx4HrfSpNw4h/BvWFq53fRkIxP2a1IxI/JWDQQpyGUbGh1MnZuxjODAqWeKOKNv2fyzbKf3wkr69p4f0sxJTZcYYBUI0HcWJRW+uI9lTO7w+USvL6Fz7gy+GDJ05cydBKymhW7yvyuwW8FwduGthToX7lpR5rpuPC0MVLR6xeCAv/wkcaqt9p3EoWbfEC3A4ncUGCvQCwle7ZTTEMJCZBdvPDEonxAZsXkxKxhodDRpA3LMZdLg1saAvWDE9Z5mIm0dE9AIWb2R0PUyPcK7HJfUv3zag1NEK8FMZbyNIYtpTdh9GbTLHZd//GMNcCVqo86rYARXrolhzDDUyiXgM2ZXNScsW/a7pAgeuX+ooi5JECQVgOhqBSv6vkG20pXRkTcEELNQNx71GUFlZ8bwSNp2ACefotJ7qF8PPCijZDOFAttvaWUgBxGGkAsGRBRNNaGIRgdsnDL/ZkRscwWrXpUewS+HVrT4QwSTu+DZZBAr/GaDC5NDjL9Jwe+/6DvuJ+roN8CmCZrNccVsB2b8SXLTc3YzFmWg2SkTVwuOE+EA965v9Fxzpqkn4sQwKRPlh+yomtB8RzyEBpKmLiXow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(136003)(396003)(346002)(376002)(451199018)(71200400001)(66446008)(7696005)(316002)(86362001)(54906003)(26005)(186003)(6916009)(4326008)(478600001)(76116006)(66476007)(66946007)(66556008)(8676002)(64756008)(9686003)(5660300002)(6506007)(107886003)(55016003)(41300700001)(8936002)(52536014)(83380400001)(33656002)(38070700005)(2906002)(38100700002)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DAyrxu4wW0aPM1jANvgzudVnfuQaxwwx8CRS87Cr8ZSbeDjZEYf3m7SZLEJ9?=
 =?us-ascii?Q?eNy7bOKlnMr/B9oxCMg0q97nOdy+oFhgCQZmUChwNjEf0lgVj0NpFGnbbbbQ?=
 =?us-ascii?Q?jP9fwxU+h3lQnt9OFZ3uqyCE66WcNUyyiyIKQ40wy3dWdoxx8f2g+XjquKBL?=
 =?us-ascii?Q?yIMdwSbSYwMX5y7mQ7hQH9gfL6r5896pIrXQmqqAAfwLICLdmCcMpZdocDUq?=
 =?us-ascii?Q?kfselopc1AG8w9GFozgaBPPV7SNQ312I4TWoWDG4Uw3uxlzX4Bg3m5+BKesS?=
 =?us-ascii?Q?5XXPn2ZD8R2yBAt8tPV3Gh193Y+bMZY8jyTKgYPmm900OQoxeBlNezXIei4T?=
 =?us-ascii?Q?PQp9k6taCZ1wBWh4uMaIRK+HJzS5HGrW7Fv4yZswZeAOR/I3qWAvDyrtbxID?=
 =?us-ascii?Q?3oNkySIz6IIMNbHnMB0kxZEtQSkO85uyiMoYrMhC6qdBTlPJCOfobNYlsayK?=
 =?us-ascii?Q?9DwqL7HDnKIc/x1BSRck2q8yfIB8e1naEjnN6fy7XNeejhAjIf6yVg6LnaPX?=
 =?us-ascii?Q?fDuynr1g2aERjCck8g8qaPbDyw/0AK5ErHd9ACwcSjOtFXJpAtj4Pkrhn/LG?=
 =?us-ascii?Q?Vo/xVqez/pk8JiEXbQM3pFRzqR80xOOSRXIMkGO7uyPsXTZORvK692t5x457?=
 =?us-ascii?Q?mogy3pAGnE6ZIibYDM7H17DjeI6onaY43rDuHA6qSwT6WFxcatST1hy5okj6?=
 =?us-ascii?Q?seulM+z/v49mKipJtj9quKdXDIhh3/LCJUW2xjPRGBd+jfgqr6HCCsPTDlGy?=
 =?us-ascii?Q?iJ3gljwTjHpMqylHSbQA7u51oy3GQlNqABVAwrj0uTmgNyg/raF/1EDFJbky?=
 =?us-ascii?Q?IX1dUwyl9ylVrpJPYPJlYQkBFwqHnoC3pRzl4BOWwmpPpaC1WQAR4/e6eIV5?=
 =?us-ascii?Q?+rPEmUmEklp1YfMVq5w1UhmdUndC9QcURR+MT02RrkTFZ2b5MIxBTHqf1AXF?=
 =?us-ascii?Q?09oStUood2vmfFXdVO3GzWTxPH7h43G0Ig3mBDfCz+ZmMKbjwfWgKb/S3j44?=
 =?us-ascii?Q?1cBx+1ZPf5seZWtVK3xBnQ4cR0DeIaLfo1PrFEWgySg25vHnpDf5/Ug1wPv9?=
 =?us-ascii?Q?hizhQLs4gFwH+rZy32bb3Edc3TxUn1ESbpBW25J8L/qDsKOnwKWtBtfin0Qy?=
 =?us-ascii?Q?7BmpXgBq2AIDX5FEOSbVM+coxW2v1tvpfCgfkgMzNctchpIJGv2ikXy0iElG?=
 =?us-ascii?Q?ORRVKQavAesxhwFVIczed27QSPaP7q17DPIeV4+NG7sOjKDMgPx2oxDeOP/1?=
 =?us-ascii?Q?3xytrf/jMHbEMdLbHyk20smlECUPIgQWs2M83pKK0w5GmLmTvIJyQBDm1kQN?=
 =?us-ascii?Q?9kYIdjCjHZhCQGRKXIQNRa0m2/1k/Xw4PtCf94nIWrIYcP0TWXiHpA/BIBN4?=
 =?us-ascii?Q?1xMAVmPeRBSZrJQ9Gl2PEp406y42UZdGVVEKhn1VIPJh6o+9kORB8UxVuWzx?=
 =?us-ascii?Q?ixNCpJ/XfIU2rtD/ZNBAx7XwIBBb3KihVtcdoOOT5wGca+RElRJPYErRyQRM?=
 =?us-ascii?Q?4mE+DqmktkELI1cTmUYohKcGLwjw7KR8Y/C3M1lmu+QraWGJrluTSryb1xEG?=
 =?us-ascii?Q?4nabAWitUWHBPvHzzQddfME1GHxdosnb+fdVfvjJ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b99cabf0-358f-43c2-31f8-08db0ef58459
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2023 01:39:45.2802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNVFrF7phnj6x8md0eBPoanzhqUWLP3mB/dd1C/Vm7WQKfKkmE6ho92p8Li6faSlBhlYWtP3yCO280MqpCzzWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5868
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Tuesday, February 14, 2023 11:15 PM
>=20
> On Tue, Feb 14, 2023 at 05:51:13AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, February 14, 2023 2:03 AM
> > >
> > > The hwpt is added to the hwpt_list only during its creation, it is ne=
ver
> > > added again. This hunk is some missed leftover from rework. Adding it
> > > twice will corrupt the linked list in some cases.
> > >
> > > It effects HWPT specific attachment, which is something the test suit=
e
> > > cannot cover until we can create a legitimate struct device with a
> > > non-system iommu "driver" (ie we need the bus removed from the
> iommu
> > > code)
> > >
> > > Cc: stable@vger.kernel.org
> > > Fixes: e8d57210035b ("iommufd: Add kAPI toward external drivers for
> > > physical devices")
> > > Reported-by: Kevin Tian <kevin.tian@intel.com>
> > > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> >
> > for stable kernels this kind of fixes an issue in a dead code path
> > where no uAPI for user to manually create hwpt or return the
> > hwpt id of auto domain to userspace.
> >
> > from that angle do we still want a fix tag?
>=20
> I always put fixes tags, no matter how minor.
>=20
> The cc stable is the thoughtful one.
>=20
> In this case though there is no way to formall access this API the
> HWPT ID does exist and a hostile userspace can guess it to trigger a
> kernel bug. So it should be fixed.
>=20

this is fair. So,

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
