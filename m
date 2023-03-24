Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4B7E
	for <iommu@lists.linux.dev>; Fri, 24 Mar 2023 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679642304; x=1711178304;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9PMQnWeYT/po3m7Yog/lqg/L/fRbChuR+Vn0mcnH7eo=;
  b=Jix3o3GqyZIfhL4DMpGo3+MJptQc4b/rw7jLNj8PGidU/kG401rb/5BN
   BfsUbMZ7nGBR+jDOwex4UgZds3u9QlwGLXiP6muj8P3yn02lfcGS1K2IR
   Z7fOHE0d9AtqU9UkrQQB9yiobjHZY9O4VeH47Bjgoi8Ta1Hg4kXnOoFJU
   iuWQNMh5nryveYE/p0gqITK5No3mdXSiSfi4lw7LVfMTsiMEOsw4c9Kcx
   lifPsVw/xEYqq9KuNzwqHZxQ5etPq23Lct29pqUDYyyOHObrjvTB8yIBN
   rPe4RThQcn7SEq6X7/NIjaJ3wqdz1LBHxcX4byMM6TU/Fe0x8cZ4n2U9H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="337221865"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="337221865"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 00:18:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="715116922"
X-IronPort-AV: E=Sophos;i="5.98,287,1673942400"; 
   d="scan'208";a="715116922"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 24 Mar 2023 00:18:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 24 Mar 2023 00:18:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 24 Mar 2023 00:18:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 24 Mar 2023 00:18:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UWhEJBgu8loJvYW6pwgaxjUwg1IBTO02IVuQ1rcaD+cJhW5s0gyqToiLwf72LccAxSQ79dfrOamvI4tUkzDaFjECyM6MlauRYk8hH098h79sX7M5DickjjyCEekL2nghwKkYfyVtfwkSovUoA6kC2ZtUttlKahzKlV/rP9dq9pVqR3UMg9kntRCpA766DXMoOHGSsvZWKxJHk9FWWyd7swb+PsZuEyuz0uIbrFpjeNYtDrjNPf2NvezjIn+fZCyMUW/v95R3jgPTBZZB6SoWdQrppxVtCGRJLrjSyKzxZ/iQyQKNxsZ7FzrzibvdOaCxQ1Ootk1o1dpbLFZMIyviZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9PMQnWeYT/po3m7Yog/lqg/L/fRbChuR+Vn0mcnH7eo=;
 b=jhM7uL3E4Q9WCf8cfmi6Py2YuIkO+XdelysfDvgh0Z1y/Ycg2QAFj93XTD2JHBDdiPNx39RhgK9bxoLcqB0VG1g473aSWJCcWYKKljCeEw4ER/klDcv66zn2TNLTfqpGNA0J7pHIJ1HE0ffxQ/EqHVrF85zpNV/FPwAqAoM2kPBLVl4w5P1SiClLoW9A9ZjWkt8AiOsK6bEgyHFldY+Nj9O5/TByfToKO7i4pMwWyyflFNc+b92DOHhe89sxJcJyTnA/9+1J64RDePBX6SgrUW7ZsfZAuIZJvhYzcRsDnntDrIFljykcs0D2sSdrUiSaIpdQwXX1poJ3cyP1R236jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY8PR11MB6817.namprd11.prod.outlook.com (2603:10b6:930:63::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 07:18:19 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::1aac:b695:f7c5:bcac%8]) with mapi id 15.20.6178.039; Fri, 24 Mar 2023
 07:18:19 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>, Robin Murphy
	<robin.murphy@arm.com>, Will Deacon <will@kernel.org>
CC: Lu Baolu <baolu.lu@linux.intel.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH 2/9] iommu: Use __iommu_group_set_domain() for
 __iommu_attach_group()
Thread-Topic: [PATCH 2/9] iommu: Use __iommu_group_set_domain() for
 __iommu_attach_group()
Thread-Index: AQHZXC7W6oEbywHm70yRn9GK0pRE668JiSrA
Date: Fri, 24 Mar 2023 07:18:19 +0000
Message-ID: <BN9PR11MB527624B00D3B1A3CC32E5EF88C849@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <0-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
 <2-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
In-Reply-To: <2-v1-20507a7e6b7e+2d6-iommu_err_unwind_jgg@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|CY8PR11MB6817:EE_
x-ms-office365-filtering-correlation-id: 3d875e0b-efe6-42fc-8665-08db2c37f19c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vuI4NOeIk9qXeNlu1lr4JBUmtIDxXDCxtdb6bWBFb85L8D9qxzJiZo7zu39EuKfN3cgmSlEy8eY8MoBLu760cPwZz1kjReNQWEPe7SE3I5aUnKeZk9vswVOJSm0fC0HEt6BF2ADWcBBmHzY/Oku9VXkYfMa12dArwNo8c17keeNIQSOZ6U5IzCMTxT7EwkQGj3ArliQn1KFrlFOtRJFXFd6Ly9psdCAHoGcrD9siqF6FpOv8xgWcerp/QHmdJKtyFK8lMrW6tmWzlzfXsSh+zBskfXM5UJgoK+cwSP20dDDv4fvgJFGETleE5UZyO5HPjW2wFZme6D0oUWqu38q4lgMDMEJKAqYIGuDmwzMR0NtkR6s8cowJujmIcMGbHKb2LcH0oTekGGDB+gn/HzWMCBEn7NmHsjttxOCnhoW3jD6VCDDS8WNQQ+bnWif/znA4NFBElc7fYnVk2VrAC6vkwAHEFGbjVJpYUdA2mUDyC3lwczkFJgLCrKNnl4s+kuLrKhHUgb5iQKqLyWC2H4XThA7OH7FfiSh8mVXBCiyKCv8hhVPXaMppYWFloCELwPwcJyM5XyR3JnyykVNLfIR2TZlxjwSGP9MVC6Ptu/X7G9OQaabjQWuBKmJmpCGNcMFxOEChcLxjsa3ZVAze6r9HN2fbgFD2V3rpdLXKbNM0ElCZCGoGqL9kBYFssxHR2ART0nJq9APHcpfmanLn4nB3/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199018)(82960400001)(558084003)(8676002)(38070700005)(33656002)(86362001)(122000001)(71200400001)(7696005)(38100700002)(52536014)(5660300002)(64756008)(66556008)(4326008)(2906002)(66476007)(66446008)(41300700001)(55016003)(8936002)(186003)(9686003)(66946007)(6506007)(54906003)(316002)(478600001)(110136005)(76116006)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sv3UVviGeCYwDtpjMaLMhZ+TnI9znWKbofTWwufjF4eeXRZwuACENYSGieYt?=
 =?us-ascii?Q?uuPSWKSzRuamj9we+9EHXXPSalT46FMlUv+XAUbFFbZheyccICpL+KXLOCi9?=
 =?us-ascii?Q?O66RL7wHChrM9RXVUaWjQdT4jngchLF7rYgxImqDw/1+q2M2qYja8GL5CtOt?=
 =?us-ascii?Q?/mJDccQzVOfbwOAlb/v6ejbPnSPYi7pf6k/dGDCIh90WPzPKH1ddt6/h7MUm?=
 =?us-ascii?Q?BebrzQCQa0vdBkkU6kBeIh6CJqWOX5MOOIaEmvfg4vM5yAvyKgdP/fnyEBdT?=
 =?us-ascii?Q?XD8Ah+WO64LBbrnG+ajlewBnuXGR0DJ5n2eLJSsUIEOrF66DU7cTbKB1Drwe?=
 =?us-ascii?Q?OUiQxQlPfzEa2IARXEqYgcqImpk0w8nC82kj6Kwd6s1TmsiMvzlogY+6P1C/?=
 =?us-ascii?Q?qqE/TbazIK3Wz2fvMaR6G0jO5yjoHjeg8nlOamJ8Fk8Vj/eju/NkcCzRa105?=
 =?us-ascii?Q?lIaRRl5Y2J51wBtGb0FHUmRWnaFHduNKhPf2f6HEsWm/10wjAHWFHCiYi5kf?=
 =?us-ascii?Q?f6pMu2vJWz7L3t518RO+hR+pTkMHBrRwgguWJ5MHWNk9aUjT++wPXxKWHtbN?=
 =?us-ascii?Q?lRnOY0tvqoIISo1sAoH1t7Weq92ofhy6I0J4/FEg0Iy2Fggma4q/uZfVLFOX?=
 =?us-ascii?Q?k7OdoLIQzS3oLyM0x4paLIy/yUDEVF7PNBzr+r7NJ0wTrmJh1K1K/D++sSuo?=
 =?us-ascii?Q?9J4KuHppghdRJcqEGsRasxXm1gWFudi5iX1d7p7ehkhBWu8F3a7vdCtfFt30?=
 =?us-ascii?Q?97f/6N6abbqEOXOnaGhKvIlkQy7qsKzmowW2qL+Uai09n0RB7REP901lSYui?=
 =?us-ascii?Q?1h0oKG1EBWJ1VJHSBb4kBhFtM+4gX0S03H96DJ9gCgcEJEFFIfwMkh5oVetW?=
 =?us-ascii?Q?ca7tqsDgwPTQzwu/BY0+4dg4IxLUKNBNHTLpkSjc8PExrxY+7lkK7eHiVNve?=
 =?us-ascii?Q?p/3roeKEkcrriyjLpTaRgYbDQjzGaR27WqtQwO6IOxIhp9s8FoQD344oO9T1?=
 =?us-ascii?Q?P8TlpgVJq395n2TEqEoYlq6BWi+5VGm64TkCiejajPOR0PqJItMt+jUvVjAh?=
 =?us-ascii?Q?CX1sdKd0jNSpFR+QGGocWQA6yh6qZpBrhVzNlKfXVWEeK47Zbdytgtm+T5Go?=
 =?us-ascii?Q?rf59F6d5cgFRcvVr2cphiwc0KsiropJB/ykhw24H0MTonvo4/YIg16+VNefc?=
 =?us-ascii?Q?2nMAi8DK9msGuYPBhfCYxH0prA7oZ5xA4B2b5aq9BeAH8s2FVge+kSybvQww?=
 =?us-ascii?Q?3cDvIQu4QjkbWqJ21xMtyg3eIDZ8XawlOoIG00Eiqof/e2pG7Lv5PVggbBtV?=
 =?us-ascii?Q?elX/7ZJAiRJO2Kv1MuuRO5tTohWmSuO/su6EK5MEARefc5xXTcClm2JcU0Xw?=
 =?us-ascii?Q?jLpNAa4PEzzQEextYdNa7PM2T1mvpccBB3Kup6uqzjODBJO/nR/2frpyPGHZ?=
 =?us-ascii?Q?Wavpy1V0K29wVNbud1D9B5k5plsbwaiNUdTgTmmuHn7JlFXUdGb+jtm6EpOU?=
 =?us-ascii?Q?rqKL91/fqAEOj23s4ZXLfifCWOr3blrCkdayFpQDfOEhi6ZfcHqwRjHZcoky?=
 =?us-ascii?Q?LxoUeF+T573nwn3wVmxQW+0yut6Onn9LcP9wBBsq?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d875e0b-efe6-42fc-8665-08db2c37f19c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2023 07:18:19.0811
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LBBY/RJCRdHD1w1GQw2KwGd6B4t/ty32G1s7VdjhbY0/+o2efnblXUpHbhyb5CZYEsovWiLUi+91VKz7zGj06A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6817
X-OriginatorOrg: intel.com

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Wednesday, March 22, 2023 3:53 AM
>=20
> The error recovery here matches the recovery inside
> __iommu_group_set_domain(), so just use it directly.
>=20
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
